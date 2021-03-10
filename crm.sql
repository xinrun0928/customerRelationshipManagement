/*
Navicat MySQL Data Transfer

Source Server         : windows
Source Server Version : 50537
Source Host           : localhost:3306
Source Database       : crm

Target Server Type    : MYSQL
Target Server Version : 50537
File Encoding         : 65001

Date: 2021-03-03 16:32:11
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for tbl_activity
-- ----------------------------
DROP TABLE IF EXISTS `tbl_activity`;
CREATE TABLE `tbl_activity` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `startDate` char(10) DEFAULT NULL,
  `endDate` char(10) DEFAULT NULL,
  `cost` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_activity
-- ----------------------------
INSERT INTO `tbl_activity` VALUES ('a6756ed4b4d04278b25900e885846834', '40f6cdea0bd34aceb77492a1656d9fb3', '发传单8', '2021-02-04', '2021-02-08', '10000', '123', '2021-02-10 08:54:40', 'admin', null, null);
INSERT INTO `tbl_activity` VALUES ('ab20cd3ae2e64e0fbb46b144b4802def', '40f6cdea0bd34aceb77492a1656d9fb3', '发传单34w', '2021-01-31', '2021-02-19', '123', 'dsafadsf', '2021-02-10 12:51:38', 'admin', '2021-02-10 14:34:42', 'admin');
INSERT INTO `tbl_activity` VALUES ('df5c838d8d6640188cb69d592a919c29', '40f6cdea0dd34aceb77292a1656d9fb3', '发传单999', '2021-02-02', '2021-02-11', '100000', '描述1236', '2021-02-10 08:54:44', 'admin', '2021-02-19 23:53:59', '系统维护工程师');

-- ----------------------------
-- Table structure for tbl_activity_remark
-- ----------------------------
DROP TABLE IF EXISTS `tbl_activity_remark`;
CREATE TABLE `tbl_activity_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL COMMENT '0表示未修改，1表示已修改',
  `activityId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_activity_remark
-- ----------------------------
INSERT INTO `tbl_activity_remark` VALUES ('0ab57e8d2e4c414a8556753648358444', 'aaaaaaaaaaaaaaaaaaaaaaaa', '2021-02-21 11:58:20', '系统维护工程师', null, null, '0', '3d9a41bad6cb4cc7a57b33c872b7bf5b');
INSERT INTO `tbl_activity_remark` VALUES ('0acbd1c043c04c8c821cd23edf9a1653', '市场活动备注信息1', '2021-02-19 23:08:42', '系统维护工程师', null, null, '0', 'ab20cd3ae2e64e0fbb46b144b4802def');
INSERT INTO `tbl_activity_remark` VALUES ('284580f1c5ba425b92a5a127287791ff', 'hhhhasdfad', '2021-02-10 20:28:22', 'admin', '2021-02-10 20:28:36', 'admin', '1', 'df5c838d8d6640188cb69d592a919c29');
INSERT INTO `tbl_activity_remark` VALUES ('38e472a676514279a089ebec105bddc0', 'qwerreqwr', '2021-02-10 20:28:29', 'admin', null, null, '0', 'df5c838d8d6640188cb69d592a919c29');
INSERT INTO `tbl_activity_remark` VALUES ('40f6cdea0bd34aceb77492a1656d4', '传单（发传单9）', '2021-01-08', 'sdf', '2021-02-03', 'sdfsd', '0', 'df5c838d8d6640188cb69d592a919c29');
INSERT INTO `tbl_activity_remark` VALUES ('6262907ded6c4dd28363627dbd384cc8', '市场活动备注信息3', '2021-02-19 23:08:58', '系统维护工程师', null, null, '0', 'ab20cd3ae2e64e0fbb46b144b4802def');
INSERT INTO `tbl_activity_remark` VALUES ('683cd11870294bb6baf3efcf821c36b5', '1111111111111', '2021-02-21 11:52:51', '系统维护工程师', null, null, '0', '395bf914efca45b2bdda6a27f5b4e388');
INSERT INTO `tbl_activity_remark` VALUES ('7067dbd09b664a2999a71e8075899e04', 'asdf', '2021-02-21 12:23:31', '系统维护工程师', null, null, '0', '96eacf97f82a4ce2ba356822c8b8d7b3');
INSERT INTO `tbl_activity_remark` VALUES ('778e3a924cca47d9b20c26225aec411f', 'zhangxinrun', '2021-02-21 12:09:19', '系统维护工程师', null, null, '0', 'd52fe6778a6c49e78b12b824342236a8');
INSERT INTO `tbl_activity_remark` VALUES ('7ba5fc59a7c04133ba1d59b25dcf8420', 'bbbbbbbbbbbbbbbbbbbbbbbbb', '2021-02-21 11:58:25', '系统维护工程师', null, null, '0', '3d9a41bad6cb4cc7a57b33c872b7bf5b');
INSERT INTO `tbl_activity_remark` VALUES ('7d5ce9ca682d4f849677c28f2f60f573', 'sdafassadf', '2021-02-21 12:21:03', '系统维护工程师', null, null, '0', '082d8e228a28469586575534d6c98007');
INSERT INTO `tbl_activity_remark` VALUES ('7e58c578521540ce9b6484b26494739a', 'ccccccccccccccccccccccc', '2021-02-21 11:58:29', '系统维护工程师', null, null, '0', '3d9a41bad6cb4cc7a57b33c872b7bf5b');
INSERT INTO `tbl_activity_remark` VALUES ('8d30da5cd0fa49cc85d0c5c46d074d28', '市场活动备注信息2', '2021-02-19 23:12:22', '系统维护工程师', null, null, '0', 'ab20cd3ae2e64e0fbb46b144b4802def');
INSERT INTO `tbl_activity_remark` VALUES ('99306d51e8974b46b59c3b0864da3f60', 'asfds', '2021-02-21 12:21:07', '系统维护工程师', null, null, '0', '082d8e228a28469586575534d6c98007');
INSERT INTO `tbl_activity_remark` VALUES ('9c27135d3c3d4a1abdb9e79728e6677e', 'asdfasd', '2021-02-21 12:23:28', '系统维护工程师', null, null, '0', '96eacf97f82a4ce2ba356822c8b8d7b3');
INSERT INTO `tbl_activity_remark` VALUES ('badd573139ac4c8b85a5dc58d91f1f5b', 'zhangxinrun', '2021-02-21 12:09:13', '系统维护工程师', null, null, '0', 'd52fe6778a6c49e78b12b824342236a8');
INSERT INTO `tbl_activity_remark` VALUES ('c59c8ae68cb94ee5a5fdbd988a8a417c', '市场活动备注信息5', '2021-02-10 20:12:22', 'admin', '2021-02-19 23:09:35', '系统维护工程师', '1', 'ab20cd3ae2e64e0fbb46b144b4802def');
INSERT INTO `tbl_activity_remark` VALUES ('ef50ff9515f8408c8108f5fb78e0b84b', '市场活动备注信息4', '2021-02-10 20:16:49', 'admin', '2021-02-19 23:09:24', '系统维护工程师', '1', 'ab20cd3ae2e64e0fbb46b144b4802def');
INSERT INTO `tbl_activity_remark` VALUES ('f5a669278e7b43d1b9e3d4cc306d1384', '2222222222222', '2021-02-21 11:52:55', '系统维护工程师', null, null, '0', '395bf914efca45b2bdda6a27f5b4e388');
INSERT INTO `tbl_activity_remark` VALUES ('f62bdc88cff349888aa577ff7d25c9b8', 'sadfdasf', '2021-02-10 20:28:26', 'admin', null, null, '0', 'df5c838d8d6640188cb69d592a919c29');

-- ----------------------------
-- Table structure for tbl_clue
-- ----------------------------
DROP TABLE IF EXISTS `tbl_clue`;
CREATE TABLE `tbl_clue` (
  `id` char(32) NOT NULL,
  `fullname` varchar(255) DEFAULT NULL,
  `appellation` varchar(255) DEFAULT NULL,
  `owner` char(32) DEFAULT NULL,
  `company` varchar(255) DEFAULT NULL,
  `job` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `mphone` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_clue
-- ----------------------------
INSERT INTO `tbl_clue` VALUES ('9028ab77c80e47df9ce25632abe4f412', '马云', '先生', '40f6cdea0bd34aceb77492a1656d9fb3', '阿里巴巴', 'CEO', 'alibab@qq.com', '3167856', 'www.alibaba.com', '13888888888', '将来联系', '聊天', 'admin', '2021-02-11 13:18:34', '系统维护工程师', '2021-02-21 20:44:08', '线索描述123', '联系纪要123', '2013-12-1', '杭州西湖');
INSERT INTO `tbl_clue` VALUES ('9028ab77c80e47df9ce25632abe4f466', '马云', '先生', '40f6cdea0bd34aceb77492a1656d9fb3', '阿里巴巴', 'CEO', 'alibab@qq.com', '3167856', 'www.alibaba.com', '13888888888', '将来联系', '聊天', 'admin', '2021-02-11 13:18:34', '系统维护工程师', '2021-02-21 20:44:08', '线索描述123', '联系纪要123', '2013-12-1', '杭州西湖');

-- ----------------------------
-- Table structure for tbl_clue_activity_relation
-- ----------------------------
DROP TABLE IF EXISTS `tbl_clue_activity_relation`;
CREATE TABLE `tbl_clue_activity_relation` (
  `id` char(32) NOT NULL,
  `clueId` char(32) DEFAULT NULL,
  `activityId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_clue_activity_relation
-- ----------------------------
INSERT INTO `tbl_clue_activity_relation` VALUES ('138b27122e07471e80ec2fe03340c49b', '9028ab77c80e47df9ce25632abe4f412', 'a6756ed4b4d04278b25900e885846834');

-- ----------------------------
-- Table structure for tbl_clue_remark
-- ----------------------------
DROP TABLE IF EXISTS `tbl_clue_remark`;
CREATE TABLE `tbl_clue_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `clueId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_clue_remark
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_contacts
-- ----------------------------
DROP TABLE IF EXISTS `tbl_contacts`;
CREATE TABLE `tbl_contacts` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `customerId` char(32) DEFAULT NULL,
  `fullname` varchar(255) DEFAULT NULL,
  `appellation` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mphone` varchar(255) DEFAULT NULL,
  `job` varchar(255) DEFAULT NULL,
  `birth` char(10) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_contacts
-- ----------------------------
INSERT INTO `tbl_contacts` VALUES ('1ce4f5e55fa840c083dc4c9eee46875c', '40f6cdea0bd34aceb77492a1656d9fb3', '聊天', 'd5bde91390fb4d03b96ec70a5d6dae86', '马云', '先生', 'alibab@qq.com', '13888888888', 'CEO', '2021-02-23', '系统维护工程师', '2021-02-21 21:00:32', null, null, '线索描述123', '联系纪要123', '2013-12-1', '杭州西湖');
INSERT INTO `tbl_contacts` VALUES ('4797346e6f0941c59c7f19f6350bf1bf', '40f6cdea0dd34aceb77292a1656d9fb3', 'web下载', 'b5dd2cdc65ce4e3d8d5094fc196daeff', '马化腾', '先生', '3132432@qq.com', '12431241234', '总裁', '2021-02-23', '系统维护工程师', '2021-02-16 23:24:15', null, null, 'dasf', 'asfdasd', '2021-02-16', '深圳市');
INSERT INTO `tbl_contacts` VALUES ('5d5197d856634539a396a56d9cda8bf1', '40f6cdea0dd34aceb77292a1656d9fb3', '员工介绍', '25e5278498f64486a2e29bfdc0141d8f', '小刘', '女士', 'xiaoliu@qq.com', '112233445566', '化妆品检测师', '2020-01-01', '系统维护工程师', '2021-02-16 23:14:22', null, null, '我是独一无二的', '联系纪要123', '2020-03-30', '广东省广州市白云区');
INSERT INTO `tbl_contacts` VALUES ('5e42e1ee8ef2416485f05dfcfc5cbfd3', '40f6cdea0bd34aceb77492a1656d9fb3', '广告', 'db219cfef08744949e18c30d4de053ed', '王健林', '先生', 'hengda@qq.com', '13666666666', 'CEO', '2021-02-13', '管理员', '2021-02-13 16:12:24', null, null, '线索描述123', '联系纪要123', '2013-12-1', '深圳');
INSERT INTO `tbl_contacts` VALUES ('6f520dedd025452db898918713d84eb9', '40f6cdea0bd34aceb77492a1656d9fb3', '合作伙伴研讨会', '239f2916997f43c8a323fbeb9605401f', 'xiaoxiao zhang', '博士', '2314@qq.com', '2343214324', 'Java', '2021-02-13', 'admin', '2021-02-12 15:37:54', null, null, 'sdasdasdaf', 'sdffdsfsfdsf', '2013-12-1', 'guangdong');

-- ----------------------------
-- Table structure for tbl_contacts_activity_relation
-- ----------------------------
DROP TABLE IF EXISTS `tbl_contacts_activity_relation`;
CREATE TABLE `tbl_contacts_activity_relation` (
  `id` char(32) NOT NULL,
  `contactsId` char(32) DEFAULT NULL,
  `activityId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_contacts_activity_relation
-- ----------------------------
INSERT INTO `tbl_contacts_activity_relation` VALUES ('15e42f4edd244045806089c5dc4621bd', '1ce4f5e55fa840c083dc4c9eee46875c', '29de8f6b66504a508ac1f43b06e87b05');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('26ddd0aca1ff436b9b730766e7ecd284', '6f520dedd025452db898918713d84eb9', 'f9f95d822d164e9692c5e2b3db455465');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('3ee9e3c2e88945b29ecb4cfda8803773', '5e42e1ee8ef2416485f05dfcfc5cbfd3', 'a6756ed4b4d04278b25900e885846834');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('41d1e1626fb54612bbfe9ab675cd06da', '5e42e1ee8ef2416485f05dfcfc5cbfd3', '93129eba43204cdebfef25526bcb0b7f');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('4f7981f7c64140dda99a5bc78a57823a', '5e42e1ee8ef2416485f05dfcfc5cbfd3', '29de8f6b66504a508ac1f43b06e87b05');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('6dfd9ef42b0e46db991cbdc172008af2', '5e42e1ee8ef2416485f05dfcfc5cbfd3', '082d8e228a28469586575534d6c98007');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('751892b3e2d34cdba46694dc10155106', '6f520dedd025452db898918713d84eb9', '685e26fef44b4cc0a9626d10aa66c7bc');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('76e07348cde24d49801b0a9fc3808381', '5e42e1ee8ef2416485f05dfcfc5cbfd3', '93461119cdf64121810e9bf3c8a64633');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('7ae7ff5466c645f7a9540840e92fe83a', '5e42e1ee8ef2416485f05dfcfc5cbfd3', 'f9f95d822d164e9692c5e2b3db455465');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('9e147a01e66d434d91abb99b060d783d', '5e42e1ee8ef2416485f05dfcfc5cbfd3', 'ab20cd3ae2e64e0fbb46b144b4802def');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('ba105206eb5540138378525efacbf18d', '5e42e1ee8ef2416485f05dfcfc5cbfd3', 'df5c838d8d6640188cb69d592a919c29');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('d44d6944725947c981ca7c93b5ea7814', '5e42e1ee8ef2416485f05dfcfc5cbfd3', 'd52fe6778a6c49e78b12b824342236a8');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('ee293cdc82164e4ebb8b5ae1a87b954f', '6f520dedd025452db898918713d84eb9', 'ab20cd3ae2e64e0fbb46b144b4802def');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('fea02bcbc2f94fc38de56d96278c4bc3', '5e42e1ee8ef2416485f05dfcfc5cbfd3', '54f50dfd729c43cd8c4300bb746558c3');

-- ----------------------------
-- Table structure for tbl_contacts_remark
-- ----------------------------
DROP TABLE IF EXISTS `tbl_contacts_remark`;
CREATE TABLE `tbl_contacts_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `contactsId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_contacts_remark
-- ----------------------------
INSERT INTO `tbl_contacts_remark` VALUES ('fa5d64d758c640168910f18cacb89802', '大师傅撒地方士大夫十大', 'admin', '2021-02-12 15:37:54', null, null, '0', '6f520dedd025452db898918713d84eb9');

-- ----------------------------
-- Table structure for tbl_customer
-- ----------------------------
DROP TABLE IF EXISTS `tbl_customer`;
CREATE TABLE `tbl_customer` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT '',
  `phone` varchar(255) DEFAULT '',
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_customer
-- ----------------------------
INSERT INTO `tbl_customer` VALUES ('67d5e36b14ed42ea9d64f062f83e492f', '40f6cdea0dd34aceb77292a1656d9fb3', '阿里dsf', 'www.alibaba.com', '32452345', '系统维护工程师', '2021-02-22 20:07:06', null, null, '联系纪要123456', '2021-04-01', '描述123456', '广东省广州市龙洞街道');
INSERT INTO `tbl_customer` VALUES ('6c26379092474644a1bd318dc4e4d97a', '40f6cdea0dd34aceb77292a1656d9fb3', '阿里', 'www.alibaba.com', '23454325', '系统维护工程师', '2021-02-22 19:47:21', null, null, '联系纪要123456', '2021-04-01', '描述123456', '广东省广州市龙洞街道');
INSERT INTO `tbl_customer` VALUES ('75572561e87b48d195fa1054f1bdd37b', '40f6cdea0dd34aceb77292a1656d9fb3', '阿帕奇', 'www.apq.ory', '3413543', '系统维护工程师', '2021-02-22 02:03:03', null, null, '联系纪要123', '2021-02-26', '描述123', '美国');
INSERT INTO `tbl_customer` VALUES ('906a3d47f368484fad2b91e52123ab95', '40f6cdea0dd34aceb77292a1656d9fb3', '迅雷公司', 'www.xunlei.com', '12341324', '系统维护工程师', '2021-02-22 02:05:53', null, null, '联系纪要123', '2021-03-05', '描述123', '广东省');
INSERT INTO `tbl_customer` VALUES ('b5dd2cdc65ce4e3d8d5094fc196daeff', '40f6cdea0dd34aceb77292a1656d9fb3', '小小张', 'www.baidu.com', '34132412341234', '系统维护工程师', '2021-02-15 11:40:06', null, null, 'asdf', '2020-03-30', '线索描述123', '广东省广州市白云区');
INSERT INTO `tbl_customer` VALUES ('c51bc885641147a29c3b2616771ea45d', '40f6cdea0dd34aceb77292a1656d9fb3', '百度云公司', 'www.baiduyun.com', '12343124', '系统维护工程师', '2021-02-22 01:58:20', null, null, '联系纪要123', '2021-02-25', '描述123', '广东省深圳市');
INSERT INTO `tbl_customer` VALUES ('d5bde91390fb4d03b96ec70a5d6dae86', '40f6cdea0bd34aceb77492a1656d9fb3', '阿里巴巴', 'www.alibaba.com', '3167856', '系统维护工程师', '2021-02-21 21:00:32', null, null, '联系纪要123', '2013-12-1', '线索描述123', '杭州西湖');
INSERT INTO `tbl_customer` VALUES ('db219cfef08744949e18c30d4de053ed', '40f6cdea0bd34aceb77492a1656d9fb3', '恒大集团', 'www.hengda.com', '3517895', '管理员', '2021-02-13 16:12:24', null, null, '联系纪要123', '2013-12-1', '线索描述123', '深圳');

-- ----------------------------
-- Table structure for tbl_customer_remark
-- ----------------------------
DROP TABLE IF EXISTS `tbl_customer_remark`;
CREATE TABLE `tbl_customer_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `customerId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_customer_remark
-- ----------------------------
INSERT INTO `tbl_customer_remark` VALUES ('c257e29231c44253bf0b95763a07511b', '大师傅撒地方士大夫十大', 'admin', '2021-02-12 15:37:54', null, null, '0', '239f2916997f43c8a323fbeb9605401f');

-- ----------------------------
-- Table structure for tbl_dic_type
-- ----------------------------
DROP TABLE IF EXISTS `tbl_dic_type`;
CREATE TABLE `tbl_dic_type` (
  `code` varchar(255) NOT NULL COMMENT '编码是主键，不能为空，不能含有中文。',
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_dic_type
-- ----------------------------
INSERT INTO `tbl_dic_type` VALUES ('appellation', '称呼', '');
INSERT INTO `tbl_dic_type` VALUES ('clueState', '线索状态', '');
INSERT INTO `tbl_dic_type` VALUES ('returnPriority', '回访优先级', '');
INSERT INTO `tbl_dic_type` VALUES ('returnState', '回访状态', '');
INSERT INTO `tbl_dic_type` VALUES ('source', '来源', '');
INSERT INTO `tbl_dic_type` VALUES ('stage', '阶段', '');
INSERT INTO `tbl_dic_type` VALUES ('transactionType', '交易类型', '');

-- ----------------------------
-- Table structure for tbl_dic_value
-- ----------------------------
DROP TABLE IF EXISTS `tbl_dic_value`;
CREATE TABLE `tbl_dic_value` (
  `id` char(32) NOT NULL COMMENT '主键，采用UUID',
  `value` varchar(255) DEFAULT NULL COMMENT '不能为空，并且要求同一个字典类型下字典值不能重复，具有唯一性。',
  `text` varchar(255) DEFAULT NULL COMMENT '可以为空',
  `orderNo` varchar(255) DEFAULT NULL COMMENT '可以为空，但不为空的时候，要求必须是正整数',
  `typeCode` varchar(255) DEFAULT NULL COMMENT '外键',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_dic_value
-- ----------------------------
INSERT INTO `tbl_dic_value` VALUES ('06e3cbdf10a44eca8511dddfc6896c55', '虚假线索', '虚假线索', '4', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('0fe33840c6d84bf78df55d49b169a894', '销售邮件', '销售邮件', '8', 'source');
INSERT INTO `tbl_dic_value` VALUES ('12302fd42bd349c1bb768b19600e6b20', '交易会', '交易会', '11', 'source');
INSERT INTO `tbl_dic_value` VALUES ('1615f0bb3e604552a86cde9a2ad45bea', '最高', '最高', '2', 'returnPriority');
INSERT INTO `tbl_dic_value` VALUES ('176039d2a90e4b1a81c5ab8707268636', '教授', '教授', '5', 'appellation');
INSERT INTO `tbl_dic_value` VALUES ('1e0bd307e6ee425599327447f8387285', '将来联系', '将来联系', '2', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('2173663b40b949ce928db92607b5fe57', '丢失线索', '丢失线索', '5', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('2876690b7e744333b7f1867102f91153', '未启动', '未启动', '1', 'returnState');
INSERT INTO `tbl_dic_value` VALUES ('29805c804dd94974b568cfc9017b2e4c', '07成交', '07成交', '7', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('310e6a49bd8a4962b3f95a1d92eb76f4', '试图联系', '试图联系', '1', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('31539e7ed8c848fc913e1c2c93d76fd1', '博士', '博士', '4', 'appellation');
INSERT INTO `tbl_dic_value` VALUES ('37ef211719134b009e10b7108194cf46', '01资质审查', '01资质审查', '1', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('391807b5324d4f16bd58c882750ee632', '08丢失的线索', '08丢失的线索', '8', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('3a39605d67da48f2a3ef52e19d243953', '聊天', '聊天', '14', 'source');
INSERT INTO `tbl_dic_value` VALUES ('474ab93e2e114816abf3ffc596b19131', '低', '低', '3', 'returnPriority');
INSERT INTO `tbl_dic_value` VALUES ('48512bfed26145d4a38d3616e2d2cf79', '广告', '广告', '1', 'source');
INSERT INTO `tbl_dic_value` VALUES ('4d03a42898684135809d380597ed3268', '合作伙伴研讨会', '合作伙伴研讨会', '9', 'source');
INSERT INTO `tbl_dic_value` VALUES ('59795c49896947e1ab61b7312bd0597c', '先生', '先生', '1', 'appellation');
INSERT INTO `tbl_dic_value` VALUES ('5c6e9e10ca414bd499c07b886f86202a', '高', '高', '1', 'returnPriority');
INSERT INTO `tbl_dic_value` VALUES ('67165c27076e4c8599f42de57850e39c', '夫人', '夫人', '2', 'appellation');
INSERT INTO `tbl_dic_value` VALUES ('68a1b1e814d5497a999b8f1298ace62b', '09因竞争丢失关闭', '09因竞争丢失关闭', '9', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('6b86f215e69f4dbd8a2daa22efccf0cf', 'web调研', 'web调研', '13', 'source');
INSERT INTO `tbl_dic_value` VALUES ('72f13af8f5d34134b5b3f42c5d477510', '合作伙伴', '合作伙伴', '6', 'source');
INSERT INTO `tbl_dic_value` VALUES ('7c07db3146794c60bf975749952176df', '未联系', '未联系', '6', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('86c56aca9eef49058145ec20d5466c17', '内部研讨会', '内部研讨会', '10', 'source');
INSERT INTO `tbl_dic_value` VALUES ('9095bda1f9c34f098d5b92fb870eba17', '进行中', '进行中', '3', 'returnState');
INSERT INTO `tbl_dic_value` VALUES ('954b410341e7433faa468d3c4f7cf0d2', '已有业务', '已有业务', '1', 'transactionType');
INSERT INTO `tbl_dic_value` VALUES ('966170ead6fa481284b7d21f90364984', '已联系', '已联系', '3', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('96b03f65dec748caa3f0b6284b19ef2f', '推迟', '推迟', '2', 'returnState');
INSERT INTO `tbl_dic_value` VALUES ('97d1128f70294f0aac49e996ced28c8a', '新业务', '新业务', '2', 'transactionType');
INSERT INTO `tbl_dic_value` VALUES ('9ca96290352c40688de6596596565c12', '完成', '完成', '4', 'returnState');
INSERT INTO `tbl_dic_value` VALUES ('9e6d6e15232549af853e22e703f3e015', '需要条件', '需要条件', '7', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('9ff57750fac04f15b10ce1bbb5bb8bab', '02需求分析', '02需求分析', '2', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('a70dc4b4523040c696f4421462be8b2f', '等待某人', '等待某人', '5', 'returnState');
INSERT INTO `tbl_dic_value` VALUES ('a83e75ced129421dbf11fab1f05cf8b4', '推销电话', '推销电话', '2', 'source');
INSERT INTO `tbl_dic_value` VALUES ('ab8472aab5de4ae9b388b2f1409441c1', '常规', '常规', '5', 'returnPriority');
INSERT INTO `tbl_dic_value` VALUES ('ab8c2a3dc05f4e3dbc7a0405f721b040', '05提案/报价', '05提案/报价', '5', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('b924d911426f4bc5ae3876038bc7e0ad', 'web下载', 'web下载', '12', 'source');
INSERT INTO `tbl_dic_value` VALUES ('c13ad8f9e2f74d5aa84697bb243be3bb', '03价值建议', '03价值建议', '3', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('c83c0be184bc40708fd7b361b6f36345', '最低', '最低', '4', 'returnPriority');
INSERT INTO `tbl_dic_value` VALUES ('db867ea866bc44678ac20c8a4a8bfefb', '员工介绍', '员工介绍', '3', 'source');
INSERT INTO `tbl_dic_value` VALUES ('e44be1d99158476e8e44778ed36f4355', '04确定决策者', '04确定决策者', '4', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('e5f383d2622b4fc0959f4fe131dafc80', '女士', '女士', '3', 'appellation');
INSERT INTO `tbl_dic_value` VALUES ('e81577d9458f4e4192a44650a3a3692b', '06谈判/复审', '06谈判/复审', '6', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('fb65d7fdb9c6483db02713e6bc05dd19', '在线商场', '在线商场', '5', 'source');
INSERT INTO `tbl_dic_value` VALUES ('fd677cc3b5d047d994e16f6ece4d3d45', '公开媒介', '公开媒介', '7', 'source');
INSERT INTO `tbl_dic_value` VALUES ('ff802a03ccea4ded8731427055681d48', '外部介绍', '外部介绍', '4', 'source');

-- ----------------------------
-- Table structure for tbl_tran
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tran`;
CREATE TABLE `tbl_tran` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `money` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `expectedDate` char(10) DEFAULT NULL,
  `customerId` char(32) DEFAULT '',
  `stage` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `activityId` char(32) DEFAULT NULL,
  `contactsId` char(32) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_tran
-- ----------------------------
INSERT INTO `tbl_tran` VALUES ('4213b153803243cebfb1c23a88735759', '40f6cdea0dd34aceb77292a1656d9fb3', '3141234', 'zhangxinrun', '2021-02-02', 'd5bde91390fb4d03b96ec70a5d6dae86', '06谈判/复审', '新业务', '广告', 'ab20cd3ae2e64e0fbb46b144b4802def', '6f520dedd025452db898918713d84eb9', '系统维护工程师', '2021-02-15 11:29:01', '系统维护工程师', '2021-02-23 18:48:17', 'asdfsdaasdfs', 'adsfsa', '2013-12-1');
INSERT INTO `tbl_tran` VALUES ('63b13fd87f36407b98dbc115a63fbad3', '40f6cdea0dd34aceb77292a1656d9fb3', '123456789', 'xiaoxiao zhang', '2021-02-17', 'd5bde91390fb4d03b96ec70a5d6dae86', '05提案/报价', '新业务', '广告', 'ab20cd3ae2e64e0fbb46b144b4802def', '6f520dedd025452db898918713d84eb9', '系统维护工程师', '2021-02-15 11:40:06', '系统维护工程师', '2021-02-23 18:49:08', 'asdf', 'asdf', '2013-12-1');

-- ----------------------------
-- Table structure for tbl_tran_history
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tran_history`;
CREATE TABLE `tbl_tran_history` (
  `id` char(32) NOT NULL,
  `stage` varchar(255) DEFAULT NULL,
  `money` varchar(255) DEFAULT NULL,
  `expectedDate` char(10) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `tranId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_tran_history
-- ----------------------------
INSERT INTO `tbl_tran_history` VALUES ('057a3c9bc04e41a4bc5b2ef4618e9a34', null, '123456789', '2021-02-17', null, null, '63b13fd87f36407b98dbc115a63fbad3');
INSERT INTO `tbl_tran_history` VALUES ('08138b0353254c068c6b6bff219aba51', null, '123456789', '2021-02-17', null, null, '63b13fd87f36407b98dbc115a63fbad3');
INSERT INTO `tbl_tran_history` VALUES ('0d805cf71b3d4810abf1eef272da5c3d', null, '3141234', '2021-02-02', '2021-02-23 18:48:17', null, '4213b153803243cebfb1c23a88735759');
INSERT INTO `tbl_tran_history` VALUES ('108230f7a3e443fcb40dbf2d35eb3a5d', null, '123456789', '2021-02-17', null, null, '63b13fd87f36407b98dbc115a63fbad3');
INSERT INTO `tbl_tran_history` VALUES ('18a2882374bd43b886f97a34f20cc0da', null, '123456789', '2021-02-17', null, null, '63b13fd87f36407b98dbc115a63fbad3');
INSERT INTO `tbl_tran_history` VALUES ('194f5d0d2cc746a398157574ae1be16c', null, '123456789', '2021-02-17', null, null, '63b13fd87f36407b98dbc115a63fbad3');
INSERT INTO `tbl_tran_history` VALUES ('211667b11beb499593d864330aa2f7a7', null, '123456789', '2021-02-17', '2021-02-16 19:25:49', null, '63b13fd87f36407b98dbc115a63fbad3');
INSERT INTO `tbl_tran_history` VALUES ('223720711b69441ea522f83280bf7b86', null, '3141234', '2021-02-02', '2021-02-23 18:48:13', null, '4213b153803243cebfb1c23a88735759');
INSERT INTO `tbl_tran_history` VALUES ('2dee1189024b4b38bcc813d31df08e3d', '03价值建议', '34253245', '2021-02-17', '2021-02-12 15:37:54', 'admin', '63b2b8b4f82346e595b20263e32c97fa');
INSERT INTO `tbl_tran_history` VALUES ('2fbe0f04933740b79af8b687e2e3a25a', null, '123456789', '2021-02-17', null, null, '63b13fd87f36407b98dbc115a63fbad3');
INSERT INTO `tbl_tran_history` VALUES ('3176f5c5f4ff41fe9696c905c31e81c6', null, '123456789', '2021-02-17', null, null, '63b13fd87f36407b98dbc115a63fbad3');
INSERT INTO `tbl_tran_history` VALUES ('34830e1e5b90476b87d67b48e323467a', null, '123456789', '2021-02-17', null, null, '63b13fd87f36407b98dbc115a63fbad3');
INSERT INTO `tbl_tran_history` VALUES ('42df2230728c4a568d44cf7b84f7b471', null, '123456789', '2021-02-17', null, null, '63b13fd87f36407b98dbc115a63fbad3');
INSERT INTO `tbl_tran_history` VALUES ('456f0b486d1b4c8f90b162f9cadf9af0', null, '123456789', '2021-02-17', null, null, '63b13fd87f36407b98dbc115a63fbad3');
INSERT INTO `tbl_tran_history` VALUES ('520e0b776d6746cca614870e35dfffa2', '03价值建议', '123456789', '2021-02-17', '2021-02-15 11:40:06', '系统维护工程师', '63b13fd87f36407b98dbc115a63fbad3');
INSERT INTO `tbl_tran_history` VALUES ('5ffda504fbc748548cef352a92760432', null, '123456789', '2021-02-17', '2021-02-16 19:25:51', null, '63b13fd87f36407b98dbc115a63fbad3');
INSERT INTO `tbl_tran_history` VALUES ('68721d0a9f294d98897e56aebab0f64a', null, '123456789', '2021-02-17', '2021-02-23 18:49:08', null, '63b13fd87f36407b98dbc115a63fbad3');
INSERT INTO `tbl_tran_history` VALUES ('847443bae34f43539222deadb8a2ed0c', null, '123456789', '2021-02-17', null, null, '63b13fd87f36407b98dbc115a63fbad3');
INSERT INTO `tbl_tran_history` VALUES ('877c53d64ae14789be4c09f9f00c116f', null, '3141234', '2021-02-02', '2021-02-23 18:48:15', null, '4213b153803243cebfb1c23a88735759');
INSERT INTO `tbl_tran_history` VALUES ('a2211c0e4bba466db0e926617963d75a', null, '123456789', '2021-02-17', null, null, '63b13fd87f36407b98dbc115a63fbad3');
INSERT INTO `tbl_tran_history` VALUES ('b7c9e8050deb4aac8759fc31aea02f06', null, '123456789', '2021-02-17', null, null, '63b13fd87f36407b98dbc115a63fbad3');
INSERT INTO `tbl_tran_history` VALUES ('bcbaa7464a7641cdbfbdb399b88f7912', null, '123456789', '2021-02-17', null, null, '63b13fd87f36407b98dbc115a63fbad3');
INSERT INTO `tbl_tran_history` VALUES ('c1fc312d6338458487871a3937628fdd', null, '123456789', '2021-02-17', null, null, '63b13fd87f36407b98dbc115a63fbad3');
INSERT INTO `tbl_tran_history` VALUES ('d261490e0a1642a8a9ee34336f84daf1', null, '123456789', '2021-02-17', null, null, '63b13fd87f36407b98dbc115a63fbad3');
INSERT INTO `tbl_tran_history` VALUES ('ddf9e2918cd74678b8eb2042070637c6', null, '123456789', '2021-02-17', null, null, '63b13fd87f36407b98dbc115a63fbad3');
INSERT INTO `tbl_tran_history` VALUES ('de3595164a8340588e2a5fe7cf23a4c8', '03价值建议', '3141234', '2021-02-02', '2021-02-15 11:29:01', '系统维护工程师', '4213b153803243cebfb1c23a88735759');
INSERT INTO `tbl_tran_history` VALUES ('f475b5129f2a45ed81e9189bb5a213ba', null, '123456789', '2021-02-17', null, null, '63b13fd87f36407b98dbc115a63fbad3');
INSERT INTO `tbl_tran_history` VALUES ('f94665f69c3442e9a5b8f675cb5c6edc', null, '123456789', '2021-02-17', null, null, '63b13fd87f36407b98dbc115a63fbad3');
INSERT INTO `tbl_tran_history` VALUES ('fae61d22ff1a41f3af025afbea8b9552', null, '123456789', '2021-02-17', '2021-02-23 18:48:25', null, '63b13fd87f36407b98dbc115a63fbad3');

-- ----------------------------
-- Table structure for tbl_tran_remark
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tran_remark`;
CREATE TABLE `tbl_tran_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `tranId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_tran_remark
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_user
-- ----------------------------
DROP TABLE IF EXISTS `tbl_user`;
CREATE TABLE `tbl_user` (
  `id` char(32) NOT NULL COMMENT 'uuid\r\n            ',
  `loginAct` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `loginPwd` varchar(255) DEFAULT NULL COMMENT '密码不能采用明文存储，采用密文，MD5加密之后的数据',
  `email` varchar(255) DEFAULT NULL,
  `expireTime` char(19) DEFAULT NULL COMMENT '失效时间为空的时候表示永不失效，失效时间为2018-10-10 10:10:10，则表示在该时间之前该账户可用。',
  `lockState` char(1) DEFAULT NULL COMMENT '锁定状态为空时表示启用，为0时表示锁定，为1时表示启用。',
  `deptno` char(4) DEFAULT NULL,
  `allowIps` varchar(255) DEFAULT NULL COMMENT '允许访问的IP为空时表示IP地址永不受限，允许访问的IP可以是一个，也可以是多个，当多个IP地址的时候，采用半角逗号分隔。允许IP是192.168.100.2，表示该用户只能在IP地址为192.168.100.2的机器上使用。',
  `createTime` char(19) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_user
-- ----------------------------
INSERT INTO `tbl_user` VALUES ('06f5fc056eac41558a964f96daa7f27c', 'ls', '李四', '202cb962ac59075b964b07152d234b70', 'ls@163.com', '2018-11-27 21:50:05', '0', 'A001', '192.168.1.1', '2018-11-22 12:11:40', '李四', null, null);
INSERT INTO `tbl_user` VALUES ('40f6cdea0bd34aceb77492a1656d9fb3', 'zs', '张三', '202cb962ac59075b964b07152d234b70', 'zs@163.com', '2021-04-30 23:50:55', '1', 'A001', '192.168.1.1,192.168.1.2,127.0.0.1', '2018-11-22 11:37:34', '张三', null, null);
INSERT INTO `tbl_user` VALUES ('40f6cdea0dd34aceb77292a1656d9fb3', 'admin', '系统维护工程师', '21232f297a57a5a743894a0e4a801fc3', 'admin@qq.com', '2021-04-30 23:50:55', '1', 'A001', '192.168.1.1,192.168.1.2,127.0.0.1', '2021-01-01 23:50:55', '超级管理员', null, null);
INSERT INTO `tbl_user` VALUES ('40f6saea0bd34aceb77492a1656d9fb3', 'xiaozhang', '小张', '202cb962ac59075b964b07152d234b70', 'xiaozhang@qq.com', '2021-04-30 23:50:55', '1', 'A001', '192.168.1.1,192.168.1.2,127.0.0.1', '2021-01-01 23:50:55', '小小张', null, null);
