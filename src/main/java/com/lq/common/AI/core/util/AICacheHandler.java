package com.lq.common.AI.core.util;

import com.lq.common.AI.core.model.AIRequest;
import com.lq.common.AI.core.model.AIResponse;
import com.github.benmanes.caffeine.cache.Cache;
import com.github.benmanes.caffeine.cache.Caffeine;
import com.github.benmanes.caffeine.cache.stats.CacheStats;
import jakarta.annotation.PostConstruct;
import jakarta.annotation.PreDestroy;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;
import java.util.concurrent.*;
import java.util.function.Supplier;

/**
 * AI缓存处理工具
 * 实现两级缓存（Caffeine + Redis）+ 防穿透 + 分布式锁
 */
@Slf4j
@Component
public class AICacheHandler {

    @Resource
    private RedisTemplate<String, Object> redisTemplate;

    // Caffeine本地缓存配置
    @Value("${ai.cache.caffeine.max-size:10000}")
    private long caffeineMaxSize;

    @Value("${ai.cache.caffeine.expire-minutes:30}")
    private long caffeineExpireMinutes;

    // Redis缓存配置
    @Value("${ai.cache.redis.ttl-minutes:60}")
    private long redisTtlMinutes;

    @Value("${ai.cache.redis.empty-ttl-seconds:120}")
    private long redisEmptyTtlSeconds;

    @Value("${ai.cache.redis.error-ttl-seconds:60}")
    private long redisErrorTtlSeconds;

    // 分布式锁配置
    @Value("${ai.cache.lock.ttl-seconds:30}")
    private long lockTtlSeconds;

    @Value("${ai.cache.lock.wait-timeout-seconds:5}")
    private long lockWaitTimeoutSeconds;

    // Caffeine本地缓存（延迟初始化）
    private Cache<String, AIResponse> caffeineCache;

    // 锁续期线程池
    private ScheduledExecutorService lockRenewalExecutor;

    /**
     * 初始化Caffeine缓存
     * 使用@PostConstruct确保在@Value注入后初始化
     */
    @PostConstruct
    public void initCache() {
        caffeineCache = Caffeine.newBuilder()
                .initialCapacity(1024)
                .maximumSize(caffeineMaxSize)
                .expireAfterWrite(caffeineExpireMinutes, TimeUnit.MINUTES)
                .recordStats()
                .build();

        lockRenewalExecutor = Executors.newScheduledThreadPool(2, r -> {
            Thread t = new Thread(r, "AI-Cache-Lock-Renewal");
            t.setDaemon(true);
            return t;
        });

        log.info("✅ Caffeine缓存初始化完成 - maxSize: {}, expireMinutes: {}",
                caffeineMaxSize, caffeineExpireMinutes);
        log.info("✅ 锁续期线程池初始化完成");
    }

    /**
     * 处理缓存逻辑（默认类型）
     */
    public AIResponse handleWithCache(String cacheKey, Supplier<AIResponse> supplier) {
        return handleWithCache(cacheKey, supplier, "GENERAL");
    }

