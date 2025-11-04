package com.lq.common.AI.core.service.impl;

import com.lq.common.AI.core.interfaces.AIProvider;
import com.lq.common.AI.core.interfaces.StreamCallback;
import com.lq.common.AI.core.model.AIRequest;
import com.lq.common.AI.core.model.AIResponse;
import com.lq.common.AI.core.model.entity.AIMessage;
import com.lq.common.AI.core.service.AIService;
import com.lq.common.AI.core.service.AIMessageService;
import com.lq.common.AI.core.util.AICacheHandler;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * AI服务实现类
 */
@Slf4j
@Service
public class AIServiceImpl implements AIService {

    @Autowired
    private List<AIProvider> providers;

    @Autowired
    private AIMessageService messageService;

    @Value("${ai.default.provider}")
    private String defaultProviderName;

    private final Map<String, AIProvider> providerMap = new ConcurrentHashMap<>();

    @Resource
    private AICacheHandler cacheHandler;

    /**
     * 初始化提供商映射
     */
    @Autowired
    public void initProviders() {
        for (AIProvider provider : providers) {
            providerMap.put(provider.getProviderName(), provider);
            log.info("注册AI提供商: {}", provider.getProviderName());
        }
    }

    @Override
    public AIResponse chat(AIRequest request) {
        log.info("🚀 调用chat(AIRequest)方法 - 无对话ID");
        // 生成缓存键
        String cacheKey = cacheHandler.generateCacheKey(request, null);
        log.info("无对话ID的缓存键: {}", cacheKey);

        return cacheHandler.handleWithCache(cacheKey, () -> {
            AIProvider provider = getProvider(defaultProviderName);
            if (provider == null) {
                return AIResponse.error("默认AI提供商不可用: " + defaultProviderName, "system");
            }
            return provider.chat(request);
        });
    }

    @Override
    public AIResponse chat(AIRequest request, Long conversationId) {
        log.info("🚀 开始处理AI聊天请求 - 消息: {}", request.getMessage());

        // 生成缓存键
        String cacheKey = cacheHandler.generateCacheKey(request, conversationId);
        log.info("🔑 生成缓存键: {}", cacheKey);

        return cacheHandler.handleWithCache(cacheKey, () -> {
            AIProvider provider = getProvider(defaultProviderName);
            if (provider == null) {
                return AIResponse.error("默认AI提供商不可用: " + defaultProviderName, "system");
            }

            // 如果有对话ID，处理历史记录
            if (conversationId != null) {
                // 先保存当前用户消息
                messageService.saveUserMessage(conversationId, request.getMessage());
                
                // 加载历史消息（排除刚保存的当前消息，因为当前消息在request.getMessage()中）
                List<AIRequest.Message> allHistory = messageService.convertToAIRequestHistory(conversationId);
                List<AIRequest.Message> history = allHistory;
                
                // 排除最后一条用户消息（当前消息），因为它已经在request.getMessage()中了
                if (!allHistory.isEmpty() && "user".equals(allHistory.get(allHistory.size() - 1).getRole())) {
                    history = allHistory.subList(0, allHistory.size() - 1);
                    log.debug("排除当前用户消息，历史消息数量: {} -> {}", allHistory.size(), history.size());
                }
                
                // 限制历史消息数量，避免上下文过长（保留最近10条消息）
                if (history.size() > 10) {
                    history = history.subList(history.size() - 10, history.size());
                    log.debug("限制历史消息数量为10条");
                }
                
                if (!history.isEmpty()) {
                    request.setHistory(history);
                    log.info("加载了 {} 条历史消息作为上下文", history.size());
                }
            }

            long startTime = System.currentTimeMillis();
            AIResponse response = provider.chat(request);
            long responseTime = System.currentTimeMillis() - startTime;

            // 保存AI回复
            if (conversationId != null && response.getSuccess()) {
                messageService.saveAIMessage(conversationId, response.getContent(),
                        response.getTokensUsed(), responseTime);
            }

            return response;
        });
    }

