/*
 Navicat Premium Data Transfer

 Source Server         : mac
 Source Server Type    : MySQL
 Source Server Version : 80015
 Source Host           : localhost:3306
 Source Schema         : dbapp2

 Target Server Type    : MySQL
 Target Server Version : 80015
 File Encoding         : 65001

 Date: 17/04/2019 21:13:02
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin_user
-- ----------------------------
DROP TABLE IF EXISTS `admin_user`;
CREATE TABLE `admin_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `in_time` datetime NOT NULL,
  `role_id` int(11) NOT NULL,
  `tag_id` int(11) DEFAULT NULL,
  `department` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `username` (`username`) USING BTREE,
  KEY `role_id` (`role_id`) USING BTREE,
  CONSTRAINT `admin_user_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of admin_user
-- ----------------------------
BEGIN;
INSERT INTO `admin_user` VALUES (1, 'admin', '$2a$10$wr5wNPtdAYCtR7pJHVjzm.duC3v2d3tXympYz171RgH7CZCzHGJZm', '2018-11-11 11:11:11', 1, 0, '', '', '');
INSERT INTO `admin_user` VALUES (19, '于富洋', '$2a$10$UKd0T1JulD8PpnCryHjr4eBM8mw5cSXUYcIpcJln5NwLM3b7bP4M2', '2019-04-03 03:19:24', 2, 20, '网络安全学院', '122334455', '1776972921@qq.com');
COMMIT;

-- ----------------------------
-- Table structure for code
-- ----------------------------
DROP TABLE IF EXISTS `code`;
CREATE TABLE `code` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `in_time` datetime NOT NULL,
  `expire_time` datetime NOT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `used` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `code` (`code`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  CONSTRAINT `code_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for collect
-- ----------------------------
DROP TABLE IF EXISTS `collect`;
CREATE TABLE `collect` (
  `topic_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `in_time` datetime NOT NULL,
  KEY `topic_id` (`topic_id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  CONSTRAINT `collect_ibfk_1` FOREIGN KEY (`topic_id`) REFERENCES `topic` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `collect_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `topic_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `in_time` datetime NOT NULL,
  `comment_id` int(11) DEFAULT NULL,
  `up_ids` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `topic_id` (`topic_id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for document
-- ----------------------------
DROP TABLE IF EXISTS `document`;
CREATE TABLE `document` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `document_class` varchar(255) NOT NULL,
  `document_type` varchar(255) NOT NULL,
  `document_classify` varchar(255) NOT NULL,
  `document_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `in_time` datetime NOT NULL,
  `url` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of document
-- ----------------------------
BEGIN;
INSERT INTO `document` VALUES (1, '明御', '安全网关', '安装', '网关安装说明', '2019-04-16 07:53:09', 'MY/AQWG/install', 'http://127.0.0.1:8080/static/upload/MY/AQWG/install/java开发_程鸿志-1555401189450.pdf');
COMMIT;

-- ----------------------------
-- Table structure for flyway_schema_history
-- ----------------------------
DROP TABLE IF EXISTS `flyway_schema_history`;
CREATE TABLE `flyway_schema_history` (
  `installed_rank` int(11) NOT NULL,
  `version` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `description` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `script` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `checksum` int(11) DEFAULT NULL,
  `installed_by` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `installed_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `execution_time` int(11) NOT NULL,
  `success` tinyint(1) NOT NULL,
  PRIMARY KEY (`installed_rank`) USING BTREE,
  KEY `flyway_schema_history_s_idx` (`success`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of flyway_schema_history
-- ----------------------------
BEGIN;
INSERT INTO `flyway_schema_history` VALUES (1, '1', 'initialize', 'SQL', 'V1__initialize.sql', -1378939418, 'root', '2019-03-06 15:21:41', 789, 1);
COMMIT;

-- ----------------------------
-- Table structure for notification
-- ----------------------------
DROP TABLE IF EXISTS `notification`;
CREATE TABLE `notification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `topic_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `target_user_id` int(11) NOT NULL,
  `action` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `in_time` datetime NOT NULL,
  `read` bit(1) NOT NULL DEFAULT b'0',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `topic_id` (`topic_id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `target_user_id` (`target_user_id`) USING BTREE,
  CONSTRAINT `notification_ibfk_3` FOREIGN KEY (`target_user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of notification
-- ----------------------------
BEGIN;
INSERT INTO `notification` VALUES (15, 7, 0, 4, 'check', '2019-03-10 08:06:13', b'1', 'two');
INSERT INTO `notification` VALUES (16, 6, 0, 4, 'check', '2019-03-10 08:06:19', b'1', 'one');
INSERT INTO `notification` VALUES (17, 7, 5, 4, 'COMMENT', '2019-03-10 08:06:44', b'1', '二');
INSERT INTO `notification` VALUES (18, 7, 0, 4, 'check', '2019-03-11 01:43:29', b'1', 'two');
INSERT INTO `notification` VALUES (19, 7, 0, 4, 'check', '2019-03-11 01:44:48', b'1', 'two');
INSERT INTO `notification` VALUES (20, 7, 5, 4, 'COMMENT', '2019-03-11 01:59:16', b'1', '三');
INSERT INTO `notification` VALUES (21, 7, 5, 4, 'COMMENT', '2019-03-11 01:59:23', b'1', '四');
INSERT INTO `notification` VALUES (22, 6, 5, 4, 'COMMENT', '2019-03-11 03:06:22', b'1', '一');
INSERT INTO `notification` VALUES (23, 6, 5, 4, 'COMMENT', '2019-03-11 03:06:28', b'1', '二');
INSERT INTO `notification` VALUES (24, 6, 4, 5, 'REPLY', '2019-03-11 04:22:54', b'0', '@yujiajun 这样吗');
INSERT INTO `notification` VALUES (25, 6, 4, 5, 'REPLY', '2019-03-11 04:29:31', b'0', '@yujiajun 就这样把');
INSERT INTO `notification` VALUES (26, 6, 5, 4, 'COMMENT', '2019-03-11 04:51:30', b'1', '四');
INSERT INTO `notification` VALUES (27, 6, 5, 4, 'COMMENT', '2019-03-11 04:51:40', b'1', '五');
INSERT INTO `notification` VALUES (28, 6, 4, 5, 'REPLY', '2019-03-11 04:52:31', b'0', '@yujiajun 好困');
INSERT INTO `notification` VALUES (29, 7, 5, 4, 'COMMENT', '2019-03-11 05:01:25', b'1', '五');
INSERT INTO `notification` VALUES (30, 6, 4, 5, 'REPLY', '2019-03-11 05:03:47', b'0', '@yujiajun 再试一次');
INSERT INTO `notification` VALUES (31, 6, 4, 5, 'REPLY', '2019-03-11 05:10:24', b'0', '@yujiajun 还来');
INSERT INTO `notification` VALUES (32, 7, 5, 4, 'COMMENT', '2019-03-11 05:24:15', b'1', '@yujiajun saddsad');
INSERT INTO `notification` VALUES (33, 6, 4, 5, 'REPLY', '2019-03-11 06:11:02', b'0', '@yujiajun 功能测试');
INSERT INTO `notification` VALUES (34, 6, 6, 4, 'COMMENT', '2019-03-15 04:42:04', b'0', '111');
INSERT INTO `notification` VALUES (35, 6, 6, 4, 'COMMENT', '2019-03-15 04:45:09', b'0', '222');
INSERT INTO `notification` VALUES (36, 7, 6, 4, 'COMMENT', '2019-03-15 05:25:00', b'0', '333');
INSERT INTO `notification` VALUES (37, 6, 6, 4, 'COMMENT', '2019-03-15 05:50:47', b'0', '3');
INSERT INTO `notification` VALUES (38, 7, 6, 4, 'COMMENT', '2019-03-15 05:56:48', b'0', '4');
INSERT INTO `notification` VALUES (39, 7, 6, 4, 'COMMENT', '2019-03-15 06:05:21', b'0', '5');
INSERT INTO `notification` VALUES (40, 7, 6, 4, 'COMMENT', '2019-03-15 06:15:58', b'0', '2');
INSERT INTO `notification` VALUES (41, 7, 6, 4, 'COMMENT', '2019-03-15 06:17:37', b'0', '666');
INSERT INTO `notification` VALUES (42, 7, 6, 4, 'COMMENT', '2019-03-15 06:18:41', b'0', '999');
INSERT INTO `notification` VALUES (43, 7, 6, 4, 'COMMENT', '2019-03-15 06:22:13', b'0', '222323213');
INSERT INTO `notification` VALUES (44, 7, 6, 4, 'COMMENT', '2019-03-15 06:29:15', b'0', '22');
INSERT INTO `notification` VALUES (45, 7, 6, 4, 'COMMENT', '2019-03-15 06:33:18', b'0', '44');
INSERT INTO `notification` VALUES (46, 7, 6, 4, 'COMMENT', '2019-03-15 06:36:22', b'0', '1');
INSERT INTO `notification` VALUES (47, 7, 6, 4, 'COMMENT', '2019-03-15 06:40:12', b'0', '222');
INSERT INTO `notification` VALUES (48, 7, 6, 4, 'COMMENT', '2019-03-15 06:50:01', b'0', '111');
INSERT INTO `notification` VALUES (49, 7, 6, 4, 'COMMENT', '2019-03-15 06:53:31', b'0', '312312');
INSERT INTO `notification` VALUES (50, 7, 6, 4, 'COMMENT', '2019-03-15 06:55:30', b'0', '678');
INSERT INTO `notification` VALUES (51, 7, 6, 4, 'COMMENT', '2019-03-15 06:57:36', b'0', '77');
INSERT INTO `notification` VALUES (52, 7, 6, 4, 'COMMENT', '2019-03-15 06:59:16', b'0', '88');
INSERT INTO `notification` VALUES (53, 7, 6, 4, 'COMMENT', '2019-03-15 07:07:22', b'0', '22');
INSERT INTO `notification` VALUES (54, 7, 6, 4, 'COMMENT', '2019-03-15 07:08:46', b'0', '2');
INSERT INTO `notification` VALUES (55, 7, 6, 4, 'COMMENT', '2019-03-15 07:09:14', b'0', '2');
INSERT INTO `notification` VALUES (56, 7, 6, 4, 'COMMENT', '2019-03-15 07:12:42', b'0', '333');
INSERT INTO `notification` VALUES (57, 7, 6, 4, 'COMMENT', '2019-03-15 07:13:28', b'0', '333');
INSERT INTO `notification` VALUES (58, 7, 6, 4, 'COMMENT', '2019-03-15 07:14:29', b'0', '44');
INSERT INTO `notification` VALUES (59, 7, 6, 4, 'COMMENT', '2019-03-15 07:17:41', b'0', '333');
INSERT INTO `notification` VALUES (60, 7, 6, 4, 'COMMENT', '2019-03-15 07:28:35', b'0', '11313');
COMMIT;

-- ----------------------------
-- Table structure for oauth_user
-- ----------------------------
DROP TABLE IF EXISTS `oauth_user`;
CREATE TABLE `oauth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `oauth_id` int(11) NOT NULL,
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `login` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `access_token` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `in_time` datetime NOT NULL,
  `bio` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  CONSTRAINT `oauth_user_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `pid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE,
  UNIQUE KEY `value` (`value`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of permission
-- ----------------------------
BEGIN;
INSERT INTO `permission` VALUES (1, '首页', 'index', 0);
INSERT INTO `permission` VALUES (2, '话题', 'topic', 0);
INSERT INTO `permission` VALUES (3, '评论', 'comment', 0);
INSERT INTO `permission` VALUES (4, '通知', 'notification', 0);
INSERT INTO `permission` VALUES (5, '用户', 'user', 0);
INSERT INTO `permission` VALUES (6, '验证码', 'code', 0);
INSERT INTO `permission` VALUES (7, '标签', 'tag', 0);
INSERT INTO `permission` VALUES (8, '权限', 'permission', 0);
INSERT INTO `permission` VALUES (9, '系统', 'system', 0);
INSERT INTO `permission` VALUES (10, '后台用户', 'admin_user', 0);
INSERT INTO `permission` VALUES (11, '仪表盘', 'index:index', 1);
INSERT INTO `permission` VALUES (12, '话题列表', 'topic:list', 2);
INSERT INTO `permission` VALUES (13, '话题编辑', 'topic:edit', 2);
INSERT INTO `permission` VALUES (14, '话题删除', 'topic:delete', 2);
INSERT INTO `permission` VALUES (15, '话题加精', 'topic:good', 2);
INSERT INTO `permission` VALUES (16, '话题置顶', 'topic:top', 2);
INSERT INTO `permission` VALUES (17, '评论列表', 'comment:list', 3);
INSERT INTO `permission` VALUES (18, '评论编辑', 'comment:edit', 3);
INSERT INTO `permission` VALUES (19, '评论删除', 'comment:delete', 3);
INSERT INTO `permission` VALUES (20, '通知列表', 'notification:list', 4);
INSERT INTO `permission` VALUES (21, '通知删除', 'notification:delete', 4);
INSERT INTO `permission` VALUES (22, '用户列表', 'user:list', 5);
INSERT INTO `permission` VALUES (23, '用户编辑', 'user:edit', 5);
INSERT INTO `permission` VALUES (24, '用户删除', 'user:delete', 5);
INSERT INTO `permission` VALUES (25, '验证码列表', 'code:list', 6);
INSERT INTO `permission` VALUES (26, '标签列表', 'tag:list', 7);
INSERT INTO `permission` VALUES (27, '标签编辑', 'tag:edit', 7);
INSERT INTO `permission` VALUES (28, '标签删除', 'tag:delete', 7);
INSERT INTO `permission` VALUES (29, '标签同步', 'tag:async', 7);
INSERT INTO `permission` VALUES (30, '权限列表', 'permission:list', 8);
INSERT INTO `permission` VALUES (31, '权限编辑', 'permission:edit', 8);
INSERT INTO `permission` VALUES (32, '权限删除', 'permission:delete', 8);
INSERT INTO `permission` VALUES (33, '角色', 'role', 0);
INSERT INTO `permission` VALUES (34, '日志', 'log', 0);
INSERT INTO `permission` VALUES (35, '角色列表', 'role:list', 33);
INSERT INTO `permission` VALUES (36, '角色编辑', 'role:edit', 33);
INSERT INTO `permission` VALUES (37, '角色删除', 'role:delete', 33);
INSERT INTO `permission` VALUES (38, '系统设置', 'system:edit', 9);
INSERT INTO `permission` VALUES (39, '后台用户列表', 'admin_user:list', 10);
INSERT INTO `permission` VALUES (40, '后台用户编辑', 'admin_user:edit', 10);
INSERT INTO `permission` VALUES (41, '后台用户创建', 'admin_user:add', 10);
INSERT INTO `permission` VALUES (42, '日志列表', 'log:list', 34);
INSERT INTO `permission` VALUES (43, '用户刷新Token', 'user:refresh_token', 5);
INSERT INTO `permission` VALUES (44, '权限添加', 'permission:add', 8);
INSERT INTO `permission` VALUES (45, '索引单个话题', 'topic:index', 2);
INSERT INTO `permission` VALUES (46, '索引全部话题', 'topic:index_all', 2);
INSERT INTO `permission` VALUES (48, '删除索引', 'topic:delete_index', 2);
INSERT INTO `permission` VALUES (49, '删除所有话题索引', 'topic:delete_all_index', 2);
INSERT INTO `permission` VALUES (50, '添加板块', 'tag:add', 7);
INSERT INTO `permission` VALUES (51, '后台用户删除', 'admin_user:delete', 10);
INSERT INTO `permission` VALUES (52, '话题审核', 'topic:check', 2);
INSERT INTO `permission` VALUES (53, '记录列表', 'record:list', 11);
INSERT INTO `permission` VALUES (56, '软件', 'software', 0);
INSERT INTO `permission` VALUES (57, '软件列表', 'software:list', 56);
INSERT INTO `permission` VALUES (58, '软件上传', 'software:add', 56);
INSERT INTO `permission` VALUES (59, '分类列表', 'software:categorylist', 56);
INSERT INTO `permission` VALUES (60, '分类添加', 'software:categoryadd', 56);
INSERT INTO `permission` VALUES (61, '文档中心', 'documents:list', 0);
INSERT INTO `permission` VALUES (62, '文档列表', 'document:list', 61);
INSERT INTO `permission` VALUES (63, '文档上传', 'document:upload', 61);
INSERT INTO `permission` VALUES (64, '文档添加', 'document:add', 61);
COMMIT;

-- ----------------------------
-- Table structure for plate
-- ----------------------------
DROP TABLE IF EXISTS `plate`;
CREATE TABLE `plate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `in_time` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of plate
-- ----------------------------
BEGIN;
INSERT INTO `plate` VALUES (1, '软件中心', '2019-04-08 15:44:00');
INSERT INTO `plate` VALUES (2, '文档中心', '2019-04-15 16:57:55');
COMMIT;

-- ----------------------------
-- Table structure for record
-- ----------------------------
DROP TABLE IF EXISTS `record`;
CREATE TABLE `record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `origin_id` int(11) NOT NULL,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `operation` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `method` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `params` varchar(10000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `in_time` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=140 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of record
-- ----------------------------
BEGIN;
INSERT INTO `record` VALUES (129, 0, 'test', '编辑话题', 'edit', '{\"topic\":{\"inTime\":1552637259000,\"view\":3,\"top\":false,\"pass\":false,\"tagId\":15,\"collectCount\":0,\"id\":32,\"title\":\"我的一个小测试2\",\"good\":false,\"userId\":6,\"content\":\"2\",\"commentCount\":0},\"list\":[\"c\",\"c#\",\"java\",\"javascrip\"],\"tags\":\"c\"}', '2019-03-15 08:22:38');
INSERT INTO `record` VALUES (130, 0, 'test', '更新话题', 'edit', '{\"title\":\"我的一个小测试233\",\"content\":\"2\",\"tags\":\"c\"}', '2019-03-15 08:22:40');
INSERT INTO `record` VALUES (131, 0, 'test', '发表评论', 'create', '{\"topicId\":\"32\",\"commentId\":\"\",\"content\":\"222\"}', '2019-03-15 08:23:00');
INSERT INTO `record` VALUES (132, 0, 'test', '更新评论', 'update', '{\"content\":\"2223\"}', '2019-03-15 08:23:03');
INSERT INTO `record` VALUES (133, 0, 'test', '创建话题', 'create', '{\"title\":\"测试结果2\",\"content\":\"2\",\"tags\":\"c\"}', '2019-03-15 08:39:15');
INSERT INTO `record` VALUES (134, 0, 'test', '创建话题', 'create', '{\"title\":\"我的一个小测试\",\"content\":\"java\",\"tags\":\"java\"}', '2019-03-18 05:35:13');
INSERT INTO `record` VALUES (135, 0, 'test', '发表评论', 'create', '{\"topicId\":\"34\",\"commentId\":\"\",\"content\":\"测试结果\"}', '2019-03-18 05:42:01');
INSERT INTO `record` VALUES (136, 0, 'test', '发表评论', 'create', '{\"topicId\":\"34\",\"commentId\":\"59\",\"content\":\"@test 测试如下\"}', '2019-03-18 05:42:14');
INSERT INTO `record` VALUES (137, 0, 'test', '创建话题', 'create', '{\"title\":\"我的一个小测试2\",\"content\":\"2\",\"tags\":\"java\"}', '2019-03-18 05:52:04');
INSERT INTO `record` VALUES (138, 0, 'test', '创建话题', 'create', '{\"title\":\"我的一个小测试2\",\"content\":\"1\",\"tags\":\"C#\"}', '2019-03-18 08:53:24');
INSERT INTO `record` VALUES (139, 116, '于富洋', '创建话题', 'create', '{\"title\":\"回家\",\"content\":\"\",\"tags\":\"springmvc\"}', '2019-03-25 05:29:35');
COMMIT;

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of role
-- ----------------------------
BEGIN;
INSERT INTO `role` VALUES (2, '审核员');
INSERT INTO `role` VALUES (4, '文档中心管理员');
INSERT INTO `role` VALUES (1, '超级管理员');
INSERT INTO `role` VALUES (3, '软件中心管理员');
COMMIT;

-- ----------------------------
-- Table structure for role_permission
-- ----------------------------
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission` (
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  KEY `role_id` (`role_id`) USING BTREE,
  KEY `permission_id` (`permission_id`) USING BTREE,
  CONSTRAINT `role_permission_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `role_permission_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of role_permission
-- ----------------------------
BEGIN;
INSERT INTO `role_permission` VALUES (2, 11);
INSERT INTO `role_permission` VALUES (2, 12);
INSERT INTO `role_permission` VALUES (2, 13);
INSERT INTO `role_permission` VALUES (2, 14);
INSERT INTO `role_permission` VALUES (2, 15);
INSERT INTO `role_permission` VALUES (2, 16);
INSERT INTO `role_permission` VALUES (2, 52);
INSERT INTO `role_permission` VALUES (2, 17);
INSERT INTO `role_permission` VALUES (2, 18);
INSERT INTO `role_permission` VALUES (2, 19);
INSERT INTO `role_permission` VALUES (2, 26);
INSERT INTO `role_permission` VALUES (2, 57);
INSERT INTO `role_permission` VALUES (2, 58);
INSERT INTO `role_permission` VALUES (2, 59);
INSERT INTO `role_permission` VALUES (2, 60);
INSERT INTO `role_permission` VALUES (1, 11);
INSERT INTO `role_permission` VALUES (1, 12);
INSERT INTO `role_permission` VALUES (1, 13);
INSERT INTO `role_permission` VALUES (1, 14);
INSERT INTO `role_permission` VALUES (1, 15);
INSERT INTO `role_permission` VALUES (1, 16);
INSERT INTO `role_permission` VALUES (1, 45);
INSERT INTO `role_permission` VALUES (1, 46);
INSERT INTO `role_permission` VALUES (1, 48);
INSERT INTO `role_permission` VALUES (1, 49);
INSERT INTO `role_permission` VALUES (1, 52);
INSERT INTO `role_permission` VALUES (1, 17);
INSERT INTO `role_permission` VALUES (1, 18);
INSERT INTO `role_permission` VALUES (1, 19);
INSERT INTO `role_permission` VALUES (1, 20);
INSERT INTO `role_permission` VALUES (1, 21);
INSERT INTO `role_permission` VALUES (1, 22);
INSERT INTO `role_permission` VALUES (1, 23);
INSERT INTO `role_permission` VALUES (1, 24);
INSERT INTO `role_permission` VALUES (1, 43);
INSERT INTO `role_permission` VALUES (1, 25);
INSERT INTO `role_permission` VALUES (1, 26);
INSERT INTO `role_permission` VALUES (1, 27);
INSERT INTO `role_permission` VALUES (1, 28);
INSERT INTO `role_permission` VALUES (1, 29);
INSERT INTO `role_permission` VALUES (1, 50);
INSERT INTO `role_permission` VALUES (1, 30);
INSERT INTO `role_permission` VALUES (1, 31);
INSERT INTO `role_permission` VALUES (1, 32);
INSERT INTO `role_permission` VALUES (1, 44);
INSERT INTO `role_permission` VALUES (1, 38);
INSERT INTO `role_permission` VALUES (1, 39);
INSERT INTO `role_permission` VALUES (1, 40);
INSERT INTO `role_permission` VALUES (1, 41);
INSERT INTO `role_permission` VALUES (1, 51);
INSERT INTO `role_permission` VALUES (1, 35);
INSERT INTO `role_permission` VALUES (1, 36);
INSERT INTO `role_permission` VALUES (1, 37);
INSERT INTO `role_permission` VALUES (1, 42);
INSERT INTO `role_permission` VALUES (1, 57);
INSERT INTO `role_permission` VALUES (1, 58);
INSERT INTO `role_permission` VALUES (1, 59);
INSERT INTO `role_permission` VALUES (1, 60);
INSERT INTO `role_permission` VALUES (1, 62);
INSERT INTO `role_permission` VALUES (1, 63);
INSERT INTO `role_permission` VALUES (1, 64);
COMMIT;

-- ----------------------------
-- Table structure for softcategory
-- ----------------------------
DROP TABLE IF EXISTS `softcategory`;
CREATE TABLE `softcategory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `in_time` datetime NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of softcategory
-- ----------------------------
BEGIN;
INSERT INTO `softcategory` VALUES (5, '天池', 'D:/Files', '2019-04-08 02:06:31', 'aaaaaaa');
INSERT INTO `softcategory` VALUES (6, '攻防平台', 'D:/Files', '2019-04-16 06:46:28', '渔夫阳');
INSERT INTO `softcategory` VALUES (7, '大数据', 'D:/Files', '2019-04-16 07:48:21', '大大大大大');
INSERT INTO `softcategory` VALUES (8, '测试', 'D:\\Files', '2019-04-17 06:09:47', '测试添加等级');
COMMIT;

-- ----------------------------
-- Table structure for system_config
-- ----------------------------
DROP TABLE IF EXISTS `system_config`;
CREATE TABLE `system_config` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `description` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `pid` int(11) NOT NULL DEFAULT '0',
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '',
  `option` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `reboot` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of system_config
-- ----------------------------
BEGIN;
INSERT INTO `system_config` VALUES (1, 'admin_remember_me_max_age', '30', '登录后台记住我功能记住时间，单位：天', 23, 'number', NULL, 1);
INSERT INTO `system_config` VALUES (2, 'base_url', 'http://localhost:8080', '网站部署后访问的域名，注意这个后面没有 \"/\"', 23, 'url', NULL, 0);
INSERT INTO `system_config` VALUES (3, 'comment_layer', '1', '评论盖楼形式显示', 23, 'radio', NULL, 0);
INSERT INTO `system_config` VALUES (4, 'cookie_domain', 'localhost', '存cookie时用到的域名，要与网站部署后访问的域名一致', 23, 'text', NULL, 0);
INSERT INTO `system_config` VALUES (5, 'cookie_max_age', '604800', 'cookie有效期，单位秒，默认1周', 23, 'number', NULL, 0);
INSERT INTO `system_config` VALUES (6, 'cookie_name', 'user_token', '存cookie时用到的名称', 23, 'text', NULL, 0);
INSERT INTO `system_config` VALUES (7, 'create_comment_score', '5', '发布评论奖励的积分', 26, 'number', NULL, 0);
INSERT INTO `system_config` VALUES (8, 'create_topic_score', '10', '创建话题奖励的积分', 26, 'number', NULL, 0);
INSERT INTO `system_config` VALUES (9, 'delete_comment_score', '5', '删除评论要被扣除的积分', 26, 'number', NULL, 0);
INSERT INTO `system_config` VALUES (10, 'delete_topic_score', '10', '删除话题要被扣除的积分', 26, 'number', NULL, 0);
INSERT INTO `system_config` VALUES (11, 'intro', '<h5>这里是安恒信息</h5><p>在这里，您可以提问，回答，分享，诉说，欢迎您的加入！</p>', '站点介绍', 23, 'text', NULL, 0);
INSERT INTO `system_config` VALUES (12, 'mail_host', 'smtp.qq.com', '邮箱的smtp服务器地址', 24, 'text', NULL, 0);
INSERT INTO `system_config` VALUES (13, 'mail_password', '', '发送邮件的邮箱密码', 24, 'password', NULL, 0);
INSERT INTO `system_config` VALUES (14, 'mail_username', 'xxoo@qq.com', '发送邮件的邮箱地址', 24, 'email', NULL, 0);
INSERT INTO `system_config` VALUES (15, 'name', '安恒信息', '站点名称', 23, 'text', NULL, 0);
INSERT INTO `system_config` VALUES (16, 'page_size', '8', '分页每页条数', 23, 'number', NULL, 0);
INSERT INTO `system_config` VALUES (17, 'websocket', '0', '是否开启websocket功能', 45, 'radio', NULL, 1);
INSERT INTO `system_config` VALUES (18, 'static_url', 'http://127.0.0.1:8080/static/upload/', '静态文件访问地址，主要用于上传文件的访问，注意最后有个\"/\"', 25, 'url', NULL, 0);
INSERT INTO `system_config` VALUES (19, 'up_comment_score', '3', '点赞评论奖励评论作者的积分', 26, 'number', NULL, 0);
INSERT INTO `system_config` VALUES (20, 'upload_avatar_size_limit', '2', '上传头像文件大小，单位MB，默认2MB', 25, 'number', NULL, 0);
INSERT INTO `system_config` VALUES (21, 'upload_path', '/Users/chenghongzhi/GitHub/pybbs/pybbs-db/static/upload/', '上传文件的路径，注意最后有个\"/\"', 25, 'text', NULL, 0);
INSERT INTO `system_config` VALUES (22, 'up_topic_score', '3', '点赞话题奖励话题作者的积分', 26, 'number', NULL, 0);
INSERT INTO `system_config` VALUES (23, NULL, NULL, '基础配置', 0, NULL, NULL, 0);
INSERT INTO `system_config` VALUES (25, NULL, NULL, '上传配置', 0, NULL, NULL, 0);
INSERT INTO `system_config` VALUES (27, NULL, NULL, 'Redis配置', 0, NULL, NULL, 0);
INSERT INTO `system_config` VALUES (29, 'redis_host', '', 'redis服务host地址', 27, 'text', NULL, 0);
INSERT INTO `system_config` VALUES (30, 'redis_port', '', 'redis服务端口（默认: 6379）', 27, 'number', NULL, 0);
INSERT INTO `system_config` VALUES (31, 'redis_password', '', 'redis服务密码', 27, 'password', NULL, 0);
INSERT INTO `system_config` VALUES (32, 'redis_timeout', '2000', '网站连接redis服务超时时间，单位毫秒', 27, 'number', NULL, 0);
INSERT INTO `system_config` VALUES (33, 'redis_database', '0', '网站连接redis服务的哪个数据库，默认0号数据库，取值范围0-15', 27, 'number', NULL, 0);
INSERT INTO `system_config` VALUES (34, 'redis_ssl', '0', 'redis服务是否开启认证连接', 27, 'radio', NULL, 0);
INSERT INTO `system_config` VALUES (35, NULL, NULL, 'Elasticsearch配置', 0, NULL, NULL, 0);
INSERT INTO `system_config` VALUES (36, 'elasticsearch_host', '', 'elasticsearch服务的地址', 35, 'text', NULL, 0);
INSERT INTO `system_config` VALUES (37, 'elasticsearch_port', '', 'elasticsearch服务的http端口', 35, 'number', NULL, 0);
INSERT INTO `system_config` VALUES (38, 'elasticsearch_index', '', '索引的名字', 35, 'text', NULL, 0);
INSERT INTO `system_config` VALUES (39, 'search', '0', '是否开启搜索功能（如果开启，需要额外启动一个ES服务，并填好ES相关的配置）', 35, 'radio', NULL, 0);
INSERT INTO `system_config` VALUES (41, 'oauth_github_client_id', '', 'Github登录配置项ClientId', 40, 'text', NULL, 0);
INSERT INTO `system_config` VALUES (42, 'oauth_github_client_secret', '', 'Github登录配置项ClientSecret', 40, 'text', NULL, 0);
INSERT INTO `system_config` VALUES (43, 'oauth_github_callback_url', '', 'Github登录配置项回调地址', 40, 'url', NULL, 0);
INSERT INTO `system_config` VALUES (44, 'topic_view_increase_interval', '600', '同一个用户浏览同一个话题多长时间算一次浏览量，默认10分钟，单位秒（只有当配置了redis才会生效）', 23, 'number', NULL, 0);
INSERT INTO `system_config` VALUES (46, 'websocket_host', '', 'websocket服务的主机名，这个跟cookie的域名设置成一样的就可以了', 45, 'text', NULL, 1);
INSERT INTO `system_config` VALUES (47, 'websocket_port', '', 'websocket服务的端口，不能跟论坛服务端口一样，其它随便设置', 45, 'number', NULL, 1);
COMMIT;

-- ----------------------------
-- Table structure for tag
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `description` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `topic_count` int(11) NOT NULL DEFAULT '0',
  `in_time` datetime NOT NULL,
  `admin_id` int(11) DEFAULT '0',
  `admin_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tag
-- ----------------------------
BEGIN;
INSERT INTO `tag` VALUES (20, '软件下载', '下载内容\r\n      软件版本：提供产品软件版本的下载链接和使用说明\r\n      规则库：提供规则库的下载链接和使用说明\r\n资料来源\r\n      统一由产品组负责更新维护\r\n', NULL, 0, '2019-04-03 00:52:55', 19, '于富洋');
INSERT INTO `tag` VALUES (21, '文档中心', '下载内容\r\n      用户手册：提供产品通用的用户使用指导手册\r\n      配置案例：提供产品常用的配置说明案例\r\n      维护资料：提供产品常见的维护指导资料\r\n资料来源\r\n      统一由产品组负责更新维护\r\n', NULL, 0, '2019-04-03 00:53:38', 0, NULL);
INSERT INTO `tag` VALUES (22, '知识库', '内容：涉及各个产品的配置、问题排查方法、FAQ等资料\r\n来源：所有安恒员工均可提交资料\r\n审核：400中心L2负责审核资料\r\n', NULL, 0, '2019-04-03 00:54:49', 0, NULL);
INSERT INTO `tag` VALUES (23, '许可申请', '推进许可自动化，逐步将OA系统的许可申请迁移至社区平台\r\n', NULL, 0, '2019-04-03 00:55:21', 0, NULL);
INSERT INTO `tag` VALUES (24, '快问快答', '话题广场：所有人员（外部+内部）都可以提交话题，安恒总部技术（400L2/产品组）回答问题\r\n智能客服：智能机器人+在线客服（400L1）\r\n', NULL, 0, '2019-04-03 00:56:04', 0, NULL);
INSERT INTO `tag` VALUES (25, '技术论坛', '内容：交流帖子、技术分享、改进建议等\r\n来源：面向所有人，包括安恒员工、安恒客户、渠道工程师等\r\n管理：资料不做审核，但是需要管理维护\r\n', NULL, 0, '2019-04-03 00:56:50', 0, NULL);
INSERT INTO `tag` VALUES (26, '产品需求', '内容：产品改进建议或者功能需求\r\n来源：面向所有安恒员工开放\r\n管理：400L2首次审核，产品组二次审核，研发最终审核\r\n奖励：接纳的需求给予相关奖励\r\n', NULL, 0, '2019-04-03 00:57:36', 0, NULL);
COMMIT;

-- ----------------------------
-- Table structure for topic
-- ----------------------------
DROP TABLE IF EXISTS `topic`;
CREATE TABLE `topic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `in_time` datetime NOT NULL,
  `modify_time` datetime DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `comment_count` int(11) NOT NULL DEFAULT '0',
  `collect_count` int(11) NOT NULL DEFAULT '0',
  `view` int(11) NOT NULL DEFAULT '0',
  `top` bit(1) NOT NULL DEFAULT b'0',
  `good` bit(1) NOT NULL DEFAULT b'0',
  `up_ids` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `tag_id` int(11) NOT NULL,
  `pass` bit(1) DEFAULT b'0',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `title` (`title`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for topic_tag
-- ----------------------------
DROP TABLE IF EXISTS `topic_tag`;
CREATE TABLE `topic_tag` (
  `tag_id` int(11) NOT NULL,
  `topic_id` int(11) NOT NULL,
  KEY `tag_id` (`tag_id`) USING BTREE,
  KEY `topic_id` (`topic_id`) USING BTREE,
  CONSTRAINT `topic_tag_ibfk_1` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `topic_tag_ibfk_2` FOREIGN KEY (`topic_id`) REFERENCES `topic` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for uploadfile
-- ----------------------------
DROP TABLE IF EXISTS `uploadfile`;
CREATE TABLE `uploadfile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `size` bigint(20) NOT NULL,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `in_time` datetime NOT NULL,
  `category_id` int(11) NOT NULL,
  `version` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Grade` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `origin_id` int(11) NOT NULL,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '',
  `avatar` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `bio` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `score` int(11) NOT NULL DEFAULT '0',
  `in_time` datetime NOT NULL,
  `token` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `telegram_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `email_notification` bit(1) NOT NULL DEFAULT b'0',
  `message` bigint(255) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `username` (`username`) USING BTREE,
  UNIQUE KEY `token` (`token`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` VALUES (4, 116, '于富洋', '$2a$10$MKpzmLCebYMqeCLW8pD2/ecWU6ofKYnjNkfnykWzs6YHQjrrv2WV6', NULL, NULL, NULL, 65, '2019-03-10 07:50:54', 'b04b1ac5-d45f-4808-84b0-d8eac1b15682', NULL, b'0', 0);
INSERT INTO `user` VALUES (5, 1159, 'yujiajun', '$2a$10$p8CEhzMRsAFph2khMSPNtORwFDVyjFqnZsiNV1DwmYxZZCHmRaGoG', NULL, NULL, NULL, 45, '2019-03-10 08:05:49', '310655ee-121d-45c5-b2a2-938a645b32a5', NULL, b'0', 0);
INSERT INTO `user` VALUES (6, 115, 'test', '$2a$10$fPKYEXWvltG2xGpXjqLWCOeV/25sMa06.YATRiLQumAL7mliCL7MK', 'http://127.0.0.1:8080/static/upload/avatar/test/avatar.jpeg?v=5', NULL, NULL, 410, '2019-03-11 06:01:11', '5e431eb4-7ae1-460c-846b-293cc9c8673d', NULL, b'0', 0);
INSERT INTO `user` VALUES (7, 1195, '会员0b3f0a635e719f04', '$2a$10$c1JVjk75gKvDqjX9fhslIuf3eekm.SG0Ztm9Yqw7nGIkFQnlMoYii', 'http://p1q3gxdny.bkt.clouddn.com/default-avatar.png', '', NULL, 0, '2019-03-14 02:16:43', 'f80d861c-edb4-4255-a3b8-4adc7d3713cf', NULL, b'0', 0);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