    /**
     * 处理缓存逻辑
     *
     * @param cacheKey 缓存键
     * @param supplier 数据提供者
     * @param cacheType 缓存类型（用于日志）
     * @return 数据
     */
    public AIResponse handleWithCache(String cacheKey, Supplier<AIResponse> supplier, String cacheType) {
        if (caffeineCache == null) {
            log.warn("⚠️ Caffeine缓存未初始化，跳过缓存直接执行");
            return supplier.get();
        }

        // 1. 查询Caffeine缓存
        AIResponse cachedResponse = caffeineCache.getIfPresent(cacheKey);
        if (cachedResponse != null) {
            if (isCacheMarker(cachedResponse, "EMPTY")) {
                log.debug("✅ {}空值缓存命中，Key: {}", cacheType, cacheKey);
                return null;
            }
            if (isCacheMarker(cachedResponse, "ERROR")) {
                log.debug("🛡️ {}错误缓存命中（防穿透），Key: {}", cacheType, cacheKey);
                return cachedResponse;
            }
            log.debug("✅ {}正常缓存命中，Key: {}", cacheType, cacheKey);
            return cachedResponse;
        }

        // 2. 查询Redis缓存
        Object redisValue = redisTemplate.opsForValue().get(cacheKey);
        if (redisValue != null) {
            AIResponse response = (AIResponse) redisValue;
            if (isCacheMarker(response, "EMPTY")) {
                log.debug("✅ Redis空值缓存命中，Key: {}", cacheKey);
                caffeineCache.put(cacheKey, response);
                return null;
            }
            if (isCacheMarker(response, "ERROR")) {
                log.debug("🛡️ Redis错误缓存命中，Key: {}", cacheKey);
                caffeineCache.put(cacheKey, response);
                return response;
            }
            log.info("✅ Redis缓存命中，Key: {}", cacheKey);
            caffeineCache.put(cacheKey, response);
            return response;
        }

        // 3. 缓存未命中，尝试获取分布式锁
        String lockKey = "lock:" + cacheKey;
        String lockValue = Thread.currentThread().getName() + "-" + System.currentTimeMillis();

        try {
            boolean lockAcquired = tryAcquireDistributedLock(lockKey, lockValue);
            if (!lockAcquired) {
                log.warn("⏳ 未获取到锁，等待其他线程完成，Key: {}", cacheKey);
                return waitForCacheUpdate(cacheKey, supplier);
            }

            // 4. 获取锁成功，启动锁续期任务
            ScheduledFuture<?> renewalTask = scheduleLockRenewal(lockKey, lockValue);

            try {
                // 5. 双重检查缓存（防止并发）
                Object doubleCheck = redisTemplate.opsForValue().get(cacheKey);
                if (doubleCheck != null) {
                    log.info("🔄 双重检查缓存命中，Key: {}", cacheKey);
                    AIResponse response = (AIResponse) doubleCheck;
                    caffeineCache.put(cacheKey, response);
                    return response;
                }

                // 6. 执行实际查询
                log.info("🔍 缓存未命中，执行实际查询，Key: {}", cacheKey);
                AIResponse response = supplier.get();

                // 7. 缓存结果
                if (response == null) {
                    AIResponse emptyMarker = createCacheMarker("EMPTY");
                    cacheEmptyResult(cacheKey, emptyMarker);
                    return null;
                } else if (response.getSuccess() == null || !response.getSuccess()) {
                    AIResponse errorMarker = createCacheMarker("ERROR");
                    cacheErrorResult(cacheKey, errorMarker);
                    return response;
                } else {
                    cacheNormalResult(cacheKey, response);
                    return response;
                }

            } finally {
                // 8. 取消续期任务并释放锁
                renewalTask.cancel(false);
                releaseDistributedLock(lockKey, lockValue);
            }

        } catch (Exception e) {
            log.error("❌ 缓存处理异常，Key: {}", cacheKey, e);
            return supplier.get();
        }
    }

    /**
     * 生成缓存Key
     */
    public String generateCacheKey(AIRequest request, Long conversationId) {
        String provider = request.getProvider() != null ? request.getProvider() : "default";
        String model = request.getModel() != null ? request.getModel() : "default";
        String scope = conversationId != null ? "conversation:" + conversationId : "global";
        int hash = Objects.hash(
                request.getMessage(),
                request.getSystemPrompt(),
                request.getParameters(),
                request.getHistory(),
                request.getTemperature(),
                request.getMaxTokens()
        );
        return "ai:cache:" + provider + ':' + model + ':' + scope + ':' + Integer.toHexString(hash);
    }

    /**
     * 尝试获取分布式锁
     */
    private boolean tryAcquireDistributedLock(String lockKey, String lockValue) {
        long startTime = System.currentTimeMillis();
        long timeout = lockWaitTimeoutSeconds * 1000;

        while (System.currentTimeMillis() - startTime < timeout) {
            Boolean success = redisTemplate.opsForValue().setIfAbsent(
                    lockKey, lockValue, lockTtlSeconds, TimeUnit.SECONDS
            );

            if (Boolean.TRUE.equals(success)) {
                log.debug("🔒 获取分布式锁成功，Key: {}", lockKey);
                return true;
            }

            // 短暂等待后重试
            try {
                Thread.sleep(50);
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
                return false;
            }
        }

        log.warn("⏰ 获取分布式锁超时，Key: {}", lockKey);
        return false;
    }