    @Override
    public void chatStream(AIRequest request, StreamCallback callback) {
        AIProvider provider = getProvider(defaultProviderName);
        if (provider == null) {
            callback.onError(new RuntimeException("默认AI提供商不可用: " + defaultProviderName));
            return;
        }

        provider.chatStream(request, callback);
    }

    @Override
    public void chatStream(AIRequest request, Long conversationId, StreamCallback callback) {
        AIProvider provider = getProvider(defaultProviderName);
        if (provider == null) {
            callback.onError(new RuntimeException("默认AI提供商不可用: " + defaultProviderName));
            return;
        }

        // 如果有对话ID，处理历史记录
        if (conversationId != null) {
            // 检查消息是否看起来像系统生成的prompt（Agent构建的完整prompt）
            // 如果包含系统提示词特征，说明这不是原始用户消息，不应该保存
            String messageContent = request.getMessage();
            boolean isSystemGeneratedPrompt = messageContent != null && (
                messageContent.contains("系统角色:") || 
                messageContent.contains("当前是第") || 
                messageContent.contains("请按照要求的格式") ||
                messageContent.contains("请严格按照以下格式") ||
                messageContent.length() > 200  // 系统生成的prompt通常很长
            );
            
            // 只有当消息看起来像原始用户消息时才保存
            // 因为Controller层可能已经保存过了，或者这是Agent构建的prompt
            if (!isSystemGeneratedPrompt) {
                // 检查是否已经有相同的用户消息（避免重复保存）
                List<AIMessage> recentMessages = messageService.getRecentMessages(conversationId, 1);
                boolean alreadySaved = !recentMessages.isEmpty() && 
                    recentMessages.get(0).getRole().equals("user") &&
                    recentMessages.get(0).getContent().contains(messageContent);
                
                if (!alreadySaved) {
                    messageService.saveUserMessage(conversationId, messageContent);
                    log.debug("保存用户消息: {}", messageContent.length() > 50 ? messageContent.substring(0, 50) + "..." : messageContent);
                } else {
                    log.debug("用户消息已存在，跳过保存");
                }
            } else {
                log.debug("检测到系统生成的prompt，跳过保存用户消息");
            }
            
            // 加载历史消息（排除刚保存的当前消息，因为当前消息在request.getMessage()中）
            List<AIRequest.Message> allHistory = messageService.convertToAIRequestHistory(conversationId);
            List<AIRequest.Message> history = allHistory;
            
            // 排除最后一条用户消息（当前消息），因为它已经在request.getMessage()中了
            if (!allHistory.isEmpty() && "user".equals(allHistory.get(allHistory.size() - 1).getRole())) {
                history = allHistory.subList(0, allHistory.size() - 1);
                log.debug("排除当前用户消息，历史消息数量: {} -> {}", allHistory.size(), history.size());
            }
            
            // 限制历史消息数量，避免上下文过长（保留最近10条消息）
            if (history.size() > 10) {
                history = history.subList(history.size() - 10, history.size());
                log.debug("限制历史消息数量为10条");
            }
            
            if (!history.isEmpty()) {
                request.setHistory(history);
                log.info("✅ 成功加载了 {} 条历史消息作为上下文", history.size());
                // 打印最近几条历史消息的内容（用于调试）
                log.info("📝 最近{}条历史消息预览:", Math.min(3, history.size()));
                int displayCount = Math.min(3, history.size());
                for (int i = history.size() - displayCount; i < history.size(); i++) {
                    AIRequest.Message msg = history.get(i);
                    String content = msg.getContent();
                    String preview = content.length() > 50 ? content.substring(0, 50) + "..." : content;
                    log.info("  [{}] {}", msg.getRole(), preview);
                }
            } else {
                log.warn("⚠️ 没有历史消息，这是对话的开始。如果这是连续对话，请确保使用同一个conversationId！");
            }
        }

        // 创建包装的回调，用于保存AI回复和缓存
        StreamCallback wrappedCallback = new StreamCallback() {
            private final StringBuilder contentBuilder = new StringBuilder();
            private final long startTime = System.currentTimeMillis();

            @Override
            public void onData(String data) {
                contentBuilder.append(data);
                callback.onData(data);
            }

            @Override
            public void onComplete() {
                // 缓存最终结果
                String fullResponse = contentBuilder.toString();

                // 获取模型和提供商信息
                String model = request.getModel() != null ? request.getModel() : provider.getDefaultModel();
                String providerName = request.getProvider() != null ? request.getProvider() : defaultProviderName;

                // 创建完整的响应对象
                AIResponse response = AIResponse.success(fullResponse, model, providerName);

                // 生成缓存键并缓存响应
                String cacheKey = cacheHandler.generateCacheKey(request, conversationId);
                cacheHandler.cacheResponse(cacheKey, response);

                // 保存AI回复
                if (conversationId != null) {
                    long responseTime = System.currentTimeMillis() - startTime;
                    messageService.saveAIMessage(conversationId, fullResponse,
                            null, responseTime);
                }
                callback.onComplete();
            }

            @Override
            public void onError(Exception e) {
                callback.onError(e);
            }
        };

        provider.chatStream(request, wrappedCallback);
    }

