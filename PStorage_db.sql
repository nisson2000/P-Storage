/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.11-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: PStorage_db
-- ------------------------------------------------------
-- Server version	10.11.11-MariaDB-0ubuntu0.24.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `oc_accounts`
--

DROP TABLE IF EXISTS `oc_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_accounts` (
  `uid` varchar(64) NOT NULL DEFAULT '',
  `data` longtext NOT NULL DEFAULT '',
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_accounts`
--

LOCK TABLES `oc_accounts` WRITE;
/*!40000 ALTER TABLE `oc_accounts` DISABLE KEYS */;
INSERT INTO `oc_accounts` VALUES
('admin','{\"displayname\":{\"value\":\"admin\",\"scope\":\"v2-federated\",\"verified\":\"0\"},\"address\":{\"value\":\"\",\"scope\":\"v2-local\",\"verified\":\"0\"},\"website\":{\"value\":\"\",\"scope\":\"v2-local\",\"verified\":\"0\"},\"email\":{\"value\":null,\"scope\":\"v2-federated\",\"verified\":\"0\"},\"avatar\":{\"scope\":\"v2-federated\"},\"phone\":{\"value\":\"\",\"scope\":\"v2-local\",\"verified\":\"0\"},\"twitter\":{\"value\":\"\",\"scope\":\"v2-local\",\"verified\":\"0\"},\"fediverse\":{\"value\":\"\",\"scope\":\"v2-local\",\"verified\":\"0\"},\"organisation\":{\"value\":\"\",\"scope\":\"v2-local\"},\"role\":{\"value\":\"\",\"scope\":\"v2-local\"},\"headline\":{\"value\":\"\",\"scope\":\"v2-local\"},\"biography\":{\"value\":\"\",\"scope\":\"v2-local\"},\"profile_enabled\":{\"value\":\"1\"}}');
/*!40000 ALTER TABLE `oc_accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_accounts_data`
--

DROP TABLE IF EXISTS `oc_accounts_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_accounts_data` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uid` varchar(64) NOT NULL,
  `name` varchar(64) NOT NULL,
  `value` varchar(255) DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `accounts_data_uid` (`uid`),
  KEY `accounts_data_name` (`name`),
  KEY `accounts_data_value` (`value`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_accounts_data`
--

LOCK TABLES `oc_accounts_data` WRITE;
/*!40000 ALTER TABLE `oc_accounts_data` DISABLE KEYS */;
INSERT INTO `oc_accounts_data` VALUES
(1,'admin','displayname','admin'),
(2,'admin','address',''),
(3,'admin','website',''),
(4,'admin','email',''),
(5,'admin','phone',''),
(6,'admin','twitter',''),
(7,'admin','fediverse',''),
(8,'admin','organisation',''),
(9,'admin','role',''),
(10,'admin','headline',''),
(11,'admin','biography',''),
(12,'admin','profile_enabled','1');
/*!40000 ALTER TABLE `oc_accounts_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_activity`
--

DROP TABLE IF EXISTS `oc_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_activity` (
  `activity_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `timestamp` int(11) NOT NULL DEFAULT 0,
  `priority` int(11) NOT NULL DEFAULT 0,
  `type` varchar(255) DEFAULT NULL,
  `user` varchar(64) DEFAULT NULL,
  `affecteduser` varchar(64) NOT NULL,
  `app` varchar(32) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `subjectparams` longtext NOT NULL,
  `message` varchar(255) DEFAULT NULL,
  `messageparams` longtext DEFAULT NULL,
  `file` varchar(4000) DEFAULT NULL,
  `link` varchar(4000) DEFAULT NULL,
  `object_type` varchar(255) DEFAULT NULL,
  `object_id` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`activity_id`),
  KEY `activity_user_time` (`affecteduser`,`timestamp`),
  KEY `activity_filter_by` (`affecteduser`,`user`,`timestamp`),
  KEY `activity_filter` (`affecteduser`,`type`,`app`,`timestamp`),
  KEY `activity_object` (`object_type`,`object_id`)
) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_activity`
--

LOCK TABLES `oc_activity` WRITE;
/*!40000 ALTER TABLE `oc_activity` DISABLE KEYS */;
INSERT INTO `oc_activity` VALUES
(1,1752496153,30,'file_created','admin','admin','files','created_self','[{\"3\":\"\\/Photos\"}]','','[]','/Photos','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/','files',3),
(2,1752496153,30,'file_created','admin','admin','files','created_self','[{\"4\":\"\\/Photos\\/Birdie.jpg\"}]','','[]','/Photos/Birdie.jpg','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Photos','files',4),
(3,1752496153,30,'file_changed','admin','admin','files','changed_self','[{\"4\":\"\\/Photos\\/Birdie.jpg\"}]','','[]','/Photos/Birdie.jpg','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Photos','files',4),
(4,1752496153,30,'file_created','admin','admin','files','created_self','[{\"5\":\"\\/Photos\\/Frog.jpg\"}]','','[]','/Photos/Frog.jpg','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Photos','files',5),
(5,1752496153,30,'file_changed','admin','admin','files','changed_self','[{\"5\":\"\\/Photos\\/Frog.jpg\"}]','','[]','/Photos/Frog.jpg','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Photos','files',5),
(6,1752496153,30,'file_created','admin','admin','files','created_self','[{\"6\":\"\\/Photos\\/Library.jpg\"}]','','[]','/Photos/Library.jpg','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Photos','files',6),
(7,1752496153,30,'file_changed','admin','admin','files','changed_self','[{\"6\":\"\\/Photos\\/Library.jpg\"}]','','[]','/Photos/Library.jpg','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Photos','files',6),
(8,1752496153,30,'file_created','admin','admin','files','created_self','[{\"7\":\"\\/Photos\\/Nextcloud community.jpg\"}]','','[]','/Photos/Nextcloud community.jpg','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Photos','files',7),
(9,1752496153,30,'file_changed','admin','admin','files','changed_self','[{\"7\":\"\\/Photos\\/Nextcloud community.jpg\"}]','','[]','/Photos/Nextcloud community.jpg','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Photos','files',7),
(10,1752496153,30,'file_created','admin','admin','files','created_self','[{\"8\":\"\\/Photos\\/Toucan.jpg\"}]','','[]','/Photos/Toucan.jpg','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Photos','files',8),
(11,1752496153,30,'file_changed','admin','admin','files','changed_self','[{\"8\":\"\\/Photos\\/Toucan.jpg\"}]','','[]','/Photos/Toucan.jpg','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Photos','files',8),
(12,1752496153,30,'file_created','admin','admin','files','created_self','[{\"9\":\"\\/Photos\\/Gorilla.jpg\"}]','','[]','/Photos/Gorilla.jpg','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Photos','files',9),
(13,1752496153,30,'file_changed','admin','admin','files','changed_self','[{\"9\":\"\\/Photos\\/Gorilla.jpg\"}]','','[]','/Photos/Gorilla.jpg','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Photos','files',9),
(14,1752496153,30,'file_created','admin','admin','files','created_self','[{\"10\":\"\\/Photos\\/Vineyard.jpg\"}]','','[]','/Photos/Vineyard.jpg','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Photos','files',10),
(15,1752496153,30,'file_changed','admin','admin','files','changed_self','[{\"10\":\"\\/Photos\\/Vineyard.jpg\"}]','','[]','/Photos/Vineyard.jpg','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Photos','files',10),
(16,1752496153,30,'file_created','admin','admin','files','created_self','[{\"11\":\"\\/Photos\\/Steps.jpg\"}]','','[]','/Photos/Steps.jpg','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Photos','files',11),
(17,1752496153,30,'file_changed','admin','admin','files','changed_self','[{\"11\":\"\\/Photos\\/Steps.jpg\"}]','','[]','/Photos/Steps.jpg','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Photos','files',11),
(18,1752496153,30,'file_created','admin','admin','files','created_self','[{\"12\":\"\\/Photos\\/Readme.md\"}]','','[]','/Photos/Readme.md','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Photos','files',12),
(19,1752496153,30,'file_changed','admin','admin','files','changed_self','[{\"12\":\"\\/Photos\\/Readme.md\"}]','','[]','/Photos/Readme.md','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Photos','files',12),
(20,1752496153,30,'file_created','admin','admin','files','created_self','[{\"13\":\"\\/Nextcloud.png\"}]','','[]','/Nextcloud.png','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/','files',13),
(21,1752496153,30,'file_changed','admin','admin','files','changed_self','[{\"13\":\"\\/Nextcloud.png\"}]','','[]','/Nextcloud.png','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/','files',13),
(22,1752496153,30,'file_created','admin','admin','files','created_self','[{\"14\":\"\\/Documents\"}]','','[]','/Documents','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/','files',14),
(23,1752496153,30,'file_created','admin','admin','files','created_self','[{\"15\":\"\\/Documents\\/Nextcloud flyer.pdf\"}]','','[]','/Documents/Nextcloud flyer.pdf','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Documents','files',15),
(24,1752496154,30,'file_changed','admin','admin','files','changed_self','[{\"15\":\"\\/Documents\\/Nextcloud flyer.pdf\"}]','','[]','/Documents/Nextcloud flyer.pdf','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Documents','files',15),
(25,1752496154,30,'file_created','admin','admin','files','created_self','[{\"16\":\"\\/Documents\\/Welcome to Nextcloud Hub.docx\"}]','','[]','/Documents/Welcome to Nextcloud Hub.docx','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Documents','files',16),
(26,1752496154,30,'file_changed','admin','admin','files','changed_self','[{\"16\":\"\\/Documents\\/Welcome to Nextcloud Hub.docx\"}]','','[]','/Documents/Welcome to Nextcloud Hub.docx','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Documents','files',16),
(27,1752496154,30,'file_created','admin','admin','files','created_self','[{\"17\":\"\\/Documents\\/Example.md\"}]','','[]','/Documents/Example.md','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Documents','files',17),
(28,1752496154,30,'file_changed','admin','admin','files','changed_self','[{\"17\":\"\\/Documents\\/Example.md\"}]','','[]','/Documents/Example.md','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Documents','files',17),
(29,1752496154,30,'file_created','admin','admin','files','created_self','[{\"18\":\"\\/Documents\\/Readme.md\"}]','','[]','/Documents/Readme.md','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Documents','files',18),
(30,1752496154,30,'file_changed','admin','admin','files','changed_self','[{\"18\":\"\\/Documents\\/Readme.md\"}]','','[]','/Documents/Readme.md','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Documents','files',18),
(31,1752496154,30,'file_created','admin','admin','files','created_self','[{\"19\":\"\\/Reasons to use Nextcloud.pdf\"}]','','[]','/Reasons to use Nextcloud.pdf','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/','files',19),
(32,1752496154,30,'file_changed','admin','admin','files','changed_self','[{\"19\":\"\\/Reasons to use Nextcloud.pdf\"}]','','[]','/Reasons to use Nextcloud.pdf','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/','files',19),
(33,1752496154,30,'file_created','admin','admin','files','created_self','[{\"20\":\"\\/Nextcloud intro.mp4\"}]','','[]','/Nextcloud intro.mp4','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/','files',20),
(34,1752496154,30,'file_changed','admin','admin','files','changed_self','[{\"20\":\"\\/Nextcloud intro.mp4\"}]','','[]','/Nextcloud intro.mp4','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/','files',20),
(35,1752496154,30,'file_created','admin','admin','files','created_self','[{\"21\":\"\\/Templates\"}]','','[]','/Templates','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/','files',21),
(36,1752496154,30,'file_created','admin','admin','files','created_self','[{\"22\":\"\\/Templates\\/Mother\'s day.odt\"}]','','[]','/Templates/Mother\'s day.odt','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',22),
(37,1752496154,30,'file_changed','admin','admin','files','changed_self','[{\"22\":\"\\/Templates\\/Mother\'s day.odt\"}]','','[]','/Templates/Mother\'s day.odt','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',22),
(38,1752496154,30,'file_created','admin','admin','files','created_self','[{\"23\":\"\\/Templates\\/Meeting notes.md\"}]','','[]','/Templates/Meeting notes.md','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',23),
(39,1752496154,30,'file_changed','admin','admin','files','changed_self','[{\"23\":\"\\/Templates\\/Meeting notes.md\"}]','','[]','/Templates/Meeting notes.md','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',23),
(40,1752496154,30,'file_created','admin','admin','files','created_self','[{\"24\":\"\\/Templates\\/Impact effort matrix.whiteboard\"}]','','[]','/Templates/Impact effort matrix.whiteboard','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',24),
(41,1752496154,30,'file_changed','admin','admin','files','changed_self','[{\"24\":\"\\/Templates\\/Impact effort matrix.whiteboard\"}]','','[]','/Templates/Impact effort matrix.whiteboard','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',24),
(42,1752496154,30,'file_created','admin','admin','files','created_self','[{\"25\":\"\\/Templates\\/Simple.odp\"}]','','[]','/Templates/Simple.odp','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',25),
(43,1752496154,30,'file_changed','admin','admin','files','changed_self','[{\"25\":\"\\/Templates\\/Simple.odp\"}]','','[]','/Templates/Simple.odp','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',25),
(44,1752496154,30,'file_created','admin','admin','files','created_self','[{\"26\":\"\\/Templates\\/Gotong royong.odp\"}]','','[]','/Templates/Gotong royong.odp','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',26),
(45,1752496154,30,'file_changed','admin','admin','files','changed_self','[{\"26\":\"\\/Templates\\/Gotong royong.odp\"}]','','[]','/Templates/Gotong royong.odp','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',26),
(46,1752496154,30,'file_created','admin','admin','files','created_self','[{\"27\":\"\\/Templates\\/Resume.odt\"}]','','[]','/Templates/Resume.odt','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',27),
(47,1752496154,30,'file_changed','admin','admin','files','changed_self','[{\"27\":\"\\/Templates\\/Resume.odt\"}]','','[]','/Templates/Resume.odt','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',27),
(48,1752496154,30,'file_created','admin','admin','files','created_self','[{\"28\":\"\\/Templates\\/Mindmap.odg\"}]','','[]','/Templates/Mindmap.odg','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',28),
(49,1752496154,30,'file_changed','admin','admin','files','changed_self','[{\"28\":\"\\/Templates\\/Mindmap.odg\"}]','','[]','/Templates/Mindmap.odg','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',28),
(50,1752496154,30,'file_created','admin','admin','files','created_self','[{\"29\":\"\\/Templates\\/Photo book.odt\"}]','','[]','/Templates/Photo book.odt','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',29),
(51,1752496155,30,'file_changed','admin','admin','files','changed_self','[{\"29\":\"\\/Templates\\/Photo book.odt\"}]','','[]','/Templates/Photo book.odt','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',29),
(52,1752496155,30,'file_created','admin','admin','files','created_self','[{\"30\":\"\\/Templates\\/SWOT analysis.whiteboard\"}]','','[]','/Templates/SWOT analysis.whiteboard','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',30),
(53,1752496155,30,'file_changed','admin','admin','files','changed_self','[{\"30\":\"\\/Templates\\/SWOT analysis.whiteboard\"}]','','[]','/Templates/SWOT analysis.whiteboard','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',30),
(54,1752496155,30,'file_created','admin','admin','files','created_self','[{\"31\":\"\\/Templates\\/Party invitation.odt\"}]','','[]','/Templates/Party invitation.odt','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',31),
(55,1752496155,30,'file_changed','admin','admin','files','changed_self','[{\"31\":\"\\/Templates\\/Party invitation.odt\"}]','','[]','/Templates/Party invitation.odt','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',31),
(56,1752496155,30,'file_created','admin','admin','files','created_self','[{\"32\":\"\\/Templates\\/Invoice.odt\"}]','','[]','/Templates/Invoice.odt','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',32),
(57,1752496155,30,'file_changed','admin','admin','files','changed_self','[{\"32\":\"\\/Templates\\/Invoice.odt\"}]','','[]','/Templates/Invoice.odt','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',32),
(58,1752496155,30,'file_created','admin','admin','files','created_self','[{\"33\":\"\\/Templates\\/Flowchart.odg\"}]','','[]','/Templates/Flowchart.odg','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',33),
(59,1752496155,30,'file_changed','admin','admin','files','changed_self','[{\"33\":\"\\/Templates\\/Flowchart.odg\"}]','','[]','/Templates/Flowchart.odg','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',33),
(60,1752496155,30,'file_created','admin','admin','files','created_self','[{\"34\":\"\\/Templates\\/Product plan.md\"}]','','[]','/Templates/Product plan.md','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',34),
(61,1752496155,30,'file_changed','admin','admin','files','changed_self','[{\"34\":\"\\/Templates\\/Product plan.md\"}]','','[]','/Templates/Product plan.md','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',34),
(62,1752496155,30,'file_created','admin','admin','files','created_self','[{\"35\":\"\\/Templates\\/Yellow idea.odp\"}]','','[]','/Templates/Yellow idea.odp','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',35),
(63,1752496155,30,'file_changed','admin','admin','files','changed_self','[{\"35\":\"\\/Templates\\/Yellow idea.odp\"}]','','[]','/Templates/Yellow idea.odp','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',35),
(64,1752496155,30,'file_created','admin','admin','files','created_self','[{\"36\":\"\\/Templates\\/Modern company.odp\"}]','','[]','/Templates/Modern company.odp','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',36),
(65,1752496155,30,'file_changed','admin','admin','files','changed_self','[{\"36\":\"\\/Templates\\/Modern company.odp\"}]','','[]','/Templates/Modern company.odp','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',36),
(66,1752496155,30,'file_created','admin','admin','files','created_self','[{\"37\":\"\\/Templates\\/Expense report.ods\"}]','','[]','/Templates/Expense report.ods','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',37),
(67,1752496155,30,'file_changed','admin','admin','files','changed_self','[{\"37\":\"\\/Templates\\/Expense report.ods\"}]','','[]','/Templates/Expense report.ods','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',37),
(68,1752496155,30,'file_created','admin','admin','files','created_self','[{\"38\":\"\\/Templates\\/Org chart.odg\"}]','','[]','/Templates/Org chart.odg','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',38),
(69,1752496155,30,'file_changed','admin','admin','files','changed_self','[{\"38\":\"\\/Templates\\/Org chart.odg\"}]','','[]','/Templates/Org chart.odg','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',38),
(70,1752496156,30,'file_created','admin','admin','files','created_self','[{\"39\":\"\\/Templates\\/Business model canvas.odg\"}]','','[]','/Templates/Business model canvas.odg','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',39),
(71,1752496156,30,'file_changed','admin','admin','files','changed_self','[{\"39\":\"\\/Templates\\/Business model canvas.odg\"}]','','[]','/Templates/Business model canvas.odg','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',39),
(72,1752496156,30,'file_created','admin','admin','files','created_self','[{\"40\":\"\\/Templates\\/Elegant.odp\"}]','','[]','/Templates/Elegant.odp','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',40),
(73,1752496156,30,'file_changed','admin','admin','files','changed_self','[{\"40\":\"\\/Templates\\/Elegant.odp\"}]','','[]','/Templates/Elegant.odp','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',40),
(74,1752496156,30,'file_created','admin','admin','files','created_self','[{\"41\":\"\\/Templates\\/Timesheet.ods\"}]','','[]','/Templates/Timesheet.ods','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',41),
(75,1752496156,30,'file_changed','admin','admin','files','changed_self','[{\"41\":\"\\/Templates\\/Timesheet.ods\"}]','','[]','/Templates/Timesheet.ods','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',41),
(76,1752496156,30,'file_created','admin','admin','files','created_self','[{\"42\":\"\\/Templates\\/Syllabus.odt\"}]','','[]','/Templates/Syllabus.odt','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',42),
(77,1752496156,30,'file_changed','admin','admin','files','changed_self','[{\"42\":\"\\/Templates\\/Syllabus.odt\"}]','','[]','/Templates/Syllabus.odt','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',42),
(78,1752496156,30,'file_created','admin','admin','files','created_self','[{\"43\":\"\\/Templates\\/Readme.md\"}]','','[]','/Templates/Readme.md','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',43),
(79,1752496156,30,'file_changed','admin','admin','files','changed_self','[{\"43\":\"\\/Templates\\/Readme.md\"}]','','[]','/Templates/Readme.md','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',43),
(80,1752496156,30,'file_created','admin','admin','files','created_self','[{\"44\":\"\\/Templates\\/Business model canvas.ods\"}]','','[]','/Templates/Business model canvas.ods','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',44),
(81,1752496156,30,'file_changed','admin','admin','files','changed_self','[{\"44\":\"\\/Templates\\/Business model canvas.ods\"}]','','[]','/Templates/Business model canvas.ods','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',44),
(82,1752496156,30,'file_created','admin','admin','files','created_self','[{\"45\":\"\\/Templates\\/Diagram & table.ods\"}]','','[]','/Templates/Diagram & table.ods','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',45),
(83,1752496156,30,'file_changed','admin','admin','files','changed_self','[{\"45\":\"\\/Templates\\/Diagram & table.ods\"}]','','[]','/Templates/Diagram & table.ods','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',45),
(84,1752496156,30,'file_created','admin','admin','files','created_self','[{\"46\":\"\\/Templates\\/Letter.odt\"}]','','[]','/Templates/Letter.odt','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',46),
(85,1752496156,30,'file_changed','admin','admin','files','changed_self','[{\"46\":\"\\/Templates\\/Letter.odt\"}]','','[]','/Templates/Letter.odt','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/Templates','files',46),
(86,1752496156,30,'file_created','admin','admin','files','created_self','[{\"47\":\"\\/Readme.md\"}]','','[]','/Readme.md','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/','files',47),
(87,1752496156,30,'file_changed','admin','admin','files','changed_self','[{\"47\":\"\\/Readme.md\"}]','','[]','/Readme.md','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/','files',47),
(88,1752496156,30,'file_created','admin','admin','files','created_self','[{\"48\":\"\\/Templates credits.md\"}]','','[]','/Templates credits.md','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/','files',48),
(89,1752496156,30,'file_changed','admin','admin','files','changed_self','[{\"48\":\"\\/Templates credits.md\"}]','','[]','/Templates credits.md','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/','files',48),
(90,1752496156,30,'file_created','admin','admin','files','created_self','[{\"49\":\"\\/Nextcloud Manual.pdf\"}]','','[]','/Nextcloud Manual.pdf','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/','files',49),
(91,1752496156,30,'file_changed','admin','admin','files','changed_self','[{\"49\":\"\\/Nextcloud Manual.pdf\"}]','','[]','/Nextcloud Manual.pdf','http://pstorage.ntuee.temp/index.php/apps/files/?dir=/','files',49);
/*!40000 ALTER TABLE `oc_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_activity_mq`
--

DROP TABLE IF EXISTS `oc_activity_mq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_activity_mq` (
  `mail_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `amq_timestamp` int(11) NOT NULL DEFAULT 0,
  `amq_latest_send` int(11) NOT NULL DEFAULT 0,
  `amq_type` varchar(255) NOT NULL,
  `amq_affecteduser` varchar(64) NOT NULL,
  `amq_appid` varchar(32) NOT NULL,
  `amq_subject` varchar(255) NOT NULL,
  `amq_subjectparams` longtext DEFAULT NULL,
  `object_type` varchar(255) DEFAULT NULL,
  `object_id` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`mail_id`),
  KEY `amp_user` (`amq_affecteduser`),
  KEY `amp_latest_send_time` (`amq_latest_send`),
  KEY `amp_timestamp_time` (`amq_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_activity_mq`
--

LOCK TABLES `oc_activity_mq` WRITE;
/*!40000 ALTER TABLE `oc_activity_mq` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_activity_mq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_addressbookchanges`
--

DROP TABLE IF EXISTS `oc_addressbookchanges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_addressbookchanges` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uri` varchar(255) DEFAULT NULL,
  `synctoken` int(10) unsigned NOT NULL DEFAULT 1,
  `addressbookid` bigint(20) NOT NULL,
  `operation` smallint(6) NOT NULL,
  `created_at` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `addressbookid_synctoken` (`addressbookid`,`synctoken`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_addressbookchanges`
--

LOCK TABLES `oc_addressbookchanges` WRITE;
/*!40000 ALTER TABLE `oc_addressbookchanges` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_addressbookchanges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_addressbooks`
--

DROP TABLE IF EXISTS `oc_addressbooks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_addressbooks` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `principaluri` varchar(255) DEFAULT NULL,
  `displayname` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `synctoken` int(10) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `addressbook_index` (`principaluri`,`uri`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_addressbooks`
--

LOCK TABLES `oc_addressbooks` WRITE;
/*!40000 ALTER TABLE `oc_addressbooks` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_addressbooks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_appconfig`
--

DROP TABLE IF EXISTS `oc_appconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_appconfig` (
  `appid` varchar(32) NOT NULL DEFAULT '',
  `configkey` varchar(64) NOT NULL DEFAULT '',
  `configvalue` longtext DEFAULT NULL,
  `type` int(11) NOT NULL DEFAULT 2,
  `lazy` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`appid`,`configkey`),
  KEY `appconfig_config_key_index` (`configkey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_appconfig`
--

LOCK TABLES `oc_appconfig` WRITE;
/*!40000 ALTER TABLE `oc_appconfig` DISABLE KEYS */;
INSERT INTO `oc_appconfig` VALUES
('activity','enabled','yes',2,0),
('activity','installed_version','2.20.0',2,0),
('activity','types','filesystem',2,0),
('backgroundjob','lastjob','12',2,0),
('circles','enabled','yes',2,0),
('circles','installed_version','28.0.0',2,0),
('circles','loopback_tmp_scheme','http',2,0),
('circles','maintenance_run','0',2,0),
('circles','maintenance_update','{\"3\":1752496197,\"2\":1752496197,\"1\":1752496197}',2,0),
('circles','types','filesystem,dav',2,0),
('cloud_federation_api','enabled','yes',2,0),
('cloud_federation_api','installed_version','1.11.0',2,0),
('cloud_federation_api','types','filesystem',2,0),
('comments','enabled','yes',2,0),
('comments','installed_version','1.18.0',2,0),
('comments','types','logging',2,0),
('contactsinteraction','enabled','yes',2,0),
('contactsinteraction','installed_version','1.9.0',2,0),
('contactsinteraction','types','dav',2,0),
('core','files_metadata','{\"photos-original_date_time\":{\"value\":null,\"type\":\"int\",\"indexed\":true,\"editPermission\":0},\"photos-exif\":{\"value\":null,\"type\":\"array\",\"indexed\":false,\"editPermission\":0},\"photos-ifd0\":{\"value\":null,\"type\":\"array\",\"indexed\":false,\"editPermission\":0},\"photos-size\":{\"value\":null,\"type\":\"array\",\"indexed\":false,\"editPermission\":0}}',2,0),
('core','files_metadata_installed','1',2,0),
('core','installedat','1752496146.7248',2,0),
('core','lastcron','1752634643',2,0),
('core','lastupdateResult','{\"version\":\"29.0.16.1\",\"versionstring\":\"Nextcloud 29.0.16\",\"url\":\"https:\\/\\/download.nextcloud.com\\/server\\/releases\\/nextcloud-29.0.16.zip\",\"web\":\"https:\\/\\/docs.nextcloud.com\\/server\\/29\\/admin_manual\\/maintenance\\/upgrade.html\",\"changes\":\"https:\\/\\/updates.nextcloud.com\\/changelog_server\\/?version=29.0.16\",\"autoupdater\":\"1\",\"eol\":\"1\"}',2,0),
('core','lastupdatedat','1752633892',2,0),
('core','oc.integritycheck.checker','[]',2,0),
('core','public_files','files_sharing/public.php',2,0),
('core','public_webdav','dav/appinfo/v1/publicwebdav.php',2,0),
('core','vendor','nextcloud',2,0),
('dashboard','enabled','yes',2,0),
('dashboard','installed_version','7.8.0',2,0),
('dashboard','types','',2,0),
('dav','enabled','yes',2,0),
('dav','installed_version','1.29.2',2,0),
('dav','types','filesystem',2,0),
('federatedfilesharing','enabled','yes',2,0),
('federatedfilesharing','installed_version','1.18.0',2,0),
('federatedfilesharing','types','',2,0),
('federation','enabled','yes',2,0),
('federation','installed_version','1.18.0',2,0),
('federation','types','authentication',2,0),
('files','enabled','yes',2,0),
('files','installed_version','2.0.0',2,0),
('files','types','filesystem',2,0),
('files_pdfviewer','enabled','yes',2,0),
('files_pdfviewer','installed_version','2.9.0',2,0),
('files_pdfviewer','types','',2,0),
('files_reminders','enabled','yes',2,0),
('files_reminders','installed_version','1.1.0',2,0),
('files_reminders','types','dav',2,0),
('files_sharing','enabled','yes',2,0),
('files_sharing','installed_version','1.20.0',2,0),
('files_sharing','types','filesystem',2,0),
('files_trashbin','enabled','yes',2,0),
('files_trashbin','installed_version','1.18.0',2,0),
('files_trashbin','types','filesystem,dav',2,0),
('files_versions','enabled','yes',2,0),
('files_versions','installed_version','1.21.0',2,0),
('files_versions','types','filesystem,dav',2,0),
('firstrunwizard','enabled','yes',2,0),
('firstrunwizard','installed_version','2.17.0',2,0),
('firstrunwizard','types','logging',2,0),
('logreader','enabled','yes',2,0),
('logreader','installed_version','2.13.0',2,0),
('logreader','types','logging',2,0),
('lookup_server_connector','enabled','yes',2,0),
('lookup_server_connector','installed_version','1.16.0',2,0),
('lookup_server_connector','types','authentication',2,0),
('nextcloud_announcements','enabled','yes',2,0),
('nextcloud_announcements','installed_version','1.17.0',2,0),
('nextcloud_announcements','types','logging',2,0),
('notifications','enabled','yes',2,0),
('notifications','installed_version','2.16.0',2,0),
('notifications','types','logging',2,0),
('oauth2','enabled','yes',2,0),
('oauth2','installed_version','1.16.4',2,0),
('oauth2','types','authentication',2,0),
('password_policy','enabled','yes',2,0),
('password_policy','installed_version','1.18.0',2,0),
('password_policy','types','authentication',2,0),
('photos','enabled','yes',2,0),
('photos','installed_version','2.4.0',2,0),
('photos','types','dav,authentication',2,0),
('privacy','enabled','yes',2,0),
('privacy','installed_version','1.12.0',2,0),
('privacy','types','',2,0),
('provisioning_api','enabled','yes',2,0),
('provisioning_api','installed_version','1.18.0',2,0),
('provisioning_api','types','prevent_group_restriction',2,0),
('recommendations','enabled','yes',2,0),
('recommendations','installed_version','2.0.0',2,0),
('recommendations','types','',2,0),
('related_resources','enabled','yes',2,0),
('related_resources','installed_version','1.3.0',2,0),
('related_resources','types','',2,0),
('serverinfo','enabled','yes',2,0),
('serverinfo','installed_version','1.18.0',2,0),
('serverinfo','types','',2,0),
('settings','enabled','yes',2,0),
('settings','installed_version','1.10.1',2,0),
('settings','types','',2,0),
('sharebymail','enabled','yes',2,0),
('sharebymail','installed_version','1.18.0',2,0),
('sharebymail','types','filesystem',2,0),
('support','enabled','yes',2,0),
('support','installed_version','1.11.1',2,0),
('support','types','session',2,0),
('survey_client','enabled','yes',2,0),
('survey_client','installed_version','1.16.0',2,0),
('survey_client','types','',2,0),
('systemtags','enabled','yes',2,0),
('systemtags','installed_version','1.18.0',2,0),
('systemtags','types','logging',2,0),
('text','enabled','yes',2,0),
('text','installed_version','3.9.2',2,0),
('text','types','dav',2,0),
('theming','backgroundMime','image/png',2,0),
('theming','cachebuster','5',2,0),
('theming','enabled','yes',2,0),
('theming','installed_version','2.3.0',2,0),
('theming','logoDimensions','1039x1039',2,0),
('theming','logoMime','image/png',2,0),
('theming','name','PStorage',2,0),
('theming','slogan','',2,0),
('theming','types','logging',2,0),
('theming','url','https://PStorage',2,0),
('twofactor_backupcodes','enabled','yes',2,0),
('twofactor_backupcodes','installed_version','1.17.0',2,0),
('twofactor_backupcodes','types','',2,0),
('updatenotification','enabled','yes',2,0),
('updatenotification','installed_version','1.18.0',2,0),
('updatenotification','types','',2,0),
('user_status','enabled','yes',2,0),
('user_status','installed_version','1.8.1',2,0),
('user_status','types','',2,0),
('viewer','enabled','yes',2,0),
('viewer','installed_version','2.2.0',2,0),
('viewer','types','',2,0),
('weather_status','enabled','yes',2,0),
('weather_status','installed_version','1.8.0',2,0),
('weather_status','types','',2,0),
('workflowengine','enabled','yes',2,0),
('workflowengine','installed_version','2.10.0',2,0),
('workflowengine','types','filesystem',2,0);
/*!40000 ALTER TABLE `oc_appconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_authorized_groups`
--

DROP TABLE IF EXISTS `oc_authorized_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_authorized_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` varchar(200) NOT NULL,
  `class` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `admindel_groupid_idx` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_authorized_groups`
--

LOCK TABLES `oc_authorized_groups` WRITE;
/*!40000 ALTER TABLE `oc_authorized_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_authorized_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_authtoken`
--

DROP TABLE IF EXISTS `oc_authtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_authtoken` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uid` varchar(64) NOT NULL DEFAULT '',
  `login_name` varchar(255) NOT NULL DEFAULT '',
  `password` longtext DEFAULT NULL,
  `name` longtext NOT NULL DEFAULT '',
  `token` varchar(200) NOT NULL DEFAULT '',
  `type` smallint(5) unsigned DEFAULT 0,
  `remember` smallint(5) unsigned DEFAULT 0,
  `last_activity` int(10) unsigned DEFAULT 0,
  `last_check` int(10) unsigned DEFAULT 0,
  `scope` longtext DEFAULT NULL,
  `expires` int(10) unsigned DEFAULT NULL,
  `private_key` longtext DEFAULT NULL,
  `public_key` longtext DEFAULT NULL,
  `version` smallint(5) unsigned NOT NULL DEFAULT 1,
  `password_invalid` tinyint(1) DEFAULT 0,
  `password_hash` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `authtoken_token_index` (`token`),
  KEY `authtoken_last_activity_idx` (`last_activity`),
  KEY `authtoken_uid_index` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_authtoken`
--

LOCK TABLES `oc_authtoken` WRITE;
/*!40000 ALTER TABLE `oc_authtoken` DISABLE KEYS */;
INSERT INTO `oc_authtoken` VALUES
(1,'admin','admin','bbzerXzl65oqvL498gKSZT4Pl5SKZQWAN2J/YW4FHTIMK8txxsWqwm63zpxMpjiMRYp+a0hQunQjwmk+srRpJT/wo88zg/8IwWjR+cGxxu7+ey+XRmT/5MTy3LgJwje+1TO8YLcsSuK97pyZ64lUeQnp8tZ0Bm2DUAewA0yIY1jCi1ZxEqiIfiJp/R22f5bEIpRP0PRWT5jtIfNCMpY1Kcn206sVByLIdG5yQ2X1xLXE0U4qFCuXxmcMMR4IaPpdh+vUAspksKHJ9ijUTr/clKPujbTJcL37ARCvEScoTi34y7lFoEKlNPxcDnT6/lO6S4uq2cMTNiYf5wJsgQMuLA==','Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:137.0) Gecko/20100101 Firefox/137.0','816b7fce245288bae4e2d1bb97bb237e8ca88f46c011f079b204bb088d4312f57278d603312f072640b229d53ca2a4b309a265e87d3a017e4b02b72bc788ecb1',0,0,1752640818,1752640631,NULL,NULL,'be479c6effd5f555ba1f7d5f6e8bbd7d0db770a285794e0b4ce8aabe465575f662607d1612660bbb96f2bd3ac4c04ea68f7d865b871a997e9f0b0c58c649a3ccbb7a754152e05af5b8201de6b2a15192392eee677dfcf9617d3d2c5fe6ec722c83554d279c9003a74bec751a86911500e2e5dd423f76b7af7c5fb2de1f2c716707ad8c3511f2dc95dc75d4f4cbe79e182abf257ba968cc6736446bfdf6c9055b598677d974d340853e5b8a030b59b4ae89d1ac156543889d43a918ecf25437484abfcf446f9472fe8a3cdaa67405a62436610dd5849c5a6e04d5ccf26705f7bd5c028df0db247542891965893482fa893cbf37286e0f496f4c70c69737c7e85d10e184632027cd925a684b787112cbfdb6899818ac570465b40a6907dc2a57dffa57f33d45c815c9af8935d69c261c046dcf7c156c05ae345c4a1de767cd66771ec79579d6345aa064bac5c5cf2f6522bd6af86111b8ef04c83664b17400d2e283fc1d471f75a920bcb9477d6a03b38b8bf9b842ca137d387d43f7314c07e295964398391d1646f003d31fb38e96733dd82ea605554bc2f2bcff15adba96029d3e2eb006481cd462aa3630ea9fa6f7a2c92c306c031e21682bf0b646b299c8d3d049cfd81991bd633605ee4a705700ee99acec0c28fe76fdc3cd78fbe4d292e1b6c2ae460bebe57b93e3c6e76cb49bde16a1deab63002624a3ee0d1262ee26bf926d4b3ca299ee8c37dbfd10845b9eeaea0c408bb30388e7db2e79af12a581a082d644c563209aba7369bfc06d1c3a14444060af6973638c766f49c85bd190284d80ac5c57d4e8ddf5a16f7a7d7a1f636dedd6d8e9470b2ae1b1a5ed8cf2d084375c2f10a6e9c8e69791baee1e54c629d051879df8f512034e7cc3440b3b35fc859e13fec69ff04b651216cac898aa4362d6b14a1f0efca50dbc48f5bea3d7076eaa66eef408a3d8e52c0cae2113979a2bf60300cf50cf24a8efaebb286f5a959fdd2f55855e9db00d292b697c1ac76e65ae15307eb594ae23c4aac2dc49087625a879ca38dedaf66077e3cd7d19c25699052e90d8bf29158fb23f33cd683f219675f2cfb16f1add4cc8cb052b9814d7ff49e561ec8ab07b216642266158961ff9c92891f4dd4356cb412899639265defde6cdba5a13bc55eb4d2eaa1873fd79118edbaa41ef777ec7ea04da8727690cad34c2efde28393e3696486b356755513b7aec80e9bcac0de1a474eb667af0a1a54461d3e11ba7772c5996a1f90145aa2e5dc3e4c1ed88636d549d23134b57566a14cc34e236902c791992012b170d22378f91bafe33a78f0abab4a247ae1f92d82e339bd6c2ce96be37a42d81475c27b5d612d0ce02bf016cc5255e022f1ac1644537f21ee23bfccff3e1d5d7de25abe39c78823a736bd7fd28c5ca8c8b9e1ef255ebdc897baff28969bb9e0f10284316e1d3d789f582b75768f38e6bf5e4bd7a7e6061c7a0088e7a2f9a94799048ee8a495d73c0f006aaa5b3c0301c8b8bfb16fed2f0726c032c79858565920511baa8225f6ea3f66ae385b7a8fdcd01eccd898ceb6543beca525bd5732365f62a0cb793be9a1bb2b3bda489d7400c154af4fa2a7ece89610767d08f9d2b5baaa245acbf215db2cea8f5ddc34dea30485afe65a8ebf5fc7d059c1e9110c0fc1e63911b405d7183cbd094022f867cf4a44c300950ac04e940c1f1cb54f5a53c2d761b689ecc0c50da5345b673f0affbcf5e1685b366c327034d15d009de3353e785df6f4d0a6b37970865b31f80939ac0e65e5305761bf193810cfae5d54b0380216c6d75510db30d8c130bdfdeaf9a44ad0453a4de9279496903486e8a3fb17c08de903e6f8c241a8e7208163b041bfa5c97c202148fb5ea5a2e845b2fbc01c9cf0c66a49f7747d7c65b9bc21217d1feb0ec8768cc2d8c0f1a3537aea3147e9cd9197766629427e928e5d7351642034e2979212897d668dabb0bd0a9d6a4ea37213a43c7ff61269af245edf1ac4cc59be46783a43533b3039f3a6270f567427e72b5d4a3d0a849ffae09f3d474ca5d492e7fe642f066a50762daf8d67041cecc078a540ce8f21251ec7b6b6c9de872b91ee5c1cd0b08ee7a5c0658d2621132df41e7bfc44b3f885bac91a7d57b905dc1cc99cdfa03aa6640811bcf66f6e9d92991407c3e3321e65d8e94bb87c2454be8a25946e5e4e8a0d1363dd89ec97a7edd7ea52c4e48f75bbf6e6708929854e0c48b9eb788e45ea96780bc16b95132f96e7af127a5bb4c83cab6e59fd79a4572ecf8edc6fa867f3ce725f900ec4fc73a5d33dcbed243c5d794694cb66ff2e7edc47a131d5ef6df9e6e295fe1b03cc351b8f5f36cdce2c76f0e2d479873aafc81e4eac62252b7349b6c97604669002460b6305c8014c34a8e760deb30a95ac5909e6723|c85269ff8450393c3c07cb213a02c5fd|82fdc6ec14d983dac577a04c37433fae6cc1076a0867c6779d72c3822fa8bf34454a927a71725b45f9757828e15cda9c832c463a9762ca2c0a3579f5ca5be283|3','-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtpT1ojwwNpKh+DEm6vVz\n9Qgd1xQtQqtlu0FpklFKZsJtpGoQ8X5H36Inh5W1KYUCST5ujddRt1a684lhkZZX\nbaF5OwGLkCHY0M4Q6EpKHO71Bz0GGUkbfKzPA6bZ5y/iGOFnAtNypFHaSxqmN2DK\nVkujyNHbAYAYNw5mM0olZsS3JdjNX8lYxas7YseMURmXqEXEnDjBIe4vxA0XX5ua\nN3TFkv4PWPLFXcsnXlY21AW349IXaTYktVwO1ml3CTvUo69tMSiQFKrLS9Ds20tk\nCMP5V6wvwhrePPSw8xl6XeqXBTnA9PKNZACdGU1u860/UsoitcoXcZaHaraEMPlc\nbwIDAQAB\n-----END PUBLIC KEY-----\n',2,0,'3|$argon2id$v=19$m=65536,t=4,p=1$ZGkzNnFrZU1NUkF2OEs4Zw$rZjwhf2LL8T+sC0iQOTKpmi/SemKjb53Xt03Ujv7w8Y');
/*!40000 ALTER TABLE `oc_authtoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_bruteforce_attempts`
--

DROP TABLE IF EXISTS `oc_bruteforce_attempts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_bruteforce_attempts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `action` varchar(64) NOT NULL DEFAULT '',
  `occurred` int(10) unsigned NOT NULL DEFAULT 0,
  `ip` varchar(255) NOT NULL DEFAULT '',
  `subnet` varchar(255) NOT NULL DEFAULT '',
  `metadata` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `bruteforce_attempts_ip` (`ip`),
  KEY `bruteforce_attempts_subnet` (`subnet`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_bruteforce_attempts`
--

LOCK TABLES `oc_bruteforce_attempts` WRITE;
/*!40000 ALTER TABLE `oc_bruteforce_attempts` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_bruteforce_attempts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_calendar_invitations`
--

DROP TABLE IF EXISTS `oc_calendar_invitations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_calendar_invitations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uid` varchar(255) NOT NULL,
  `recurrenceid` varchar(255) DEFAULT NULL,
  `attendee` varchar(255) NOT NULL,
  `organizer` varchar(255) NOT NULL,
  `sequence` bigint(20) unsigned DEFAULT NULL,
  `token` varchar(60) NOT NULL,
  `expiration` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `calendar_invitation_tokens` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_calendar_invitations`
--

LOCK TABLES `oc_calendar_invitations` WRITE;
/*!40000 ALTER TABLE `oc_calendar_invitations` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_calendar_invitations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_calendar_reminders`
--

DROP TABLE IF EXISTS `oc_calendar_reminders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_calendar_reminders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `calendar_id` bigint(20) NOT NULL,
  `object_id` bigint(20) NOT NULL,
  `is_recurring` smallint(6) DEFAULT NULL,
  `uid` varchar(255) NOT NULL,
  `recurrence_id` bigint(20) unsigned DEFAULT NULL,
  `is_recurrence_exception` smallint(6) NOT NULL,
  `event_hash` varchar(255) NOT NULL,
  `alarm_hash` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `is_relative` smallint(6) NOT NULL,
  `notification_date` bigint(20) unsigned NOT NULL,
  `is_repeat_based` smallint(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `calendar_reminder_objid` (`object_id`),
  KEY `calendar_reminder_uidrec` (`uid`,`recurrence_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_calendar_reminders`
--

LOCK TABLES `oc_calendar_reminders` WRITE;
/*!40000 ALTER TABLE `oc_calendar_reminders` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_calendar_reminders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_calendar_resources`
--

DROP TABLE IF EXISTS `oc_calendar_resources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_calendar_resources` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `backend_id` varchar(64) DEFAULT NULL,
  `resource_id` varchar(64) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `displayname` varchar(255) DEFAULT NULL,
  `group_restrictions` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `calendar_resources_bkdrsc` (`backend_id`,`resource_id`),
  KEY `calendar_resources_email` (`email`),
  KEY `calendar_resources_name` (`displayname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_calendar_resources`
--

LOCK TABLES `oc_calendar_resources` WRITE;
/*!40000 ALTER TABLE `oc_calendar_resources` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_calendar_resources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_calendar_resources_md`
--

DROP TABLE IF EXISTS `oc_calendar_resources_md`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_calendar_resources_md` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `resource_id` bigint(20) unsigned NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `calendar_resources_md_idk` (`resource_id`,`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_calendar_resources_md`
--

LOCK TABLES `oc_calendar_resources_md` WRITE;
/*!40000 ALTER TABLE `oc_calendar_resources_md` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_calendar_resources_md` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_calendar_rooms`
--

DROP TABLE IF EXISTS `oc_calendar_rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_calendar_rooms` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `backend_id` varchar(64) DEFAULT NULL,
  `resource_id` varchar(64) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `displayname` varchar(255) DEFAULT NULL,
  `group_restrictions` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `calendar_rooms_bkdrsc` (`backend_id`,`resource_id`),
  KEY `calendar_rooms_email` (`email`),
  KEY `calendar_rooms_name` (`displayname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_calendar_rooms`
--

LOCK TABLES `oc_calendar_rooms` WRITE;
/*!40000 ALTER TABLE `oc_calendar_rooms` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_calendar_rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_calendar_rooms_md`
--

DROP TABLE IF EXISTS `oc_calendar_rooms_md`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_calendar_rooms_md` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `room_id` bigint(20) unsigned NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `calendar_rooms_md_idk` (`room_id`,`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_calendar_rooms_md`
--

LOCK TABLES `oc_calendar_rooms_md` WRITE;
/*!40000 ALTER TABLE `oc_calendar_rooms_md` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_calendar_rooms_md` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_calendarchanges`
--

DROP TABLE IF EXISTS `oc_calendarchanges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_calendarchanges` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uri` varchar(255) DEFAULT NULL,
  `synctoken` int(10) unsigned NOT NULL DEFAULT 1,
  `calendarid` bigint(20) NOT NULL,
  `operation` smallint(6) NOT NULL,
  `calendartype` int(11) NOT NULL DEFAULT 0,
  `created_at` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `calid_type_synctoken` (`calendarid`,`calendartype`,`synctoken`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_calendarchanges`
--

LOCK TABLES `oc_calendarchanges` WRITE;
/*!40000 ALTER TABLE `oc_calendarchanges` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_calendarchanges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_calendarobjects`
--

DROP TABLE IF EXISTS `oc_calendarobjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_calendarobjects` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `calendardata` longblob DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `calendarid` bigint(20) unsigned NOT NULL,
  `lastmodified` int(10) unsigned DEFAULT NULL,
  `etag` varchar(32) DEFAULT NULL,
  `size` bigint(20) unsigned NOT NULL,
  `componenttype` varchar(8) DEFAULT NULL,
  `firstoccurence` bigint(20) unsigned DEFAULT NULL,
  `lastoccurence` bigint(20) unsigned DEFAULT NULL,
  `uid` varchar(255) DEFAULT NULL,
  `classification` int(11) DEFAULT 0,
  `calendartype` int(11) NOT NULL DEFAULT 0,
  `deleted_at` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `calobjects_index` (`calendarid`,`calendartype`,`uri`),
  KEY `calobj_clssfction_index` (`classification`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_calendarobjects`
--

LOCK TABLES `oc_calendarobjects` WRITE;
/*!40000 ALTER TABLE `oc_calendarobjects` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_calendarobjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_calendarobjects_props`
--

DROP TABLE IF EXISTS `oc_calendarobjects_props`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_calendarobjects_props` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `calendarid` bigint(20) NOT NULL DEFAULT 0,
  `objectid` bigint(20) unsigned NOT NULL DEFAULT 0,
  `name` varchar(64) DEFAULT NULL,
  `parameter` varchar(64) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `calendartype` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `calendarobject_index` (`objectid`,`calendartype`),
  KEY `calendarobject_name_index` (`name`,`calendartype`),
  KEY `calendarobject_value_index` (`value`,`calendartype`),
  KEY `calendarobject_calid_index` (`calendarid`,`calendartype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_calendarobjects_props`
--

LOCK TABLES `oc_calendarobjects_props` WRITE;
/*!40000 ALTER TABLE `oc_calendarobjects_props` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_calendarobjects_props` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_calendars`
--

DROP TABLE IF EXISTS `oc_calendars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_calendars` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `principaluri` varchar(255) DEFAULT NULL,
  `displayname` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `synctoken` int(10) unsigned NOT NULL DEFAULT 1,
  `description` varchar(255) DEFAULT NULL,
  `calendarorder` int(10) unsigned NOT NULL DEFAULT 0,
  `calendarcolor` varchar(255) DEFAULT NULL,
  `timezone` longtext DEFAULT NULL,
  `components` varchar(64) DEFAULT NULL,
  `transparent` smallint(6) NOT NULL DEFAULT 0,
  `deleted_at` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `calendars_index` (`principaluri`,`uri`),
  KEY `cals_princ_del_idx` (`principaluri`,`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_calendars`
--

LOCK TABLES `oc_calendars` WRITE;
/*!40000 ALTER TABLE `oc_calendars` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_calendars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_calendarsubscriptions`
--

DROP TABLE IF EXISTS `oc_calendarsubscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_calendarsubscriptions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uri` varchar(255) DEFAULT NULL,
  `principaluri` varchar(255) DEFAULT NULL,
  `displayname` varchar(100) DEFAULT NULL,
  `refreshrate` varchar(10) DEFAULT NULL,
  `calendarorder` int(10) unsigned NOT NULL DEFAULT 0,
  `calendarcolor` varchar(255) DEFAULT NULL,
  `striptodos` smallint(6) DEFAULT NULL,
  `stripalarms` smallint(6) DEFAULT NULL,
  `stripattachments` smallint(6) DEFAULT NULL,
  `lastmodified` int(10) unsigned DEFAULT NULL,
  `synctoken` int(10) unsigned NOT NULL DEFAULT 1,
  `source` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `calsub_index` (`principaluri`,`uri`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_calendarsubscriptions`
--

LOCK TABLES `oc_calendarsubscriptions` WRITE;
/*!40000 ALTER TABLE `oc_calendarsubscriptions` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_calendarsubscriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_cards`
--

DROP TABLE IF EXISTS `oc_cards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_cards` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `addressbookid` bigint(20) NOT NULL DEFAULT 0,
  `carddata` longblob DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `lastmodified` bigint(20) unsigned DEFAULT NULL,
  `etag` varchar(32) DEFAULT NULL,
  `size` bigint(20) unsigned NOT NULL,
  `uid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cards_abid` (`addressbookid`),
  KEY `cards_abiduri` (`addressbookid`,`uri`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_cards`
--

LOCK TABLES `oc_cards` WRITE;
/*!40000 ALTER TABLE `oc_cards` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_cards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_cards_properties`
--

DROP TABLE IF EXISTS `oc_cards_properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_cards_properties` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `addressbookid` bigint(20) NOT NULL DEFAULT 0,
  `cardid` bigint(20) unsigned NOT NULL DEFAULT 0,
  `name` varchar(64) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `preferred` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `card_contactid_index` (`cardid`),
  KEY `card_name_index` (`name`),
  KEY `card_value_index` (`value`),
  KEY `cards_prop_abid` (`addressbookid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_cards_properties`
--

LOCK TABLES `oc_cards_properties` WRITE;
/*!40000 ALTER TABLE `oc_cards_properties` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_cards_properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_circles_circle`
--

DROP TABLE IF EXISTS `oc_circles_circle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_circles_circle` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `unique_id` varchar(31) NOT NULL,
  `name` varchar(127) NOT NULL,
  `display_name` varchar(255) DEFAULT '',
  `sanitized_name` varchar(127) DEFAULT '',
  `instance` varchar(255) DEFAULT '',
  `config` int(10) unsigned DEFAULT NULL,
  `source` int(10) unsigned DEFAULT NULL,
  `settings` longtext DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  `contact_addressbook` int(10) unsigned DEFAULT NULL,
  `contact_groupname` varchar(127) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_8195F548E3C68343` (`unique_id`),
  KEY `IDX_8195F548D48A2F7C` (`config`),
  KEY `IDX_8195F5484230B1DE` (`instance`),
  KEY `IDX_8195F5485F8A7F73` (`source`),
  KEY `IDX_8195F548C317B362` (`sanitized_name`),
  KEY `dname` (`display_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_circles_circle`
--

LOCK TABLES `oc_circles_circle` WRITE;
/*!40000 ALTER TABLE `oc_circles_circle` DISABLE KEYS */;
INSERT INTO `oc_circles_circle` VALUES
(1,'r7K3286dVqsdIJfN6IajxN12dFlkHWW','user:admin:r7K3286dVqsdIJfN6IajxN12dFlkHWW','admin','','',1,1,'[]','','2025-07-14 12:29:12',0,''),
(2,'V1R41GXyeqV9LC6xuSDwel8j3Z6Kfx8','app:circles:V1R41GXyeqV9LC6xuSDwel8j3Z6Kfx8','Circles','','',8193,10001,'[]','','2025-07-14 12:29:12',0,'');
/*!40000 ALTER TABLE `oc_circles_circle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_circles_event`
--

DROP TABLE IF EXISTS `oc_circles_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_circles_event` (
  `token` varchar(63) NOT NULL,
  `instance` varchar(255) NOT NULL,
  `event` longtext DEFAULT NULL,
  `result` longtext DEFAULT NULL,
  `interface` int(11) NOT NULL DEFAULT 0,
  `severity` int(11) DEFAULT NULL,
  `retry` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `creation` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`token`,`instance`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_circles_event`
--

LOCK TABLES `oc_circles_event` WRITE;
/*!40000 ALTER TABLE `oc_circles_event` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_circles_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_circles_member`
--

DROP TABLE IF EXISTS `oc_circles_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_circles_member` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `single_id` varchar(31) DEFAULT NULL,
  `circle_id` varchar(31) NOT NULL,
  `member_id` varchar(31) DEFAULT NULL,
  `user_id` varchar(127) NOT NULL,
  `user_type` smallint(6) NOT NULL DEFAULT 1,
  `instance` varchar(255) DEFAULT '',
  `invited_by` varchar(31) DEFAULT NULL,
  `level` smallint(6) NOT NULL,
  `status` varchar(15) DEFAULT NULL,
  `note` longtext DEFAULT NULL,
  `cached_name` varchar(255) DEFAULT '',
  `cached_update` datetime DEFAULT NULL,
  `contact_id` varchar(127) DEFAULT NULL,
  `contact_meta` longtext DEFAULT NULL,
  `joined` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `circles_member_cisiuiutil` (`circle_id`,`single_id`,`user_id`,`user_type`,`instance`,`level`),
  KEY `circles_member_cisi` (`circle_id`,`single_id`),
  KEY `IDX_25C66A49E7A1254A` (`contact_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_circles_member`
--

LOCK TABLES `oc_circles_member` WRITE;
/*!40000 ALTER TABLE `oc_circles_member` DISABLE KEYS */;
INSERT INTO `oc_circles_member` VALUES
(1,'V1R41GXyeqV9LC6xuSDwel8j3Z6Kfx8','V1R41GXyeqV9LC6xuSDwel8j3Z6Kfx8','V1R41GXyeqV9LC6xuSDwel8j3Z6Kfx8','circles',10000,'',NULL,9,'Member','[]','Circles','2025-07-14 12:29:12','',NULL,'2025-07-14 12:29:12'),
(2,'r7K3286dVqsdIJfN6IajxN12dFlkHWW','r7K3286dVqsdIJfN6IajxN12dFlkHWW','r7K3286dVqsdIJfN6IajxN12dFlkHWW','admin',1,'','V1R41GXyeqV9LC6xuSDwel8j3Z6Kfx8',9,'Member','[]','admin','2025-07-14 12:29:12','',NULL,'2025-07-14 12:29:12');
/*!40000 ALTER TABLE `oc_circles_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_circles_membership`
--

DROP TABLE IF EXISTS `oc_circles_membership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_circles_membership` (
  `circle_id` varchar(31) NOT NULL,
  `single_id` varchar(31) NOT NULL,
  `level` int(10) unsigned NOT NULL,
  `inheritance_first` varchar(31) NOT NULL,
  `inheritance_last` varchar(31) NOT NULL,
  `inheritance_depth` int(10) unsigned NOT NULL,
  `inheritance_path` longtext NOT NULL,
  PRIMARY KEY (`single_id`,`circle_id`),
  KEY `IDX_8FC816EAE7C1D92B` (`single_id`),
  KEY `circles_membership_ifilci` (`inheritance_first`,`inheritance_last`,`circle_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_circles_membership`
--

LOCK TABLES `oc_circles_membership` WRITE;
/*!40000 ALTER TABLE `oc_circles_membership` DISABLE KEYS */;
INSERT INTO `oc_circles_membership` VALUES
('V1R41GXyeqV9LC6xuSDwel8j3Z6Kfx8','V1R41GXyeqV9LC6xuSDwel8j3Z6Kfx8',9,'V1R41GXyeqV9LC6xuSDwel8j3Z6Kfx8','V1R41GXyeqV9LC6xuSDwel8j3Z6Kfx8',1,'[\"V1R41GXyeqV9LC6xuSDwel8j3Z6Kfx8\"]'),
('r7K3286dVqsdIJfN6IajxN12dFlkHWW','r7K3286dVqsdIJfN6IajxN12dFlkHWW',9,'r7K3286dVqsdIJfN6IajxN12dFlkHWW','r7K3286dVqsdIJfN6IajxN12dFlkHWW',1,'[\"r7K3286dVqsdIJfN6IajxN12dFlkHWW\"]');
/*!40000 ALTER TABLE `oc_circles_membership` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_circles_mount`
--

DROP TABLE IF EXISTS `oc_circles_mount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_circles_mount` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mount_id` varchar(31) NOT NULL,
  `circle_id` varchar(31) NOT NULL,
  `single_id` varchar(31) NOT NULL,
  `token` varchar(63) DEFAULT NULL,
  `parent` int(11) DEFAULT NULL,
  `mountpoint` longtext DEFAULT NULL,
  `mountpoint_hash` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `circles_mount_cimipt` (`circle_id`,`mount_id`,`parent`,`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_circles_mount`
--

LOCK TABLES `oc_circles_mount` WRITE;
/*!40000 ALTER TABLE `oc_circles_mount` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_circles_mount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_circles_mountpoint`
--

DROP TABLE IF EXISTS `oc_circles_mountpoint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_circles_mountpoint` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mount_id` varchar(31) NOT NULL,
  `single_id` varchar(31) NOT NULL,
  `mountpoint` longtext DEFAULT NULL,
  `mountpoint_hash` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `circles_mountpoint_ms` (`mount_id`,`single_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_circles_mountpoint`
--

LOCK TABLES `oc_circles_mountpoint` WRITE;
/*!40000 ALTER TABLE `oc_circles_mountpoint` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_circles_mountpoint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_circles_remote`
--

DROP TABLE IF EXISTS `oc_circles_remote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_circles_remote` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(15) NOT NULL DEFAULT 'Unknown',
  `interface` int(11) NOT NULL DEFAULT 0,
  `uid` varchar(20) DEFAULT NULL,
  `instance` varchar(127) DEFAULT NULL,
  `href` varchar(254) DEFAULT NULL,
  `item` longtext DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_F94EF834230B1DE` (`instance`),
  KEY `IDX_F94EF83539B0606` (`uid`),
  KEY `IDX_F94EF8334F8E741` (`href`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_circles_remote`
--

LOCK TABLES `oc_circles_remote` WRITE;
/*!40000 ALTER TABLE `oc_circles_remote` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_circles_remote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_circles_share_lock`
--

DROP TABLE IF EXISTS `oc_circles_share_lock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_circles_share_lock` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` varchar(31) NOT NULL,
  `circle_id` varchar(31) NOT NULL,
  `instance` varchar(127) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_337F52F8126F525E70EE2FF6` (`item_id`,`circle_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_circles_share_lock`
--

LOCK TABLES `oc_circles_share_lock` WRITE;
/*!40000 ALTER TABLE `oc_circles_share_lock` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_circles_share_lock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_circles_token`
--

DROP TABLE IF EXISTS `oc_circles_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_circles_token` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `share_id` int(11) DEFAULT NULL,
  `circle_id` varchar(31) DEFAULT NULL,
  `single_id` varchar(31) DEFAULT NULL,
  `member_id` varchar(31) DEFAULT NULL,
  `token` varchar(31) DEFAULT NULL,
  `password` varchar(127) DEFAULT NULL,
  `accepted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sicisimit` (`share_id`,`circle_id`,`single_id`,`member_id`,`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_circles_token`
--

LOCK TABLES `oc_circles_token` WRITE;
/*!40000 ALTER TABLE `oc_circles_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_circles_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_collres_accesscache`
--

DROP TABLE IF EXISTS `oc_collres_accesscache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_collres_accesscache` (
  `user_id` varchar(64) NOT NULL,
  `collection_id` bigint(20) NOT NULL DEFAULT 0,
  `resource_type` varchar(64) NOT NULL DEFAULT '',
  `resource_id` varchar(64) NOT NULL DEFAULT '',
  `access` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`user_id`,`collection_id`,`resource_type`,`resource_id`),
  KEY `collres_user_res` (`user_id`,`resource_type`,`resource_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_collres_accesscache`
--

LOCK TABLES `oc_collres_accesscache` WRITE;
/*!40000 ALTER TABLE `oc_collres_accesscache` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_collres_accesscache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_collres_collections`
--

DROP TABLE IF EXISTS `oc_collres_collections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_collres_collections` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_collres_collections`
--

LOCK TABLES `oc_collres_collections` WRITE;
/*!40000 ALTER TABLE `oc_collres_collections` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_collres_collections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_collres_resources`
--

DROP TABLE IF EXISTS `oc_collres_resources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_collres_resources` (
  `collection_id` bigint(20) NOT NULL,
  `resource_type` varchar(64) NOT NULL,
  `resource_id` varchar(64) NOT NULL,
  PRIMARY KEY (`collection_id`,`resource_type`,`resource_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_collres_resources`
--

LOCK TABLES `oc_collres_resources` WRITE;
/*!40000 ALTER TABLE `oc_collres_resources` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_collres_resources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_comments`
--

DROP TABLE IF EXISTS `oc_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_comments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `topmost_parent_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `children_count` int(10) unsigned NOT NULL DEFAULT 0,
  `actor_type` varchar(64) NOT NULL DEFAULT '',
  `actor_id` varchar(64) NOT NULL DEFAULT '',
  `message` longtext DEFAULT NULL,
  `verb` varchar(64) DEFAULT NULL,
  `creation_timestamp` datetime DEFAULT NULL,
  `latest_child_timestamp` datetime DEFAULT NULL,
  `object_type` varchar(64) NOT NULL DEFAULT '',
  `object_id` varchar(64) NOT NULL DEFAULT '',
  `reference_id` varchar(64) DEFAULT NULL,
  `reactions` varchar(4000) DEFAULT NULL,
  `expire_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `comments_parent_id_index` (`parent_id`),
  KEY `comments_topmost_parent_id_idx` (`topmost_parent_id`),
  KEY `comments_object_index` (`object_type`,`object_id`,`creation_timestamp`),
  KEY `comments_actor_index` (`actor_type`,`actor_id`),
  KEY `expire_date` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_comments`
--

LOCK TABLES `oc_comments` WRITE;
/*!40000 ALTER TABLE `oc_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_comments_read_markers`
--

DROP TABLE IF EXISTS `oc_comments_read_markers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_comments_read_markers` (
  `user_id` varchar(64) NOT NULL DEFAULT '',
  `object_type` varchar(64) NOT NULL DEFAULT '',
  `object_id` varchar(64) NOT NULL DEFAULT '',
  `marker_datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`user_id`,`object_type`,`object_id`),
  KEY `comments_marker_object_index` (`object_type`,`object_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_comments_read_markers`
--

LOCK TABLES `oc_comments_read_markers` WRITE;
/*!40000 ALTER TABLE `oc_comments_read_markers` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_comments_read_markers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_dav_absence`
--

DROP TABLE IF EXISTS `oc_dav_absence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_dav_absence` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(64) NOT NULL,
  `first_day` varchar(10) NOT NULL,
  `last_day` varchar(10) NOT NULL,
  `status` varchar(100) NOT NULL,
  `message` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `dav_absence_uid_idx` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_dav_absence`
--

LOCK TABLES `oc_dav_absence` WRITE;
/*!40000 ALTER TABLE `oc_dav_absence` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_dav_absence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_dav_cal_proxy`
--

DROP TABLE IF EXISTS `oc_dav_cal_proxy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_dav_cal_proxy` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `owner_id` varchar(64) NOT NULL,
  `proxy_id` varchar(64) NOT NULL,
  `permissions` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `dav_cal_proxy_uidx` (`owner_id`,`proxy_id`,`permissions`),
  KEY `dav_cal_proxy_ipid` (`proxy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_dav_cal_proxy`
--

LOCK TABLES `oc_dav_cal_proxy` WRITE;
/*!40000 ALTER TABLE `oc_dav_cal_proxy` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_dav_cal_proxy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_dav_shares`
--

DROP TABLE IF EXISTS `oc_dav_shares`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_dav_shares` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `principaluri` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `access` smallint(6) DEFAULT NULL,
  `resourceid` bigint(20) unsigned NOT NULL,
  `publicuri` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `dav_shares_index` (`principaluri`,`resourceid`,`type`,`publicuri`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_dav_shares`
--

LOCK TABLES `oc_dav_shares` WRITE;
/*!40000 ALTER TABLE `oc_dav_shares` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_dav_shares` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_direct_edit`
--

DROP TABLE IF EXISTS `oc_direct_edit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_direct_edit` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `editor_id` varchar(64) NOT NULL,
  `token` varchar(64) NOT NULL,
  `file_id` bigint(20) NOT NULL,
  `user_id` varchar(64) DEFAULT NULL,
  `share_id` bigint(20) DEFAULT NULL,
  `timestamp` bigint(20) unsigned NOT NULL,
  `accessed` tinyint(1) DEFAULT 0,
  `file_path` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_4D5AFECA5F37A13B` (`token`),
  KEY `direct_edit_timestamp` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_direct_edit`
--

LOCK TABLES `oc_direct_edit` WRITE;
/*!40000 ALTER TABLE `oc_direct_edit` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_direct_edit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_directlink`
--

DROP TABLE IF EXISTS `oc_directlink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_directlink` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(64) DEFAULT NULL,
  `file_id` bigint(20) unsigned NOT NULL,
  `token` varchar(60) DEFAULT NULL,
  `expiration` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `directlink_token_idx` (`token`),
  KEY `directlink_expiration_idx` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_directlink`
--

LOCK TABLES `oc_directlink` WRITE;
/*!40000 ALTER TABLE `oc_directlink` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_directlink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_federated_reshares`
--

DROP TABLE IF EXISTS `oc_federated_reshares`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_federated_reshares` (
  `share_id` bigint(20) NOT NULL,
  `remote_id` varchar(255) DEFAULT '',
  PRIMARY KEY (`share_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_federated_reshares`
--

LOCK TABLES `oc_federated_reshares` WRITE;
/*!40000 ALTER TABLE `oc_federated_reshares` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_federated_reshares` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_file_locks`
--

DROP TABLE IF EXISTS `oc_file_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_file_locks` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `lock` int(11) NOT NULL DEFAULT 0,
  `key` varchar(64) NOT NULL,
  `ttl` int(11) NOT NULL DEFAULT -1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lock_key_index` (`key`),
  KEY `lock_ttl_index` (`ttl`)
) ENGINE=InnoDB AUTO_INCREMENT=192 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_file_locks`
--

LOCK TABLES `oc_file_locks` WRITE;
/*!40000 ALTER TABLE `oc_file_locks` DISABLE KEYS */;
INSERT INTO `oc_file_locks` VALUES
(1,0,'files/bd83838427963fd89c2a051b3aeda2d5',1752638246),
(36,0,'files/b6ef755cfc70b5eb94f5d3aad8ba833d',1752638246),
(38,0,'files/2b7e5de9afe8b3f7b056c0ba2a04af46',1752638247),
(62,0,'files/585273f764f7401d20c06a646f408e8a',1752638247),
(81,0,'files/6b2de085d9b53fa93fa74433933ff37f',1752638246),
(84,0,'files/cbc6f4e337332b94c2e02444d64b1c16',1752638246),
(85,0,'files/2c7eaecb9090bd89cef1dcd4d0d5881a',1752638246),
(86,0,'files/84fc6d08ed3bd071bcdab33a99d2d7d9',1752638247),
(87,0,'files/3513aba8aa4305d3ad33fc7122d4af30',1752638247),
(147,0,'files/8a049f46ee21ae8c406df9673180b970',1752637488),
(148,0,'files/bacd71c48ffad3be3eb476a34ef8dd0c',1752637488),
(149,0,'files/c10134fc3f762ca09aa4ba28c6f4c667',1752637488),
(150,0,'files/698894014df222bf32839d442aa7638e',1752637488),
(151,0,'files/b5ad799d90e4a8f7bcd650aa7411f456',1752637488),
(152,0,'files/6b2bc044ac25291f292c8b8810a20517',1752637488),
(153,0,'files/2dddd7da5a7b62d82e6ae97b7699b0ee',1752637488),
(154,0,'files/dbb50957218777cdcf51a42a7b32e3b3',1752637488),
(155,0,'files/865f43c36e0dc133c97285ca99ad3913',1752637488),
(156,0,'files/cb585c2688d46b8556e67a08c17fd9b0',1752637488),
(157,0,'files/f241fce686d393d2d4b90056ff0a10d9',1752637488),
(158,0,'files/e8cc3b2ee6e936fc725d43381784860f',1752637488),
(159,0,'files/bfb83959e562078cc867945ab9fffbe6',1752637488),
(160,0,'files/dc7d258e8a42b5f3f3bffdc9aa14b078',1752637488),
(161,0,'files/a5441f87285fc124c2d2694cf71addb2',1752637488),
(162,0,'files/4c6100eb262d1f0af77a29782201c436',1752637488),
(163,0,'files/48b6181fc6403b676524ced2c5caec50',1752637488),
(164,0,'files/b38fed9a499f26184a4902507a98f907',1752637488);
/*!40000 ALTER TABLE `oc_file_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_filecache`
--

DROP TABLE IF EXISTS `oc_filecache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_filecache` (
  `fileid` bigint(20) NOT NULL AUTO_INCREMENT,
  `storage` bigint(20) NOT NULL DEFAULT 0,
  `path` varchar(4000) DEFAULT NULL,
  `path_hash` varchar(32) NOT NULL DEFAULT '',
  `parent` bigint(20) NOT NULL DEFAULT 0,
  `name` varchar(250) DEFAULT NULL,
  `mimetype` bigint(20) NOT NULL DEFAULT 0,
  `mimepart` bigint(20) NOT NULL DEFAULT 0,
  `size` bigint(20) NOT NULL DEFAULT 0,
  `mtime` bigint(20) NOT NULL DEFAULT 0,
  `storage_mtime` bigint(20) NOT NULL DEFAULT 0,
  `encrypted` int(11) NOT NULL DEFAULT 0,
  `unencrypted_size` bigint(20) NOT NULL DEFAULT 0,
  `etag` varchar(40) DEFAULT NULL,
  `permissions` int(11) DEFAULT 0,
  `checksum` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`fileid`),
  UNIQUE KEY `fs_storage_path_hash` (`storage`,`path_hash`),
  KEY `fs_parent_name_hash` (`parent`,`name`),
  KEY `fs_storage_mimetype` (`storage`,`mimetype`),
  KEY `fs_storage_mimepart` (`storage`,`mimepart`),
  KEY `fs_storage_size` (`storage`,`size`,`fileid`),
  KEY `fs_id_storage_size` (`fileid`,`storage`,`size`),
  KEY `fs_parent` (`parent`),
  KEY `fs_mtime` (`mtime`),
  KEY `fs_size` (`size`),
  KEY `fs_storage_path_prefix` (`storage`,`path`(64))
) ENGINE=InnoDB AUTO_INCREMENT=190 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_filecache`
--

LOCK TABLES `oc_filecache` WRITE;
/*!40000 ALTER TABLE `oc_filecache` DISABLE KEYS */;
INSERT INTO `oc_filecache` VALUES
(1,1,'','d41d8cd98f00b204e9800998ecf8427e',-1,'',2,1,39080128,1752633874,1752633874,0,0,'687712127d04d',23,''),
(2,1,'files','45b963397aa40d4a0063e0d85e4fe7a1',1,'files',2,1,39080128,1752496156,1752496156,0,0,'6874f81cce8a4',31,''),
(3,1,'files/Photos','d01bb67e7b71dd49fd06bad922f521c9',2,'Photos',2,1,5656463,1752496153,1752496153,0,0,'6874f819d08fe',31,''),
(4,1,'files/Photos/Birdie.jpg','cd31c7af3a0ec6e15782b5edd2774549',3,'Birdie.jpg',4,3,593508,1752496153,1752496153,0,0,'c698fcf097acda80a758a9a8f251c8d3',27,''),
(5,1,'files/Photos/Frog.jpg','d6219add1a9129ed0c1513af985e2081',3,'Frog.jpg',4,3,457744,1752496153,1752496153,0,0,'270b864670b3359dd7e8520cb0f17380',27,''),
(6,1,'files/Photos/Library.jpg','0b785d02a19fc00979f82f6b54a05805',3,'Library.jpg',4,3,2170375,1752496153,1752496153,0,0,'70b69dd5454db8c80c570e27d677c887',27,''),
(7,1,'files/Photos/Nextcloud community.jpg','b9b3caef83a2a1c20354b98df6bcd9d0',3,'Nextcloud community.jpg',4,3,797325,1752496153,1752496153,0,0,'b144a6da1d2ec5c93442720c48c26e21',27,''),
(8,1,'files/Photos/Toucan.jpg','681d1e78f46a233e12ecfa722cbc2aef',3,'Toucan.jpg',4,3,167989,1752496153,1752496153,0,0,'76a926bfd4f024a94cc1f33f1137fe17',27,''),
(9,1,'files/Photos/Gorilla.jpg','6d5f5956d8ff76a5f290cebb56402789',3,'Gorilla.jpg',4,3,474653,1752496153,1752496153,0,0,'b879f629fc62b67f52ad2dbfceb092c1',27,''),
(10,1,'files/Photos/Vineyard.jpg','14e5f2670b0817614acd52269d971db8',3,'Vineyard.jpg',4,3,427030,1752496153,1752496153,0,0,'e726137cd37cd22ea469748f10dca14b',27,''),
(11,1,'files/Photos/Steps.jpg','7b2ca8d05bbad97e00cbf5833d43e912',3,'Steps.jpg',4,3,567689,1752496153,1752496153,0,0,'552de4a4e091abd6b85e178efcbd47e3',27,''),
(12,1,'files/Photos/Readme.md','2a4ac36bb841d25d06d164f291ee97db',3,'Readme.md',6,5,150,1752496153,1752496153,0,0,'5e23d91cc29cfdc9c96916d7ff1fe761',27,''),
(13,1,'files/Nextcloud.png','2bcc0ff06465ef1bfc4a868efde1e485',2,'Nextcloud.png',7,3,50598,1752496153,1752496153,0,0,'e5229ff211027b9fb09bd6786b8ac97d',27,''),
(14,1,'files/Documents','0ad78ba05b6961d92f7970b2b3922eca',2,'Documents',2,1,1108865,1752496154,1752496154,0,0,'6874f81a32fe0',31,''),
(15,1,'files/Documents/Nextcloud flyer.pdf','9c5b4dc7182a7435767708ac3e8d126c',14,'Nextcloud flyer.pdf',9,8,1083339,1752496154,1752496154,0,0,'363e4b4ebe70415bb3697d1c5737b35a',27,''),
(16,1,'files/Documents/Welcome to Nextcloud Hub.docx','b44cb84f22ceddc4ca2826e026038091',14,'Welcome to Nextcloud Hub.docx',10,8,24295,1752496154,1752496154,0,0,'5ba8ea62135ed859df744f19e8744321',27,''),
(17,1,'files/Documents/Example.md','efe0853470dd0663db34818b444328dd',14,'Example.md',6,5,1095,1752496154,1752496154,0,0,'aa1357346716d7af2589776ca887b932',27,''),
(18,1,'files/Documents/Readme.md','51ec9e44357d147dd5c212b850f6910f',14,'Readme.md',6,5,136,1752496154,1752496154,0,0,'9a941a22b91dd1da02032106f7f96099',27,''),
(19,1,'files/Reasons to use Nextcloud.pdf','418b19142a61c5bef296ea56ee144ca3',2,'Reasons to use Nextcloud.pdf',9,8,976625,1752496154,1752496154,0,0,'c93b4c1d944920765630228696dab7a8',27,''),
(20,1,'files/Nextcloud intro.mp4','e4919345bcc87d4585a5525daaad99c0',2,'Nextcloud intro.mp4',12,11,3963036,1752496154,1752496154,0,0,'5d2ffb7678b573b3fb538f20ed57b05e',27,''),
(21,1,'files/Templates','530b342d0b8164ff3b4754c2273a453e',2,'Templates',2,1,10721152,1752496156,1752496156,0,0,'6874f81c89365',31,''),
(22,1,'files/Templates/Mother\'s day.odt','cb66c617dbb4acc9b534ec095c400b53',21,'Mother\'s day.odt',13,8,340061,1752496154,1752496154,0,0,'ced5c27deff461241e4eabd6a9f44b34',27,''),
(23,1,'files/Templates/Meeting notes.md','c0279758bb570afdcdbc2471b2f16285',21,'Meeting notes.md',6,5,326,1752496154,1752496154,0,0,'9f4a5d21d7f150be6c6adcfd49b94957',27,''),
(24,1,'files/Templates/Impact effort matrix.whiteboard','c5e3b589ec8f9dd6afdebe0ac6feeac8',21,'Impact effort matrix.whiteboard',14,8,52674,1752496154,1752496154,0,0,'240c3c996e218d1f7ba4908870623507',27,''),
(25,1,'files/Templates/Simple.odp','a2c90ff606d31419d699b0b437969c61',21,'Simple.odp',15,8,14810,1752496154,1752496154,0,0,'cca528b4dd954e109370e5fbd0b81e4f',27,''),
(26,1,'files/Templates/Gotong royong.odp','14b958f5aafb7cfd703090226f3cbd1b',21,'Gotong royong.odp',15,8,3509628,1752496154,1752496154,0,0,'31cb674b8e07ce63804e1e8e738209d6',27,''),
(27,1,'files/Templates/Resume.odt','ace8f81202eadb2f0c15ba6ecc2539f5',21,'Resume.odt',13,8,39404,1752496154,1752496154,0,0,'d2cad8f54b9a210aa91539e3cce618a5',27,''),
(28,1,'files/Templates/Mindmap.odg','74cff798fc1b9634ee45380599b2a6da',21,'Mindmap.odg',16,8,13653,1752496154,1752496154,0,0,'45881f337a09d46fb63de37014744398',27,''),
(29,1,'files/Templates/Photo book.odt','ea35993988e2799424fef3ff4f420c24',21,'Photo book.odt',13,8,5155877,1752496155,1752496155,0,0,'ab9aedb93fb4941dbe2dd9b23e64fd99',27,''),
(30,1,'files/Templates/SWOT analysis.whiteboard','3fd0e44b3e6f0e7144442ef6fc71a663',21,'SWOT analysis.whiteboard',14,8,38605,1752496155,1752496155,0,0,'0f22fe9901136e58a096a984d49eadd4',27,''),
(31,1,'files/Templates/Party invitation.odt','439f95f734be87868374b1a5a312c550',21,'Party invitation.odt',13,8,868111,1752496155,1752496155,0,0,'15ae95421ec87d6eca0da237dc77ee97',27,''),
(32,1,'files/Templates/Invoice.odt','40fdccb51b6c3e3cf20532e06ed5016e',21,'Invoice.odt',13,8,17276,1752496155,1752496155,0,0,'a0d004a3c38d1bc18c9014293a778019',27,''),
(33,1,'files/Templates/Flowchart.odg','832942849155883ceddc6f3cede21867',21,'Flowchart.odg',16,8,11836,1752496155,1752496155,0,0,'3f418e2925950ce2da54d8a0e7fb0070',27,''),
(34,1,'files/Templates/Product plan.md','a9fbf58bf31cebb8143f7ad3a5205633',21,'Product plan.md',6,5,573,1752496155,1752496155,0,0,'26879509010bc0f0fa88c40a88796a03',27,''),
(35,1,'files/Templates/Yellow idea.odp','3a57051288d7b81bef3196a2123f4af5',21,'Yellow idea.odp',15,8,81196,1752496155,1752496155,0,0,'c0d7c8a39462e1e0814676fed52ffcdc',27,''),
(36,1,'files/Templates/Modern company.odp','96ad2c06ebb6a79bcdf2f4030421dee3',21,'Modern company.odp',15,8,317015,1752496155,1752496155,0,0,'8fb467afd4540cba15dc52a5186dd2d8',27,''),
(37,1,'files/Templates/Expense report.ods','d0a4025621279b95d2f94ff4ec09eab3',21,'Expense report.ods',17,8,13441,1752496155,1752496155,0,0,'093b9a9d9ffb9e531b6b1455e9bb3efc',27,''),
(38,1,'files/Templates/Org chart.odg','fd846bc062b158abb99a75a5b33b53e7',21,'Org chart.odg',16,8,13878,1752496155,1752496155,0,0,'174be361f744d3baf805f88aa85dd3d6',27,''),
(39,1,'files/Templates/Business model canvas.odg','6a8f3e02bdf45c8b0671967969393bcb',21,'Business model canvas.odg',16,8,16988,1752496156,1752496156,0,0,'bca55a2efccc7128a89cea60f18dc525',27,''),
(40,1,'files/Templates/Elegant.odp','f3ec70ed694c0ca215f094b98eb046a7',21,'Elegant.odp',15,8,14316,1752496156,1752496156,0,0,'e7a76dbe6384c9afb68ca5edacc4c68d',27,''),
(41,1,'files/Templates/Timesheet.ods','cb79c81e41d3c3c77cd31576dc7f1a3a',21,'Timesheet.ods',17,8,88394,1752496156,1752496156,0,0,'c5d0d4cddcf921a69eea3755317408da',27,''),
(42,1,'files/Templates/Syllabus.odt','03b3147e6dae00674c1d50fe22bb8496',21,'Syllabus.odt',13,8,30354,1752496156,1752496156,0,0,'a3545bb3aa6aa78c42e75ed64ebbb27f',27,''),
(43,1,'files/Templates/Readme.md','71fa2e74ab30f39eed525572ccc3bbec',21,'Readme.md',6,5,554,1752496156,1752496156,0,0,'237e5dcb9e09447cbb24d3df1aa6726e',27,''),
(44,1,'files/Templates/Business model canvas.ods','86c10a47dedf156bf4431cb75e0f76ec',21,'Business model canvas.ods',17,8,52843,1752496156,1752496156,0,0,'bdfc1edcda9b8325b9951c6b2054677d',27,''),
(45,1,'files/Templates/Diagram & table.ods','0a89f154655f6d4a0098bc4e6ca87367',21,'Diagram & table.ods',17,8,13378,1752496156,1752496156,0,0,'e7f694f8c1218ef828c7e5d74822db57',27,''),
(46,1,'files/Templates/Letter.odt','15545ade0e9863c98f3a5cc0fbf2836a',21,'Letter.odt',13,8,15961,1752496156,1752496156,0,0,'1c2712dc0f57368aa52d4366e18c4a96',27,''),
(47,1,'files/Readme.md','49af83716f8dcbfa89aaf835241c0b9f',2,'Readme.md',6,5,206,1752496156,1752496156,0,0,'076da18b7fb7961253519ff7641ea3ea',27,''),
(48,1,'files/Templates credits.md','f7c01e3e0b55bb895e09dc08d19375b3',2,'Templates credits.md',6,5,2403,1752496156,1752496156,0,0,'61fa3ea3f91a807d9d4c4e4525bb92f6',27,''),
(49,1,'files/Nextcloud Manual.pdf','2bc58a43566a8edde804a4a97a9c7469',2,'Nextcloud Manual.pdf',9,8,16600780,1752496156,1752496156,0,0,'a7944f050b8b3224a746429816c288ec',27,''),
(50,2,'','d41d8cd98f00b204e9800998ecf8427e',-1,'',2,1,-1,1752496176,1752496176,0,0,'6874f8301017f',23,''),
(51,2,'appdata_oc4topogunye','274a64dd4421ea947187702ec416ce5b',50,'appdata_oc4topogunye',2,1,0,1752496541,1752496541,0,0,'6874f8300f1c4',31,''),
(52,2,'appdata_oc4topogunye/js','bd07f2739367498e1e8a9154d715078e',51,'js',2,1,0,1752496176,1752496176,0,0,'6874f83015565',31,''),
(53,2,'appdata_oc4topogunye/js/core','955ed2b39772f71e0415358b563ede11',52,'core',2,1,0,1752496176,1752496176,0,0,'6874f8301710e',31,''),
(54,2,'appdata_oc4topogunye/js/core/merged-template-prepend.js','0ef180110186d9d05a21a3904950cb40',53,'merged-template-prepend.js',18,8,12290,1752496176,1752496176,0,0,'05bbef479cd3c60dac47b25ae041a95e',27,''),
(55,2,'appdata_oc4topogunye/js/core/merged-template-prepend.js.deps','9b9dd4c7173008cab461441ae4e9bfdf',53,'merged-template-prepend.js.deps',19,8,306,1752496176,1752496176,0,0,'f5ada8101d7241797ebd328a44d9c7cb',27,''),
(56,2,'appdata_oc4topogunye/js/core/merged-template-prepend.js.gzip','20df826602ccf6efc8b820cb84bd9ee8',53,'merged-template-prepend.js.gzip',20,8,3141,1752496176,1752496176,0,0,'e7a1233b20dbde372a6aaa6b936671c7',27,''),
(57,2,'appdata_oc4topogunye/theming','90f7bd1ae622020e8a8d3d3005d90e83',51,'theming',2,1,0,1752496176,1752496176,0,0,'6874f8302d439',31,''),
(58,2,'appdata_oc4topogunye/theming/global','e93eb80281e5048070f68d3f6dc02334',57,'global',2,1,0,1752496540,1752496540,0,0,'6874f8302fedc',31,''),
(59,2,'appdata_oc4topogunye/appstore','9ff8cc0decb262670eb489c1ab2773dc',51,'appstore',2,1,0,1752496185,1752496185,0,0,'6874f83124c64',31,''),
(60,2,'appdata_oc4topogunye/appstore/apps.json','e711cecad74a1b328a153cc7cd22c390',59,'apps.json',21,8,2676401,1752496185,1752496185,0,0,'f0567a9d9d3be5b524b912af80d2dbcd',27,''),
(61,2,'appdata_oc4topogunye/avatar','a792fb50138c22e6156e021c4b6d9373',51,'avatar',2,1,0,1752496198,1752496198,0,0,'6874f84647e3d',31,''),
(62,2,'appdata_oc4topogunye/avatar/admin','a189b15571d44bf33c1f22020392d2ad',61,'admin',2,1,0,1752496199,1752496199,0,0,'6874f84649c5f',31,''),
(63,2,'appdata_oc4topogunye/preview','12ef18353ebe9de412b5f8a56ab70dbe',51,'preview',2,1,0,1752496198,1752496198,0,0,'6874f84681765',31,''),
(64,2,'appdata_oc4topogunye/preview/3','218ad8a9794ff2ce47841a020a268447',63,'3',2,1,-1,1752496198,1752496198,0,0,'6874f8469c683',31,''),
(65,2,'appdata_oc4topogunye/preview/3/4','f825e64c767d00ea6790b2ba56c5b2a3',64,'4',2,1,-1,1752496198,1752496198,0,0,'6874f8469ae91',31,''),
(66,2,'appdata_oc4topogunye/preview/d','58b76dd93edad000ee595f2469e2a021',63,'d',2,1,-1,1752496198,1752496198,0,0,'6874f8469c71d',31,''),
(68,2,'appdata_oc4topogunye/preview/3/4/1','35c35e7ab5d1274fe93ad63ec629b3ea',65,'1',2,1,-1,1752496198,1752496198,0,0,'6874f84698471',31,''),
(69,2,'appdata_oc4topogunye/preview/d/6','b5cda351f6176d54886ea99b47898d01',66,'6',2,1,-1,1752496198,1752496198,0,0,'6874f846998ec',31,''),
(70,2,'appdata_oc4topogunye/preview/d/6/4','a7c33b2f35166d1226f637582ec15189',69,'4',2,1,-1,1752496198,1752496198,0,0,'6874f84698d0b',31,''),
(71,2,'appdata_oc4topogunye/preview/3/4/1/6','7140d2aefe368bf4fe218523a4d5e6bd',68,'6',2,1,-1,1752496198,1752496198,0,0,'6874f84695d48',31,''),
(72,2,'appdata_oc4topogunye/preview/d/6/4/5','607fd343060c00f903333b076e5baca7',70,'5',2,1,-1,1752496198,1752496198,0,0,'6874f846975ae',31,''),
(73,2,'appdata_oc4topogunye/preview/3/4/1/6/a','eb5af3c133331298642c74abfda6f0cb',71,'a',2,1,-1,1752496198,1752496198,0,0,'6874f84691710',31,''),
(75,2,'appdata_oc4topogunye/preview/d/6/4/5/9','a07b5a6b5d0755396f584a9639ce458a',72,'9',2,1,-1,1752496198,1752496198,0,0,'6874f84695e10',31,''),
(76,2,'appdata_oc4topogunye/preview/3/4/1/6/a/7','bd5c02af32cbc42c8a4ea9a71436b177',73,'7',2,1,-1,1752496198,1752496198,0,0,'6874f8468f04a',31,''),
(77,2,'appdata_oc4topogunye/preview/d/6/4/5/9/2','85d68803a1771d5ebce75a51b5762c5c',75,'2',2,1,-1,1752496198,1752496198,0,0,'6874f846936b4',31,''),
(78,2,'appdata_oc4topogunye/preview/3/4/1/6/a/7/5','45d443a44813f4a7568b39aabb568f60',76,'5',2,1,-1,1752496198,1752496198,0,0,'6874f8468e315',31,''),
(79,2,'appdata_oc4topogunye/preview/d/6/4/5/9/2/0','155c95d816558169d6eff0c090a97920',77,'0',2,1,-1,1752496198,1752496198,0,0,'6874f84691305',31,''),
(80,2,'appdata_oc4topogunye/preview/3/4/1/6/a/7/5/41','9f3d25a04b064efd1e62d8427df9cd9e',78,'41',2,1,0,1752496198,1752496198,0,0,'6874f8468b2d9',31,''),
(81,2,'appdata_oc4topogunye/preview/d/6/4/5/9/2/0/40','c6c29c288bc954a689b3aa039d33dd67',79,'40',2,1,0,1752496198,1752496198,0,0,'6874f8468f388',31,''),
(82,2,'appdata_oc4topogunye/preview/a','a42ea96879f00c937fc2893e2da218b6',63,'a',2,1,-1,1752496198,1752496198,0,0,'6874f846a95c7',31,''),
(83,2,'appdata_oc4topogunye/preview/d/6/7','27623ea10e51481295a835b0e7deb0bb',69,'7',2,1,-1,1752496198,1752496198,0,0,'6874f846980ae',31,''),
(84,2,'appdata_oc4topogunye/preview/a/1','207efdaedd3eb029f38ad4427ad73379',82,'1',2,1,-1,1752496198,1752496198,0,0,'6874f846a5ab6',31,''),
(85,2,'appdata_oc4topogunye/preview/d/6/7/d','a40670ad87ffefa0176afd94c1d238df',83,'d',2,1,-1,1752496198,1752496198,0,0,'6874f846971c9',31,''),
(86,2,'appdata_oc4topogunye/preview/a/1/d','6d1a4db5854eeb251c00b73577f65c97',84,'d',2,1,-1,1752496198,1752496198,0,0,'6874f846a3145',31,''),
(87,2,'appdata_oc4topogunye/preview/d/6/7/d/8','93c572f72c651c5cd69470f841632337',85,'8',2,1,-1,1752496198,1752496198,0,0,'6874f84695c69',31,''),
(88,2,'appdata_oc4topogunye/preview/a/1/d/0','b3d2f33a482971e6571a46f1c5050374',86,'0',2,1,-1,1752496198,1752496198,0,0,'6874f8469f67e',31,''),
(89,2,'appdata_oc4topogunye/preview/d/6/7/d/8/a','8ee86548bb01e3bd85eb7891ade6b655',87,'a',2,1,-1,1752496198,1752496198,0,0,'6874f8468fe7a',31,''),
(90,2,'appdata_oc4topogunye/preview/a/1/d/0/c','f24592410ee9b39611bc90ddb9ffc9da',88,'c',2,1,-1,1752496198,1752496198,0,0,'6874f8469c7ff',31,''),
(91,2,'appdata_oc4topogunye/preview/d/6/7/d/8/a/b','5dc5c6bba28217a01feb120b24cf7892',89,'b',2,1,-1,1752496198,1752496198,0,0,'6874f8468e77a',31,''),
(92,2,'appdata_oc4topogunye/preview/d/6/4/5/9/2/0/40/256-144-max.png','edb76876f5c75ab76b489bf3aa6acb4a',81,'256-144-max.png',7,3,1898,1752496198,1752496198,0,0,'bb48af606af322e194c1bcdc3f9e9906',27,''),
(93,2,'appdata_oc4topogunye/preview/d/6/7/d/8/a/b/39','21bbfebf3259287ae40cdd5fa1d53c84',91,'39',2,1,0,1752496198,1752496198,0,0,'6874f8468b653',31,''),
(94,2,'appdata_oc4topogunye/preview/a/1/d/0/c/6','46c0627a4b9cef715701376d7a31584f',90,'6',2,1,-1,1752496198,1752496198,0,0,'6874f84699a68',31,''),
(95,2,'appdata_oc4topogunye/preview/a/1/d/0/c/6/e','60d01fc254bdc4faa1caa4b036a54747',94,'e',2,1,-1,1752496198,1752496198,0,0,'6874f84697f86',31,''),
(96,2,'appdata_oc4topogunye/preview/a/1/d/0/c/6/e/42','9a8c20cb47ffaa15574cb1f6607a5507',95,'42',2,1,0,1752496199,1752496199,0,0,'6874f846967ef',31,''),
(97,2,'appdata_oc4topogunye/preview/3/4/1/6/a/7/5/41/328-441-max.png','7d0397cd541f2c2bcd82181d65fbed7a',80,'328-441-max.png',7,3,21466,1752496198,1752496198,0,0,'074a1c58588aadb5d223af07927f2342',27,''),
(98,2,'appdata_oc4topogunye/preview/d/6/4/5/9/2/0/40/144-144-crop.png','d64fc60e4ecdfd79a6e607008827633b',81,'144-144-crop.png',7,3,5337,1752496198,1752496198,0,0,'9d4618326d284cb7cb596bcb02474bf9',27,''),
(99,2,'appdata_oc4topogunye/preview/d/6/7/d/8/a/b/39/256-181-max.png','dc5f7b4b2a9de07782255ab64a82d4a7',93,'256-181-max.png',7,3,4032,1752496198,1752496198,0,0,'fd8c0f36e85b677a4ae9d06fa4f548ae',27,''),
(100,2,'appdata_oc4topogunye/preview/3/4/1/6/a/7/5/41/256-256-crop.png','e581cad678edee8ccd682bf084e3b5ff',80,'256-256-crop.png',7,3,49463,1752496198,1752496198,0,0,'5410d6a28c79741b1fbcbd41bcaf88d9',27,''),
(101,2,'appdata_oc4topogunye/preview/1','20e6ab70ff2a5f331f3f7e653833428f',63,'1',2,1,-1,1752496198,1752496198,0,0,'6874f846dd97f',31,''),
(102,2,'appdata_oc4topogunye/preview/1/7','143f9810b15b66dd3fb38fb83ace9870',101,'7',2,1,-1,1752496198,1752496198,0,0,'6874f846dc9e9',31,''),
(103,2,'appdata_oc4topogunye/preview/a/1/d/0/c/6/e/42/396-512-max.png','4da2274b0d20b94d0d894108cfc3083d',96,'396-512-max.png',7,3,19811,1752496198,1752496198,0,0,'1aa7422ff79caa9117cdb5a6805cc156',27,''),
(104,2,'appdata_oc4topogunye/preview/1/7/e','876790e601e2281579881c9bbf49b935',102,'e',2,1,-1,1752496198,1752496198,0,0,'6874f846db8d1',31,''),
(105,2,'appdata_oc4topogunye/preview/1/7/e/6','e5df7674d88ae849eb619825089da7a2',104,'6',2,1,-1,1752496198,1752496198,0,0,'6874f846dacaa',31,''),
(106,2,'appdata_oc4topogunye/preview/1/7/e/6/2','0f1eab836a7f5c5ec191f4cddfdc774d',105,'2',2,1,-1,1752496198,1752496198,0,0,'6874f846d9584',31,''),
(107,2,'appdata_oc4topogunye/preview/1/7/e/6/2/1','fdfad85a7487e3b1cb2a6205ff0b31e2',106,'1',2,1,-1,1752496198,1752496198,0,0,'6874f846d4e3d',31,''),
(108,2,'appdata_oc4topogunye/avatar/admin/avatar.png','114a0215bab0d7b3f0990cb5cd2ba8f8',62,'avatar.png',7,3,15643,1752496198,1752496198,0,0,'0bf2c079a70dae13934d976f840621c7',27,''),
(109,2,'appdata_oc4topogunye/preview/d/6/7/d/8/a/b/39/181-181-crop.png','9d783e2d3d609c1a642c3937050218f4',93,'181-181-crop.png',7,3,8254,1752496198,1752496198,0,0,'76812653bbfef0c905a3011053938181',27,''),
(110,2,'appdata_oc4topogunye/preview/1/7/e/6/2/1/6','67cebf9b37d91fb81375df9deb7875a8',107,'6',2,1,-1,1752496198,1752496198,0,0,'6874f846d2dd0',31,''),
(111,2,'appdata_oc4topogunye/avatar/admin/generated','cc65aac66082082e1249de4ef1fbadfb',62,'generated',19,8,0,1752496198,1752496198,0,0,'7065969fc9852797811e4b564d183fb6',27,''),
(112,2,'appdata_oc4topogunye/preview/1/7/e/6/2/1/6/43','922d402893f3f46962515cc43d6f91bc',110,'43',2,1,0,1752496199,1752496199,0,0,'6874f846cf6bb',31,''),
(113,2,'appdata_oc4topogunye/avatar/admin/avatar.64.png','e1418caa1ade3f744c75aa77e097eff6',62,'avatar.64.png',7,3,792,1752496199,1752496199,0,0,'03bd6590f8b2c252b7e1fb2410b1b67d',27,''),
(114,2,'appdata_oc4topogunye/preview/6','54417d8673392c61fadf3601d165d587',63,'6',2,1,-1,1752496199,1752496199,0,0,'6874f84707ff0',31,''),
(115,2,'appdata_oc4topogunye/preview/6/c','43af308f8beae410b352f5809e963d3c',114,'c',2,1,-1,1752496199,1752496199,0,0,'6874f847079fd',31,''),
(116,2,'appdata_oc4topogunye/preview/6/c/8','4e68dba988fb7689c124622c097475f8',115,'8',2,1,-1,1752496199,1752496199,0,0,'6874f84706ab3',31,''),
(117,2,'appdata_oc4topogunye/preview/6/c/8/3','1592c70b8ce3289e9d1cb9c7819ab411',116,'3',2,1,-1,1752496199,1752496199,0,0,'6874f8470639c',31,''),
(118,2,'appdata_oc4topogunye/preview/6/c/8/3/4','94497e3c2e665248165b434ee70f9900',117,'4',2,1,-1,1752496199,1752496199,0,0,'6874f84705a03',31,''),
(119,2,'appdata_oc4topogunye/preview/a/1/d/0/c/6/e/42/256-256-crop.png','ab9cd7300a9766d90fbb525623768804',96,'256-256-crop.png',7,3,39396,1752496199,1752496199,0,0,'e48bb8eb91bba2c7b74ea88e365f4a6f',27,''),
(120,2,'appdata_oc4topogunye/preview/6/c/8/3/4/9','5c669ee0594d3eeaeca2c73786efd2e3',118,'9',2,1,-1,1752496199,1752496199,0,0,'6874f84704d4c',31,''),
(121,2,'appdata_oc4topogunye/preview/6/c/8/3/4/9/c','b208bc1b5bf2e05a8aa6b4e76d09589a',120,'c',2,1,-1,1752496199,1752496199,0,0,'6874f847040ee',31,''),
(122,2,'appdata_oc4topogunye/preview/6/c/8/3/4/9/c/45','289956cfe1ffe86403c2e74d3b252f37',121,'45',2,1,0,1752496199,1752496199,0,0,'6874f847029ed',31,''),
(123,2,'appdata_oc4topogunye/preview/6/c/8/3/4/9/c/45/201-255-max.png','d120a10f30526445d399cab6d1b5d2da',122,'201-255-max.png',7,3,2090,1752496199,1752496199,0,0,'bdbd783b4adb899f3ee15758705e9487',27,''),
(124,2,'appdata_oc4topogunye/preview/6/c/8/3/4/9/c/45/201-201-crop.png','74a3158d6f3f1336bfc94c0b1e786e95',122,'201-201-crop.png',7,3,1639,1752496199,1752496199,0,0,'d1e5d8291d0623ffdb821228bb66c14b',27,''),
(125,2,'appdata_oc4topogunye/preview/f','f1cdb9b9f93c1a79ed24e7b73a83da58',63,'f',2,1,-1,1752496199,1752496199,0,0,'6874f84726171',31,''),
(126,2,'appdata_oc4topogunye/preview/f/7','f92cd714e8a93f24a66e6e008df34005',125,'7',2,1,-1,1752496199,1752496199,0,0,'6874f84724e2a',31,''),
(127,2,'appdata_oc4topogunye/preview/f/7/1','258ec4918fe87659f680151685a0a224',126,'1',2,1,-1,1752496199,1752496199,0,0,'6874f847237dc',31,''),
(128,2,'appdata_oc4topogunye/preview/f/7/1/7','5ff5938893a8e7d55173f0037c582b01',127,'7',2,1,-1,1752496199,1752496199,0,0,'6874f847218a9',31,''),
(129,2,'appdata_oc4topogunye/preview/f/7/1/7/7','b1a325602bf7ce0cf68e02ed6d5fb516',128,'7',2,1,-1,1752496199,1752496199,0,0,'6874f8471e6be',31,''),
(130,2,'appdata_oc4topogunye/preview/f/7/1/7/7/1','76a53188c9b7ecd77e1bb472915558dd',129,'1',2,1,-1,1752496199,1752496199,0,0,'6874f8471d472',31,''),
(131,2,'appdata_oc4topogunye/preview/f/7/1/7/7/1/6','ef69e89296e356828709ba1242bbd710',130,'6',2,1,-1,1752496199,1752496199,0,0,'6874f847192b1',31,''),
(132,2,'appdata_oc4topogunye/preview/f/7/1/7/7/1/6/44','d4936100e016f9b987d23d250080b1a3',131,'44',2,1,0,1752496199,1752496199,0,0,'6874f84714b1e',31,''),
(133,2,'appdata_oc4topogunye/preview/f/7/1/7/7/1/6/44/512-376-max.png','e54dcaecd9ec201edd986cbbcd272553',132,'512-376-max.png',7,3,13892,1752496199,1752496199,0,0,'ffd48d11c639eb3ceb37f708a5224c7e',27,''),
(134,2,'appdata_oc4topogunye/preview/f/7/1/7/7/1/6/44/256-256-crop.png','7c004eea6631beb05c5a9278eb533126',132,'256-256-crop.png',7,3,27900,1752496199,1752496199,0,0,'f3c5150f0e66afe264d40507f8107c6b',27,''),
(135,2,'appdata_oc4topogunye/preview/1/7/e/6/2/1/6/43/4096-4096-max.png','c4cc151c4683eed4dd3babd05e8bb9b3',112,'4096-4096-max.png',7,3,111694,1752496199,1752496199,0,0,'b6b1df65262e60e3f36566d3353eb61b',27,''),
(136,2,'appdata_oc4topogunye/preview/1/7/e/6/2/1/6/43/256-256-crop.png','6132e22b0e3703825b9ca4a0305331e7',112,'256-256-crop.png',7,3,20914,1752496199,1752496199,0,0,'810de28a52535dcbb27bc66a8c7b66d1',27,''),
(137,2,'appdata_oc4topogunye/theming/global/images','a361435f2ff21864eee4ef8f1f656b22',58,'images',2,1,0,1752496394,1752496394,0,0,'6874f9037795f',31,''),
(138,2,'appdata_oc4topogunye/theming/global/images/logo','f8a73b54df82c15130b110e09023f146',137,'logo',19,8,7935,1752496387,1752496387,0,0,'68ebebd4549b8bf41101641e3463a36c',27,''),
(139,2,'appdata_oc4topogunye/theming/global/images/background','bd1a8afe05e397c02f3dc2223a990b90',137,'background',19,8,783214,1752496394,1752496394,0,0,'4b480cae7d1e195d8d80c4112c04adac',27,''),
(140,2,'appdata_oc4topogunye/theming/global/5','e36ce608ca29b046b3de00168a84b4ff',58,'5',2,1,-1,1752633887,1752633887,0,0,'6874f99d08e0e',31,''),
(141,2,'appdata_oc4topogunye/theming/global/5/icon-core-#0082c9filetypes_x-office-document.svg','cf23611387d0564570c2fe21d00e838a',140,'icon-core-#0082c9filetypes_x-office-document.svg',22,3,295,1752496541,1752496541,0,0,'fe2cd23af8cdfff310cf30d9adf64c7e',27,''),
(142,2,'appdata_oc4topogunye/theming/global/5/icon-core-#0082c9filetypes_x-office-spreadsheet.svg','2c4644d4e00137ac7405db23dc5fbca9',140,'icon-core-#0082c9filetypes_x-office-spreadsheet.svg',22,3,327,1752496541,1752496541,0,0,'b290c8816cf8d892562923ac0984fd8f',27,''),
(143,2,'appdata_oc4topogunye/theming/global/5/icon-core-#0082c9filetypes_x-office-presentation.svg','03565a31ee4d789ca152af59d2d4985d',140,'icon-core-#0082c9filetypes_x-office-presentation.svg',22,3,261,1752496541,1752496541,0,0,'30c2c28902a98182dc574c45c6febb14',27,''),
(144,2,'appdata_oc4topogunye/theming/global/5/icon-core-#0082c9filetypes_text.svg','35d5dc1b9aa468c46328d0636e86a1c4',140,'icon-core-#0082c9filetypes_text.svg',22,3,295,1752496541,1752496541,0,0,'80e8d0751aa7de180dbe69982a69f12d',27,''),
(145,2,'appdata_oc4topogunye/preview/c','faf799b09d6730731fca5998e1c55ebc',63,'c',2,1,-1,1752496541,1752496541,0,0,'6874f99dba06f',31,''),
(146,2,'appdata_oc4topogunye/preview/9','e5c7273da4c91e0ffc2ae05d90de490a',63,'9',2,1,-1,1752496541,1752496541,0,0,'6874f99dbb7a2',31,''),
(147,2,'appdata_oc4topogunye/preview/c/5','e0978c75b7088fabc1ea37e4f4ddd4cd',145,'5',2,1,-1,1752496541,1752496541,0,0,'6874f99db95c4',31,''),
(148,2,'appdata_oc4topogunye/preview/9/8','09d6949c0c2855a1c2a5427472226bbd',146,'8',2,1,-1,1752496541,1752496541,0,0,'6874f99dbab51',31,''),
(149,2,'appdata_oc4topogunye/preview/c/5/1','5956f1495610537a9e48eca6c1392fee',147,'1',2,1,-1,1752496541,1752496541,0,0,'6874f99db8918',31,''),
(150,2,'appdata_oc4topogunye/preview/9/8/f','15c697e02b38b815d988d1588dc992fd',148,'f',2,1,-1,1752496541,1752496541,0,0,'6874f99db9a6c',31,''),
(151,2,'appdata_oc4topogunye/preview/c/5/1/c','498e3e3c939ea754e2807fe6d60de947',149,'c',2,1,-1,1752496541,1752496541,0,0,'6874f99db31a0',31,''),
(152,2,'appdata_oc4topogunye/preview/9/8/f/1','cf29344ee563c18349d1ccd2ebba4e62',150,'1',2,1,-1,1752496541,1752496541,0,0,'6874f99db9039',31,''),
(153,2,'appdata_oc4topogunye/preview/c/5/1/c/e','a5a2fdab685e47bd75e4d8fb339916a4',151,'e',2,1,-1,1752496541,1752496541,0,0,'6874f99db0ae8',31,''),
(154,2,'appdata_oc4topogunye/preview/c/5/1/c/e/4','25a22564c3d9383891e2a5330c55c266',153,'4',2,1,-1,1752496541,1752496541,0,0,'6874f99daf214',31,''),
(155,2,'appdata_oc4topogunye/preview/9/8/f/1/3','38dcf4a5a3b2873298725cea57695376',152,'3',2,1,-1,1752496541,1752496541,0,0,'6874f99db3a8b',31,''),
(156,2,'appdata_oc4topogunye/preview/c/5/1/c/e/4/1','016ef28883d0dfd55bd147d3ba38d98a',154,'1',2,1,-1,1752496541,1752496541,0,0,'6874f99dae65f',31,''),
(157,2,'appdata_oc4topogunye/preview/9/8/f/1/3/7','e407e2563d174e02662941f3c8677e21',155,'7',2,1,-1,1752496541,1752496541,0,0,'6874f99db1052',31,''),
(158,2,'appdata_oc4topogunye/preview/c/5/1/c/e/4/1/13','3fa14c9da31cd2f5f4a76d03febb1aba',156,'13',2,1,0,1752496541,1752496541,0,0,'6874f99dad036',31,''),
(159,2,'appdata_oc4topogunye/preview/9/8/f/1/3/7/0','96c7ac7dab863948147d7e96aa71432b',157,'0',2,1,-1,1752496541,1752496541,0,0,'6874f99db025c',31,''),
(160,2,'appdata_oc4topogunye/preview/9/8/f/1/3/7/0/20','8652d6e01cb6149e297698fe5a50b103',159,'20',2,1,0,1752496541,1752496541,0,0,'6874f99daea9c',31,''),
(161,2,'appdata_oc4topogunye/text','e7d9003334635de4f0f10fc50a252549',51,'text',2,1,0,1752496541,1752496541,0,0,'6874f99dd5a22',31,''),
(162,2,'appdata_oc4topogunye/preview/c/5/1/c/e/4/1/13/500-500-max.png','036e2fa5237a85e0cc6ce7369d6930b0',158,'500-500-max.png',7,3,50545,1752496541,1752496541,0,0,'c77191b081d010bbb1809d07b885d836',27,''),
(163,2,'appdata_oc4topogunye/text/documents','6b37805ac49714c1cde4736e2ca80553',161,'documents',2,1,0,1752496541,1752496541,0,0,'6874f99dda1e8',31,''),
(164,2,'appdata_oc4topogunye/preview/c/5/1/c/e/4/1/13/64-64-crop.png','a9436cd80057295ee67d89f6ba9f9a3f',158,'64-64-crop.png',7,3,3895,1752496541,1752496541,0,0,'70fb87ab3931f6fcbda4da940e571741',27,''),
(165,1,'cache','0fea6a13c52b4d4725368f24b045ca84',1,'cache',2,1,0,1752633874,1752633874,0,0,'6877121272b91',31,''),
(166,2,'appdata_oc4topogunye/theming/global/5/icon-core-#0082c9filetypes_x-office-drawing.svg','98ec2f90cf734b185c213c7d42296afe',140,'icon-core-#0082c9filetypes_x-office-drawing.svg',22,3,270,1752633887,1752633887,0,0,'ad7eadc17b506b7fc2bcb64ec40e1fae',27,''),
(167,2,'appdata_oc4topogunye/preview/1/f','e57e6324a9ce44d4c08c2eb284a57606',101,'f',2,1,-1,1752633888,1752633888,0,0,'6877122079461',31,''),
(168,2,'appdata_oc4topogunye/preview/1/f/0','856563a0e21e79acea1c067a6839a614',167,'0',2,1,-1,1752633888,1752633888,0,0,'68771220773ab',31,''),
(169,2,'appdata_oc4topogunye/preview/1/f/0/e','aeec7286eb35467f60bf54c13356fdbe',168,'e',2,1,-1,1752633888,1752633888,0,0,'6877122075deb',31,''),
(170,2,'appdata_oc4topogunye/preview/1/f/0/e/3','f60678d4d4702de75c01335d1b52e52d',169,'3',2,1,-1,1752633888,1752633888,0,0,'687712207501e',31,''),
(171,2,'appdata_oc4topogunye/preview/1/f/0/e/3/d','0cfd563c4a7065609ee16933c6897c3f',170,'d',2,1,-1,1752633888,1752633888,0,0,'68771220741af',31,''),
(172,2,'appdata_oc4topogunye/preview/f/4','f27b5b3110a37f4b73fa1201d1f50222',125,'4',2,1,-1,1752633888,1752633888,0,0,'687712207e49d',31,''),
(173,2,'appdata_oc4topogunye/preview/1/f/0/e/3/d/a','b27db69351df783b17e9170464eb7649',171,'a',2,1,-1,1752633888,1752633888,0,0,'68771220737e4',31,''),
(174,2,'appdata_oc4topogunye/preview/6/7','d7f9e088252c10189682846158e6d613',114,'7',2,1,-1,1752633888,1752633888,0,0,'687712207fd45',31,''),
(175,2,'appdata_oc4topogunye/preview/f/4/5','f152d0c71c90b36d8b35f31bb637afdf',172,'5',2,1,-1,1752633888,1752633888,0,0,'687712207d047',31,''),
(176,2,'appdata_oc4topogunye/preview/1/f/0/e/3/d/a/19','c8afa695ccc8cebc04aed770ddc9f196',173,'19',2,1,0,1752633888,1752633888,0,0,'6877122070e30',31,''),
(177,2,'appdata_oc4topogunye/preview/6/7/c','44cdfc57e49f4db464c8d6c14f9c4d42',174,'c',2,1,-1,1752633888,1752633888,0,0,'687712207f04b',31,''),
(178,2,'appdata_oc4topogunye/preview/f/4/5/7','e27cf0910a07ce8b296a25561fa5e574',175,'7',2,1,-1,1752633888,1752633888,0,0,'687712207bc3e',31,''),
(179,2,'appdata_oc4topogunye/preview/6/7/c/6','9458b3c1e671c4ac342b52f312f02149',177,'6',2,1,-1,1752633888,1752633888,0,0,'687712207e039',31,''),
(180,2,'appdata_oc4topogunye/preview/f/4/5/7/c','e2b4cfec50c16570567bc5fe779279f0',178,'c',2,1,-1,1752633888,1752633888,0,0,'687712207a920',31,''),
(181,2,'appdata_oc4topogunye/preview/f/4/5/7/c/5','19585d5b7389e9d8beb06b2b94e286c1',180,'5',2,1,-1,1752633888,1752633888,0,0,'68771220785a9',31,''),
(182,2,'appdata_oc4topogunye/preview/6/7/c/6/a','54080f5ed34d8940ba3a4047b692c7cf',179,'a',2,1,-1,1752633888,1752633888,0,0,'687712207c973',31,''),
(183,2,'appdata_oc4topogunye/preview/f/4/5/7/c/5/4','bd035271304ede898cc539e5ea51013f',181,'4',2,1,-1,1752633888,1752633888,0,0,'6877122075f31',31,''),
(184,2,'appdata_oc4topogunye/preview/6/7/c/6/a/1','95e617e1d2bec87df5671f4af90d429c',182,'1',2,1,-1,1752633888,1752633888,0,0,'687712207bb4b',31,''),
(185,2,'appdata_oc4topogunye/preview/f/4/5/7/c/5/4/49','c7c9730f60a4df2dccbc06ed912e3f08',183,'49',2,1,0,1752633888,1752633888,0,0,'6877122074700',31,''),
(186,2,'appdata_oc4topogunye/preview/6/7/c/6/a/1/e','68239cfc49b879576ad2338e0f207cff',184,'e',2,1,-1,1752633888,1752633888,0,0,'687712207a5ca',31,''),
(187,2,'appdata_oc4topogunye/preview/6/7/c/6/a/1/e/47','3cc70f23e7604df9252e106617e316a1',186,'47',2,1,0,1752633889,1752633889,0,0,'6877122077c59',31,''),
(188,2,'appdata_oc4topogunye/preview/6/7/c/6/a/1/e/47/4096-4096-max.png','81521bc819148153a3875303146bd457',187,'4096-4096-max.png',7,3,47099,1752633888,1752633888,0,0,'19ac05bf8ba5253a5c4bcfa55a17c312',27,''),
(189,2,'appdata_oc4topogunye/preview/6/7/c/6/a/1/e/47/64-64-crop.png','8530581c5a0dd7ac7b4a3ab5bb4f8f99',187,'64-64-crop.png',7,3,1158,1752633889,1752633889,0,0,'f0b2ec022fcefab658bab12b7448fe16',27,'');
/*!40000 ALTER TABLE `oc_filecache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_filecache_extended`
--

DROP TABLE IF EXISTS `oc_filecache_extended`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_filecache_extended` (
  `fileid` bigint(20) unsigned NOT NULL,
  `metadata_etag` varchar(40) DEFAULT NULL,
  `creation_time` bigint(20) NOT NULL DEFAULT 0,
  `upload_time` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`fileid`),
  KEY `fce_ctime_idx` (`creation_time`),
  KEY `fce_utime_idx` (`upload_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_filecache_extended`
--

LOCK TABLES `oc_filecache_extended` WRITE;
/*!40000 ALTER TABLE `oc_filecache_extended` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_filecache_extended` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_files_metadata`
--

DROP TABLE IF EXISTS `oc_files_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_files_metadata` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `file_id` bigint(20) NOT NULL,
  `json` longtext NOT NULL,
  `sync_token` varchar(15) NOT NULL,
  `last_update` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `files_meta_fileid` (`file_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_files_metadata`
--

LOCK TABLES `oc_files_metadata` WRITE;
/*!40000 ALTER TABLE `oc_files_metadata` DISABLE KEYS */;
INSERT INTO `oc_files_metadata` VALUES
(1,4,'{\"photos-original_date_time\":{\"value\":1341059531,\"type\":\"int\",\"indexed\":true,\"editPermission\":0},\"photos-exif\":{\"value\":{\"ExposureTime\":\"1\\/125\",\"FNumber\":\"28\\/5\",\"ExposureProgram\":3,\"ISOSpeedRatings\":320,\"UndefinedTag__x____\":320,\"ExifVersion\":\"0230\",\"DateTimeOriginal\":\"2012:06:30 12:32:11\",\"DateTimeDigitized\":\"2012:06:30 12:32:11\",\"ComponentsConfiguration\":\"\",\"ShutterSpeedValue\":\"7\\/1\",\"ApertureValue\":\"5\\/1\",\"ExposureBiasValue\":\"0\\/1\",\"MaxApertureValue\":\"189284\\/33461\",\"MeteringMode\":5,\"Flash\":16,\"FocalLength\":\"280\\/1\",\"SubSecTime\":\"83\",\"SubSecTimeOriginal\":\"83\",\"SubSecTimeDigitized\":\"83\",\"FlashPixVersion\":\"0100\",\"ColorSpace\":1,\"ExifImageWidth\":1600,\"ExifImageLength\":1067,\"FocalPlaneXResolution\":\"1920000\\/487\",\"FocalPlaneYResolution\":\"320000\\/81\",\"FocalPlaneResolutionUnit\":2,\"CustomRendered\":0,\"ExposureMode\":0,\"WhiteBalance\":0,\"SceneCaptureType\":0,\"UndefinedTag__xA___\":\"0000000000\"},\"type\":\"array\",\"indexed\":false,\"editPermission\":0},\"photos-ifd0\":{\"value\":{\"Make\":\"Canon\",\"Model\":\"Canon EOS 5D Mark III\",\"Orientation\":1,\"XResolution\":\"72\\/1\",\"YResolution\":\"72\\/1\",\"ResolutionUnit\":2,\"DateTime\":\"2012:06:30 12:32:11\",\"Exif_IFD_Pointer\":174},\"type\":\"array\",\"indexed\":false,\"editPermission\":0},\"photos-size\":{\"value\":{\"width\":1600,\"height\":1067},\"type\":\"array\",\"indexed\":false,\"editPermission\":0}}','n1Qbzgv','2025-07-14 12:29:13'),
(2,5,'{\"photos-original_date_time\":{\"value\":1341072915,\"type\":\"int\",\"indexed\":true,\"editPermission\":0},\"photos-exif\":{\"value\":{\"ExposureTime\":\"1\\/500\",\"FNumber\":\"28\\/5\",\"ExposureProgram\":1,\"ISOSpeedRatings\":8000,\"ExifVersion\":\"0230\",\"DateTimeOriginal\":\"2012:06:30 16:15:15\",\"DateTimeDigitized\":\"2012:06:30 16:15:15\",\"ComponentsConfiguration\":\"\",\"ShutterSpeedValue\":\"9\\/1\",\"ApertureValue\":\"5\\/1\",\"ExposureBiasValue\":\"0\\/1\",\"MaxApertureValue\":\"6149\\/1087\",\"MeteringMode\":5,\"Flash\":16,\"FocalLength\":\"280\\/1\",\"SubSecTime\":\"00\",\"SubSecTimeOriginal\":\"00\",\"SubSecTimeDigitized\":\"00\",\"FlashPixVersion\":\"0100\",\"ColorSpace\":1,\"ExifImageWidth\":1600,\"ExifImageLength\":1067,\"FocalPlaneXResolution\":\"382423\\/97\",\"FocalPlaneYResolution\":\"134321\\/34\",\"FocalPlaneResolutionUnit\":2,\"CustomRendered\":0,\"ExposureMode\":1,\"WhiteBalance\":0,\"SceneCaptureType\":0},\"type\":\"array\",\"indexed\":false,\"editPermission\":0},\"photos-ifd0\":{\"value\":{\"Make\":\"Canon\",\"Model\":\"Canon EOS 5D Mark III\",\"Orientation\":1,\"XResolution\":\"72\\/1\",\"YResolution\":\"72\\/1\",\"ResolutionUnit\":2,\"Software\":\"Aperture 3.3.1\",\"DateTime\":\"2012:06:30 16:15:15\",\"Exif_IFD_Pointer\":202},\"type\":\"array\",\"indexed\":false,\"editPermission\":0},\"photos-size\":{\"value\":{\"width\":1600,\"height\":1067},\"type\":\"array\",\"indexed\":false,\"editPermission\":0}}','8pSR4US','2025-07-14 12:29:13'),
(3,6,'{\"photos-original_date_time\":{\"value\":1341258636,\"type\":\"int\",\"indexed\":true,\"editPermission\":0},\"photos-exif\":{\"value\":{\"ExposureTime\":\"1\\/80\",\"FNumber\":\"4\\/1\",\"ExposureProgram\":3,\"ISOSpeedRatings\":400,\"ExifVersion\":\"0230\",\"DateTimeOriginal\":\"2012:07:02 19:50:36\",\"DateTimeDigitized\":\"2012:07:02 19:50:36\",\"ComponentsConfiguration\":\"\",\"ShutterSpeedValue\":\"51\\/8\",\"ApertureValue\":\"4\\/1\",\"ExposureBiasValue\":\"0\\/1\",\"MaxApertureValue\":\"4\\/1\",\"MeteringMode\":5,\"Flash\":16,\"FocalLength\":\"32\\/1\",\"SubSecTime\":\"00\",\"SubSecTimeOriginal\":\"00\",\"SubSecTimeDigitized\":\"00\",\"FlashPixVersion\":\"0100\",\"ColorSpace\":1,\"ExifImageWidth\":1600,\"ExifImageLength\":1066,\"FocalPlaneXResolution\":\"382423\\/97\",\"FocalPlaneYResolution\":\"185679\\/47\",\"FocalPlaneResolutionUnit\":2,\"CustomRendered\":0,\"ExposureMode\":0,\"WhiteBalance\":0,\"SceneCaptureType\":0},\"type\":\"array\",\"indexed\":false,\"editPermission\":0},\"photos-ifd0\":{\"value\":{\"Make\":\"Canon\",\"Model\":\"Canon EOS 5D Mark III\",\"Orientation\":1,\"XResolution\":\"72\\/1\",\"YResolution\":\"72\\/1\",\"ResolutionUnit\":2,\"Software\":\"GIMP 2.8.0\",\"DateTime\":\"2012:07:02 22:06:14\",\"Exif_IFD_Pointer\":198},\"type\":\"array\",\"indexed\":false,\"editPermission\":0},\"photos-size\":{\"value\":{\"width\":1600,\"height\":1066},\"type\":\"array\",\"indexed\":false,\"editPermission\":0}}','ifetlfb','2025-07-14 12:29:13'),
(4,7,'{\"photos-original_date_time\":{\"value\":1752496153,\"type\":\"int\",\"indexed\":true,\"editPermission\":0},\"photos-size\":{\"value\":{\"width\":3000,\"height\":2000},\"type\":\"array\",\"indexed\":false,\"editPermission\":0}}','RjWQrP4','2025-07-14 12:29:13'),
(5,8,'{\"photos-original_date_time\":{\"value\":1444907264,\"type\":\"int\",\"indexed\":true,\"editPermission\":0},\"photos-exif\":{\"value\":{\"ExposureTime\":\"1\\/320\",\"FNumber\":\"4\\/1\",\"ExposureProgram\":3,\"ISOSpeedRatings\":640,\"UndefinedTag__x____\":640,\"ExifVersion\":\"0230\",\"DateTimeOriginal\":\"2015:10:15 11:07:44\",\"DateTimeDigitized\":\"2015:10:15 11:07:44\",\"ShutterSpeedValue\":\"27970\\/3361\",\"ApertureValue\":\"4\\/1\",\"ExposureBiasValue\":\"1\\/3\",\"MaxApertureValue\":\"4\\/1\",\"MeteringMode\":5,\"Flash\":16,\"FocalLength\":\"200\\/1\",\"SubSecTimeOriginal\":\"63\",\"SubSecTimeDigitized\":\"63\",\"ColorSpace\":1,\"ExifImageWidth\":1600,\"ExifImageLength\":1067,\"FocalPlaneXResolution\":\"1600\\/1\",\"FocalPlaneYResolution\":\"1600\\/1\",\"FocalPlaneResolutionUnit\":3,\"CustomRendered\":0,\"ExposureMode\":0,\"WhiteBalance\":0,\"SceneCaptureType\":0,\"UndefinedTag__xA___\":\"000084121f\"},\"type\":\"array\",\"indexed\":false,\"editPermission\":0},\"photos-ifd0\":{\"value\":{\"Make\":\"Canon\",\"Model\":\"Canon EOS 5D Mark III\",\"Orientation\":1,\"XResolution\":\"240\\/1\",\"YResolution\":\"240\\/1\",\"ResolutionUnit\":2,\"Software\":\"Adobe Photoshop Lightroom 6.2.1 (Macintosh)\",\"DateTime\":\"2015:10:16 14:40:21\",\"Exif_IFD_Pointer\":230},\"type\":\"array\",\"indexed\":false,\"editPermission\":0},\"photos-size\":{\"value\":{\"width\":1600,\"height\":1067},\"type\":\"array\",\"indexed\":false,\"editPermission\":0}}','6H2MsvQ','2025-07-14 12:29:13'),
(6,9,'{\"photos-original_date_time\":{\"value\":1341064060,\"type\":\"int\",\"indexed\":true,\"editPermission\":0},\"photos-exif\":{\"value\":{\"ExposureTime\":\"1\\/640\",\"FNumber\":\"28\\/5\",\"ExposureProgram\":1,\"ISOSpeedRatings\":12800,\"ExifVersion\":\"0230\",\"DateTimeOriginal\":\"2012:06:30 13:47:40\",\"DateTimeDigitized\":\"2012:06:30 13:47:40\",\"ComponentsConfiguration\":\"\",\"ShutterSpeedValue\":\"75\\/8\",\"ApertureValue\":\"5\\/1\",\"ExposureBiasValue\":\"0\\/1\",\"MaxApertureValue\":\"6149\\/1087\",\"MeteringMode\":5,\"Flash\":16,\"FocalLength\":\"235\\/1\",\"SubSecTime\":\"00\",\"SubSecTimeOriginal\":\"00\",\"SubSecTimeDigitized\":\"00\",\"FlashPixVersion\":\"0100\",\"ExifImageWidth\":1600,\"ExifImageLength\":1067,\"FocalPlaneXResolution\":\"382423\\/97\",\"FocalPlaneYResolution\":\"134321\\/34\",\"FocalPlaneResolutionUnit\":2,\"CustomRendered\":0,\"ExposureMode\":1,\"WhiteBalance\":0,\"SceneCaptureType\":0},\"type\":\"array\",\"indexed\":false,\"editPermission\":0},\"photos-ifd0\":{\"value\":{\"Make\":\"Canon\",\"Model\":\"Canon EOS 5D Mark III\",\"Orientation\":1,\"XResolution\":\"72\\/1\",\"YResolution\":\"72\\/1\",\"ResolutionUnit\":2,\"Software\":\"Aperture 3.3.1\",\"DateTime\":\"2012:06:30 13:47:40\",\"Exif_IFD_Pointer\":202},\"type\":\"array\",\"indexed\":false,\"editPermission\":0},\"photos-size\":{\"value\":{\"width\":1600,\"height\":1067},\"type\":\"array\",\"indexed\":false,\"editPermission\":0}}','Nbeb7mr','2025-07-14 12:29:13'),
(7,10,'{\"photos-original_date_time\":{\"value\":1526500980,\"type\":\"int\",\"indexed\":true,\"editPermission\":0},\"photos-exif\":{\"value\":{\"ExposureTime\":\"10\\/12500\",\"FNumber\":\"35\\/10\",\"ExposureProgram\":3,\"ISOSpeedRatings\":100,\"DateTimeOriginal\":\"2018:05:16 20:03:00\",\"DateTimeDigitized\":\"2018:05:16 20:03:00\",\"ExposureBiasValue\":\"0\\/6\",\"MaxApertureValue\":\"30\\/10\",\"MeteringMode\":5,\"LightSource\":0,\"Flash\":16,\"FocalLength\":\"700\\/10\",\"MakerNote\":\"Nikon\",\"UserComment\":\"Christoph WurstCC-SA 4.0\",\"SubSecTime\":\"30\",\"SubSecTimeOriginal\":\"30\",\"SubSecTimeDigitized\":\"30\",\"ColorSpace\":1,\"SensingMethod\":2,\"FileSource\":\"\",\"SceneType\":\"\",\"CustomRendered\":0,\"ExposureMode\":0,\"WhiteBalance\":0,\"DigitalZoomRatio\":\"1\\/1\",\"FocalLengthIn__mmFilm\":70,\"SceneCaptureType\":0,\"GainControl\":0,\"Contrast\":1,\"Saturation\":0,\"Sharpness\":1,\"SubjectDistanceRange\":0},\"type\":\"array\",\"indexed\":false,\"editPermission\":0},\"photos-ifd0\":{\"value\":{\"ImageDescription\":\"Christoph WurstCC-SA 4.0\",\"Make\":\"NIKON CORPORATION\",\"Model\":\"NIKON D610\",\"Orientation\":1,\"XResolution\":\"72\\/1\",\"YResolution\":\"72\\/1\",\"ResolutionUnit\":2,\"Software\":\"GIMP 2.10.14\",\"DateTime\":\"2019:12:10 08:51:16\",\"Artist\":\"Christoph Wurst                     \",\"Copyright\":\"Christoph Wurst                                       \",\"Exif_IFD_Pointer\":402,\"GPS_IFD_Pointer\":13738,\"DateTimeOriginal\":\"2018:05:16 20:03:00\"},\"type\":\"array\",\"indexed\":false,\"editPermission\":0},\"photos-size\":{\"value\":{\"width\":1920,\"height\":1281},\"type\":\"array\",\"indexed\":false,\"editPermission\":0}}','nMuC88U','2025-07-14 12:29:13'),
(8,11,'{\"photos-original_date_time\":{\"value\":1372319469,\"type\":\"int\",\"indexed\":true,\"editPermission\":0},\"photos-exif\":{\"value\":{\"ExposureTime\":\"1\\/160\",\"FNumber\":\"4\\/1\",\"ExposureProgram\":3,\"ISOSpeedRatings\":100,\"ExifVersion\":\"0230\",\"DateTimeOriginal\":\"2013:06:27 07:51:09\",\"DateTimeDigitized\":\"2013:06:27 07:51:09\",\"ComponentsConfiguration\":\"\",\"ShutterSpeedValue\":\"59\\/8\",\"ApertureValue\":\"4\\/1\",\"ExposureBiasValue\":\"2\\/3\",\"MaxApertureValue\":\"4\\/1\",\"MeteringMode\":5,\"Flash\":16,\"FocalLength\":\"45\\/1\",\"SubSecTime\":\"00\",\"SubSecTimeOriginal\":\"00\",\"SubSecTimeDigitized\":\"00\",\"FlashPixVersion\":\"0100\",\"ColorSpace\":1,\"ExifImageWidth\":1200,\"ExifImageLength\":1800,\"FocalPlaneXResolution\":\"382423\\/97\",\"FocalPlaneYResolution\":\"185679\\/47\",\"FocalPlaneResolutionUnit\":2,\"CustomRendered\":0,\"ExposureMode\":0,\"WhiteBalance\":0,\"SceneCaptureType\":0,\"UndefinedTag__xA___\":\"000052602c\"},\"type\":\"array\",\"indexed\":false,\"editPermission\":0},\"photos-ifd0\":{\"value\":{\"Make\":\"Canon\",\"Model\":\"Canon EOS 5D Mark III\",\"Orientation\":1,\"XResolution\":\"72\\/1\",\"YResolution\":\"72\\/1\",\"ResolutionUnit\":2,\"Software\":\"Aperture 3.4.5\",\"DateTime\":\"2013:06:27 07:51:09\",\"Exif_IFD_Pointer\":202},\"type\":\"array\",\"indexed\":false,\"editPermission\":0},\"photos-size\":{\"value\":{\"width\":1200,\"height\":1800},\"type\":\"array\",\"indexed\":false,\"editPermission\":0}}','w6b9lHF','2025-07-14 12:29:13'),
(9,13,'{\"photos-original_date_time\":{\"value\":1752496153,\"type\":\"int\",\"indexed\":true,\"editPermission\":0},\"photos-size\":{\"value\":{\"width\":500,\"height\":500},\"type\":\"array\",\"indexed\":false,\"editPermission\":0}}','x8DSjab','2025-07-14 12:29:13'),
(10,20,'{\"photos-original_date_time\":{\"value\":1752496154,\"type\":\"int\",\"indexed\":true,\"editPermission\":0}}','lMxBqiQ','2025-07-14 12:29:14');
/*!40000 ALTER TABLE `oc_files_metadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_files_metadata_index`
--

DROP TABLE IF EXISTS `oc_files_metadata_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_files_metadata_index` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `file_id` bigint(20) NOT NULL,
  `meta_key` varchar(31) DEFAULT NULL,
  `meta_value_string` varchar(63) DEFAULT NULL,
  `meta_value_int` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `f_meta_index` (`file_id`,`meta_key`,`meta_value_string`),
  KEY `f_meta_index_i` (`file_id`,`meta_key`,`meta_value_int`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_files_metadata_index`
--

LOCK TABLES `oc_files_metadata_index` WRITE;
/*!40000 ALTER TABLE `oc_files_metadata_index` DISABLE KEYS */;
INSERT INTO `oc_files_metadata_index` VALUES
(2,4,'photos-original_date_time',NULL,1341059531),
(4,5,'photos-original_date_time',NULL,1341072915),
(6,6,'photos-original_date_time',NULL,1341258636),
(8,7,'photos-original_date_time',NULL,1752496153),
(10,8,'photos-original_date_time',NULL,1444907264),
(12,9,'photos-original_date_time',NULL,1341064060),
(14,10,'photos-original_date_time',NULL,1526500980),
(16,11,'photos-original_date_time',NULL,1372319469),
(18,13,'photos-original_date_time',NULL,1752496153),
(19,20,'photos-original_date_time',NULL,1752496154);
/*!40000 ALTER TABLE `oc_files_metadata_index` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_files_reminders`
--

DROP TABLE IF EXISTS `oc_files_reminders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_files_reminders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(64) NOT NULL,
  `file_id` bigint(20) unsigned NOT NULL,
  `due_date` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `notified` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reminders_uniq_idx` (`user_id`,`file_id`,`due_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_files_reminders`
--

LOCK TABLES `oc_files_reminders` WRITE;
/*!40000 ALTER TABLE `oc_files_reminders` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_files_reminders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_files_trash`
--

DROP TABLE IF EXISTS `oc_files_trash`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_files_trash` (
  `auto_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `id` varchar(250) NOT NULL DEFAULT '',
  `user` varchar(64) NOT NULL DEFAULT '',
  `timestamp` varchar(12) NOT NULL DEFAULT '',
  `location` varchar(512) NOT NULL DEFAULT '',
  `type` varchar(4) DEFAULT NULL,
  `mime` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`auto_id`),
  KEY `id_index` (`id`),
  KEY `timestamp_index` (`timestamp`),
  KEY `user_index` (`user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_files_trash`
--

LOCK TABLES `oc_files_trash` WRITE;
/*!40000 ALTER TABLE `oc_files_trash` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_files_trash` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_files_versions`
--

DROP TABLE IF EXISTS `oc_files_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_files_versions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `file_id` bigint(20) NOT NULL,
  `timestamp` bigint(20) NOT NULL,
  `size` bigint(20) NOT NULL,
  `mimetype` bigint(20) NOT NULL,
  `metadata` longtext NOT NULL COMMENT '(DC2Type:json)' CHECK (json_valid(`metadata`)),
  PRIMARY KEY (`id`),
  UNIQUE KEY `files_versions_uniq_index` (`file_id`,`timestamp`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_files_versions`
--

LOCK TABLES `oc_files_versions` WRITE;
/*!40000 ALTER TABLE `oc_files_versions` DISABLE KEYS */;
INSERT INTO `oc_files_versions` VALUES
(1,4,1752496153,593508,4,'[]'),
(2,5,1752496153,457744,4,'[]'),
(3,6,1752496153,2170375,4,'[]'),
(4,7,1752496153,797325,4,'[]'),
(5,8,1752496153,167989,4,'[]'),
(6,9,1752496153,474653,4,'[]'),
(7,10,1752496153,427030,4,'[]'),
(8,11,1752496153,567689,4,'[]'),
(9,12,1752496153,150,6,'[]'),
(10,13,1752496153,50598,7,'[]'),
(11,15,1752496154,1083339,9,'[]'),
(12,16,1752496154,24295,10,'[]'),
(13,17,1752496154,1095,6,'[]'),
(14,18,1752496154,136,6,'[]'),
(15,19,1752496154,976625,9,'[]'),
(16,20,1752496154,3963036,12,'[]'),
(17,22,1752496154,340061,13,'[]'),
(18,23,1752496154,326,6,'[]'),
(19,24,1752496154,52674,14,'[]'),
(20,25,1752496154,14810,15,'[]'),
(21,26,1752496154,3509628,15,'[]'),
(22,27,1752496154,39404,13,'[]'),
(23,28,1752496154,13653,16,'[]'),
(24,29,1752496155,5155877,13,'[]'),
(25,30,1752496155,38605,14,'[]'),
(26,31,1752496155,868111,13,'[]'),
(27,32,1752496155,17276,13,'[]'),
(28,33,1752496155,11836,16,'[]'),
(29,34,1752496155,573,6,'[]'),
(30,35,1752496155,81196,15,'[]'),
(31,36,1752496155,317015,15,'[]'),
(32,37,1752496155,13441,17,'[]'),
(33,38,1752496155,13878,16,'[]'),
(34,39,1752496156,16988,16,'[]'),
(35,40,1752496156,14316,15,'[]'),
(36,41,1752496156,88394,17,'[]'),
(37,42,1752496156,30354,13,'[]'),
(38,43,1752496156,554,6,'[]'),
(39,44,1752496156,52843,17,'[]'),
(40,45,1752496156,13378,17,'[]'),
(41,46,1752496156,15961,13,'[]'),
(42,47,1752496156,206,6,'[]'),
(43,48,1752496156,2403,6,'[]'),
(44,49,1752496156,16600780,9,'[]');
/*!40000 ALTER TABLE `oc_files_versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_flow_checks`
--

DROP TABLE IF EXISTS `oc_flow_checks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_flow_checks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class` varchar(256) NOT NULL DEFAULT '',
  `operator` varchar(16) NOT NULL DEFAULT '',
  `value` longtext DEFAULT NULL,
  `hash` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `flow_unique_hash` (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_flow_checks`
--

LOCK TABLES `oc_flow_checks` WRITE;
/*!40000 ALTER TABLE `oc_flow_checks` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_flow_checks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_flow_operations`
--

DROP TABLE IF EXISTS `oc_flow_operations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_flow_operations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class` varchar(256) NOT NULL DEFAULT '',
  `name` varchar(256) DEFAULT '',
  `checks` longtext DEFAULT NULL,
  `operation` longtext DEFAULT NULL,
  `entity` varchar(256) NOT NULL DEFAULT 'OCA\\WorkflowEngine\\Entity\\File',
  `events` longtext NOT NULL DEFAULT '[]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_flow_operations`
--

LOCK TABLES `oc_flow_operations` WRITE;
/*!40000 ALTER TABLE `oc_flow_operations` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_flow_operations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_flow_operations_scope`
--

DROP TABLE IF EXISTS `oc_flow_operations_scope`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_flow_operations_scope` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `operation_id` int(11) NOT NULL DEFAULT 0,
  `type` int(11) NOT NULL DEFAULT 0,
  `value` varchar(64) DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `flow_unique_scope` (`operation_id`,`type`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_flow_operations_scope`
--

LOCK TABLES `oc_flow_operations_scope` WRITE;
/*!40000 ALTER TABLE `oc_flow_operations_scope` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_flow_operations_scope` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_group_admin`
--

DROP TABLE IF EXISTS `oc_group_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_group_admin` (
  `gid` varchar(64) NOT NULL DEFAULT '',
  `uid` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`gid`,`uid`),
  KEY `group_admin_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_group_admin`
--

LOCK TABLES `oc_group_admin` WRITE;
/*!40000 ALTER TABLE `oc_group_admin` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_group_admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_group_user`
--

DROP TABLE IF EXISTS `oc_group_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_group_user` (
  `gid` varchar(64) NOT NULL DEFAULT '',
  `uid` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`gid`,`uid`),
  KEY `gu_uid_index` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_group_user`
--

LOCK TABLES `oc_group_user` WRITE;
/*!40000 ALTER TABLE `oc_group_user` DISABLE KEYS */;
INSERT INTO `oc_group_user` VALUES
('admin','admin');
/*!40000 ALTER TABLE `oc_group_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_groups`
--

DROP TABLE IF EXISTS `oc_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_groups` (
  `gid` varchar(64) NOT NULL DEFAULT '',
  `displayname` varchar(255) NOT NULL DEFAULT 'name',
  PRIMARY KEY (`gid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_groups`
--

LOCK TABLES `oc_groups` WRITE;
/*!40000 ALTER TABLE `oc_groups` DISABLE KEYS */;
INSERT INTO `oc_groups` VALUES
('admin','admin');
/*!40000 ALTER TABLE `oc_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_jobs`
--

DROP TABLE IF EXISTS `oc_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `class` varchar(255) NOT NULL DEFAULT '',
  `argument` varchar(4000) NOT NULL DEFAULT '',
  `last_run` int(11) DEFAULT 0,
  `last_checked` int(11) DEFAULT 0,
  `reserved_at` int(11) DEFAULT 0,
  `execution_duration` int(11) DEFAULT 0,
  `argument_hash` varchar(64) DEFAULT NULL,
  `time_sensitive` smallint(6) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `job_class_index` (`class`),
  KEY `job_lastcheck_reserved` (`last_checked`,`reserved_at`),
  KEY `job_argument_hash` (`class`,`argument_hash`),
  KEY `jobs_time_sensitive` (`time_sensitive`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_jobs`
--

LOCK TABLES `oc_jobs` WRITE;
/*!40000 ALTER TABLE `oc_jobs` DISABLE KEYS */;
INSERT INTO `oc_jobs` VALUES
(1,'OCA\\Files_Trashbin\\BackgroundJob\\ExpireTrash','null',1752496177,1752496177,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),
(2,'OCA\\Circles\\Cron\\Maintenance','null',1752496197,1752496197,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),
(3,'OCA\\UpdateNotification\\Notification\\BackgroundJob','null',1752496215,1752496215,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),
(4,'OCA\\Activity\\BackgroundJob\\EmailNotification','null',1752496219,1752496219,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),
(5,'OCA\\Activity\\BackgroundJob\\ExpireActivities','null',1752496415,1752496415,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),
(6,'OCA\\Activity\\BackgroundJob\\DigestMail','null',1752496539,1752496539,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),
(7,'OCA\\Files\\BackgroundJob\\ScanFiles','null',1752633878,1752633878,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),
(8,'OCA\\Files\\BackgroundJob\\DeleteOrphanedItems','null',1752633886,1752633886,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),
(9,'OCA\\Files\\BackgroundJob\\CleanupFileLocks','null',1752633895,1752633895,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),
(10,'OCA\\Files\\BackgroundJob\\CleanupDirectEditingTokens','null',1752633900,1752633900,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),
(11,'OCA\\Files\\BackgroundJob\\DeleteExpiredOpenLocalEditor','null',1752634640,1752634640,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),
(12,'OCA\\Support\\BackgroundJobs\\CheckSubscription','null',1752634643,1752634643,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),
(13,'OCA\\ContactsInteraction\\BackgroundJob\\CleanupJob','null',0,1752496148,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),
(14,'OCA\\WorkflowEngine\\BackgroundJobs\\Rotate','null',0,1752496148,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),
(15,'OCA\\Text\\Cron\\Cleanup','null',0,1752496149,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),
(16,'OCA\\ServerInfo\\Jobs\\UpdateStorageStats','null',0,1752496149,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),
(17,'OCA\\NextcloudAnnouncements\\Cron\\Crawler','null',0,1752496149,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),
(18,'OCA\\Photos\\Jobs\\AutomaticPlaceMapperJob','null',0,1752496149,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),
(19,'OCA\\UserStatus\\BackgroundJob\\ClearOldStatusesBackgroundJob','null',0,1752496149,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),
(20,'OCA\\Notifications\\BackgroundJob\\GenerateUserSettings','null',0,1752496149,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),
(21,'OCA\\Notifications\\BackgroundJob\\SendNotificationMails','null',0,1752496149,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),
(22,'OCA\\Files_Sharing\\DeleteOrphanedSharesJob','null',0,1752496150,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),
(23,'OCA\\Files_Sharing\\ExpireSharesJob','null',0,1752496150,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),
(24,'OCA\\Files_Sharing\\BackgroundJob\\FederatedSharesDiscoverJob','null',0,1752496150,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),
(25,'OCA\\Federation\\SyncJob','null',0,1752496150,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),
(26,'OCA\\FilesReminders\\BackgroundJob\\CleanUpReminders','null',0,1752496150,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),
(27,'OCA\\FilesReminders\\BackgroundJob\\ScheduledNotifications','null',0,1752496150,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),
(28,'OCA\\OAuth2\\BackgroundJob\\CleanupExpiredAuthorizationCode','null',0,1752496150,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),
(29,'OCA\\DAV\\BackgroundJob\\CleanupDirectLinksJob','null',0,1752496151,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),
(30,'OCA\\DAV\\BackgroundJob\\UpdateCalendarResourcesRoomsBackgroundJob','null',0,1752496151,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),
(31,'OCA\\DAV\\BackgroundJob\\CleanupInvitationTokenJob','null',0,1752496151,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),
(32,'OCA\\DAV\\BackgroundJob\\EventReminderJob','null',0,1752496151,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),
(33,'OCA\\DAV\\BackgroundJob\\CalendarRetentionJob','null',0,1752496151,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),
(34,'OCA\\DAV\\BackgroundJob\\PruneOutdatedSyncTokensJob','null',0,1752496151,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),
(35,'OCA\\Files_Versions\\BackgroundJob\\ExpireVersions','null',0,1752496152,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),
(36,'OC\\Authentication\\Token\\TokenCleanupJob','null',0,1752496152,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),
(37,'OC\\Log\\Rotate','null',0,1752496152,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),
(38,'OC\\Preview\\BackgroundCleanupJob','null',0,1752496152,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),
(39,'OC\\TextProcessing\\RemoveOldTasksBackgroundJob','null',0,1752496152,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),
(40,'OC\\User\\BackgroundJobs\\CleanupDeletedUsers','null',0,1752496152,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),
(41,'OC\\FilesMetadata\\Job\\UpdateSingleMetadata','[\"admin\",4]',0,1752496153,0,0,'4956793059d80398b3d78ea2215ebb860a2e0c724aefa0ce04b1a8bbb5a70f46',1),
(42,'OC\\FilesMetadata\\Job\\UpdateSingleMetadata','[\"admin\",5]',0,1752496153,0,0,'bab5ba2238ecad63141db6c5f1608efc3b0efecc909f4f8d8e111e0d5c23edad',1),
(43,'OC\\FilesMetadata\\Job\\UpdateSingleMetadata','[\"admin\",6]',0,1752496153,0,0,'0d840fcf4d96c36eb80b922e14ca2b7aa5acaba8f61b45e2d8bd832199fe8c9d',1),
(44,'OC\\FilesMetadata\\Job\\UpdateSingleMetadata','[\"admin\",7]',0,1752496153,0,0,'5889fec72259069bfcddd1167dbbf1c854234eb06614dd8fd894eff7956192a7',1),
(45,'OC\\FilesMetadata\\Job\\UpdateSingleMetadata','[\"admin\",8]',0,1752496153,0,0,'075228ca5e1ab3f24fd39c1402e41a206a4afd78fc71b52f0021faaa6121c260',1),
(46,'OC\\FilesMetadata\\Job\\UpdateSingleMetadata','[\"admin\",9]',0,1752496153,0,0,'6aeb888c4dfdca1c745d4f2367a7386cf490285b3d961db0382c594a54c400a0',1),
(47,'OC\\FilesMetadata\\Job\\UpdateSingleMetadata','[\"admin\",10]',0,1752496153,0,0,'9e79a1d0a821264f3aa6269c1d3dba0f52274f57ff2819cc5c70f60300c2ec6c',1),
(48,'OC\\FilesMetadata\\Job\\UpdateSingleMetadata','[\"admin\",11]',0,1752496153,0,0,'32ea4cc1f86ec7aba234f815b18136b6eab27615e67f71a4f752e863214b3b22',1),
(49,'OC\\FilesMetadata\\Job\\UpdateSingleMetadata','[\"admin\",13]',0,1752496153,0,0,'05b302cbd33b86157c9981f8eb4ab72466e203421a1a8d2b9d504b7ec7e17ea7',1),
(50,'OCA\\FirstRunWizard\\Notification\\BackgroundJob','{\"uid\":\"admin\"}',0,1752496194,0,0,'70071f2985a39d9762e53229dd5125d134cd7601939c1a4d69cd99aa90057e8a',1);
/*!40000 ALTER TABLE `oc_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_known_users`
--

DROP TABLE IF EXISTS `oc_known_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_known_users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `known_to` varchar(255) NOT NULL,
  `known_user` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ku_known_to` (`known_to`),
  KEY `ku_known_user` (`known_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_known_users`
--

LOCK TABLES `oc_known_users` WRITE;
/*!40000 ALTER TABLE `oc_known_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_known_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_login_flow_v2`
--

DROP TABLE IF EXISTS `oc_login_flow_v2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_login_flow_v2` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `timestamp` bigint(20) unsigned NOT NULL,
  `started` smallint(5) unsigned NOT NULL DEFAULT 0,
  `poll_token` varchar(255) NOT NULL,
  `login_token` varchar(255) NOT NULL,
  `public_key` text NOT NULL,
  `private_key` text NOT NULL,
  `client_name` varchar(255) NOT NULL,
  `login_name` varchar(255) DEFAULT NULL,
  `server` varchar(255) DEFAULT NULL,
  `app_password` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `poll_token` (`poll_token`),
  UNIQUE KEY `login_token` (`login_token`),
  KEY `timestamp` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_login_flow_v2`
--

LOCK TABLES `oc_login_flow_v2` WRITE;
/*!40000 ALTER TABLE `oc_login_flow_v2` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_login_flow_v2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_migrations`
--

DROP TABLE IF EXISTS `oc_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_migrations` (
  `app` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  PRIMARY KEY (`app`,`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_migrations`
--

LOCK TABLES `oc_migrations` WRITE;
/*!40000 ALTER TABLE `oc_migrations` DISABLE KEYS */;
INSERT INTO `oc_migrations` VALUES
('activity','2006Date20170808154933'),
('activity','2006Date20170808155040'),
('activity','2006Date20170919095939'),
('activity','2007Date20181107114613'),
('activity','2008Date20181011095117'),
('activity','2010Date20190416112817'),
('activity','2011Date20201006132544'),
('activity','2011Date20201006132545'),
('activity','2011Date20201006132546'),
('activity','2011Date20201006132547'),
('activity','2011Date20201207091915'),
('circles','0022Date20220526111723'),
('circles','0022Date20220526113601'),
('circles','0022Date20220703115023'),
('circles','0023Date20211216113101'),
('circles','0024Date20220203123901'),
('circles','0024Date20220203123902'),
('circles','0024Date20220317190331'),
('circles','0028Date20230705222601'),
('contactsinteraction','010000Date20200304152605'),
('core','13000Date20170705121758'),
('core','13000Date20170718121200'),
('core','13000Date20170814074715'),
('core','13000Date20170919121250'),
('core','13000Date20170926101637'),
('core','14000Date20180129121024'),
('core','14000Date20180404140050'),
('core','14000Date20180516101403'),
('core','14000Date20180518120534'),
('core','14000Date20180522074438'),
('core','14000Date20180626223656'),
('core','14000Date20180710092004'),
('core','14000Date20180712153140'),
('core','15000Date20180926101451'),
('core','15000Date20181015062942'),
('core','15000Date20181029084625'),
('core','16000Date20190207141427'),
('core','16000Date20190212081545'),
('core','16000Date20190427105638'),
('core','16000Date20190428150708'),
('core','17000Date20190514105811'),
('core','18000Date20190920085628'),
('core','18000Date20191014105105'),
('core','18000Date20191204114856'),
('core','19000Date20200211083441'),
('core','20000Date20201109081915'),
('core','20000Date20201109081918'),
('core','20000Date20201109081919'),
('core','20000Date20201111081915'),
('core','21000Date20201120141228'),
('core','21000Date20201202095923'),
('core','21000Date20210119195004'),
('core','21000Date20210309185126'),
('core','21000Date20210309185127'),
('core','22000Date20210216080825'),
('core','23000Date20210721100600'),
('core','23000Date20210906132259'),
('core','23000Date20210930122352'),
('core','23000Date20211203110726'),
('core','23000Date20211213203940'),
('core','24000Date20211210141942'),
('core','24000Date20211213081506'),
('core','24000Date20211213081604'),
('core','24000Date20211222112246'),
('core','24000Date20211230140012'),
('core','24000Date20220131153041'),
('core','24000Date20220202150027'),
('core','24000Date20220404230027'),
('core','24000Date20220425072957'),
('core','25000Date20220515204012'),
('core','25000Date20220602190540'),
('core','25000Date20220905140840'),
('core','25000Date20221007010957'),
('core','27000Date20220613163520'),
('core','27000Date20230309104325'),
('core','27000Date20230309104802'),
('core','28000Date20230616104802'),
('core','28000Date20230728104802'),
('core','28000Date20230803221055'),
('core','28000Date20230906104802'),
('core','28000Date20231004103301'),
('core','28000Date20231103104802'),
('core','28000Date20231126110901'),
('core','28000Date20240828142927'),
('core','30000Date20240814180800'),
('dav','1004Date20170825134824'),
('dav','1004Date20170919104507'),
('dav','1004Date20170924124212'),
('dav','1004Date20170926103422'),
('dav','1005Date20180413093149'),
('dav','1005Date20180530124431'),
('dav','1006Date20180619154313'),
('dav','1006Date20180628111625'),
('dav','1008Date20181030113700'),
('dav','1008Date20181105104826'),
('dav','1008Date20181105104833'),
('dav','1008Date20181105110300'),
('dav','1008Date20181105112049'),
('dav','1008Date20181114084440'),
('dav','1011Date20190725113607'),
('dav','1011Date20190806104428'),
('dav','1012Date20190808122342'),
('dav','1016Date20201109085907'),
('dav','1017Date20210216083742'),
('dav','1018Date20210312100735'),
('dav','1024Date20211221144219'),
('dav','1025Date20240308063933'),
('dav','1027Date20230504122946'),
('dav','1029Date20221114151721'),
('dav','1029Date20231004091403'),
('federatedfilesharing','1010Date20200630191755'),
('federatedfilesharing','1011Date20201120125158'),
('federation','1010Date20200630191302'),
('files','11301Date20191205150729'),
('files','12101Date20221011153334'),
('files_reminders','10000Date20230725162149'),
('files_sharing','11300Date20201120141438'),
('files_sharing','21000Date20201223143245'),
('files_sharing','22000Date20210216084241'),
('files_sharing','24000Date20220208195521'),
('files_sharing','24000Date20220404142216'),
('files_trashbin','1010Date20200630192639'),
('files_versions','1020Date20221114144058'),
('notifications','2004Date20190107135757'),
('notifications','2010Date20210218082811'),
('notifications','2010Date20210218082855'),
('notifications','2011Date20210930134607'),
('notifications','2011Date20220826074907'),
('oauth2','010401Date20181207190718'),
('oauth2','010402Date20190107124745'),
('oauth2','011601Date20230522143227'),
('oauth2','011602Date20230613160650'),
('oauth2','011603Date20230620111039'),
('oauth2','011901Date20240829164356'),
('photos','20000Date20220727125801'),
('photos','20001Date20220830131446'),
('photos','20003Date20221102170153'),
('photos','20003Date20221103094628'),
('privacy','100Date20190217131943'),
('text','010000Date20190617184535'),
('text','030001Date20200402075029'),
('text','030201Date20201116110353'),
('text','030201Date20201116123153'),
('text','030501Date20220202101853'),
('text','030701Date20230207131313'),
('text','030901Date20231114150437'),
('twofactor_backupcodes','1002Date20170607104347'),
('twofactor_backupcodes','1002Date20170607113030'),
('twofactor_backupcodes','1002Date20170919123342'),
('twofactor_backupcodes','1002Date20170926101419'),
('twofactor_backupcodes','1002Date20180821043638'),
('user_status','0001Date20200602134824'),
('user_status','0002Date20200902144824'),
('user_status','1000Date20201111130204'),
('user_status','1003Date20210809144824'),
('user_status','1008Date20230921144701'),
('workflowengine','2000Date20190808074233'),
('workflowengine','2200Date20210805101925');
/*!40000 ALTER TABLE `oc_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_mimetypes`
--

DROP TABLE IF EXISTS `oc_mimetypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_mimetypes` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mimetype` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mimetype_id_index` (`mimetype`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_mimetypes`
--

LOCK TABLES `oc_mimetypes` WRITE;
/*!40000 ALTER TABLE `oc_mimetypes` DISABLE KEYS */;
INSERT INTO `oc_mimetypes` VALUES
(8,'application'),
(20,'application/gzip'),
(18,'application/javascript'),
(21,'application/json'),
(19,'application/octet-stream'),
(9,'application/pdf'),
(14,'application/vnd.excalidraw+json'),
(16,'application/vnd.oasis.opendocument.graphics'),
(15,'application/vnd.oasis.opendocument.presentation'),
(17,'application/vnd.oasis.opendocument.spreadsheet'),
(13,'application/vnd.oasis.opendocument.text'),
(10,'application/vnd.openxmlformats-officedocument.wordprocessingml.document'),
(1,'httpd'),
(2,'httpd/unix-directory'),
(3,'image'),
(4,'image/jpeg'),
(7,'image/png'),
(22,'image/svg+xml'),
(5,'text'),
(6,'text/markdown'),
(11,'video'),
(12,'video/mp4');
/*!40000 ALTER TABLE `oc_mimetypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_mounts`
--

DROP TABLE IF EXISTS `oc_mounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_mounts` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `storage_id` bigint(20) NOT NULL,
  `root_id` bigint(20) NOT NULL,
  `user_id` varchar(64) NOT NULL,
  `mount_point` varchar(4000) NOT NULL,
  `mount_id` bigint(20) DEFAULT NULL,
  `mount_provider_class` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mounts_storage_index` (`storage_id`),
  KEY `mounts_root_index` (`root_id`),
  KEY `mounts_mount_id_index` (`mount_id`),
  KEY `mounts_user_root_path_index` (`user_id`,`root_id`,`mount_point`(128)),
  KEY `mounts_class_index` (`mount_provider_class`),
  KEY `mount_user_storage` (`storage_id`,`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_mounts`
--

LOCK TABLES `oc_mounts` WRITE;
/*!40000 ALTER TABLE `oc_mounts` DISABLE KEYS */;
INSERT INTO `oc_mounts` VALUES
(1,1,1,'admin','/admin/',NULL,'OC\\Files\\Mount\\LocalHomeMountProvider');
/*!40000 ALTER TABLE `oc_mounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_notifications`
--

DROP TABLE IF EXISTS `oc_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_notifications` (
  `notification_id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(32) NOT NULL,
  `user` varchar(64) NOT NULL,
  `timestamp` int(11) NOT NULL DEFAULT 0,
  `object_type` varchar(64) NOT NULL,
  `object_id` varchar(64) NOT NULL,
  `subject` varchar(64) NOT NULL,
  `subject_parameters` longtext DEFAULT NULL,
  `message` varchar(64) DEFAULT NULL,
  `message_parameters` longtext DEFAULT NULL,
  `link` varchar(4000) DEFAULT NULL,
  `icon` varchar(4000) DEFAULT NULL,
  `actions` longtext DEFAULT NULL,
  PRIMARY KEY (`notification_id`),
  KEY `oc_notifications_app` (`app`),
  KEY `oc_notifications_user` (`user`),
  KEY `oc_notifications_timestamp` (`timestamp`),
  KEY `oc_notifications_object` (`object_type`,`object_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_notifications`
--

LOCK TABLES `oc_notifications` WRITE;
/*!40000 ALTER TABLE `oc_notifications` DISABLE KEYS */;
INSERT INTO `oc_notifications` VALUES
(1,'firstrunwizard','admin',1752496194,'app','recognize','apphint-recognize','[]','','[]','','','[]'),
(2,'firstrunwizard','admin',1752496194,'app','groupfolders','apphint-groupfolders','[]','','[]','','','[]'),
(3,'firstrunwizard','admin',1752496194,'app','forms','apphint-forms','[]','','[]','','','[]'),
(4,'firstrunwizard','admin',1752496194,'app','deck','apphint-deck','[]','','[]','','','[]'),
(5,'firstrunwizard','admin',1752496194,'app','tasks','apphint-tasks','[]','','[]','','','[]');
/*!40000 ALTER TABLE `oc_notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_notifications_pushhash`
--

DROP TABLE IF EXISTS `oc_notifications_pushhash`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_notifications_pushhash` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(64) NOT NULL,
  `token` int(11) NOT NULL DEFAULT 0,
  `deviceidentifier` varchar(128) NOT NULL,
  `devicepublickey` varchar(512) NOT NULL,
  `devicepublickeyhash` varchar(128) NOT NULL,
  `pushtokenhash` varchar(128) NOT NULL,
  `proxyserver` varchar(256) NOT NULL,
  `apptype` varchar(32) NOT NULL DEFAULT 'unknown',
  PRIMARY KEY (`id`),
  UNIQUE KEY `oc_npushhash_uid` (`uid`,`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_notifications_pushhash`
--

LOCK TABLES `oc_notifications_pushhash` WRITE;
/*!40000 ALTER TABLE `oc_notifications_pushhash` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_notifications_pushhash` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_notifications_settings`
--

DROP TABLE IF EXISTS `oc_notifications_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_notifications_settings` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(64) NOT NULL,
  `batch_time` int(11) NOT NULL DEFAULT 0,
  `last_send_id` bigint(20) NOT NULL DEFAULT 0,
  `next_send_time` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `notset_user` (`user_id`),
  KEY `notset_nextsend` (`next_send_time`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_notifications_settings`
--

LOCK TABLES `oc_notifications_settings` WRITE;
/*!40000 ALTER TABLE `oc_notifications_settings` DISABLE KEYS */;
INSERT INTO `oc_notifications_settings` VALUES
(1,'admin',0,0,0);
/*!40000 ALTER TABLE `oc_notifications_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_oauth2_access_tokens`
--

DROP TABLE IF EXISTS `oc_oauth2_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_oauth2_access_tokens` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `token_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `hashed_code` varchar(128) NOT NULL,
  `encrypted_token` varchar(786) NOT NULL,
  `code_created_at` bigint(20) unsigned NOT NULL DEFAULT 0,
  `token_count` bigint(20) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `oauth2_access_hash_idx` (`hashed_code`),
  KEY `oauth2_access_client_id_idx` (`client_id`),
  KEY `oauth2_tk_c_created_idx` (`token_count`,`code_created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_oauth2_access_tokens`
--

LOCK TABLES `oc_oauth2_access_tokens` WRITE;
/*!40000 ALTER TABLE `oc_oauth2_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_oauth2_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_oauth2_clients`
--

DROP TABLE IF EXISTS `oc_oauth2_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_oauth2_clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `redirect_uri` varchar(2000) NOT NULL,
  `client_identifier` varchar(64) NOT NULL,
  `secret` varchar(512) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `oauth2_client_id_idx` (`client_identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_oauth2_clients`
--

LOCK TABLES `oc_oauth2_clients` WRITE;
/*!40000 ALTER TABLE `oc_oauth2_clients` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_oauth2_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_open_local_editor`
--

DROP TABLE IF EXISTS `oc_open_local_editor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_open_local_editor` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(64) NOT NULL,
  `path_hash` varchar(64) NOT NULL,
  `expiration_time` bigint(20) unsigned NOT NULL,
  `token` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `openlocal_user_path_token` (`user_id`,`path_hash`,`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_open_local_editor`
--

LOCK TABLES `oc_open_local_editor` WRITE;
/*!40000 ALTER TABLE `oc_open_local_editor` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_open_local_editor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_photos_albums`
--

DROP TABLE IF EXISTS `oc_photos_albums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_photos_albums` (
  `album_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `user` varchar(255) NOT NULL,
  `created` bigint(20) NOT NULL,
  `location` varchar(255) NOT NULL,
  `last_added_photo` bigint(20) NOT NULL,
  PRIMARY KEY (`album_id`),
  KEY `pa_user` (`user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_photos_albums`
--

LOCK TABLES `oc_photos_albums` WRITE;
/*!40000 ALTER TABLE `oc_photos_albums` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_photos_albums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_photos_albums_collabs`
--

DROP TABLE IF EXISTS `oc_photos_albums_collabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_photos_albums_collabs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `album_id` bigint(20) NOT NULL,
  `collaborator_id` varchar(64) NOT NULL,
  `collaborator_type` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `album_collabs_uniq_collab` (`album_id`,`collaborator_id`,`collaborator_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_photos_albums_collabs`
--

LOCK TABLES `oc_photos_albums_collabs` WRITE;
/*!40000 ALTER TABLE `oc_photos_albums_collabs` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_photos_albums_collabs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_photos_albums_files`
--

DROP TABLE IF EXISTS `oc_photos_albums_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_photos_albums_files` (
  `album_file_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `album_id` bigint(20) NOT NULL,
  `file_id` bigint(20) NOT NULL,
  `added` bigint(20) NOT NULL,
  `owner` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`album_file_id`),
  UNIQUE KEY `paf_album_file` (`album_id`,`file_id`),
  KEY `paf_folder` (`album_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_photos_albums_files`
--

LOCK TABLES `oc_photos_albums_files` WRITE;
/*!40000 ALTER TABLE `oc_photos_albums_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_photos_albums_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_preferences`
--

DROP TABLE IF EXISTS `oc_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_preferences` (
  `userid` varchar(64) NOT NULL DEFAULT '',
  `appid` varchar(32) NOT NULL DEFAULT '',
  `configkey` varchar(64) NOT NULL DEFAULT '',
  `configvalue` longtext DEFAULT NULL,
  PRIMARY KEY (`userid`,`appid`,`configkey`),
  KEY `preferences_app_key` (`appid`,`configkey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_preferences`
--

LOCK TABLES `oc_preferences` WRITE;
/*!40000 ALTER TABLE `oc_preferences` DISABLE KEYS */;
INSERT INTO `oc_preferences` VALUES
('admin','activity','configured','yes'),
('admin','avatar','generated','true'),
('admin','core','lang','en'),
('admin','core','templateDirectory','Templates/'),
('admin','dashboard','firstRun','0'),
('admin','firstrunwizard','apphint','18'),
('admin','firstrunwizard','show','0'),
('admin','login','lastLogin','1752496152'),
('admin','notifications','sound_notification','no'),
('admin','notifications','sound_talk','no'),
('admin','password_policy','failedLoginAttempts','0');
/*!40000 ALTER TABLE `oc_preferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_privacy_admins`
--

DROP TABLE IF EXISTS `oc_privacy_admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_privacy_admins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `displayname` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_privacy_admins`
--

LOCK TABLES `oc_privacy_admins` WRITE;
/*!40000 ALTER TABLE `oc_privacy_admins` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_privacy_admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_profile_config`
--

DROP TABLE IF EXISTS `oc_profile_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_profile_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(64) NOT NULL,
  `config` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `profile_config_user_id_idx` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_profile_config`
--

LOCK TABLES `oc_profile_config` WRITE;
/*!40000 ALTER TABLE `oc_profile_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_profile_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_properties`
--

DROP TABLE IF EXISTS `oc_properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_properties` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userid` varchar(64) NOT NULL DEFAULT '',
  `propertypath` varchar(255) NOT NULL DEFAULT '',
  `propertyname` varchar(255) NOT NULL DEFAULT '',
  `propertyvalue` longtext NOT NULL,
  `valuetype` smallint(6) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `property_index` (`userid`),
  KEY `properties_path_index` (`userid`,`propertypath`),
  KEY `properties_pathonly_index` (`propertypath`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_properties`
--

LOCK TABLES `oc_properties` WRITE;
/*!40000 ALTER TABLE `oc_properties` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_ratelimit_entries`
--

DROP TABLE IF EXISTS `oc_ratelimit_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_ratelimit_entries` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `hash` varchar(128) NOT NULL,
  `delete_after` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ratelimit_hash` (`hash`),
  KEY `ratelimit_delete_after` (`delete_after`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_ratelimit_entries`
--

LOCK TABLES `oc_ratelimit_entries` WRITE;
/*!40000 ALTER TABLE `oc_ratelimit_entries` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_ratelimit_entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_reactions`
--

DROP TABLE IF EXISTS `oc_reactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_reactions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) unsigned NOT NULL,
  `message_id` bigint(20) unsigned NOT NULL,
  `actor_type` varchar(64) NOT NULL DEFAULT '',
  `actor_id` varchar(64) NOT NULL DEFAULT '',
  `reaction` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `comment_reaction_unique` (`parent_id`,`actor_type`,`actor_id`,`reaction`),
  KEY `comment_reaction` (`reaction`),
  KEY `comment_reaction_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_reactions`
--

LOCK TABLES `oc_reactions` WRITE;
/*!40000 ALTER TABLE `oc_reactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_reactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_recent_contact`
--

DROP TABLE IF EXISTS `oc_recent_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_recent_contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `actor_uid` varchar(64) NOT NULL,
  `uid` varchar(64) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `federated_cloud_id` varchar(255) DEFAULT NULL,
  `card` longblob NOT NULL,
  `last_contact` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `recent_contact_actor_uid` (`actor_uid`),
  KEY `recent_contact_id_uid` (`id`,`actor_uid`),
  KEY `recent_contact_uid` (`uid`),
  KEY `recent_contact_email` (`email`),
  KEY `recent_contact_fed_id` (`federated_cloud_id`),
  KEY `recent_contact_last_contact` (`last_contact`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_recent_contact`
--

LOCK TABLES `oc_recent_contact` WRITE;
/*!40000 ALTER TABLE `oc_recent_contact` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_recent_contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_schedulingobjects`
--

DROP TABLE IF EXISTS `oc_schedulingobjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_schedulingobjects` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `principaluri` varchar(255) DEFAULT NULL,
  `calendardata` longblob DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `lastmodified` int(10) unsigned DEFAULT NULL,
  `etag` varchar(32) DEFAULT NULL,
  `size` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `schedulobj_principuri_index` (`principaluri`),
  KEY `schedulobj_lastmodified_idx` (`lastmodified`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_schedulingobjects`
--

LOCK TABLES `oc_schedulingobjects` WRITE;
/*!40000 ALTER TABLE `oc_schedulingobjects` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_schedulingobjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_share`
--

DROP TABLE IF EXISTS `oc_share`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_share` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `share_type` smallint(6) NOT NULL DEFAULT 0,
  `share_with` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `uid_owner` varchar(64) NOT NULL DEFAULT '',
  `uid_initiator` varchar(64) DEFAULT NULL,
  `parent` bigint(20) DEFAULT NULL,
  `item_type` varchar(64) NOT NULL DEFAULT '',
  `item_source` varchar(255) DEFAULT NULL,
  `item_target` varchar(255) DEFAULT NULL,
  `file_source` bigint(20) DEFAULT NULL,
  `file_target` varchar(512) DEFAULT NULL,
  `permissions` smallint(6) NOT NULL DEFAULT 0,
  `stime` bigint(20) NOT NULL DEFAULT 0,
  `accepted` smallint(6) NOT NULL DEFAULT 0,
  `expiration` datetime DEFAULT NULL,
  `token` varchar(32) DEFAULT NULL,
  `mail_send` smallint(6) NOT NULL DEFAULT 0,
  `share_name` varchar(64) DEFAULT NULL,
  `password_by_talk` tinyint(1) DEFAULT 0,
  `note` longtext DEFAULT NULL,
  `hide_download` smallint(6) DEFAULT 0,
  `label` varchar(255) DEFAULT NULL,
  `attributes` longtext DEFAULT NULL COMMENT '(DC2Type:json)' CHECK (json_valid(`attributes`)),
  `password_expiration_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `item_share_type_index` (`item_type`,`share_type`),
  KEY `file_source_index` (`file_source`),
  KEY `token_index` (`token`),
  KEY `share_with_index` (`share_with`),
  KEY `parent_index` (`parent`),
  KEY `owner_index` (`uid_owner`),
  KEY `initiator_index` (`uid_initiator`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_share`
--

LOCK TABLES `oc_share` WRITE;
/*!40000 ALTER TABLE `oc_share` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_share` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_share_external`
--

DROP TABLE IF EXISTS `oc_share_external`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_share_external` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent` bigint(20) DEFAULT -1,
  `share_type` int(11) DEFAULT NULL,
  `remote` varchar(512) NOT NULL,
  `remote_id` varchar(255) DEFAULT '',
  `share_token` varchar(64) NOT NULL,
  `password` varchar(64) DEFAULT NULL,
  `name` varchar(4000) NOT NULL,
  `owner` varchar(64) NOT NULL,
  `user` varchar(64) NOT NULL,
  `mountpoint` varchar(4000) NOT NULL,
  `mountpoint_hash` varchar(32) NOT NULL,
  `accepted` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sh_external_mp` (`user`,`mountpoint_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_share_external`
--

LOCK TABLES `oc_share_external` WRITE;
/*!40000 ALTER TABLE `oc_share_external` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_share_external` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_storages`
--

DROP TABLE IF EXISTS `oc_storages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_storages` (
  `numeric_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `id` varchar(64) DEFAULT NULL,
  `available` int(11) NOT NULL DEFAULT 1,
  `last_checked` int(11) DEFAULT NULL,
  PRIMARY KEY (`numeric_id`),
  UNIQUE KEY `storages_id_index` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_storages`
--

LOCK TABLES `oc_storages` WRITE;
/*!40000 ALTER TABLE `oc_storages` DISABLE KEYS */;
INSERT INTO `oc_storages` VALUES
(1,'home::admin',1,NULL),
(2,'local::/var/www/PStorage.ntuee.temp/data/',1,NULL);
/*!40000 ALTER TABLE `oc_storages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_storages_credentials`
--

DROP TABLE IF EXISTS `oc_storages_credentials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_storages_credentials` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user` varchar(64) DEFAULT NULL,
  `identifier` varchar(64) NOT NULL,
  `credentials` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `stocred_ui` (`user`,`identifier`),
  KEY `stocred_user` (`user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_storages_credentials`
--

LOCK TABLES `oc_storages_credentials` WRITE;
/*!40000 ALTER TABLE `oc_storages_credentials` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_storages_credentials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_systemtag`
--

DROP TABLE IF EXISTS `oc_systemtag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_systemtag` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL DEFAULT '',
  `visibility` smallint(6) NOT NULL DEFAULT 1,
  `editable` smallint(6) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tag_ident` (`name`,`visibility`,`editable`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_systemtag`
--

LOCK TABLES `oc_systemtag` WRITE;
/*!40000 ALTER TABLE `oc_systemtag` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_systemtag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_systemtag_group`
--

DROP TABLE IF EXISTS `oc_systemtag_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_systemtag_group` (
  `systemtagid` bigint(20) unsigned NOT NULL DEFAULT 0,
  `gid` varchar(255) NOT NULL,
  PRIMARY KEY (`gid`,`systemtagid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_systemtag_group`
--

LOCK TABLES `oc_systemtag_group` WRITE;
/*!40000 ALTER TABLE `oc_systemtag_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_systemtag_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_systemtag_object_mapping`
--

DROP TABLE IF EXISTS `oc_systemtag_object_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_systemtag_object_mapping` (
  `objectid` varchar(64) NOT NULL DEFAULT '',
  `objecttype` varchar(64) NOT NULL DEFAULT '',
  `systemtagid` bigint(20) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`objecttype`,`objectid`,`systemtagid`),
  KEY `systag_by_tagid` (`systemtagid`,`objecttype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_systemtag_object_mapping`
--

LOCK TABLES `oc_systemtag_object_mapping` WRITE;
/*!40000 ALTER TABLE `oc_systemtag_object_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_systemtag_object_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_text2image_tasks`
--

DROP TABLE IF EXISTS `oc_text2image_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_text2image_tasks` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `input` longtext NOT NULL,
  `status` int(11) DEFAULT 0,
  `number_of_images` int(11) NOT NULL DEFAULT 1,
  `user_id` varchar(64) DEFAULT NULL,
  `app_id` varchar(32) NOT NULL DEFAULT '',
  `identifier` varchar(255) DEFAULT '',
  `last_updated` datetime DEFAULT NULL,
  `completion_expected_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `t2i_tasks_updated` (`last_updated`),
  KEY `t2i_tasks_status` (`status`),
  KEY `t2i_tasks_uid_appid_ident` (`user_id`,`app_id`,`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_text2image_tasks`
--

LOCK TABLES `oc_text2image_tasks` WRITE;
/*!40000 ALTER TABLE `oc_text2image_tasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_text2image_tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_text_documents`
--

DROP TABLE IF EXISTS `oc_text_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_text_documents` (
  `id` bigint(20) unsigned NOT NULL,
  `current_version` bigint(20) unsigned DEFAULT 0,
  `last_saved_version` bigint(20) unsigned DEFAULT 0,
  `last_saved_version_time` bigint(20) unsigned NOT NULL,
  `last_saved_version_etag` varchar(64) DEFAULT '',
  `base_version_etag` varchar(64) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_text_documents`
--

LOCK TABLES `oc_text_documents` WRITE;
/*!40000 ALTER TABLE `oc_text_documents` DISABLE KEYS */;
INSERT INTO `oc_text_documents` VALUES
(47,0,0,1752496156,'076da18b7fb7961253519ff7641ea3ea','6874f99ddc939');
/*!40000 ALTER TABLE `oc_text_documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_text_sessions`
--

DROP TABLE IF EXISTS `oc_text_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_text_sessions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(64) DEFAULT NULL,
  `guest_name` varchar(64) DEFAULT NULL,
  `color` varchar(7) DEFAULT NULL,
  `token` varchar(64) NOT NULL,
  `document_id` bigint(20) NOT NULL,
  `last_contact` bigint(20) unsigned NOT NULL,
  `last_awareness_message` longtext DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `rd_session_token_idx` (`token`),
  KEY `ts_lastcontact` (`last_contact`),
  KEY `ts_docid_lastcontact` (`document_id`,`last_contact`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_text_sessions`
--

LOCK TABLES `oc_text_sessions` WRITE;
/*!40000 ALTER TABLE `oc_text_sessions` DISABLE KEYS */;
INSERT INTO `oc_text_sessions` VALUES
(3,'admin',NULL,'#d09e6d','6LA29V/omhJT0rCPsCpayUnO3GDuoOVeo+X7jGoYJl3XFKzD03BMsD2f5t22orf4',47,1752640835,'AWIBl6+86Qa4AVl7InVzZXIiOnsibmFtZSI6ImFkbWluIiwiY2xpZW50SWQiOjE4MzE4MDI3NzUsImNvbG9yIjoiI2QwOWU2ZCIsImxhc3RVcGRhdGUiOjE3NTI2MzQ2NDR9fQ==');
/*!40000 ALTER TABLE `oc_text_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_text_steps`
--

DROP TABLE IF EXISTS `oc_text_steps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_text_steps` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `document_id` bigint(20) unsigned NOT NULL,
  `session_id` bigint(20) unsigned NOT NULL,
  `data` longtext NOT NULL,
  `version` bigint(20) unsigned DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `rd_steps_did_idx` (`document_id`),
  KEY `rd_steps_version_idx` (`version`),
  KEY `textstep_session` (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_text_steps`
--

LOCK TABLES `oc_text_steps` WRITE;
/*!40000 ALTER TABLE `oc_text_steps` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_text_steps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_textprocessing_tasks`
--

DROP TABLE IF EXISTS `oc_textprocessing_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_textprocessing_tasks` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `input` longtext NOT NULL,
  `output` longtext DEFAULT NULL,
  `status` int(11) DEFAULT 0,
  `user_id` varchar(64) DEFAULT NULL,
  `app_id` varchar(32) NOT NULL DEFAULT '',
  `identifier` varchar(255) NOT NULL DEFAULT '',
  `last_updated` int(10) unsigned DEFAULT 0,
  `completion_expected_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tp_tasks_updated` (`last_updated`),
  KEY `tp_tasks_status_type_nonunique` (`status`,`type`),
  KEY `tp_tasks_uid_appid_ident` (`user_id`,`app_id`,`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_textprocessing_tasks`
--

LOCK TABLES `oc_textprocessing_tasks` WRITE;
/*!40000 ALTER TABLE `oc_textprocessing_tasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_textprocessing_tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_trusted_servers`
--

DROP TABLE IF EXISTS `oc_trusted_servers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_trusted_servers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(512) NOT NULL,
  `url_hash` varchar(255) NOT NULL DEFAULT '',
  `token` varchar(128) DEFAULT NULL,
  `shared_secret` varchar(256) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 2,
  `sync_token` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `url_hash` (`url_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_trusted_servers`
--

LOCK TABLES `oc_trusted_servers` WRITE;
/*!40000 ALTER TABLE `oc_trusted_servers` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_trusted_servers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_twofactor_backupcodes`
--

DROP TABLE IF EXISTS `oc_twofactor_backupcodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_twofactor_backupcodes` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(64) NOT NULL DEFAULT '',
  `code` varchar(128) NOT NULL,
  `used` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `twofactor_backupcodes_uid` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_twofactor_backupcodes`
--

LOCK TABLES `oc_twofactor_backupcodes` WRITE;
/*!40000 ALTER TABLE `oc_twofactor_backupcodes` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_twofactor_backupcodes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_twofactor_providers`
--

DROP TABLE IF EXISTS `oc_twofactor_providers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_twofactor_providers` (
  `provider_id` varchar(32) NOT NULL,
  `uid` varchar(64) NOT NULL,
  `enabled` smallint(6) NOT NULL,
  PRIMARY KEY (`provider_id`,`uid`),
  KEY `twofactor_providers_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_twofactor_providers`
--

LOCK TABLES `oc_twofactor_providers` WRITE;
/*!40000 ALTER TABLE `oc_twofactor_providers` DISABLE KEYS */;
INSERT INTO `oc_twofactor_providers` VALUES
('backup_codes','admin',0);
/*!40000 ALTER TABLE `oc_twofactor_providers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_user_status`
--

DROP TABLE IF EXISTS `oc_user_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_user_status` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `status_timestamp` int(10) unsigned NOT NULL,
  `is_user_defined` tinyint(1) DEFAULT NULL,
  `message_id` varchar(255) DEFAULT NULL,
  `custom_icon` varchar(255) DEFAULT NULL,
  `custom_message` longtext DEFAULT NULL,
  `clear_at` int(10) unsigned DEFAULT NULL,
  `is_backup` tinyint(1) DEFAULT 0,
  `status_message_timestamp` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_status_uid_ix` (`user_id`),
  KEY `user_status_clr_ix` (`clear_at`),
  KEY `user_status_tstmp_ix` (`status_timestamp`),
  KEY `user_status_iud_ix` (`is_user_defined`,`status`),
  KEY `user_status_mtstmp_ix` (`status_message_timestamp`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_user_status`
--

LOCK TABLES `oc_user_status` WRITE;
/*!40000 ALTER TABLE `oc_user_status` DISABLE KEYS */;
INSERT INTO `oc_user_status` VALUES
(1,'admin','away',1752640766,0,NULL,NULL,NULL,NULL,0,0);
/*!40000 ALTER TABLE `oc_user_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_user_transfer_owner`
--

DROP TABLE IF EXISTS `oc_user_transfer_owner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_user_transfer_owner` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `source_user` varchar(64) NOT NULL,
  `target_user` varchar(64) NOT NULL,
  `file_id` bigint(20) NOT NULL,
  `node_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_user_transfer_owner`
--

LOCK TABLES `oc_user_transfer_owner` WRITE;
/*!40000 ALTER TABLE `oc_user_transfer_owner` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_user_transfer_owner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_users`
--

DROP TABLE IF EXISTS `oc_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_users` (
  `uid` varchar(64) NOT NULL DEFAULT '',
  `displayname` varchar(64) DEFAULT NULL,
  `password` varchar(255) NOT NULL DEFAULT '',
  `uid_lower` varchar(64) DEFAULT '',
  PRIMARY KEY (`uid`),
  KEY `user_uid_lower` (`uid_lower`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_users`
--

LOCK TABLES `oc_users` WRITE;
/*!40000 ALTER TABLE `oc_users` DISABLE KEYS */;
INSERT INTO `oc_users` VALUES
('admin',NULL,'3|$argon2id$v=19$m=65536,t=4,p=1$ZWtLd3FMS3RlRXNNeGlwSg$A2tLCcCqFm24bZlqaahPrsOikhZz6SUldQ2hUZ97al4','admin');
/*!40000 ALTER TABLE `oc_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_vcategory`
--

DROP TABLE IF EXISTS `oc_vcategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_vcategory` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uid` varchar(64) NOT NULL DEFAULT '',
  `type` varchar(64) NOT NULL DEFAULT '',
  `category` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `uid_index` (`uid`),
  KEY `type_index` (`type`),
  KEY `category_index` (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_vcategory`
--

LOCK TABLES `oc_vcategory` WRITE;
/*!40000 ALTER TABLE `oc_vcategory` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_vcategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_vcategory_to_object`
--

DROP TABLE IF EXISTS `oc_vcategory_to_object`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_vcategory_to_object` (
  `objid` bigint(20) unsigned NOT NULL DEFAULT 0,
  `categoryid` bigint(20) unsigned NOT NULL DEFAULT 0,
  `type` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`categoryid`,`objid`,`type`),
  KEY `vcategory_objectd_index` (`objid`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_vcategory_to_object`
--

LOCK TABLES `oc_vcategory_to_object` WRITE;
/*!40000 ALTER TABLE `oc_vcategory_to_object` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_vcategory_to_object` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_webauthn`
--

DROP TABLE IF EXISTS `oc_webauthn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_webauthn` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(64) NOT NULL,
  `name` varchar(64) NOT NULL,
  `public_key_credential_id` varchar(512) NOT NULL,
  `data` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `webauthn_uid` (`uid`),
  KEY `webauthn_publicKeyCredentialId` (`public_key_credential_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_webauthn`
--

LOCK TABLES `oc_webauthn` WRITE;
/*!40000 ALTER TABLE `oc_webauthn` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_webauthn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_whats_new`
--

DROP TABLE IF EXISTS `oc_whats_new`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_whats_new` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `version` varchar(64) NOT NULL DEFAULT '11',
  `etag` varchar(64) NOT NULL DEFAULT '',
  `last_check` int(10) unsigned NOT NULL DEFAULT 0,
  `data` longtext NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `version` (`version`),
  KEY `version_etag_idx` (`version`,`etag`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_whats_new`
--

LOCK TABLES `oc_whats_new` WRITE;
/*!40000 ALTER TABLE `oc_whats_new` DISABLE KEYS */;
INSERT INTO `oc_whats_new` VALUES
(1,'29.0.16','d41d8cd98f00b204e9800998ecf8427e',1752633893,'[]');
/*!40000 ALTER TABLE `oc_whats_new` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-16  4:40:55
