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
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media` (
  `mediaID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `type` varchar(15) NOT NULL,
  `duration` int(11) NOT NULL,
  `originalFilename` varchar(254) DEFAULT NULL,
  `storedAs` varchar(254) DEFAULT NULL COMMENT 'What has this media been stored as',
  `MD5` varchar(32) DEFAULT NULL,
  `FileSize` bigint(20) DEFAULT NULL,
  `userID` int(11) NOT NULL,
  `retired` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Is retired?',
  `isEdited` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Is this the current record',
  `editedMediaID` int(11) DEFAULT NULL COMMENT 'The Parent ID',
  `moduleSystemFile` tinyint(1) NOT NULL DEFAULT '0',
  `valid` tinyint(1) NOT NULL DEFAULT '1',
  `expires` int(11) DEFAULT NULL,
  `released` tinyint(4) NOT NULL DEFAULT '1',
  `apiRef` varchar(254) DEFAULT NULL,
  PRIMARY KEY (`mediaID`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
INSERT INTO `media` VALUES (1,'jquery-1.11.1.min.js','module',0,'jquery-1.11.1.min.js','jquery-1.11.1.min.js','ee092541bc79668e3e0a7b76d2faf00c',95788,0,0,0,0,1,1,0,1,NULL),(2,'jquery-cycle-2.1.6.min.js','module',0,'jquery-cycle-2.1.6.min.js','jquery-cycle-2.1.6.min.js','61ac73e72bb83e7576de0da409a8fa16',28914,0,0,0,0,1,1,0,1,NULL),(3,'moment.js','module',0,'moment.js','moment.js','6abec3b24ad31c456248bc67993a92cb',160335,0,0,0,0,1,1,0,1,NULL),(4,'flipclock.min.js','module',0,'flipclock.min.js','flipclock.min.js','7595304ffd51f44c5715ba150d5f0d8e',21108,0,0,0,0,1,1,0,1,NULL),(5,'xibo-layout-scaler.js','module',0,'xibo-layout-scaler.js','xibo-layout-scaler.js','553ca540a883b26b675024d552a85ba3',4576,0,0,0,0,1,1,0,1,NULL),(6,'xibo-dataset-render.js','module',0,'xibo-dataset-render.js','xibo-dataset-render.js','bb7c30e89c5e577fea1252f2912a0380',1636,0,0,0,0,1,1,0,1,NULL),(7,'xibo-image-render.js','module',0,'xibo-image-render.js','xibo-image-render.js','7a8a3b4cbab3ab81d2932bbb21304f74',3067,0,0,0,0,1,1,0,1,NULL),(13,'pdf.js','module',0,'pdf.js','pdf.js','b5840df3f17ae9eb53034364a098ca88',343763,0,0,0,0,1,1,0,1,NULL),(14,'pdf.worker.js','module',0,'pdf.worker.js','pdf.worker.js','d2a2d063316f787ac5a6277d427fccca',1379493,0,0,0,0,1,1,0,1,NULL),(15,'compatibility.js','module',0,'compatibility.js','compatibility.js','ddb85c8495edcc6c4336a06906d9d9f9',18719,0,0,0,0,1,1,0,1,NULL),(16,'jquery.marquee.min.js','module',0,'jquery.marquee.min.js','jquery.marquee.min.js','03d7d36a95393f245ed2151b97eaa760',2253,0,0,0,0,1,1,0,1,NULL),(17,'xibo-text-render.js','module',0,'xibo-text-render.js','xibo-text-render.js','2b6f106b73ec60925714f4b4315f7187',11299,0,0,0,0,1,1,0,1,NULL),(18,'xibo-webpage-render.js','module',0,'xibo-webpage-render.js','xibo-webpage-render.js','a68da610faf96b98c18c4af6d7ad2c1f',4936,0,0,0,0,1,1,0,1,NULL),(19,'fonts.css','module',0,'fonts.css','fonts.css','d79f6084d7b7d41d380da17479aaf50c',153,0,0,0,0,1,1,0,1,NULL);
/*!40000 ALTER TABLE `media` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-01-18 10:35:55