    @Override
    public AIResponse chatWithProvider(String providerName, AIRequest request) {
        log.info("🚀 开始处理AI聊天请求(指定提供商) - 提供商: {}, 消息: {}", providerName, request.getMessage());

        // 生成缓存键
        String cacheKey = cacheHandler.generateCacheKey(request, null);
        log.info("指定提供商无对话ID的缓存键: {}", cacheKey);

        return cacheHandler.handleWithCache(cacheKey, () -> {
            AIProvider provider = getProvider(providerName);
            if (provider == null) {
                return AIResponse.error("AI提供商不存在或不可用: " + providerName, "system");
            }
            return provider.chat(request);
        });
    }

    @Override
    public AIResponse chatWithProvider(String providerName, AIRequest request, Long conversationId) {
        log.info("🚀 开始处理AI聊天请求(指定提供商) - 提供商: {}, 消息: {}", providerName, request.getMessage());

        // 生成缓存键
        String cacheKey = cacheHandler.generateCacheKey(request, conversationId);
        log.info("🔑 生成缓存键: {}", cacheKey);

        return cacheHandler.handleWithCache(cacheKey, () -> {
            AIProvider provider = getProvider(providerName);
            if (provider == null) {
                return AIResponse.error("AI提供商不存在或不可用: " + providerName, "system");
            }

            // 如果有对话ID，处理历史记录
            if (conversationId != null) {
                // 先保存当前用户消息
                messageService.saveUserMessage(conversationId, request.getMessage());
                
                // 加载历史消息（排除刚保存的当前消息，因为当前消息在request.getMessage()中）
                List<AIRequest.Message> allHistory = messageService.convertToAIRequestHistory(conversationId);
                List<AIRequest.Message> history = allHistory;
                
                // 排除最后一条用户消息（当前消息），因为它已经在request.getMessage()中了
                if (!allHistory.isEmpty() && "user".equals(allHistory.get(allHistory.size() - 1).getRole())) {
                    history = allHistory.subList(0, allHistory.size() - 1);
                    log.debug("排除当前用户消息，历史消息数量: {} -> {}", allHistory.size(), history.size());
                }
                
                // 限制历史消息数量，避免上下文过长（保留最近10条消息）
                if (history.size() > 10) {
                    history = history.subList(history.size() - 10, history.size());
                    log.debug("限制历史消息数量为10条");
                }
                
                if (!history.isEmpty()) {
                    request.setHistory(history);
                    log.info("加载了 {} 条历史消息作为上下文", history.size());
                }
            }

            long startTime = System.currentTimeMillis();
            AIResponse response = provider.chat(request);
            long responseTime = System.currentTimeMillis() - startTime;

            // 保存AI回复
            if (conversationId != null && response.getSuccess()) {
                messageService.saveAIMessage(conversationId, response.getContent(),
                        response.getTokensUsed(), responseTime);
            }

            return response;
        });
    }
    @Override
    public String[] getAvailableProviders() {
        return providerMap.values().stream()
                .filter(AIProvider::isAvailable)
                .map(AIProvider::getProviderName)
                .toArray(String[]::new);
    }
    @Override
    public String getDefaultProvider() {
        return defaultProviderName;
    }
    @Override
    public void setDefaultProvider(String providerName) {
        if (providerMap.containsKey(providerName) && providerMap.get(providerName).isAvailable()) {
            this.defaultProviderName = providerName;
            log.info("设置默认AI提供商为: {}", providerName);
        } else {
            throw new IllegalArgumentException("提供商不存在或不可用: " + providerName);
        }
    }

