/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80031
 Source Host           : localhost:3306
 Source Schema         : project

 Target Server Type    : MySQL
 Target Server Version : 80031
 File Encoding         : 65001

 Date: 14/01/2023 23:29:44
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for images
-- ----------------------------
DROP TABLE IF EXISTS `images`;
CREATE TABLE `images`  (
  `img_name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `img_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of images
-- ----------------------------
INSERT INTO `images` VALUES ('0.png', 'D:\\haichong\\out\\artifacts\\haichong_war_exploded\\images_soruce');
INSERT INTO `images` VALUES ('1.png', 'D:\\haichong\\out\\artifacts\\haichong_war_exploded\\images_soruce');
INSERT INTO `images` VALUES ('2.png', 'D:\\haichong\\out\\artifacts\\haichong_war_exploded\\images_soruce');
INSERT INTO `images` VALUES ('3.png', 'D:\\haichong\\out\\artifacts\\haichong_war_exploded\\images_soruce');

-- ----------------------------
-- Table structure for weights
-- ----------------------------
DROP TABLE IF EXISTS `weights`;
CREATE TABLE `weights`  (
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of weights
-- ----------------------------
INSERT INTO `weights` VALUES ('苹果病害识别');

SET FOREIGN_KEY_CHECKS = 1;
