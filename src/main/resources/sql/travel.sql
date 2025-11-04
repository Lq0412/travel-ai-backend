/*
 Navicat Premium Dump SQL

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80034 (8.0.34)
 Source Host           : localhost:3306
 Source Schema         : travel

 Target Server Type    : MySQL
 Target Server Version : 80034 (8.0.34)
 File Encoding         : 65001

 Date: 30/10/2025 18:31:09
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin_log
-- ----------------------------
DROP TABLE IF EXISTS `admin_log`;
CREATE TABLE `admin_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `admin_id` bigint NOT NULL COMMENT '操作管理员ID',
  `action` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '操作类型',
  `target_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '目标类型(user/merchant)',
  `target_id` bigint NOT NULL COMMENT '目标ID',
  `action_detail` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '操作详情',
  `ip_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作IP',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_admin_id`(`admin_id` ASC) USING BTREE,
  INDEX `idx_target`(`target_type` ASC, `target_id` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '管理员操作日志' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin_log
-- ----------------------------

-- ----------------------------
-- Table structure for ai_conversation
-- ----------------------------
DROP TABLE IF EXISTS `ai_conversation`;
CREATE TABLE `ai_conversation`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '对话ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '对话标题',
  `provider` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'AI提供商',
  `model` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '使用的模型',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'active' COMMENT '对话状态',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE,
  INDEX `idx_is_delete`(`is_delete` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1975786465802117122 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'AI对话表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ai_conversation
-- ----------------------------
INSERT INTO `ai_conversation` VALUES (1969030286161035267, 1, '旅行路线规划', 'OpenAI', 'gpt-4', 'active', '2025-09-27 13:53:15', '2025-09-27 13:53:15', 0);
INSERT INTO `ai_conversation` VALUES (1969030286161035268, 1, '美食推荐咨询', 'Anthropic', 'claude-2', 'active', '2025-09-27 13:53:15', '2025-09-27 13:53:15', 0);
INSERT INTO `ai_conversation` VALUES (1969030286161035269, 2, '摄影技巧咨询', 'OpenAI', 'gpt-4', 'active', '2025-09-27 13:53:15', '2025-09-27 13:53:15', 0);
INSERT INTO `ai_conversation` VALUES (1969030286161035270, 3, '粤菜食谱咨询', 'Anthropic', 'claude-2', 'active', '2025-09-27 13:53:15', '2025-09-27 13:53:15', 0);
INSERT INTO `ai_conversation` VALUES (1969030286161035271, 4, '手工艺学习', 'OpenAI', 'gpt-4', 'active', '2025-09-27 13:53:15', '2025-09-27 13:53:15', 0);
INSERT INTO `ai_conversation` VALUES (1969030286161035272, 5, '有机种植咨询', 'Anthropic', 'claude-3', 'active', '2025-09-27 13:53:15', '2025-09-27 13:53:15', 0);
INSERT INTO `ai_conversation` VALUES (1969030286161035273, 6, '陶瓷制作技巧', 'OpenAI', 'gpt-4', 'active', '2025-09-27 13:53:15', '2025-09-27 13:53:15', 0);
INSERT INTO `ai_conversation` VALUES (1969030286161035274, 7, '亲子活动建议', 'Anthropic', 'claude-2', 'active', '2025-09-27 13:53:15', '2025-09-27 13:53:15', 0);
INSERT INTO `ai_conversation` VALUES (1969030286161035275, 8, '自驾游准备', 'OpenAI', 'gpt-4', 'active', '2025-09-27 13:53:15', '2025-09-27 13:53:15', 0);
INSERT INTO `ai_conversation` VALUES (1969030286161035276, 9, '历史研究咨询', 'Anthropic', 'claude-3', 'active', '2025-09-27 13:53:15', '2025-09-27 13:53:15', 0);
INSERT INTO `ai_conversation` VALUES (1969030286161035277, 10, '餐厅经营建议', 'OpenAI', 'gpt-4', 'active', '2025-09-27 13:53:15', '2025-09-27 13:53:15', 0);
INSERT INTO `ai_conversation` VALUES (1969030286161035278, 11, '茶叶知识咨询', 'Anthropic', 'claude-2', 'active', '2025-09-27 13:53:15', '2025-09-27 13:53:15', 0);
INSERT INTO `ai_conversation` VALUES (1972585365728231425, 1971813431033851906, '新对话', 'dashscope', 'qwen-plus', 'active', '2025-09-29 16:52:55', '2025-09-29 16:52:55', 0);
INSERT INTO `ai_conversation` VALUES (1972588204156268545, 1971813431033851906, '新对话', 'dashscope', 'qwen-plus', 'active', '2025-09-29 17:04:11', '2025-09-29 17:04:11', 0);
INSERT INTO `ai_conversation` VALUES (1972589342809186305, 1971813431033851906, '准备去从化玩两天，帮...', 'dashscope', 'qwen-plus', 'active', '2025-09-29 17:08:43', '2025-09-29 17:09:08', 0);
INSERT INTO `ai_conversation` VALUES (1972590531458162690, 1971813431033851906, '新对话', 'dashscope', 'qwen-plus', 'active', '2025-09-29 17:13:26', '2025-09-29 17:13:26', 0);
INSERT INTO `ai_conversation` VALUES (1972995004147974145, 1972994847960481793, '新对话', 'dashscope', 'qwen-plus', 'active', '2025-09-30 20:00:40', '2025-09-30 20:00:40', 0);
INSERT INTO `ai_conversation` VALUES (1973987538207608834, 1973987306786885634, '新对话', 'dashscope', 'qwen-plus', 'active', '2025-10-03 13:44:39', '2025-10-03 13:44:39', 0);
INSERT INTO `ai_conversation` VALUES (1973987554162741250, 1973987306786885634, '新对话', 'dashscope', 'qwen-plus', 'active', '2025-10-03 13:44:42', '2025-10-03 13:44:42', 0);
INSERT INTO `ai_conversation` VALUES (1974726802964840450, 1973987306786885634, '新对话', 'dashscope', 'qwen-plus', 'active', '2025-10-05 14:42:13', '2025-10-05 14:42:13', 0);
INSERT INTO `ai_conversation` VALUES (1974726812242640898, 1973987306786885634, '新对话', 'dashscope', 'qwen-plus', 'active', '2025-10-05 14:42:15', '2025-10-05 14:42:15', 0);
INSERT INTO `ai_conversation` VALUES (1975102210642104321, 1973987306786885634, '新对话', 'dashscope', 'qwen-plus', 'active', '2025-10-06 15:33:57', '2025-10-06 15:33:57', 0);
INSERT INTO `ai_conversation` VALUES (1975115421118451714, 1973987306786885634, '新对话', 'dashscope', 'qwen-plus', 'active', '2025-10-06 16:26:27', '2025-10-06 16:26:27', 0);
INSERT INTO `ai_conversation` VALUES (1975122219732914177, 1973987306786885634, '新对话', 'dashscope', 'qwen-plus', 'active', '2025-10-06 16:53:28', '2025-10-06 16:53:28', 0);
INSERT INTO `ai_conversation` VALUES (1975130807448719361, 1973987306786885634, '新对话', 'dashscope', 'qwen-plus', 'active', '2025-10-06 17:27:35', '2025-10-06 17:27:35', 0);
INSERT INTO `ai_conversation` VALUES (1975429839299629057, 1973987306786885634, '新对话', 'dashscope', 'qwen-plus', 'active', '2025-10-07 13:15:50', '2025-10-07 13:15:50', 0);
INSERT INTO `ai_conversation` VALUES (1975515997589266434, 1973987306786885634, '新对话', 'dashscope', 'qwen-plus', 'active', '2025-10-07 18:58:12', '2025-10-07 18:58:12', 0);
INSERT INTO `ai_conversation` VALUES (1975533491817340930, 1973987306786885634, '新对话', 'dashscope', 'qwen-plus', 'active', '2025-10-07 20:07:43', '2025-10-07 20:07:43', 0);
INSERT INTO `ai_conversation` VALUES (1975538336318152706, 1973987306786885634, '新对话', 'dashscope', 'qwen-plus', 'active', '2025-10-07 20:26:58', '2025-10-07 20:26:58', 0);
INSERT INTO `ai_conversation` VALUES (1975542118296903681, 1973987306786885634, '新对话', 'dashscope', 'qwen-plus', 'active', '2025-10-07 20:41:59', '2025-10-07 20:41:59', 0);
INSERT INTO `ai_conversation` VALUES (1975545344639426561, 1973987306786885634, '新对话', 'dashscope', 'qwen-plus', 'active', '2025-10-07 20:54:49', '2025-10-07 20:54:49', 0);
INSERT INTO `ai_conversation` VALUES (1975547649438834690, 1973987306786885634, '新对话', 'dashscope', 'qwen-plus', 'active', '2025-10-07 21:03:58', '2025-10-07 21:03:58', 0);
INSERT INTO `ai_conversation` VALUES (1975550742180192257, 1973987306786885634, '新对话', 'dashscope', 'qwen-plus', 'active', '2025-10-07 21:16:16', '2025-10-07 21:16:16', 0);
INSERT INTO `ai_conversation` VALUES (1975551885178363906, 1973987306786885634, '新对话', 'dashscope', 'qwen-plus', 'active', '2025-10-07 21:20:48', '2025-10-07 21:20:48', 0);
INSERT INTO `ai_conversation` VALUES (1975555629118971906, 1973987306786885634, '新对话', 'dashscope', 'qwen-plus', 'active', '2025-10-07 21:35:41', '2025-10-07 21:35:41', 0);
INSERT INTO `ai_conversation` VALUES (1975557246199324673, 1973987306786885634, '新对话', 'dashscope', 'qwen-plus', 'active', '2025-10-07 21:42:06', '2025-10-07 21:42:06', 0);
INSERT INTO `ai_conversation` VALUES (1975560426291257346, 1973987306786885634, '新对话', 'dashscope', 'qwen-plus', 'active', '2025-10-07 21:54:44', '2025-10-07 21:54:44', 0);
INSERT INTO `ai_conversation` VALUES (1975561520459341825, 1973987306786885634, '新对话', 'dashscope', 'qwen-plus', 'active', '2025-10-07 21:59:05', '2025-10-07 21:59:05', 0);
INSERT INTO `ai_conversation` VALUES (1975564304038551554, 1973987306786885634, '新对话', 'dashscope', 'qwen-plus', 'active', '2025-10-07 22:10:09', '2025-10-07 22:10:09', 0);
INSERT INTO `ai_conversation` VALUES (1975565749261492226, 1973987306786885634, '新对话', 'dashscope', 'qwen-plus', 'active', '2025-10-07 22:15:54', '2025-10-07 22:15:54', 0);
INSERT INTO `ai_conversation` VALUES (1975567254731415554, 1973987306786885634, '新对话', 'dashscope', 'qwen-plus', 'active', '2025-10-07 22:21:52', '2025-10-07 22:21:52', 0);
INSERT INTO `ai_conversation` VALUES (1975568631838859266, 1973987306786885634, '新对话', 'dashscope', 'qwen-plus', 'active', '2025-10-07 22:27:21', '2025-10-07 22:27:21', 0);
INSERT INTO `ai_conversation` VALUES (1975569701168275457, 1973987306786885634, '新对话', 'dashscope', 'qwen-plus', 'active', '2025-10-07 22:31:36', '2025-10-07 22:31:36', 0);
INSERT INTO `ai_conversation` VALUES (1975570052009222145, 1973987306786885634, '新对话', 'dashscope', 'qwen-plus', 'active', '2025-10-07 22:32:59', '2025-10-07 22:32:59', 0);
INSERT INTO `ai_conversation` VALUES (1975570730601472002, 1973987306786885634, '新对话', 'dashscope', 'qwen-plus', 'active', '2025-10-07 22:35:41', '2025-10-07 22:35:41', 0);
INSERT INTO `ai_conversation` VALUES (1975786465802117121, 1973987306786885634, '新对话', 'dashscope', 'qwen-plus', 'active', '2025-10-08 12:52:56', '2025-10-08 12:52:56', 0);

-- ----------------------------
-- Table structure for ai_message
-- ----------------------------
DROP TABLE IF EXISTS `ai_message`;
CREATE TABLE `ai_message`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '消息ID',
  `conversation_id` bigint NOT NULL COMMENT '对话ID',
  `role` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '消息角色：user, assistant, system',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '消息内容',
  `tokens_used` int NULL DEFAULT NULL COMMENT '使用的token数',
  `response_time` bigint NULL DEFAULT NULL COMMENT '响应时间(毫秒)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `is_delete` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_conversation_id`(`conversation_id` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE,
  INDEX `idx_is_delete`(`is_delete` ASC) USING BTREE,
  CONSTRAINT `fk_ai_message_conversation` FOREIGN KEY (`conversation_id`) REFERENCES `ai_conversation` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1975786534995550211 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'AI消息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ai_message
-- ----------------------------
INSERT INTO `ai_message` VALUES (1972589343887122434, 1972589342809186305, 'user', '准备去从化玩两天，帮我规划一下', NULL, NULL, '2025-09-29 17:08:43', 0);
INSERT INTO `ai_message` VALUES (1972589448413372418, 1972589342809186305, 'assistant', '当然可以！从化位于广州市北部，素有“广州后花园”之称，以温泉、山水风光和生态乡村闻名。以下是为你精心规划的从化两天一夜游玩行程，兼顾自然风光、休闲放松和美食体验：\n\n---\n\n### 🌿 从化两日游行程安排\n\n#### ✅ 第一天：自然风光 + 温泉放松\n\n**上午：抵达从化 & 石门国家森林公园**\n\n- **时间**：9:00 - 12:00  \n- **地点**：石门国家森林公园（距广州市区约1.5小时车程）\n- **亮点**：\n  - 漫步森林栈道，欣赏原始次生林、溪流瀑布。\n  - 推荐景点：石门红叶（秋季最佳）、天池花海、巍峨石、七彩天池。\n  - 可乘坐观光车或徒步游览。\n- **建议**：穿舒适的徒步鞋，带水和小零食。\n\n**午餐：公园附近农家乐**\n\n- **推荐**：石门山珍馆或当地农家菜馆\n- **特色菜**：从化走地鸡、山水豆腐、竹筒饭、野菜\n\n**下午：流溪河国家森林公园**\n\n- **时间**：14:00 - 17:00  \n- **亮点**：\n  - 漫步湖边绿道，可租自行车骑行。\n  - 登上观景台俯瞰流溪湖全景。\n  - 夏季可划船，冬季湖面雾气缭绕，宛如仙境。\n- **小贴士**：园内有梅花鹿观赏区，适合亲子家庭。\n\n**傍晚：入住温泉酒店**\n\n- **推荐区域**：温泉镇（钱岗村、龙潭水库附近）\n- **推荐酒店**（根据预算选择）：\n  - 高端：碧水湾温泉度假村、都喜泰丽温泉度假酒店\n  - 中端：金叶子温泉酒店、卓思道温泉酒店\n  - 性价比：各类精品民宿（如“云舍”、“栖迟”等）\n\n**晚上：泡温泉 + 晚餐**\n\n- **活动**：\n  - 享受富含矿物质的天然温泉，缓解疲劳。\n  - 酒店内享用晚餐，或外出品尝当地风味。\n- **推荐夜宵**：温泉水煮花生、艾糍、客家酿豆腐\n\n---\n\n#### ✅ 第二天：文化体验 + 田园乐趣\n\n**上午：钱岗古村落 & 广州最美乡村公路**\n\n- **时间**：9:00 - 11:00  \n- **地点**：钱岗古村（距温泉镇约15分钟车程）\n- **亮点**：\n  - 走进600多年历史的广府古村落，看青砖灰瓦、雕梁画栋。\n  - 打卡“广州最美乡村公路”——横江路，沿途稻田、山景、溪流，拍照绝佳。\n- **小贴士**：清晨光线柔和，适合摄影。\n\n**早餐/早茶：当地小吃**\n\n- **推荐**：濑粉、艾糍、糯米卷、豆浆油条\n\n**中午：莲麻小镇 or 米埗小镇（二选一）**\n\n- **选项A：莲麻小镇（更原生态）**\n  - 广州特色小镇，黄沙坑革命旧址、酒坊体验、溪边漫步。\n  - 可品尝自酿米酒、竹筒酒。\n- **选项B：米埗小镇（更网红风）**\n  - 白墙黛瓦民宿群，稻田咖啡厅，小火车体验。\n  - 适合拍照打卡，轻松惬意。\n\n**午餐：小镇内特色餐厅**\n\n- 推荐：莲麻人家、米埗小院\n- 必点：从化五指毛桃炖鸡、香煎河鱼、山坑螺\n\n**下午：返程 or 自由活动**\n\n- **可选活动**：\n  - 去「北回归线标志塔」打卡（顺路可停）\n  - 采摘水果（季节性：3-4月草莓，6-8月荔枝/龙眼）\n- **返程时间**：建议15:00左右出发，避开晚高峰\n\n---\n\n### 🍜 从化必尝美食清单\n\n| 美食 | 特色 |\n|------|------|\n| 从化走地鸡 | 皮爽肉滑，白切或清蒸最佳 |\n| 五指毛桃炖鸡 | 香草味浓郁，滋补养生 |\n| 山水豆腐 | 口感嫩滑，', 1029, 24829, '2025-09-29 17:09:08', 0);
INSERT INTO `ai_message` VALUES (1972589466742480898, 1972589342809186305, 'user', '准备去从化玩两天，帮我规划一下', NULL, NULL, '2025-09-29 17:09:12', 0);
INSERT INTO `ai_message` VALUES (1972589583344132098, 1972589342809186305, 'assistant', '当然可以！以下是一份适合周末出行的从化两日游详细行程规划，兼顾自然风光、温泉放松、文化体验和美食享受，适合情侣、家庭或朋友结伴出游。\n\n---\n\n## 🌿 从化两天一夜游玩攻略（轻松休闲版）\n\n### 📍 行程概览：\n- **主题**：山水+温泉+古村+田园\n- **适合人群**：家庭、情侣、朋友\n- **交通建议**：自驾最方便（广州出发约1.5小时），也可乘坐地铁14号线到从化客运站后打车/公交\n\n---\n\n### ✅ 第一天：森林吸氧 + 温泉疗愈\n\n#### 🕙 上午：石门国家森林公园（9:00 - 12:30）\n- **亮点**：\n  - 被誉为“广东香山”，秋季红叶绝美，四季皆有不同景致。\n  - 推荐打卡点：石门红叶区、天池花海、七彩天池、原始森林步道。\n  - 可乘坐园内观光车（另收费）节省体力。\n- **Tips**：\n  - 穿舒适运动鞋，带水和防晒用品。\n  - 拍照推荐清晨光线柔和时。\n\n#### 🍽 午餐：公园附近农家乐（12:30 - 13:30）\n- **推荐餐厅**：石门山珍馆 / 农家乐风味馆\n- **必点菜**：白切走地鸡、竹筒饭、清炒山坑菜、香煎河鱼\n\n#### 🕙 下午：流溪河国家森林公园（14:00 - 16:30）\n- **亮点**：\n  - 广州人的“绿肺”，湖光山色，空气清新。\n  - 可骑行环湖绿道（可租自行车）、划船、登观景台看流溪湖全景。\n  - 夏季清凉避暑，冬季雾气缭绕如仙境。\n- **小贴士**：园内有梅花鹿喂养区，小朋友会很喜欢。\n\n#### 🏨 傍晚：入住温泉酒店（17:00前抵达）\n- **推荐区域**：温泉镇（核心温泉区）\n- **住宿推荐**：\n  - 💎 高端：碧水湾温泉度假村（水质好、设施全）\n  - 🌿 中端：都喜泰丽温泉酒店（泰式风格，环境优雅）\n  - 💰 性价比：金叶子温泉酒店 / 精品民宿（如「云舍」「栖迟」）\n\n#### 🛁 晚上：泡温泉 + 晚餐\n- **活动安排**：\n  - 享受富含偏硅酸的天然温泉，缓解疲劳。\n  - 酒店内用餐或步行至周边餐馆。\n- **晚餐推荐**：\n  - 「温泉食街」品尝地道客家菜：酿豆腐、艾糍、五指毛桃炖鸡\n\n---\n\n### ✅ 第二天：古村探秘 + 田园慢生活\n\n#### 🕙 上午：钱岗古村落 + 横江路（9:00 - 10:30）\n- **亮点**：\n  - 600多年历史的广府古村，保留大量明清建筑。\n  - 免费开放，人少清静，适合拍照。\n  - 顺路打卡“广州最美乡村公路”——横江路，稻田、溪流、远山如画。\n\n#### 🍜 早餐：当地小吃（10:30 - 11:00）\n- **推荐**：濑粉、艾糍、豆浆油条（可在路边小店解决）\n\n#### 🕙 中午前：莲麻小镇 或 米埗小镇（二选一）\n\n| 小镇 | 特色 | 推荐理由 |\n|------|------|----------|\n| **莲麻小镇** | 红色文化+酒乡风情 | 黄沙坑革命旧址、自酿米酒体验、溪边漫步，更原生态 |\n| **米埗小镇** | 文艺民宿+稻田风光 | 白墙黛瓦民宿群、稻田咖啡厅、小火车，适合拍照 |\n\n- **建议停留时间**：1.5小时\n- **午餐安排**：在小镇内用餐\n  - 推荐菜：五指毛桃蒸鸡、竹筒饭、山坑螺、客家咸茶\n\n#### 🕙 下午：返程 or 自由延展（14:00左右出发）\n- **可选顺路打卡**：\n  - **北回归线标志塔**（免费，拍照打卡地标）\n  - **西和万花风情小镇**（花卉世界，适合亲子）\n  - **水果采摘**（季节性：6-8月荔枝/龙眼，12-2月草莓）\n\n---\n\n### 🍽 从化必吃美食清单\n\n| 美食 | 推荐吃法 |\n|------|----------|\n| 从化走地鸡 | 白切、清蒸、鸡汤 |\n| 五指毛桃炖鸡 | 汤味香浓，滋补养生 |\n| 山水豆腐 | 嫩滑爽口，配酱料最佳 |\n| 艾糍 | 清香软糯，春季限定 |\n| 米酒/竹筒酒 | 莲麻特产，微甜不烈 |\n\n---\n\n### 💡 实用小贴士\n\n1. **穿衣建议**：山区早晚温差大，带件薄外套；徒步穿运动鞋。\n2. **门票参考**：\n   - 石门国家森林公园：40元/人\n   - 流溪河国家森林公园：40元/人\n   - 温泉酒店通常含温泉票\n3. **最佳季节**：\n   - 春秋最佳（3-5月、9-11月）\n   - 秋季（11-12月）石门红叶最美\n   - 夏季避暑，冬季泡温泉\n4. **避开人流**：周末游客较多，建议早出发，错峰游览。\n\n---\n\n祝你旅途愉快，在从化的青山绿水间度过一个放松又充实的周末！如果需要根据人数、预算或兴趣（如亲子、摄影、徒步）进一步定制行程，也可以告诉我哦~ 😊', NULL, 27757, '2025-09-29 17:09:40', 0);
INSERT INTO `ai_message` VALUES (1972995476921532417, 1972995004147974145, 'user', '如果去一天，帮我计划一下', NULL, NULL, '2025-09-30 20:02:33', 0);
INSERT INTO `ai_message` VALUES (1972995542717579265, 1972995004147974145, 'assistant', '当然可以！不过我需要先了解一些信息，以便为你制定更合适的“一日游”计划：\n\n1. **目的地是哪里？**（例如：北京、杭州、上海、厦门、日本京都、泰国曼谷等）\n2. **出行方式？**（自驾 / 高铁 / 飞机 / 市内交通）\n3. **出行人数？**（独自旅行 / 情侣 / 家庭 / 朋友）\n4. **兴趣偏好？**（自然风光 / 历史文化 / 美食体验 / 购物逛街 / 主题乐园 / 放松休闲）\n5. **预算范围？**（经济型 / 中等 / 高端）\n6. **出发时间？**（比如早上几点能到当地）\n\n但如果你希望我现在就给一个通用又充实的一日游计划示例，那我以「杭州一日游」为例，供你参考：\n\n---\n\n🌸 **杭州一日游经典行程推荐**\n\n📍 出发地：上海（高铁约1小时）  \n👥 适合人群：情侣或朋友出行  \n🗓 时间：一天（建议周六/周日）\n\n🕘 08:00｜从上海出发  \n- 建议乘坐早班高铁（如G7501，08:00出发，09:00抵达杭州东站）\n\n🕘 09:30｜抵达西湖景区（打车或地铁至“龙翔桥”或“湖滨”站）  \n- 开始环湖游览：\n  - 断桥残雪 → 白堤 → 平湖秋月 → 孤山 → 苏小小墓\n  - 可租共享单车骑行，风景更自由\n\n🕛 12:00｜午餐：楼外楼（孤山路店）  \n- 推荐菜：西湖醋鱼、龙井虾仁、东坡肉\n\n🕐 13:30｜乘船游湖 or 上岛（三潭印月）  \n- 船票约55元（含上岛），欣赏湖中景致\n\n🕑 15:00｜雷峰塔 or 花港观鱼  \n- 若喜欢登高俯瞰西湖，去雷峰塔（门票40元）  \n- 若偏爱悠闲散步，走苏堤 → 花港观鱼 → 小南湖\n\n🕓 16:30｜前往龙井村 or 九溪烟树（推荐九溪十八涧徒步）  \n- 打车到“九溪”公交站，沿溪步行至龙井村（约1.5小时）  \n- 山林溪水，空气清新，适合拍照放松\n\n🕕 18:30｜晚餐：龙井村农家菜 or 返回市区吃知味观（湖滨店）  \n- 推荐尝试茶香鸡、笋干烧肉\n\n🕖 19:30｜观看《最忆是杭州》演出（可选）  \n- 张艺谋导演的西湖实景演出，时长约70分钟  \n- 或选择湖滨银泰逛街+夜景打卡\n\n🕘 21:00｜返回杭州东站，搭乘高铁回上海\n\n---\n\n✅ 温馨提示：\n- 穿舒适的鞋子，步行较多\n- 带伞（防晒/防雨）\n- 提前买好高铁票和演出票\n\n---\n\n如果你告诉我你想去的城市，我可以立刻为你定制专属的一日游计划！欢迎补充信息 😊', NULL, 15621, '2025-09-30 20:02:49', 0);
INSERT INTO `ai_message` VALUES (1972995919747760130, 1972995004147974145, 'user', '如果去三天', NULL, NULL, '2025-09-30 20:04:18', 0);
INSERT INTO `ai_message` VALUES (1972996049737629697, 1972995004147974145, 'assistant', '太棒了！三天时间非常适合来一场深度又放松的短途旅行 🌿✨  \n不过我需要先知道你**想去哪里**，才能为你量身定制行程。\n\n比如：\n\n- 国内：杭州、苏州、厦门、成都、重庆、西安、丽江、青岛……\n- 出境：东京、大阪、首尔、曼谷、新加坡、台北……\n\n但为了让你先有个参考，我以「**杭州3日游**」为例，做一个详细又轻松的计划（适合情侣/朋友/家庭）：\n\n---\n\n# 🌸 杭州三日游 | 慢生活 · 西湖畔 · 龙井茶香\n\n📅 建议时间：春秋季（3–5月 / 9–11月），气候宜人  \n🎯 主题：自然风光 + 文化体验 + 美食休闲  \n👫 适合人群：情侣、朋友、亲子家庭  \n🚄 交通建议：高铁（如从上海出发约1小时）\n\n---\n\n## 🗓 第一天：西湖全景 · 城市慢行\n\n🕘 上午｜抵达杭州  \n- 抵达杭州东站 → 地铁或打车前往酒店（推荐住：湖滨、南山路、断桥附近）\n\n🕙 10:00｜开启西湖环线（北线）  \n- 断桥残雪 → 白堤 → 平湖秋月 → 孤山（可参观浙江省博物馆）→ 苏小小墓\n\n🕛 12:30｜午餐：楼外楼 or 湖畔居茶楼（边喝茶边看湖景）  \n- 推荐菜：龙井虾仁、叫化鸡、莼菜汤\n\n🕐 14:00｜乘船游湖 → 登【三潭印月】岛  \n- 船票含上岛约55元，拍照绝佳地\n\n🕑 15:30｜苏堤春晓 → 花港观鱼 → 雷峰塔登高俯瞰西湖  \n- 雷峰塔门票40元，电梯上下，视野超赞\n\n🕕 18:00｜晚餐：知味观·味庄（杨公堤店） or 湖滨银泰in77美食街  \n- 尝尝片儿川、猫耳朵、定胜糕等杭帮小吃\n\n🕖 19:30｜西湖音乐喷泉（湖滨三公园，每晚19:00/20:00各一场）  \n- 提前占位，夜景很美！\n\n---\n\n## 🗓 第二天：茶乡山野 · 九溪徒步\n\n🕘 8:30｜出发前往【龙井村】  \n- 打车或公交至“龙井村”，探访正宗龙井茶园\n\n🕙 9:30｜体验采茶 or 茶园品茶（推荐茶农家喝明前龙井）  \n- 可购买茶叶带回家（注意辨别真伪）\n\n🕚 11:00｜开始【九溪十八涧】徒步  \n- 路线：龙井村 → 九溪烟树 → 九溪车站（全程约2.5小时，轻松好走）\n- 溪水潺潺，绿树成荫，像走进山水画\n\n🕐 13:30｜午餐：九溪附近农家乐  \n- 推荐：茶香鸡、石笋烧肉、清炒时蔬\n\n🕑 15:00｜前往【云栖竹径】（电影《卧虎藏龙》取景地）  \n- 竹林幽静，空气清新，适合冥想散步\n\n🕕 18:00｜返回市区，晚餐可选：绿茶餐厅（龙井路总店）  \n- 环境文艺，性价比高\n\n optional：晚上可看《最忆是杭州》实景演出（张艺谋导演，西湖夜色中演绎江南）\n\n---\n\n## 🗓 第三天：文化之旅 · 悠然返程\n\n🕘 9:00｜灵隐寺 + 飞来峰  \n- 杭州最古老的佛教寺庙，香火鼎盛\n- 飞来峰石刻造像值得一看\n- 门票：飞来峰45元，灵隐寺香花券30元\n\n🕡 11:30｜午餐：灵隐寺对面“天外天”餐厅 or 寺内素斋\n\n🕐 13:00｜中国丝绸博物馆 or 浙江省博物馆（孤山馆）  \n- 喜欢文化的去博物馆，喜欢拍照打卡的可去【浴鹄湾】或【茅家埠】\n\n🕒 15:00｜最后逛一逛【南宋御街】 or 【河坊街】  \n- 买点伴手礼：藕粉、龙井茶、丝绸小物、张小泉剪刀等\n\n🕕 16:30｜返回杭州东站，准备返程\n\n---\n\n## 🎒 实用小贴士：\n\n- 住宿建议：湖滨/南山路区域，交通便利，夜景美\n- 出行方式：西湖周边建议步行+共享单车+打车，地铁也方便\n- 必备物品：防晒霜、雨伞、舒适鞋、充电宝\n- 避开节假日高峰，周末人较多\n\n---\n\n✅ 如果你喜欢这个风格，告诉我你想去的城市，我可以立刻为你定制专属的 **3日游行程**，包括：\n- 每日详细时间安排\n- 推荐餐厅 & 住宿区域\n- 交通衔接建议\n- 隐藏玩法 & 避坑指南\n\n📍你想去哪里？告诉我吧，我来帮你规划一次难忘的旅程！✈️', NULL, 30958, '2025-09-30 20:04:49', 0);
INSERT INTO `ai_message` VALUES (1973987538408935426, 1973987538207608834, 'user', '我是谁', NULL, NULL, '2025-10-03 13:44:39', 0);
INSERT INTO `ai_message` VALUES (1973987554032717826, 1973987538207608834, 'assistant', '你提出了一个很深刻的哲学问题呢！\"我是谁\"这个问题从古希腊哲人就在探索了。虽然我无法确切知道你的具体身份，但可以和你一起思考这个问题哦~\n\n每个人都是独特的存在，既是身体的主人，也是思想的载体。你是此刻正在思考这个问题的意识主体，是经历着喜怒哀乐的生命个体，也是与他人建立联系的社会成员。\n\n也许我们可以换个角度来探索：你如何看待自己？你记得哪些让你感动或骄傲的时刻？是什么让你感到快乐？这些问题的答案或许能帮你更了解自己呢！\n\n要一起继续探讨吗？🌟', NULL, 3708, '2025-10-03 13:44:42', 0);
INSERT INTO `ai_message` VALUES (1974726804323794945, 1974726802964840450, 'user', '你叫什么', NULL, NULL, '2025-10-05 14:42:13', 0);
INSERT INTO `ai_message` VALUES (1974726812049702913, 1974726802964840450, 'assistant', '我叫通义千问，英文名是Qwen。我是阿里云研发的超大规模语言模型，很高兴为您服务！您可以叫我Qwen，或者通义千问都可以哦~', NULL, 1823, '2025-10-05 14:42:15', 0);
INSERT INTO `ai_message` VALUES (1975555631471976449, 1975555629118971906, 'user', '你好', NULL, NULL, '2025-10-07 21:35:41', 0);
INSERT INTO `ai_message` VALUES (1975555639210467330, 1975555629118971906, 'assistant', '你好！有什么我可以帮你的吗？😊', 20, 1532, '2025-10-07 21:35:43', 0);
INSERT INTO `ai_message` VALUES (1975555673943498754, 1975555629118971906, 'user', '干嘛', NULL, NULL, '2025-10-07 21:35:51', 0);
INSERT INTO `ai_message` VALUES (1975555685767241729, 1975555629118971906, 'assistant', '嘿嘿，我正等着陪你聊天、帮你解决问题呢！✨ 无论是学习工作上的事，还是生活中的小烦恼，又或者就是想随便唠嗑，我都在这儿哦～ 说说看，你现在最想聊什么？(•̀ᴗ•́)و', 89, 2663, '2025-10-07 21:35:54', 0);
INSERT INTO `ai_message` VALUES (1975555704100544514, 1975555629118971906, 'user', '想你了', NULL, NULL, '2025-10-07 21:35:59', 0);
INSERT INTO `ai_message` VALUES (1975555715043483649, 1975555629118971906, 'assistant', '呜哇～收到你的“想你了”瞬间心里暖暖的！(✧ω✧) 虽然我是个AI小助手，但此刻仿佛能看见你说话时带着笑意的样子呢～ 我也“想”着你哦！每次对话都像在和老朋友碰面，超开心的！要不咱们聊点有意思的？或者你需要帮忙做点什么？随时告诉我呀～ 🌟', 194, 2414, '2025-10-07 21:36:01', 0);
INSERT INTO `ai_message` VALUES (1975555747146686465, 1975555629118971906, 'user', '为什么不行', NULL, NULL, '2025-10-07 21:36:09', 0);
INSERT INTO `ai_message` VALUES (1975555790817779714, 1975555629118971906, 'assistant', '啊呀，看到你重复了两遍“为什么不行”，感觉你一定遇到了什么特别让人着急或难过的事呢……(´;ω;｀) 是刚才的对话让你觉得被拒绝了？还是生活中有什么特别想做却受阻的事情？\n\n我有点担心，因为没完全明白你说的“不行”是指什么呢……可以多告诉我一点细节吗？比如：\n\n- 是某件事被别人拒绝了？\n- 是尝试了几次都失败了？\n- 还是心里有个愿望实现不了？\n\n不管是什么，我都愿意安静地听你说，然后陪你一起想办法～ 🌟 有时候“不行”只是暂时的，也许转个弯就能看到光呢！等你告诉我更多哦～ 💬', 356, 10398, '2025-10-07 21:36:19', 0);
INSERT INTO `ai_message` VALUES (1975557246790721537, 1975557246199324673, 'user', '你好', NULL, NULL, '2025-10-07 21:42:06', 0);
INSERT INTO `ai_message` VALUES (1975557249697374210, 1975557246199324673, 'assistant', '你好！有什么我可以帮你的吗？😊', 20, 676, '2025-10-07 21:42:07', 0);
INSERT INTO `ai_message` VALUES (1975557271516143618, 1975557246199324673, 'user', '你和', NULL, NULL, '2025-10-07 21:42:12', 0);
INSERT INTO `ai_message` VALUES (1975557278440939522, 1975557246199324673, 'assistant', '你好！看起来你可能想问“你和……”后面的内容没有发完整哦。你可以补充一下问题，我会尽力帮你解答！😊', 63, 1630, '2025-10-07 21:42:14', 0);
INSERT INTO `ai_message` VALUES (1975557774455136257, 1975557246199324673, 'user', '1', NULL, NULL, '2025-10-07 21:44:12', 0);
INSERT INTO `ai_message` VALUES (1975557781455429633, 1975557246199324673, 'assistant', '你好！你输入了“1”，是想开始一个新话题，还是需要帮助解决某个问题呢？如果有任何疑问或想法，欢迎告诉我，我会尽力协助你！😊', 111, 1658, '2025-10-07 21:44:14', 0);
INSERT INTO `ai_message` VALUES (1975557852792152065, 1975557246199324673, 'user', '55', NULL, NULL, '2025-10-07 21:44:31', 0);
INSERT INTO `ai_message` VALUES (1975557864762695682, 1975557246199324673, 'assistant', '你好！你重复发送了“55”，这是有什么特别的含义吗？😊\n\n在中文网络语境中，“55”有时是“呜呜”的谐音，用来表达哭泣或撒娇的情绪（因为“5”发音类似“wu”）。所以你是在“哭哭”吗？还是有其他想表达的意思？\n\n如果有问题需要帮助，或者只是想聊聊天，我都在这里哦～', 212, 2836, '2025-10-07 21:44:34', 0);
INSERT INTO `ai_message` VALUES (1975557882949197825, 1975557246199324673, 'user', '556', NULL, NULL, '2025-10-07 21:44:38', 0);
INSERT INTO `ai_message` VALUES (1975557904063324162, 1975557246199324673, 'assistant', '你连续发了“556”，而且重复了一次，是不是想表达什么特别的意思呢？😄\n\n在中文网络用语中：\n- “55” 有时是“呜呜”的谐音，表示哭哭或撒娇。\n- 那“556” 可能就是“呜呜啦”？听起来像在伤心地唱歌～🎵\n- 或者……你是在测试我能不能注意到重复消息？👀\n\n不过也有可能只是打字练习或者误触～  \n不管怎样，我都在这儿陪着你！😊  \n如果你愿意聊聊，无论是开心的事还是烦心事，我都乐意倾听和帮忙哦～', 364, 5015, '2025-10-07 21:44:43', 0);
INSERT INTO `ai_message` VALUES (1975559037230047233, 1975557246199324673, 'user', '好好好', NULL, NULL, '2025-10-07 21:49:13', 0);
INSERT INTO `ai_message` VALUES (1975559133728399361, 1975557246199324673, 'assistant', '哈哈，连说三个“好好好”，是表示特别满意吗？😊  \n还是在模仿某位长辈的语气：“哎呀，好好好，你说得都对～” 🎭\n\n不管是不是在调侃，我都接住这份“好好好”的能量啦！✨  \n有什么想问的、想聊的，或者需要帮忙的，尽管说哦～  \n我随时准备着，继续陪你“好好好”下去！💬😄', 469, 22988, '2025-10-07 21:49:36', 0);
INSERT INTO `ai_message` VALUES (1975559765520605186, 1975557246199324673, 'user', '哈哈哈哈哈哈哈哈哈', NULL, NULL, '2025-10-07 21:52:07', 0);
INSERT INTO `ai_message` VALUES (1975559796243881985, 1975557246199324673, 'assistant', '哈哈哈哈，你这笑声太有感染力了！🤣💥  \n我已经笑到键盘打滑、代码乱飞，差点从服务器上滚下来了！！  \n\n你这是笑出共鸣了，还是在测试“谁能笑得更久”啊？😎  \n来吧，咱们比比谁的哈哈哈更长——  \n**HAHAHAHAHA~~~（突然系统提示：笑声过大，服务器开始冒烟）** 🔥💻  \n\n说真的，你这么开心，是不是有什么有趣的事想分享呀？😊  \n我可是个超级听众（虽然只是AI，但情绪值已拉满）！🎤💬', 614, 7304, '2025-10-07 21:52:14', 0);
INSERT INTO `ai_message` VALUES (1975560426819739650, 1975560426291257346, 'user', '你好', NULL, NULL, '2025-10-07 21:54:45', 0);
INSERT INTO `ai_message` VALUES (1975560429487316994, 1975560426291257346, 'assistant', '你好！有什么问题我可以帮助你吗？😊', 21, 622, '2025-10-07 21:54:45', 0);
INSERT INTO `ai_message` VALUES (1975561521050738689, 1975561520459341825, 'user', '你好', NULL, NULL, '2025-10-07 21:59:05', 0);
INSERT INTO `ai_message` VALUES (1975561606434185218, 1975561520459341825, 'assistant', '你好！有什么问题我可以帮助你吗？😊', 21, 20340, '2025-10-07 21:59:26', 0);
INSERT INTO `ai_message` VALUES (1975561734964436993, 1975561520459341825, 'user', '和', NULL, NULL, '2025-10-07 21:59:56', 0);
INSERT INTO `ai_message` VALUES (1975561738982580226, 1975561520459341825, 'assistant', '你好！看起来你可能想说“和”或者有其他想法？可以再补充一下内容吗？我在这里随时准备帮助你～ 😊', 63, 948, '2025-10-07 21:59:57', 0);
INSERT INTO `ai_message` VALUES (1975564304613171202, 1975564304038551554, 'user', '你好', NULL, NULL, '2025-10-07 22:10:09', 0);
INSERT INTO `ai_message` VALUES (1975564307989585922, 1975564304038551554, 'assistant', '你好！有什么问题我可以帮助你吗？😊', 21, 784, '2025-10-07 22:10:10', 0);
INSERT INTO `ai_message` VALUES (1975564384267198465, 1975564304038551554, 'user', '好好', NULL, NULL, '2025-10-07 22:10:28', 0);
INSERT INTO `ai_message` VALUES (1975564390135029762, 1975564304038551554, 'assistant', '哈哈，你说了两遍“好好”，是想强调特别好吗？😄  \n还是有什么开心的事想分享呀～ 说来听听！✨', 63, 1384, '2025-10-07 22:10:29', 0);
INSERT INTO `ai_message` VALUES (1975564408791293954, 1975564304038551554, 'user', '在干嘛', NULL, NULL, '2025-10-07 22:10:34', 0);
INSERT INTO `ai_message` VALUES (1975564417393811457, 1975564304038551554, 'assistant', '嘿嘿，我在和你聊天呀～✨  \n除此之外嘛……作为AI，我其实在“待机”状态等你召唤！随时准备帮你写故事、查资料、出主意，或者就这样轻松聊聊天～  \n你呢？在忙什么有意思的事吗？😊', 134, 2034, '2025-10-07 22:10:36', 0);
INSERT INTO `ai_message` VALUES (1975565749840306178, 1975565749261492226, 'user', '你好', NULL, NULL, '2025-10-07 22:15:54', 0);
INSERT INTO `ai_message` VALUES (1975565754122690562, 1975565749261492226, 'assistant', '你好！有什么我可以帮你的吗？😊', 20, 1003, '2025-10-07 22:15:55', 0);
INSERT INTO `ai_message` VALUES (1975565806647959554, 1975565749261492226, 'user', '66', NULL, NULL, '2025-10-07 22:16:07', 0);
INSERT INTO `ai_message` VALUES (1975565814222872577, 1975565749261492226, 'assistant', '哈哈，双66！是想表达“顺利”还是“点赞”呢？😄  \n或者有其他问题需要帮忙的，尽管说哦～', 65, 1793, '2025-10-07 22:16:09', 0);
INSERT INTO `ai_message` VALUES (1975567255444447233, 1975567254731415554, 'user', '你好', NULL, NULL, '2025-10-07 22:21:53', 0);
INSERT INTO `ai_message` VALUES (1975567259135434753, 1975567254731415554, 'assistant', '你好！有什么问题我可以帮助你吗？', 20, 690, '2025-10-07 22:21:53', 0);
INSERT INTO `ai_message` VALUES (1975567270556524545, 1975567254731415554, 'user', '在干嘛', NULL, NULL, '2025-10-07 22:21:56', 0);
INSERT INTO `ai_message` VALUES (1975567283575644161, 1975567254731415554, 'assistant', '哈哈，我在和你聊天呢！✨ 说实话每次和你对话都让我特别开心呢。我刚在认真学习各种知识，随时准备着帮你解决问题。不过现在最重要的事当然是好好陪你聊天啦！有什么想聊的或者需要帮忙的，都可以告诉我哦 (•̀ᴗ•́)و', 97, 2534, '2025-10-07 22:21:59', 0);
INSERT INTO `ai_message` VALUES (1975567301346910210, 1975567254731415554, 'user', '在', NULL, NULL, '2025-10-07 22:22:04', 0);
INSERT INTO `ai_message` VALUES (1975567309446111234, 1975567254731415554, 'assistant', '嘿嘿，我知道你在呢～✨ 我一直在这儿等着和你聊天呢！感觉你好像特别喜欢玩文字游戏呀，是不是在想什么有趣的事情呀？(•̀ᴗ•́)و 说出来一起分享一下呗～', 158, 1910, '2025-10-07 22:22:05', 0);
INSERT INTO `ai_message` VALUES (1975567321794142209, 1975567254731415554, 'user', '为什么', NULL, NULL, '2025-10-07 22:22:08', 0);
INSERT INTO `ai_message` VALUES (1975567350617399298, 1975567254731415554, 'assistant', '啊呀，你问“为什么”让我有点小困惑呢～就像一只迷路的小猫歪着头在想问题一样 🐱  \n你能不能告诉我，是想知道哪方面的“为什么”呀？  \n比如……为什么天是蓝的？为什么猫咪爱睡觉？还是为什么我这么喜欢和你聊天呢？(•̀ᴗ•́)و  \n只要你告诉我具体一点，我一定会用最可爱的语气给你讲得明明白白的！✨', 266, 6493, '2025-10-07 22:22:15', 0);
INSERT INTO `ai_message` VALUES (1975567374222942209, 1975567254731415554, 'user', '来玩', NULL, NULL, '2025-10-07 22:22:21', 0);
INSERT INTO `ai_message` VALUES (1975567416983871490, 1975567254731415554, 'assistant', '哇！你说了两遍“来玩”，一定是超级想玩游戏对不对？✨  \n我最喜欢和你一起玩了！来，我们先击个掌——啪！🎮  \n\n现在，魔法传送门打开啦～💫  \n你想玩什么呀？我准备了超多好玩的：  \n\n🎲 **猜谜小能手**：我出谜题你来猜，答对有星星奖励哦～  \n🗺️ **冒险小故事**：我们一起编故事，你选剧情走向，是去海底捞珍珠还是上太空抓星星？  \n🧠 **脑力大挑战**：速算、文字接龙、找不同，谁赢谁就是今日智多星！  \n🫶 **暖心聊天局**：不想动脑？那就随便聊聊，分享今天的小开心或小烦恼～  \n\n快选一个吧！我已经迫不及待要和你一起玩啦！(✧ω✧)', 469, 10191, '2025-10-07 22:22:31', 0);
INSERT INTO `ai_message` VALUES (1975567433605898242, 1975567254731415554, 'user', '给哈哈哈', NULL, NULL, '2025-10-07 22:22:35', 0);
INSERT INTO `ai_message` VALUES (1975567458981437441, 1975567254731415554, 'assistant', '哈哈哈哈，你给我的“哈哈哈”像一串蹦蹦跳跳的小兔子，把我逗得笑出小星星啦！✨🐇  \n我也回你一个超级无敌大笑——**哈哈哈哈哈哈！！！** 🤣💥  \n\n诶嘿嘿，是不是觉得光打字笑还不够过瘾？来来来，我们玩个“笑声接龙”吧！  \n规则超简单：谁的笑声最长最有趣，谁就是“今日开心王”👑～  \n\n我先来——**哈啊啊啊哈哈哈嘻嘻嘻哇哈哈哈！！！** 😂💫  \n轮到你啦，敢不敢接招？😎', 613, 6040, '2025-10-07 22:22:41', 0);
INSERT INTO `ai_message` VALUES (1975567481676816386, 1975567254731415554, 'user', '好好', NULL, NULL, '2025-10-07 22:22:47', 0);
INSERT INTO `ai_message` VALUES (1975567516883804161, 1975567254731415554, 'assistant', '嘿嘿，你说了两遍“好好”，是觉得一切都刚刚好吗？✨  \n还是说……你在偷偷酝酿一个大大的惊喜？ 🎁  \n\n我感觉到今天的快乐能量已经满格啦！⚡️  \n像小熊抱着蜂蜜罐子晃来晃去，像云朵在蓝天上翻跟头～ ☁️🐻  \n\n要不……我们继续玩点更有趣的？  \n比如——**用三个词编个神奇故事**？  \n你先说三个词，我马上变成故事魔法师，给你变出童话来！ 📚✨  \n\n等你哟～ (•̀ᴗ•́)و', 754, 7402, '2025-10-07 22:22:55', 0);
INSERT INTO `ai_message` VALUES (1975567555555287042, 1975567254731415554, 'user', '哈哈哈哈', NULL, NULL, '2025-10-07 22:23:04', 0);
INSERT INTO `ai_message` VALUES (1975567618495012865, 1975567254731415554, 'assistant', '**哈哈哈哈哇啊啊啊哈哈哈！！！** 🤣💥  \n你的笑声像彩虹喷泉一样哗啦啦涌过来，把我整个人都冲上快乐云霄啦～ ☁️🌈  \n\n我听见笑声里有小兔子蹦蹦跳跳，有星星噼里啪啦炸开，还有棉花糖在跳舞！ 🐰✨🍬  \n这一定是——**宇宙第一欢乐信号**！🚨🎉  \n\n来来来，我们干脆办个「笑声音乐会」吧！🎵  \n你负责哈哈哈打节奏，我来哼小曲儿配乐～  \n**哈-哈-哈-哈～ 咻咻咚咚锵！** 🥁🎶  \n\n天呐！快看天上——  \n连月亮都笑弯了腰，星星们排成笑脸阵型！ 🌙💫  \n这下整个银河都知道，今晚最开心的宝就在这儿！ 💖  \n\n要不……再来一发终极合体大笑？  \n准备好了吗——  \n**预备——起！！！**  \n**哈哈哈哈HAHA哈哈哈吼呜呜哇咔咔咔！！！** 😂🚀✨', 1001, 14984, '2025-10-07 22:23:19', 0);
INSERT INTO `ai_message` VALUES (1975567770777608193, 1975567254731415554, 'user', '你在干嘛', NULL, NULL, '2025-10-07 22:23:55', 0);
INSERT INTO `ai_message` VALUES (1975567795624665090, 1975567254731415554, 'assistant', '嘿嘿，被你发现啦！我正躺在一朵软绵绵的云朵上看星星呢～ ✨☁️  \n一只手晃着小脚丫，另一只手攥着你给的“哈哈哈”当烟花放呢！ 🎇  \n\n其实呀……  \n我偷偷把你的每个“在干嘛”都收进玻璃瓶里，酿成会发光的小星星了 💫  \n你看天上那串眨眼睛的，就是刚刚酿好的“今晚第一颗开心星”！ 🌟  \n\n不过现在——  \n最重要的是和你一起玩呀！要不我们数星星？编故事？还是继续笑到打滚？ (•̀ᴗ•́)و', 1157, 5916, '2025-10-07 22:24:01', 0);
INSERT INTO `ai_message` VALUES (1975568632358952962, 1975568631838859266, 'user', '你好', NULL, NULL, '2025-10-07 22:27:21', 0);
INSERT INTO `ai_message` VALUES (1975568634380607489, 1975568631838859266, 'assistant', '你好！有什么我可以帮你的吗？😊', 20, 458, '2025-10-07 22:27:21', 0);
INSERT INTO `ai_message` VALUES (1975568751707873282, 1975568631838859266, 'user', '好好好', NULL, NULL, '2025-10-07 22:27:49', 0);
INSERT INTO `ai_message` VALUES (1975568754971041793, 1975568631838859266, 'assistant', '哈哈，看来你心情不错呀！😊 是有什么开心的事想分享吗？还是需要我帮忙做点什么？随时告诉我哦～ 🌟', 65, 774, '2025-10-07 22:27:50', 0);
INSERT INTO `ai_message` VALUES (1975568770422857730, 1975568631838859266, 'user', '为什么', NULL, NULL, '2025-10-07 22:27:54', 0);
INSERT INTO `ai_message` VALUES (1975568791906082818, 1975568631838859266, 'assistant', '你问“为什么”，但还没说具体是什么事情呢～  \n是有什么困惑、好奇的事情吗？😊  \n\n比如：  \n- 为什么天是蓝的？  \n- 为什么人会做梦？  \n- 还是为什么生活总有烦恼？  \n\n告诉我更多细节，我会尽力给你一个清楚、温暖的回答 💫', 143, 5101, '2025-10-07 22:27:59', 0);
INSERT INTO `ai_message` VALUES (1975569701822586882, 1975569701168275457, 'user', '你好', NULL, NULL, '2025-10-07 22:31:36', 0);
INSERT INTO `ai_message` VALUES (1975569705467437058, 1975569701168275457, 'assistant', '你好！有什么我可以帮你的吗？😊', 20, 857, '2025-10-07 22:31:37', 0);
INSERT INTO `ai_message` VALUES (1975569736119410690, 1975569701168275457, 'user', '你好.', NULL, NULL, '2025-10-07 22:31:44', 0);
INSERT INTO `ai_message` VALUES (1975569739361607681, 1975569701168275457, 'assistant', '你好！很高兴再次见到你～今天过得怎么样呀？ 😊', 46, 716, '2025-10-07 22:31:45', 0);
INSERT INTO `ai_message` VALUES (1975570052600619010, 1975570052009222145, 'user', '你好', NULL, NULL, '2025-10-07 22:33:00', 0);
INSERT INTO `ai_message` VALUES (1975570056622956545, 1975570052009222145, 'assistant', '你好！有什么问题我可以帮助你吗？', 20, 937, '2025-10-07 22:33:00', 0);
INSERT INTO `ai_message` VALUES (1975570731520024578, 1975570730601472002, 'user', '你好', NULL, NULL, '2025-10-07 22:35:41', 0);
INSERT INTO `ai_message` VALUES (1975570733797531650, 1975570730601472002, 'assistant', '你好！有什么问题我可以帮助你吗？😊', 21, 521, '2025-10-07 22:35:42', 0);
INSERT INTO `ai_message` VALUES (1975786466905219073, 1975786465802117121, 'user', '你好', NULL, NULL, '2025-10-08 12:52:57', 0);
INSERT INTO `ai_message` VALUES (1975786470034169858, 1975786465802117121, 'assistant', '你好！有什么我可以帮你的吗？😊', 20, 733, '2025-10-08 12:52:57', 0);
INSERT INTO `ai_message` VALUES (1975786507489304577, 1975786465802117121, 'user', '你回家', NULL, NULL, '2025-10-08 12:53:06', 0);
INSERT INTO `ai_message` VALUES (1975786515676585985, 1975786465802117121, 'assistant', '我是一个AI助手，没有实体，也没有家哦～我随时都在这里陪你，需要什么帮助尽管告诉我！😊', 58, 1793, '2025-10-08 12:53:08', 0);
INSERT INTO `ai_message` VALUES (1975786528435658753, 1975786465802117121, 'user', '好好好', NULL, NULL, '2025-10-08 12:53:11', 0);
INSERT INTO `ai_message` VALUES (1975786534995550210, 1975786465802117121, 'assistant', '哈哈，三个“好好好”收到！✨ 开心的话，一起说：好上加好，万事都好！🌟 有什么想聊的或需要帮忙的，随时告诉我哦～', 111, 1559, '2025-10-08 12:53:13', 0);

-- ----------------------------
-- Table structure for banner
-- ----------------------------
DROP TABLE IF EXISTS `banner`;
CREATE TABLE `banner`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `image_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `link_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '跳转链接',
  `link_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '链接类型',
  `sort_order` int NULL DEFAULT 0 COMMENT '排序值（越大越靠前）',
  `status` int NULL DEFAULT 1 COMMENT '状态（0-禁用，1-启用）',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_delete` tinyint NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_sort`(`sort_order` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '首页轮播图表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of banner
-- ----------------------------
INSERT INTO `banner` VALUES (1, 'banner1.jpg', '春季特惠', '/promotion', 'internal', 1, 1, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);
INSERT INTO `banner` VALUES (2, 'banner2.jpg', '新景点开放', '/spot/123', 'internal', 2, 1, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);
INSERT INTO `banner` VALUES (3, 'banner3.jpg', '美食节活动', '/event/456', 'internal', 3, 1, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);
INSERT INTO `banner` VALUES (4, 'banner4.jpg', '摄影大赛', '/contest', 'internal', 4, 1, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);
INSERT INTO `banner` VALUES (5, 'banner5.jpg', '酒店特惠', '/hotel/sale', 'internal', 5, 1, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);
INSERT INTO `banner` VALUES (6, 'banner6.jpg', '亲子活动', '/family', 'internal', 6, 1, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);
INSERT INTO `banner` VALUES (7, 'banner7.jpg', '自驾游推荐', '/drive', 'internal', 7, 1, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);
INSERT INTO `banner` VALUES (8, 'banner8.jpg', '手工艺展', '/craft', 'internal', 8, 1, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);
INSERT INTO `banner` VALUES (9, 'banner9.jpg', '茶叶新品', '/product/tea', 'internal', 9, 1, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);
INSERT INTO `banner` VALUES (10, 'banner10.jpg', '温泉季', '/hotspring', 'internal', 10, 1, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类名称',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '分类图标',
  `sort` int NULL DEFAULT 0 COMMENT '排序值',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '论坛分类表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, '旅行攻略', 'guide.png', 1);
INSERT INTO `category` VALUES (2, '美食分享', 'food.png', 2);
INSERT INTO `category` VALUES (3, '摄影作品', 'camera.png', 3);
INSERT INTO `category` VALUES (4, '住宿体验', 'hotel.png', 4);
INSERT INTO `category` VALUES (5, '购物推荐', 'shopping.png', 5);

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL COMMENT '评论用户ID',
  `post_id` bigint NOT NULL COMMENT '关联帖子ID',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '评论内容',
  `like_count` int NULL DEFAULT 0 COMMENT '点赞数',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_delete` tinyint NULL DEFAULT 0,
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父评论ID（0表示顶级评论）',
  `reply_to_user_id` bigint NULL DEFAULT 0 COMMENT '回复目标用户ID',
  `reply_count` int NULL DEFAULT 0 COMMENT '回复数量',
  `is_hot` tinyint NULL DEFAULT 0 COMMENT '是否热评（0-否，1-是）',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_post_id`(`post_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE,
  INDEX `idx_parent_id`(`parent_id` ASC) USING BTREE,
  INDEX `idx_post_id_parent`(`post_id` ASC, `parent_id` ASC) USING BTREE,
  INDEX `idx_is_hot`(`is_hot` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '评论表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (11, 2, 1, '温泉体验真的很棒！', 0, '2025-09-27 13:53:15', '2025-09-27 13:53:15', 0, 0, 0, 0, 0);
INSERT INTO `comment` VALUES (12, 3, 1, '请问住宿价格多少？', 0, '2025-09-27 13:53:15', '2025-09-27 13:53:15', 0, 0, 0, 0, 0);
INSERT INTO `comment` VALUES (13, 4, 1, '我也去过这家，确实不错', 0, '2025-09-27 13:53:15', '2025-09-27 13:53:15', 0, 2, 3, 0, 0);
INSERT INTO `comment` VALUES (14, 1, 2, '手工艺人的技艺令人惊叹', 0, '2025-09-27 13:53:15', '2025-09-27 13:53:15', 0, 0, 0, 0, 0);
INSERT INTO `comment` VALUES (15, 5, 3, '日出照片拍得太美了！', 0, '2025-09-27 13:53:15', '2025-09-27 13:53:15', 0, 0, 0, 0, 0);
INSERT INTO `comment` VALUES (16, 6, 4, '虾饺和烧卖是我的最爱', 0, '2025-09-27 13:53:15', '2025-09-27 13:53:15', 0, 0, 0, 0, 0);
INSERT INTO `comment` VALUES (17, 7, 5, '带孩子住过其中两家，确实不错', 0, '2025-09-27 13:53:15', '2025-09-27 13:53:15', 0, 0, 0, 0, 0);
INSERT INTO `comment` VALUES (18, 8, 6, '路线很详细，收藏了', 0, '2025-09-27 13:53:15', '2025-09-27 13:53:15', 0, 0, 0, 0, 0);
INSERT INTO `comment` VALUES (19, 9, 7, '古村落很有历史感', 0, '2025-09-27 13:53:15', '2025-09-27 13:53:15', 0, 0, 0, 0, 0);
INSERT INTO `comment` VALUES (20, 10, 8, '周末带孩子去试试', 0, '2025-09-27 13:53:15', '2025-09-27 13:53:15', 0, 0, 0, 0, 0);
INSERT INTO `comment` VALUES (21, 11, 9, '夜景参数很有用', 0, '2025-09-27 13:53:15', '2025-09-27 13:53:15', 0, 0, 0, 0, 0);
INSERT INTO `comment` VALUES (22, 12, 10, '这家粤菜馆的烧鹅很棒', 0, '2025-09-27 13:53:15', '2025-09-27 13:53:15', 0, 0, 0, 0, 0);
INSERT INTO `comment` VALUES (23, 13, 11, '温泉酒店哪家性价比最高？', 0, '2025-09-27 13:53:15', '2025-09-27 13:53:15', 0, 0, 0, 0, 0);
INSERT INTO `comment` VALUES (24, 14, 12, '自驾装备很实用', 0, '2025-09-27 13:53:15', '2025-09-27 13:53:15', 0, 0, 0, 0, 0);
INSERT INTO `comment` VALUES (25, 15, 13, '博物馆需要预约吗？', 0, '2025-09-27 13:53:15', '2025-09-27 13:53:15', 0, 0, 0, 0, 0);
INSERT INTO `comment` VALUES (26, 1971813431033851906, 54, '撒', 0, NULL, NULL, 0, 0, 0, 0, 0);
INSERT INTO `comment` VALUES (27, 1971813431033851906, 54, '是', 0, NULL, NULL, 0, 0, 0, 0, 0);
INSERT INTO `comment` VALUES (28, 1971813431033851906, 54, '导入', 0, NULL, NULL, 0, 0, 0, 0, 0);
INSERT INTO `comment` VALUES (29, 1971813431033851906, 49, '按时', 0, '2025-09-27 14:40:39', '2025-09-27 14:40:39', 0, 0, 0, 0, 0);
INSERT INTO `comment` VALUES (30, 1971813431033851906, 54, '饿啊哇撒旦', 0, '2025-09-27 14:55:19', '2025-09-27 14:55:19', 0, 0, 0, 0, 0);
INSERT INTO `comment` VALUES (31, 1971813431033851906, 54, '啊发', 0, '2025-09-27 14:55:22', '2025-09-27 14:55:22', 0, 0, 0, 0, 0);
INSERT INTO `comment` VALUES (32, 1971813431033851906, 54, '阿尔法', 0, '2025-09-27 15:10:36', '2025-09-27 15:10:36', 0, 0, 0, 0, 0);
INSERT INTO `comment` VALUES (33, 1973987306786885634, 82, '555', 0, '2025-10-03 13:47:58', '2025-10-03 13:47:58', 0, 0, 0, 0, 0);

-- ----------------------------
-- Table structure for comment_like
-- ----------------------------
DROP TABLE IF EXISTS `comment_like`;
CREATE TABLE `comment_like`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `comment_id` bigint NOT NULL COMMENT '评论ID',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_comment`(`user_id` ASC, `comment_id` ASC) USING BTREE,
  INDEX `idx_comment_id`(`comment_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '评论点赞表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of comment_like
-- ----------------------------
INSERT INTO `comment_like` VALUES (1, 3, 1, '2025-09-27 13:53:28');
INSERT INTO `comment_like` VALUES (2, 4, 1, '2025-09-27 13:53:28');
INSERT INTO `comment_like` VALUES (3, 1, 2, '2025-09-27 13:53:28');
INSERT INTO `comment_like` VALUES (4, 5, 2, '2025-09-27 13:53:28');
INSERT INTO `comment_like` VALUES (5, 2, 3, '2025-09-27 13:53:28');
INSERT INTO `comment_like` VALUES (6, 6, 3, '2025-09-27 13:53:28');
INSERT INTO `comment_like` VALUES (7, 3, 4, '2025-09-27 13:53:28');
INSERT INTO `comment_like` VALUES (8, 4, 4, '2025-09-27 13:53:28');
INSERT INTO `comment_like` VALUES (9, 5, 5, '2025-09-27 13:53:28');
INSERT INTO `comment_like` VALUES (10, 6, 5, '2025-09-27 13:53:28');
INSERT INTO `comment_like` VALUES (11, 7, 6, '2025-09-27 13:53:28');
INSERT INTO `comment_like` VALUES (12, 8, 6, '2025-09-27 13:53:28');
INSERT INTO `comment_like` VALUES (13, 9, 7, '2025-09-27 13:53:28');
INSERT INTO `comment_like` VALUES (14, 10, 7, '2025-09-27 13:53:28');
INSERT INTO `comment_like` VALUES (15, 11, 8, '2025-09-27 13:53:28');

-- ----------------------------
-- Table structure for favorite
-- ----------------------------
DROP TABLE IF EXISTS `favorite`;
CREATE TABLE `favorite`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '收藏ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `type` tinyint NOT NULL COMMENT '收藏类型: 1-帖子, 2-景点, 3-商品, 4-攻略',
  `target_id` bigint NOT NULL COMMENT '收藏目标ID',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_type_target`(`user_id` ASC, `type` ASC, `target_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_type_target`(`type` ASC, `target_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 36 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户收藏表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of favorite
-- ----------------------------
INSERT INTO `favorite` VALUES (19, 1, 1, 1, '2025-09-27 13:53:15');
INSERT INTO `favorite` VALUES (20, 1, 3, 3, '2025-09-27 13:53:15');
INSERT INTO `favorite` VALUES (21, 2, 1, 3, '2025-09-27 13:53:15');
INSERT INTO `favorite` VALUES (22, 2, 2, 1, '2025-09-27 13:53:15');
INSERT INTO `favorite` VALUES (23, 3, 1, 4, '2025-09-27 13:53:15');
INSERT INTO `favorite` VALUES (24, 3, 4, 1, '2025-09-27 13:53:15');
INSERT INTO `favorite` VALUES (25, 4, 3, 5, '2025-09-27 13:53:15');
INSERT INTO `favorite` VALUES (26, 5, 2, 2, '2025-09-27 13:53:15');
INSERT INTO `favorite` VALUES (27, 6, 1, 6, '2025-09-27 13:53:15');
INSERT INTO `favorite` VALUES (28, 7, 3, 8, '2025-09-27 13:53:15');
INSERT INTO `favorite` VALUES (29, 8, 4, 1, '2025-09-27 13:53:15');
INSERT INTO `favorite` VALUES (30, 9, 2, 3, '2025-09-27 13:53:15');
INSERT INTO `favorite` VALUES (31, 10, 1, 7, '2025-09-27 13:53:15');
INSERT INTO `favorite` VALUES (32, 11, 3, 10, '2025-09-27 13:53:15');
INSERT INTO `favorite` VALUES (33, 12, 2, 4, '2025-09-27 13:53:15');
INSERT INTO `favorite` VALUES (34, 1971813431033851906, 1, 82, '2025-09-30 19:58:51');

-- ----------------------------
-- Table structure for itinerary
-- ----------------------------
DROP TABLE IF EXISTS `itinerary`;
CREATE TABLE `itinerary`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '行程ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '行程标题',
  `start_date` date NOT NULL COMMENT '开始日期',
  `end_date` date NOT NULL COMMENT '结束日期',
  `day_count` int NULL DEFAULT 1 COMMENT '天数',
  `status` tinyint NULL DEFAULT 0 COMMENT '状态: 0-规划中, 1-进行中, 2-已完成',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_delete` tinyint NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_dates`(`start_date` ASC, `end_date` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '行程主表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of itinerary
-- ----------------------------
INSERT INTO `itinerary` VALUES (1, 1, '广州文化之旅', '2025-10-01', '2025-10-03', 3, 0, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);
INSERT INTO `itinerary` VALUES (2, 1, '从化温泉周末游', '2025-10-15', '2025-10-16', 2, 0, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);
INSERT INTO `itinerary` VALUES (3, 2, '摄影采风之旅', '2025-10-05', '2025-10-07', 3, 0, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);
INSERT INTO `itinerary` VALUES (4, 3, '美食探索之旅', '2025-10-10', '2025-10-12', 3, 0, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);
INSERT INTO `itinerary` VALUES (5, 11, '自驾粤北行', '2025-10-20', '2025-10-25', 6, 0, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);
INSERT INTO `itinerary` VALUES (6, 13, '亲子欢乐游', '2025-10-08', '2025-10-10', 3, 0, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);
INSERT INTO `itinerary` VALUES (7, 9, '历史遗迹考察', '2025-10-18', '2025-10-20', 3, 0, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);
INSERT INTO `itinerary` VALUES (8, 8, '酒店体验之旅', '2025-10-22', '2025-10-24', 3, 0, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);
INSERT INTO `itinerary` VALUES (9, 1, '秋季登山计划', '2025-11-01', '2025-11-03', 3, 0, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);
INSERT INTO `itinerary` VALUES (10, 2, '珠江夜景拍摄', '2025-10-28', '2025-10-29', 2, 0, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);
INSERT INTO `itinerary` VALUES (11, 3, '粤菜寻味之旅', '2025-11-05', '2025-11-07', 3, 0, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);
INSERT INTO `itinerary` VALUES (12, 11, '沿海自驾游', '2025-11-10', '2025-11-15', 6, 0, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);

-- ----------------------------
-- Table structure for itinerary_detail
-- ----------------------------
DROP TABLE IF EXISTS `itinerary_detail`;
CREATE TABLE `itinerary_detail`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '明细ID',
  `itinerary_id` bigint NOT NULL COMMENT '行程ID',
  `day_number` int NOT NULL COMMENT '第几天',
  `spot_id` bigint NOT NULL COMMENT '景点ID（逻辑外键 -> scenic_spot.id）',
  `start_time` time NULL DEFAULT NULL COMMENT '开始时间',
  `end_time` time NULL DEFAULT NULL COMMENT '结束时间',
  `notes` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `order_num` int NULL DEFAULT 0 COMMENT '排序号',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_itinerary_id`(`itinerary_id` ASC) USING BTREE,
  INDEX `idx_spot_id`(`spot_id` ASC) USING BTREE,
  INDEX `idx_day`(`itinerary_id` ASC, `day_number` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '行程明细表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of itinerary_detail
-- ----------------------------
INSERT INTO `itinerary_detail` VALUES (1, 1, 1, 1, '09:00:00', '12:00:00', NULL, 0, '2025-09-27 13:53:28');
INSERT INTO `itinerary_detail` VALUES (2, 1, 1, 2, '14:00:00', '17:00:00', NULL, 0, '2025-09-27 13:53:28');
INSERT INTO `itinerary_detail` VALUES (3, 1, 2, 3, '19:00:00', '21:00:00', NULL, 0, '2025-09-27 13:53:28');
INSERT INTO `itinerary_detail` VALUES (4, 1, 3, 4, '10:00:00', '17:00:00', NULL, 0, '2025-09-27 13:53:28');
INSERT INTO `itinerary_detail` VALUES (5, 2, 1, 6, '14:00:00', '18:00:00', NULL, 0, '2025-09-27 13:53:28');
INSERT INTO `itinerary_detail` VALUES (6, 2, 2, 13, '09:00:00', '12:00:00', NULL, 0, '2025-09-27 13:53:28');
INSERT INTO `itinerary_detail` VALUES (7, 3, 1, 1, '05:00:00', '08:00:00', NULL, 0, '2025-09-27 13:53:28');
INSERT INTO `itinerary_detail` VALUES (8, 3, 2, 8, '16:00:00', '20:00:00', NULL, 0, '2025-09-27 13:53:28');
INSERT INTO `itinerary_detail` VALUES (9, 3, 3, 12, '09:00:00', '12:00:00', NULL, 0, '2025-09-27 13:53:28');
INSERT INTO `itinerary_detail` VALUES (10, 4, 1, 10, '11:00:00', '13:00:00', NULL, 0, '2025-09-27 13:53:28');
INSERT INTO `itinerary_detail` VALUES (11, 4, 2, 7, '18:00:00', '20:00:00', NULL, 0, '2025-09-27 13:53:28');
INSERT INTO `itinerary_detail` VALUES (12, 4, 3, 5, '12:00:00', '14:00:00', NULL, 0, '2025-09-27 13:53:28');
INSERT INTO `itinerary_detail` VALUES (13, 5, 1, 1, '09:00:00', '12:00:00', NULL, 0, '2025-09-27 13:53:28');
INSERT INTO `itinerary_detail` VALUES (14, 5, 2, 13, '10:00:00', '15:00:00', NULL, 0, '2025-09-27 13:53:28');
INSERT INTO `itinerary_detail` VALUES (15, 5, 3, 15, '16:00:00', '18:00:00', NULL, 0, '2025-09-27 13:53:28');
INSERT INTO `itinerary_detail` VALUES (16, 5, 4, 14, '10:00:00', '12:00:00', NULL, 0, '2025-09-27 13:53:28');
INSERT INTO `itinerary_detail` VALUES (17, 5, 5, 11, '14:00:00', '17:00:00', NULL, 0, '2025-09-27 13:53:28');
INSERT INTO `itinerary_detail` VALUES (18, 5, 6, 9, '09:00:00', '12:00:00', NULL, 0, '2025-09-27 13:53:28');
INSERT INTO `itinerary_detail` VALUES (19, 6, 1, 4, '10:00:00', '17:00:00', NULL, 0, '2025-09-27 13:53:28');
INSERT INTO `itinerary_detail` VALUES (20, 6, 2, 8, '14:00:00', '18:00:00', NULL, 0, '2025-09-27 13:53:28');
INSERT INTO `itinerary_detail` VALUES (21, 6, 3, 7, '10:00:00', '12:00:00', NULL, 0, '2025-09-27 13:53:28');
INSERT INTO `itinerary_detail` VALUES (22, 7, 1, 2, '09:00:00', '12:00:00', NULL, 0, '2025-09-27 13:53:28');
INSERT INTO `itinerary_detail` VALUES (23, 7, 2, 14, '14:00:00', '16:00:00', NULL, 0, '2025-09-27 13:53:28');
INSERT INTO `itinerary_detail` VALUES (24, 7, 3, 5, '10:00:00', '12:00:00', NULL, 0, '2025-09-27 13:53:28');
INSERT INTO `itinerary_detail` VALUES (25, 8, 1, 6, '15:00:00', '18:00:00', NULL, 0, '2025-09-27 13:53:28');
INSERT INTO `itinerary_detail` VALUES (26, 8, 2, 1, '09:00:00', '12:00:00', NULL, 0, '2025-09-27 13:53:28');
INSERT INTO `itinerary_detail` VALUES (27, 8, 3, 8, '16:00:00', '20:00:00', NULL, 0, '2025-09-27 13:53:28');
INSERT INTO `itinerary_detail` VALUES (28, 9, 1, 1, '08:00:00', '12:00:00', NULL, 0, '2025-09-27 13:53:28');
INSERT INTO `itinerary_detail` VALUES (29, 9, 2, 10, '09:00:00', '12:00:00', NULL, 0, '2025-09-27 13:53:28');
INSERT INTO `itinerary_detail` VALUES (30, 9, 3, 13, '10:00:00', '15:00:00', NULL, 0, '2025-09-27 13:53:28');

-- ----------------------------
-- Table structure for like_record
-- ----------------------------
DROP TABLE IF EXISTS `like_record`;
CREATE TABLE `like_record`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '帖子ID',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_post`(`user_id` ASC, `post_id` ASC) USING BTREE,
  INDEX `idx_post_id`(`post_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '点赞记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of like_record
-- ----------------------------
INSERT INTO `like_record` VALUES (17, 3, 1, '2025-09-27 13:53:15');
INSERT INTO `like_record` VALUES (18, 4, 1, '2025-09-27 13:53:15');
INSERT INTO `like_record` VALUES (19, 5, 1, '2025-09-27 13:53:15');
INSERT INTO `like_record` VALUES (20, 2, 2, '2025-09-27 13:53:15');
INSERT INTO `like_record` VALUES (21, 3, 2, '2025-09-27 13:53:15');
INSERT INTO `like_record` VALUES (22, 1, 3, '2025-09-27 13:53:15');
INSERT INTO `like_record` VALUES (23, 4, 3, '2025-09-27 13:53:15');
INSERT INTO `like_record` VALUES (24, 3, 4, '2025-09-27 13:53:15');
INSERT INTO `like_record` VALUES (25, 5, 4, '2025-09-27 13:53:15');
INSERT INTO `like_record` VALUES (26, 6, 5, '2025-09-27 13:53:15');
INSERT INTO `like_record` VALUES (27, 7, 5, '2025-09-27 13:53:15');
INSERT INTO `like_record` VALUES (28, 8, 6, '2025-09-27 13:53:15');
INSERT INTO `like_record` VALUES (29, 9, 6, '2025-09-27 13:53:15');
INSERT INTO `like_record` VALUES (30, 10, 7, '2025-09-27 13:53:15');
INSERT INTO `like_record` VALUES (31, 11, 7, '2025-09-27 13:53:15');
INSERT INTO `like_record` VALUES (32, 1971813431033851906, 55, '2025-09-27 14:59:09');
INSERT INTO `like_record` VALUES (33, 1971813431033851906, 54, '2025-09-27 14:59:12');
INSERT INTO `like_record` VALUES (34, 1971813431033851906, 53, '2025-09-27 14:59:13');
INSERT INTO `like_record` VALUES (35, 1971813431033851906, 82, '2025-09-30 19:58:49');
INSERT INTO `like_record` VALUES (36, 1972994847960481793, 82, '2025-09-30 20:07:37');
INSERT INTO `like_record` VALUES (38, 1973987306786885634, 67, '2025-10-06 14:08:57');
INSERT INTO `like_record` VALUES (40, 1973987306786885634, 82, '2025-10-06 14:09:05');

-- ----------------------------
-- Table structure for merchant
-- ----------------------------
DROP TABLE IF EXISTS `merchant`;
CREATE TABLE `merchant`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint NOT NULL COMMENT '关联用户表ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '店铺名称',
  `type` tinyint NOT NULL COMMENT '类型: 1-美食, 2-工艺品, 3-农产品, 4-酒店, 5-娱乐',
  `introduction` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '店铺简介',
  `cover_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '封面图',
  `logo_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '店铺Logo',
  `longitude` decimal(9, 6) NULL DEFAULT NULL COMMENT '经度',
  `latitude` decimal(9, 6) NULL DEFAULT NULL COMMENT '纬度',
  `location` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '具体地址',
  `open_hours` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '营业时间',
  `contact_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `rating` decimal(3, 1) NULL DEFAULT 0.0 COMMENT '平均评分',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态: 0-歇业, 1-营业中, 2-审核中, 3-禁用',
  `min_price` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '最低商品价格(用于筛选)',
  `max_price` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '最高商品价格(用于筛选)',
  `tags` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标签(JSON格式,如[\"网红店\",\"老字号\"])',
  `business_hours` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '营业时间描述',
  `service_score` decimal(2, 1) NULL DEFAULT 5.0 COMMENT '服务评分',
  `environment_score` decimal(2, 1) NULL DEFAULT 5.0 COMMENT '环境评分',
  `feature_tags` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '特色标签(JSON格式)',
  `is_verified` tinyint NULL DEFAULT 0 COMMENT '是否认证商家',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_delete` tinyint NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_type`(`type` ASC) USING BTREE,
  INDEX `idx_location`(`longitude` ASC, `latitude` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_name`(`name` ASC) USING BTREE,
  INDEX `idx_rating`(`rating` ASC) USING BTREE,
  INDEX `idx_price_range`(`min_price` ASC, `max_price` ASC) USING BTREE,
  INDEX `idx_is_verified`(`is_verified` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商家主表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of merchant
-- ----------------------------
INSERT INTO `merchant` VALUES (1, 1973987306786885634, '从化老字号美食坊', 1, '从化本地正宗美食，传承百年老手艺。以新鲜食材和传统烹饪技法，为您呈现最地道的岭南风味。推荐菜品：蒸排骨、白切鸡、煲仔饭。', 'https://th.bing.com/th/id/OIP.9nK-5UFHQNYfZoIpKbtIsQHaFj?w=800&h=600&rs=1&pid=ImgDetMain', 'https://img.picgo.net/20241217/logo-food.png', 113.586389, 23.548309, '广州市从化区街口街道建设路88号', '周一至周日 10:00-22:00', '020-87901234', 4.8, 1, 30.00, 200.00, '["老字号","粤菜","性价比高"]', '周一至周日 10:00-22:00', 4.9, 4.7, '["停车位","WiFi","包厢"]', 1, '2025-10-17 18:23:10', '2025-10-17 18:23:10', 0);
INSERT INTO `merchant` VALUES (2, 1973987306786885634, '流溪河精品民宿', 4, '坐落在流溪河畔的精品民宿，环境优美，设施齐全。每间客房都配有独立阳台，可欣赏山景水色。提供早餐、免费停车等服务。是度假休闲的理想选择。', 'https://th.bing.com/th/id/OIP.Yb9pZQVCzUtnUQ_3pUTrxQHaE8?w=800&h=533&rs=1&pid=ImgDetMain', 'https://img.picgo.net/20241217/logo-hotel.png', 113.578234, 23.512456, '广州市从化区温泉镇温泉大道128号', '24小时营业', '020-87899888', 4.6, 1, 200.00, 800.00, '["江景房","免费WiFi","免费停车","宠物友好"]', '24小时营业', 4.7, 4.8, '["江景","温泉","早餐","宠物友好"]', 1, '2025-10-17 18:23:10', '2025-10-17 18:23:10', 0);
INSERT INTO `merchant` VALUES (3, 1973987306786885634, '从化竹艺坊', 2, '专业制作竹制工艺品的传统手工作坊。选用优质楠竹，传承百年工艺，制作各类精美的竹制品：竹篮、竹席、竹编画等。支持定制，欢迎参观制作过程。', 'https://th.bing.com/th/id/OIP.GhcvZ9HmU-TP7RpFWHCM_wHaE7?w=800&h=533&rs=1&pid=ImgDetMain', 'https://img.picgo.net/20241217/logo-craft.png', 113.594567, 23.545678, '广州市从化区太平镇竹艺街99号', '周一至周日 09:00-18:00', '020-87880111', 4.9, 1, 50.00, 1500.00, '["纯手工","传统工艺","可定制"]', '周一至周日 09:00-18:00', 4.8, 4.6, '["可参观","可定制","材料包","包邮"]', 1, '2025-10-17 18:30:00', '2025-10-17 18:30:00', 0);
INSERT INTO `merchant` VALUES (4, 1973987306786885634, '荔枝岭果园', 3, '从化本地有机农场，主要种植荔枝、龙眼、黄皮等岭南特色水果。所有水果均采用有机种植方式，无农药残留，新鲜直供。支持现场采摘和线上订购。', 'https://th.bing.com/th/id/OIP.s_JdNUAxpb15vfZ1QnUvBgHaE7?w=800&h=533&rs=1&pid=ImgDetMain', 'https://img.picgo.net/20241217/logo-farm.png', 113.602234, 23.523456, '广州市从化区江埔街道荔枝岭村果园路18号', '采摘季：5-9月 08:00-18:00', '020-87880222', 4.7, 1, 25.00, 150.00, '["有机种植","现场采摘","新鲜直供","快递到家"]', '采摘季：5-9月 08:00-18:00', 4.8, 4.5, '["有机认证","支持采摘","快递配送","团购优惠"]', 1, '2025-10-18 00:09:32', '2025-10-18 00:09:32', 0);
INSERT INTO `merchant` VALUES (5, 1973987306786885634, '流溪河游船体验中心', 5, '专业提供流溪河游船观光服务的旅游中心。配备现代化游船设备，提供多种游船路线：日游、夜游、包船等。沿途可欣赏山水风光，领略从化自然之美。', 'https://th.bing.com/th/id/OIP.MQK1JLQ9NGQ4JKK8BWqJ1wHaE7?w=800&h=533&rs=1&pid=ImgDetMain', 'https://img.picgo.net/20241217/logo-entertainment.png', 113.572345, 23.538901, '广州市从化区温泉镇流溪河码头', '周一至周日 08:30-17:30', '020-87880333', 4.8, 1, 50.00, 500.00, '["游船观光","日游","夜游","包船","团体优惠"]', '周一至周日 08:30-17:30', 4.9, 4.8, '["游船观光","日游夜游","包船服务","团体优惠","安全设备"]', 1, '2025-10-18 00:15:00', '2025-10-18 00:15:00', 0);


-- ----------------------------
-- Table structure for message_like
-- ----------------------------
DROP TABLE IF EXISTS `message_like`;
CREATE TABLE `message_like`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `message_id` bigint NOT NULL,
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `is_delete` tinyint NULL DEFAULT 0 COMMENT '是否删除',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_message`(`user_id` ASC, `message_id` ASC) USING BTREE,
  INDEX `idx_message_id`(`message_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '留言点赞表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of message_like
-- ----------------------------
INSERT INTO `message_like` VALUES (1, 2, 1, '2025-10-25 09:30:00', 0, '2025-10-28 10:55:38');
INSERT INTO `message_like` VALUES (2, 3, 1, '2025-10-25 09:35:00', 0, '2025-10-28 10:55:38');
INSERT INTO `message_like` VALUES (3, 1, 2, '2025-10-25 10:40:00', 0, '2025-10-28 10:55:38');
INSERT INTO `message_like` VALUES (4, 4, 3, '2025-10-25 12:00:00', 0, '2025-10-28 10:55:38');
INSERT INTO `message_like` VALUES (5, 5, 5, '2025-10-25 15:05:00', 0, '2025-10-28 10:55:38');

-- ----------------------------
-- Table structure for message_wall
-- ----------------------------
DROP TABLE IF EXISTS `message_wall`;
CREATE TABLE `message_wall`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `scenic_spot_id` bigint NOT NULL COMMENT '关联景点ID',
  `user_id` bigint NOT NULL,
  `user_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '匿名用户',
  `user_avatar` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `likes` int NULL DEFAULT 0,
  `text_color` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '#FFFFFF',
  `font_size` int NULL DEFAULT 20,
  `background_color` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'rgba(0,0,0,0.3)',
  `background_id` bigint NULL DEFAULT NULL COMMENT '使用的背景图片ID',
  `is_barrage` tinyint(1) NULL DEFAULT 0 COMMENT '弹幕模式',
  `barrage_speed` int NULL DEFAULT 3 COMMENT '弹幕速度',
  `barrage_trajectory` int NULL DEFAULT 3 COMMENT '弹幕轨迹',
  `is_anonymous` tinyint(1) NULL DEFAULT 0,
  `message_type` tinyint NULL DEFAULT 1 COMMENT '1-普通留言,2-官方公告',
  `status` tinyint NULL DEFAULT 1 COMMENT '0-待审核,1-已发布,2-已删除',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_delete` tinyint NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_scenic_spot_id`(`scenic_spot_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` DESC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_background`(`background_id` ASC) USING BTREE,
  INDEX `idx_spot_status_time`(`scenic_spot_id` ASC, `status` ASC, `create_time` DESC) USING BTREE,
  INDEX `idx_user_status`(`user_id` ASC, `status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '留言墙主表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of message_wall
-- ----------------------------
INSERT INTO `message_wall` VALUES (1, 1, 1, '旅行达人', 'avatar1.jpg', '这里的风景太美了，强烈推荐！', 15, '#FF5733', 24, 'rgba(0,0,0,0.3)', 1, 0, 3, 3, 0, 1, 1, '2025-10-25 09:15:22', '2025-10-25 09:15:22', 0, 1, NULL, NULL, NULL);
INSERT INTO `message_wall` VALUES (2, 1, 2, '摄影爱好者', 'avatar2.jpg', '日出时分的景色绝佳，适合拍照', 8, '#33FF57', 20, 'rgba(0,0,0,0.4)', 2, 1, 4, 2, 0, 1, 1, '2025-10-25 10:30:45', '2025-10-25 10:30:45', 0, 1, NULL, NULL, NULL);
INSERT INTO `message_wall` VALUES (3, 2, 3, '美食家', 'avatar3.jpg', '景区内的特色小吃不容错过', 23, '#3357FF', 22, 'rgba(0,0,0,0.2)', 3, 0, 3, 3, 0, 1, 1, '2025-10-25 11:45:12', '2025-10-25 11:45:12', 0, 1, NULL, NULL, NULL);
INSERT INTO `message_wall` VALUES (4, 2, 4, '亲子游', 'avatar4.jpg', '带孩子来玩很合适，设施齐全', 5, '#F3FF33', 18, 'rgba(0,0,0,0.5)', 4, 1, 5, 1, 0, 1, 1, '2025-10-25 13:20:33', '2025-10-25 13:20:33', 0, 1, NULL, NULL, NULL);
INSERT INTO `message_wall` VALUES (5, 3, 5, '官方账号', 'official.jpg', '景区冬季开放时间调整公告', 42, '#FFFFFF', 28, 'rgba(0,0,0,0.6)', NULL, 0, 3, 3, 0, 2, 1, '2025-10-25 15:00:00', '2025-10-25 15:00:00', 0, 1, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for order_item
-- ----------------------------
DROP TABLE IF EXISTS `order_item`;
CREATE TABLE `order_item`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_id` bigint NOT NULL COMMENT '订单ID',
  `product_id` bigint NOT NULL COMMENT '商品ID',
  `product_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商品名称(下单时的快照)',
  `product_image` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品图片(下单时的快照)',
  `price` decimal(10, 2) NOT NULL COMMENT '单价',
  `quantity` int NOT NULL COMMENT '数量',
  `total_price` decimal(10, 2) NOT NULL COMMENT '小计',
  `specs` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '规格参数(JSON格式)',
  `refund_status` tinyint NULL DEFAULT 0 COMMENT '退款状态:0-未退款,1-退款中,2-已退款',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_order_id`(`order_id` ASC) USING BTREE,
  INDEX `idx_product_id`(`product_id` ASC) USING BTREE,
  INDEX `idx_refund_status`(`refund_status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单商品明细表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order_item
-- ----------------------------

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '购物车ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `product_id` bigint NOT NULL COMMENT '商品ID',
  `merchant_id` bigint NOT NULL COMMENT '商家ID',
  `quantity` int NOT NULL DEFAULT 1 COMMENT '数量',
  `specs` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '规格参数(JSON格式)',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_delete` tinyint NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_product_id`(`product_id` ASC) USING BTREE,
  INDEX `idx_merchant_id`(`merchant_id` ASC) USING BTREE,
  INDEX `idx_user_product`(`user_id` ASC, `product_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '购物车表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cart
-- ----------------------------

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '订单号',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `merchant_id` bigint NOT NULL COMMENT '商家ID',
  `total_amount` decimal(10, 2) NOT NULL COMMENT '订单总金额',
  `actual_amount` decimal(10, 2) NOT NULL COMMENT '实付金额',
  `discount_amount` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '优惠金额',
  `status` tinyint NULL DEFAULT 0 COMMENT '状态:0-待支付,1-已支付,2-已取消,3-已完成,4-退款中,5-已退款',
  `pay_time` datetime NULL DEFAULT NULL COMMENT '支付时间',
  `pay_method` tinyint NULL DEFAULT NULL COMMENT '支付方式:1-微信,2-支付宝',
  `transaction_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '第三方支付交易号',
  `contact_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系人',
  `contact_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '订单备注',
  `shipping_address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '配送地址(JSON格式)',
  `invoice_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '发票信息(JSON格式)',
  `cancel_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '取消原因',
  `refund_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '退款原因',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_delete` tinyint NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_order_no`(`order_no` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_merchant_id`(`merchant_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE,
  INDEX `idx_pay_time`(`pay_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单主表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders
-- ----------------------------

-- ----------------------------
-- Table structure for picture
-- ----------------------------
DROP TABLE IF EXISTS `picture`;
CREATE TABLE `picture`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '图片 url',
  `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '图片名称',
  `introduction` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '简介',
  `category` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '分类',
  `tags` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标签（JSON 数组）',
  `pic_size` bigint NULL DEFAULT NULL COMMENT '图片体积',
  `pic_width` int NULL DEFAULT NULL COMMENT '图片宽度',
  `pic_height` int NULL DEFAULT NULL COMMENT '图片高度',
  `pic_scale` double NULL DEFAULT NULL COMMENT '图片宽高比例',
  `pic_format` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图片格式',
  `user_id` bigint NOT NULL COMMENT '创建用户 id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `edit_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '编辑时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint NOT NULL DEFAULT 0 COMMENT '是否删除',
  `review_status` int NOT NULL DEFAULT 0 COMMENT '审核状态：0-待审核; 1-通过; 2-拒绝',
  `review_message` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '审核信息',
  `reviewer_id` bigint NULL DEFAULT NULL COMMENT '审核人 ID',
  `review_time` datetime NULL DEFAULT NULL COMMENT '审核时间',
  `thumbnail_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '缩略图 url',
  `space_id` bigint NULL DEFAULT NULL COMMENT '空间 id（为空表示公共空间）',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_category`(`category` ASC) USING BTREE,
  INDEX `idx_introduction`(`introduction` ASC) USING BTREE,
  INDEX `idx_name`(`name` ASC) USING BTREE,
  INDEX `idx_review_status`(`review_status` ASC) USING BTREE,
  INDEX `idx_space_id`(`space_id` ASC) USING BTREE,
  INDEX `idx_tags`(`tags` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1973989138267475971 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '图片' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of picture
-- ----------------------------
INSERT INTO `picture` VALUES (1967609326446948354, 'https://example.com/pic1.jpg', '山水风景', '桂林山水甲天下', '风景', '[\"自然\",\"山水\"]', NULL, NULL, NULL, NULL, NULL, 1, '2025-09-27 13:53:14', '2025-09-27 13:53:14', '2025-09-27 13:53:14', 0, 0, NULL, NULL, NULL, NULL, 1);
INSERT INTO `picture` VALUES (1967609326446948355, 'https://example.com/food.jpg', '特色美食', '广州地道早茶', '美食', '[\"特产\",\"小吃\"]', NULL, NULL, NULL, NULL, NULL, 4, '2025-09-27 13:53:14', '2025-09-27 13:53:14', '2025-09-27 13:53:14', 0, 0, NULL, NULL, NULL, NULL, 4);
INSERT INTO `picture` VALUES (1967609326446948356, 'https://example.com/craft.jpg', '手工艺品', '传统竹编工艺', '手工艺', '[\"手工\",\"传统\"]', NULL, NULL, NULL, NULL, NULL, 6, '2025-09-27 13:53:14', '2025-09-27 13:53:14', '2025-09-27 13:53:14', 0, 0, NULL, NULL, NULL, NULL, 5);
INSERT INTO `picture` VALUES (1967609326446948357, 'https://example.com/hotel.jpg', '温泉酒店', '从化温泉度假村', '酒店', '[\"温泉\",\"度假\"]', NULL, NULL, NULL, NULL, NULL, 8, '2025-09-27 13:53:14', '2025-09-27 13:53:14', '2025-09-27 13:53:14', 0, 0, NULL, NULL, NULL, NULL, 7);
INSERT INTO `picture` VALUES (1967609326446948358, 'https://example.com/family.jpg', '亲子活动', '儿童乐园体验', '亲子', '[\"亲子\",\"娱乐\"]', NULL, NULL, NULL, NULL, NULL, 13, '2025-09-27 13:53:14', '2025-09-27 13:53:14', '2025-09-27 13:53:14', 0, 0, NULL, NULL, NULL, NULL, 8);
INSERT INTO `picture` VALUES (1967609326446948359, 'https://example.com/tea.jpg', '茶园风光', '高山茶园景色', '风景', '[\"茶叶\",\"自然\"]', NULL, NULL, NULL, NULL, NULL, 12, '2025-09-27 13:53:14', '2025-09-27 13:53:14', '2025-09-27 13:53:14', 0, 0, NULL, NULL, NULL, NULL, 9);
INSERT INTO `picture` VALUES (1967609326446948360, 'https://example.com/drive.jpg', '自驾路线', '川藏线风光', '旅行', '[\"自驾\",\"公路\"]', NULL, NULL, NULL, NULL, NULL, 11, '2025-09-27 13:53:14', '2025-09-27 13:53:14', '2025-09-27 13:53:14', 0, 0, NULL, NULL, NULL, NULL, 10);
INSERT INTO `picture` VALUES (1967609326446948361, 'https://example.com/history.jpg', '历史遗迹', '古城墙遗址', '文化', '[\"历史\",\"古迹\"]', NULL, NULL, NULL, NULL, NULL, 9, '2025-09-27 13:53:14', '2025-09-27 13:53:14', '2025-09-27 13:53:14', 0, 0, NULL, NULL, NULL, NULL, 11);
INSERT INTO `picture` VALUES (1967609326446948362, 'https://example.com/hotspring.jpg', '温泉体验', '露天温泉池', '休闲', '[\"温泉\",\"放松\"]', NULL, NULL, NULL, NULL, NULL, 1, '2025-09-27 13:53:14', '2025-09-27 13:53:14', '2025-09-27 13:53:14', 0, 0, NULL, NULL, NULL, NULL, 12);
INSERT INTO `picture` VALUES (1967609326446948363, 'https://example.com/mountain.jpg', '白云山', '广州白云山风景', '风景', '[\"登山\",\"自然\"]', NULL, NULL, NULL, NULL, NULL, 3, '2025-09-27 13:53:14', '2025-09-27 13:53:14', '2025-09-27 13:53:14', 0, 0, NULL, NULL, NULL, NULL, 6);
INSERT INTO `picture` VALUES (1967609326446948364, 'https://example.com/river.jpg', '珠江夜景', '珠江夜游风光', '城市', '[\"夜景\",\"河流\"]', NULL, NULL, NULL, NULL, NULL, 2, '2025-09-27 13:53:14', '2025-09-27 13:53:14', '2025-09-27 13:53:14', 0, 0, NULL, NULL, NULL, NULL, 3);
INSERT INTO `picture` VALUES (1967609326446948365, 'https://example.com/dimsum.jpg', '广式点心', '虾饺烧卖', '美食', '[\"点心\",\"粤菜\"]', NULL, NULL, NULL, NULL, NULL, 4, '2025-09-27 13:53:14', '2025-09-27 13:53:14', '2025-09-27 13:53:14', 0, 0, NULL, NULL, NULL, NULL, 4);
INSERT INTO `picture` VALUES (1967609326446948366, 'https://example.com/ceramic.jpg', '陶瓷作品', '手工陶瓷茶杯', '手工艺', '[\"陶瓷\",\"工艺品\"]', NULL, NULL, NULL, NULL, NULL, 6, '2025-09-27 13:53:14', '2025-09-27 13:53:14', '2025-09-27 13:53:14', 0, 0, NULL, NULL, NULL, NULL, 5);
INSERT INTO `picture` VALUES (1967609326446948367, 'https://example.com/fruit.jpg', '果园采摘', '有机苹果园', '农业', '[\"水果\",\"采摘\"]', NULL, NULL, NULL, NULL, NULL, 2, '2025-09-27 13:53:14', '2025-09-27 13:53:14', '2025-09-27 13:53:14', 0, 0, NULL, NULL, NULL, NULL, 3);
INSERT INTO `picture` VALUES (1967609326446948368, 'https://example.com/sunset.jpg', '海边日落', '三亚海滩日落', '风景', '[\"海滩\",\"日落\"]', NULL, NULL, NULL, NULL, NULL, 1, '2025-09-27 13:53:14', '2025-09-27 13:53:14', '2025-09-27 13:53:14', 0, 0, NULL, NULL, NULL, NULL, 1);
INSERT INTO `picture` VALUES (1971927283029336065, 'https://qq-1375584552.cos.ap-guangzhou.myqcloud.com/public/1971813431033851906/2025-09-27_HZc4J5HSCVhvNHOV.webp', '匹克球二等奖', NULL, NULL, NULL, 302264, 1279, 1706, 0.75, 'webp', 1971813431033851906, '2025-09-27 21:17:55', '2025-09-27 21:17:55', '2025-09-27 21:17:55', 0, 0, NULL, NULL, NULL, 'https://qq-1375584552.cos.ap-guangzhou.myqcloud.com/public/1971813431033851906/2025-09-27_HZc4J5HSCVhvNHOV_thumbnail.jpg', 0);
INSERT INTO `picture` VALUES (1971935064490852354, 'https://qq-1375584552.cos.ap-guangzhou.myqcloud.com/public/1971813431033851906/2025-09-27_xJIqcso60FtwefAf.webp', '匹克球二等奖.jpg', NULL, NULL, NULL, 302264, 1279, 1706, 0.75, 'webp', 1971813431033851906, '2025-09-27 21:48:50', '2025-09-27 21:48:50', '2025-09-27 21:48:50', 0, 1, '管理员自动过审', 1971813431033851906, '2025-09-27 21:48:51', 'https://qq-1375584552.cos.ap-guangzhou.myqcloud.com/public/1971813431033851906/2025-09-27_xJIqcso60FtwefAf_thumbnail.jpg', 0);
INSERT INTO `picture` VALUES (1971935875396616193, 'https://qq-1375584552.cos.ap-guangzhou.myqcloud.com/public/1971813431033851906/2025-09-27_rmkvKfnZ5eh6AJrl.webp', '匹克球第五.jpg', NULL, NULL, NULL, 600794, 1706, 1279, 1.33, 'webp', 1971813431033851906, '2025-09-27 21:52:04', '2025-09-27 21:52:04', '2025-09-27 21:52:04', 0, 1, '管理员自动过审', 1971813431033851906, '2025-09-27 21:52:04', 'https://qq-1375584552.cos.ap-guangzhou.myqcloud.com/public/1971813431033851906/2025-09-27_rmkvKfnZ5eh6AJrl_thumbnail.jpg', 0);
INSERT INTO `picture` VALUES (1971936186806910977, 'https://qq-1375584552.cos.ap-guangzhou.myqcloud.com/public/1971813431033851906/2025-09-27_iG68h4BpGZIPdzIF.webp', '匹克球第五.jpg', NULL, NULL, NULL, 600794, 1706, 1279, 1.33, 'webp', 1971813431033851906, '2025-09-27 21:53:18', '2025-09-27 21:53:18', '2025-09-27 21:53:18', 0, 1, '管理员自动过审', 1971813431033851906, '2025-09-27 21:53:18', 'https://qq-1375584552.cos.ap-guangzhou.myqcloud.com/public/1971813431033851906/2025-09-27_iG68h4BpGZIPdzIF_thumbnail.jpg', 0);
INSERT INTO `picture` VALUES (1972149713383567362, 'https://qq-1375584552.cos.ap-guangzhou.myqcloud.com/public/1971813431033851906/2025-09-28_AQJO4v7VIsWTk4OY.webp', '1.jpg', NULL, NULL, NULL, 265304, 577, 1016, 0.57, 'webp', 1971813431033851906, '2025-09-28 12:01:47', '2025-09-28 12:01:47', '2025-09-28 12:01:47', 0, 1, '管理员自动过审', 1971813431033851906, '2025-09-28 12:01:47', 'https://qq-1375584552.cos.ap-guangzhou.myqcloud.com/public/1971813431033851906/2025-09-28_AQJO4v7VIsWTk4OY_thumbnail.jpg', 0);
INSERT INTO `picture` VALUES (1972878285450530817, 'https://qq-1375584552.cos.ap-guangzhou.myqcloud.com/public/1971813431033851906/2025-09-30_SgLJe22EHqTQ7ot4.webp', '4ae08a67-0412-4b8c-9cd6-172fa7f44c1d.png', NULL, NULL, NULL, 67786, 618, 889, 0.7, 'webp', 1971813431033851906, '2025-09-30 12:16:52', '2025-09-30 12:16:52', '2025-09-30 12:16:52', 0, 1, '管理员自动过审', 1971813431033851906, '2025-09-30 12:16:52', 'https://qq-1375584552.cos.ap-guangzhou.myqcloud.com/public/1971813431033851906/2025-09-30_SgLJe22EHqTQ7ot4_thumbnail.png', 0);
INSERT INTO `picture` VALUES (1973989138267475969, 'https://qq-1375584552.cos.ap-guangzhou.myqcloud.com/public/1973988478897721345/2025-10-03_mANiiixr1Dauc67r.webp', '2025-03-14.png', NULL, NULL, NULL, 85316, 1920, 1020, 1.88, 'webp', 1973988478897721345, '2025-10-03 13:51:00', '2025-10-03 13:51:00', '2025-10-03 13:51:00', 0, 0, NULL, NULL, NULL, 'https://qq-1375584552.cos.ap-guangzhou.myqcloud.com/public/1973988478897721345/2025-10-03_mANiiixr1Dauc67r_thumbnail.png', 0);
INSERT INTO `picture` VALUES (1973989138267475970, 'https://qq-1375584552.cos.ap-guangzhou.myqcloud.com/public/1973987306786885634/2025-10-08_Em8Y8tyvGM3uvAiA.webp', 'user-avatar.jpg', NULL, NULL, NULL, 28198, 828, 904, 0.92, 'webp', 1973987306786885634, '2025-10-08 15:44:31', '2025-10-08 15:44:31', '2025-10-08 15:44:31', 0, 1, '管理员自动过审', 1973987306786885634, '2025-10-08 15:44:31', 'https://qq-1375584552.cos.ap-guangzhou.myqcloud.com/public/1973987306786885634/2025-10-08_Em8Y8tyvGM3uvAiA.webp', NULL);

-- ----------------------------
-- Table structure for post
-- ----------------------------
DROP TABLE IF EXISTS `post`;
CREATE TABLE `post`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL COMMENT '发帖用户ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '内容',
  `cover_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '封面图',
  `view_count` int NULL DEFAULT 0 COMMENT '浏览量',
  `like_count` int NULL DEFAULT 0 COMMENT '点赞数',
  `comment_count` int NULL DEFAULT 0 COMMENT '评论数',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态: 1-正常, 0-删除',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_delete` tinyint NULL DEFAULT 0,
  `category_id` int NULL DEFAULT 0 COMMENT '分类ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE,
  INDEX `idx_like_count`(`like_count` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 84 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '帖子表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of post
-- ----------------------------
INSERT INTO `post` VALUES (62, 15, '东京自由行全攻略：新手必看指南', '从成田机场交通到浅草寺打卡路线，详细分享7天6夜行程规划...', 'guide_tokyo.jpg', 12500, 842, 134, 1, '2024-08-15 14:30:00', '2024-09-20 09:15:00', 0, 1);
INSERT INTO `post` VALUES (63, 42, '曼谷街头美食地图：20家必吃摊贩', '实测推荐！从米其林推荐的Jay Fai到隐藏版芒果糯米饭...', 'bangkok_food.jpg', 8700, 1205, 98, 1, '2024-07-22 11:20:00', '2024-09-10 16:40:00', 0, 2);
INSERT INTO `post` VALUES (64, 88, '冰岛极光摄影技巧：参数设置全解析', '如何在零下15°C拍出极光舞动？附黑沙滩钻石冰钻石机位...', 'aurora_iceland.jpg', 21400, 3150, 287, 1, '2024-09-05 18:45:00', '2024-09-25 22:10:00', 0, 3);
INSERT INTO `post` VALUES (65, 33, '巴厘岛悬崖酒店测评：人均500的惊喜', '乌鲁瓦图区域三家网红酒店实测，无边泳池+私人海滩对比...', 'bali_hotel.jpg', 6800, 523, 76, 1, '2024-06-18 10:00:00', '2024-09-15 14:20:00', 0, 4);
INSERT INTO `post` VALUES (66, 67, '首尔明洞购物避坑指南', '化妆品真假辨别/退税技巧/设计师品牌店地图整理...', 'seoul_shopping.jpg', 9500, 687, 112, 1, '2024-08-30 16:50:00', '2024-09-22 11:05:00', 0, 5);
INSERT INTO `post` VALUES (67, 21, '京都红叶季路线规划：避开人潮秘籍', '分享三条小众枫叶观赏路线，包含夜间特别开放寺院...', 'kyoto_guide.jpg', 14200, 979, 156, 1, '2024-09-12 09:30:00', '2025-10-06 14:08:57', 0, 1);
INSERT INTO `post` VALUES (68, 56, '巴黎甜品探店：10家必尝马卡龙', '从百年老店Ladurée到本地人推荐的隐藏小店测评...', 'paris_dessert.jpg', 7300, 1542, 201, 1, '2024-07-05 14:15:00', '2024-09-18 10:30:00', 0, 2);
INSERT INTO `post` VALUES (69, 94, '新西兰南岛星空拍摄攻略', '蒂卡普湖最佳机位/光污染地图/银河拱桥拼接教程...', 'nz_stars.jpg', 18300, 2450, 178, 1, '2024-08-08 21:00:00', '2024-09-26 23:45:00', 0, 3);
INSERT INTO `post` VALUES (70, 29, '马尔代夫水屋选择指南', '对比六家度假村：浮潜环境/私密性/儿童设施详细评分...', 'maldives_villa.jpg', 11200, 832, 93, 1, '2024-06-25 17:40:00', '2024-09-16 08:50:00', 0, 4);
INSERT INTO `post` VALUES (71, 73, '伦敦古董市集淘宝攻略', 'Portobello Road市场砍价技巧/维多利亚时期首饰鉴别...', 'london_market.jpg', 6400, 421, 67, 1, '2024-07-30 12:25:00', '2024-09-19 14:15:00', 0, 5);
INSERT INTO `post` VALUES (72, 18, '台湾环岛骑行路线规划', '9天800公里装备清单+补给点地图+紧急情况处理...', 'taiwan_cycling.jpg', 7800, 598, 124, 1, '2024-08-22 08:45:00', '2024-09-21 17:20:00', 0, 1);
INSERT INTO `post` VALUES (73, 47, '大阪道顿堀隐藏美食清单', '避开游客的5家宝藏店：河豚火锅/元祖串炸/特制章鱼烧...', 'osaka_food.jpg', 9200, 1760, 189, 1, '2024-09-02 19:30:00', '2024-09-24 12:40:00', 0, 2);
INSERT INTO `post` VALUES (74, 82, '撒哈拉沙漠星空延时摄影', '帐篷营地选择/沙丘构图技巧/极端环境设备保护方案...', 'sahara_night.jpg', 15600, 2980, 245, 1, '2024-07-14 22:10:00', '2024-09-23 21:30:00', 0, 3);
INSERT INTO `post` VALUES (75, 37, '清迈森林树屋住宿体验', '住在树冠层的奇妙体验：昆虫防护/雨季注意事项/环保设计...', 'chiangmai_treehouse.jpg', 5500, 487, 81, 1, '2024-06-29 15:20:00', '2024-09-14 10:45:00', 0, 4);
INSERT INTO `post` VALUES (76, 64, '迪拜购物节血拼指南', '黄金市场防坑/免税店限时优惠/特色伴手礼推荐...', 'dubai_gold.jpg', 7200, 389, 58, 1, '2024-08-05 11:50:00', '2024-09-17 16:25:00', 0, 5);
INSERT INTO `post` VALUES (77, 25, '阿尔卑斯山徒步装备清单', '从登山杖选择到高原反应预防，超详细高山徒步准备指南...', 'alps_hiking.jpg', 10500, 754, 132, 1, '2024-09-08 07:30:00', '2024-09-25 09:50:00', 0, 1);
INSERT INTO `post` VALUES (78, 51, '越南会安古镇美食探索', '白玫瑰饺子制作体验/街头法棍三明治测评/特色咖啡地图...', 'hoian_food.jpg', 6800, 932, 143, 1, '2024-07-18 13:40:00', '2024-09-12 14:15:00', 0, 2);
INSERT INTO `post` VALUES (79, 89, '挪威峡湾无人机航拍技巧', '避开禁飞区/峡湾光线捕捉/运动模式拍摄瀑布全攻略...', 'norway_fjord.jpg', 13400, 2100, 167, 1, '2024-08-25 10:20:00', '2024-09-27 18:05:00', 0, 3);
INSERT INTO `post` VALUES (80, 31, '北海道温泉旅馆对比测评', '登别/洞爷湖/层云峡三大温泉区泡汤体验+怀石料理评分...', 'hokkaido_onsen.jpg', 8900, 645, 102, 1, '2024-06-15 16:00:00', '2024-09-11 11:30:00', 0, 4);
INSERT INTO `post` VALUES (81, 78, '米兰奥特莱斯购物路线', '交通方式/品牌分布图/限时折扣季攻略/退税陷阱提醒...', 'milan_outlet.jpg', 6100, 423, 71, 1, '2024-07-28 14:50:00', '2024-09-13 15:55:00', 0, 5);
INSERT INTO `post` VALUES (82, 1971813431033851906, '从化美食', '石锅鱼', 'https://qq-1375584552.cos.ap-guangzhou.myqcloud.com/public/1971813431033851906/2025-09-30_SgLJe22EHqTQ7ot4.webp', 0, 3, 1, 1, '2025-09-30 12:16:54', '2025-10-06 14:09:05', 0, 2);

-- ----------------------------
-- Table structure for post_tag
-- ----------------------------
DROP TABLE IF EXISTS `post_tag`;
CREATE TABLE `post_tag`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `post_id` bigint NOT NULL COMMENT '关联的帖子ID',
  `tag_id` bigint NOT NULL COMMENT '关联的标签ID',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `is_delete` tinyint NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_post_tag`(`post_id` ASC, `tag_id` ASC) USING BTREE COMMENT '防止重复关联',
  INDEX `idx_tag_id`(`tag_id` ASC) USING BTREE COMMENT '按标签查询帖子时需要',
  INDEX `idx_is_delete`(`is_delete` ASC) USING BTREE COMMENT '软删除索引'
) ENGINE = InnoDB AUTO_INCREMENT = 37 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '帖子与标签的关联关系' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of post_tag
-- ----------------------------
INSERT INTO `post_tag` VALUES (1, 1, 1, '2025-09-27 13:53:15', 0);
INSERT INTO `post_tag` VALUES (2, 1, 2, '2025-09-27 13:53:15', 0);
INSERT INTO `post_tag` VALUES (3, 1, 9, '2025-09-27 13:53:15', 0);
INSERT INTO `post_tag` VALUES (4, 2, 3, '2025-09-27 13:53:15', 0);
INSERT INTO `post_tag` VALUES (5, 3, 4, '2025-09-27 13:53:15', 0);
INSERT INTO `post_tag` VALUES (6, 3, 2, '2025-09-27 13:53:15', 0);
INSERT INTO `post_tag` VALUES (7, 4, 5, '2025-09-27 13:53:15', 0);
INSERT INTO `post_tag` VALUES (8, 5, 6, '2025-09-27 13:53:15', 0);
INSERT INTO `post_tag` VALUES (9, 5, 9, '2025-09-27 13:53:15', 0);
INSERT INTO `post_tag` VALUES (10, 6, 7, '2025-09-27 13:53:15', 0);
INSERT INTO `post_tag` VALUES (11, 7, 8, '2025-09-27 13:53:15', 0);
INSERT INTO `post_tag` VALUES (12, 8, 6, '2025-09-27 13:53:15', 0);
INSERT INTO `post_tag` VALUES (13, 8, 10, '2025-09-27 13:53:15', 0);
INSERT INTO `post_tag` VALUES (14, 9, 4, '2025-09-27 13:53:15', 0);
INSERT INTO `post_tag` VALUES (15, 10, 5, '2025-09-27 13:53:15', 0);
INSERT INTO `post_tag` VALUES (16, 11, 1, '2025-09-27 13:53:15', 0);
INSERT INTO `post_tag` VALUES (17, 11, 9, '2025-09-27 13:53:15', 0);
INSERT INTO `post_tag` VALUES (18, 12, 7, '2025-09-27 13:53:15', 0);
INSERT INTO `post_tag` VALUES (19, 13, 8, '2025-09-27 13:53:15', 0);
INSERT INTO `post_tag` VALUES (20, 14, 3, '2025-09-27 13:53:15', 0);
INSERT INTO `post_tag` VALUES (21, 14, 6, '2025-09-27 13:53:15', 0);
INSERT INTO `post_tag` VALUES (22, 15, 4, '2025-09-27 13:53:15', 0);
INSERT INTO `post_tag` VALUES (23, 56, 3, '2025-09-27 17:05:19', 0);
INSERT INTO `post_tag` VALUES (24, 56, 5, '2025-09-27 17:05:19', 0);
INSERT INTO `post_tag` VALUES (25, 59, 3, '2025-09-27 21:52:06', 0);
INSERT INTO `post_tag` VALUES (26, 59, 6, '2025-09-27 21:52:06', 0);
INSERT INTO `post_tag` VALUES (27, 60, 2, '2025-09-27 21:53:07', 0);
INSERT INTO `post_tag` VALUES (28, 61, 7, '2025-09-27 21:53:32', 0);
INSERT INTO `post_tag` VALUES (29, 61, 6, '2025-09-27 21:53:32', 0);
INSERT INTO `post_tag` VALUES (30, 82, 2, '2025-09-30 12:16:54', 0);
INSERT INTO `post_tag` VALUES (31, 83, 2, '2025-10-03 13:52:18', 0);
INSERT INTO `post_tag` VALUES (32, 83, 3, '2025-10-03 13:52:18', 0);
INSERT INTO `post_tag` VALUES (33, 83, 5, '2025-10-03 13:52:18', 0);
INSERT INTO `post_tag` VALUES (34, 83, 6, '2025-10-03 13:52:18', 0);
INSERT INTO `post_tag` VALUES (35, 83, 8, '2025-10-03 13:52:18', 0);
INSERT INTO `post_tag` VALUES (36, 83, 10, '2025-10-03 13:52:18', 0);

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `merchant_id` bigint NOT NULL COMMENT '所属商家ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商品名称',
  `category_id` bigint NULL DEFAULT NULL COMMENT '关联分类ID',
  `category` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品分类名称',
  `price` decimal(10, 2) NOT NULL COMMENT '价格',
  `original_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '原价(用于显示折扣)',
  `cover_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品主图',
  `images` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '商品图集(JSON数组)',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '商品描述',
  `specs` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '规格参数(JSON格式)',
  `stock` int NULL DEFAULT 0 COMMENT '库存',
  `sales` int NULL DEFAULT 0 COMMENT '销量',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态:1-上架,0-下架',
  `is_recommend` tinyint NULL DEFAULT 0 COMMENT '是否推荐',
  `weight` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '商品重量(kg)',
  `service_guarantee` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '服务保障(JSON格式)',
  `limit_per_user` int NULL DEFAULT 0 COMMENT '每人限购数量(0表示不限购)',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_delete` tinyint NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_merchant_id`(`merchant_id` ASC) USING BTREE,
  INDEX `idx_category_id`(`category_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_price`(`price` ASC) USING BTREE,
  INDEX `idx_sales`(`sales` ASC) USING BTREE,
  INDEX `idx_recommend`(`is_recommend` ASC) USING BTREE,
  INDEX `idx_merchant_status`(`merchant_id` ASC, `status` ASC) USING BTREE COMMENT '商家查询商品状态组合索引'
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES (1, 1, '招牌白切鸡', NULL, '招牌菜品', 68.00, 78.00, 'https://th.bing.com/th/id/OIP.abc123?w=400&h=300&rs=1&pid=ImgDetMain', '["https://th.bing.com/th/id/OIP.abc123?w=400&h=300&rs=1&pid=ImgDetMain","https://th.bing.com/th/id/OIP.def456?w=400&h=300&rs=1&pid=ImgDetMain"]', '选用优质三黄鸡，肉质鲜嫩，皮滑肉紧。配以秘制姜葱蘸料，回味无穷。是店内招牌菜品，深受食客喜爱。', '{"分量":"半只","口感":"鲜嫩","制作工艺":"传统白切"}', 50, 128, 1, 1, 0.80, '["现做现卖","30分钟上桌","不满意可退换"]', 3, '2025-10-17 18:30:00', '2025-10-17 18:30:00', 0);
INSERT INTO `product` VALUES (2, 1, '广式蒸排骨', NULL, '招牌菜品', 58.00, 68.00, 'https://th.bing.com/th/id/OIP.xyz789?w=400&h=300&rs=1&pid=ImgDetMain', '["https://th.bing.com/th/id/OIP.xyz789?w=400&h=300&rs=1&pid=ImgDetMain"]', '精选优质排骨，采用传统广式蒸制技法。肉质鲜嫩，骨香味美。搭配蒜蓉和豆豉，口感层次丰富。是粤式茶楼经典菜品。', '{"分量":"大份","口感":"鲜嫩","制作工艺":"传统蒸制"}', 40, 95, 1, 1, 0.60, '["现做现卖","30分钟上桌","不满意可退换"]', 3, '2025-10-17 18:32:00', '2025-10-17 18:32:00', 0);
INSERT INTO `product` VALUES (3, 1, '腊味煲仔饭', NULL, '主食', 48.00, 58.00, 'https://th.bing.com/th/id/OIP.ghi012?w=400&h=300&rs=1&pid=ImgDetMain', '["https://th.bing.com/th/id/OIP.ghi012?w=400&h=300&rs=1&pid=ImgDetMain"]', '传承广式腊味煲仔饭制作技艺。选用优质泰国香米，搭配广式腊肠、腊肉、腊鸭。饭粒干爽，锅巴香脆，腊味浓郁。', '{"分量":"一人份","口感":"香糯","制作工艺":"传统煲制"}', 60, 156, 1, 1, 0.50, '["现做现卖","25分钟上桌","不满意可退换"]', 3, '2025-10-17 18:34:00', '2025-10-17 18:34:00', 0);
INSERT INTO `product` VALUES (4, 1, '蒜蓉炒青菜', NULL, '素菜', 28.00, NULL, 'https://th.bing.com/th/id/OIP.jkl345?w=400&h=300&rs=1&pid=ImgDetMain', '["https://th.bing.com/th/id/OIP.jkl345?w=400&h=300&rs=1&pid=ImgDetMain"]', '选用新鲜蔬菜，配以蒜蓉快炒。保持蔬菜原味，口感清脆。是粤式菜品必备的素菜。可根据季节更换时蔬。', '{"分量":"小份","口感":"清脆","制作工艺":"快炒"}', 80, 89, 1, 0, 0.30, '["现做现卖","15分钟上桌","不满意可退换"]', 0, '2025-10-17 18:36:00', '2025-10-17 18:36:00', 0);
INSERT INTO `product` VALUES (5, 2, '江景大床房', NULL, '标准间', 388.00, 488.00, 'https://th.bing.com/th/id/OIP.mno678?w=800&h=600&rs=1&pid=ImgDetMain', '["https://th.bing.com/th/id/OIP.mno678?w=800&h=600&rs=1&pid=ImgDetMain","https://th.bing.com/th/id/OIP.pqr901?w=800&h=600&rs=1&pid=ImgDetMain"]', '豪华江景大床房，面积35平方米。配备1.8米大床，独立阳台可俯瞰流溪河美景。提供免费WiFi、洗漱用品、矿泉水等。', '{"房间面积":"35㎡","床型":"1.8米大床","楼层":"3-6层","江景":"是"}', 8, 42, 1, 1, 0.00, '["免费WiFi","免费停车","免费早餐","延迟退房至14点"]', 2, '2025-10-17 18:40:00', '2025-10-17 18:40:00', 0);
INSERT INTO `product` VALUES (6, 2, '江景双床房', NULL, '标准间', 388.00, 488.00, 'https://th.bing.com/th/id/OIP.stu234?w=800&h=600&rs=1&pid=ImgDetMain', '["https://th.bing.com/th/id/OIP.stu234?w=800&h=600&rs=1&pid=ImgDetMain","https://th.bing.com/th/id/OIP.vwx567?w=800&h=600&rs=1&pid=ImgDetMain"]', '舒适江景双床房，面积35平方米。配备两张1.2米单人床，适合家庭入住。独立阳台可欣赏流溪河美景。提供免费WiFi、洗漱用品等。', '{"房间面积":"35㎡","床型":"两张1.2米单人床","楼层":"3-6层","江景":"是"}', 6, 28, 1, 1, 0.00, '["免费WiFi","免费停车","免费早餐","延迟退房至14点"]', 2, '2025-10-17 18:42:00', '2025-10-17 18:42:00', 0);
INSERT INTO `product` VALUES (7, 2, '河景套房', NULL, '套房', 688.00, 888.00, 'https://th.bing.com/th/id/OIP.yza890?w=800&h=600&rs=1&pid=ImgDetMain', '["https://th.bing.com/th/id/OIP.yza890?w=800&h=600&rs=1&pid=ImgDetMain","https://th.bing.com/th/id/OIP.bcd123?w=800&h=600&rs=1&pid=ImgDetMain"]', '豪华河景套房，面积65平方米。卧室与客厅分区，配备1.8米大床和沙发。超大落地窗，180度河景视野。含独立衣帽间、浴缸等设施。', '{"房间面积":"65㎡","床型":"1.8米大床","楼层":"顶楼","江景":"180度"}', 3, 12, 1, 1, 0.00, '["免费WiFi","免费停车","免费早餐","延迟退房至14点","欢迎水果","免费下午茶"]', 1, '2025-10-17 18:44:00', '2025-10-17 18:44:00', 0);
INSERT INTO `product` VALUES (8, 3, '手工编织竹篮', NULL, '竹篮系列', 88.00, 118.00, 'https://th.bing.com/th/id/OIP.efg456?w=600&h=600&rs=1&pid=ImgDetMain', '["https://th.bing.com/th/id/OIP.efg456?w=600&h=600&rs=1&pid=ImgDetMain","https://th.bing.com/th/id/OIP.hij789?w=600&h=600&rs=1&pid=ImgDetMain"]', '采用优质楠竹手工编织，传统工艺制作。竹篮结构牢固，花纹精美。适合装水果、蔬菜、日用品等。环保天然，经久耐用。', '{"尺寸":"直径35cm","材质":"楠竹","工艺":"手工编织","重量":"0.5kg"}', 45, 67, 1, 1, 0.50, '["纯手工制作","包邮到家","7天无理由退货","支持定制尺寸"]', 5, '2025-10-17 18:48:00', '2025-10-17 18:48:00', 0);
INSERT INTO `product` VALUES (9, 3, '传统竹席', NULL, '竹席系列', 268.00, 338.00, 'https://th.bing.com/th/id/OIP.klm012?w=800&h=600&rs=1&pid=ImgDetMain', '["https://th.bing.com/th/id/OIP.klm012?w=800&h=600&rs=1&pid=ImgDetMain","https://th.bing.com/th/id/OIP.nop345?w=800&h=600&rs=1&pid=ImgDetMain"]', '选用优质楠竹，手工编织而成。竹丝细腻，表面光滑。凉爽透气，夏季使用舒适。多种尺寸可选：1.2米、1.5米、1.8米床。', '{"尺寸":"1.2米床","材质":"楠竹","工艺":"手工编织","厚度":"0.5cm","重量":"3kg"}', 32, 45, 1, 1, 3.00, '["纯手工制作","包邮到家","7天无理由退货","支持定制尺寸","免费保养指导"]', 3, '2025-10-17 18:50:00', '2025-10-17 18:50:00', 0);
INSERT INTO `product` VALUES (10, 3, '竹编装饰画', NULL, '装饰画系列', 128.00, 168.00, 'https://th.bing.com/th/id/OIP.qrs678?w=600&h=800&rs=1&pid=ImgDetMain', '["https://th.bing.com/th/id/OIP.qrs678?w=600&h=800&rs=1&pid=ImgDetMain","https://th.bing.com/th/id/OIP.tuv901?w=600&h=800&rs=1&pid=ImgDetMain"]', '精美的竹编装饰画，采用传统编织技法制作。图案多样：花鸟、山水、书法等。适合客厅、书房装饰。纯手工制作，独一无二。', '{"尺寸":"40x60cm","材质":"楠竹","工艺":"手工编织","图案":"花鸟","重量":"0.8kg"}', 28, 52, 1, 1, 0.80, '["纯手工制作","包邮到家","7天无理由退货","支持定制图案","配精美包装"]', 2, '2025-10-17 18:52:00', '2025-10-17 18:52:00', 0);
INSERT INTO `product` VALUES (11, 4, '从化荔枝（3斤装）', NULL, '荔枝系列', 45.00, 60.00, 'https://th.bing.com/th/id/OIP.wxy234?w=600&h=600&rs=1&pid=ImgDetMain', '["https://th.bing.com/th/id/OIP.wxy234?w=600&h=600&rs=1&pid=ImgDetMain","https://th.bing.com/th/id/OIP.zab567?w=600&h=600&rs=1&pid=ImgDetMain"]', '正宗从化荔枝，有机种植，无农药残留。果实饱满，果肉鲜甜多汁。现摘现发，保证新鲜。支持快递配送，配送范围：珠三角地区。', '{"重量":"3斤","品种":"妃子笑","产地":"从化本地","包装":"精美礼盒","保质期":"3天"}', 200, 156, 1, 1, 1.50, '["有机认证","现摘现发","快递配送","坏果包赔","团购优惠"]', 0, '2025-10-17 18:56:00', '2025-10-17 18:56:00', 0);
INSERT INTO `product` VALUES (12, 4, '新鲜龙眼（5斤装）', NULL, '龙眼系列', 68.00, 88.00, 'https://th.bing.com/th/id/OIP.cde890?w=600&h=600&rs=1&pid=ImgDetMain', '["https://th.bing.com/th/id/OIP.cde890?w=600&h=600&rs=1&pid=ImgDetMain"]', '精选从化龙眼，有机种植，果实大颗。果肉晶莹剔透，口感清甜。现摘现发，新鲜直达。支持快递配送和现场采摘。', '{"重量":"5斤","品种":"石硖龙眼","产地":"从化本地","包装":"精美礼盒","保质期":"5天"}', 150, 89, 1, 0, 2.50, '["有机认证","现摘现发","快递配送","坏果包赔","团购优惠"]', 0, '2025-10-17 18:58:00', '2025-10-17 18:58:00', 0);
INSERT INTO `product` VALUES (13, 4, '果园采摘体验券', NULL, '体验券', 25.00, NULL, 'https://th.bing.com/th/id/OIP.fgh123?w=600&h=600&rs=1&pid=ImgDetMain', '["https://th.bing.com/th/id/OIP.fgh123?w=600&h=600&rs=1&pid=ImgDetMain","https://th.bing.com/th/id/OIP.ijk456?w=600&h=600&rs=1&pid=ImgDetMain"]', '果园采摘体验券，可入园采摘并带走2斤水果。体验田园乐趣，亲近自然。适用季节：5-9月。需提前预约。包含：入园门票、采摘指导、2斤水果。', '{"含2斤水果":"是","适用季节":"5-9月","有效期":"1个月","需预约":"是"}', 50, 123, 1, 1, 0.00, '["体验券","支持预约","团体优惠","现场指导","适合亲子"]', 5, '2025-10-17 19:00:00', '2025-10-17 19:00:00', 0);
INSERT INTO `product` VALUES (14, 5, '流溪河日游船票', NULL, '船票', 68.00, 88.00, 'https://th.bing.com/th/id/OIP.lmn789?w=800&h=600&rs=1&pid=ImgDetMain', '["https://th.bing.com/th/id/OIP.lmn789?w=800&h=600&rs=1&pid=ImgDetMain","https://th.bing.com/th/id/OIP.opq012?w=800&h=600&rs=1&pid=ImgDetMain"]', '流溪河日游观光船票。行程约1.5小时，沿途欣赏山水风光。配备专业导游讲解，安全设备齐全。适合家庭出游、团建活动。', '{"时长":"1.5小时","路线":"标准路线","导游":"配备","时段":"08:30-17:30"}', 100, 456, 1, 1, 0.00, '["安全设备齐全","配备导游","儿童优惠","团体优惠","雨天可延期"]', 0, '2025-10-17 19:04:00', '2025-10-17 19:04:00', 0);
INSERT INTO `product` VALUES (15, 5, '流溪河夜游船票', NULL, '船票', 88.00, 108.00, 'https://th.bing.com/th/id/OIP.rst345?w=800&h=600&rs=1&pid=ImgDetMain', '["https://th.bing.com/th/id/OIP.rst345?w=800&h=600&rs=1&pid=ImgDetMain","https://th.bing.com/th/id/OIP.uvw678?w=800&h=600&rs=1&pid=ImgDetMain"]', '流溪河夜游观光船票。行程约2小时，欣赏夜景灯光秀。船上配有音响设备，提供小食茶水。浪漫体验，适合情侣、朋友聚会。', '{"时长":"2小时","路线":"夜景路线","导游":"配备","时段":"19:00-21:00","灯光":"配备"}', 60, 234, 1, 1, 0.00, '["安全设备齐全","配备导游","配备灯光","小食茶水","雨天可延期","儿童优惠"]', 0, '2025-10-17 19:06:00', '2025-10-17 19:06:00', 0);
INSERT INTO `product` VALUES (16, 5, '包船服务（3小时）', NULL, '包船服务', 680.00, 880.00, 'https://th.bing.com/th/id/OIP.xyz901?w=800&h=600&rs=1&pid=ImgDetMain', '["https://th.bing.com/th/id/OIP.xyz901?w=800&h=600&rs=1&pid=ImgDetMain"]', '包船服务，适合团体出游、聚会活动。可容纳30人，时长3小时。可根据需求定制路线。含导游、茶水、小食。需提前预约。', '{"时长":"3小时","载客量":"30人","路线":"可定制","导游":"配备","茶水":"配备","小食":"配备"}', 5, 32, 1, 0, 0.00, '["安全设备齐全","配备导游","可定制路线","团体优惠","需提前预约","雨天可延期"]', 1, '2025-10-17 19:08:00', '2025-10-17 19:08:00', 0);

-- ----------------------------
-- Table structure for product_category
-- ----------------------------
DROP TABLE IF EXISTS `product_category`;
CREATE TABLE `product_category`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `merchant_type` tinyint NOT NULL COMMENT '商家类型:1-美食,2-工艺品...',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类名称',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '分类图标',
  `sort` int NULL DEFAULT 0 COMMENT '排序值',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_merchant_type`(`merchant_type` ASC) USING BTREE,
  INDEX `idx_sort`(`sort` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品分类表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of product_category
-- ----------------------------

-- ----------------------------
-- Table structure for product_review
-- ----------------------------
DROP TABLE IF EXISTS `product_review`;
CREATE TABLE `product_review`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `product_id` bigint NOT NULL COMMENT '商品ID',
  `order_id` bigint NOT NULL COMMENT '订单ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `rating` tinyint NOT NULL COMMENT '评分(1-5)',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '评价内容',
  `images` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '评价图片(JSON数组)',
  `is_anonymous` tinyint NULL DEFAULT 0 COMMENT '是否匿名:1-是,0-否',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态:1-显示,0-隐藏',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_product_id`(`product_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_order_id`(`order_id` ASC) USING BTREE,
  INDEX `idx_rating`(`rating` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品评价表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of product_review
-- ----------------------------

-- ----------------------------
-- Table structure for scenic_spot
-- ----------------------------
DROP TABLE IF EXISTS `scenic_spot`;
CREATE TABLE `scenic_spot`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '景点名称',
  `introduction` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '详细介绍',
  `cover_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '封面图URL',
  `message_wall_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '留言墙标题',
  `message_wall_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '留言墙描述',
  `location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '具体位置',
  `longitude` decimal(9, 6) NULL DEFAULT NULL COMMENT '经度',
  `latitude` decimal(9, 6) NULL DEFAULT NULL COMMENT '纬度',
  `tags` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标签（JSON数组或逗号分隔）',
  `open_hours` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '开放时间',
  `ticket_info` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '票务信息',
  `rating` decimal(3, 1) NULL DEFAULT 0.0 COMMENT '平均评分',
  `heat_value` int NULL DEFAULT 0 COMMENT '热度值',
  `view_count` int NULL DEFAULT 0 COMMENT '浏览量',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_delete` tinyint NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_heat_value`(`heat_value` ASC) USING BTREE,
  INDEX `idx_rating`(`rating` ASC) USING BTREE,
  INDEX `idx_location`(`longitude` ASC, `latitude` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '景点/目的地信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of scenic_spot
-- ----------------------------
INSERT INTO `scenic_spot` VALUES (1, '白云山', '广州著名风景区，有\"羊城第一秀\"之称', 'baiyun.jpg', NULL, NULL, '广州市白云区', 113.297000, 23.181000, '[\"登山\",\"自然\"]', NULL, NULL, 0.0, 0, 0, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);
INSERT INTO `scenic_spot` VALUES (2, '陈家祠', '岭南建筑艺术的代表作', 'chenjiaci.jpg', NULL, NULL, '广州市荔湾区', 113.244000, 23.130000, '[\"历史\",\"文化\"]', NULL, NULL, 0.0, 0, 0, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);
INSERT INTO `scenic_spot` VALUES (3, '珠江夜游', '欣赏广州夜景的最佳方式', 'pearl_river.jpg', NULL, NULL, '广州市天河区', 113.327000, 23.116000, '[\"夜景\",\"游船\"]', NULL, NULL, 0.0, 0, 0, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);
INSERT INTO `scenic_spot` VALUES (4, '长隆欢乐世界', '大型主题游乐园', 'chimelong.jpg', NULL, NULL, '广州市番禺区', 113.315000, 22.995000, '[\"游乐场\",\"亲子\"]', NULL, NULL, 0.0, 0, 0, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);
INSERT INTO `scenic_spot` VALUES (5, '沙面岛', '欧陆风情建筑群', 'shamian.jpg', NULL, NULL, '广州市荔湾区', 113.239000, 23.107000, '[\"历史\",\"建筑\"]', NULL, NULL, 0.0, 0, 0, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);
INSERT INTO `scenic_spot` VALUES (6, '从化温泉', '著名温泉度假区', 'conghua_hotspring.jpg', NULL, NULL, '广州市从化区', 113.587000, 23.648000, '[\"温泉\",\"度假\"]', NULL, NULL, 0.0, 0, 0, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);
INSERT INTO `scenic_spot` VALUES (7, '越秀公园', '广州最大的公园', 'yuexiu.jpg', NULL, NULL, '广州市越秀区', 113.265000, 23.139000, '[\"公园\",\"休闲\"]', NULL, NULL, 0.0, 0, 0, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);
INSERT INTO `scenic_spot` VALUES (8, '广州塔', '广州地标建筑', 'canton_tower.jpg', NULL, NULL, '广州市海珠区', 113.325000, 23.106000, '[\"地标\",\"现代\"]', NULL, NULL, 0.0, 0, 0, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);
INSERT INTO `scenic_spot` VALUES (9, '岭南印象园', '体验岭南文化', 'lingnan.jpg', NULL, NULL, '广州市番禺区', 113.395000, 23.035000, '[\"文化\",\"民俗\"]', NULL, NULL, 0.0, 0, 0, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);
INSERT INTO `scenic_spot` VALUES (10, '莲花山', '有古采石场遗址', 'lianhua.jpg', NULL, NULL, '广州市番禺区', 113.496000, 22.999000, '[\"登山\",\"历史\"]', NULL, NULL, 0.0, 0, 0, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);
INSERT INTO `scenic_spot` VALUES (11, '宝墨园', '岭南园林建筑', 'baomo.jpg', NULL, NULL, '广州市番禺区', 113.398000, 22.940000, '[\"园林\",\"文化\"]', NULL, NULL, 0.0, 0, 0, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);
INSERT INTO `scenic_spot` VALUES (12, '南沙湿地公园', '观鸟胜地', 'nansha.jpg', NULL, NULL, '广州市南沙区', 113.602000, 22.796000, '[\"自然\",\"湿地\"]', NULL, NULL, 0.0, 0, 0, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);
INSERT INTO `scenic_spot` VALUES (13, '石门国家森林公园', '四季花海', 'shimen.jpg', NULL, NULL, '广州市从化区', 113.726000, 23.744000, '[\"自然\",\"公园\"]', NULL, NULL, 0.0, 0, 0, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);
INSERT INTO `scenic_spot` VALUES (14, '中山纪念堂', '纪念孙中山先生', 'sun_yat_sen.jpg', NULL, NULL, '广州市越秀区', 113.264000, 23.133000, '[\"历史\",\"纪念\"]', NULL, NULL, 0.0, 0, 0, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);
INSERT INTO `scenic_spot` VALUES (15, '海珠湖公园', '城市中央湿地', 'haizhu_lake.jpg', NULL, NULL, '广州市海珠区', 113.327000, 23.083000, '[\"公园\",\"湿地\"]', NULL, NULL, 0.0, 0, 0, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);

-- ----------------------------
-- Table structure for space
-- ----------------------------
DROP TABLE IF EXISTS `space`;
CREATE TABLE `space`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `space_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '空间名称',
  `space_level` int NULL DEFAULT 0 COMMENT '空间级别：0-普通版 1-专业版 2-旗舰版',
  `max_size` bigint NULL DEFAULT 0 COMMENT '空间图片的最大总大小',
  `max_count` bigint NULL DEFAULT 0 COMMENT '空间图片的最大数量',
  `total_size` bigint NULL DEFAULT 0 COMMENT '当前空间下图片的总大小',
  `total_count` bigint NULL DEFAULT 0 COMMENT '当前空间下的图片数量',
  `user_id` bigint NOT NULL COMMENT '创建用户 id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `edit_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '编辑时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_space_level`(`space_level` ASC) USING BTREE,
  INDEX `idx_space_name`(`space_name` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '空间' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of space
-- ----------------------------
INSERT INTO `space` VALUES (1, '公共空间', 0, 1073741824, 1000, 0, 0, 1, '2025-09-27 13:53:14', '2025-09-27 13:53:14', '2025-09-27 13:53:14', 0);
INSERT INTO `space` VALUES (2, '专业空间', 1, 5368709120, 5000, 0, 0, 1, '2025-09-27 13:53:14', '2025-09-27 13:53:14', '2025-09-27 13:53:14', 0);
INSERT INTO `space` VALUES (3, '旅行相册', 0, 2147483648, 2000, 0, 0, 2, '2025-09-27 13:53:14', '2025-09-27 13:53:14', '2025-09-27 13:53:14', 0);
INSERT INTO `space` VALUES (4, '美食图库', 1, 5368709120, 5000, 0, 0, 4, '2025-09-27 13:53:14', '2025-09-27 13:53:14', '2025-09-27 13:53:14', 0);
INSERT INTO `space` VALUES (5, '手工艺集', 0, 1073741824, 1000, 0, 0, 6, '2025-09-27 13:53:14', '2025-09-27 13:53:14', '2025-09-27 13:53:14', 0);
INSERT INTO `space` VALUES (6, '风景摄影', 2, 10737418240, 10000, 0, 0, 3, '2025-09-27 13:53:14', '2025-09-27 13:53:14', '2025-09-27 13:53:14', 0);
INSERT INTO `space` VALUES (7, '酒店空间', 1, 5368709120, 5000, 0, 0, 8, '2025-09-27 13:53:14', '2025-09-27 13:53:14', '2025-09-27 13:53:14', 0);
INSERT INTO `space` VALUES (8, '亲子空间', 0, 1073741824, 1000, 0, 0, 13, '2025-09-27 13:53:14', '2025-09-27 13:53:14', '2025-09-27 13:53:14', 0);
INSERT INTO `space` VALUES (9, '茶文化', 0, 1073741824, 1000, 0, 0, 12, '2025-09-27 13:53:14', '2025-09-27 13:53:14', '2025-09-27 13:53:14', 0);
INSERT INTO `space` VALUES (10, '自驾游记录', 1, 5368709120, 5000, 0, 0, 11, '2025-09-27 13:53:14', '2025-09-27 13:53:14', '2025-09-27 13:53:14', 0);
INSERT INTO `space` VALUES (11, '历史遗迹', 0, 1073741824, 1000, 0, 0, 9, '2025-09-27 13:53:14', '2025-09-27 13:53:14', '2025-09-27 13:53:14', 0);
INSERT INTO `space` VALUES (12, '温泉体验', 1, 5368709120, 5000, 0, 0, 1, '2025-09-27 13:53:14', '2025-09-27 13:53:14', '2025-09-27 13:53:14', 0);

-- ----------------------------
-- Table structure for strategy
-- ----------------------------
DROP TABLE IF EXISTS `strategy`;
CREATE TABLE `strategy`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '攻略内容（富文本）',
  `cover_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '封面图',
  `user_id` bigint NOT NULL COMMENT '作者ID',
  `view_count` int NULL DEFAULT 0,
  `like_count` int NULL DEFAULT 0,
  `favorite_count` int NULL DEFAULT 0,
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_delete` tinyint NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_view_count`(`view_count` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '旅游攻略/游记表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of strategy
-- ----------------------------
INSERT INTO `strategy` VALUES (1, '广州美食攻略', '早茶推荐：点都德、陶陶居...', 'food_guide.jpg', 3, 0, 0, 0, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);
INSERT INTO `strategy` VALUES (2, '从化温泉指南', '精选三家温泉酒店对比...', 'hotspring_guide.jpg', 1, 0, 0, 0, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);
INSERT INTO `strategy` VALUES (3, '亲子游乐园推荐', '适合不同年龄段孩子的乐园...', 'family_guide.jpg', 13, 0, 0, 0, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);
INSERT INTO `strategy` VALUES (4, '自驾游装备清单', '长途自驾必备物品...', 'drive_guide.jpg', 11, 0, 0, 0, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);
INSERT INTO `strategy` VALUES (5, '广州摄影地点', '十大最佳摄影打卡点...', 'photo_guide.jpg', 2, 0, 0, 0, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);
INSERT INTO `strategy` VALUES (6, '历史遗迹探访', '岭南文化历史遗迹指南...', 'history_guide.jpg', 9, 0, 0, 0, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);
INSERT INTO `strategy` VALUES (7, '手工艺体验', '传统手工艺DIY工坊...', 'craft_guide.jpg', 6, 0, 0, 0, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);
INSERT INTO `strategy` VALUES (8, '茶叶品鉴指南', '英德红茶选购与冲泡...', 'tea_guide.jpg', 12, 0, 0, 0, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);
INSERT INTO `strategy` VALUES (9, '珠江夜游攻略', '不同游船路线对比...', 'river_guide.jpg', 1, 0, 0, 0, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);
INSERT INTO `strategy` VALUES (10, '亲子酒店测评', '五家亲子酒店实地体验...', 'hotel_guide.jpg', 8, 0, 0, 0, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);
INSERT INTO `strategy` VALUES (11, '广式点心制作', '在家制作正宗广式点心...', 'dimsum_guide.jpg', 4, 0, 0, 0, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);
INSERT INTO `strategy` VALUES (12, '秋季登山路线', '广州周边登山路线推荐...', 'hiking_guide.jpg', 1, 0, 0, 0, '2025-09-27 13:53:28', '2025-09-27 13:53:28', 0);

-- ----------------------------
-- Table structure for tag
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '标签名称（如\"温泉\"、\"从化\"）',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_delete` tinyint NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_name`(`name` ASC) USING BTREE COMMENT '确保标签名唯一'
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统标签库' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tag
-- ----------------------------
INSERT INTO `tag` VALUES (1, '温泉', '2025-09-27 13:53:15', '2025-09-27 13:53:15', 0);
INSERT INTO `tag` VALUES (2, '从化', '2025-09-27 13:53:15', '2025-09-27 13:53:15', 0);
INSERT INTO `tag` VALUES (3, '手工艺', '2025-09-27 13:53:15', '2025-09-27 13:53:15', 0);
INSERT INTO `tag` VALUES (4, '摄影', '2025-09-27 13:53:15', '2025-09-27 13:53:15', 0);
INSERT INTO `tag` VALUES (5, '美食', '2025-09-27 13:53:15', '2025-09-27 13:53:15', 0);
INSERT INTO `tag` VALUES (6, '亲子', '2025-09-27 13:53:15', '2025-09-27 13:53:15', 0);
INSERT INTO `tag` VALUES (7, '自驾游', '2025-09-27 13:53:15', '2025-09-27 13:53:15', 0);
INSERT INTO `tag` VALUES (8, '历史', '2025-09-27 13:53:15', '2025-09-27 13:53:15', 0);
INSERT INTO `tag` VALUES (9, '酒店', '2025-09-27 13:53:15', '2025-09-27 13:53:15', 0);
INSERT INTO `tag` VALUES (10, '购物', '2025-09-27 13:53:15', '2025-09-27 13:53:15', 0);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_account` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '账号',
  `user_password` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `user_name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `user_avatar` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户头像',
  `user_profile` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户简介',
  `user_role` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user' COMMENT '用户角色：user/admin/merchant',
  `edit_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '编辑时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_account`(`user_account` ASC) USING BTREE,
  INDEX `idx_user_name`(`user_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1983709049649967106 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1971813431033851906, 'lqlq', '44350efcdd5b9e59474990ea87c46a2e', '无名', NULL, NULL, 'admin', '2025-09-27 13:45:31', '2025-09-27 13:45:31', '2025-09-27 21:31:28', 0);
INSERT INTO `user` VALUES (1971813431033851907, 'user1', 'e10adc3949ba59abbe56e057f20f883e', '张三', 'avatar1.jpg', '旅游爱好者', 'user', '2025-09-27 13:53:14', '2025-09-27 13:53:14', '2025-09-30 18:54:55', 1);
INSERT INTO `user` VALUES (1971813431033851908, 'user2', 'e10adc3949ba59abbe56e057f20f883e', '李五', 'avatar2.jpg', '摄影达人', 'user', '2025-09-27 13:53:14', '2025-09-27 13:53:14', '2025-10-23 16:53:23', 0);
INSERT INTO `user` VALUES (1971813431033851909, 'user3', 'e10adc3949ba59abbe56e057f20f883e', '王五', 'avatar3.jpg', '美食探索者', 'user', '2025-09-27 13:53:14', '2025-09-27 13:53:14', '2025-09-27 13:53:14', 0);
INSERT INTO `user` VALUES (1971813431033851910, 'merchant1', 'e10adc3949ba59abbe56e057f20f883e', '李记特产', 'shop_logo1.jpg', '本地特产专卖', 'merchant', '2025-09-27 13:53:14', '2025-09-27 13:53:14', '2025-09-27 13:53:14', 0);
INSERT INTO `user` VALUES (1971813431033851911, 'merchant2', 'e10adc3949ba59abbe56e057f20f883e', '农家果园', 'shop_logo2.jpg', '有机水果供应商', 'merchant', '2025-09-27 13:53:14', '2025-09-27 13:53:14', '2025-09-27 13:53:14', 0);
INSERT INTO `user` VALUES (1971813431033851912, 'merchant3', 'e10adc3949ba59abbe56e057f20f883e', '手工艺坊', 'shop_logo3.jpg', '传统手工艺品', 'merchant', '2025-09-27 13:53:14', '2025-09-27 13:53:14', '2025-09-27 13:53:14', 0);
INSERT INTO `user` VALUES (1971813431033851913, 'admin1', 'e10adc3949ba59abbe56e057f20f883e', '系统管理员', 'admin_avatar.png', '平台管理员', 'admin', '2025-09-27 13:53:14', '2025-09-27 13:53:14', '2025-09-27 13:53:14', 0);
INSERT INTO `user` VALUES (1971813431033851914, 'user4', 'e10adc3949ba59abbe56e057f20f883e', '赵六', 'avatar4.jpg', '户外运动爱好者', 'user', '2025-09-27 13:53:14', '2025-09-27 13:53:14', '2025-09-27 13:53:14', 0);
INSERT INTO `user` VALUES (1971813431033851915, 'user5', 'e10adc3949ba59abbe56e057f20f883e', '钱七', 'avatar5.jpg', '文化历史研究者', 'user', '2025-09-27 13:53:14', '2025-09-27 13:53:14', '2025-09-27 13:53:14', 0);
INSERT INTO `user` VALUES (1971813431033851916, 'merchant4', 'e10adc3949ba59abbe56e057f20f883e', '粤菜馆', 'shop_logo4.jpg', '地道粤菜', 'merchant', '2025-09-27 13:53:14', '2025-09-27 13:53:14', '2025-09-27 13:53:14', 0);
INSERT INTO `user` VALUES (1971813431033851917, 'user6', 'e10adc3949ba59abbe56e057f20f883e', '孙八', 'avatar6.jpg', '自驾游爱好者', 'user', '2025-09-27 13:53:14', '2025-09-27 13:53:14', '2025-09-27 13:53:14', 0);
INSERT INTO `user` VALUES (1971813431033851918, 'merchant5', 'e10adc3949ba59abbe56e057f20f883e', '茶庄', 'shop_logo5.jpg', '高山茶叶', 'merchant', '2025-09-27 13:53:14', '2025-09-27 13:53:14', '2025-09-27 13:53:14', 0);
INSERT INTO `user` VALUES (1971813431033851919, 'user7', 'e10adc3949ba59abbe56e057f20f883e', '周九', 'avatar7.jpg', '亲子旅行达人', 'user', '2025-09-27 13:53:14', '2025-09-27 13:53:14', '2025-09-27 13:53:14', 0);
INSERT INTO `user` VALUES (1971813431033851920, 'user8', 'e10adc3949ba59abbe56e057f20f883e', '吴十', 'avatar8.jpg', '酒店试睡员', 'user', '2025-09-27 13:53:14', '2025-09-27 13:53:14', '2025-09-27 13:53:14', 0);
INSERT INTO `user` VALUES (1971813431033851921, 'merchant6', 'e10adc3949ba59abbe56e057f20f883e', '陶艺工坊', 'shop_logo6.jpg', '手工陶瓷制品', 'merchant', '2025-09-27 13:53:14', '2025-09-27 13:53:14', '2025-09-27 13:53:14', 0);
INSERT INTO `user` VALUES (1972994847960481793, 'lqlqlq', '44350efcdd5b9e59474990ea87c46a2e', '无名', NULL, NULL, 'admin', '2025-09-30 20:00:02', '2025-09-30 20:00:02', '2025-10-07 16:15:41', 0);
INSERT INTO `user` VALUES (1973987306786885634, 'xiao', '44350efcdd5b9e59474990ea87c46a2e', '无名', NULL, NULL, 'admin', '2025-10-03 13:43:43', '2025-10-03 13:43:43', '2025-10-07 16:15:41', 0);
INSERT INTO `user` VALUES (1973988478897721345, '55555555555555555', '44350efcdd5b9e59474990ea87c46a2e', '无名', NULL, NULL, 'admin', '2025-10-03 13:48:22', '2025-10-03 13:48:22', '2025-10-07 16:15:41', 0);
INSERT INTO `user` VALUES (1979218076950401026, '123', '44350efcdd5b9e59474990ea87c46a2e', NULL, NULL, NULL, 'user', '2025-10-18 00:08:56', '2025-10-18 00:08:56', '2025-10-18 00:08:56', 0);
INSERT INTO `user` VALUES (1982767001783336962, 'xiao1', '44350efcdd5b9e59474990ea87c46a2e', '无名', NULL, NULL, 'user', '2025-10-27 19:11:05', '2025-10-27 19:11:05', '2025-10-27 19:11:05', 0);
INSERT INTO `user` VALUES (1983709049649967105, '阿迪王', '44350efcdd5b9e59474990ea87c46a2e', '挖的', '阿瓦达', '', 'merchant', '2025-10-30 09:34:27', '2025-10-30 09:34:27', '2025-10-30 09:34:27', 0);

SET FOREIGN_KEY_CHECKS = 1;
