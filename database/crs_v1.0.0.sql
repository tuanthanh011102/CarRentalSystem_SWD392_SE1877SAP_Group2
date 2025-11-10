CREATE DATABASE  IF NOT EXISTS `crs` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `crs`;
-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: crs
-- ------------------------------------------------------
-- Server version	8.0.42

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking` (
  `booking_id` bigint NOT NULL AUTO_INCREMENT,
  `customer_id` bigint NOT NULL,
  `car_id` bigint NOT NULL,
  `price` decimal(10,0) NOT NULL,
  `start_date` date NOT NULL,
  `return_date` date NOT NULL,
  `booking_status` enum('pending','payment pending','confirmed','confirm pending','completed','cancelled','rejected') COLLATE utf8mb4_unicode_ci DEFAULT 'payment pending',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`booking_id`),
  KEY `idx_customer_id` (`customer_id`),
  KEY `idx_booking_status` (`booking_status`),
  KEY `idx_dates` (`start_date`,`return_date`),
  KEY `booking_ibfk_2_idx` (`car_id`),
  CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE,
  CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`car_id`) REFERENCES `car` (`car_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking`
--

LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
INSERT INTO `booking` VALUES (12,1,1,500000,'2025-11-10','2025-11-11','confirm pending','2025-11-07 19:38:57','2025-11-07 19:44:32'),(13,1,2,550000,'2025-11-08','2025-11-09','confirm pending','2025-11-07 19:53:43','2025-11-07 19:55:54'),(14,5,1,500000,'2025-11-28','2025-11-29','payment pending','2025-11-09 15:43:16','2025-11-09 15:43:16'),(15,5,1,500000,'2025-11-20','2025-11-21','payment pending','2025-11-10 15:16:32','2025-11-10 15:16:32'),(16,5,2,550000,'2025-11-20','2025-11-21','confirm pending','2025-11-10 15:45:08','2025-11-10 15:47:08'),(17,3,1,500000,'2025-11-14','2025-11-15','confirm pending','2025-11-10 17:20:57','2025-11-10 17:23:37');
/*!40000 ALTER TABLE `booking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `car`
--