    @Override
    public String[] getAvailableModels() {
        return providerMap.values().stream()
                .filter(AIProvider::isAvailable)
                .flatMap(provider -> {
                    try {
                        return java.util.Arrays.stream(provider.getAvailableModels());
                    } catch (Exception e) {
                        log.warn("获取提供商 {} 的模型列表失败: {}", provider.getProviderName(), e.getMessage());
                        return java.util.stream.Stream.empty();
                    }
                })
                .distinct()
                .toArray(String[]::new);
    }
    @Override
    public String[] getModelsByProvider(String providerName) {
        AIProvider provider = getProvider(providerName);
        if (provider == null) {
            throw new IllegalArgumentException("提供商不存在或不可用: " + providerName);
        }
        try {
            return provider.getAvailableModels();
        } catch (Exception e) {
            log.error("获取提供商 {} 的模型列表失败", providerName, e);
            throw new RuntimeException("获取模型列表失败: " + e.getMessage());
        }
    }
    @Override
    public String getCurrentModel() {
        AIProvider provider = getProvider(defaultProviderName);
        if (provider == null) {
            throw new RuntimeException("默认AI提供商不可用: " + defaultProviderName);
        }
        try {
            return provider.getDefaultModel();
        } catch (Exception e) {
            log.error("获取当前模型失败", e);
            throw new RuntimeException("获取当前模型失败: " + e.getMessage());
        }
    }
    @Override
    public void setDefaultModel(String modelName) {
        AIProvider provider = getProvider(defaultProviderName);
        if (provider == null) {
            throw new RuntimeException("默认AI提供商不可用: " + defaultProviderName);
        }
        // 验证模型是否可用
        try {
            String[] availableModels = provider.getAvailableModels();
            boolean modelExists = java.util.Arrays.asList(availableModels).contains(modelName);
            if (!modelExists) {
                throw new IllegalArgumentException("模型不存在或不可用: " + modelName);
            }
            // 这里可以添加设置默认模型的逻辑
            log.info("请求设置默认模型为: {} (提供商: {})", modelName, defaultProviderName);
        } catch (Exception e) {
            log.error("设置默认模型失败，模型: {}", modelName, e);
            throw new RuntimeException("设置默认模型失败: " + e.getMessage());
        }
    }

    @Override
    public Map<String, Object> getCacheStats() {
        return cacheHandler.getCacheStats();
    }

    @Override
    public void clearConversationCache(Long conversationId) {
        cacheHandler.clearConversationCache(conversationId);
    }

    /**
     * 获取提供商
     */
    private AIProvider getProvider(String providerName) {
        AIProvider provider = providerMap.get(providerName);
        if (provider != null && provider.isAvailable()) {
            return provider;
        }
        return null;
    }
}