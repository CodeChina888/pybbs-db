/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50721
Source Host           : localhost:3306
Source Database       : pybbs

Target Server Type    : MYSQL
Target Server Version : 50721
File Encoding         : 65001

Date: 2019-03-08 15:32:50
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of admin_user
-- ----------------------------
INSERT INTO `admin_user` VALUES ('1', 'admin', '$2a$10$nyYFQsw.vc3oIAi2CoZJJOO7MBOP3zqLU3YHEpeOU1YPLAheSJi5q', '2018-11-11 11:11:11', '1', '0', '', null, null);
INSERT INTO `admin_user` VALUES ('2', 'fuyang', '$2a$10$tc2Pyjpad3J9JSzzjk0gaOkL5cYMyJ/gtTtT4xKUdBzvkH.2HCnLK', '2019-03-06 07:46:57', '2', '7', '', '', '');
INSERT INTO `admin_user` VALUES ('3', 'hongzhi', '$2a$10$TUF8z4okCVIRBnPwvlWot.wuZiusqUbpGjOIkOv.vebdZbFn7/Ri6', '2019-03-06 07:59:29', '2', '2', '', null, null);
INSERT INTO `admin_user` VALUES ('4', 'liangxuan', '$2a$10$vlmE1GoMpkKVkzEMyBIJ5.O/dTZPMo33ib/RcOXtRkmtTOB8IlrCu', '2019-03-06 08:05:13', '2', '5', '', '', '');

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
INSERT INTO `collect` VALUES ('3', '2', '2019-03-06 08:14:59');

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
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`topic_id`) REFERENCES `topic` (`id`),
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES ('1', 'one', '1', '2', '2019-03-06 08:12:53', null, null);
INSERT INTO `comment` VALUES ('2', 'two', '2', '2', '2019-03-06 08:13:00', null, null);
INSERT INTO `comment` VALUES ('3', 'three', '3', '2', '2019-03-06 08:13:07', null, null);
INSERT INTO `comment` VALUES ('4', '222', '1', '3', '2019-03-08 05:15:14', null, null);
INSERT INTO `comment` VALUES ('5', '1', '3', '2', '2019-03-08 06:20:43', null, null);
INSERT INTO `comment` VALUES ('6', '221', '4', '3', '2019-03-08 06:21:10', null, null);

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
  CONSTRAINT `notification_ibfk_1` FOREIGN KEY (`topic_id`) REFERENCES `topic` (`id`),
  CONSTRAINT `notification_ibfk_3` FOREIGN KEY (`target_user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of notification
-- ----------------------------
INSERT INTO `notification` VALUES ('1', '1', '2', '1', 'COMMENT', '2019-03-06 08:12:53', '\0', 'one');
INSERT INTO `notification` VALUES ('2', '2', '2', '1', 'COMMENT', '2019-03-06 08:13:00', '\0', 'two');
INSERT INTO `notification` VALUES ('3', '3', '2', '1', 'COMMENT', '2019-03-06 08:13:07', '\0', 'three');
INSERT INTO `notification` VALUES ('4', '3', '2', '1', 'COLLECT', '2019-03-06 08:14:59', '\0', null);
INSERT INTO `notification` VALUES ('7', '4', '0', '2', 'check', '2019-03-08 03:04:22', '', '第四个');
INSERT INTO `notification` VALUES ('8', '1', '3', '1', 'COMMENT', '2019-03-08 05:15:14', '\0', '222');
INSERT INTO `notification` VALUES ('9', '3', '2', '1', 'COMMENT', '2019-03-08 06:20:43', '\0', '1');
INSERT INTO `notification` VALUES ('10', '4', '3', '2', 'COMMENT', '2019-03-08 06:21:10', '', '221');
INSERT INTO `notification` VALUES ('11', '4', '0', '2', 'check', '2019-03-08 06:22:10', '\0', '第四个');

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
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

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
INSERT INTO `system_config` VALUES ('11', 'intro', '<h5>属于Java语言的bbs</h5><p>在这里，您可以提问，回答，分享，诉说，这是个属于Java程序员的社区，欢迎您的加入！</p>', '站点介绍', '23', 'text', null, '0');
INSERT INTO `system_config` VALUES ('12', 'mail_host', 'smtp.qq.com', '邮箱的smtp服务器地址', '24', 'text', null, '0');
INSERT INTO `system_config` VALUES ('13', 'mail_password', '', '发送邮件的邮箱密码', '24', 'password', null, '0');
INSERT INTO `system_config` VALUES ('14', 'mail_username', 'xxoo@qq.com', '发送邮件的邮箱地址', '24', 'email', null, '0');
INSERT INTO `system_config` VALUES ('15', 'name', '朋也社区', '站点名称', '23', 'text', null, '0');
INSERT INTO `system_config` VALUES ('16', 'page_size', '20', '分页每页条数', '23', 'number', null, '0');
INSERT INTO `system_config` VALUES ('17', 'websocket', '0', '是否开启websocket功能', '45', 'radio', null, '1');
INSERT INTO `system_config` VALUES ('18', 'static_url', 'http://localhost:8080/static/upload/', '静态文件访问地址，主要用于上传图片的访问，注意最后有个\"/\"', '25', 'url', null, '0');
INSERT INTO `system_config` VALUES ('19', 'up_comment_score', '3', '点赞评论奖励评论作者的积分', '26', 'number', null, '0');
INSERT INTO `system_config` VALUES ('20', 'upload_avatar_size_limit', '2', '上传头像文件大小，单位MB，默认2MB', '25', 'number', null, '0');
INSERT INTO `system_config` VALUES ('21', 'upload_path', '/Users/hh/git/github/pybbs/static/upload/', '上传文件的路径，注意最后有个\"/\"', '25', 'text', null, '0');
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tag
-- ----------------------------
INSERT INTO `tag` VALUES ('1', 'java', '', null, '0', '2019-03-06 07:44:32', '2', 'fuyang');
INSERT INTO `tag` VALUES ('2', 'python', '', null, '1', '2019-03-06 07:44:39', '3', 'hongzhi');
INSERT INTO `tag` VALUES ('3', 'c', '', null, '1', '2019-03-06 07:46:01', '0', '');
INSERT INTO `tag` VALUES ('4', 'c#', '', null, '1', '2019-03-06 07:46:08', '0', '');
INSERT INTO `tag` VALUES ('5', 'c++', '', null, '1', '2019-03-06 07:46:14', '4', 'liangxuan');
INSERT INTO `tag` VALUES ('6', 'javascrip', '', null, '0', '2019-03-06 09:25:09', '0', '');
INSERT INTO `tag` VALUES ('7', 'wechat', '', null, '0', '2019-03-06 09:25:48', '2', 'fuyang');
INSERT INTO `tag` VALUES ('8', 'javascript', 'javascript', null, '0', '2019-03-08 06:52:42', '0', null);

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
  KEY `user_id` (`user_id`) USING BTREE,
  CONSTRAINT `topic_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of topic
-- ----------------------------
INSERT INTO `topic` VALUES ('1', '第一', '第一个', '2019-03-06 07:47:55', '2019-03-06 07:50:41', '1', '2', '0', '6', '\0', '\0', null, '1', '');
INSERT INTO `topic` VALUES ('2', '第二', '第二个', '2019-03-06 08:01:01', '2019-03-06 08:01:28', '1', '1', '0', '3', '\0', '\0', null, '2', '');
INSERT INTO `topic` VALUES ('3', '第三', '第三个', '2019-03-06 08:06:24', '2019-03-06 08:07:02', '1', '2', '1', '5', '\0', '\0', null, '3', '');
INSERT INTO `topic` VALUES ('4', '第四', '第四个', '2019-03-06 08:15:39', '2019-03-08 06:22:10', '2', '1', '0', '5', '\0', '\0', null, '5', '\0');

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
  `username` varchar(255) NOT NULL DEFAULT '',
  `password` varchar(255) DEFAULT '',
  `avatar` varchar(1000) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `bio` varchar(1000) DEFAULT NULL,
  `score` int(11) NOT NULL DEFAULT '0',
  `in_time` datetime NOT NULL,
  `token` varchar(255) NOT NULL DEFAULT '',
  `telegram_name` varchar(255) DEFAULT NULL,
  `email_notification` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `username` (`username`) USING BTREE,
  UNIQUE KEY `token` (`token`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'fuyang', '$2a$10$nyhjCYARfj.27y5d27o2muexAiRRRgi/VkdnP5fn.jxO8bVgB3m86', null, null, null, null, '30', '2019-03-06 07:47:34', '7d4daf28-3d7a-447b-8bf5-b5ef78045c99', null, '\0');
INSERT INTO `user` VALUES ('2', 'hongzhi', '$2a$10$CIhh87vkR7.IAmHnzis1pOXZFHC3ePeUNEYkhVwIT0AbtcBjjxcAq', null, null, null, null, '30', '2019-03-06 08:12:41', 'bb2f2b82-591d-43a5-a8a7-4c0905ac1473', null, '\0');
INSERT INTO `user` VALUES ('3', 'test', '$2a$10$xSnn8JotgiqmwV1MxqIVVewsOPu0ljRYJB0n8PPu2wFiJ90rwzcOe', 'http://localhost:8080/static/upload/avatar/test/avatar.png', null, null, null, '10', '2019-03-08 05:15:00', '34af2c2e-5363-43a8-8ffe-26ac5efd7526', null, '\0');
