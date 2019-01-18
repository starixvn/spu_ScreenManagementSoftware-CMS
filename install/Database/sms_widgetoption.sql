-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: 10.70.70.213    Database: sms
-- ------------------------------------------------------
-- Server version	5.5.57-0ubuntu0.14.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `widgetoption`
--

DROP TABLE IF EXISTS `widgetoption`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `widgetoption` (
  `widgetId` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `option` varchar(254) NOT NULL,
  `value` text,
  PRIMARY KEY (`widgetId`,`type`,`option`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `widgetoption`
--

LOCK TABLES `widgetoption` WRITE;
/*!40000 ALTER TABLE `widgetoption` DISABLE KEYS */;
INSERT INTO `widgetoption` VALUES (2,'attrib','backgroundColor',NULL),(2,'attrib','direction','none'),(2,'attrib','effect','none'),(2,'attrib','fitText','0'),(2,'attrib','marqueeInlineSelector',NULL),(2,'attrib','name',NULL),(2,'attrib','scrollSpeed','2'),(2,'attrib','speed',NULL),(2,'attrib','xmds','1'),(2,'cdata','javaScript',''),(2,'cdata','text','<p style=\"text-align: center;\"><span style=\"font-size:168px;\"><strong><span style=\"font-family:arial,helvetica,sans-serif;\"><span style=\"color:#FFFFFF;\">Welcome to SMS</span></span></strong></span></p>\r\n\r\n<p style=\"text-align: center;\"><span style=\"font-size:80px;\"><span style=\"font-family:arial,helvetica,sans-serif;\"><span style=\"color:#FFFFFF;\">Powerful Digital Signage</span></span></span></p>\r\n\r\n<p style=\"text-align: center;\"><span style=\"font-size:48px;\"><span style=\"color:#D3D3D3;\"><span style=\"font-family:arial,helvetica,sans-serif;\">This is the default layout - please feel free to change it whenever you like.</span></span></span></p>\r\n'),(3,'attrib','backgroundColor',NULL),(3,'attrib','direction','none'),(3,'attrib','effect','none'),(3,'attrib','fitText','0'),(3,'attrib','marqueeInlineSelector',NULL),(3,'attrib','name',NULL),(3,'attrib','scrollSpeed','2'),(3,'attrib','speed',NULL),(3,'attrib','xmds','1'),(3,'cdata','javaScript',''),(3,'cdata','text','<p style=\"text-align: right;\"><span style=\"font-size:96px;\"><span style=\"font-family:arial,helvetica,sans-serif;\"><span style=\"color:#D3D3D3;\">[Clock]</span></span></span></p>\r\n');
/*!40000 ALTER TABLE `widgetoption` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-01-18 10:35:54
