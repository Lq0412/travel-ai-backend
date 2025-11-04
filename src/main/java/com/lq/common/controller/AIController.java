package com.lq.common.controller;

import com.lq.common.AI.core.annotation.ApiRateLimit;
import com.lq.common.AI.core.constants.AIModelConfig;
import com.lq.common.AI.core.constants.TimeoutConfig;
import com.lq.common.AI.core.model.AIRequest;
import com.lq.common.AI.core.model.AIResponse;
import com.lq.common.AI.core.model.AgentRequest;
import com.lq.common.AI.core.model.dto.ResponseDTO;
import com.lq.common.AI.core.service.AIService;
import com.lq.common.AI.core.service.AgentService;
import com.lq.common.AI.core.service.AIMessageService;
import com.lq.common.AI.core.service.QuotaService;
import com.lq.common.AI.core.interfaces.StreamCallback;
import com.lq.common.AI.core.agent.impl.CongHuaTourismAgent;
import com.lq.common.annotation.AuthCheck;
import com.lq.common.model.entity.User;
import io.github.resilience4j.ratelimiter.RequestNotPermitted;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;
import org.springframework.http.MediaType;

import jakarta.validation.Valid;
import java.io.IOException;
import java.util.concurrent.CompletableFuture;


/**
 * AI控制器
 * 提供AI聊天和从化旅游代理流式调用接口
 */
@RestController
@RequestMapping("/ai")
@Slf4j
@Validated
public class AIController {

    @Resource
    private AIService aiService;
    
    @Resource
    private AgentService agentService;
    
    @Resource
    private AIMessageService messageService;
    
    @Resource
    private QuotaService quotaService;
    
    /**
     * AI聊天接口
     * 需要用户登录 + 限流保护 + 配额检查
     */
    @PostMapping("/chat")
    @AuthCheck(mustRole = "user")  // 需要用户登录
    @ApiRateLimit(name = "aiChat")  // 限流：10次/分钟
    public ResponseEntity<ResponseDTO<AIResponse>> chat(
            @Valid @RequestBody AIRequest request,
            HttpServletRequest httpRequest) {
        try {
            // 获取当前登录用户
            User loginUser = (User) httpRequest.getSession().getAttribute("loginUser");
            if (loginUser == null) {
                return ResponseEntity.ok(ResponseDTO.error("请先登录"));
            }
            
            // 检查用户配额
            if (!quotaService.checkQuota(loginUser.getId())) {
                Integer remaining = quotaService.getRemainingQuota(loginUser.getId());
                return ResponseEntity.ok(ResponseDTO.error(
                    "您的每日配额已用完，剩余: " + remaining + " tokens。明天0点自动恢复。"));
            }
            
            log.info("用户 {} 发起AI聊天请求: {}", loginUser.getId(), request.getMessage());
            
            // 调用AI服务
            AIResponse response = aiService.chat(request);
            
            // 扣减配额
            if (response.getSuccess() && response.getTokensUsed() != null) {
                quotaService.deductQuota(loginUser.getId(), response.getTokensUsed());
            }
            
            return ResponseEntity.ok(ResponseDTO.success("AI聊天成功", response));
            
        } catch (RequestNotPermitted e) {
            // 限流触发
            log.warn("⚠️ AI聊天接口限流触发");
            return ResponseEntity.ok(ResponseDTO.error("请求过于频繁，请1分钟后再试"));
        } catch (Exception e) {
            log.error("AI聊天失败", e);
            return ResponseEntity.ok(ResponseDTO.error("AI聊天失败: " + e.getMessage()));
        }
    }

