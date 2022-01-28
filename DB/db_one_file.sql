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
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course` (
  `course_id` int NOT NULL,
  `title` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES (1,'Body blocking'),(2,'Memes'),(3,'Math'),(4,'Elph language'),(5,'zxc'),(6,'Social Credits');
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group`
--

DROP TABLE IF EXISTS `group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group` (
  `group_name` varchar(10) NOT NULL,
  PRIMARY KEY (`group_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group`
--

LOCK TABLES `group` WRITE;
/*!40000 ALTER TABLE `group` DISABLE KEYS */;
INSERT INTO `group` VALUES ('BIVT-19-2'),('BIVT-20-21'),('MEM-830');
/*!40000 ALTER TABLE `group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_courses`
--

DROP TABLE IF EXISTS `group_courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group_courses` (
  `group_name` varchar(10) NOT NULL,
  `course_id` int NOT NULL,
  PRIMARY KEY (`group_name`,`course_id`),
  KEY `course_id` (`course_id`),
  CONSTRAINT `group_courses_ibfk_1` FOREIGN KEY (`group_name`) REFERENCES `group` (`group_name`) ON DELETE CASCADE,
  CONSTRAINT `group_courses_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_courses`
--

LOCK TABLES `group_courses` WRITE;
/*!40000 ALTER TABLE `group_courses` DISABLE KEYS */;
INSERT INTO `group_courses` VALUES ('MEM-830',1),('BIVT-19-2',2),('BIVT-20-21',2),('BIVT-19-2',3),('MEM-830',3),('BIVT-19-2',4),('MEM-830',4),('MEM-830',5),('BIVT-20-21',6);
/*!40000 ALTER TABLE `group_courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `student_id` int NOT NULL,
  `first_name` varchar(20) DEFAULT NULL,
  `middle_name` varchar(20) DEFAULT NULL,
  `last_name` varchar(20) DEFAULT NULL,
  `gpa` float DEFAULT NULL,
  `group_name` varchar(10) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`student_id`),
  KEY `group_name` (`group_name`),
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`group_name`) REFERENCES `group` (`group_name`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (1,'f test','m test','l test',5,'BIVT-20-21','p test'),(2,'Kirill',NULL,'Somov',5,'BIVT-19-2','k pass'),(3,'Regina',NULL,'Abdullina',5,'BIVT-19-2','r pass'),(4,'Tanya',NULL,'Khokhlova',5,'BIVT-20-21','t pass'),(5,'Geogy',NULL,'Tesarian',5,'MEM-830','g pass'),(6,'Bob',NULL,'Bobino',4,'MEM-830','b pass'),(7,'Arbuz',NULL,'DJ',3,'BIVT-19-2','arbuz pass'),(8,'a',NULL,'a',5,'BIVT-19-2','a');
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task` (
  `course_id` int NOT NULL,
  `task_id` int NOT NULL,
  `title` varchar(30) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
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
INSERT INTO `task` VALUES (1,5,'Body-block someone','Forecast your partner move and block him/her as long as possible','2021-10-19 20:59:59'),(2,3,'Play Squid Game','Play any game from \"Squid Game\" series (4 people in group)','2021-11-25 20:59:59'),(2,4,'Favorite meme','Send your favorite meme','2021-10-22 20:59:59'),(2,11,'Ghoul Test','Complete \"What Tokyo Ghoul Character are You?\" test','2021-10-07 06:09:03'),(3,6,'Millenium problem','Solve at least one millenium problem','2021-10-24 20:59:59'),(3,10,'Solve tricky task','(1000 - x)^2 = 986 049','2021-10-22 04:07:07'),(4,7,'@#^*$(JFGU*#(','SF&^@#&*@#(*JFJF@*#Y&RJBJ','2021-11-19 09:00:00'),(4,8,'Y4505 B1B4','*^&$IY@HBU(@*#Y Y4505 B1B4 (&*O$^&UH@I','2021-10-28 20:59:59'),(4,9,'F!ND 0U7 W@TH $#% 1$','!$ $#% @ MY7h 0R N07','2021-12-31 20:59:59'),(5,1,'993 coils in a row','Coil enemies 993 times in a row','2021-10-30 20:59:59'),(5,2,'Destroy items','Buy and destroy 993 items in one game','2021-10-25 20:59:59'),(5,12,'Question mark in a chat','Kill an enemy, press pause button, type \"?\" in the chat 993 times. Screenshots are required!','2021-12-02 17:21:02'),(6,13,'Country test','Complete the test about countries and get +15 social credits','2021-12-27 20:59:59');
/*!40000 ALTER TABLE `task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher`
--

DROP TABLE IF EXISTS `teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teacher` (
  `teacher_id` int NOT NULL,
  `first_name` varchar(20) DEFAULT NULL,
  `middle_name` varchar(20) DEFAULT NULL,
  `last_name` varchar(20) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  `course_id` int DEFAULT NULL,
  PRIMARY KEY (`teacher_id`),
  KEY `course_id` (`course_id`),
  CONSTRAINT `teacher_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher`
--

LOCK TABLES `teacher` WRITE;
/*!40000 ALTER TABLE `teacher` DISABLE KEYS */;
INSERT INTO `teacher` VALUES (1,'Antonio','True','Margheriti','marg pass',4),(2,'Panda',NULL,'Master','master pass',2),(3,'Fiend',NULL,'Shadow','shadow pass',5),(4,'Warlord',NULL,'Troll','troll pass',1),(5,'Elo',NULL,'Bosg','bosg pass',3),(6,'Dead',NULL,'Inside','inside pass',6);
/*!40000 ALTER TABLE `teacher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher_courses`
--

DROP TABLE IF EXISTS `teacher_courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teacher_courses` (
  `teacher_id` int NOT NULL,
  `course_id` int NOT NULL,
  PRIMARY KEY (`teacher_id`,`course_id`),
  KEY `course_id` (`course_id`),
  CONSTRAINT `teacher_courses_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`teacher_id`) ON DELETE CASCADE,
  CONSTRAINT `teacher_courses_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher_courses`
--

LOCK TABLES `teacher_courses` WRITE;
/*!40000 ALTER TABLE `teacher_courses` DISABLE KEYS */;
INSERT INTO `teacher_courses` VALUES (4,1),(6,1),(2,2),(5,3),(1,4),(2,5),(3,5),(6,6);
/*!40000 ALTER TABLE `teacher_courses` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-12-03 19:51:51
