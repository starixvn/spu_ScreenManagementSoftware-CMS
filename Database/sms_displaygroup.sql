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
-- Table structure for table `displaygroup`
--

DROP TABLE IF EXISTS `displaygroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `displaygroup` (
  `DisplayGroupID` int(11) NOT NULL AUTO_INCREMENT,
  `DisplayGroup` varchar(50) NOT NULL,
  `Description` varchar(254) DEFAULT NULL,
  `IsDisplaySpecific` tinyint(4) NOT NULL DEFAULT '0',
  `isDynamic` tinyint(4) NOT NULL DEFAULT '0',
  `dynamicCriteria` varchar(2000) DEFAULT NULL,
  `userId` int(11) NOT NULL,
  PRIMARY KEY (`DisplayGroupID`)
) ENGINE=InnoDB AUTO_INCREMENT=410 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `displaygroup`
--

LOCK TABLES `displaygroup` WRITE;
/*!40000 ALTER TABLE `displaygroup` DISABLE KEYS */;
INSERT INTO `displaygroup` VALUES (1,'All Screens','The group of all screens. Can not be modified!',0,0,'',0),(405,'MINIX-SPU',NULL,1,0,NULL,0),(406,'SPU_WIN7_TESTIN',NULL,1,0,NULL,0),(407,'SMS_PRJ2',NULL,1,0,NULL,0),(408,'SMS_PRJ3',NULL,1,0,NULL,0),(409,'SMS_PRJ1',NULL,1,0,NULL,0);
/*!40000 ALTER TABLE `displaygroup` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-01-18 10:35:52
