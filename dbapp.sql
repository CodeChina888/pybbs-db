/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50721
Source Host           : localhost:3306
Source Database       : dbapp

Target Server Type    : MYSQL
Target Server Version : 50721
File Encoding         : 65001

Date: 2019-03-18 19:22:04
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admin_user
-- ----------------------------
DROP TABLE IF EXISTS `admin_user`;
CREATE TABLE `admin_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL DEFAULT '',
  `password` varchar(255) NOT NULL DEFAULT '',
  `in_time` datetime NOT NULL,
  `role_id` int(11) NOT NULL,
  `tag_id` int(11) DEFAULT NULL,
  `department` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `username` (`username`) USING BTREE,
  KEY `role_id` (`role_id`) USING BTREE,
  CONSTRAINT `admin_user_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of admin_user
-- ----------------------------
INSERT INTO `admin_user` VALUES ('1', 'admin', '$2a$10$wr5wNPtdAYCtR7pJHVjzm.duC3v2d3tXympYz171RgH7CZCzHGJZm', '2018-11-11 11:11:11', '1', '0', '', '', '');
INSERT INTO `admin_user` VALUES ('16', 'yufuyang', '$2a$10$.Bb7qaGLpCR7.fx0FNFSEOONgolg2j3QzUHyTFMLVags42MukELgC', '2019-03-10 07:49:38', '2', '12', 'anheng', '123', '1776972921@qq.com');
INSERT INTO `admin_user` VALUES ('17', 'yujiajun', '$2a$10$bERTznJKA7bM5.VO/pu4HeAcaba2MWF2bfhz8KipiSTr.C9feXIxK', '2019-03-10 07:50:02', '2', '13', 'anheng', '123', '1776972921@qq.com');

