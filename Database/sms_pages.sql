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
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pages` (
  `pageID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `title` varchar(50) NOT NULL,
  `asHome` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`pageID`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 COMMENT='Available Pages';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages`
--

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
INSERT INTO `pages` VALUES (1,'dashboard','Dashboard',1),(2,'schedule','Schedule',1),(3,'mediamanager','Media Dashboard',0),(4,'layout','Layout',1),(5,'library','Library',1),(6,'display','Screens',1),(7,'update','Update',0),(8,'admin','Administration',0),(9,'group','User Groups',1),(10,'log','Log',1),(11,'user','Users',1),(12,'license','Licence',1),(13,'index','Home',0),(14,'module','Modules',0),(15,'template','Templates',0),(16,'fault','Report Fault',1),(17,'stats','Statistics',1),(18,'manual','Manual',0),(19,'resolution','Resolutions',1),(20,'help','Help Links',0),(21,'clock','Clock',0),(22,'displaygroup','Screen Groups',1),(23,'application','Applications',0),(24,'dataset','DataSets',0),(25,'campaign','Campaigns',1),(26,'transition','Transitions',0),(27,'sessions','Sessions',1),(28,'preview','Preview',0),(29,'statusdashboard','Status Dashboard',1),(30,'displayprofile','Screen Profiles',1),(31,'audit','Audit Trail',0),(32,'region','Regions',0),(33,'playlist','Playlist',0),(34,'maintenance','Maintenance',0),(35,'command','Commands',1),(36,'notification','Notifications',0),(37,'drawer','Notification Drawer',0),(38,'daypart','Dayparting',0),(39,'task','Tasks',0),(40,'clientversion','Client Versions',0);
/*!40000 ALTER TABLE `pages` ENABLE KEYS */;
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
