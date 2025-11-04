-- AI配额管理系统SQL脚本
-- 用于跟踪用户AI使用情况和配额

-- 用户配额记录表（可选，如果要持久化配额）
CREATE TABLE IF NOT EXISTS `tb_user_quota` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `user_id` BIGINT NOT NULL COMMENT '用户ID',
    `total_quota` INT NOT NULL DEFAULT 10000 COMMENT '总配额（Token数量）',
    `used_quota` INT NOT NULL DEFAULT 0 COMMENT '已使用配额',
    `remaining_quota` INT NOT NULL DEFAULT 10000 COMMENT '剩余配额',
    `reset_date` DATE NOT NULL COMMENT '配额重置日期',
    `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_user_id_date` (`user_id`, `reset_date`),
    KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户AI配额表';

-- 用户使用历史表
CREATE TABLE IF NOT EXISTS `tb_ai_usage_history` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `user_id` BIGINT NOT NULL COMMENT '用户ID',
    `conversation_id` BIGINT NULL COMMENT '对话ID',
    `tokens_used` INT NOT NULL COMMENT '使用的Token数量',
    `usage_type` VARCHAR(50) NOT NULL COMMENT '使用类型：chat/stream/agent',
    `request_content` TEXT NULL COMMENT '请求内容',
    `response_content` TEXT NULL COMMENT '响应内容',
    `response_time_ms` BIGINT NULL COMMENT '响应时间（毫秒）',
    `is_success` TINYINT NOT NULL DEFAULT 1 COMMENT '是否成功：1-成功，0-失败',
    `error_message` VARCHAR(500) NULL COMMENT '错误信息',
    `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`),
    KEY `idx_user_id` (`user_id`),
    KEY `idx_conversation_id` (`conversation_id`),
    KEY `idx_create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='AI使用历史记录表';

-- 限流记录表（可选，用于统计分析）
CREATE TABLE IF NOT EXISTS `tb_rate_limit_log` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `user_id` BIGINT NOT NULL COMMENT '用户ID',
    `api_path` VARCHAR(200) NOT NULL COMMENT 'API路径',
    `limiter_name` VARCHAR(50) NOT NULL COMMENT '限流器名称',
    `is_allowed` TINYINT NOT NULL COMMENT '是否允许：1-允许，0-拒绝',
    `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`),
    KEY `idx_user_id` (`user_id`),
    KEY `idx_create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='API限流日志表';

