-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: localhost    Database: notebook
-- ------------------------------------------------------
-- Server version	8.0.27

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task` (
  `course_id` int NOT NULL,
  `task_id` int NOT NULL,
  `title` varchar(20) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `deadline` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`course_id`,`task_id`),
  CONSTRAINT `task_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task`
--

LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
INSERT INTO `task` VALUES (1,5,'Body-block someone','Forecast your partner move and block him/her as long as possible','2021-10-19 20:59:59'),(2,3,'Play Squid Game','Play any game from \"Squid Game\" series (4 people in group)','2021-11-25 20:59:59'),(2,4,'Favorite meme','Send your favorite meme','2021-10-22 20:59:59'),(2,11,'Ghoul Test','Complete \"What Tokyo Ghoul Character are You?\" test','2021-10-07 06:09:03'),(3,6,'Millenium problem','Solve at least one millenium problem','2021-10-24 20:59:59'),(3,10,'Solve tricky task','(1000 - x)^2 = 986 049','2021-10-22 04:07:07'),(4,7,'@#^*$(JFGU*#(','SF&^@#&*@#(*JFJF@*#Y&RJBJ','2021-11-19 09:00:00'),(4,8,'Y4505 B1B4','*^&$IY@HBU(@*#Y Y4505 B1B4 (&*O$^&UH@I','2021-10-28 20:59:59'),(4,9,'F!ND 0U7 W@TH $#% 1$','!$ $#% @ MY7h 0R N07','2021-12-31 20:59:59'),(5,1,'993 coils in a row','Coil enemies 993 times in a row','2021-10-30 20:59:59'),(5,2,'Destroy items','Buy and destroy 993 items in one game','2021-10-25 20:59:59');
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

-- Dump completed on 2021-10-22 14:47:08