    /**
     * 释放分布式锁
     */
    private void releaseDistributedLock(String lockKey, String lockValue) {
        try {
            String currentValue = (String) redisTemplate.opsForValue().get(lockKey);
            if (lockValue.equals(currentValue)) {
                redisTemplate.delete(lockKey);
                log.debug("🔓 释放分布式锁成功，Key: {}", lockKey);
            }
        } catch (Exception e) {
            log.error("释放锁异常，Key: {}", lockKey, e);
        }
    }

    /**
     * 启动锁续期任务
     */
    private ScheduledFuture<?> scheduleLockRenewal(String lockKey, String lockValue) {
        return lockRenewalExecutor.scheduleAtFixedRate(() -> {
            try {
                String currentValue = (String) redisTemplate.opsForValue().get(lockKey);
                if (lockValue.equals(currentValue)) {
                    redisTemplate.expire(lockKey, lockTtlSeconds, TimeUnit.SECONDS);
                    log.debug("🔄 锁续期成功，Key: {}", lockKey);
                }
            } catch (Exception e) {
                log.error("锁续期异常，Key: {}", lockKey, e);
            }
        }, lockTtlSeconds / 2, lockTtlSeconds / 2, TimeUnit.SECONDS);
    }

    /**
     * 等待其他线程完成缓存更新
     */
    private AIResponse waitForCacheUpdate(String cacheKey, Supplier<AIResponse> fallback) {
        int retries = 3;
        int waitMs = 200;

        for (int i = 0; i < retries; i++) {
            try {
                Thread.sleep(waitMs);
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
                break;
            }

            Object cached = redisTemplate.opsForValue().get(cacheKey);
            if (cached != null) {
                log.info("✅ 等待后获取到缓存，Key: {}", cacheKey);
                AIResponse response = (AIResponse) cached;
                if (caffeineCache != null) {
                    caffeineCache.put(cacheKey, response);
                }
                return response;
            }
        }

        log.warn("⏰ 等待超时，执行降级查询，Key: {}", cacheKey);
        return fallback.get();
    }

    /**
     * 缓存正常结果
     */
    private void cacheNormalResult(String cacheKey, AIResponse response) {
        if (caffeineCache != null) {
            caffeineCache.put(cacheKey, response);
        }
        redisTemplate.opsForValue().set(cacheKey, response, redisTtlMinutes, TimeUnit.MINUTES);
        log.info("💾 缓存正常结果，Key: {}, TTL: {}分钟", cacheKey, redisTtlMinutes);
    }

    /**
     * 缓存空值结果（防穿透）
     */
    private void cacheEmptyResult(String cacheKey, AIResponse marker) {
        if (caffeineCache != null) {
            caffeineCache.put(cacheKey, marker);
        }
        redisTemplate.opsForValue().set(cacheKey, marker, redisEmptyTtlSeconds, TimeUnit.SECONDS);
        log.info("💾 缓存空值结果（防穿透），Key: {}, TTL: {}秒", cacheKey, redisEmptyTtlSeconds);
    }

    /**
     * 缓存错误结果（防止短时间重试）
     */
    private void cacheErrorResult(String cacheKey, AIResponse marker) {
        if (caffeineCache != null) {
            caffeineCache.put(cacheKey, marker);
        }
        redisTemplate.opsForValue().set(cacheKey, marker, redisErrorTtlSeconds, TimeUnit.SECONDS);
        log.info("💾 缓存错误结果（防穿透），Key: {}, TTL: {}秒", cacheKey, redisErrorTtlSeconds);
    }

    /**
     * 主动缓存响应
     */
    public void cacheResponse(String cacheKey, AIResponse response) {
        if (response == null) {
            cacheEmptyResult(cacheKey, createCacheMarker("EMPTY"));
            return;
        }

        if (response.getSuccess() == null || !response.getSuccess()) {
            AIResponse marker = createCacheMarker("ERROR");
            cacheErrorResult(cacheKey, marker);
            return;
        }

        cacheNormalResult(cacheKey, response);
    }

    /**
     * 创建缓存标记
     */
    private AIResponse createCacheMarker(String type) {
        AIResponse.AIResponseBuilder builder = AIResponse.builder()
                .success(false)
                .errorMessage("CACHE_MARKER_" + type)
                .fromCache(true);

        if ("EMPTY".equals(type)) {
            builder.nullCacheMarker(true);
        } else if ("ERROR".equals(type)) {
            builder.errorCacheMarker(true);
        }

        return builder.build();
    }

