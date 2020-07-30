-- MySQL dump 10.13  Distrib 5.7.19, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: bmei
-- ------------------------------------------------------
-- Server version	5.7.19

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
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `accounts_username_uindex` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_prerequisites`
--

DROP TABLE IF EXISTS `course_prerequisites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_prerequisites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course` int(11) NOT NULL,
  `required_course` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `course_prerequisites_course_index` (`course`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_prerequisites`
--

LOCK TABLES `course_prerequisites` WRITE;
/*!40000 ALTER TABLE `course_prerequisites` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_prerequisites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses` (
  `id` int(11) NOT NULL,
  `code_th` varchar(50) NOT NULL,
  `code_en` varchar(50) NOT NULL,
  `name_th` varchar(500) NOT NULL,
  `name_en` varchar(500) NOT NULL,
  `credit` int(11) NOT NULL,
  `detail_th` text NOT NULL,
  `detail_en` text NOT NULL,
  `condition_department` tinyint(4) NOT NULL,
  `condition_instructor` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `degrees`
--

DROP TABLE IF EXISTS `degrees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `degrees` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name_th` varchar(500) NOT NULL,
  `name_en` varchar(500) NOT NULL,
  `short_name_th` varchar(255) NOT NULL,
  `short_name_en` varchar(255) NOT NULL,
  `detail_th` longtext NOT NULL,
  `detail_en` longtext NOT NULL,
  `visible` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `degrees_visible_index` (`visible`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `degrees`
--

LOCK TABLES `degrees` WRITE;
/*!40000 ALTER TABLE `degrees` DISABLE KEYS */;
/*!40000 ALTER TABLE `degrees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `files`
--

DROP TABLE IF EXISTS `files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(500) NOT NULL,
  `type` varchar(500) NOT NULL,
  `size` int(11) NOT NULL,
  `uploaded_dt` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `files`
--

LOCK TABLES `files` WRITE;
/*!40000 ALTER TABLE `files` DISABLE KEYS */;
/*!40000 ALTER TABLE `files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news`
--

DROP TABLE IF EXISTS `news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` int(11) NOT NULL,
  `title_th` varchar(500) NOT NULL,
  `title_en` varchar(500) NOT NULL,
  `detail_th` longtext NOT NULL,
  `detail_en` longtext NOT NULL,
  `published_dt` int(11) NOT NULL,
  `show_front` tinyint(4) NOT NULL,
  `visible` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `news_category_index` (`category`),
  KEY `news_visible_index` (`visible`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news`
--

LOCK TABLES `news` WRITE;
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
/*!40000 ALTER TABLE `news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news_files`
--

DROP TABLE IF EXISTS `news_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `news_files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `news` int(11) NOT NULL,
  `file` int(11) NOT NULL,
  `image` tinyint(4) NOT NULL,
  `description_th` varchar(500) NOT NULL,
  `description_en` varchar(500) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `news_images_news_index` (`news`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news_files`
--

LOCK TABLES `news_files` WRITE;
/*!40000 ALTER TABLE `news_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `news_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pages` (
  `id` varchar(100) NOT NULL,
  `section` varchar(100) NOT NULL,
  `title_th` varchar(500) NOT NULL,
  `title_en` varchar(500) NOT NULL,
  `detail_th` longtext NOT NULL,
  `detail_en` longtext NOT NULL,
  `published_dt` int(11) NOT NULL,
  `visible` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages`
--

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
/*!40000 ALTER TABLE `pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `research_categories`
--

DROP TABLE IF EXISTS `research_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `research_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title_th` varchar(255) NOT NULL,
  `title_en` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `research_categories`
--

LOCK TABLES `research_categories` WRITE;
/*!40000 ALTER TABLE `research_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `research_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `research_organizations`
--

DROP TABLE IF EXISTS `research_organizations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `research_organizations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name_th` varchar(500) NOT NULL,
  `name_en` varchar(500) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `research_organizations`
--

LOCK TABLES `research_organizations` WRITE;
/*!40000 ALTER TABLE `research_organizations` DISABLE KEYS */;
/*!40000 ALTER TABLE `research_organizations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `research_researchers`
--

DROP TABLE IF EXISTS `research_researchers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `research_researchers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `research` int(11) NOT NULL,
  `researcher` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `research_researchers_research_index` (`research`)
) ENGINE=MyISAM AUTO_INCREMENT=78 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `research_researchers`
--

LOCK TABLES `research_researchers` WRITE;
/*!40000 ALTER TABLE `research_researchers` DISABLE KEYS */;
/*!40000 ALTER TABLE `research_researchers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `researchers`
--

DROP TABLE IF EXISTS `researchers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `researchers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name_th` varchar(500) NOT NULL,
  `name_en` varchar(500) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `researchers`
--

LOCK TABLES `researchers` WRITE;
/*!40000 ALTER TABLE `researchers` DISABLE KEYS */;
/*!40000 ALTER TABLE `researchers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `researches`
--

DROP TABLE IF EXISTS `researches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `researches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title_th` varchar(255) NOT NULL,
  `title_en` varchar(255) NOT NULL,
  `category` int(11) NOT NULL,
  `organization` int(11) NOT NULL,
  `start_dt` int(11) DEFAULT NULL,
  `end_dt` int(11) DEFAULT NULL,
  `budget_th` varchar(255) NOT NULL,
  `budget_en` varchar(255) NOT NULL,
  `budget_amount` int(11) NOT NULL,
  `abstract_th` longtext NOT NULL,
  `abstract_en` longtext NOT NULL,
  `visible` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `researches_visible_index` (`visible`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `researches`
--

LOCK TABLES `researches` WRITE;
/*!40000 ALTER TABLE `researches` DISABLE KEYS */;
/*!40000 ALTER TABLE `researches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `slide_shows`
--

DROP TABLE IF EXISTS `slide_shows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `slide_shows` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image` int(11) NOT NULL,
  `sequence` int(11) NOT NULL,
  `visible` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slide_shows`
--

LOCK TABLES `slide_shows` WRITE;
/*!40000 ALTER TABLE `slide_shows` DISABLE KEYS */;
/*!40000 ALTER TABLE `slide_shows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `texts`
--

DROP TABLE IF EXISTS `texts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `texts` (
  `id` varchar(100) NOT NULL,
  `description` varchar(500) NOT NULL,
  `text_th` longtext NOT NULL,
  `text_en` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `texts`
--

LOCK TABLES `texts` WRITE;
/*!40000 ALTER TABLE `texts` DISABLE KEYS */;
INSERT INTO `texts` VALUES ('home_about','','สถาบันวิศวกรรมชีวการแพทย์ มหาวิทยาลัยเชียงใหม่ สถาบันวิศวกรรมชีวการแพทย์ มหาวิทยาลัยเชียงใหม่ สถาบันวิศวกรรมชีวการแพทย์ มหาวิทยาลัยเชียงใหม่ สถาบันวิศวกรรมชีวการแพทย์ มหาวิทยาลัยเชียงใหม่ สถาบันวิศวกรรมชีวการแพทย์ มหาวิทยาลัยเชียงใหม่ สถาบันวิศวกรรมชีวการแพทย์ มหาวิทยาลัยเชียงใหม่ สถาบันวิศวกรรมชีวการแพทย์ มหาวิทยาลัยเชียงใหม่ สถาบันวิศวกรรมชีวการแพทย์ มหาวิทยาลัยเชียงใหม่ สถาบันวิศวกรรมชีวการแพทย์ มหาวิทยาลัยเชียงใหม่ สถาบันวิศวกรรมชีวการแพทย์ มหาวิทยาลัยเชียงใหม่ สถาบันวิศวกรรมชีวการแพทย์ มหาวิทยาลัยเชียงใหม่ สถาบันวิศวกรรมชีวการแพทย์ มหาวิทยาลัยเชียงใหม่ สถาบันวิศวกรรมชีวการแพทย์ มหาวิทยาลัยเชียงใหม่ สถาบันวิศวกรรมชีวการแพทย์ มหาวิทยาลัยเชียงใหม่ สถาบันวิศวกรรมชีวการแพทย์ มหาวิทยาลัยเชียงใหม่ สถาบันวิศวกรรมชีวการแพทย์ มหาวิทยาลัยเชียงใหม่ สถาบันวิศวกรรมชีวการแพทย์ มหาวิทยาลัยเชียงใหม่ สถาบันวิศวกรรมชีวการแพทย์ มหาวิทยาลัยเชียงใหม่ ','The origin of BMEI started from the coordination among researchers from several faculties. In fact, there are a number of high-quality researchers in various fields in Chiang Mai University related to biomedical engineeringssuch as Faculty of Engineering, Medicine, Science, Associated Medical Sciences, Pharmacy, Agriculture, Agro-Industry, Dentistry, and Veterinary Medicine. Furthermore, these related researchers produce many research works which are widely recognized internationally. Therefore, the purpose of the establishment of BMEI is to produce university\'s postgraduates who have knowledge in theoretical and practical aspects in the field of biomedical engineering and make use of the knowledge to help develop the country in this field and provide academic service to the community. Our sample tasks include being a consultant and medical devices developer for the community and spreading the knowledge to other communities, hospitals, or medical service centers, including producing research works in biomedical engineering to increase the effectiveness in research and develop the country sustainably.'),('address','ที่อยู่','ห้อง 702 อาคาร 30 ปี คณะวิศวกรรมศาสตร์ มหาวิทยาลัยเชียงใหม่, 239 ถนนห้วยแก้ว ตำบลสุเทพ อำเภอเมืองเชียงใหม่ จังหวัดเชียงใหม่ 50200 ประเทศไทย','Room 702, 30th Anniversary Building, Faculty of Engineering, Chiang Mai University, 239 Huay Keaw Rd., Suthep, Muang, Chiang Mai 50200 THAILAND'),('about','เกี่ยวกับ','สถาบันวิศวกรรมชีวการแพทย์ มหาวิทยาลัยเชียงใหม่ สถาบันวิศวกรรมชีวการแพทย์ มหาวิทยาลัยเชียงใหม่ สถาบันวิศวกรรมชีวการแพทย์ มหาวิทยาลัยเชียงใหม่ สถาบันวิศวกรรมชีวการแพทย์ มหาวิทยาลัยเชียงใหม่ สถาบันวิศวกรรมชีวการแพทย์ มหาวิทยาลัยเชียงใหม่ สถาบันวิศวกรรมชีวการแพทย์ มหาวิทยาลัยเชียงใหม่ สถาบันวิศวกรรมชีวการแพทย์ มหาวิทยาลัยเชียงใหม่ สถาบันวิศวกรรมชีวการแพทย์ มหาวิทยาลัยเชียงใหม่ สถาบันวิศวกรรมชีวการแพทย์ มหาวิทยาลัยเชียงใหม่ สถาบันวิศวกรรมชีวการแพทย์ มหาวิทยาลัยเชียงใหม่ สถาบันวิศวกรรมชีวการแพทย์ มหาวิทยาลัยเชียงใหม่ สถาบันวิศวกรรมชีวการแพทย์ มหาวิทยาลัยเชียงใหม่ สถาบันวิศวกรรมชีวการแพทย์ มหาวิทยาลัยเชียงใหม่ สถาบันวิศวกรรมชีวการแพทย์ มหาวิทยาลัยเชียงใหม่ สถาบันวิศวกรรมชีวการแพทย์ มหาวิทยาลัยเชียงใหม่ สถาบันวิศวกรรมชีวการแพทย์ มหาวิทยาลัยเชียงใหม่ สถาบันวิศวกรรมชีวการแพทย์ มหาวิทยาลัยเชียงใหม่ สถาบันวิศวกรรมชีวการแพทย์ มหาวิทยาลัยเชียงใหม่','The origin of BMEI started from the coordination among researchers from several faculties. In fact, there are a number of high-quality researchers in various fields in Chiang Mai University related to biomedical engineeringssuch as Faculty of Engineering, Medicine, Science, Associated Medical Sciences, Pharmacy, Agriculture, Agro-Industry, Dentistry, and Veterinary Medicine. Furthermore, these related researchers produce many research works which are widely recognized internationally. Therefore, the purpose of the establishment of BMEI is to produce university\'s postgraduates who have knowledge in theoretical and practical aspects in the field of biomedical engineering and make use of the knowledge to help develop the country in this field and provide academic service to the community. Our sample tasks include being a consultant and medical devices developer for the community and spreading the knowledge to other communities, hospitals, or medical service centers, including producing research works in biomedical engineering to increase the effectiveness in research and develop the country sustainably.'),('email','อีเมล','bmei@cmu.ac.th','bmei@cmu.ac.th'),('facebook_name','ชื่อเฟสบุค','',''),('facebook_url','URL เฟสบุค (facebook.com/.....)','-','-'),('twitter','ชื่อทวิตเตอร์ (ไม่ต้องใส่ @)','',''),('instagram','ชื่ออินสตาแกรม (ไม่ต้องใส่ @)','',''),('youtube_name','ชื่อช่องยูทูป','-','-'),('youtube_url','URL ยูทูป','',''),('line_ad','Line @','-','-'),('tel','หมายเลขโทรศัพท์','053-942-083-4','(+66)-5394-2083-4'),('fax','หมายเลขโทรสาร','053-942-083 ต่อ 18','(+66)-5394-2083 Ext. 18');
/*!40000 ALTER TABLE `texts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `variables`
--

DROP TABLE IF EXISTS `variables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `variables` (
  `name` varchar(200) NOT NULL,
  `value` varchar(500) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `variables`
--

LOCK TABLES `variables` WRITE;
/*!40000 ALTER TABLE `variables` DISABLE KEYS */;
/*!40000 ALTER TABLE `variables` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-04-22 21:59:25
