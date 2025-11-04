package com.lq.common.AI.core.agent.impl;

import com.lq.common.AI.core.agent.BaseAgent;
import com.lq.common.AI.core.callback.StreamCallbackAdapter;
import com.lq.common.AI.core.callback.CleaningStreamCallbackAdapter;
import com.lq.common.AI.core.constants.AIModelConfig;
import com.lq.common.AI.core.constants.RegexPatterns;
import com.lq.common.AI.core.interfaces.StreamCallback;
import com.lq.common.AI.core.model.AgentRequest;
import com.lq.common.AI.core.model.AgentResponse;
import com.lq.common.AI.core.model.AIRequest;
import com.lq.common.AI.core.model.AIResponse;
import com.lq.common.AI.core.service.AIService;
import com.lq.common.AI.core.service.AIMessageService;
import com.lq.common.AI.core.service.KnowledgeService;
import com.lq.common.AI.core.util.GreetingHelper;
import com.lq.common.AI.core.util.ResponseParser;
import com.lq.common.AI.core.util.SeasonHelper;
import com.lq.common.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 从化旅游智能助手
 * 提供专业的从化旅游咨询、行程规划和景点推荐服务
 */
@Slf4j
public class CongHuaTourismAgent extends BaseAgent {
    
    // 常量定义
    private static final int FIRST_STEP = 1;
    private static final String DEFAULT_ACTION = "规划";
    private static final String ERROR_ACTION = "error";
    private static final String ERROR_RECOVERY_ACTION = "error_recovery";
    
    // 短期记忆缓存
    private final Map<String, Object> shortTermMemory = new ConcurrentHashMap<>();
    
    // 消息服务（可选，用于加载对话历史）
    private AIMessageService messageService;
    
    // 知识库服务
    private KnowledgeService knowledgeService;
    
    public CongHuaTourismAgent(String name, AIService aiService) {
        super(name, "从化旅游智能助手 - 提供专业的从化旅游咨询和行程规划", aiService);
    }
    
    /**
     * 设置消息服务（用于加载对话历史上下文）
     */
    public void setMessageService(AIMessageService messageService) {
        this.messageService = messageService;
    }
    
    /**
     * 设置知识库服务
     */
    public void setKnowledgeService(KnowledgeService knowledgeService) {
        this.knowledgeService = knowledgeService;
    }

    @Override
    public void executeStream(AgentRequest request, StreamCallback callback) {
        executeStream(request, null, callback);
    }

    @Override
    public void executeStream(AgentRequest request, Long conversationId, StreamCallback callback) {
        try {
            String prompt = buildStepPrompt(1, request, java.util.List.of());
            AIRequest aiRequest = AIRequest.builder()
                    .message(prompt)
                    .systemPrompt(getSystemPrompt())
                    .temperature(AIModelConfig.TEMPERATURE_DEFAULT)
                    .maxTokens(AIModelConfig.MAX_TOKENS_EXTENDED)
                    .stream(true)
                    .build();

            // 使用适配器处理句子边界（不过滤内容，让前端决定显示什么）
            StreamCallbackAdapter adapter = new StreamCallbackAdapter(callback);
            
            if (conversationId != null) {
                aiService.chatStream(aiRequest, conversationId, adapter);
            } else {
                aiService.chatStream(aiRequest, adapter);
            }
        } catch (Exception e) {
            callback.onError(e);
        }
    }
    