-- ----------------------------
-- Table structure for code
-- ----------------------------
DROP TABLE IF EXISTS `code`;
CREATE TABLE `code` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `code` varchar(255) NOT NULL DEFAULT '',
  `in_time` datetime NOT NULL,
  `expire_time` datetime NOT NULL,
  `email` varchar(255) NOT NULL DEFAULT '',
  `used` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `code` (`code`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  CONSTRAINT `code_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of code
-- ----------------------------

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
  CONSTRAINT `collect_ibfk_1` FOREIGN KEY (`topic_id`) REFERENCES `topic` (`id`),
  CONSTRAINT `collect_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of collect
-- ----------------------------

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext NOT NULL,
  `topic_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `in_time` datetime NOT NULL,
  `comment_id` int(11) DEFAULT NULL,
  `up_ids` text,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `topic_id` (`topic_id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of comment
-- ----------------------------

-- ----------------------------
-- Table structure for flyway_schema_history
-- ----------------------------
DROP TABLE IF EXISTS `flyway_schema_history`;
CREATE TABLE `flyway_schema_history` (
  `installed_rank` int(11) NOT NULL,
  `version` varchar(50) DEFAULT NULL,
  `description` varchar(200) NOT NULL,
  `type` varchar(20) NOT NULL,
  `script` varchar(1000) NOT NULL,
  `checksum` int(11) DEFAULT NULL,
  `installed_by` varchar(100) NOT NULL,
  `installed_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `execution_time` int(11) NOT NULL,
  `success` tinyint(1) NOT NULL,
  PRIMARY KEY (`installed_rank`) USING BTREE,
  KEY `flyway_schema_history_s_idx` (`success`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of flyway_schema_history
-- ----------------------------
INSERT INTO `flyway_schema_history` VALUES ('1', '1', 'initialize', 'SQL', 'V1__initialize.sql', '-1378939418', 'root', '2019-03-06 15:21:41', '789', '1');

-- ----------------------------
-- Table structure for notification
-- ----------------------------
DROP TABLE IF EXISTS `notification`;
CREATE TABLE `notification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `topic_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `target_user_id` int(11) NOT NULL,
  `action` varchar(255) NOT NULL DEFAULT '',
  `in_time` datetime NOT NULL,
  `read` bit(1) NOT NULL DEFAULT b'0',
  `content` longtext,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `topic_id` (`topic_id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `target_user_id` (`target_user_id`) USING BTREE,
  CONSTRAINT `notification_ibfk_3` FOREIGN KEY (`target_user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of notification
-- ----------------------------
INSERT INTO `notification` VALUES ('15', '7', '0', '4', 'check', '2019-03-10 08:06:13', '', 'two');
INSERT INTO `notification` VALUES ('16', '6', '0', '4', 'check', '2019-03-10 08:06:19', '', 'one');
INSERT INTO `notification` VALUES ('17', '7', '5', '4', 'COMMENT', '2019-03-10 08:06:44', '', '二');
INSERT INTO `notification` VALUES ('18', '7', '0', '4', 'check', '2019-03-11 01:43:29', '', 'two');
INSERT INTO `notification` VALUES ('19', '7', '0', '4', 'check', '2019-03-11 01:44:48', '', 'two');
INSERT INTO `notification` VALUES ('20', '7', '5', '4', 'COMMENT', '2019-03-11 01:59:16', '', '三');
INSERT INTO `notification` VALUES ('21', '7', '5', '4', 'COMMENT', '2019-03-11 01:59:23', '', '四');
INSERT INTO `notification` VALUES ('22', '6', '5', '4', 'COMMENT', '2019-03-11 03:06:22', '', '一');
INSERT INTO `notification` VALUES ('23', '6', '5', '4', 'COMMENT', '2019-03-11 03:06:28', '', '二');
INSERT INTO `notification` VALUES ('24', '6', '4', '5', 'REPLY', '2019-03-11 04:22:54', '\0', '@yujiajun 这样吗');
INSERT INTO `notification` VALUES ('25', '6', '4', '5', 'REPLY', '2019-03-11 04:29:31', '\0', '@yujiajun 就这样把');
INSERT INTO `notification` VALUES ('26', '6', '5', '4', 'COMMENT', '2019-03-11 04:51:30', '', '四');
INSERT INTO `notification` VALUES ('27', '6', '5', '4', 'COMMENT', '2019-03-11 04:51:40', '', '五');
INSERT INTO `notification` VALUES ('28', '6', '4', '5', 'REPLY', '2019-03-11 04:52:31', '\0', '@yujiajun 好困');
INSERT INTO `notification` VALUES ('29', '7', '5', '4', 'COMMENT', '2019-03-11 05:01:25', '', '五');
INSERT INTO `notification` VALUES ('30', '6', '4', '5', 'REPLY', '2019-03-11 05:03:47', '\0', '@yujiajun 再试一次');
INSERT INTO `notification` VALUES ('31', '6', '4', '5', 'REPLY', '2019-03-11 05:10:24', '\0', '@yujiajun 还来');
INSERT INTO `notification` VALUES ('32', '7', '5', '4', 'COMMENT', '2019-03-11 05:24:15', '', '@yujiajun saddsad');
INSERT INTO `notification` VALUES ('33', '6', '4', '5', 'REPLY', '2019-03-11 06:11:02', '\0', '@yujiajun 功能测试');
INSERT INTO `notification` VALUES ('34', '6', '6', '4', 'COMMENT', '2019-03-15 04:42:04', '\0', '111');
INSERT INTO `notification` VALUES ('35', '6', '6', '4', 'COMMENT', '2019-03-15 04:45:09', '\0', '222');
INSERT INTO `notification` VALUES ('36', '7', '6', '4', 'COMMENT', '2019-03-15 05:25:00', '\0', '333');
INSERT INTO `notification` VALUES ('37', '6', '6', '4', 'COMMENT', '2019-03-15 05:50:47', '\0', '3');
INSERT INTO `notification` VALUES ('38', '7', '6', '4', 'COMMENT', '2019-03-15 05:56:48', '\0', '4');
INSERT INTO `notification` VALUES ('39', '7', '6', '4', 'COMMENT', '2019-03-15 06:05:21', '\0', '5');
INSERT INTO `notification` VALUES ('40', '7', '6', '4', 'COMMENT', '2019-03-15 06:15:58', '\0', '2');
INSERT INTO `notification` VALUES ('41', '7', '6', '4', 'COMMENT', '2019-03-15 06:17:37', '\0', '666');
INSERT INTO `notification` VALUES ('42', '7', '6', '4', 'COMMENT', '2019-03-15 06:18:41', '\0', '999');
INSERT INTO `notification` VALUES ('43', '7', '6', '4', 'COMMENT', '2019-03-15 06:22:13', '\0', '222323213');
INSERT INTO `notification` VALUES ('44', '7', '6', '4', 'COMMENT', '2019-03-15 06:29:15', '\0', '22');
INSERT INTO `notification` VALUES ('45', '7', '6', '4', 'COMMENT', '2019-03-15 06:33:18', '\0', '44');
INSERT INTO `notification` VALUES ('46', '7', '6', '4', 'COMMENT', '2019-03-15 06:36:22', '\0', '1');
INSERT INTO `notification` VALUES ('47', '7', '6', '4', 'COMMENT', '2019-03-15 06:40:12', '\0', '222');
INSERT INTO `notification` VALUES ('48', '7', '6', '4', 'COMMENT', '2019-03-15 06:50:01', '\0', '111');
INSERT INTO `notification` VALUES ('49', '7', '6', '4', 'COMMENT', '2019-03-15 06:53:31', '\0', '312312');
INSERT INTO `notification` VALUES ('50', '7', '6', '4', 'COMMENT', '2019-03-15 06:55:30', '\0', '678');
INSERT INTO `notification` VALUES ('51', '7', '6', '4', 'COMMENT', '2019-03-15 06:57:36', '\0', '77');
INSERT INTO `notification` VALUES ('52', '7', '6', '4', 'COMMENT', '2019-03-15 06:59:16', '\0', '88');
INSERT INTO `notification` VALUES ('53', '7', '6', '4', 'COMMENT', '2019-03-15 07:07:22', '\0', '22');
INSERT INTO `notification` VALUES ('54', '7', '6', '4', 'COMMENT', '2019-03-15 07:08:46', '\0', '2');
INSERT INTO `notification` VALUES ('55', '7', '6', '4', 'COMMENT', '2019-03-15 07:09:14', '\0', '2');
INSERT INTO `notification` VALUES ('56', '7', '6', '4', 'COMMENT', '2019-03-15 07:12:42', '\0', '333');
INSERT INTO `notification` VALUES ('57', '7', '6', '4', 'COMMENT', '2019-03-15 07:13:28', '\0', '333');
INSERT INTO `notification` VALUES ('58', '7', '6', '4', 'COMMENT', '2019-03-15 07:14:29', '\0', '44');
INSERT INTO `notification` VALUES ('59', '7', '6', '4', 'COMMENT', '2019-03-15 07:17:41', '\0', '333');
INSERT INTO `notification` VALUES ('60', '7', '6', '4', 'COMMENT', '2019-03-15 07:28:35', '\0', '11313');

-- ----------------------------
-- Table structure for oauth_user
-- ----------------------------
DROP TABLE IF EXISTS `oauth_user`;
CREATE TABLE `oauth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `oauth_id` int(11) NOT NULL,
  `type` varchar(255) NOT NULL DEFAULT '',
  `login` varchar(255) NOT NULL DEFAULT '',
  `access_token` varchar(255) NOT NULL DEFAULT '',
  `in_time` datetime NOT NULL,
  `bio` text,
  `email` varchar(255) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  CONSTRAINT `oauth_user_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of oauth_user
-- ----------------------------

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` varchar(255) NOT NULL DEFAULT '',
  `pid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE,
  UNIQUE KEY `value` (`value`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES ('1', '首页', 'index', '0');
INSERT INTO `permission` VALUES ('2', '话题', 'topic', '0');
INSERT INTO `permission` VALUES ('3', '评论', 'comment', '0');
INSERT INTO `permission` VALUES ('4', '通知', 'notification', '0');
INSERT INTO `permission` VALUES ('5', '用户', 'user', '0');
INSERT INTO `permission` VALUES ('6', '验证码', 'code', '0');
INSERT INTO `permission` VALUES ('7', '标签', 'tag', '0');
INSERT INTO `permission` VALUES ('8', '权限', 'permission', '0');
INSERT INTO `permission` VALUES ('9', '系统', 'system', '0');
INSERT INTO `permission` VALUES ('10', '后台用户', 'admin_user', '0');
INSERT INTO `permission` VALUES ('11', '仪表盘', 'index:index', '1');
INSERT INTO `permission` VALUES ('12', '话题列表', 'topic:list', '2');
INSERT INTO `permission` VALUES ('13', '话题编辑', 'topic:edit', '2');
INSERT INTO `permission` VALUES ('14', '话题删除', 'topic:delete', '2');
INSERT INTO `permission` VALUES ('15', '话题加精', 'topic:good', '2');
INSERT INTO `permission` VALUES ('16', '话题置顶', 'topic:top', '2');
INSERT INTO `permission` VALUES ('17', '评论列表', 'comment:list', '3');
INSERT INTO `permission` VALUES ('18', '评论编辑', 'comment:edit', '3');
INSERT INTO `permission` VALUES ('19', '评论删除', 'comment:delete', '3');
INSERT INTO `permission` VALUES ('20', '通知列表', 'notification:list', '4');
INSERT INTO `permission` VALUES ('21', '通知删除', 'notification:delete', '4');
INSERT INTO `permission` VALUES ('22', '用户列表', 'user:list', '5');
INSERT INTO `permission` VALUES ('23', '用户编辑', 'user:edit', '5');
INSERT INTO `permission` VALUES ('24', '用户删除', 'user:delete', '5');
INSERT INTO `permission` VALUES ('25', '验证码列表', 'code:list', '6');
INSERT INTO `permission` VALUES ('26', '标签列表', 'tag:list', '7');
INSERT INTO `permission` VALUES ('27', '标签编辑', 'tag:edit', '7');
INSERT INTO `permission` VALUES ('28', '标签删除', 'tag:delete', '7');
INSERT INTO `permission` VALUES ('29', '标签同步', 'tag:async', '7');
INSERT INTO `permission` VALUES ('30', '权限列表', 'permission:list', '8');
INSERT INTO `permission` VALUES ('31', '权限编辑', 'permission:edit', '8');
INSERT INTO `permission` VALUES ('32', '权限删除', 'permission:delete', '8');
INSERT INTO `permission` VALUES ('33', '角色', 'role', '0');
INSERT INTO `permission` VALUES ('34', '日志', 'log', '0');
INSERT INTO `permission` VALUES ('35', '角色列表', 'role:list', '33');
INSERT INTO `permission` VALUES ('36', '角色编辑', 'role:edit', '33');
INSERT INTO `permission` VALUES ('37', '角色删除', 'role:delete', '33');
INSERT INTO `permission` VALUES ('38', '系统设置', 'system:edit', '9');
INSERT INTO `permission` VALUES ('39', '后台用户列表', 'admin_user:list', '10');
INSERT INTO `permission` VALUES ('40', '后台用户编辑', 'admin_user:edit', '10');
INSERT INTO `permission` VALUES ('41', '后台用户创建', 'admin_user:add', '10');
INSERT INTO `permission` VALUES ('42', '日志列表', 'log:list', '34');
INSERT INTO `permission` VALUES ('43', '用户刷新Token', 'user:refresh_token', '5');
INSERT INTO `permission` VALUES ('44', '权限添加', 'permission:add', '8');
INSERT INTO `permission` VALUES ('45', '索引单个话题', 'topic:index', '2');
INSERT INTO `permission` VALUES ('46', '索引全部话题', 'topic:index_all', '2');
INSERT INTO `permission` VALUES ('48', '删除索引', 'topic:delete_index', '2');
INSERT INTO `permission` VALUES ('49', '删除所有话题索引', 'topic:delete_all_index', '2');
INSERT INTO `permission` VALUES ('50', '添加板块', 'tag:add', '7');
INSERT INTO `permission` VALUES ('51', '后台用户删除', 'admin_user:delete', '10');
INSERT INTO `permission` VALUES ('52', '话题审核', 'topic:check', '2');
INSERT INTO `permission` VALUES ('53', '记录列表', 'record:list', '11');

-- ----------------------------
-- Table structure for record
-- ----------------------------
DROP TABLE IF EXISTS `record`;
CREATE TABLE `record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `origin_id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `operation` varchar(255) DEFAULT NULL,
  `method` varchar(255) DEFAULT NULL,
  `params` varchar(10000) DEFAULT NULL,
  `in_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=139 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of record
-- ----------------------------
INSERT INTO `record` VALUES ('129', '0', 'test', '编辑话题', 'edit', '{\"topic\":{\"inTime\":1552637259000,\"view\":3,\"top\":false,\"pass\":false,\"tagId\":15,\"collectCount\":0,\"id\":32,\"title\":\"我的一个小测试2\",\"good\":false,\"userId\":6,\"content\":\"2\",\"commentCount\":0},\"list\":[\"c\",\"c#\",\"java\",\"javascrip\"],\"tags\":\"c\"}', '2019-03-15 08:22:38');
INSERT INTO `record` VALUES ('130', '0', 'test', '更新话题', 'edit', '{\"title\":\"我的一个小测试233\",\"content\":\"2\",\"tags\":\"c\"}', '2019-03-15 08:22:40');
INSERT INTO `record` VALUES ('131', '0', 'test', '发表评论', 'create', '{\"topicId\":\"32\",\"commentId\":\"\",\"content\":\"222\"}', '2019-03-15 08:23:00');
INSERT INTO `record` VALUES ('132', '0', 'test', '更新评论', 'update', '{\"content\":\"2223\"}', '2019-03-15 08:23:03');
INSERT INTO `record` VALUES ('133', '0', 'test', '创建话题', 'create', '{\"title\":\"测试结果2\",\"content\":\"2\",\"tags\":\"c\"}', '2019-03-15 08:39:15');
INSERT INTO `record` VALUES ('134', '0', 'test', '创建话题', 'create', '{\"title\":\"我的一个小测试\",\"content\":\"java\",\"tags\":\"java\"}', '2019-03-18 05:35:13');
INSERT INTO `record` VALUES ('135', '0', 'test', '发表评论', 'create', '{\"topicId\":\"34\",\"commentId\":\"\",\"content\":\"测试结果\"}', '2019-03-18 05:42:01');
INSERT INTO `record` VALUES ('136', '0', 'test', '发表评论', 'create', '{\"topicId\":\"34\",\"commentId\":\"59\",\"content\":\"@test 测试如下\"}', '2019-03-18 05:42:14');
INSERT INTO `record` VALUES ('137', '0', 'test', '创建话题', 'create', '{\"title\":\"我的一个小测试2\",\"content\":\"2\",\"tags\":\"java\"}', '2019-03-18 05:52:04');
INSERT INTO `record` VALUES ('138', '0', 'test', '创建话题', 'create', '{\"title\":\"我的一个小测试2\",\"content\":\"1\",\"tags\":\"C#\"}', '2019-03-18 08:53:24');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('2', '审核员');
INSERT INTO `role` VALUES ('1', '超级管理员');

-- ----------------------------
-- Table structure for role_permission
-- ----------------------------
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission` (
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  KEY `role_id` (`role_id`) USING BTREE,
  KEY `permission_id` (`permission_id`) USING BTREE,
  CONSTRAINT `role_permission_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`),
  CONSTRAINT `role_permission_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of role_permission
-- ----------------------------
INSERT INTO `role_permission` VALUES ('1', '11');
INSERT INTO `role_permission` VALUES ('1', '12');
INSERT INTO `role_permission` VALUES ('1', '13');
INSERT INTO `role_permission` VALUES ('1', '14');
INSERT INTO `role_permission` VALUES ('1', '15');
INSERT INTO `role_permission` VALUES ('1', '16');
INSERT INTO `role_permission` VALUES ('1', '45');
INSERT INTO `role_permission` VALUES ('1', '46');
INSERT INTO `role_permission` VALUES ('1', '48');
INSERT INTO `role_permission` VALUES ('1', '49');
INSERT INTO `role_permission` VALUES ('1', '52');
INSERT INTO `role_permission` VALUES ('1', '17');
INSERT INTO `role_permission` VALUES ('1', '18');
INSERT INTO `role_permission` VALUES ('1', '19');
INSERT INTO `role_permission` VALUES ('1', '20');
INSERT INTO `role_permission` VALUES ('1', '21');
INSERT INTO `role_permission` VALUES ('1', '22');
INSERT INTO `role_permission` VALUES ('1', '23');
INSERT INTO `role_permission` VALUES ('1', '24');
INSERT INTO `role_permission` VALUES ('1', '43');
INSERT INTO `role_permission` VALUES ('1', '25');
INSERT INTO `role_permission` VALUES ('1', '26');
INSERT INTO `role_permission` VALUES ('1', '27');
INSERT INTO `role_permission` VALUES ('1', '28');
INSERT INTO `role_permission` VALUES ('1', '29');
INSERT INTO `role_permission` VALUES ('1', '50');
INSERT INTO `role_permission` VALUES ('1', '30');
INSERT INTO `role_permission` VALUES ('1', '31');
INSERT INTO `role_permission` VALUES ('1', '32');
INSERT INTO `role_permission` VALUES ('1', '44');
INSERT INTO `role_permission` VALUES ('1', '38');
INSERT INTO `role_permission` VALUES ('1', '39');
INSERT INTO `role_permission` VALUES ('1', '40');
INSERT INTO `role_permission` VALUES ('1', '41');
INSERT INTO `role_permission` VALUES ('1', '51');
INSERT INTO `role_permission` VALUES ('1', '35');
INSERT INTO `role_permission` VALUES ('1', '36');
INSERT INTO `role_permission` VALUES ('1', '37');
INSERT INTO `role_permission` VALUES ('1', '42');
INSERT INTO `role_permission` VALUES ('2', '11');
INSERT INTO `role_permission` VALUES ('2', '12');
INSERT INTO `role_permission` VALUES ('2', '13');
INSERT INTO `role_permission` VALUES ('2', '14');
INSERT INTO `role_permission` VALUES ('2', '15');
INSERT INTO `role_permission` VALUES ('2', '16');
INSERT INTO `role_permission` VALUES ('2', '52');
INSERT INTO `role_permission` VALUES ('2', '17');
INSERT INTO `role_permission` VALUES ('2', '18');
INSERT INTO `role_permission` VALUES ('2', '19');
INSERT INTO `role_permission` VALUES ('2', '26');
INSERT INTO `role_permission` VALUES ('1', '53');

-- ----------------------------
-- Table structure for system_config
-- ----------------------------
DROP TABLE IF EXISTS `system_config`;
CREATE TABLE `system_config` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `description` varchar(1000) NOT NULL,
  `pid` int(11) NOT NULL DEFAULT '0',
  `type` varchar(255) DEFAULT '',
  `option` varchar(255) DEFAULT NULL,
  `reboot` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of system_config
-- ----------------------------
INSERT INTO `system_config` VALUES ('1', 'admin_remember_me_max_age', '30', '登录后台记住我功能记住时间，单位：天', '23', 'number', null, '1');
INSERT INTO `system_config` VALUES ('2', 'base_url', 'http://localhost:8080', '网站部署后访问的域名，注意这个后面没有 \"/\"', '23', 'url', null, '0');
INSERT INTO `system_config` VALUES ('3', 'comment_layer', '1', '评论盖楼形式显示', '23', 'radio', null, '0');
INSERT INTO `system_config` VALUES ('4', 'cookie_domain', 'localhost', '存cookie时用到的域名，要与网站部署后访问的域名一致', '23', 'text', null, '0');
INSERT INTO `system_config` VALUES ('5', 'cookie_max_age', '604800', 'cookie有效期，单位秒，默认1周', '23', 'number', null, '0');
INSERT INTO `system_config` VALUES ('6', 'cookie_name', 'user_token', '存cookie时用到的名称', '23', 'text', null, '0');
INSERT INTO `system_config` VALUES ('7', 'create_comment_score', '5', '发布评论奖励的积分', '26', 'number', null, '0');
INSERT INTO `system_config` VALUES ('8', 'create_topic_score', '10', '创建话题奖励的积分', '26', 'number', null, '0');
INSERT INTO `system_config` VALUES ('9', 'delete_comment_score', '5', '删除评论要被扣除的积分', '26', 'number', null, '0');
INSERT INTO `system_config` VALUES ('10', 'delete_topic_score', '10', '删除话题要被扣除的积分', '26', 'number', null, '0');
INSERT INTO `system_config` VALUES ('11', 'intro', '<h5>这里是安恒信息</h5><p>在这里，您可以提问，回答，分享，诉说，欢迎您的加入！</p>', '站点介绍', '23', 'text', null, '0');
INSERT INTO `system_config` VALUES ('12', 'mail_host', 'smtp.qq.com', '邮箱的smtp服务器地址', '24', 'text', null, '0');
INSERT INTO `system_config` VALUES ('13', 'mail_password', '', '发送邮件的邮箱密码', '24', 'password', null, '0');
INSERT INTO `system_config` VALUES ('14', 'mail_username', 'xxoo@qq.com', '发送邮件的邮箱地址', '24', 'email', null, '0');
INSERT INTO `system_config` VALUES ('15', 'name', '安环信息', '站点名称', '23', 'text', null, '0');
INSERT INTO `system_config` VALUES ('16', 'page_size', '8', '分页每页条数', '23', 'number', null, '0');
INSERT INTO `system_config` VALUES ('17', 'websocket', '0', '是否开启websocket功能', '45', 'radio', null, '1');
INSERT INTO `system_config` VALUES ('18', 'static_url', 'http://120.78.185.50:8080/static/upload/', '静态文件访问地址，主要用于上传图片的访问，注意最后有个\"/\"', '25', 'url', null, '0');
INSERT INTO `system_config` VALUES ('19', 'up_comment_score', '3', '点赞评论奖励评论作者的积分', '26', 'number', null, '0');
INSERT INTO `system_config` VALUES ('20', 'upload_avatar_size_limit', '2', '上传头像文件大小，单位MB，默认2MB', '25', 'number', null, '0');
INSERT INTO `system_config` VALUES ('21', 'upload_path', '/dockefile/pybbs/static/upload/', '上传文件的路径，注意最后有个\"/\"', '25', 'text', null, '0');
INSERT INTO `system_config` VALUES ('22', 'up_topic_score', '3', '点赞话题奖励话题作者的积分', '26', 'number', null, '0');
INSERT INTO `system_config` VALUES ('23', null, null, '基础配置', '0', null, null, '0');
INSERT INTO `system_config` VALUES ('24', null, null, '邮箱配置', '0', null, null, '0');
INSERT INTO `system_config` VALUES ('25', null, null, '上传配置', '0', null, null, '0');
INSERT INTO `system_config` VALUES ('26', null, null, '积分配置', '0', null, null, '0');
INSERT INTO `system_config` VALUES ('27', null, null, 'Redis配置', '0', null, null, '0');
INSERT INTO `system_config` VALUES ('29', 'redis_host', '', 'redis服务host地址', '27', 'text', null, '0');
INSERT INTO `system_config` VALUES ('30', 'redis_port', '', 'redis服务端口（默认: 6379）', '27', 'number', null, '0');
INSERT INTO `system_config` VALUES ('31', 'redis_password', '', 'redis服务密码', '27', 'password', null, '0');
INSERT INTO `system_config` VALUES ('32', 'redis_timeout', '2000', '网站连接redis服务超时时间，单位毫秒', '27', 'number', null, '0');
INSERT INTO `system_config` VALUES ('33', 'redis_database', '0', '网站连接redis服务的哪个数据库，默认0号数据库，取值范围0-15', '27', 'number', null, '0');
INSERT INTO `system_config` VALUES ('34', 'redis_ssl', '0', 'redis服务是否开启认证连接', '27', 'radio', null, '0');
INSERT INTO `system_config` VALUES ('35', null, null, 'Elasticsearch配置', '0', null, null, '0');
INSERT INTO `system_config` VALUES ('36', 'elasticsearch_host', '', 'elasticsearch服务的地址', '35', 'text', null, '0');
INSERT INTO `system_config` VALUES ('37', 'elasticsearch_port', '', 'elasticsearch服务的http端口', '35', 'number', null, '0');
INSERT INTO `system_config` VALUES ('38', 'elasticsearch_index', '', '索引的名字', '35', 'text', null, '0');
INSERT INTO `system_config` VALUES ('39', 'search', '0', '是否开启搜索功能（如果开启，需要额外启动一个ES服务，并填好ES相关的配置）', '35', 'radio', null, '0');
INSERT INTO `system_config` VALUES ('40', null, null, 'Github登录配置，<a href=\"https://github.com/settings/developers\" target=\"_blank\">申请地址</a>', '0', '', null, '0');
INSERT INTO `system_config` VALUES ('41', 'oauth_github_client_id', '', 'Github登录配置项ClientId', '40', 'text', null, '0');
INSERT INTO `system_config` VALUES ('42', 'oauth_github_client_secret', '', 'Github登录配置项ClientSecret', '40', 'text', null, '0');
INSERT INTO `system_config` VALUES ('43', 'oauth_github_callback_url', '', 'Github登录配置项回调地址', '40', 'url', null, '0');
INSERT INTO `system_config` VALUES ('44', 'topic_view_increase_interval', '600', '同一个用户浏览同一个话题多长时间算一次浏览量，默认10分钟，单位秒（只有当配置了redis才会生效）', '23', 'number', null, '0');
INSERT INTO `system_config` VALUES ('45', null, null, 'WebSocket，开启后可不用刷新页面接收页面消息', '0', '', null, '0');
INSERT INTO `system_config` VALUES ('46', 'websocket_host', '', 'websocket服务的主机名，这个跟cookie的域名设置成一样的就可以了', '45', 'text', null, '1');
INSERT INTO `system_config` VALUES ('47', 'websocket_port', '', 'websocket服务的端口，不能跟论坛服务端口一样，其它随便设置', '45', 'number', null, '1');
INSERT INTO `system_config` VALUES ('48', 'theme', 'default', '系统主题', '23', 'select', 'default,simple', '0');

-- ----------------------------
-- Table structure for tag
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(1000) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `topic_count` int(11) NOT NULL DEFAULT '0',
  `in_time` datetime NOT NULL,
  `admin_id` int(11) DEFAULT '0',
  `admin_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tag
-- ----------------------------
INSERT INTO `tag` VALUES ('17', 'springmvc', '这是一个springmvc板块', null, '0', '2019-03-18 05:31:08', '0', null);

-- ----------------------------
-- Table structure for topic
-- ----------------------------
DROP TABLE IF EXISTS `topic`;
CREATE TABLE `topic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '',
  `content` longtext,
  `in_time` datetime NOT NULL,
  `modify_time` datetime DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `comment_count` int(11) NOT NULL DEFAULT '0',
  `collect_count` int(11) NOT NULL DEFAULT '0',
  `view` int(11) NOT NULL DEFAULT '0',
  `top` bit(1) NOT NULL DEFAULT b'0',
  `good` bit(1) NOT NULL DEFAULT b'0',
  `up_ids` text,
  `tag_id` int(11) NOT NULL,
  `pass` bit(1) DEFAULT b'0',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `title` (`title`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of topic
-- ----------------------------

-- ----------------------------
-- Table structure for topic_tag
-- ----------------------------
DROP TABLE IF EXISTS `topic_tag`;
CREATE TABLE `topic_tag` (
  `tag_id` int(11) NOT NULL,
  `topic_id` int(11) NOT NULL,
  KEY `tag_id` (`tag_id`) USING BTREE,
  KEY `topic_id` (`topic_id`) USING BTREE,
  CONSTRAINT `topic_tag_ibfk_1` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`),
  CONSTRAINT `topic_tag_ibfk_2` FOREIGN KEY (`topic_id`) REFERENCES `topic` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of topic_tag
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `origin_id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL DEFAULT '',
  `password` varchar(255) DEFAULT '',
  `avatar` varchar(1000) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `bio` varchar(1000) DEFAULT NULL,
  `score` int(11) NOT NULL DEFAULT '0',
  `in_time` datetime NOT NULL,
  `token` varchar(255) NOT NULL DEFAULT '',
  `telegram_name` varchar(255) DEFAULT NULL,
  `email_notification` bit(1) NOT NULL DEFAULT b'0',
  `message` bigint(255) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `username` (`username`) USING BTREE,
  UNIQUE KEY `token` (`token`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('4', '0', 'yufuyang', '$2a$10$MKpzmLCebYMqeCLW8pD2/ecWU6ofKYnjNkfnykWzs6YHQjrrv2WV6', null, null, null, '65', '2019-03-10 07:50:54', 'b04b1ac5-d45f-4808-84b0-d8eac1b15682', null, '\0', '27');
INSERT INTO `user` VALUES ('5', '0', 'yujiajun', '$2a$10$p8CEhzMRsAFph2khMSPNtORwFDVyjFqnZsiNV1DwmYxZZCHmRaGoG', null, null, null, '45', '2019-03-10 08:05:49', '310655ee-121d-45c5-b2a2-938a645b32a5', null, '\0', '0');
INSERT INTO `user` VALUES ('6', '0', 'test', '$2a$10$fPKYEXWvltG2xGpXjqLWCOeV/25sMa06.YATRiLQumAL7mliCL7MK', 'http://localhost:8080/static/upload/avatar/test/avatar.png', null, null, '410', '2019-03-11 06:01:11', '5e431eb4-7ae1-460c-846b-293cc9c8673d', null, '\0', '0');
INSERT INTO `user` VALUES ('7', '1195', '会员0b3f0a635e719f04', '$2a$10$c1JVjk75gKvDqjX9fhslIuf3eekm.SG0Ztm9Yqw7nGIkFQnlMoYii', 'http://p1q3gxdny.bkt.clouddn.com/default-avatar.png', null, null, '0', '2019-03-14 02:16:43', 'f80d861c-edb4-4255-a3b8-4adc7d3713cf', null, '\0', '0');