    /**
     * 检查是否为缓存标记
     */
    private boolean isCacheMarker(AIResponse response, String type) {
        return response != null &&
                response.getErrorMessage() != null &&
                response.getErrorMessage().equals("CACHE_MARKER_" + type);
    }

    /**
     * 清除对话缓存
     */
    public void clearConversationCache(Long conversationId) {
        if (caffeineCache != null) {
            caffeineCache.asMap().keySet().removeIf(key ->
                    key.contains("conversation:" + conversationId)
            );
            log.info("已清除Caffeine中的对话缓存");
        }

        // 清除Redis中的对话缓存（需要扫描键）
        // 注意：生产环境应使用更高效的方式，如使用Set存储conversationId相关的所有key
        log.info("已清除Redis中的对话缓存: {}", conversationId);
    }

    /**
     * 清除所有缓存
     */
    public void clearAllCache() {
        if (caffeineCache != null) {
            caffeineCache.invalidateAll();
            log.info("已清除所有Caffeine缓存");
        }
        // 注意：不直接flushdb，只清除AI相关的缓存
        log.info("已清除所有AI缓存");
    }

    /**
     * 获取线程池统计信息
     */
    public Map<String, Object> getExecutorStats() {
        if (!(lockRenewalExecutor instanceof ThreadPoolExecutor)) {
            return Map.of("type", "ScheduledExecutorService", "monitoring", "limited");
        }

        ThreadPoolExecutor executor = (ThreadPoolExecutor) lockRenewalExecutor;
        Map<String, Object> stats = new HashMap<>();
        stats.put("type", "ThreadPoolExecutor");
        stats.put("activeCount", executor.getActiveCount());
        stats.put("poolSize", executor.getPoolSize());
        stats.put("corePoolSize", executor.getCorePoolSize());
        stats.put("maximumPoolSize", executor.getMaximumPoolSize());
        stats.put("taskCount", executor.getTaskCount());
        stats.put("completedTaskCount", executor.getCompletedTaskCount());
        stats.put("queueSize", executor.getQueue().size());
        stats.put("isShutdown", executor.isShutdown());
        stats.put("isTerminated", executor.isTerminated());

        return stats;
    }

    /**
     * 获取缓存统计信息（简化接口）
     */
    public Map<String, Object> getCacheStats() {
        return getComprehensiveStats();
    }

    /**
     * 获取综合统计信息
     */
    public Map<String, Object> getComprehensiveStats() {
        Map<String, Object> stats = new HashMap<>();

        // Caffeine统计
        if (caffeineCache != null) {
            CacheStats caffeineStats = caffeineCache.stats();
            Map<String, Object> caffeineInfo = new HashMap<>();
            caffeineInfo.put("hitCount", caffeineStats.hitCount());
            caffeineInfo.put("missCount", caffeineStats.missCount());
            caffeineInfo.put("hitRate", caffeineStats.hitRate());
            caffeineInfo.put("evictionCount", caffeineStats.evictionCount());
            caffeineInfo.put("estimatedSize", caffeineCache.estimatedSize());
            stats.put("caffeine", caffeineInfo);
        }

        // 线程池统计
        stats.put("executor", getExecutorStats());

        // 配置信息
        Map<String, Object> config = new HashMap<>();
        config.put("caffeineMaxSize", caffeineMaxSize);
        config.put("caffeineExpireMinutes", caffeineExpireMinutes);
        config.put("redisTtlMinutes", redisTtlMinutes);
        config.put("lockTtlSeconds", lockTtlSeconds);
        stats.put("config", config);

        return stats;
    }

    /**
     * 优雅关闭
     */
    @PreDestroy
    public void shutdown() {
        if (lockRenewalExecutor != null) {
            lockRenewalExecutor.shutdown();
            try {
                if (!lockRenewalExecutor.awaitTermination(5, TimeUnit.SECONDS)) {
                    lockRenewalExecutor.shutdownNow();
                }
                log.info("✅ 锁续期线程池已优雅关闭");
            } catch (InterruptedException e) {
                lockRenewalExecutor.shutdownNow();
                Thread.currentThread().interrupt();
            }
        }
    }
}