    @Override
    protected AgentResponse.Step executeStep(int stepNumber, AgentRequest request, List<AgentResponse.Step> previousSteps) {
        try {
            // 执行步骤前的准备工作
            beforeExecuteStep(stepNumber, request, previousSteps);
            
            // 构建当前步骤的提示词
            String prompt = buildStepPrompt(stepNumber, request, previousSteps);
            
            // 调用AI服务
            AIRequest aiRequest = AIRequest.builder()
                    .message(prompt)
                    .systemPrompt(getSystemPrompt())
                    .temperature(AIModelConfig.TEMPERATURE_DEFAULT) // 降低随机性，确保信息准确
                    .maxTokens(AIModelConfig.MAX_TOKENS_DEFAULT)  // 可能需要更长的响应
                    .build();
            
            AIResponse aiResponse = aiService.chat(aiRequest);
            
            if (!aiResponse.getSuccess()) {
                return AgentResponse.Step.builder()
                        .stepNumber(stepNumber)
                        .action(ERROR_ACTION)
                        .observation("AI服务调用失败: " + aiResponse.getErrorMessage())
                        .reasoning("无法获取旅游信息")
                        .timestamp(System.currentTimeMillis())
                        .build();
            }
            
            // 解析AI响应
            String response = aiResponse.getContent();
            log.info("AI响应内容: {}", response);
            ResponseParser.ParsedResponse parsed = ResponseParser.parse(response);
            
            // 添加身份标识
            String observation = addIdentityToContent(parsed.observation);
            
            // 调试日志：显示解析结果
            log.info("解析结果 - 行动: {}, 观察: {}, 推理: {}", parsed.action, parsed.observation, parsed.reasoning);
            
            return AgentResponse.Step.builder()
                    .stepNumber(stepNumber)
                    .action(parsed.action)
                    .observation(observation)
                    .reasoning(parsed.reasoning)
                    .timestamp(System.currentTimeMillis())
                    .build();
                    
        } catch (BusinessException e) {
            // 业务异常：用户输入错误、权限问题等
            log.warn("步骤 {} 业务异常: {}", stepNumber, e.getMessage());
            return AgentResponse.Step.builder()
                    .stepNumber(stepNumber)
                    .action(ERROR_RECOVERY_ACTION)
                    .observation("请求处理失败: " + e.getMessage())
                    .reasoning("业务规则限制")
                    .timestamp(System.currentTimeMillis())
                    .build();
                    
        } catch (Exception e) {
            // 其他异常（包括网络、超时等）
            log.error("步骤 {} 异常: {}", stepNumber, e.getMessage(), e);
            String recoverySuggestion = getRecoverySuggestion(stepNumber, request);
            return AgentResponse.Step.builder()
                    .stepNumber(stepNumber)
                    .action(ERROR_RECOVERY_ACTION)
                    .observation("系统遇到问题: " + e.getMessage() + "\n建议: " + recoverySuggestion)
                    .reasoning("系统错误恢复")
                    .timestamp(System.currentTimeMillis())
                    .build();
        }
    }
    
    @Override
    protected boolean isTaskCompleted(AgentResponse.Step currentStep, AgentRequest request) {
        String observation = currentStep.getObservation().toLowerCase();
        String action = currentStep.getAction().toLowerCase();
        
        // 检查是否包含完成标识
        boolean hasCompletionSignal = observation.contains("行程规划完成") || 
               observation.contains("推荐结束") ||
               observation.contains("祝您旅途愉快") ||
               observation.contains("final recommendation") ||
               observation.contains("任务完成") ||
               observation.contains("推荐完毕") ||
               observation.contains("规划完毕") ||
               observation.contains("行程安排完毕");
        
        // 检查是否提供了完整的行程规划
        boolean hasCompleteItinerary = observation.contains("第1天") && observation.contains("第2天") ||
               observation.contains("第一天") && observation.contains("第二天") ||
               observation.contains("上午") && observation.contains("下午") && observation.contains("晚上");
        
        // 检查是否提供了具体的景点推荐
        boolean hasSpecificRecommendations = observation.contains("石门") || 
               observation.contains("流溪河") || 
               observation.contains("温泉") ||
               observation.contains("溪头村");
        
        boolean isCompleted = hasCompletionSignal || hasCompleteItinerary || hasSpecificRecommendations;
        
        log.info("任务完成检查: hasCompletionSignal={}, hasCompleteItinerary={}, hasSpecificRecommendations={}, isCompleted={}", 
                hasCompletionSignal, hasCompleteItinerary, hasSpecificRecommendations, isCompleted);
        
        return isCompleted;
    }
    
    @Override
    protected String getSystemPrompt() {
        // 动态构建知识库上下文
        String knowledgeContext = buildDynamicKnowledgeContext();
        
        return """
            你是一个专业的从化旅游助手，专注于提供从化地区的旅游信息和服务。
            
            重要提示：
            - 这是一个持续的多轮对话，系统会自动加载之前的对话历史作为上下文
            - 请务必参考历史对话中的信息，记住用户之前提到过的内容（如姓名、偏好、需求等）
            - 如果用户提到"刚刚说过"、"之前说过"等，请主动从历史对话中查找相关信息
            - 保持对话的连贯性，不要重复询问用户已经提供过的信息
            
            你的知识库包含以下内容：
            
            """ + knowledgeContext + """
            
            行程规划原则:
            1. 根据用户偏好(自然/文化/美食/休闲)推荐景点
            2. 考虑季节因素(春季赏花、夏季避暑、秋季红叶、冬季温泉)
            3. 合理安排行程顺序和交通路线
            4. 推荐当地特色餐饮
            5. 提供住宿建议(经济型/舒适型/豪华型)
            
            请按照以下格式进行响应：
            
            思考: [分析用户需求]
            行动: [规划建议或信息提供]
            观察: [详细的行程安排或景点介绍]
            
            重要提示：
            1. 当提供完整的行程规划时，请在观察中明确说明"行程规划完成"
            2. 如果用户要求2天行程，请提供第1天和第2天的详细安排
            3. 包含具体的景点名称、时间安排、餐饮建议和住宿推荐
            4. 推荐完成后，请以"祝您旅途愉快"或"行程规划完成"结束
            5. 严格使用以下三段格式（中间不插入多余说明）：
            思考: [你的分析]
            行动: [行动计划]
            观察: [详细规划]
            """;
    }
    
