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
-- Table structure for table `module`
--

DROP TABLE IF EXISTS `module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `module` (
  `ModuleID` int(11) NOT NULL AUTO_INCREMENT,
  `Module` varchar(50) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `Enabled` tinyint(4) NOT NULL DEFAULT '0',
  `RegionSpecific` tinyint(4) NOT NULL DEFAULT '1',
  `Description` varchar(254) DEFAULT NULL,
  `ImageUri` varchar(254) NOT NULL,
  `SchemaVersion` int(11) NOT NULL DEFAULT '1',
  `ValidExtensions` varchar(254) DEFAULT NULL,
  `PreviewEnabled` tinyint(4) NOT NULL DEFAULT '1',
  `assignable` tinyint(4) NOT NULL DEFAULT '1',
  `render_as` varchar(10) DEFAULT NULL,
  `settings` text,
  `viewPath` varchar(254) NOT NULL DEFAULT '../modules',
  `class` varchar(254) NOT NULL,
  `defaultDuration` int(11) NOT NULL,
  `installName` varchar(254) DEFAULT NULL,
  PRIMARY KEY (`ModuleID`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='Functional Modules';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `module`
--

LOCK TABLES `module` WRITE;
/*!40000 ALTER TABLE `module` DISABLE KEYS */;
INSERT INTO `module` VALUES (1,'Image','Image',0,0,'Images. PNG, JPG, BMP, GIF','forms/image.gif',1,'jpg,jpeg,png,bmp,gif',1,1,NULL,NULL,'../modules','Xibo\\Widget\\Image',10,NULL),(2,'Video','Video',1,0,'Videos - support varies depending on the client hardware you are using.','forms/video.gif',1,'wmv,avi,mpg,mpeg,webm,mp4',0,1,NULL,NULL,'../modules','Xibo\\Widget\\Video',0,NULL),(3,'Flash','Flash',0,0,'Flash','forms/flash.gif',1,'swf',1,1,NULL,NULL,'../modules','Xibo\\Widget\\Flash',10,NULL),(4,'PowerPoint','PowerPoint',0,0,'Powerpoint. PPT, PPS','forms/powerpoint.gif',1,'ppt,pps,pptx',1,1,NULL,NULL,'../modules','Xibo\\Widget\\PowerPoint',10,NULL),(5,'Webpage','Webpage',1,1,'Webpages.','forms/webpage.gif',1,NULL,1,1,NULL,NULL,'../modules','Xibo\\Widget\\WebPage',86399,NULL),(6,'Ticker','Ticker',0,1,'RSS Ticker.','forms/ticker.gif',1,NULL,1,1,NULL,'[]','../modules','Xibo\\Widget\\Ticker',5,NULL),(7,'Text','Text',0,1,'Text. With Directional Controls.','forms/text.gif',1,NULL,1,1,NULL,NULL,'../modules','Xibo\\Widget\\Text',5,NULL),(8,'Embedded','Embedded',0,1,'Embedded HTML','forms/webpage.gif',1,NULL,1,1,NULL,NULL,'../modules','Xibo\\Widget\\Embedded',60,NULL),(11,'datasetview','Data Set',0,1,'A view on a DataSet','forms/datasetview.gif',1,NULL,1,1,NULL,NULL,'../modules','Xibo\\Widget\\DataSetView',60,NULL),(12,'shellcommand','Shell Command',0,1,'Execute a shell command on the client','forms/shellcommand.gif',1,NULL,1,1,NULL,NULL,'../modules','Xibo\\Widget\\ShellCommand',3,NULL),(13,'localvideo','Local Video',0,1,'Play a video locally stored on the client','forms/video.gif',1,NULL,0,1,NULL,NULL,'../modules','Xibo\\Widget\\LocalVideo',60,NULL),(14,'genericfile','Generic File',0,0,'A generic file to be stored in the library','forms/library.gif',1,'apk,js,html,htm',0,0,NULL,NULL,'../modules','Xibo\\Widget\\GenericFile',10,NULL),(15,'clock','Clock',0,1,'','forms/library.gif',1,NULL,1,1,'html','[]','../modules','Xibo\\Widget\\Clock',5,NULL),(16,'font','Font',0,0,'A font to use in other Modules','forms/library.gif',1,'ttf,otf,eot,svg,woff',0,0,NULL,NULL,'../modules','Xibo\\Widget\\Font',10,NULL),(17,'audio','Audio',0,0,'Audio - support varies depending on the client hardware','forms/video.gif',1,'mp3,wav',0,1,NULL,NULL,'../modules','Xibo\\Widget\\Audio',0,NULL),(18,'pdf','PDF',0,0,'PDF document viewer','forms/pdf.gif',1,'pdf',1,1,'html',NULL,'../modules','Xibo\\Widget\\Pdf',60,NULL);
/*!40000 ALTER TABLE `module` ENABLE KEYS */;
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