    /**
     * 从化旅游助手流式接口
     * 需要用户登录 + 限流保护 + 配额检查
     */
    @GetMapping(value = "/tourism/stream", produces = MediaType.TEXT_EVENT_STREAM_VALUE + ";charset=UTF-8")
    @AuthCheck(mustRole = "user")  // 需要用户登录
    @ApiRateLimit(name = "aiStream")  // 限流：5次/分钟
    public SseEmitter tourismStream(
            @RequestParam String task,
            @RequestParam(required = false) String context,
            @RequestParam(required = false) String goal,
            @RequestParam(required = false) String constraints,
            @RequestParam(required = false) Long conversationId,
            HttpServletRequest httpRequest,
            HttpServletResponse response) {
        
        // 设置响应头防止乱码和缓存
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Cache-Control", "no-cache");
        response.setHeader("Connection", "keep-alive");
        response.setHeader("X-Accel-Buffering", "no"); // 禁用Nginx缓冲
        
        SseEmitter emitter = new SseEmitter(TimeoutConfig.SSE_TIMEOUT_AI_STREAM); // 5分钟超时
        
        // 获取当前登录用户（已被 @AuthCheck 拦截器验证过）
        User loginUser = (User) httpRequest.getAttribute("loginUser");
        if (loginUser == null) {
            // 如果 attribute 中没有，尝试从 session 获取
            loginUser = (User) httpRequest.getSession().getAttribute("loginUser");
        }
        if (loginUser == null) {
            try {
                emitter.send(SseEmitter.event()
                        .name("error")
                        .data("请先登录"));
                emitter.complete();
            } catch (IOException e) {
                emitter.completeWithError(e);
            }
            return emitter;
        }
        
        // 检查用户配额
        if (!quotaService.checkQuota(loginUser.getId())) {
            try {
                Integer remaining = quotaService.getRemainingQuota(loginUser.getId());
                emitter.send(SseEmitter.event()
                        .name("error")
                        .data("您的每日配额已用完，剩余: " + remaining + " tokens。明天0点自动恢复。"));
                emitter.complete();
            } catch (IOException e) {
                emitter.completeWithError(e);
            }
            return emitter;
        }
        
        // 创建 final 变量供异步任务使用
        final User finalLoginUser = loginUser;
        
        // 异步执行，避免阻塞
        CompletableFuture.runAsync(() -> {
            try {
                log.info("用户 {} 发起从化旅游代理流式请求: {}, 对话ID: {}", 
                        finalLoginUser.getId(), task, conversationId);

                if (conversationId != null) {
                    messageService.saveUserMessage(conversationId, task);
                    log.info("已保存用户消息到对话: {}", conversationId);
                }

                emitter.send(SseEmitter.event()
                        .name("start")
                        .data("🏞️ 从化旅游助手开始为您规划行程..."));

                AgentRequest agentRequest = AgentRequest.builder()
                        .task(task)
                        .context(context)
                        .goal(goal)
                        .constraints(constraints)
                        .maxSteps(AIModelConfig.MAX_STEPS_TOURISM)
                    .build();
            
                agentService.executeAgentStream("conghua-tourism", agentRequest, conversationId, new StreamCallback() {
                    private final StringBuilder full = new StringBuilder();
                    private final long startTime = System.currentTimeMillis();

                @Override
                public void onData(String data) {
                    try {
                            full.append(data);
                        emitter.send(SseEmitter.event()
                                .name("data")
                                    .data(data));
                    } catch (IOException e) {
                        log.error("发送流式数据失败", e);
                    }
                }
                
                @Override
                public void onComplete() {
                    try {
                            String finalResult = full.toString();
                            
                            // 保存AI消息并扣减配额
                            if (conversationId != null) {
                                long responseTime = System.currentTimeMillis() - startTime;
                                messageService.saveAIMessage(conversationId, full.toString(), null, responseTime);
                                log.info("已保存AI回复到对话: {}, 响应时间: {}ms", conversationId, responseTime);
                            }
                            
                            // 根据响应长度估算Token使用量并扣减配额
                            // 粗略估算：中文字符约1.5 tokens/字，英文约0.75 tokens/字
                            int estimatedTokens = (int) (full.length() * 1.5);
                            quotaService.deductQuota(finalLoginUser.getId(), estimatedTokens);
                            log.info("用户 {} 使用 {} tokens", finalLoginUser.getId(), estimatedTokens);
                            
                            emitter.send(SseEmitter.event()
                                    .name("result")
                                    .data(finalResult));
                        emitter.send(SseEmitter.event()
                                .name("complete")
                                    .data("从化旅游代理执行完成"));
                        emitter.complete();
                            log.info("从化旅游代理流式调用完成");
                    } catch (IOException e) {
                        log.error("发送完成事件失败", e);
                        emitter.completeWithError(e);
                    }
                }
                
                @Override
                public void onError(Exception error) {
                    try {
                        if (conversationId != null) {
                            String errorMessage = "AI服务错误: " + error.getMessage();
                            messageService.saveAIMessage(conversationId, errorMessage, null, 0L);
                            log.warn("已记录错误信息到对话: {}", conversationId);
                        }
                        
                        emitter.send(SseEmitter.event()
                                .name("error")
                                    .data("AI服务错误: " + error.getMessage()));
                        emitter.completeWithError(error);
                    } catch (IOException e) {
                        log.error("发送错误事件失败", e);
                        emitter.completeWithError(e);
                    }
                }
            });
            
        } catch (Exception e) {
                log.error("从化旅游代理流式调用失败", e);
                try {
                    emitter.send(SseEmitter.event()
                            .name("error")
                            .data("系统错误: " + e.getMessage()));
            emitter.completeWithError(e);
                } catch (IOException ioException) {
                    log.error("发送错误事件失败", ioException);
                    emitter.completeWithError(ioException);
                }
        }
        });
        
        return emitter;
    }
    
