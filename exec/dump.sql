CREATE DATABASE  IF NOT EXISTS `proctormatic` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `proctormatic`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: k11s209.p.ssafy.io    Database: proctormatic
-- ------------------------------------------------------
-- Server version	9.1.0

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
-- Table structure for table `abnormal`
--

DROP TABLE IF EXISTS `abnormal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abnormal` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `detected_time` time(6) NOT NULL,
  `end_time` time(6) NOT NULL,
  `type` varchar(20) NOT NULL,
  `taker_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `abnormal_taker_id_e083eda7_fk_taker_id` (`taker_id`),
  CONSTRAINT `abnormal_taker_id_e083eda7_fk_taker_id` FOREIGN KEY (`taker_id`) REFERENCES `taker` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=661 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abnormal`
--

LOCK TABLES `abnormal` WRITE;
/*!40000 ALTER TABLE `abnormal` DISABLE KEYS */;
INSERT INTO `abnormal` VALUES (1,'00:00:34.000000','00:00:39.000000','eyesight_left',5),(2,'00:00:50.000000','00:00:55.000000','eyesight_left',5),(3,'00:00:56.000000','00:01:01.000000','eyesight_right',5),(4,'00:01:41.000000','00:01:46.000000','eyesight_right',5),(5,'00:01:47.000000','00:01:52.000000','eyesight_right',5),(6,'00:01:52.000000','00:01:57.000000','eyesight_right',5),(7,'00:00:06.000000','00:00:11.000000','eyesight_left',8),(8,'00:01:57.000000','00:02:02.000000','eyesight_right',5),(9,'00:00:11.000000','00:00:16.000000','eyesight_left',8),(10,'00:00:16.000000','00:00:21.000000','eyesight_left',8),(11,'00:00:21.000000','00:00:26.000000','eyesight_left',8),(12,'00:00:26.000000','00:00:31.000000','eyesight_left',8),(13,'00:00:39.000000','00:00:44.000000','eyesight_left',8),(14,'00:00:08.000000','00:00:13.000000','eyesight_left',9),(15,'00:00:44.000000','00:00:49.000000','eyesight_left',8),(16,'00:00:49.000000','00:00:54.000000','eyesight_left',8),(17,'00:00:54.000000','00:00:59.000000','eyesight_left',8),(18,'00:00:20.000000','00:00:25.000000','eyesight_left',9),(19,'00:00:59.000000','00:01:04.000000','eyesight_left',8),(20,'00:01:04.000000','00:01:09.000000','eyesight_left',8),(21,'00:03:02.000000','00:03:07.000000','eyesight_right',5),(22,'00:01:11.000000','00:01:16.000000','eyesight_left',8),(23,'00:00:37.000000','00:00:42.000000','eyesight_left',9),(24,'00:03:07.000000','00:03:12.000000','eyesight_right',5),(25,'00:01:17.000000','00:01:22.000000','eyesight_left',8),(26,'00:00:43.000000','00:00:48.000000','eyesight_left',9),(27,'00:01:22.000000','00:01:27.000000','eyesight_left',8),(28,'00:03:12.000000','00:03:17.000000','eyesight_up',5),(29,'00:00:48.000000','00:00:53.000000','eyesight_left',9),(30,'00:01:27.000000','00:01:32.000000','eyesight_left',8),(31,'00:00:53.000000','00:00:58.000000','eyesight_left',9),(32,'00:01:32.000000','00:01:37.000000','eyesight_left',8),(33,'00:01:37.000000','00:01:42.000000','eyesight_left',8),(34,'00:01:42.000000','00:01:47.000000','eyesight_left',8),(35,'00:01:47.000000','00:01:52.000000','eyesight_left',8),(36,'00:01:52.000000','00:01:57.000000','eyesight_left',8),(37,'00:01:57.000000','00:02:02.000000','eyesight_left',8),(38,'00:01:22.000000','00:01:27.000000','eyesight_left',9),(39,'00:02:02.000000','00:02:07.000000','eyesight_left',8),(40,'00:02:07.000000','00:02:12.000000','eyesight_left',8),(41,'00:02:12.000000','00:02:17.000000','eyesight_left',8),(42,'00:02:17.000000','00:02:22.000000','eyesight_left',8),(43,'00:02:22.000000','00:02:27.000000','eyesight_left',8),(44,'00:02:27.000000','00:02:32.000000','eyesight_left',8),(45,'00:02:32.000000','00:02:37.000000','eyesight_left',8),(46,'00:02:37.000000','00:02:42.000000','eyesight_left',8),(47,'00:02:43.000000','00:02:48.000000','eyesight_left',8),(48,'00:02:48.000000','00:02:53.000000','eyesight_left',8),(49,'00:02:56.000000','00:02:57.000000','absence',8),(50,'00:02:57.000000','00:02:58.000000','absence',8),(51,'00:03:01.000000','00:03:06.000000','eyesight_left',8),(52,'00:03:06.000000','00:03:11.000000','eyesight_left',8),(53,'00:03:11.000000','00:03:16.000000','eyesight_left',8),(54,'00:03:16.000000','00:03:21.000000','eyesight_left',8),(55,'00:03:21.000000','00:03:26.000000','eyesight_left',8),(56,'00:03:27.000000','00:03:28.000000','absence',8),(57,'00:03:27.000000','00:03:32.000000','eyesight_left',8),(58,'00:03:33.000000','00:03:38.000000','eyesight_left',8),(59,'00:03:38.000000','00:03:43.000000','eyesight_left',8),(60,'00:03:43.000000','00:03:48.000000','eyesight_left',8),(61,'00:03:48.000000','00:03:53.000000','eyesight_left',8),(62,'00:00:09.000000','00:00:14.000000','eyesight_left',5),(63,'00:03:55.000000','00:04:00.000000','eyesight_left',8),(64,'00:04:00.000000','00:04:05.000000','eyesight_left',8),(65,'00:04:05.000000','00:04:10.000000','eyesight_left',8),(66,'00:04:17.000000','00:04:18.000000','absence',8),(67,'00:04:18.000000','00:04:19.000000','absence',8),(68,'00:04:20.000000','00:04:21.000000','absence',8),(69,'00:04:17.000000','00:04:22.000000','eyesight_left',8),(70,'00:04:22.000000','00:04:27.000000','eyesight_left',8),(71,'00:04:27.000000','00:04:32.000000','eyesight_left',8),(72,'00:04:32.000000','00:04:37.000000','eyesight_left',8),(73,'00:04:42.000000','00:04:47.000000','eyesight_left',8),(74,'00:04:47.000000','00:04:52.000000','eyesight_left',8),(75,'00:04:52.000000','00:04:57.000000','eyesight_left',8),(76,'00:04:57.000000','00:05:02.000000','eyesight_left',8),(77,'00:05:02.000000','00:05:07.000000','eyesight_left',8),(78,'00:05:07.000000','00:05:12.000000','eyesight_left',8),(79,'00:05:12.000000','00:05:17.000000','eyesight_left',8),(80,'00:01:30.000000','00:01:35.000000','eyesight_right',5),(81,'00:05:17.000000','00:05:22.000000','eyesight_left',8),(82,'00:05:25.000000','00:05:30.000000','eyesight_left',8),(83,'00:02:02.000000','00:02:07.000000','eyesight_left',5),(84,'00:02:13.000000','00:02:18.000000','eyesight_left',5),(85,'00:02:18.000000','00:02:23.000000','eyesight_left',5),(86,'00:02:24.000000','00:02:29.000000','eyesight_left',5),(87,'00:02:57.000000','00:03:02.000000','eyesight_left',5),(88,'00:03:27.000000','00:03:32.000000','eyesight_right',5),(89,'00:04:07.000000','00:04:12.000000','eyesight_left',5),(90,'00:04:48.000000','00:04:53.000000','eyesight_up',5),(91,'00:05:07.000000','00:05:12.000000','eyesight_right',5),(92,'00:05:12.000000','00:05:17.000000','eyesight_right',5),(93,'00:05:17.000000','00:05:22.000000','eyesight_right',5),(94,'00:05:22.000000','00:05:27.000000','eyesight_right',5),(95,'00:05:28.000000','00:05:33.000000','eyesight_right',5),(96,'00:05:47.000000','00:05:52.000000','eyesight_up',7),(97,'00:06:12.000000','00:06:17.000000','eyesight_left',7),(98,'00:06:48.000000','00:06:53.000000','eyesight_left',7),(99,'00:06:56.000000','00:07:01.000000','eyesight_left',7),(100,'00:11:21.000000','00:11:26.000000','eyesight_left',8),(101,'00:07:02.000000','00:07:07.000000','eyesight_left',7),(102,'00:11:26.000000','00:11:31.000000','eyesight_left',8),(103,'00:11:31.000000','00:11:36.000000','eyesight_left',8),(104,'00:07:12.000000','00:07:17.000000','eyesight_left',7),(105,'00:11:39.000000','00:11:44.000000','eyesight_left',8),(106,'00:07:17.000000','00:07:22.000000','eyesight_left',7),(107,'00:11:44.000000','00:11:49.000000','eyesight_left',8),(108,'00:07:25.000000','00:07:30.000000','eyesight_left',7),(109,'00:11:49.000000','00:11:54.000000','eyesight_left',8),(110,'00:11:57.000000','00:12:02.000000','eyesight_left',8),(111,'00:12:02.000000','00:12:07.000000','eyesight_left',8),(112,'00:07:41.000000','00:07:46.000000','eyesight_left',7),(113,'00:12:07.000000','00:12:12.000000','eyesight_left',8),(114,'00:07:46.000000','00:07:51.000000','eyesight_left',7),(115,'00:07:51.000000','00:07:56.000000','eyesight_left',7),(116,'00:08:44.000000','00:08:49.000000','eyesight_left',7),(117,'00:09:29.000000','00:09:34.000000','eyesight_left',7),(118,'00:09:34.000000','00:09:39.000000','eyesight_left',7),(119,'00:09:49.000000','00:09:54.000000','eyesight_left',7),(120,'00:09:54.000000','00:09:59.000000','eyesight_left',7),(121,'00:10:00.000000','00:10:05.000000','eyesight_up',7),(122,'00:10:05.000000','00:10:10.000000','eyesight_up',7),(123,'00:10:10.000000','00:10:15.000000','eyesight_right',7),(124,'00:10:19.000000','00:10:24.000000','eyesight_up',7),(125,'00:01:08.000000','00:01:13.000000','eyesight_left',9),(126,'00:11:41.000000','00:11:42.000000','absence',7),(127,'00:11:42.000000','00:11:56.000000','absence',7),(128,'00:16:30.000000','00:16:35.000000','eyesight_left',8),(129,'00:16:35.000000','00:16:40.000000','eyesight_left',8),(130,'00:00:00.000000','00:03:52.000000','absence',6),(131,'00:03:53.000000','00:03:54.000000','absence',6),(132,'00:03:54.000000','00:03:55.000000','absence',6),(133,'00:12:22.000000','00:12:27.000000','eyesight_right',7),(134,'00:03:57.000000','00:03:58.000000','absence',6),(135,'00:03:59.000000','00:04:00.000000','absence',6),(136,'00:04:00.000000','00:04:01.000000','absence',6),(137,'00:04:01.000000','00:04:02.000000','absence',6),(138,'00:04:02.000000','00:04:03.000000','absence',6),(139,'00:04:03.000000','00:04:04.000000','absence',6),(140,'00:04:04.000000','00:04:05.000000','absence',6),(141,'00:04:05.000000','00:04:06.000000','absence',6),(142,'00:04:06.000000','00:04:07.000000','absence',6),(143,'00:12:35.000000','00:12:36.000000','absence',7),(144,'00:04:07.000000','00:04:08.000000','absence',6),(145,'00:04:08.000000','00:04:09.000000','absence',6),(146,'00:04:09.000000','00:04:10.000000','absence',6),(147,'00:04:10.000000','00:04:11.000000','absence',6),(148,'00:04:11.000000','00:04:12.000000','absence',6),(149,'00:04:12.000000','00:04:13.000000','absence',6),(150,'00:12:39.000000','00:12:41.000000','absence',7),(151,'00:16:59.000000','00:17:04.000000','eyesight_left',8),(152,'00:17:00.000000','00:17:04.000000','absence',8),(153,'00:04:13.000000','00:04:14.000000','absence',6),(154,'00:04:15.000000','00:04:16.000000','absence',6),(155,'00:17:04.000000','00:17:07.000000','absence',8),(156,'00:04:16.000000','00:04:17.000000','absence',6),(157,'00:04:17.000000','00:04:18.000000','absence',6),(158,'00:04:18.000000','00:04:19.000000','absence',6),(159,'00:12:45.000000','00:12:47.000000','absence',7),(160,'00:04:20.000000','00:04:21.000000','absence',6),(161,'00:12:45.000000','00:12:50.000000','eyesight_up',7),(162,'00:17:09.000000','00:17:13.000000','absence',8),(163,'00:04:22.000000','00:04:23.000000','absence',6),(164,'00:17:09.000000','00:17:14.000000','eyesight_up',8),(165,'00:04:23.000000','00:04:24.000000','absence',6),(166,'00:12:51.000000','00:12:52.000000','absence',7),(167,'00:12:52.000000','00:12:53.000000','absence',7),(168,'00:17:16.000000','00:17:17.000000','absence',8),(169,'00:04:25.000000','00:04:26.000000','absence',6),(170,'00:04:26.000000','00:04:27.000000','absence',6),(171,'00:04:27.000000','00:04:28.000000','absence',6),(172,'00:12:55.000000','00:12:57.000000','absence',7),(173,'00:04:28.000000','00:04:29.000000','absence',6),(174,'00:04:29.000000','00:04:30.000000','absence',6),(175,'00:17:16.000000','00:17:21.000000','eyesight_left',8),(176,'00:04:30.000000','00:04:31.000000','absence',6),(177,'00:17:21.000000','00:17:22.000000','absence',8),(178,'00:04:31.000000','00:04:32.000000','absence',6),(179,'00:04:32.000000','00:04:33.000000','absence',6),(180,'00:04:33.000000','00:04:34.000000','absence',6),(181,'00:04:34.000000','00:04:35.000000','absence',6),(182,'00:04:36.000000','00:04:37.000000','absence',6),(183,'00:04:37.000000','00:04:38.000000','absence',6),(184,'00:04:38.000000','00:04:39.000000','absence',6),(185,'00:04:39.000000','00:04:40.000000','absence',6),(186,'00:04:40.000000','00:04:41.000000','absence',6),(187,'00:04:41.000000','00:04:42.000000','absence',6),(188,'00:04:42.000000','00:04:43.000000','absence',6),(189,'00:04:43.000000','00:04:44.000000','absence',6),(190,'00:04:44.000000','00:04:45.000000','absence',6),(191,'00:17:35.000000','00:17:36.000000','absence',8),(192,'00:04:45.000000','00:04:46.000000','absence',6),(193,'00:04:46.000000','00:04:47.000000','absence',6),(194,'00:04:47.000000','00:04:48.000000','absence',6),(195,'00:04:48.000000','00:04:49.000000','absence',6),(196,'00:04:49.000000','00:04:50.000000','absence',6),(197,'00:04:50.000000','00:04:51.000000','absence',6),(198,'00:04:51.000000','00:04:52.000000','absence',6),(199,'00:04:52.000000','00:04:53.000000','absence',6),(200,'00:04:53.000000','00:04:54.000000','absence',6),(201,'00:13:21.000000','00:13:23.000000','absence',7),(202,'00:04:55.000000','00:04:56.000000','absence',6),(203,'00:04:57.000000','00:04:58.000000','absence',6),(204,'00:04:58.000000','00:04:59.000000','absence',6),(205,'00:13:25.000000','00:13:30.000000','eyesight_left',7),(206,'00:05:01.000000','00:05:02.000000','absence',6),(207,'00:05:02.000000','00:05:03.000000','absence',6),(208,'00:05:04.000000','00:05:05.000000','absence',6),(209,'00:05:05.000000','00:05:06.000000','absence',6),(210,'00:13:30.000000','00:13:35.000000','eyesight_up',7),(211,'00:05:06.000000','00:05:07.000000','absence',6),(212,'00:05:07.000000','00:05:08.000000','absence',6),(213,'00:05:08.000000','00:05:09.000000','absence',6),(214,'00:05:09.000000','00:05:10.000000','absence',6),(215,'00:13:35.000000','00:13:39.000000','absence',7),(216,'00:05:11.000000','00:05:12.000000','absence',6),(217,'00:13:40.000000','00:13:41.000000','absence',7),(218,'00:05:12.000000','00:05:13.000000','absence',6),(219,'00:05:14.000000','00:05:15.000000','absence',6),(220,'00:13:44.000000','00:13:45.000000','absence',7),(221,'00:13:40.000000','00:13:45.000000','eyesight_left',7),(222,'00:05:15.000000','00:05:19.000000','absence',6),(223,'00:05:19.000000','00:05:20.000000','absence',6),(224,'00:13:49.000000','00:13:50.000000','absence',7),(225,'00:13:45.000000','00:13:50.000000','eyesight_left',7),(226,'00:13:54.000000','00:13:55.000000','absence',7),(227,'00:13:51.000000','00:13:56.000000','eyesight_left',7),(228,'00:13:57.000000','00:13:58.000000','absence',7),(229,'00:14:00.000000','00:14:01.000000','absence',7),(230,'00:13:57.000000','00:14:02.000000','eyesight_left',7),(231,'00:14:02.000000','00:14:04.000000','absence',7),(232,'00:14:02.000000','00:14:07.000000','eyesight_left',7),(233,'00:14:09.000000','00:14:10.000000','absence',7),(234,'00:14:10.000000','00:14:12.000000','absence',7),(235,'00:14:07.000000','00:14:12.000000','eyesight_left',7),(236,'00:14:12.000000','00:14:13.000000','absence',7),(237,'00:14:15.000000','00:14:16.000000','absence',7),(238,'00:14:13.000000','00:14:18.000000','eyesight_left',7),(239,'00:14:17.000000','00:14:18.000000','absence',7),(240,'00:14:18.000000','00:14:20.000000','absence',7),(241,'00:14:23.000000','00:14:24.000000','absence',7),(242,'00:14:20.000000','00:14:25.000000','eyesight_left',7),(243,'00:14:25.000000','00:14:26.000000','absence',7),(244,'00:14:26.000000','00:14:28.000000','absence',7),(245,'00:14:25.000000','00:14:30.000000','eyesight_left',7),(246,'00:14:34.000000','00:14:36.000000','absence',7),(247,'00:14:31.000000','00:14:36.000000','eyesight_left',7),(248,'00:14:37.000000','00:14:38.000000','absence',7),(249,'00:14:39.000000','00:14:40.000000','absence',7),(250,'00:14:41.000000','00:14:42.000000','absence',7),(251,'00:14:37.000000','00:14:42.000000','eyesight_left',7),(252,'00:14:43.000000','00:14:44.000000','absence',7),(253,'00:14:42.000000','00:14:47.000000','eyesight_left',7),(254,'00:14:47.000000','00:14:48.000000','absence',7),(255,'00:14:49.000000','00:14:50.000000','absence',7),(256,'00:14:52.000000','00:14:54.000000','absence',7),(257,'00:14:49.000000','00:14:54.000000','eyesight_left',7),(258,'00:14:56.000000','00:14:57.000000','absence',7),(259,'00:14:57.000000','00:14:58.000000','absence',7),(260,'00:14:54.000000','00:14:59.000000','eyesight_left',7),(261,'00:15:02.000000','00:15:03.000000','absence',7),(262,'00:14:59.000000','00:15:04.000000','eyesight_left',7),(263,'00:15:09.000000','00:15:10.000000','absence',7),(264,'00:15:06.000000','00:15:11.000000','eyesight_left',7),(265,'00:15:12.000000','00:15:13.000000','absence',7),(266,'00:15:14.000000','00:15:15.000000','absence',7),(267,'00:15:11.000000','00:15:16.000000','eyesight_left',7),(268,'00:15:16.000000','00:15:17.000000','absence',7),(269,'00:15:27.000000','00:15:32.000000','eyesight_up',7),(270,'00:19:50.000000','00:19:55.000000','eyesight_left',8),(271,'00:15:42.000000','00:15:47.000000','eyesight_up',7),(272,'00:15:56.000000','00:16:01.000000','eyesight_up',7),(273,'00:16:04.000000','00:16:05.000000','absence',7),(274,'00:16:02.000000','00:16:07.000000','eyesight_left',7),(275,'00:16:12.000000','00:16:13.000000','absence',7),(276,'00:16:30.000000','00:16:35.000000','eyesight_up',7),(277,'00:16:48.000000','00:16:49.000000','absence',7),(278,'00:16:45.000000','00:16:50.000000','eyesight_up',7),(279,'00:16:50.000000','00:16:55.000000','eyesight_up',7),(280,'00:16:56.000000','00:17:01.000000','eyesight_right',7),(281,'00:17:03.000000','00:17:08.000000','eyesight_up',7),(282,'00:21:51.000000','00:21:56.000000','eyesight_left',8),(283,'00:21:58.000000','00:21:59.000000','absence',8),(284,'00:17:35.000000','00:17:40.000000','eyesight_left',7),(285,'00:17:40.000000','00:17:45.000000','eyesight_left',7),(286,'00:17:45.000000','00:17:50.000000','eyesight_left',7),(287,'00:17:50.000000','00:17:55.000000','eyesight_left',7),(288,'00:17:55.000000','00:18:00.000000','eyesight_left',7),(289,'00:18:01.000000','00:18:06.000000','eyesight_left',7),(290,'00:18:06.000000','00:18:11.000000','eyesight_left',7),(291,'00:18:11.000000','00:18:16.000000','eyesight_left',7),(292,'00:18:18.000000','00:18:19.000000','absence',7),(293,'00:18:26.000000','00:18:31.000000','eyesight_left',7),(294,'00:18:34.000000','00:18:35.000000','absence',7),(295,'00:18:32.000000','00:18:37.000000','eyesight_left',7),(296,'00:18:37.000000','00:18:42.000000','eyesight_left',7),(297,'00:18:45.000000','00:18:48.000000','absence',7),(298,'00:18:43.000000','00:18:48.000000','eyesight_left',7),(299,'00:18:49.000000','00:18:50.000000','absence',7),(300,'00:00:30.000000','00:00:35.000000','eyesight_right',9),(301,'00:18:48.000000','00:18:53.000000','eyesight_left',7),(302,'00:00:36.000000','00:00:41.000000','eyesight_right',9),(303,'00:18:56.000000','00:19:01.000000','eyesight_left',7),(304,'00:19:05.000000','00:19:10.000000','eyesight_left',7),(305,'00:19:17.000000','00:19:22.000000','eyesight_up',7),(306,'00:19:22.000000','00:19:27.000000','eyesight_up',7),(307,'00:19:38.000000','00:19:43.000000','eyesight_left',7),(308,'00:20:36.000000','00:20:41.000000','eyesight_right',7),(309,'00:20:45.000000','00:20:50.000000','eyesight_right',7),(310,'00:20:50.000000','00:20:55.000000','eyesight_up',7),(311,'00:02:45.000000','00:02:50.000000','eyesight_right',9),(312,'00:21:07.000000','00:21:12.000000','eyesight_up',7),(313,'00:21:12.000000','00:21:17.000000','eyesight_up',7),(314,'00:00:57.000000','00:01:02.000000','eyesight_left',9),(315,'00:01:22.000000','00:01:27.000000','eyesight_up',9),(316,'00:00:02.000000','00:00:07.000000','eyesight_left',7),(317,'00:00:07.000000','00:00:12.000000','eyesight_left',7),(318,'00:00:13.000000','00:00:18.000000','eyesight_left',7),(319,'00:01:01.000000','00:01:06.000000','eyesight_left',9),(320,'00:01:17.000000','00:01:22.000000','eyesight_right',9),(321,'00:01:35.000000','00:01:40.000000','eyesight_left',9),(322,'00:05:20.000000','00:24:42.000000','absence',6),(323,'00:24:43.000000','00:24:44.000000','absence',6),(324,'00:24:44.000000','00:24:45.000000','absence',6),(325,'00:24:46.000000','00:24:47.000000','absence',6),(326,'00:24:47.000000','00:24:48.000000','absence',6),(327,'00:24:48.000000','00:24:49.000000','absence',6),(328,'00:24:49.000000','00:24:50.000000','absence',6),(329,'00:24:50.000000','00:24:54.000000','absence',6),(330,'00:24:55.000000','00:24:56.000000','absence',6),(331,'00:24:56.000000','00:24:57.000000','absence',6),(332,'00:40:08.000000','00:40:13.000000','eyesight_left',8),(333,'00:40:15.000000','00:40:16.000000','absence',8),(334,'00:40:17.000000','00:40:18.000000','absence',8),(335,'00:40:13.000000','00:40:18.000000','eyesight_left',8),(336,'00:40:18.000000','00:40:19.000000','absence',8),(337,'00:40:20.000000','00:40:25.000000','eyesight_left',8),(338,'00:24:59.000000','00:27:37.000000','absence',6),(339,'00:27:37.000000','00:27:38.000000','absence',6),(340,'00:27:38.000000','00:27:39.000000','absence',6),(341,'00:40:31.000000','00:40:32.000000','absence',8),(342,'00:27:39.000000','00:27:50.000000','absence',6),(343,'00:27:50.000000','00:27:51.000000','absence',6),(344,'00:40:42.000000','00:40:43.000000','absence',8),(345,'00:27:51.000000','00:27:52.000000','absence',6),(346,'00:27:52.000000','00:27:53.000000','absence',6),(347,'00:27:53.000000','00:27:54.000000','absence',6),(348,'00:27:54.000000','00:27:55.000000','absence',6),(349,'00:40:46.000000','00:40:47.000000','absence',8),(350,'00:40:50.000000','00:40:51.000000','absence',8),(351,'00:40:51.000000','00:40:52.000000','absence',8),(352,'00:00:02.000000','00:00:07.000000','eyesight_left',9),(353,'00:00:07.000000','00:00:12.000000','eyesight_left',9),(354,'00:00:12.000000','00:00:17.000000','eyesight_left',9),(355,'00:00:17.000000','00:00:22.000000','eyesight_left',9),(356,'00:00:42.000000','00:00:47.000000','eyesight_up',9),(357,'00:00:02.000000','00:00:07.000000','eyesight_left',9),(358,'00:27:55.000000','00:30:53.000000','absence',6),(359,'00:30:53.000000','00:30:54.000000','absence',6),(360,'00:30:54.000000','00:30:55.000000','absence',6),(361,'00:30:55.000000','00:31:53.000000','absence',6),(362,'00:31:53.000000','00:31:54.000000','absence',6),(363,'00:31:54.000000','00:32:21.000000','absence',6),(364,'00:32:22.000000','00:32:23.000000','absence',6),(365,'00:32:23.000000','00:32:24.000000','absence',6),(366,'00:32:24.000000','00:32:25.000000','absence',6),(367,'00:32:25.000000','00:32:26.000000','absence',6),(368,'00:32:27.000000','00:32:28.000000','absence',6),(369,'00:32:28.000000','00:32:30.000000','absence',6),(370,'00:32:31.000000','00:32:32.000000','absence',6),(371,'00:32:33.000000','00:32:34.000000','absence',6),(372,'00:32:34.000000','00:32:35.000000','absence',6),(373,'00:32:35.000000','00:32:36.000000','absence',6),(374,'00:32:36.000000','00:32:37.000000','absence',6),(375,'00:32:37.000000','00:32:38.000000','absence',6),(376,'00:32:38.000000','00:32:39.000000','absence',6),(377,'00:00:02.000000','00:00:07.000000','eyesight_left',9),(378,'00:00:07.000000','00:00:12.000000','eyesight_left',9),(379,'00:00:40.000000','00:00:45.000000','eyesight_left',9),(380,'00:00:45.000000','00:00:50.000000','eyesight_left',9),(381,'00:00:50.000000','00:00:55.000000','eyesight_left',9),(382,'00:00:55.000000','00:01:00.000000','eyesight_left',9),(383,'00:01:07.000000','00:01:12.000000','eyesight_up',9),(384,'00:01:15.000000','00:01:20.000000','eyesight_left',9),(385,'00:04:07.000000','00:04:12.000000','eyesight_left',9),(386,'00:01:21.000000','00:04:12.000000','absence',9),(387,'00:04:13.000000','00:04:18.000000','eyesight_left',9),(388,'00:04:18.000000','00:04:23.000000','eyesight_left',9),(389,'00:04:23.000000','00:04:28.000000','eyesight_left',9),(390,'00:04:28.000000','00:04:33.000000','eyesight_left',9),(391,'00:04:38.000000','00:04:55.000000','absence',9),(392,'00:05:29.000000','00:05:34.000000','eyesight_left',9),(393,'00:05:34.000000','00:05:39.000000','eyesight_left',9),(394,'00:05:39.000000','00:05:44.000000','eyesight_left',9),(395,'00:06:06.000000','00:08:15.000000','absence',9),(396,'00:08:10.000000','00:08:15.000000','eyesight_left',9),(397,'00:08:19.000000','00:08:24.000000','eyesight_left',9),(436,'00:00:03.000000','00:00:07.000000','eyesight_left',11),(443,'00:02:49.000000','00:02:54.000000','eyesight_left',11),(445,'00:02:55.000000','00:03:00.000000','eyesight_right',11),(481,'00:00:47.000000','00:00:55.000000','phone',11),(482,'00:01:44.000000','00:01:47.000000','watch',11),(483,'00:02:31.000000','00:02:38.000000','earphone',11),(546,'00:00:02.000000','00:00:06.000000','absence',14),(547,'00:00:15.000000','00:00:16.000000','absence',14),(548,'00:00:18.000000','00:00:19.000000','absence',14),(549,'00:00:15.000000','00:00:20.000000','eyesight_left',14),(550,'00:00:20.000000','00:00:25.000000','eyesight_left',14),(551,'00:00:02.000000','00:00:07.000000','eyesight_up',14);
/*!40000 ALTER TABLE `abnormal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `answer`
--

DROP TABLE IF EXISTS `answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `answer` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `author` varchar(255) NOT NULL,
  `content` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `question_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `answer_question_id_523c1648_fk_question_id` (`question_id`),
  CONSTRAINT `answer_question_id_523c1648_fk_question_id` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answer`
--

LOCK TABLES `answer` WRITE;
/*!40000 ALTER TABLE `answer` DISABLE KEYS */;
INSERT INTO `answer` VALUES (1,'admin','프록토매틱의 매뉴얼을 참고 바랍니다!','2024-11-18 10:50:35.705066','2024-11-18 10:50:35.705101',1),(2,'test1','매뉴얼을 다운 받을 수 없습니다. 어떻게 해야하나요?','2024-11-18 10:52:06.974831','2024-11-18 10:52:06.974864',1),(3,'admin','빠른 시일 내에 업로드 하겠습니다. 이용에 불편을 드려 죄송합니다.','2024-11-18 10:52:38.180007','2024-11-18 10:52:38.180040',1);
/*!40000 ALTER TABLE `answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add user',1,'add_user'),(2,'Can change user',1,'change_user'),(3,'Can delete user',1,'delete_user'),(4,'Can view user',1,'view_user'),(5,'Can add coin code',2,'add_coincode'),(6,'Can change coin code',2,'change_coincode'),(7,'Can delete coin code',2,'delete_coincode'),(8,'Can view coin code',2,'view_coincode'),(9,'Can add coin',3,'add_coin'),(10,'Can change coin',3,'change_coin'),(11,'Can delete coin',3,'delete_coin'),(12,'Can view coin',3,'view_coin'),(13,'Can add exam',4,'add_exam'),(14,'Can change exam',4,'change_exam'),(15,'Can delete exam',4,'delete_exam'),(16,'Can view exam',4,'view_exam'),(17,'Can add faq',5,'add_faq'),(18,'Can change faq',5,'change_faq'),(19,'Can delete faq',5,'delete_faq'),(20,'Can view faq',5,'view_faq'),(21,'Can add notification',6,'add_notification'),(22,'Can change notification',6,'change_notification'),(23,'Can delete notification',6,'delete_notification'),(24,'Can view notification',6,'view_notification'),(25,'Can add question',7,'add_question'),(26,'Can change question',7,'change_question'),(27,'Can delete question',7,'delete_question'),(28,'Can view question',7,'view_question'),(29,'Can add answer',8,'add_answer'),(30,'Can change answer',8,'change_answer'),(31,'Can delete answer',8,'delete_answer'),(32,'Can view answer',8,'view_answer'),(33,'Can add taker',9,'add_taker'),(34,'Can change taker',9,'change_taker'),(35,'Can delete taker',9,'delete_taker'),(36,'Can view taker',9,'view_taker'),(37,'Can add logs',10,'add_logs'),(38,'Can change logs',10,'change_logs'),(39,'Can delete logs',10,'delete_logs'),(40,'Can view logs',10,'view_logs'),(41,'Can add abnormal',11,'add_abnormal'),(42,'Can change abnormal',11,'change_abnormal'),(43,'Can delete abnormal',11,'delete_abnormal'),(44,'Can view abnormal',11,'view_abnormal'),(45,'Can add Token',12,'add_token'),(46,'Can change Token',12,'change_token'),(47,'Can delete Token',12,'delete_token'),(48,'Can view Token',12,'view_token'),(49,'Can add Token',13,'add_tokenproxy'),(50,'Can change Token',13,'change_tokenproxy'),(51,'Can delete Token',13,'delete_tokenproxy'),(52,'Can view Token',13,'view_tokenproxy'),(53,'Can add log entry',14,'add_logentry'),(54,'Can change log entry',14,'change_logentry'),(55,'Can delete log entry',14,'delete_logentry'),(56,'Can view log entry',14,'view_logentry'),(57,'Can add permission',15,'add_permission'),(58,'Can change permission',15,'change_permission'),(59,'Can delete permission',15,'delete_permission'),(60,'Can view permission',15,'view_permission'),(61,'Can add group',16,'add_group'),(62,'Can change group',16,'change_group'),(63,'Can delete group',16,'delete_group'),(64,'Can view group',16,'view_group'),(65,'Can add content type',17,'add_contenttype'),(66,'Can change content type',17,'change_contenttype'),(67,'Can delete content type',17,'delete_contenttype'),(68,'Can view content type',17,'view_contenttype'),(69,'Can add session',18,'add_session'),(70,'Can change session',18,'change_session'),(71,'Can delete session',18,'delete_session'),(72,'Can view session',18,'view_session');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authtoken_token`
--

DROP TABLE IF EXISTS `authtoken_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`key`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `authtoken_token_user_id_35299eff_fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authtoken_token`
--

LOCK TABLES `authtoken_token` WRITE;
/*!40000 ALTER TABLE `authtoken_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `authtoken_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coin`
--

DROP TABLE IF EXISTS `coin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coin` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `type` varchar(20) NOT NULL,
  `amount` int NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `exam_id` bigint DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `coin_exam_id_d1541060_fk_exam_id` (`exam_id`),
  KEY `coin_user_id_9aea8e66_fk_user_id` (`user_id`),
  CONSTRAINT `coin_exam_id_d1541060_fk_exam_id` FOREIGN KEY (`exam_id`) REFERENCES `exam` (`id`),
  CONSTRAINT `coin_user_id_9aea8e66_fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coin`
--

LOCK TABLES `coin` WRITE;
/*!40000 ALTER TABLE `coin` DISABLE KEYS */;
INSERT INTO `coin` VALUES (1,'charge',10000,'2024-11-18 10:09:28.435616',NULL,2),(2,'use',3600,'2024-11-18 10:10:49.970888',1,2),(3,'charge',10000,'2024-11-18 10:12:43.789873',NULL,1),(4,'use',7200,'2024-11-18 10:13:30.492395',2,1),(5,'charge',10000,'2024-11-18 10:20:22.558031',NULL,1),(6,'use',7200,'2024-11-18 10:21:33.927471',3,1),(7,'charge',10000,'2024-11-18 10:25:20.506716',NULL,2),(8,'use',7200,'2024-11-18 10:28:40.490287',4,2),(9,'use',3600,'2024-11-18 14:14:34.535431',5,2),(10,'use',3600,'2024-11-18 14:16:40.544030',6,2),(13,'charge',10000,'2024-11-18 16:08:40.974724',NULL,2);
/*!40000 ALTER TABLE `coin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coincode`
--

DROP TABLE IF EXISTS `coincode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coincode` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(100) NOT NULL,
  `amount` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coincode`
--

LOCK TABLES `coincode` WRITE;
/*!40000 ALTER TABLE `coincode` DISABLE KEYS */;
INSERT INTO `coincode` VALUES (1,'S209-charge-1000',1000),(2,'S209-charge-5000',5000),(3,'S209-charge-10000',10000);
/*!40000 ALTER TABLE `coincode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'accounts','user'),(14,'admin','logentry'),(16,'auth','group'),(15,'auth','permission'),(12,'authtoken','token'),(13,'authtoken','tokenproxy'),(3,'coins','coin'),(2,'coins','coincode'),(17,'contenttypes','contenttype'),(4,'exams','exam'),(8,'helpdesks','answer'),(5,'helpdesks','faq'),(6,'helpdesks','notification'),(7,'helpdesks','question'),(18,'sessions','session'),(11,'takers','abnormal'),(10,'takers','logs'),(9,'takers','taker');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'accounts','0001_initial','2024-11-18 10:02:32.395975'),(2,'contenttypes','0001_initial','2024-11-18 10:02:32.512438'),(3,'admin','0001_initial','2024-11-18 10:02:32.753691'),(4,'admin','0002_logentry_remove_auto_add','2024-11-18 10:02:32.765957'),(5,'admin','0003_logentry_add_action_flag_choices','2024-11-18 10:02:32.775596'),(6,'contenttypes','0002_remove_content_type_name','2024-11-18 10:02:32.879001'),(7,'auth','0001_initial','2024-11-18 10:02:33.311365'),(8,'auth','0002_alter_permission_name_max_length','2024-11-18 10:02:33.419168'),(9,'auth','0003_alter_user_email_max_length','2024-11-18 10:02:33.432926'),(10,'auth','0004_alter_user_username_opts','2024-11-18 10:02:33.444142'),(11,'auth','0005_alter_user_last_login_null','2024-11-18 10:02:33.456098'),(12,'auth','0006_require_contenttypes_0002','2024-11-18 10:02:33.464151'),(13,'auth','0007_alter_validators_add_error_messages','2024-11-18 10:02:33.477426'),(14,'auth','0008_alter_user_username_max_length','2024-11-18 10:02:33.488271'),(15,'auth','0009_alter_user_last_name_max_length','2024-11-18 10:02:33.500631'),(16,'auth','0010_alter_group_name_max_length','2024-11-18 10:02:33.530470'),(17,'auth','0011_update_proxy_permissions','2024-11-18 10:02:33.544024'),(18,'auth','0012_alter_user_first_name_max_length','2024-11-18 10:02:33.554937'),(19,'authtoken','0001_initial','2024-11-18 10:02:33.699398'),(20,'authtoken','0002_auto_20160226_1747','2024-11-18 10:02:33.719945'),(21,'authtoken','0003_tokenproxy','2024-11-18 10:02:33.727890'),(22,'authtoken','0004_alter_tokenproxy_options','2024-11-18 10:02:33.735860'),(23,'exams','0001_initial','2024-11-18 10:02:33.866518'),(24,'coins','0001_initial','2024-11-18 10:02:34.134660'),(25,'helpdesks','0001_initial','2024-11-18 10:02:34.507846'),(26,'sessions','0001_initial','2024-11-18 10:02:34.568792'),(27,'takers','0001_initial','2024-11-18 10:02:34.974618');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam`
--

DROP TABLE IF EXISTS `exam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `entry_time` time(6) NOT NULL,
  `start_time` time(6) NOT NULL,
  `exit_time` time(6) NOT NULL,
  `end_time` time(6) NOT NULL,
  `url` varchar(255) NOT NULL,
  `expected_taker` int NOT NULL,
  `total_taker` int NOT NULL,
  `cheer_msg` varchar(100) DEFAULT NULL,
  `cost` int NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `exam_user_id_3f839504_fk_user_id` (`user_id`),
  CONSTRAINT `exam_user_id_3f839504_fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam`
--

LOCK TABLES `exam` WRITE;
/*!40000 ALTER TABLE `exam` DISABLE KEYS */;
INSERT INTO `exam` VALUES (1,'S209 인성검사','2024-11-18','13:30:00.000000','14:00:00.000000','14:00:00.000000','15:00:00.000000','https://k11s209.p.ssafy.io/exams/1/',6,5,'',3600,'2024-11-18 10:10:49.966696',0,2),(2,'test 시험','2024-11-18','09:30:00.000000','10:00:00.000000','11:00:00.000000','11:00:00.000000','https://k11s209.p.ssafy.io/exams/2/',6,1,'test 시험입니다!',7200,'2024-11-18 10:13:30.488441',0,1),(3,'test 시험2','2024-11-18','10:30:00.000000','11:00:00.000000','12:30:00.000000','13:00:00.000000','https://k11s209.p.ssafy.io/exams/3/',6,3,'',7200,'2024-11-18 10:21:33.923691',0,1),(4,'SSAFY 11th 기업연계 프로젝트 S209 최종 발표','2024-11-19','12:30:00.000000','13:00:00.000000','13:00:00.000000','15:00:00.000000','https://k11s209.p.ssafy.io/exams/4/',6,0,'그동안 수고 많으셨습니다! 끝까지 화이팅!',7200,'2024-11-18 10:28:40.486143',0,2),(5,'S209 적성검사','2024-11-18','14:30:00.000000','15:00:00.000000','15:00:00.000000','15:30:00.000000','https://k11s209.p.ssafy.io/exams/5/',6,2,'',3600,'2024-11-18 14:14:34.531602',0,2),(6,'SSAFY 11th 기업연계 프로젝트 S209 최종 발표 리허설','2024-11-18','15:30:00.000000','16:00:00.000000','16:00:00.000000','17:00:00.000000','https://k11s209.p.ssafy.io/exams/6/',6,1,'',3600,'2024-11-18 14:16:40.540095',0,2);
/*!40000 ALTER TABLE `exam` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faq`
--

DROP TABLE IF EXISTS `faq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faq` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `category` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faq`
--

LOCK TABLES `faq` WRITE;
/*!40000 ALTER TABLE `faq` DISABLE KEYS */;
INSERT INTO `faq` VALUES (1,'usage','프록토매틱 이용방법(주최자)','주최자 이용 방법은...','2024-11-18 10:57:24.848801'),(2,'usage','프록토매틱 이용방법(응시자)','응시자 이용 방법은...','2024-11-18 10:57:35.850688'),(3,'coin','적립금 충전 방법','적립금을 충전하는 방법은....','2024-11-18 10:59:26.891262'),(4,'etc','이메일이 기억나지 않아요.','이메일은 가입 시에 작성한 이름과 생년월일로 찾을 수 있습니다.','2024-11-18 11:01:38.535631'),(5,'etc','비밀번호가 기억나지 않아요.','이메일 인증을 통해 비밀번호를 재설정할 수 있습니다.','2024-11-18 11:02:17.224580'),(6,'usage','시험 예약 최대 시간','시험은 최대 2시간까지 예약 가능합니다.','2024-11-18 11:03:13.756522');
/*!40000 ALTER TABLE `faq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logs`
--

DROP TABLE IF EXISTS `logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logs` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `type` varchar(20) NOT NULL,
  `time` time(6) NOT NULL,
  `taker_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `logs_taker_id_6ad99163_fk_taker_id` (`taker_id`),
  CONSTRAINT `logs_taker_id_6ad99163_fk_taker_id` FOREIGN KEY (`taker_id`) REFERENCES `taker` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs`
--

LOCK TABLES `logs` WRITE;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
INSERT INTO `logs` VALUES (1,'entry','10:15:40.666299',1),(2,'entry','10:23:53.342053',1),(3,'entry','11:03:24.806109',1),(4,'entry','11:07:17.500298',2),(5,'entry','11:10:34.506440',2),(6,'exit','12:13:11.123456',2),(7,'entry','11:40:47.640175',1),(8,'entry','11:23:42.737339',1),(9,'entry','11:29:38.156105',1),(10,'entry','11:36:30.049060',3),(11,'entry','11:52:10.369218',4),(12,'entry','11:53:31.824931',4),(13,'entry','13:54:44.495788',5),(14,'entry','13:57:15.978258',6),(15,'entry','14:01:41.558564',7),(16,'entry','14:01:59.476977',8),(17,'entry','14:02:17.836056',9),(18,'entry','14:02:43.398699',6),(19,'entry','14:03:30.178490',9),(20,'entry','14:03:39.728310',7),(21,'entry','14:05:26.356049',6),(22,'entry','14:05:40.153214',5),(23,'entry','14:14:46.464621',9),(24,'entry','14:25:38.256925',9),(25,'entry','14:32:16.599905',7),(26,'entry','15:09:24.441858',9),(27,'entry','15:13:19.373706',10),(28,'entry','15:13:20.154182',11),(30,'entry','15:20:05.881057',11),(31,'entry','15:20:44.505321',10),(32,'entry','15:22:05.363945',11),(33,'exit','15:25:00.295862',11),(34,'exit','15:27:01.687253',11),(38,'entry','16:10:36.728991',14),(39,'entry','16:14:49.379430',14),(43,'entry','16:36:24.843274',14),(44,'entry','16:40:04.833347',14);
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
INSERT INTO `notification` VALUES (1,'[긴급] 서버 점검(24.11.19)','안정적인 서비스를 제공하기 위하여 서버 점검 작업이 진행될 예정입니다. 작업시간 동안 모든 서비스가 일시적으로 중단되오니 양해 부탁 드립니다. 작업 일시\r 2024년 11월 19일 22:00 ~ 23:30\r 이용에 불편을 드려 죄송하며,\r 보다 개선된 서비스를 위해 최선을 다하겠습니다. 감사합니다.\r - 프록토매틱 -','2024-11-18 10:35:35.306604');
/*!40000 ALTER TABLE `notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question`
--

DROP TABLE IF EXISTS `question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `question` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `category` varchar(255) NOT NULL,
  `title` varchar(100) NOT NULL,
  `content` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `question_user_id_30028240_fk_user_id` (`user_id`),
  CONSTRAINT `question_user_id_30028240_fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question`
--

LOCK TABLES `question` WRITE;
/*!40000 ALTER TABLE `question` DISABLE KEYS */;
INSERT INTO `question` VALUES (1,'usage','이용 방법이 궁금합니다.','시험을 어떻게 시작할까요?','2024-11-18 10:45:50.225153','2024-11-18 10:45:50.225182',1);
/*!40000 ALTER TABLE `question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taker`
--

DROP TABLE IF EXISTS `taker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `taker` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `birth` date DEFAULT NULL,
  `web_cam` varchar(255) DEFAULT NULL,
  `id_photo` varchar(255) DEFAULT NULL,
  `verification_rate` int DEFAULT NULL,
  `check_out_state` varchar(255) NOT NULL,
  `stored_state` varchar(255) NOT NULL,
  `exam_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `taker_exam_id_7f42f4ca_fk_exam_id` (`exam_id`),
  CONSTRAINT `taker_exam_id_7f42f4ca_fk_exam_id` FOREIGN KEY (`exam_id`) REFERENCES `exam` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taker`
--

LOCK TABLES `taker` WRITE;
/*!40000 ALTER TABLE `taker` DISABLE KEYS */;
INSERT INTO `taker` VALUES (1,'박재현','brianwogus@naver.com','1999-03-23',NULL,'https://proctormatic.s3.ap-northeast-2.amazonaws.com/2/1/idPhoto.png',32,'abnormal','before',2),(2,'허유정','yu.jeong5899@gmail.com','1995-06-14',NULL,'https://proctormatic.s3.ap-northeast-2.amazonaws.com/3/2/idPhoto.png',61,'normal','before',3),(3,'박재현','brianwogus@naver.com','0999-03-23',NULL,'https://proctormatic.s3.ap-northeast-2.amazonaws.com/3/3/idPhoto.png',34,'abnormal','before',3),(4,'최민','rmdwjd76@naver.com','2001-07-06',NULL,'https://proctormatic.s3.ap-northeast-2.amazonaws.com/3/4/idPhoto.png',89,'abnormal','before',3),(5,'허유정','yu.jeong5899@gmail.com','1995-06-14',NULL,'https://proctormatic.s3.ap-northeast-2.amazonaws.com/1/5/idPhoto.png',64,'abnormal','before',1),(6,'최민','rmdwjd76@naver.com','2001-07-06',NULL,'https://proctormatic.s3.ap-northeast-2.amazonaws.com/1/6/idPhoto.png',46,'abnormal','before',1),(7,'박재현','brianwogus@naver.com','1999-03-23',NULL,'https://proctormatic.s3.ap-northeast-2.amazonaws.com/1/7/idPhoto.png',23,'abnormal','before',1),(8,'이승민','lsm5631@naver.com','2020-02-02',NULL,'https://proctormatic.s3.ap-northeast-2.amazonaws.com/1/8/idPhoto.png',32,'abnormal','before',1),(9,'윤예리','yoonr72@naver.com','2000-01-11',NULL,'https://proctormatic.s3.ap-northeast-2.amazonaws.com/1/9/idPhoto.png',93,'abnormal','before',1),(10,'허유정','yu.jeong5899@gmail.com','1995-06-14',NULL,'https://proctormatic.s3.ap-northeast-2.amazonaws.com/5/10/idPhoto.png',73,'abnormal','before',5),(11,'박재현','brianwogus@naver.com','1999-03-23','https://proctormatic.s3.ap-northeast-2.amazonaws.com/5/11/merged.webm','https://proctormatic.s3.ap-northeast-2.amazonaws.com/5/11/idPhoto.png',76,'normal','done',5),(14,'박재현','brianwogus@naver.com','1999-03-23',NULL,'https://proctormatic.s3.ap-northeast-2.amazonaws.com/6/14/idPhoto.png',33,'abnormal','before',6);
/*!40000 ALTER TABLE `taker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(254) NOT NULL,
  `birth` date NOT NULL,
  `coin_amount` int NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `policy` tinyint(1) NOT NULL,
  `marketing` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'pbkdf2_sha256$600000$zquE8PFWs0224EoXAj9YGd$vRL76j9AGJeh0YcUU9vrQuEL/oTKgEoqTbf7DRzOmg8=',NULL,'test1','test1@test.com','2024-10-14',5370,'2024-11-18 10:04:33.844290',1,1,1),(2,'pbkdf2_sha256$600000$9NiI45GMAqASJ3q6UUwJg7$QJZUghz/vkn0b+8hZDgB4p8alzLFwoMH/otrSWhrmYs=',NULL,'윤예리','s209@gmail.com','2024-10-14',10200,'2024-11-18 10:06:33.960259',1,1,1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-18 20:57:15
