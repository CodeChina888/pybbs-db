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

 Date: 23/05/2019 09:41:03
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
  `plate_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of admin_user
-- ----------------------------
BEGIN;
INSERT INTO `admin_user` VALUES (1, 'admin', '$2a$10$wr5wNPtdAYCtR7pJHVjzm.duC3v2d3tXympYz171RgH7CZCzHGJZm', '2018-11-11 11:11:11', 1, 0, NULL);
COMMIT;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `pid` int(11) NOT NULL,
  `in_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of category
-- ----------------------------
BEGIN;
INSERT INTO `category` VALUES (1, '所有分类', 0, '2019-05-20 07:50:31');
INSERT INTO `category` VALUES (3, '明鉴系列', 1, '2019-05-20 07:53:13');
INSERT INTO `category` VALUES (14, '明御系列', 1, '2019-05-21 08:37:31');
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
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for document
-- ----------------------------
DROP TABLE IF EXISTS `document`;
CREATE TABLE `document` (
  `id` int(25) NOT NULL AUTO_INCREMENT,
  `in_time` datetime NOT NULL,
  `url` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `fullpath` varchar(255) NOT NULL,
  `origin_name` varchar(255) NOT NULL,
  `pdf_url` varchar(255) DEFAULT NULL,
  `pdf_path` varchar(255) DEFAULT NULL,
  `pdf_name` varchar(255) DEFAULT NULL,
  `document_category_id` int(11) NOT NULL,
  `category` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of document
-- ----------------------------
BEGIN;
INSERT INTO `document` VALUES (43, '2019-05-22 07:45:20', '/forum/document/download/86552fbcab7b46d6a212513957ee73f1', 'http://127.0.0.1:8080/static/upload/Linux就该这么学 高清晰PDF-1558511120340.pdf', '86552fbcab7b46d6a212513957ee73f1', '/Users/chenghongzhi/GitHub/pybbs/pybbs-db/static/upload/Linux就该这么学 高清晰PDF-1558511120340.pdf', 'Linux就该这么学 高清晰PDF.pdf', 'http://127.0.0.1:8080/static/upload/Java多线程编程核心技术_完整版+PDF电子书下载+-1558511120339.pdf', '/Users/chenghongzhi/GitHub/pybbs/pybbs-db/static/upload/Java多线程编程核心技术_完整版+PDF电子书下载+-1558511120339.pdf', 'Java多线程编程核心技术_完整版+PDF电子书下载+.pdf', 7, '远程安全评估系统');
INSERT INTO `document` VALUES (44, '2019-05-22 07:51:35', '/forum/document/download/10d9a77808a240e8b65257a17e4e12dc', 'http://127.0.0.1:8080/static/upload/Java多线程编程核心技术_完整版+PDF电子书下载+-1558511494994.pdf', '10d9a77808a240e8b65257a17e4e12dc', '/Users/chenghongzhi/GitHub/pybbs/pybbs-db/static/upload/Java多线程编程核心技术_完整版+PDF电子书下载+-1558511494994.pdf', 'Java多线程编程核心技术_完整版+PDF电子书下载+.pdf', 'http://127.0.0.1:8080/static/upload/实战Java高并发程序设计（第2版）@www.java1234.com -1558511494993.pdf', '/Users/chenghongzhi/GitHub/pybbs/pybbs-db/static/upload/实战Java高并发程序设计（第2版）@www.java1234.com -1558511494993.pdf', '实战Java高并发程序设计（第2版）@www.java1234.com .pdf', 7, '远程安全评估系统');
INSERT INTO `document` VALUES (45, '2019-05-22 07:52:00', '/forum/document/download/1cafa9b16c794f359107ef5a7b304428', 'http://127.0.0.1:8080/static/upload/深入实践Spring Boot-1558511519762.pdf', '1cafa9b16c794f359107ef5a7b304428', '/Users/chenghongzhi/GitHub/pybbs/pybbs-db/static/upload/深入实践Spring Boot-1558511519762.pdf', '深入实践Spring Boot.pdf', 'http://127.0.0.1:8080/static/upload/Java多线程编程核心技术_完整版+PDF电子书下载+-1558511519761.pdf', '/Users/chenghongzhi/GitHub/pybbs/pybbs-db/static/upload/Java多线程编程核心技术_完整版+PDF电子书下载+-1558511519761.pdf', 'Java多线程编程核心技术_完整版+PDF电子书下载+.pdf', 7, '远程安全评估系统');
COMMIT;

-- ----------------------------
-- Table structure for document_category
-- ----------------------------
DROP TABLE IF EXISTS `document_category`;
CREATE TABLE `document_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `pid` int(11) NOT NULL,
  `top_id` int(11) NOT NULL,
  `in_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of document_category
-- ----------------------------
BEGIN;
INSERT INTO `document_category` VALUES (7, '远程安全评估系统', 3, 1, '2019-05-21 08:39:24');
INSERT INTO `document_category` VALUES (8, 'web应用防火墙', 14, 1, '2019-05-21 08:39:37');
INSERT INTO `document_category` VALUES (9, 'USM运维审计', 14, 1, '2019-05-21 08:39:48');
INSERT INTO `document_category` VALUES (10, 'SOC日志审计', 14, 1, '2019-05-21 08:40:02');
INSERT INTO `document_category` VALUES (11, 'DB数据库审计', 14, 1, '2019-05-21 08:40:16');
INSERT INTO `document_category` VALUES (12, 'NGFW安全网关', 14, 1, '2019-05-21 08:40:30');
COMMIT;

-- ----------------------------
-- Table structure for document_label
-- ----------------------------
DROP TABLE IF EXISTS `document_label`;
CREATE TABLE `document_label` (
  `doc_id` int(11) DEFAULT NULL,
  `label_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of document_label
-- ----------------------------
BEGIN;
INSERT INTO `document_label` VALUES (43, 14);
INSERT INTO `document_label` VALUES (43, 15);
INSERT INTO `document_label` VALUES (43, 16);
INSERT INTO `document_label` VALUES (43, 17);
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
-- Table structure for label
-- ----------------------------
DROP TABLE IF EXISTS `label`;
CREATE TABLE `label` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '标签标示',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '标签名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=202 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of label
-- ----------------------------
BEGIN;
INSERT INTO `label` VALUES (1, '杭州办', '杭州办');
INSERT INTO `label` VALUES (2, '福州办', '福州办');
INSERT INTO `label` VALUES (3, '昆明办', '昆明办');
INSERT INTO `label` VALUES (4, '成都办', '成都办');
INSERT INTO `label` VALUES (5, '西安办', '西安办');
INSERT INTO `label` VALUES (6, '深圳办', '深圳办');
INSERT INTO `label` VALUES (7, '上海办', '上海办');
INSERT INTO `label` VALUES (8, '济南办', '济南办');
INSERT INTO `label` VALUES (9, '郑州办', '郑州办');
INSERT INTO `label` VALUES (10, '武汉办', '武汉办');
INSERT INTO `label` VALUES (11, '内蒙办', '内蒙办');
INSERT INTO `label` VALUES (12, '广州办', '广州办');
INSERT INTO `label` VALUES (13, '沈阳办', '沈阳办');
INSERT INTO `label` VALUES (14, '安恒全国渠道', '安恒全国渠道');
INSERT INTO `label` VALUES (15, '安恒技术服务中心', '安恒技术服务中心');
INSERT INTO `label` VALUES (16, '安恒渠道用户', '安恒渠道用户');
INSERT INTO `label` VALUES (17, '安恒渠道经理', '安恒渠道经理');
INSERT INTO `label` VALUES (18, '长春办', '长春办');
INSERT INTO `label` VALUES (19, '长沙办', '长沙办');
INSERT INTO `label` VALUES (20, '合肥办', '合肥办');
INSERT INTO `label` VALUES (21, '认证考试测试', '认证考试测试');
INSERT INTO `label` VALUES (22, 'default', 'default');
INSERT INTO `label` VALUES (23, '去标签', '去标签');
INSERT INTO `label` VALUES (24, '南京办', '南京办');
INSERT INTO `label` VALUES (25, '7月13日WAF售前初级认证', '7月13日WAF售前初级认证');
INSERT INTO `label` VALUES (26, '7月13日USM售前初级认证', '7月13日USM售前初级认证');
INSERT INTO `label` VALUES (27, '7月13日USM售后初级认证', '7月13日USM售后初级认证');
INSERT INTO `label` VALUES (28, '7月13日WAF售后初级认证', '7月13日WAF售后初级认证');
INSERT INTO `label` VALUES (29, 'Sheet2', 'Sheet2');
INSERT INTO `label` VALUES (30, 'Sheet3', 'Sheet3');
INSERT INTO `label` VALUES (31, '渠道经理', '渠道经理');
INSERT INTO `label` VALUES (32, '技术服务中心', '技术服务中心');
INSERT INTO `label` VALUES (33, '720WAF售前', '720WAF售前');
INSERT INTO `label` VALUES (34, '720WAF售后', '720WAF售后');
INSERT INTO `label` VALUES (35, '720USM售前', '720USM售前');
INSERT INTO `label` VALUES (36, '720USM售后', '720USM售后');
INSERT INTO `label` VALUES (37, '720SOC售前', '720SOC售前');
INSERT INTO `label` VALUES (38, '720SOC售后', '720SOC售后');
INSERT INTO `label` VALUES (39, '720DB售前', '720DB售前');
INSERT INTO `label` VALUES (40, '720DB售后', '720DB售后');
INSERT INTO `label` VALUES (41, '721WAF售前', '721WAF售前');
INSERT INTO `label` VALUES (42, '722WAF售前', '722WAF售前');
INSERT INTO `label` VALUES (43, '北京办', '北京办');
INSERT INTO `label` VALUES (44, '重庆办', '重庆办');
INSERT INTO `label` VALUES (45, '727NGFW售后', '727NGFW售后');
INSERT INTO `label` VALUES (46, '727APT售后', '727APT售后');
INSERT INTO `label` VALUES (47, '727DB售前', '727DB售前');
INSERT INTO `label` VALUES (48, '727DB售后', '727DB售后');
INSERT INTO `label` VALUES (49, '727USM售前', '727USM售前');
INSERT INTO `label` VALUES (50, '727USM售后', '727USM售后');
INSERT INTO `label` VALUES (51, '727WAF售前', '727WAF售前');
INSERT INTO `label` VALUES (52, '727WAF售后', '727WAF售后');
INSERT INTO `label` VALUES (53, '727SOC售前', '727SOC售前');
INSERT INTO `label` VALUES (54, '727SOC售后', '727SOC售后');
INSERT INTO `label` VALUES (55, '安恒', '安恒');
INSERT INTO `label` VALUES (56, '贵州办', '贵州办');
INSERT INTO `label` VALUES (57, '太原办', '太原办');
INSERT INTO `label` VALUES (58, '1808WAF售前', '1808WAF售前');
INSERT INTO `label` VALUES (59, '1808WAF售后', '1808WAF售后');
INSERT INTO `label` VALUES (60, '1808USM售前', '1808USM售前');
INSERT INTO `label` VALUES (61, '1808USM售后', '1808USM售后');
INSERT INTO `label` VALUES (62, '1808DB售前', '1808DB售前');
INSERT INTO `label` VALUES (63, '1808DB售后', '1808DB售后');
INSERT INTO `label` VALUES (64, '1808SOC售前', '1808SOC售前');
INSERT INTO `label` VALUES (65, '1808SOC售后', '1808SOC售后');
INSERT INTO `label` VALUES (66, '1808APT售前', '1808APT售前');
INSERT INTO `label` VALUES (67, '1808APT售后', '1808APT售后');
INSERT INTO `label` VALUES (68, '1808NGFW售前', '1808NGFW售前');
INSERT INTO `label` VALUES (69, '1808NGFW售后', '1808NGFW售后');
INSERT INTO `label` VALUES (70, '安恒信息', '安恒信息');
INSERT INTO `label` VALUES (71, 'Sheet1', 'Sheet1');
INSERT INTO `label` VALUES (72, '测试', '测试');
INSERT INTO `label` VALUES (73, '黑龙江网络安全知识线上竞赛', '黑龙江网络安全知识线上竞赛');
INSERT INTO `label` VALUES (74, '黑龙江CTF夺旗赛线上竞赛', '黑龙江CTF夺旗赛线上竞赛');
INSERT INTO `label` VALUES (75, '网络空间安全协会', '网络空间安全协会');
INSERT INTO `label` VALUES (76, '广西办', '广西办');
INSERT INTO `label` VALUES (77, '兰州办', '兰州办');
INSERT INTO `label` VALUES (78, '1809WAF售前', '1809WAF售前');
INSERT INTO `label` VALUES (79, '1809WAF售后', '1809WAF售后');
INSERT INTO `label` VALUES (80, '1809USM售前', '1809USM售前');
INSERT INTO `label` VALUES (81, '1809USM售后', '1809USM售后');
INSERT INTO `label` VALUES (82, '1809DB售前', '1809DB售前');
INSERT INTO `label` VALUES (83, '1809DB售后', '1809DB售后');
INSERT INTO `label` VALUES (84, '1809SOC售前', '1809SOC售前');
INSERT INTO `label` VALUES (85, '1809SOC售后', '1809SOC售后');
INSERT INTO `label` VALUES (86, '1809APT售前', '1809APT售前');
INSERT INTO `label` VALUES (87, '1809APT售后', '1809APT售后');
INSERT INTO `label` VALUES (88, '1809NGFW售前', '1809NGFW售前');
INSERT INTO `label` VALUES (89, '1809NGFW售后', '1809NGFW售后');
INSERT INTO `label` VALUES (90, '瓯网杯', '瓯网杯');
INSERT INTO `label` VALUES (91, '温州职业技术学院', '温州职业技术学院');
INSERT INTO `label` VALUES (92, '瓯网杯决赛', '瓯网杯决赛');
INSERT INTO `label` VALUES (93, '泉州参赛证', '泉州参赛证');
INSERT INTO `label` VALUES (94, '团队赛', '团队赛');
INSERT INTO `label` VALUES (95, '个人赛', '个人赛');
INSERT INTO `label` VALUES (96, '天翼杯决赛', '天翼杯决赛');
INSERT INTO `label` VALUES (97, '四川公安参赛', '四川公安参赛');
INSERT INTO `label` VALUES (98, '川职参赛', '川职参赛');
INSERT INTO `label` VALUES (99, '1810WAF售前', '1810WAF售前');
INSERT INTO `label` VALUES (100, '1810WAF售后', '1810WAF售后');
INSERT INTO `label` VALUES (101, '1810USM售前', '1810USM售前');
INSERT INTO `label` VALUES (102, '1810USM售后', '1810USM售后');
INSERT INTO `label` VALUES (103, '1810DB售前', '1810DB售前');
INSERT INTO `label` VALUES (104, '1810DB售后', '1810DB售后');
INSERT INTO `label` VALUES (105, '1810SOC售前', '1810SOC售前');
INSERT INTO `label` VALUES (106, '1810SOC售后', '1810SOC售后');
INSERT INTO `label` VALUES (107, '1810NGFW售前', '1810NGFW售前');
INSERT INTO `label` VALUES (108, '1810NGFW售后', '1810NGFW售后');
INSERT INTO `label` VALUES (109, '1810APT售前', '1810APT售前');
INSERT INTO `label` VALUES (110, '1810APT售后', '1810APT售后');
INSERT INTO `label` VALUES (111, '1', '1');
INSERT INTO `label` VALUES (113, '安恒员工认证', '安恒员工认证');
INSERT INTO `label` VALUES (114, '福职院', '福职院');
INSERT INTO `label` VALUES (115, '新疆办', '新疆办');
INSERT INTO `label` VALUES (116, '1811WAF售前', '1811WAF售前');
INSERT INTO `label` VALUES (117, '1811WAF售后', '1811WAF售后');
INSERT INTO `label` VALUES (118, '1811USM售前', '1811USM售前');
INSERT INTO `label` VALUES (119, '1811USM售后', '1811USM售后');
INSERT INTO `label` VALUES (120, '1811DB售前', '1811DB售前');
INSERT INTO `label` VALUES (121, '1811DB售后', '1811DB售后');
INSERT INTO `label` VALUES (122, '1811SOC售前', '1811SOC售前');
INSERT INTO `label` VALUES (123, '1811SOC售后', '1811SOC售后');
INSERT INTO `label` VALUES (124, '1811NGFW售前', '1811NGFW售前');
INSERT INTO `label` VALUES (125, '1811NGFW售后', '1811NGFW售后');
INSERT INTO `label` VALUES (126, '1811APT售前', '1811APT售前');
INSERT INTO `label` VALUES (127, '1811APT售后', '1811APT售后');
INSERT INTO `label` VALUES (128, '1811EDR售前', '1811EDR售前');
INSERT INTO `label` VALUES (129, '1811EDR售后', '1811EDR售后');
INSERT INTO `label` VALUES (130, '1811WPT售前', '1811WPT售前');
INSERT INTO `label` VALUES (131, '1811WPT售后', '1811WPT售后');
INSERT INTO `label` VALUES (132, '加标记', '加标记');
INSERT INTO `label` VALUES (133, '北联大', '北联大');
INSERT INTO `label` VALUES (134, '重庆科技学院', '重庆科技学院');
INSERT INTO `label` VALUES (135, '贵阳办', '贵阳办');
INSERT INTO `label` VALUES (136, '苏州办', '苏州办');
INSERT INTO `label` VALUES (137, 'WAF售前1812', 'WAF售前1812');
INSERT INTO `label` VALUES (138, 'WAF售后1812', 'WAF售后1812');
INSERT INTO `label` VALUES (139, 'USM售前1812', 'USM售前1812');
INSERT INTO `label` VALUES (140, 'USM售后1812', 'USM售后1812');
INSERT INTO `label` VALUES (141, 'DB售前1812', 'DB售前1812');
INSERT INTO `label` VALUES (142, 'DB售后1812', 'DB售后1812');
INSERT INTO `label` VALUES (143, 'SOC售前1812', 'SOC售前1812');
INSERT INTO `label` VALUES (144, 'SOC售后1812', 'SOC售后1812');
INSERT INTO `label` VALUES (145, 'NGFW售前1812', 'NGFW售前1812');
INSERT INTO `label` VALUES (146, 'NGFW售后1812', 'NGFW售后1812');
INSERT INTO `label` VALUES (147, 'APT售前1812', 'APT售前1812');
INSERT INTO `label` VALUES (148, 'APT售后1812', 'APT售后1812');
INSERT INTO `label` VALUES (149, 'EDR售前1812', 'EDR售前1812');
INSERT INTO `label` VALUES (150, 'EDR售后1812', 'EDR售后1812');
INSERT INTO `label` VALUES (151, 'WPT售前1812', 'WPT售前1812');
INSERT INTO `label` VALUES (152, 'WPT售后1812', 'WPT售后1812');
INSERT INTO `label` VALUES (153, '技术中心', '技术中心');
INSERT INTO `label` VALUES (154, '天津教育行业赛', '天津教育行业赛');
INSERT INTO `label` VALUES (155, '南宁办', '南宁办');
INSERT INTO `label` VALUES (156, '海南办', '海南办');
INSERT INTO `label` VALUES (157, '乌鲁木齐办', '乌鲁木齐办');
INSERT INTO `label` VALUES (158, '厦门办', '厦门办');
INSERT INTO `label` VALUES (159, '媒体&互联网事业部', '媒体&互联网事业部');
INSERT INTO `label` VALUES (160, 'APT售后1903C', 'APT售后1903C');
INSERT INTO `label` VALUES (161, 'APT售前1903C', 'APT售前1903C');
INSERT INTO `label` VALUES (162, 'DB售后1903C', 'DB售后1903C');
INSERT INTO `label` VALUES (163, 'DB售前1903C', 'DB售前1903C');
INSERT INTO `label` VALUES (164, 'EDR售后', 'EDR售后');
INSERT INTO `label` VALUES (165, 'EDR售前1903C', 'EDR售前1903C');
INSERT INTO `label` VALUES (166, 'NGFW售后1903C', 'NGFW售后1903C');
INSERT INTO `label` VALUES (167, 'NGFW售前1903C', 'NGFW售前1903C');
INSERT INTO `label` VALUES (168, 'SOC售后1903C', 'SOC售后1903C');
INSERT INTO `label` VALUES (169, 'SOC售前1903C', 'SOC售前1903C');
INSERT INTO `label` VALUES (170, 'USM售后1903C', 'USM售后1903C');
INSERT INTO `label` VALUES (171, 'USM售前1903C', 'USM售前1903C');
INSERT INTO `label` VALUES (172, 'USM售前1903G', 'USM售前1903G');
INSERT INTO `label` VALUES (173, 'USM售后1903G', 'USM售后1903G');
INSERT INTO `label` VALUES (174, 'WAF售后1903C', 'WAF售后1903C');
INSERT INTO `label` VALUES (175, 'WAF售前1903C', 'WAF售前1903C');
INSERT INTO `label` VALUES (176, 'WAF售后1903G', 'WAF售后1903G');
INSERT INTO `label` VALUES (177, 'WAF售前1903G', 'WAF售前1903G');
INSERT INTO `label` VALUES (178, 'Webprotect售前1903C', 'Webprotect售前1903C');
INSERT INTO `label` VALUES (179, 'Webprotect售后1903C', 'Webprotect售后1903C');
INSERT INTO `label` VALUES (180, 'EDR售后1903C', 'EDR售后1903C');
INSERT INTO `label` VALUES (181, '南昌办', '南昌办');
INSERT INTO `label` VALUES (182, '西湖论剑大赛', '西湖论剑大赛');
INSERT INTO `label` VALUES (183, 'xihulunjian', 'xihulunjian');
INSERT INTO `label` VALUES (184, '浙大', '浙大');
INSERT INTO `label` VALUES (185, '农信', '农信');
INSERT INTO `label` VALUES (186, 'WPT售前1904C', 'WPT售前1904C');
INSERT INTO `label` VALUES (187, 'WPT售后1904C', 'WPT售后1904C');
INSERT INTO `label` VALUES (188, 'WAF售前1904C', 'WAF售前1904C');
INSERT INTO `label` VALUES (189, 'WAF售后1904C', 'WAF售后1904C');
INSERT INTO `label` VALUES (190, 'USM售前1904C', 'USM售前1904C');
INSERT INTO `label` VALUES (191, 'USM售后1904C', 'USM售后1904C');
INSERT INTO `label` VALUES (192, 'SOC售前1904C', 'SOC售前1904C');
INSERT INTO `label` VALUES (193, 'SOC售后1904C', 'SOC售后1904C');
INSERT INTO `label` VALUES (194, 'NGFW售前1904C', 'NGFW售前1904C');
INSERT INTO `label` VALUES (195, 'NGFW售后1904C', 'NGFW售后1904C');
INSERT INTO `label` VALUES (196, 'EDR售前1904C', 'EDR售前1904C');
INSERT INTO `label` VALUES (197, 'EDR售后1904C', 'EDR售后1904C');
INSERT INTO `label` VALUES (198, 'DB售前1904C', 'DB售前1904C');
INSERT INTO `label` VALUES (199, 'DB售后1904C', 'DB售后1904C');
INSERT INTO `label` VALUES (200, 'APT售前1904C', 'APT售前1904C');
INSERT INTO `label` VALUES (201, 'APT售后1904C', 'APT售后1904C');
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
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of notification
-- ----------------------------
BEGIN;
INSERT INTO `notification` VALUES (68, 39, 0, 8, 'check', '2019-04-25 08:55:30', b'0', '111');
INSERT INTO `notification` VALUES (69, 40, 0, 8, 'check', '2019-05-22 08:36:43', b'0', '测试结果');
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
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

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
INSERT INTO `permission` VALUES (35, '角色列表', 'role:list', 33);
INSERT INTO `permission` VALUES (36, '角色编辑', 'role:edit', 33);
INSERT INTO `permission` VALUES (37, '角色删除', 'role:delete', 33);
INSERT INTO `permission` VALUES (38, '系统设置', 'system:edit', 9);
INSERT INTO `permission` VALUES (39, '后台用户列表', 'admin_user:list', 10);
INSERT INTO `permission` VALUES (40, '后台用户编辑', 'admin_user:edit', 10);
INSERT INTO `permission` VALUES (41, '后台用户创建', 'admin_user:add', 10);
INSERT INTO `permission` VALUES (43, '用户刷新Token', 'user:refresh_token', 5);
INSERT INTO `permission` VALUES (44, '权限添加', 'permission:add', 8);
INSERT INTO `permission` VALUES (45, '索引单个话题', 'topic:index', 2);
INSERT INTO `permission` VALUES (46, '索引全部话题', 'topic:index_all', 2);
INSERT INTO `permission` VALUES (48, '删除索引', 'topic:delete_index', 2);
INSERT INTO `permission` VALUES (49, '删除所有话题索引', 'topic:delete_all_index', 2);
INSERT INTO `permission` VALUES (50, '添加板块', 'tag:add', 7);
INSERT INTO `permission` VALUES (51, '后台用户删除', 'admin_user:delete', 10);
INSERT INTO `permission` VALUES (52, '话题审核', 'topic:check', 2);
INSERT INTO `permission` VALUES (56, '软件', 'software', 0);
INSERT INTO `permission` VALUES (57, '软件列表', 'software:list', 56);
INSERT INTO `permission` VALUES (58, '软件添加', 'software:add', 56);
INSERT INTO `permission` VALUES (70, '日志', 'record:list', 0);
INSERT INTO `permission` VALUES (71, '日志列表', 'records:list', 70);
INSERT INTO `permission` VALUES (73, '文档', 'documents:list', 0);
INSERT INTO `permission` VALUES (74, '文档上传', 'document:upload', 73);
INSERT INTO `permission` VALUES (75, '文档添加', 'document:add', 73);
INSERT INTO `permission` VALUES (76, '文档列表', 'document:list', 73);
INSERT INTO `permission` VALUES (77, '文档删除', 'document:delete', 73);
INSERT INTO `permission` VALUES (78, '软件修改', 'software:edit', 56);
INSERT INTO `permission` VALUES (79, '软件删除', 'software:delete', 56);
INSERT INTO `permission` VALUES (80, '角色添加', 'role:add', 33);
INSERT INTO `permission` VALUES (83, '文档编辑', 'document:edit', 73);
INSERT INTO `permission` VALUES (87, '分类', 'category', 0);
INSERT INTO `permission` VALUES (89, '添加分类', 'category:add', 87);
INSERT INTO `permission` VALUES (90, '删除分类', 'category:delete', 87);
INSERT INTO `permission` VALUES (91, '修改分类', 'category:edit', 87);
INSERT INTO `permission` VALUES (92, '列表分类', 'category:list', 87);
INSERT INTO `permission` VALUES (93, '文档分类添加', 'DocumentCategory:add', 87);
INSERT INTO `permission` VALUES (94, '文档分类编辑', 'DocumentCategory:edit', 87);
INSERT INTO `permission` VALUES (95, '文档分类删除', 'DocumentCategory:delete', 87);
INSERT INTO `permission` VALUES (96, '文档分类列表', 'DocumentCategory:list', 87);
INSERT INTO `permission` VALUES (97, '软件上传', 'software:upload', 56);
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of record
-- ----------------------------
BEGIN;
INSERT INTO `record` VALUES (1, 1195, '老舰长不靠浆', '创建话题', 'create', '{\"title\":\"论坛功能测试\",\"content\":\"测试结果\",\"tags\":\"产品需求\"}', '2019-05-22 08:36:22');
COMMIT;

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of role
-- ----------------------------
BEGIN;
INSERT INTO `role` VALUES (1, '超级管理员');
INSERT INTO `role` VALUES (2, '模块管理员');
INSERT INTO `role` VALUES (3, '内容管理员');
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
INSERT INTO `role_permission` VALUES (3, 11);
INSERT INTO `role_permission` VALUES (3, 38);
INSERT INTO `role_permission` VALUES (3, 39);
INSERT INTO `role_permission` VALUES (3, 40);
INSERT INTO `role_permission` VALUES (3, 41);
INSERT INTO `role_permission` VALUES (3, 51);
INSERT INTO `role_permission` VALUES (3, 57);
INSERT INTO `role_permission` VALUES (3, 58);
INSERT INTO `role_permission` VALUES (3, 78);
INSERT INTO `role_permission` VALUES (3, 79);
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
INSERT INTO `role_permission` VALUES (1, 80);
INSERT INTO `role_permission` VALUES (1, 57);
INSERT INTO `role_permission` VALUES (1, 58);
INSERT INTO `role_permission` VALUES (1, 78);
INSERT INTO `role_permission` VALUES (1, 79);
INSERT INTO `role_permission` VALUES (1, 97);
INSERT INTO `role_permission` VALUES (1, 74);
INSERT INTO `role_permission` VALUES (1, 75);
INSERT INTO `role_permission` VALUES (1, 76);
INSERT INTO `role_permission` VALUES (1, 77);
INSERT INTO `role_permission` VALUES (1, 83);
INSERT INTO `role_permission` VALUES (1, 89);
INSERT INTO `role_permission` VALUES (1, 90);
INSERT INTO `role_permission` VALUES (1, 91);
INSERT INTO `role_permission` VALUES (1, 92);
INSERT INTO `role_permission` VALUES (1, 93);
INSERT INTO `role_permission` VALUES (1, 94);
INSERT INTO `role_permission` VALUES (1, 95);
INSERT INTO `role_permission` VALUES (1, 96);
COMMIT;

-- ----------------------------
-- Table structure for software
-- ----------------------------
DROP TABLE IF EXISTS `software`;
CREATE TABLE `software` (
  `id` int(25) NOT NULL AUTO_INCREMENT,
  `in_time` datetime NOT NULL,
  `url` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `fullpath` varchar(255) NOT NULL,
  `origin_name` varchar(255) NOT NULL,
  `software_category_id` int(11) NOT NULL,
  `category` varchar(255) NOT NULL,
  `version` varchar(255) DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of software
-- ----------------------------
BEGIN;
INSERT INTO `software` VALUES (49, '2019-05-22 08:09:50', '/forum/software/download/3ca688d846bd41e1899b955d36c0c36f', 'http://127.0.0.1:8080/static/upload/实战Java高并发程序设计（第2版）@www.java1234.com -1558512589841.pdf', '3ca688d846bd41e1899b955d36c0c36f', '/Users/chenghongzhi/GitHub/pybbs/pybbs-db/static/upload/实战Java高并发程序设计（第2版）@www.java1234.com -1558512589841.pdf', '实战Java高并发程序设计（第2版）@www.java1234.com .pdf', 7, '远程安全评估系统', '', '');
INSERT INTO `software` VALUES (50, '2019-05-22 08:09:56', '/forum/software/download/bba1d34df0b849aaa6b19a2e3a338434', 'http://127.0.0.1:8080/static/upload/java开发_程鸿志-1558512595830.pdf', 'bba1d34df0b849aaa6b19a2e3a338434', '/Users/chenghongzhi/GitHub/pybbs/pybbs-db/static/upload/java开发_程鸿志-1558512595830.pdf', 'java开发_程鸿志.pdf', 7, '远程安全评估系统', '', '');
INSERT INTO `software` VALUES (51, '2019-05-22 08:10:04', '/forum/software/download/59efaedc4fd24cf8bf303eadbd51c428', 'http://127.0.0.1:8080/static/upload/实战Java高并发程序设计（第2版）@www.java1234.com -1558512604077.pdf', '59efaedc4fd24cf8bf303eadbd51c428', '/Users/chenghongzhi/GitHub/pybbs/pybbs-db/static/upload/实战Java高并发程序设计（第2版）@www.java1234.com -1558512604077.pdf', '实战Java高并发程序设计（第2版）@www.java1234.com .pdf', 7, '远程安全评估系统', '', '');
INSERT INTO `software` VALUES (52, '2019-05-22 08:24:28', '/forum/software/download/fc582f02016142b0b5c0a4c263e3749d', 'http://127.0.0.1:8080/static/upload/实验7、用户管理和权限管理-1558513468486.docx', 'fc582f02016142b0b5c0a4c263e3749d', '/Users/chenghongzhi/GitHub/pybbs/pybbs-db/static/upload/实验7、用户管理和权限管理-1558513468486.docx', '实验7、用户管理和权限管理.docx', 7, '远程安全评估系统', '', '');
COMMIT;

-- ----------------------------
-- Table structure for software_label
-- ----------------------------
DROP TABLE IF EXISTS `software_label`;
CREATE TABLE `software_label` (
  `software_id` int(11) NOT NULL,
  `label_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of software_label
-- ----------------------------
BEGIN;
INSERT INTO `software_label` VALUES (52, 1);
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
INSERT INTO `system_config` VALUES (18, 'static_url', 'http://127.0.0.1:8080/', '静态文件访问地址，主要用于上传文件的访问，注意最后有个\"/\"', 25, 'url', NULL, 0);
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
INSERT INTO `tag` VALUES (26, '产品需求', '内容：产品改进建议或者功能需求\r\n来源：面向所有安恒员工开放\r\n管理：400L2首次审核，产品组二次审核，研发最终审核\r\n奖励：接纳的需求给予相关奖励\r\n', NULL, 2, '2019-04-03 00:57:36', 0, NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of topic
-- ----------------------------
BEGIN;
INSERT INTO `topic` VALUES (40, '论坛功能测试', '测试结果', '2019-05-22 08:36:22', '2019-05-22 08:36:43', 8, 0, 0, 1, b'1', b'0', NULL, 26, b'1');
COMMIT;

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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` VALUES (6, 115, 'test', '$2a$10$fPKYEXWvltG2xGpXjqLWCOeV/25sMa06.YATRiLQumAL7mliCL7MK', 'http://127.0.0.1:8080/static/upload/avatar/test/avatar.jpeg?v=5', NULL, NULL, 410, '2019-03-11 06:01:11', '5e431eb4-7ae1-460c-846b-293cc9c8673d', NULL, b'0', 0);
INSERT INTO `user` VALUES (8, 1195, '老舰长不靠浆', '$2a$10$4yaWpl47C0hcKDr2amw/BO1NLjz0XCNet0Qs9u2TK2gl1INgOclTq', 'http://p1q3gxdny.bkt.clouddn.com/default-avatar.png', NULL, NULL, 65, '2019-04-25 06:55:53', '0aad27a4-f666-41f9-b2c3-37a97fd7a2c2', NULL, b'0', 2);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