    /**
     * 数字人对话流式接口
     * 返回纯净文本，适合语音播报
     */
    @GetMapping(value = "/digital-human/stream", produces = MediaType.TEXT_EVENT_STREAM_VALUE + ";charset=UTF-8")
    public SseEmitter digitalHumanStream(
            @RequestParam String task,
            @RequestParam(required = false) String context,
            @RequestParam(required = false) String goal,
            @RequestParam(required = false) String constraints,
            @RequestParam(required = false) Long conversationId,
            HttpServletResponse response) {
        
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Cache-Control", "no-cache");
        response.setHeader("Connection", "keep-alive");
        response.setHeader("X-Accel-Buffering", "no");
        
        SseEmitter emitter = new SseEmitter(TimeoutConfig.SSE_TIMEOUT_AI_STREAM);
        
        CompletableFuture.runAsync(() -> {
            try {
                log.info("收到数字人对话流式请求: {}, 对话ID: {}", task, conversationId);

                if (conversationId != null) {
                    messageService.saveUserMessage(conversationId, task);
                    log.info("已保存用户消息到对话: {}", conversationId);
                }

                emitter.send(SseEmitter.event()
                        .name("start")
                        .data("数字人助手开始为您服务..."));

                com.lq.common.AI.core.interfaces.Agent agent = agentService.getAgent("conghua-tourism");
                if (agent == null || !(agent instanceof CongHuaTourismAgent)) {
                    throw new IllegalStateException("从化旅游代理不可用");
                }
                
                CongHuaTourismAgent tourismAgent = (CongHuaTourismAgent) agent;
                tourismAgent.setMessageService(messageService);
                
                AgentRequest agentRequest = AgentRequest.builder()
                        .task(task)
                        .context(context)
                        .goal(goal)
                        .constraints(constraints)
                        .maxSteps(AIModelConfig.MAX_STEPS_DIGITAL_HUMAN)
                        .build();
            
                StreamCallback agentCallback = new StreamCallback() {
                    private final StringBuilder full = new StringBuilder();
                    private final long startTime = System.currentTimeMillis();

                    @Override
                    public void onData(String data) {
                        try {
                            full.append(data);
                            emitter.send(SseEmitter.event()
                                    .name("data")
                                    .data(data));
                        } catch (IOException e) {
                            log.error("发送流式数据失败", e);
                        }
                    }
                    
                    @Override
                    public void onComplete() {
                        try {
                            String finalResult = full.toString();
                            
                            if (conversationId != null) {
                                long responseTime = System.currentTimeMillis() - startTime;
                                messageService.saveAIMessage(conversationId, finalResult, null, responseTime);
                                log.info("已保存AI回复到对话: {}, 响应时间: {}ms", conversationId, responseTime);
                            }
                            
                            emitter.send(SseEmitter.event()
                                    .name("result")
                                    .data(finalResult));
                            emitter.send(SseEmitter.event()
                                    .name("complete")
                                    .data("数字人对话完成"));
                            emitter.complete();
                            log.info("数字人对话流式调用完成");
                        } catch (IOException e) {
                            log.error("发送完成事件失败", e);
                            emitter.completeWithError(e);
                        }
                    }
                    
                    @Override
                    public void onError(Exception error) {
                        try {
                            if (conversationId != null) {
                                String errorMessage = "AI服务错误: " + error.getMessage();
                                messageService.saveAIMessage(conversationId, errorMessage, null, 0L);
                                log.warn("已记录错误信息到对话: {}", conversationId);
                            }
                            
                            emitter.send(SseEmitter.event()
                                    .name("error")
                                    .data("AI服务错误: " + error.getMessage()));
                            emitter.completeWithError(error);
                        } catch (IOException e) {
                            log.error("发送错误事件失败", e);
                            emitter.completeWithError(e);
                        }
                    }
                };
                
                if (conversationId != null) {
                    tourismAgent.executeStreamForDigitalHuman(agentRequest, conversationId, agentCallback);
                } else {
                    tourismAgent.executeStreamForDigitalHuman(agentRequest, agentCallback);
                }
                
            } catch (Exception e) {
                log.error("数字人对话流式调用失败", e);
                try {
                    emitter.send(SseEmitter.event()
                            .name("error")
                            .data("系统错误: " + e.getMessage()));
                    emitter.completeWithError(e);
                } catch (IOException ioException) {
                    log.error("发送错误事件失败", ioException);
                    emitter.completeWithError(ioException);
                }
            }
        });
        
        return emitter;
    }
}