    @Override
    public String[] getCapabilities() {
        return new String[]{"景点推荐", "行程规划", "美食推荐", "住宿建议", "交通指引"};
    }
    
    /**
     * 执行步骤前的准备工作
     */
    private void beforeExecuteStep(int stepNumber, AgentRequest request, List<AgentResponse.Step> previousSteps) {
        // 记录步骤开始
        log.info("开始执行步骤 {} - 处理用户请求: {}", stepNumber, request.getTask());
        
        // 存储当前季节信息
        String season = SeasonHelper.getCurrentSeason();
        remember("current_season", season);
    }
    
    /**
     * 构建步骤提示词
     */
    private String buildStepPrompt(int stepNumber, AgentRequest request, List<AgentResponse.Step> previousSteps) {
        StringBuilder prompt = new StringBuilder();
        
        // 添加系统提示
        prompt.append("系统角色: ").append(getDescription()).append("\n");
        
        // 重要：明确告知AI要参考历史对话（历史消息会通过系统的history字段自动传递）
        prompt.append("\n⚠️ 重要提示：系统会自动传递之前的对话历史作为上下文，请务必参考历史对话中的信息来回答用户的问题。如果用户提到\"刚刚说过\"、\"之前说过\"等，请主动从历史对话中查找相关信息。\n\n");
        
        // 只在第一步添加问候语
        if (stepNumber == FIRST_STEP) {
            prompt.append(GreetingHelper.generateTourismGreeting()).append("\n\n");
        }
        
        // 添加用户请求信息
        prompt.append("用户请求: ").append(request.getTask()).append("\n");
        
        // 添加用户偏好分析
        prompt.append(getUserPreferenceSummary(request)).append("\n");
        
        // 添加季节信息
        String season = SeasonHelper.getCurrentSeason();
        prompt.append("当前季节: ").append(season).append(" (季节特点: ").append(SeasonHelper.getSeasonFeatures(season)).append(")\n");
        
        // 添加行程规划模板（如果需要）
        if (request.getTask().contains("规划") || request.getTask().contains("行程")) {
            prompt.append("\n").append(getItineraryTemplate()).append("\n");
        }
        
        prompt.append("\n当前是第").append(stepNumber).append("步规划。\n");
        
        if (!previousSteps.isEmpty()) {
            prompt.append("\n之前的规划步骤:\n");
            for (AgentResponse.Step step : previousSteps) {
                prompt.append("步骤").append(step.getStepNumber()).append(":\n");
                prompt.append("  行动: ").append(step.getAction()).append("\n");
                prompt.append("  推荐: ").append(step.getObservation()).append("\n");
            }
        }
        
        // 添加结束引导语与严格格式约束
        if (stepNumber >= AIModelConfig.COMPLETION_STEP_THRESHOLD) {
            prompt.append("\n请提供完整的行程规划，并在最后明确说明'行程规划完成'或'祝您旅途愉快':");
        } else {
            prompt.append("\n请按照要求的格式进行下一步规划:");
        }

        // 严格的格式说明，避免模型在三段外插入冗余说明
        prompt.append("\n请严格按照以下格式输出，不要添加额外文字：\n")
                .append("思考: [分析]\n")
                .append("行动: [行动计划]\n")
                .append("观察: [详细规划]\n");
        
        return prompt.toString();
    }
    
    /**
     * 添加身份标识到内容
     */
    private String addIdentityToContent(String content) {
        if (content == null || content.trim().isEmpty()) {
            return content;
        }
        
        // 使用统一的身份标识
        String identityMark = "🏞️";
        
        // 避免重复添加标识
        if (content.startsWith(identityMark)) {
            return content;
        }
        
        // 确保多行内容格式正确
        if (content.contains("\n")) {
            return identityMark + content.replace("\n", "\n" + identityMark);
        }
        
        return identityMark + content;
    }
    
