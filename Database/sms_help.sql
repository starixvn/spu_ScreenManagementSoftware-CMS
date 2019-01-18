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
-- Table structure for table `help`
--

DROP TABLE IF EXISTS `help`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `help` (
  `HelpID` int(11) NOT NULL AUTO_INCREMENT,
  `Topic` varchar(254) NOT NULL,
  `Category` varchar(254) NOT NULL DEFAULT 'General',
  `Link` varchar(254) NOT NULL,
  PRIMARY KEY (`HelpID`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `help`
--

LOCK TABLES `help` WRITE;
/*!40000 ALTER TABLE `help` DISABLE KEYS */;
INSERT INTO `help` VALUES (1,'Layout','General','layouts.html'),(2,'Content','General','media.html'),(4,'Schedule','General','scheduling.html'),(5,'Group','General','users_groups.html'),(6,'Admin','General','cms_settings.html'),(7,'Report','General','troubleshooting.html'),(8,'Dashboard','General','tour.html'),(9,'User','General','users.html'),(10,'Display','General','displays.html'),(11,'DisplayGroup','General','displays_groups.html'),(12,'Layout','Add','layouts.html#Add_Layout'),(13,'Layout','Background','layouts_designer.html#Background'),(14,'Content','Assign','layouts_playlists.html#Assigning_Content'),(15,'Layout','RegionOptions','layouts_regions.html'),(16,'Content','AddtoLibrary','media_library.html'),(17,'Display','Edit','displays.html#Display_Edit'),(18,'Display','Delete','displays.html#Display_Delete'),(19,'Displays','Groups','displays_groups.html#Group_Members'),(20,'UserGroup','Add','users_groups.html#Adding_Group'),(21,'User','Add','users_administration.html#Add_User'),(22,'User','Delete','users_administration.html#Delete_User'),(23,'Content','Config','cms_settings.html#Content'),(24,'LayoutMedia','Permissions','users_permissions.html'),(25,'Region','Permissions','users_permissions.html'),(26,'Library','Assign','layouts_playlists.html#Add_From_Library'),(27,'Media','Delete','media_library.html#Delete'),(28,'DisplayGroup','Add','displays_groups.html#Add_Group'),(29,'DisplayGroup','Edit','displays_groups.html#Edit_Group'),(30,'DisplayGroup','Delete','displays_groups.html#Delete_Group'),(31,'DisplayGroup','Members','displays_groups.html#Group_Members'),(32,'DisplayGroup','Permissions','users_permissions.html'),(34,'Schedule','ScheduleNow','scheduling_now.html'),(35,'Layout','Delete','layouts.html#Delete_Layout'),(36,'Layout','Copy','layouts.html#Copy_Layout'),(37,'Schedule','Edit','scheduling_events.html#Edit'),(38,'Schedule','Add','scheduling_events.html#Add'),(39,'Layout','Permissions','users_permissions.html'),(40,'Display','MediaInventory','displays.html#Media_Inventory'),(41,'User','ChangePassword','users.html#Change_Password'),(42,'Schedule','Delete','scheduling_events.html'),(43,'Layout','Edit','layouts_designer.html#Edit_Layout'),(44,'Media','Permissions','users_permissions.html'),(45,'Display','DefaultLayout','displays.html#DefaultLayout'),(46,'UserGroup','Edit','users_groups.html#Edit_Group'),(47,'UserGroup','Members','users_groups.html#Group_Member'),(48,'User','PageSecurity','users_permissions.html#Page_Security'),(49,'User','MenuSecurity','users_permissions.html#Menu_Security'),(50,'UserGroup','Delete','users_groups.html#Delete_Group'),(51,'User','Edit','users_administration.html#Edit_User'),(52,'User','Applications','users_administration.html#Users_MyApplications'),(53,'User','SetHomepage','users_administration.html#Media_Dashboard'),(54,'DataSet','General','media_datasets.html'),(55,'DataSet','Add','media_datasets.html#Create_Dataset'),(56,'DataSet','Edit','media_datasets.html#Edit_Dataset'),(57,'DataSet','Delete','media_datasets.html#Delete_Dataset'),(58,'DataSet','AddColumn','media_datasets.html#Dataset_Column'),(59,'DataSet','EditColumn','media_datasets.html#Dataset_Column'),(60,'DataSet','DeleteColumn','media_datasets.html#Dataset_Column'),(61,'DataSet','Data','media_datasets.html#Dataset_Row'),(62,'DataSet','Permissions','users_permissions.html'),(63,'Fault','General','troubleshooting.html#Report_Fault'),(65,'Stats','General','displays_metrics.html'),(66,'Resolution','General','layouts_resolutions.html'),(67,'Template','General','layouts_templates.html'),(68,'Services','Register','#Registered_Applications'),(69,'OAuth','General','api_oauth.html'),(70,'Services','Log','api_oauth.html#oAuthLog'),(71,'Module','Edit','media_modules.html'),(72,'Module','General','media_modules.html'),(73,'Campaign','General','layouts_campaigns.html'),(74,'License','General','licence_information.html'),(75,'DataSet','ViewColumns','media_datasets.html#Dataset_Column'),(76,'Campaign','Permissions','users_permissions.html'),(77,'Transition','Edit','layouts_transitions.html'),(78,'User','SetPassword','users_administration.html#Set_Password'),(79,'DataSet','ImportCSV','media_datasets.htmlmedia_datasets.html#Import_CSV'),(80,'DisplayGroup','FileAssociations','displays_fileassociations.html'),(81,'Statusdashboard','General','tour_status_dashboard.html'),(82,'Displayprofile','General','displays_settings.html'),(83,'DisplayProfile','Edit','displays_settings.html#edit'),(84,'DisplayProfile','Delete','displays_settings.html#delete');
/*!40000 ALTER TABLE `help` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-01-18 10:35:42
