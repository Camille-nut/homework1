/*
 Navicat Premium Data Transfer

 Source Server         : 127.0.0.1
 Source Server Type    : MySQL
 Source Server Version : 80033 (8.0.33)
 Source Host           : localhost:3306
 Source Schema         : delivery

 Target Server Type    : MySQL
 Target Server Version : 80033 (8.0.33)
 File Encoding         : 65001

 Date: 13/11/2024 18:15:51
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for app_cartitem
-- ----------------------------
DROP TABLE IF EXISTS `app_cartitem`;
CREATE TABLE `app_cartitem`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `quantity` int NOT NULL,
  `product_id` bigint NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `app_cartitem_product_id_f74e2343_fk_app_product_id`(`product_id` ASC) USING BTREE,
  INDEX `app_cartitem_user_id_5085d435_fk_auth_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `app_cartitem_product_id_f74e2343_fk_app_product_id` FOREIGN KEY (`product_id`) REFERENCES `app_product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `app_cartitem_user_id_5085d435_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of app_cartitem
-- ----------------------------
INSERT INTO `app_cartitem` VALUES (1, 1, 1, 2);
INSERT INTO `app_cartitem` VALUES (2, 1, 2, 2);

-- ----------------------------
-- Table structure for app_category
-- ----------------------------
DROP TABLE IF EXISTS `app_category`;
CREATE TABLE `app_category`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of app_category
-- ----------------------------
INSERT INTO `app_category` VALUES (1, '中式美食');
INSERT INTO `app_category` VALUES (2, '快餐');
INSERT INTO `app_category` VALUES (4, '烧烤');
INSERT INTO `app_category` VALUES (5, '甜品和饮品');
INSERT INTO `app_category` VALUES (3, '面食');

-- ----------------------------
-- Table structure for app_favorite
-- ----------------------------
DROP TABLE IF EXISTS `app_favorite`;
CREATE TABLE `app_favorite`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date_added` datetime(6) NOT NULL,
  `product_id` bigint NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `app_favorite_user_id_product_id_a0250727_uniq`(`user_id` ASC, `product_id` ASC) USING BTREE,
  INDEX `app_favorite_product_id_e5e5b1bd_fk_app_product_id`(`product_id` ASC) USING BTREE,
  CONSTRAINT `app_favorite_product_id_e5e5b1bd_fk_app_product_id` FOREIGN KEY (`product_id`) REFERENCES `app_product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `app_favorite_user_id_bd10a641_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of app_favorite
-- ----------------------------
INSERT INTO `app_favorite` VALUES (4, '2024-11-12 01:24:52.806790', 1, 2);
INSERT INTO `app_favorite` VALUES (6, '2024-11-12 02:55:15.123065', 5, 3);

-- ----------------------------
-- Table structure for app_order
-- ----------------------------
DROP TABLE IF EXISTS `app_order`;
CREATE TABLE `app_order`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date_ordered` datetime(6) NOT NULL,
  `status` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `transaction_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `app_order_user_id_f25a9fc4_fk_auth_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `app_order_user_id_f25a9fc4_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of app_order
-- ----------------------------
INSERT INTO `app_order` VALUES (1, '2024-11-12 02:56:55.143797', '已支付', '9cd13f05-7217-480f-a734-402dfa3f4007', 3);
INSERT INTO `app_order` VALUES (2, '2024-11-12 03:17:19.077598', '已取消', '0bcfc60a-f6cb-45d4-a4c1-c573723f5f03', 4);
INSERT INTO `app_order` VALUES (3, '2024-11-12 03:21:48.754832', '未支付', '0bcfc60a-f6cb-45d4-a4c1-c573723f5f03', 4);
INSERT INTO `app_order` VALUES (4, '2024-11-12 03:34:50.789296', '未支付', 'fe9cd8c9-8ba0-46fc-829b-9833ee0c201c', 4);
INSERT INTO `app_order` VALUES (5, '2024-11-12 03:40:47.919804', '未支付', 'fe9cd8c9-8ba0-46fc-829b-9833ee0c201c', 4);
INSERT INTO `app_order` VALUES (6, '2024-11-12 03:42:15.669985', '未支付', '93880b47-f3a2-4439-95df-3d45c9dca937', 4);
INSERT INTO `app_order` VALUES (7, '2024-11-12 03:53:15.411486', '未支付', '83fcc5a2-ab79-4f61-a1b2-effbb88ca740', 4);
INSERT INTO `app_order` VALUES (8, '2024-11-12 11:34:43.934176', '已取消', 'c3fbd4a8-4927-437d-963f-f2a7cfde979f', 1);
INSERT INTO `app_order` VALUES (9, '2024-11-11 11:35:09.174727', '已支付', 'fe3ecddb-7457-4c8c-8954-254ad83304b4', 1);

-- ----------------------------
-- Table structure for app_orderitem
-- ----------------------------
DROP TABLE IF EXISTS `app_orderitem`;
CREATE TABLE `app_orderitem`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `quantity` int NOT NULL,
  `date_added` datetime(6) NOT NULL,
  `order_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `app_orderitem_order_id_41257a1b_fk_app_order_id`(`order_id` ASC) USING BTREE,
  INDEX `app_orderitem_product_id_5f40ddb0_fk_app_product_id`(`product_id` ASC) USING BTREE,
  CONSTRAINT `app_orderitem_order_id_41257a1b_fk_app_order_id` FOREIGN KEY (`order_id`) REFERENCES `app_order` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `app_orderitem_product_id_5f40ddb0_fk_app_product_id` FOREIGN KEY (`product_id`) REFERENCES `app_product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of app_orderitem
-- ----------------------------
INSERT INTO `app_orderitem` VALUES (1, 2, '2024-11-12 02:56:55.154794', 1, 3);
INSERT INTO `app_orderitem` VALUES (2, 1, '2024-11-12 02:56:55.166799', 1, 6);
INSERT INTO `app_orderitem` VALUES (3, 1, '2024-11-12 03:17:19.087608', 2, 5);
INSERT INTO `app_orderitem` VALUES (4, 1, '2024-11-12 03:17:19.094820', 2, 3);
INSERT INTO `app_orderitem` VALUES (5, 1, '2024-11-12 03:21:48.759831', 3, 3);
INSERT INTO `app_orderitem` VALUES (6, 1, '2024-11-12 03:21:48.762822', 3, 6);
INSERT INTO `app_orderitem` VALUES (7, 3, '2024-11-12 03:34:50.801144', 4, 2);
INSERT INTO `app_orderitem` VALUES (8, 4, '2024-11-12 03:34:50.809986', 4, 6);
INSERT INTO `app_orderitem` VALUES (9, 1, '2024-11-12 03:40:47.926803', 5, 3);
INSERT INTO `app_orderitem` VALUES (10, 5, '2024-11-12 03:42:15.677743', 6, 3);
INSERT INTO `app_orderitem` VALUES (11, 2, '2024-11-12 03:53:15.418094', 7, 4);
INSERT INTO `app_orderitem` VALUES (12, 2, '2024-11-12 11:35:09.183720', 9, 1);
INSERT INTO `app_orderitem` VALUES (13, 1, '2024-11-12 11:35:09.199718', 9, 3);

-- ----------------------------
-- Table structure for app_product
-- ----------------------------
DROP TABLE IF EXISTS `app_product`;
CREATE TABLE `app_product`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `price` decimal(10, 2) NOT NULL,
  `stock` int NOT NULL,
  `image` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  `view_count` int NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `category_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `app_product_category_id_023742a5_fk_app_category_id`(`category_id` ASC) USING BTREE,
  CONSTRAINT `app_product_category_id_023742a5_fk_app_category_id` FOREIGN KEY (`category_id`) REFERENCES `app_category` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of app_product
-- ----------------------------
INSERT INTO `app_product` VALUES (1, '宫保鸡丁', 20.00, 98, 'products/gongbao.jpeg', '宫保鸡丁是一道经典的川菜，以其麻辣鲜香、鸡肉丁嫩滑而著称。这道菜通常包含花生和辣椒，是喜欢辣味的人的最爱。', 4, '2024-11-11 07:58:56.015905', 1);
INSERT INTO `app_product` VALUES (2, '鱼香茄子', 18.00, 100, 'products/yuxiang.jpg', '鱼香茄子是一道经典的川菜，浓郁菜香、醇厚口感和独特鱼香味道。', 2, '2024-11-11 08:26:59.763364', 1);
INSERT INTO `app_product` VALUES (3, '扬州炒饭', 15.00, 99, 'products/炒饭.jpg', '扬州炒饭是一道传统的中式美食，以其金黄的蛋丝、鲜美的虾仁和丰富的蔬菜丁而闻名。它色香味俱佳，是许多人的主食选择。', 7, '2024-11-11 08:28:16.072880', 1);
INSERT INTO `app_product` VALUES (4, '麻婆豆腐', 15.00, 98, 'products/mapo.jpeg', '麻、辣、烫、嫩、酥、香、鲜，突出川菜麻辣味型的特点。', 1, '2024-11-11 08:34:48.653451', 1);
INSERT INTO `app_product` VALUES (5, '汉堡王', 19.80, 100, 'products/汉堡.jpg', '快乐时光，与汉堡相伴。', 4, '2024-11-11 08:40:44.145771', 2);
INSERT INTO `app_product` VALUES (6, '炸鸡', 29.80, 100, 'products/zhaji.jpg', '炸鸡以其外酥里嫩、多汁可口而闻名。通常选用鸡肉，裹上面粉和香料后油炸至金黄，是聚会和休闲时光的理想选择。', 4, '2024-11-11 08:41:44.964045', 2);
INSERT INTO `app_product` VALUES (7, '披萨', 29.80, 100, 'products/pisha.jpg', '精挑细选的食材，扎实到位的手艺，每一口都有温暖的味道。', 0, '2024-11-11 08:42:37.374076', 2);
INSERT INTO `app_product` VALUES (8, '烤鸡翅', 8.90, 100, 'products/jichi.jpg', '唇齿间的烧烤风情', 0, '2024-11-11 08:51:25.999375', 4);
INSERT INTO `app_product` VALUES (9, '烤肉串', 12.90, 100, 'products/rouchuan.jpg', '烟熏火燎，肉香扑鼻，咬上一口，滋滋鲜嫩。', 0, '2024-11-11 08:52:50.866232', 4);
INSERT INTO `app_product` VALUES (10, '冰淇淋', 19.90, 100, 'products/bingqilin.jpg', '冰冰的，甜甜的，不会增肉肉哦', 0, '2024-11-11 08:54:52.971816', 5);
INSERT INTO `app_product` VALUES (11, '奶茶', 19.90, 100, 'products/奶茶.jpg', '品酥香浓郁，享人生精彩', 0, '2024-11-11 08:56:15.226256', 5);
INSERT INTO `app_product` VALUES (12, '兰州拉面', 19.90, 100, 'products/拉面.jpg', '香喷喷的肉末与细滑的面条完美融合', 0, '2024-11-11 08:58:37.008938', 3);
INSERT INTO `app_product` VALUES (13, '饺子', 19.90, 100, 'products/jiaozi.jpg', '不仅仅是一道美食，更是一种情感的寄托', 0, '2024-11-11 09:00:02.498814', 3);

-- ----------------------------
-- Table structure for app_product_score
-- ----------------------------
DROP TABLE IF EXISTS `app_product_score`;
CREATE TABLE `app_product_score`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `score` int NULL DEFAULT NULL,
  `product_id` bigint NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `app_job_score_product_id_b5897ef1_fk_app_product_id`(`product_id` ASC) USING BTREE,
  INDEX `app_job_score_user_id_dd2f71b3_fk_auth_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `app_job_score_product_id_b5897ef1_fk_app_product_id` FOREIGN KEY (`product_id`) REFERENCES `app_product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `app_job_score_user_id_dd2f71b3_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of app_product_score
-- ----------------------------
INSERT INTO `app_product_score` VALUES (1, 5, 1, 1);
INSERT INTO `app_product_score` VALUES (2, 4, 3, 3);
INSERT INTO `app_product_score` VALUES (3, 4, 5, 3);
INSERT INTO `app_product_score` VALUES (4, 4, 6, 3);
INSERT INTO `app_product_score` VALUES (5, 8, 5, 4);
INSERT INTO `app_product_score` VALUES (6, 20, 3, 4);
INSERT INTO `app_product_score` VALUES (7, 12, 6, 4);
INSERT INTO `app_product_score` VALUES (8, 5, 2, 4);
INSERT INTO `app_product_score` VALUES (9, 4, 4, 4);
INSERT INTO `app_product_score` VALUES (10, 1, 1, 4);
INSERT INTO `app_product_score` VALUES (11, 4, 3, 1);

-- ----------------------------
-- Table structure for app_userinfo
-- ----------------------------
DROP TABLE IF EXISTS `app_userinfo`;
CREATE TABLE `app_userinfo`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `class_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `grade` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `app_userinfo_user_id_106be453_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of app_userinfo
-- ----------------------------
INSERT INTO `app_userinfo` VALUES (1, '1', '2', '17315231596', '湖北省荆州市', 1);
INSERT INTO `app_userinfo` VALUES (2, '1', '2', '16345678976', '', 3);
INSERT INTO `app_userinfo` VALUES (3, '2', '2', '16345678976', '', 4);

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq`(`group_id` ASC, `permission_id` ASC) USING BTREE,
  INDEX `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm`(`permission_id` ASC) USING BTREE,
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq`(`content_type_id` ASC, `codename` ASC) USING BTREE,
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 61 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO `auth_permission` VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO `auth_permission` VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO `auth_permission` VALUES (4, 'Can view log entry', 1, 'view_logentry');
INSERT INTO `auth_permission` VALUES (5, 'Can add permission', 2, 'add_permission');
INSERT INTO `auth_permission` VALUES (6, 'Can change permission', 2, 'change_permission');
INSERT INTO `auth_permission` VALUES (7, 'Can delete permission', 2, 'delete_permission');
INSERT INTO `auth_permission` VALUES (8, 'Can view permission', 2, 'view_permission');
INSERT INTO `auth_permission` VALUES (9, 'Can add group', 3, 'add_group');
INSERT INTO `auth_permission` VALUES (10, 'Can change group', 3, 'change_group');
INSERT INTO `auth_permission` VALUES (11, 'Can delete group', 3, 'delete_group');
INSERT INTO `auth_permission` VALUES (12, 'Can view group', 3, 'view_group');
INSERT INTO `auth_permission` VALUES (13, 'Can add user', 4, 'add_user');
INSERT INTO `auth_permission` VALUES (14, 'Can change user', 4, 'change_user');
INSERT INTO `auth_permission` VALUES (15, 'Can delete user', 4, 'delete_user');
INSERT INTO `auth_permission` VALUES (16, 'Can view user', 4, 'view_user');
INSERT INTO `auth_permission` VALUES (17, 'Can add content type', 5, 'add_contenttype');
INSERT INTO `auth_permission` VALUES (18, 'Can change content type', 5, 'change_contenttype');
INSERT INTO `auth_permission` VALUES (19, 'Can delete content type', 5, 'delete_contenttype');
INSERT INTO `auth_permission` VALUES (20, 'Can view content type', 5, 'view_contenttype');
INSERT INTO `auth_permission` VALUES (21, 'Can add session', 6, 'add_session');
INSERT INTO `auth_permission` VALUES (22, 'Can change session', 6, 'change_session');
INSERT INTO `auth_permission` VALUES (23, 'Can delete session', 6, 'delete_session');
INSERT INTO `auth_permission` VALUES (24, 'Can view session', 6, 'view_session');
INSERT INTO `auth_permission` VALUES (25, 'Can add 分类', 7, 'add_category');
INSERT INTO `auth_permission` VALUES (26, 'Can change 分类', 7, 'change_category');
INSERT INTO `auth_permission` VALUES (27, 'Can delete 分类', 7, 'delete_category');
INSERT INTO `auth_permission` VALUES (28, 'Can view 分类', 7, 'view_category');
INSERT INTO `auth_permission` VALUES (29, 'Can add 订单', 8, 'add_order');
INSERT INTO `auth_permission` VALUES (30, 'Can change 订单', 8, 'change_order');
INSERT INTO `auth_permission` VALUES (31, 'Can delete 订单', 8, 'delete_order');
INSERT INTO `auth_permission` VALUES (32, 'Can view 订单', 8, 'view_order');
INSERT INTO `auth_permission` VALUES (33, 'Can add 用户信息', 9, 'add_userinfo');
INSERT INTO `auth_permission` VALUES (34, 'Can change 用户信息', 9, 'change_userinfo');
INSERT INTO `auth_permission` VALUES (35, 'Can delete 用户信息', 9, 'delete_userinfo');
INSERT INTO `auth_permission` VALUES (36, 'Can view 用户信息', 9, 'view_userinfo');
INSERT INTO `auth_permission` VALUES (37, 'Can add 产品', 10, 'add_product');
INSERT INTO `auth_permission` VALUES (38, 'Can change 产品', 10, 'change_product');
INSERT INTO `auth_permission` VALUES (39, 'Can delete 产品', 10, 'delete_product');
INSERT INTO `auth_permission` VALUES (40, 'Can view 产品', 10, 'view_product');
INSERT INTO `auth_permission` VALUES (41, 'Can add 订单项', 11, 'add_orderitem');
INSERT INTO `auth_permission` VALUES (42, 'Can change 订单项', 11, 'change_orderitem');
INSERT INTO `auth_permission` VALUES (43, 'Can delete 订单项', 11, 'delete_orderitem');
INSERT INTO `auth_permission` VALUES (44, 'Can view 订单项', 11, 'view_orderitem');
INSERT INTO `auth_permission` VALUES (45, 'Can add job_score', 12, 'add_job_score');
INSERT INTO `auth_permission` VALUES (46, 'Can change job_score', 12, 'change_job_score');
INSERT INTO `auth_permission` VALUES (47, 'Can delete job_score', 12, 'delete_job_score');
INSERT INTO `auth_permission` VALUES (48, 'Can view job_score', 12, 'view_job_score');
INSERT INTO `auth_permission` VALUES (49, 'Can add 购物车项', 13, 'add_cartitem');
INSERT INTO `auth_permission` VALUES (50, 'Can change 购物车项', 13, 'change_cartitem');
INSERT INTO `auth_permission` VALUES (51, 'Can delete 购物车项', 13, 'delete_cartitem');
INSERT INTO `auth_permission` VALUES (52, 'Can view 购物车项', 13, 'view_cartitem');
INSERT INTO `auth_permission` VALUES (53, 'Can add 用户收藏', 14, 'add_favorite');
INSERT INTO `auth_permission` VALUES (54, 'Can change 用户收藏', 14, 'change_favorite');
INSERT INTO `auth_permission` VALUES (55, 'Can delete 用户收藏', 14, 'delete_favorite');
INSERT INTO `auth_permission` VALUES (56, 'Can view 用户收藏', 14, 'view_favorite');
INSERT INTO `auth_permission` VALUES (57, 'Can add 商品评分', 12, 'add_product_score');
INSERT INTO `auth_permission` VALUES (58, 'Can change 商品评分', 12, 'change_product_score');
INSERT INTO `auth_permission` VALUES (59, 'Can delete 商品评分', 12, 'delete_product_score');
INSERT INTO `auth_permission` VALUES (60, 'Can view 商品评分', 12, 'view_product_score');

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `last_login` datetime(6) NULL DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `first_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `last_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `email` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user
-- ----------------------------
INSERT INTO `auth_user` VALUES (1, 'pbkdf2_sha256$390000$FwpzxMEe6RFcRbUvmL3rnH$9agv7DSvYceuMu8jBNUwGcwOfjCKz9Iahls5rAR7IMw=', '2024-11-12 08:26:53.235305', 0, 'nickrou', '', '', '32131455534@qq.com', 0, 1, '2024-11-11 04:09:09.949352');
INSERT INTO `auth_user` VALUES (2, 'pbkdf2_sha256$390000$4zVwtd8HPljdNneirbYnTI$4JPR2nqeCCHsEVnEj5vnerOkzu1bAijrAmsi+FNEcgg=', '2024-11-11 07:21:44.428262', 1, 'admin', '', '', '', 1, 1, '2024-11-11 07:21:37.407850');
INSERT INTO `auth_user` VALUES (3, 'pbkdf2_sha256$390000$DPq71MtjoBHReeEomvAwPz$4IYE4J2prTtXA2l9GRZcJ061IJ6zZpKrXHx7b3fna+o=', '2024-11-12 02:52:25.206382', 0, 'baoluo', '', '', 'britl@gmail.com', 0, 1, '2024-11-12 02:52:17.430978');
INSERT INTO `auth_user` VALUES (4, 'pbkdf2_sha256$390000$WrWJcUiMKY73x7JtStkxlY$DZggaKyTC2Uu10nGX72TEqdnNjJHhRiqVha6jMfapwo=', '2024-11-12 02:59:04.784854', 0, 'luoqian', '', '', 'britl@gmail.com', 0, 1, '2024-11-12 02:58:58.187956');

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_groups_user_id_group_id_94350c0c_uniq`(`user_id` ASC, `group_id` ASC) USING BTREE,
  INDEX `auth_user_groups_group_id_97559544_fk_auth_group_id`(`group_id` ASC) USING BTREE,
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq`(`user_id` ASC, `permission_id` ASC) USING BTREE,
  INDEX `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm`(`permission_id` ASC) USING BTREE,
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  `object_repr` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `action_flag` smallint UNSIGNED NOT NULL,
  `change_message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `content_type_id` int NULL DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `django_admin_log_content_type_id_c4bce8eb_fk_django_co`(`content_type_id` ASC) USING BTREE,
  INDEX `django_admin_log_user_id_c564eba6_fk_auth_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `django_admin_log_chk_1` CHECK (`action_flag` >= 0)
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------
INSERT INTO `django_admin_log` VALUES (1, '2024-11-11 07:22:15.633994', '1', '美食', 1, '[{\"added\": {}}]', 7, 2);
INSERT INTO `django_admin_log` VALUES (2, '2024-11-11 07:58:56.018907', '1', '宫保鸡丁', 1, '[{\"added\": {}}]', 10, 2);
INSERT INTO `django_admin_log` VALUES (3, '2024-11-11 07:59:09.744340', '1', '宫保鸡丁', 2, '[{\"changed\": {\"fields\": [\"\\u56fe\\u7247\"]}}]', 10, 2);
INSERT INTO `django_admin_log` VALUES (4, '2024-11-11 08:26:59.766440', '2', '鱼香茄子', 1, '[{\"added\": {}}]', 10, 2);
INSERT INTO `django_admin_log` VALUES (5, '2024-11-11 08:28:16.076386', '3', '扬州炒饭', 1, '[{\"added\": {}}]', 10, 2);
INSERT INTO `django_admin_log` VALUES (6, '2024-11-11 08:33:54.169211', '1', '中式美食', 2, '[{\"changed\": {\"fields\": [\"\\u5206\\u7c7b\\u540d\\u79f0\"]}}]', 7, 2);
INSERT INTO `django_admin_log` VALUES (7, '2024-11-11 08:34:48.655453', '4', '麻婆豆腐', 1, '[{\"added\": {}}]', 10, 2);
INSERT INTO `django_admin_log` VALUES (8, '2024-11-11 08:35:00.756527', '3', '扬州炒饭', 2, '[{\"changed\": {\"fields\": [\"\\u63cf\\u8ff0\"]}}]', 10, 2);
INSERT INTO `django_admin_log` VALUES (9, '2024-11-11 08:35:13.769969', '2', '鱼香茄子', 2, '[{\"changed\": {\"fields\": [\"\\u63cf\\u8ff0\"]}}]', 10, 2);
INSERT INTO `django_admin_log` VALUES (10, '2024-11-11 08:35:23.438601', '1', '宫保鸡丁', 2, '[{\"changed\": {\"fields\": [\"\\u63cf\\u8ff0\"]}}]', 10, 2);
INSERT INTO `django_admin_log` VALUES (11, '2024-11-11 08:36:08.175139', '2', '鱼香茄子', 2, '[{\"changed\": {\"fields\": [\"\\u63cf\\u8ff0\"]}}]', 10, 2);
INSERT INTO `django_admin_log` VALUES (12, '2024-11-11 08:36:22.296712', '2', '快餐', 1, '[{\"added\": {}}]', 7, 2);
INSERT INTO `django_admin_log` VALUES (13, '2024-11-11 08:36:30.882951', '3', '面食', 1, '[{\"added\": {}}]', 7, 2);
INSERT INTO `django_admin_log` VALUES (14, '2024-11-11 08:36:38.425325', '4', '烧烤', 1, '[{\"added\": {}}]', 7, 2);
INSERT INTO `django_admin_log` VALUES (15, '2024-11-11 08:36:48.363714', '5', '甜品和饮品', 1, '[{\"added\": {}}]', 7, 2);
INSERT INTO `django_admin_log` VALUES (16, '2024-11-11 08:40:44.147158', '5', '汉堡王', 1, '[{\"added\": {}}]', 10, 2);
INSERT INTO `django_admin_log` VALUES (17, '2024-11-11 08:41:44.966044', '6', '炸鸡', 1, '[{\"added\": {}}]', 10, 2);
INSERT INTO `django_admin_log` VALUES (18, '2024-11-11 08:42:37.376075', '7', '披萨', 1, '[{\"added\": {}}]', 10, 2);
INSERT INTO `django_admin_log` VALUES (19, '2024-11-11 08:51:26.001441', '8', '烤鸡翅', 1, '[{\"added\": {}}]', 10, 2);
INSERT INTO `django_admin_log` VALUES (20, '2024-11-11 08:52:50.870722', '9', '烤肉串', 1, '[{\"added\": {}}]', 10, 2);
INSERT INTO `django_admin_log` VALUES (21, '2024-11-11 08:54:52.974823', '10', '冰淇淋', 1, '[{\"added\": {}}]', 10, 2);
INSERT INTO `django_admin_log` VALUES (22, '2024-11-11 08:56:15.229287', '11', '奶茶', 1, '[{\"added\": {}}]', 10, 2);
INSERT INTO `django_admin_log` VALUES (23, '2024-11-11 08:58:37.014133', '12', '兰州拉面', 1, '[{\"added\": {}}]', 10, 2);
INSERT INTO `django_admin_log` VALUES (24, '2024-11-11 09:00:02.501872', '13', '饺子', 1, '[{\"added\": {}}]', 10, 2);
INSERT INTO `django_admin_log` VALUES (25, '2024-11-11 09:01:19.218919', '10', '冰淇淋', 2, '[{\"changed\": {\"fields\": [\"\\u63cf\\u8ff0\"]}}]', 10, 2);
INSERT INTO `django_admin_log` VALUES (26, '2024-11-11 09:06:07.070427', '9', '烤肉串', 2, '[{\"changed\": {\"fields\": [\"\\u63cf\\u8ff0\"]}}]', 10, 2);
INSERT INTO `django_admin_log` VALUES (27, '2024-11-11 09:06:59.547144', '8', '烤鸡翅', 2, '[{\"changed\": {\"fields\": [\"\\u63cf\\u8ff0\"]}}]', 10, 2);
INSERT INTO `django_admin_log` VALUES (28, '2024-11-11 09:08:59.000385', '7', '披萨', 2, '[{\"changed\": {\"fields\": [\"\\u63cf\\u8ff0\"]}}]', 10, 2);
INSERT INTO `django_admin_log` VALUES (29, '2024-11-11 09:09:56.820454', '5', '汉堡王', 2, '[{\"changed\": {\"fields\": [\"\\u63cf\\u8ff0\"]}}]', 10, 2);

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `model` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq`(`app_label` ASC, `model` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES (1, 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES (13, 'app', 'cartitem');
INSERT INTO `django_content_type` VALUES (7, 'app', 'category');
INSERT INTO `django_content_type` VALUES (14, 'app', 'favorite');
INSERT INTO `django_content_type` VALUES (8, 'app', 'order');
INSERT INTO `django_content_type` VALUES (11, 'app', 'orderitem');
INSERT INTO `django_content_type` VALUES (10, 'app', 'product');
INSERT INTO `django_content_type` VALUES (12, 'app', 'product_score');
INSERT INTO `django_content_type` VALUES (9, 'app', 'userinfo');
INSERT INTO `django_content_type` VALUES (3, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (2, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (4, 'auth', 'user');
INSERT INTO `django_content_type` VALUES (5, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES (6, 'sessions', 'session');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES (1, 'contenttypes', '0001_initial', '2024-11-11 03:23:29.425076');
INSERT INTO `django_migrations` VALUES (2, 'auth', '0001_initial', '2024-11-11 03:23:29.889045');
INSERT INTO `django_migrations` VALUES (3, 'admin', '0001_initial', '2024-11-11 03:23:29.973570');
INSERT INTO `django_migrations` VALUES (4, 'admin', '0002_logentry_remove_auto_add', '2024-11-11 03:23:29.980228');
INSERT INTO `django_migrations` VALUES (5, 'admin', '0003_logentry_add_action_flag_choices', '2024-11-11 03:23:29.987881');
INSERT INTO `django_migrations` VALUES (6, 'app', '0001_initial', '2024-11-11 03:23:30.514235');
INSERT INTO `django_migrations` VALUES (7, 'contenttypes', '0002_remove_content_type_name', '2024-11-11 03:23:30.575917');
INSERT INTO `django_migrations` VALUES (8, 'auth', '0002_alter_permission_name_max_length', '2024-11-11 03:23:30.616354');
INSERT INTO `django_migrations` VALUES (9, 'auth', '0003_alter_user_email_max_length', '2024-11-11 03:23:30.643263');
INSERT INTO `django_migrations` VALUES (10, 'auth', '0004_alter_user_username_opts', '2024-11-11 03:23:30.651075');
INSERT INTO `django_migrations` VALUES (11, 'auth', '0005_alter_user_last_login_null', '2024-11-11 03:23:30.695602');
INSERT INTO `django_migrations` VALUES (12, 'auth', '0006_require_contenttypes_0002', '2024-11-11 03:23:30.697967');
INSERT INTO `django_migrations` VALUES (13, 'auth', '0007_alter_validators_add_error_messages', '2024-11-11 03:23:30.706327');
INSERT INTO `django_migrations` VALUES (14, 'auth', '0008_alter_user_username_max_length', '2024-11-11 03:23:30.749567');
INSERT INTO `django_migrations` VALUES (15, 'auth', '0009_alter_user_last_name_max_length', '2024-11-11 03:23:30.801094');
INSERT INTO `django_migrations` VALUES (16, 'auth', '0010_alter_group_name_max_length', '2024-11-11 03:23:30.833182');
INSERT INTO `django_migrations` VALUES (17, 'auth', '0011_update_proxy_permissions', '2024-11-11 03:23:30.841802');
INSERT INTO `django_migrations` VALUES (18, 'auth', '0012_alter_user_first_name_max_length', '2024-11-11 03:23:30.886689');
INSERT INTO `django_migrations` VALUES (19, 'sessions', '0001_initial', '2024-11-11 03:23:30.912385');
INSERT INTO `django_migrations` VALUES (20, 'app', '0002_rename_job_score_product_score_and_more', '2024-11-11 06:35:40.679950');
INSERT INTO `django_migrations` VALUES (21, 'app', '0003_alter_order_transaction_id_alter_product_view_count', '2024-11-11 07:54:04.666694');
INSERT INTO `django_migrations` VALUES (22, 'app', '0004_alter_order_transaction_id', '2024-11-11 07:58:34.720059');
INSERT INTO `django_migrations` VALUES (23, 'app', '0005_alter_order_transaction_id_alter_product_image_and_more', '2024-11-12 02:00:16.410538');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session`  (
  `session_key` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `session_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  INDEX `django_session_expire_date_a5c62663`(`expire_date` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('4wrtei126xi3bv3jsb4a2ae7crppruzw', '.eJxVjDkOwjAUBe_iGlk2sbxQ0nMG62_BAWRLcVJF3B0ipYD2zczbVIZ1KXntMueJ1UVZdfrdEOgpdQf8gHpvmlpd5gn1ruiDdn1rLK_r4f4dFOjlWxu2g3A04xgGSByTk5SicxSMBzAWCdCI5eAiyhmEIlsMwN4a78CTen8A83k4hg:1tAmEf:ETkrQxfEuWZbcvdl-KRuZwdztN79mswyKttThEO7ow8', '2024-11-26 08:26:53.243372');
INSERT INTO `django_session` VALUES ('s28uqmtuxj3uc4lwu0x7qkr8as87fhgh', '.eJxVjDsOwjAQBe_iGlnrv6Gk5wzWrj84gGwpTirE3ZGlFNC-mXlvFnDfathHXsOS2IVpdvrdCOMztwnSA9u989jbti7Ep8IPOvitp_y6Hu7fQcVRZ11UTKXA2ZEiTdIKFdEAaENGIDmrPPhoSIqUBSREJ4S1YB06iYiefb7xODfa:1tAh7Q:tRKnWLiYBhBLLiSJsuwSXu7dlGCPjGpLHhQSEcvmZ90', '2024-11-26 02:59:04.788861');

SET FOREIGN_KEY_CHECKS = 1;