DROP TABLE IF EXISTS `car`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `car` (
  `car_id` bigint NOT NULL AUTO_INCREMENT,
  `owner_id` bigint NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `model` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `color` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `registration_no` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `price_per` decimal(10,2) NOT NULL,
  `status` enum('available','rented','maintenance') COLLATE utf8mb4_unicode_ci DEFAULT 'available',
  `location` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `thumbnail` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`car_id`),
  UNIQUE KEY `registration_no` (`registration_no`),
  KEY `idx_owner_id` (`owner_id`),
  KEY `idx_status` (`status`),
  KEY `idx_registration_no` (`registration_no`),
  CONSTRAINT `car_ibfk_1` FOREIGN KEY (`owner_id`) REFERENCES `owner` (`owner_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `car`
--

LOCK TABLES `car` WRITE;
/*!40000 ALTER TABLE `car` DISABLE KEYS */;
INSERT INTO `car` VALUES (1,1,'Toyota Vios','2023','Trắng','30A-12345',500000.00,'available','Hà Nội','https://i1-vnexpress.vnecdn.net/2023/05/10/Vios202310jpg-1683690295.jpg?w=750&h=450&q=100&dpr=1&fit=crop&s=BteldbQmWr_H2MzwpRG3DQ','2025-10-19 10:52:03','2025-10-22 09:34:39'),(2,1,'Honda City','2022','Đen','30B-23456',550000.00,'available','Hà Nội','https://i1-vnexpress.vnecdn.net/2023/09/05/HondaCityTestVnE20231299jpg-1693904414.jpg?w=750&h=450&q=100&dpr=1&fit=crop&s=bqcv0pbVwRqViH8rrrGCLA','2025-10-19 10:52:03','2025-10-22 09:34:39'),(3,1,'Mazda 3','2023','Đỏ','51F-34567',700000.00,'available','Hà Nội','https://drive.gianhangvn.com/image/9tr5xrn-2745022j30978.jpg','2025-10-19 10:52:03','2025-10-22 09:34:39'),(4,2,'Hyundai Accent','2022','Bạc','51G-45678',480000.00,'available','Hà Nội','https://hyundaikontum-gialai.com/OTO3602200320/files/san_pham/hyundai_accent_all_new_2405.webp','2025-10-19 10:52:03','2025-10-22 09:35:09'),(5,2,'Kia Morning','2023','Xanh','30C-56789',350000.00,'available','Đà Nẵng','https://kiabinhtrieu3s.com/wp-content/uploads/2022/06/new-kia-morning-gt-line-moi.jpg','2025-10-19 10:52:03','2025-10-22 09:34:39'),(6,2,'VinFast Fadil','2023','Trắng','30D-67890',400000.00,'available','Nhà Trang','https://i1-vnexpress.vnecdn.net/2021/09/18/VinFast-Fadil-1-2376-155989771-3514-7717-1559898565.jpg?w=2400&h=0&q=100&dpr=1&fit=crop&s=Gm_vTyWzX0f1zjdTD2ZDcw&t=image','2025-10-19 10:52:03','2025-10-22 09:34:39'),(7,3,'Toyota Fortuner','2023','Đen','51H-78901',1200000.00,'available','Vũng Tàu','https://i1-vnexpress.vnecdn.net/2021/09/18/Fortuner3.jpg?w=2400&h=0&q=100&dpr=1&fit=crop&s=etO430xRY8j0-zsizYyTcQ&t=image','2025-10-19 10:52:03','2025-10-22 09:34:39'),(8,3,'Ford Ranger','2022','Xám','51K-89012',1100000.00,'available','Vũng Tàu','https://www.ford.com.vn/content/dam/Ford/vn/nameplate/ranger/model-walk/stormtrak/vn-stormtrak-arctic-white-model-walk.webp','2025-10-19 10:52:03','2025-10-22 09:35:09'),(9,4,'Honda CR-V','2023','Trắng Ngọc','30E-90123',900000.00,'available','Nhà Trang','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSV24C0IlvC61LO2QtKFSFbfSJI0EJgN-Knw&s','2025-10-19 10:52:03','2025-10-22 09:34:39'),(10,4,'Mazda CX-5','2023','Xanh Đậm','30F-01234',950000.00,'available','Đà Nẵng','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQE9xIfpTo704onWifqv25wfuM2vJrqji0ghg&s','2025-10-19 10:52:03','2025-10-22 09:35:09');
/*!40000 ALTER TABLE `car` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `customer_id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `address` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `ccc_d_id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `gplx` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `idx_user_id` (`user_id`),
  CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,6,'Hoàng Văn Đức','0987654321','15 Đường Kim Mã, Ba Đình, Hà Nội','001089112345','nguyenvanan@email.com','2025-10-19 10:51:01','2025-10-19 10:51:01',NULL),(2,7,'Vũ Thị Mai','0987654322','25 Đường Lý Thường Kiệt, Quận 10, TP.HCM','079089123456','lehoangnam@email.com','2025-10-19 10:51:01','2025-10-19 10:51:01',NULL),(3,8,'Đặng Quốc Tuấn','0987654323','35 Đường Trường Chinh, Thanh Xuân, Hà Nội','001089134567','hoangvanduc@email.com','2025-10-19 10:51:01','2025-10-19 10:51:01',NULL),(4,9,'Bùi Thị Lan','0987654324','45 Đường Pasteur, Quận 1, TP.HCM','079089145678','dangquoctuan@email.com','2025-10-19 10:51:01','2025-10-19 10:51:01',NULL),(5,10,'Đinh Văn Hải','0987654325','55 Đường Xã Đàn, Đống Đa, Hà Nội','001089156789','dinhvanhai@email.com','2025-10-19 10:51:01','2025-10-19 10:51:01',NULL);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dispute`
--

DROP TABLE IF EXISTS `dispute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dispute` (
  `dispute_id` bigint NOT NULL AUTO_INCREMENT,
  `customer_id` bigint NOT NULL,
  `owner_id` bigint NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `dispute_status` enum('in_review','resolved','rejected') COLLATE utf8mb4_unicode_ci DEFAULT 'in_review',
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `resolved_date` timestamp NULL DEFAULT NULL,
  `resolution_text` text COLLATE utf8mb4_unicode_ci,
  `attachments` text COLLATE utf8mb4_unicode_ci,
  `booking_id` bigint NOT NULL,
  PRIMARY KEY (`dispute_id`),
  KEY `idx_customer_id` (`customer_id`),
  KEY `idx_owner_id` (`owner_id`),
  KEY `idx_dispute_status` (`dispute_status`),
  KEY `dispute_ibfk_1_idx` (`booking_id`),
  CONSTRAINT `dispute_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`booking_id`),
  CONSTRAINT `dispute_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE,
  CONSTRAINT `dispute_ibfk_3` FOREIGN KEY (`owner_id`) REFERENCES `owner` (`owner_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dispute`
--

LOCK TABLES `dispute` WRITE;
/*!40000 ALTER TABLE `dispute` DISABLE KEYS */;
/*!40000 ALTER TABLE `dispute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification` (
  `notification_id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('booking','payment','dispute','system') COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('unread','read') COLLATE utf8mb4_unicode_ci DEFAULT 'unread',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`notification_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_status` (`status`),
  KEY `idx_type` (`type`),
  CONSTRAINT `notification_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
INSERT INTO `notification` VALUES (1,2,'Đặt xe thành công','Bạn đã đặt xe Toyota Vios thành công. Mã booking: #BK001','booking','read','2025-10-19 10:45:21'),(2,2,'Thanh toán thành công','Thanh toán 1.500.000 VNĐ đã được xác nhận','payment','read','2025-10-19 10:45:21'),(3,4,'Xe sẵn sàng','Xe Honda City của bạn đã sẵn sàng để nhận','booking','unread','2025-10-19 10:45:21'),(4,6,'Nhắc nhở trả xe','Vui lòng trả xe Mazda 3 trước 18:00 hôm nay','booking','unread','2025-10-19 10:45:21'),(5,8,'Tranh chấp được giải quyết','Tranh chấp #DS001 đã được giải quyết','dispute','read','2025-10-19 10:45:21'),(6,10,'Khuyến mãi đặc biệt','Giảm 20% cho booking tuần tới','system','unread','2025-10-19 10:45:21'),(7,2,'Hoàn tiền','Số tiền 500.000 VNĐ đã được hoàn lại','payment','read','2025-10-19 10:45:21'),(8,4,'Đánh giá chuyến đi','Hãy đánh giá trải nghiệm của bạn với xe Hyundai Accent','booking','unread','2025-10-19 10:45:21'),(9,6,'Cảnh báo hệ thống','Tài khoản của bạn sẽ hết hạn sau 7 ngày','system','unread','2025-10-19 10:45:21'),(10,8,'Xác nhận booking','Booking #BK010 đã được chủ xe xác nhận','booking','read','2025-10-19 10:45:21');
/*!40000 ALTER TABLE `notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `owner`
--

DROP TABLE IF EXISTS `owner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `owner` (
  `owner_id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `contact` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `address` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `ccc_d_id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`owner_id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `idx_user_id` (`user_id`),
  CONSTRAINT `owner_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `owner`
--

LOCK TABLES `owner` WRITE;
/*!40000 ALTER TABLE `owner` DISABLE KEYS */;
INSERT INTO `owner` VALUES (1,2,'Nguyễn Văn An','0912345678','123 Đường Nguyễn Trãi, Thanh Xuân, Hà Nội','001089012345','2025-10-19 10:50:58','2025-10-19 10:50:58'),(2,3,'Trần Thị Bình','0913456789','456 Đường Lê Lợi, Quận 1, TP.HCM','079089023456','2025-10-19 10:50:58','2025-10-19 10:50:58'),(3,4,'Lê Hoàng Nam','0914567890','789 Đường Trần Hưng Đạo, Hoàn Kiếm, Hà Nội','001089034567','2025-10-19 10:50:58','2025-10-19 10:50:58'),(4,5,'Phạm Minh Hằng','0915678901','321 Đường Hai Bà Trưng, Quận 3, TP.HCM','079089045678','2025-10-19 10:50:58','2025-10-19 10:50:58');
/*!40000 ALTER TABLE `owner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `payment_id` bigint NOT NULL AUTO_INCREMENT,
  `booking_id` bigint NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_method` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `status` enum('pending','completed','failed','refunded') COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `gateway_txn_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `paid_at` timestamp NULL DEFAULT NULL,
  `refunded_amount` decimal(10,2) DEFAULT '0.00',
  `refund_status` enum('none','partial','full') COLLATE utf8mb4_unicode_ci DEFAULT 'none',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`payment_id`),
  KEY `idx_booking_id` (`booking_id`),
  KEY `idx_status` (`status`),
  KEY `idx_gateway_txn_id` (`gateway_txn_id`),
  CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`booking_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (12,12,500000.00,'VNPAY','completed','67574673','2025-11-07 19:44:26',0.00,'none','2025-11-07 19:44:16','2025-11-07 19:44:32'),(13,13,550000.00,'VNPAY','completed','05759820','2025-11-07 19:55:48',0.00,'none','2025-11-07 19:55:33','2025-11-07 19:55:54'),(14,15,500000.00,'VNPAY','pending',NULL,NULL,0.00,'none','2025-11-10 15:16:45','2025-11-10 15:16:45'),(15,16,550000.00,'VNPAY','completed','92880923','2025-11-10 15:46:55',0.00,'none','2025-11-10 15:45:45','2025-11-10 15:47:08'),(16,17,500000.00,'VNPAY','completed','47204457','2025-11-10 17:23:15',0.00,'none','2025-11-10 17:21:38','2025-11-10 17:23:37');
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report`
--

DROP TABLE IF EXISTS `report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `report` (
  `report_id` bigint NOT NULL AUTO_INCREMENT,
  `created_by` bigint NOT NULL,
  `booking_id` bigint NOT NULL,
  `report_type` enum('revenue','user_activity','booking','dispute') COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `generated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `summary` text COLLATE utf8mb4_unicode_ci,
  `resolved_by` bigint DEFAULT NULL,
  PRIMARY KEY (`report_id`),
  KEY `idx_report_type` (`report_type`),
  KEY `idx_date_range` (`start_date`,`end_date`),
  KEY `report_ibfk_1_idx` (`created_by`),
  KEY `report_ibfk_2_idx` (`resolved_by`),
  KEY `report_ibfk_3_idx` (`booking_id`) /*!80000 INVISIBLE */,
  CONSTRAINT `report_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `report_ibfk_2` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`booking_id`),
  CONSTRAINT `report_ibfk_3` FOREIGN KEY (`resolved_by`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report`
--

LOCK TABLES `report` WRITE;
/*!40000 ALTER TABLE `report` DISABLE KEYS */;
/*!40000 ALTER TABLE `report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `review_id` bigint NOT NULL AUTO_INCREMENT,
  `customer_id` bigint NOT NULL,
  `car_id` bigint NOT NULL,
  `rating` int NOT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `booking_id` bigint NOT NULL,
  PRIMARY KEY (`review_id`),
  KEY `idx_customer_id` (`customer_id`),
  KEY `idx_car_id` (`car_id`),
  KEY `idx_rating` (`rating`),
  KEY `review_ibfk_1_idx` (`booking_id`),
  CONSTRAINT `review_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`booking_id`),
  CONSTRAINT `review_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE,
  CONSTRAINT `review_ibfk_3` FOREIGN KEY (`car_id`) REFERENCES `car` (`car_id`) ON DELETE CASCADE,
  CONSTRAINT `review_chk_1` CHECK (((`rating` >= 1) and (`rating` <= 5)))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `password_hash` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `role` enum('admin','customer','owner') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`),
  KEY `idx_email` (`email`),
  KEY `idx_role` (`role`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Quản Trị Viên','admin@carrental.com','9de542783b81e99403701c4717b76adadc46fce53edd782737f5e4a1006eaf10','admin','2025-10-19 10:45:05','2025-10-22 16:59:03'),(2,'Nguyễn Văn An','nguyenvanan@email.com','9de542783b81e99403701c4717b76adadc46fce53edd782737f5e4a1006eaf10','customer','2025-10-19 10:45:05','2025-10-22 16:59:03'),(3,'Trần Thị Bình','tranthibinh@email.com','9de542783b81e99403701c4717b76adadc46fce53edd782737f5e4a1006eaf10','owner','2025-10-19 10:45:05','2025-10-22 16:59:03'),(4,'Lê Hoàng Nam','lehoangnam@email.com','9de542783b81e99403701c4717b76adadc46fce53edd782737f5e4a1006eaf10','customer','2025-10-19 10:45:05','2025-10-22 16:59:03'),(5,'Phạm Minh Hằng','phamminhhang@email.com','9de542783b81e99403701c4717b76adadc46fce53edd782737f5e4a1006eaf10','owner','2025-10-19 10:45:05','2025-10-22 16:59:03'),(6,'Hoàng Văn Đức','hoangvanduc@email.com','9de542783b81e99403701c4717b76adadc46fce53edd782737f5e4a1006eaf10','customer','2025-10-19 10:45:05','2025-10-22 16:59:03'),(7,'Vũ Thị Mai','vuthimai@email.com','9de542783b81e99403701c4717b76adadc46fce53edd782737f5e4a1006eaf10','owner','2025-10-19 10:45:05','2025-10-22 16:59:03'),(8,'Đặng Quốc Tuấn','dangquoctuan@email.com','9de542783b81e99403701c4717b76adadc46fce53edd782737f5e4a1006eaf10','customer','2025-10-19 10:45:05','2025-10-22 16:59:03'),(9,'Bùi Thị Lan','buithilan@email.com','9de542783b81e99403701c4717b76adadc46fce53edd782737f5e4a1006eaf10','owner','2025-10-19 10:45:05','2025-10-22 16:59:03'),(10,'Đinh Văn Hải','dinhvanhai@email.com','9de542783b81e99403701c4717b76adadc46fce53edd782737f5e4a1006eaf10','customer','2025-10-19 10:45:05','2025-10-22 16:59:03');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'crs'
--

--
-- Dumping routines for database 'crs'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-11  1:23:34