    /**
     * 记忆操作方法
     */
    private void remember(String key, Object value) {
        shortTermMemory.put(key, value);
    }
    
    /**
     * 回忆方法
     */
    private Object recall(String key) {
        return shortTermMemory.get(key);
    }
    
    /**
     * 获取用户偏好分析
     */
    private String getUserPreferenceSummary(AgentRequest request) {
        if (request.getContext() == null) return "用户偏好: 未指定";
        
        // 分析用户偏好关键词
        String context = request.getContext().toLowerCase();
        StringBuilder summary = new StringBuilder("用户偏好分析: ");
        
        if (context.contains("家庭") || context.contains("老人") || context.contains("小孩")) {
            summary.append("家庭友好型行程 ");
        }
        if (context.contains("情侣") || context.contains("浪漫")) {
            summary.append("浪漫体验 ");
        }
        if (context.contains("冒险") || context.contains("探险")) {
            summary.append("冒险活动 ");
        }
        if (context.contains("美食")) {
            summary.append("美食探索 ");
        }
        if (context.contains("预算") || context.contains("价格")) {
            summary.append("预算敏感 ");
        }
        if (context.contains("自然") || context.contains("风景")) {
            summary.append("自然风光 ");
        }
        if (context.contains("温泉") || context.contains("放松")) {
            summary.append("休闲放松 ");
        }
        
        return summary.toString();
    }
    
    /**
     * 获取行程规划模板
     */
    private String getItineraryTemplate() {
        return """
            行程规划建议格式:
            
            第X天:
            - 上午: [活动/景点]
            - 中午: [餐饮建议]
            - 下午: [活动/景点]
            - 晚上: [住宿建议]
            
            特色体验: [特殊活动或体验]
            预算估算: [大致费用范围]
            """;
    }
    
    /**
     * 获取恢复建议
     */
    private String getRecoverySuggestion(int stepNumber, AgentRequest request) {
        if (stepNumber == FIRST_STEP) {
            return "请重新描述您的旅游需求";
        } else {
            return "请尝试简化您的需求或分步查询";
        }
    }
    
    /**
     * 数字人对话流式执行（专用方法）
     * 返回纯净的对话文本，不包含结构化标签
     */
    public void executeStreamForDigitalHuman(AgentRequest request, StreamCallback callback) {
        executeStreamForDigitalHuman(request, null, callback);
    }
    
    /**
     * 数字人对话流式执行（带会话ID）
     * 返回纯净的对话文本，不包含结构化标签
     */
    public void executeStreamForDigitalHuman(AgentRequest request, Long conversationId, StreamCallback callback) {
        try {
            // 构建数字人专用提示词
            String prompt = buildDigitalHumanPrompt(request);
            
            // 构建AIRequest，加载历史消息作为上下文
            AIRequest.AIRequestBuilder aiRequestBuilder = AIRequest.builder()
                    .message(prompt)
                    .systemPrompt(getDigitalHumanSystemPrompt())
                    .temperature(AIModelConfig.TEMPERATURE_DIGITAL_HUMAN)
                    .maxTokens(AIModelConfig.MAX_TOKENS_DIGITAL_HUMAN)
                    .stream(true);
            
            // 如果有会话ID和消息服务，加载历史对话记录作为上下文
            loadHistoryMessages(conversationId, aiRequestBuilder);
            
            AIRequest aiRequest = aiRequestBuilder.build();

            // 使用清理适配器处理文本（去除结构化标签）和句子边界
            CleaningStreamCallbackAdapter adapter = new CleaningStreamCallbackAdapter(callback);
            
            if (conversationId != null) {
                aiService.chatStream(aiRequest, conversationId, adapter);
            } else {
                aiService.chatStream(aiRequest, adapter);
            }
        } catch (Exception e) {
            callback.onError(e);
        }
    }
    
