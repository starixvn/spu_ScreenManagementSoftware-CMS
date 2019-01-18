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
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task` (
  `taskId` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(254) NOT NULL,
  `class` varchar(254) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '2',
  `pid` int(11) DEFAULT NULL,
  `options` text,
  `schedule` varchar(254) DEFAULT NULL,
  `lastRunDt` int(11) DEFAULT NULL,
  `lastRunStartDt` int(11) DEFAULT NULL,
  `lastRunMessage` varchar(254) DEFAULT NULL,
  `lastRunStatus` tinyint(4) NOT NULL DEFAULT '0',
  `lastRunDuration` smallint(6) DEFAULT NULL,
  `lastRunExitCode` smallint(6) DEFAULT NULL,
  `isActive` tinyint(4) NOT NULL DEFAULT '1',
  `runNow` tinyint(4) NOT NULL DEFAULT '1',
  `configFile` varchar(254) NOT NULL,
  PRIMARY KEY (`taskId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task`
--

LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
INSERT INTO `task` VALUES (1,'Daily Maintenance','\\Xibo\\XTR\\MaintenanceDailyTask',2,0,'[]','0 0 * * * *',1539216002,1539216001,'# Daily Maintenance\n\n## Import Layouts\n - Not Required.\n\n## Tidy Logs\n - Done.\n\n## Tidy Stats\n - Done.\n\n## Tidy Cache\n - Done.\n\n## Purge Expired API Tokens\n - Done.\n\n',4,1,0,1,0,'/tasks/maintenance-daily.task'),(2,'Regular Maintenance','\\Xibo\\XTR\\MaintenanceRegularTask',1,0,'[]','*/5 * * * * *',1539225601,1539225901,'# Wake On LAN\n - Done\n\n## Build Layouts\n - Done\n\n## Tidy Library\n - Done\n\n',4,0,0,1,1,'/tasks/maintenance-regular.task'),(3,'Email Notifications','\\Xibo\\XTR\\EmailNotificationsTask',1,0,'[]','*/5 * * * * *',1539590460,1539225601,'# Email Notifications\n\n## Email Notifications\n - Done\n',4,0,0,1,0,'/tasks/email-notifications.task'),(4,'Stats Archive','\\Xibo\\XTR\\StatsArchiveTask',2,0,'{\"periodSizeInDays\":\"7\",\"maxPeriods\":\"4\",\"archiveOwner\":\"\"}','0 0 * * Mon',1539165724,1539165724,'# Stats Archive\n\nDone\n\n',4,0,0,1,0,'/tasks/stats-archiver.task'),(5,'Remove old Notifications','\\Xibo\\XTR\\NotificationTidyTask',2,0,'{\"maxAgeDays\":\"7\",\"systemOnly\":\"1\",\"readOnly\":\"0\"}','15 0 * * *',1539216901,1539216901,'# Notification Tidy\n\nDone\n\n',4,0,0,1,0,'/tasks/notification-tidy.task');
/*!40000 ALTER TABLE `task` ENABLE KEYS */;
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
