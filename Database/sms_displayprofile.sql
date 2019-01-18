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
-- Table structure for table `displayprofile`
--

DROP TABLE IF EXISTS `displayprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `displayprofile` (
  `displayprofileid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `type` varchar(15) NOT NULL,
  `config` text NOT NULL,
  `isdefault` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  PRIMARY KEY (`displayprofileid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `displayprofile`
--

LOCK TABLES `displayprofile` WRITE;
/*!40000 ALTER TABLE `displayprofile` DISABLE KEYS */;
INSERT INTO `displayprofile` VALUES (2,'Windows','windows','[{\"name\":\"CollectInterval\",\"value\":300,\"type\":\"int\"},{\"name\":\"DownloadStartWindow\",\"value\":\"00:00\",\"type\":\"string\"},{\"name\":\"DownloadEndWindow\",\"value\":\"00:00\",\"type\":\"string\"},{\"name\":\"PowerpointEnabled\",\"value\":0,\"type\":\"checkbox\"},{\"name\":\"StatsEnabled\",\"value\":0,\"type\":\"checkbox\"},{\"name\":\"XmrNetworkAddress\",\"value\":\"\",\"type\":\"string\"},{\"name\":\"SizeX\",\"value\":0,\"type\":\"double\"},{\"name\":\"SizeY\",\"value\":0,\"type\":\"double\"},{\"name\":\"OffsetX\",\"value\":0,\"type\":\"double\"},{\"name\":\"OffsetY\",\"value\":0,\"type\":\"double\"},{\"name\":\"ClientInfomationCtrlKey\",\"value\":0,\"type\":\"checkbox\"},{\"name\":\"ClientInformationKeyCode\",\"value\":\"I\",\"type\":\"string\"},{\"name\":\"LogLevel\",\"value\":\"error\",\"type\":\"string\"},{\"name\":\"LogToDiskLocation\",\"value\":\"\",\"type\":\"string\"},{\"name\":\"ShowInTaskbar\",\"value\":1,\"type\":\"checkbox\"},{\"name\":\"CursorStartPosition\",\"value\":\"Bottom Right\",\"type\":\"string\"},{\"name\":\"DoubleBuffering\",\"value\":1,\"type\":\"checkbox\"},{\"name\":\"EmptyLayoutDuration\",\"value\":10,\"type\":\"int\"},{\"name\":\"EnableMouse\",\"value\":1,\"type\":\"checkbox\"},{\"name\":\"EnableShellCommands\",\"value\":0,\"type\":\"checkbox\"},{\"name\":\"ExpireModifiedLayouts\",\"value\":1,\"type\":\"checkbox\"},{\"name\":\"MaxConcurrentDownloads\",\"value\":10,\"type\":\"int\"},{\"name\":\"ShellCommandAllowList\",\"value\":\"\",\"type\":\"string\"},{\"name\":\"UseCefWebBrowser\",\"value\":0,\"type\":\"checkbox\"},{\"name\":\"SendCurrentLayoutAsStatusUpdate\",\"value\":1,\"type\":\"checkbox\"},{\"name\":\"ScreenShotRequestInterval\",\"value\":0,\"type\":\"int\"},{\"name\":\"ScreenShotSize\",\"value\":800,\"type\":\"int\"},{\"name\":\"MaxLogFileUploads\",\"value\":3,\"type\":\"int\"},{\"name\":\"EmbeddedServerPort\",\"value\":9696,\"type\":\"int\"},{\"name\":\"PreventSleep\",\"value\":1,\"type\":\"checkbox\"}]',1,1),(3,'Android','android','[]',1,1);
/*!40000 ALTER TABLE `displayprofile` ENABLE KEYS */;
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
