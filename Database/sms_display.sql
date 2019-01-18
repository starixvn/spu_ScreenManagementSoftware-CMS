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
-- Table structure for table `display`
--

DROP TABLE IF EXISTS `display`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `display` (
  `displayid` int(11) NOT NULL AUTO_INCREMENT,
  `auditingUntil` int(11) NOT NULL DEFAULT '0' COMMENT 'Is this display auditing',
  `display` varchar(50) NOT NULL,
  `defaultlayoutid` int(8) NOT NULL,
  `license` varchar(40) DEFAULT NULL,
  `licensed` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Is the Requested License Key Allowed',
  `loggedin` tinyint(4) NOT NULL DEFAULT '0',
  `lastaccessed` int(11) DEFAULT NULL,
  `inc_schedule` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Will this default be used in the scheduling calcs',
  `email_alert` tinyint(1) NOT NULL DEFAULT '1',
  `alert_timeout` int(11) NOT NULL DEFAULT '0',
  `ClientAddress` varchar(100) DEFAULT NULL,
  `MediaInventoryStatus` tinyint(4) NOT NULL DEFAULT '0',
  `MacAddress` varchar(254) DEFAULT NULL COMMENT 'Mac Address of the Client',
  `LastChanged` int(11) DEFAULT NULL COMMENT 'Last time this Mac Address changed',
  `NumberOfMacAddressChanges` int(11) NOT NULL DEFAULT '0',
  `LastWakeOnLanCommandSent` int(11) DEFAULT NULL,
  `WakeOnLan` tinyint(4) NOT NULL DEFAULT '0',
  `WakeOnLanTime` varchar(5) DEFAULT NULL,
  `BroadCastAddress` varchar(100) DEFAULT NULL,
  `SecureOn` varchar(17) DEFAULT NULL,
  `Cidr` varchar(6) DEFAULT NULL,
  `GeoLocation` point DEFAULT NULL,
  `version_instructions` varchar(255) DEFAULT NULL,
  `client_type` varchar(20) DEFAULT NULL,
  `client_version` varchar(15) DEFAULT NULL,
  `client_code` smallint(6) DEFAULT NULL,
  `displayprofileid` int(11) DEFAULT NULL,
  `screenShotRequested` tinyint(4) NOT NULL DEFAULT '0',
  `storageAvailableSpace` bigint(20) DEFAULT NULL,
  `storageTotalSpace` bigint(20) DEFAULT NULL,
  `xmrChannel` varchar(254) DEFAULT NULL,
  `xmrPubKey` text,
  `lastCommandSuccess` tinyint(4) NOT NULL DEFAULT '2',
  `deviceName` varchar(254) DEFAULT NULL,
  `timeZone` varchar(254) DEFAULT NULL,
  `shop` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`displayid`),
  KEY `defaultplaylistid` (`defaultlayoutid`)
) ENGINE=InnoDB AUTO_INCREMENT=402 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `display`
--

LOCK TABLES `display` WRITE;
/*!40000 ALTER TABLE `display` DISABLE KEYS */;
INSERT INTO `display` VALUES (397,0,'MINIX-SPU',2,'ac27be79a644414b63a298e4730bd237',0,1,1547782429,0,0,0,'10.23.10.25',0,'28:C2:DD:76:8F:65',NULL,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'windows','2.0.0',112,0,0,NULL,NULL,'d52929523494f55432637150d001dd44','-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDDB7aomgfjBM9U3mpEs8kkewJN\nyljrhbow/DYEgpLb3+/i0fAuXLaVyjoaIoPtVjJk76F6Pdg9i74/J3dFCYczhqaf\nkPMwaAPqR1gjtJPQlc4xq8LORLTeIh49zHcZxWR/CHxiKNwjzENnF3zUqmx2zU03\nbZ2SWybQiaOtDq816QIDAQAB\n-----END PUBLIC KEY-----',0,NULL,NULL,NULL),(398,0,'SPU_WIN7_TESTIN',2,'d2f85dcdc1cdcf351807c88f15a7cea0',0,1,1547782278,0,0,0,'10.23.10.28',0,'08:60:6E:69:B9:9A',NULL,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'windows','2.0.0',112,0,0,NULL,NULL,'95cb61a92c8ada47f890b17c8b0cfe4a','-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCayyubph6BY1aaYeP2mGAvB/qf\nO2yy6YtAvQMKIGxbDepOLNx+qaOW90FHrQvuZWI/GikSm5FoQVlONI5gRFpoifFb\nabdkTJatjvFx98p3Lp97R3BeNGmtAB0ZBBhw6KQCld9huc2jqbXGOU+ednXo2fbm\n9W+cL7SkpDqRitCrxwIDAQAB\n-----END PUBLIC KEY-----',0,NULL,NULL,NULL),(399,0,'SMS_PRJ2',2,'ef93849389f384b6efd845fa35508aff',0,1,1547782401,0,0,0,'10.23.10.31',0,'F4:6D:04:77:85:8E',NULL,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'windows','2.0.0',112,0,0,NULL,NULL,'06cf6f995f3b01f507f55e2fc9d9bfae','-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCJXFWp8V4bYQOxptarJqFHA4rO\nO8usKgOxRKRDJQPCezsxekG98prgiRu7xjQIbRujvHXprad07Drnl8ka7lPcux52\n8JohjJFa0OQgwZXyzypa4//t2GSaAMQDMQ9k8nrqCBXAP4B00hHyxAVM6xu85UXp\nP/9K8zhDlHFFjNsbzQIDAQAB\n-----END PUBLIC KEY-----',0,NULL,NULL,NULL),(400,0,'SMS_PRJ3',2,'d3bae46016cc5438d8891f94dd47b096',0,1,1547782402,0,0,0,'10.23.10.32',0,'E0:CB:4E:A0:41:1A',NULL,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'windows','2.0.0',112,0,0,NULL,NULL,'da22ac5a5f30f89c3d5d0999d82a02a4','-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDyjCrNznHQtRXsHVIXpf2eijQ8\nSLH7bXTI3xMjn9hCbP0SGvA6MSpv8GdFzE/5DuZAxtosmfyuc7vhlb8vnq6IKose\newDafwOwv+sDOiVKGps8EGWoU0VSQLary5jezJHJ7TGvBjKhn1bVv/TLp+toWbiV\neXlXbUO4BZhUhmmKOwIDAQAB\n-----END PUBLIC KEY-----',0,NULL,NULL,NULL),(401,0,'SMS_PRJ1',2,'2d9f001a3d578f2bf7053b4e2fba3fc2',0,1,1547782402,0,0,0,'10.23.10.30',0,'1C:6F:65:D6:E6:1A',NULL,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'windows','2.0.0',112,0,0,NULL,NULL,'408dcad833720b292a190a8a94cebd37','-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCBCUD+/Ybx7o0VVN7iO52NaZln\nVnpg7gjO/mH8GySJ/NjPQ1JdkUtuunvzm0B/RfWSOMpuSy6mBhDXH14DhxfZCv4+\nban4hDshNjv9x9KnO9MrRspJgF3MXa9oKkY1iVF5/I8njVVhB6prZCRFVTqRPl22\n/wh8Im0vV9lWpoz4BQIDAQAB\n-----END PUBLIC KEY-----',0,NULL,NULL,NULL);
/*!40000 ALTER TABLE `display` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-01-18 10:35:51