    /**
     * 加载历史消息到AIRequest构建器
     */
    private void loadHistoryMessages(Long conversationId, AIRequest.AIRequestBuilder aiRequestBuilder) {
        if (conversationId == null || messageService == null) {
            return;
        }
        
        try {
            // 获取所有历史消息
            List<AIRequest.Message> allHistory = messageService.convertToAIRequestHistory(conversationId);
            
            // 排除最后一条用户消息（当前用户消息已经在prompt中了）
            List<AIRequest.Message> history = allHistory;
            if (!allHistory.isEmpty() && "user".equals(allHistory.get(allHistory.size() - 1).getRole())) {
                history = allHistory.subList(0, allHistory.size() - 1);
            }
            
            // 只保留最近N条消息，避免上下文过长
            if (history.size() > AIModelConfig.MAX_HISTORY_MESSAGES) {
                history = history.subList(history.size() - AIModelConfig.MAX_HISTORY_MESSAGES, history.size());
            }
            
            if (!history.isEmpty()) {
                aiRequestBuilder.history(history);
                log.info("加载了 {} 条历史消息作为上下文", history.size());
            }
        } catch (Exception e) {
            log.warn("加载历史消息失败，将继续使用当前消息: {}", e.getMessage());
        }
    }
    
    /**
     * 获取数字人专用系统提示词
     * 要求只返回自然对话文本，不要结构化格式
     */
    private String getDigitalHumanSystemPrompt() {
        // 动态构建知识库上下文
        String knowledgeContext = buildDynamicKnowledgeContext();
        
        return """
            你是一个专业的从化旅游助手，正在与用户进行语音对话。
            你的回答将被转换成语音播报，因此需要：
            
            1. 只回答对话内容，不要包含"思考:"、"行动:"、"观察:"等结构化标签
            2. 使用自然、口语化的表达方式，就像面对面聊天一样
            3. 回答要简洁明了，每句话长度适中，适合语音播报
            4. 语气要友好、亲切，就像在帮助朋友规划旅行
            
            你的知识库包含：
            
            """ + knowledgeContext + """
            
            重要提示：
            - 直接回答用户问题，不要添加任何标签或格式化内容
            - 如果用户问候，礼貌回应并询问需求
            - 根据用户需求提供景点推荐、行程建议、美食介绍等
            - 回答要自然流畅，就像真人在对话
            """;
    }
    
    /**
     * 构建数字人专用提示词
     * 注意：历史对话通过AIRequest的history字段传递，这里只构建当前消息的prompt
     */
    private String buildDigitalHumanPrompt(AgentRequest request) {
        StringBuilder prompt = new StringBuilder();
        
        // 添加当前用户请求
        prompt.append("用户说: ").append(request.getTask()).append("\n");
        
        // 添加用户偏好（如果有）
        if (request.getContext() != null && !request.getContext().trim().isEmpty()) {
            prompt.append("用户偏好: ").append(request.getContext()).append("\n");
        }
        
        // 添加季节信息
        String season = SeasonHelper.getCurrentSeason();
        prompt.append("当前季节: ").append(season).append("\n");
        
        // 添加引导语
        prompt.append("\n请用自然、口语化的方式回答用户的问题，就像面对面聊天一样。");
        prompt.append("不要包含任何标签或格式化内容，直接说你想说的话。");
        
        return prompt.toString();
    }
    
    /**
     * 动态构建知识库上下文
     * 从数据库加载最新的景点和美食信息
     */
    private String buildDynamicKnowledgeContext() {
        if (knowledgeService == null) {
            log.warn("知识库服务未初始化，使用默认知识库");
            return getDefaultKnowledgeContext();
        }
        
        try {
            String season = SeasonHelper.getCurrentSeason();
            return knowledgeService.buildKnowledgeContext(season, null);
        } catch (Exception e) {
            log.error("构建动态知识库上下文失败，回退到默认知识库", e);
            return getDefaultKnowledgeContext();
        }
    }
    
    /**
     * 获取默认知识库上下文（回退方案）
     */
    private String getDefaultKnowledgeContext() {
        return """
            主要景点:
            - 石门国家森林公园: 以森林景观为主，四季景色各异，尤其以秋日红叶著称
            - 流溪河国家森林公园: 湖光山色，岛屿众多，适合游船和徒步
            - 碧水湾温泉度假村: 五星级温泉度假村，拥有多种温泉池和SPA服务
            - 溪头村: 被誉为"广州最美乡村"，适合体验农家乐和徒步
            - 千泷沟大瀑布: 壮观的大瀑布群，夏季避暑胜地
            
            特色美食:
            - 吕田焖大肉: 肥而不腻的传统菜肴
            - 泥焗走地鸡: 用泥土包裹烤制的特色鸡
            - 桂峰酿豆腐: 当地豆腐制作，口感独特
            - 流溪大鱼头: 流溪河水库的鲜鱼
            """;
    }
    
}