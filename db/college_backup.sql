-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: university_db
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `committee_members`
--

DROP TABLE IF EXISTS `committee_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `committee_members` (
  `committee_id` int NOT NULL,
  `lecturer_id` int NOT NULL,
  PRIMARY KEY (`committee_id`,`lecturer_id`),
  KEY `fk_cm_lect` (`lecturer_id`),
  CONSTRAINT `fk_cm_comm` FOREIGN KEY (`committee_id`) REFERENCES `committees` (`committee_id`),
  CONSTRAINT `fk_cm_lect` FOREIGN KEY (`lecturer_id`) REFERENCES `lecturers` (`lecturer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `committee_members`
--

LOCK TABLES `committee_members` WRITE;
/*!40000 ALTER TABLE `committee_members` DISABLE KEYS */;
INSERT INTO `committee_members` VALUES (1,1),(2,2),(1,3),(2,4),(2,5),(3,6);
/*!40000 ALTER TABLE `committee_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `committees`
--

DROP TABLE IF EXISTS `committees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `committees` (
  `committee_id` int NOT NULL AUTO_INCREMENT,
  `committee_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`committee_id`),
  UNIQUE KEY `committee_name` (`committee_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `committees`
--

LOCK TABLES `committees` WRITE;
/*!40000 ALTER TABLE `committees` DISABLE KEYS */;
INSERT INTO `committees` VALUES (3,'Admissions Panel'),(2,'Curriculum Board'),(1,'Ethics Committee');
/*!40000 ALTER TABLE `committees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_materials`
--

DROP TABLE IF EXISTS `course_materials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_materials` (
  `material_id` int NOT NULL AUTO_INCREMENT,
  `course_code` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `material_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`material_id`),
  KEY `fk_mat_course` (`course_code`),
  CONSTRAINT `fk_mat_course` FOREIGN KEY (`course_code`) REFERENCES `courses` (`course_code`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_materials`
--

LOCK TABLES `course_materials` WRITE;
/*!40000 ALTER TABLE `course_materials` DISABLE KEYS */;
INSERT INTO `course_materials` VALUES (1,'CS201','Database Systems: The Complete Book','Textbook'),(2,'CS201','Week 1-5 Lecture Slides','Slides'),(3,'CS301','Pattern Recognition and ML','Textbook'),(4,'MA201','Statistics Problem Sets','Worksheet');
/*!40000 ALTER TABLE `course_materials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_prerequisites`
--

DROP TABLE IF EXISTS `course_prerequisites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_prerequisites` (
  `course_code` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prereq_code` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`course_code`,`prereq_code`),
  KEY `fk_pre_prereq` (`prereq_code`),
  CONSTRAINT `fk_pre_course` FOREIGN KEY (`course_code`) REFERENCES `courses` (`course_code`),
  CONSTRAINT `fk_pre_prereq` FOREIGN KEY (`prereq_code`) REFERENCES `courses` (`course_code`),
  CONSTRAINT `chk_pre_self` CHECK ((`course_code` <> `prereq_code`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_prerequisites`
--

LOCK TABLES `course_prerequisites` WRITE;
/*!40000 ALTER TABLE `course_prerequisites` DISABLE KEYS */;
INSERT INTO `course_prerequisites` VALUES ('CS201','CS101'),('CS301','CS201'),('CS302','CS201'),('MA201','MA101'),('MA301','MA201');
/*!40000 ALTER TABLE `course_prerequisites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `courses` (
  `course_code` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `course_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `dept_id` int NOT NULL,
  `level` int NOT NULL,
  `credits` int NOT NULL,
  `schedule` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`course_code`),
  KEY `fk_crs_dept` (`dept_id`),
  CONSTRAINT `fk_crs_dept` FOREIGN KEY (`dept_id`) REFERENCES `departments` (`dept_id`),
  CONSTRAINT `chk_crs_credits` CHECK ((`credits` > 0)),
  CONSTRAINT `chk_crs_level` CHECK ((`level` >= 1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` VALUES ('BU201','Corporate Finance','Capital structure and valuation.',3,2,20,'Wed 10:00'),('CS101','Programming Fundamentals','Intro to programming in Python.',1,1,20,'Mon 09:00, Thu 11:00'),('CS201','Databases','Relational design, SQL, normalisation.',1,2,20,'Tue 10:00, Fri 09:00'),('CS301','Machine Learning','Supervised and unsupervised learning.',1,3,20,'Wed 14:00'),('CS302','Distributed Systems','Consistency, replication, consensus.',1,3,20,'Mon 13:00'),('MA101','Calculus I','Limits, derivatives, integrals.',2,1,20,'Tue 09:00'),('MA201','Statistics','Probability and statistical inference.',2,2,20,'Thu 10:00'),('MA301','Financial Mathematics','Derivatives pricing, risk.',2,3,20,'Fri 11:00');
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department_research_areas`
--

DROP TABLE IF EXISTS `department_research_areas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department_research_areas` (
  `dept_id` int NOT NULL,
  `research_area` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`dept_id`,`research_area`),
  CONSTRAINT `fk_dra_dept` FOREIGN KEY (`dept_id`) REFERENCES `departments` (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department_research_areas`
--

LOCK TABLES `department_research_areas` WRITE;
/*!40000 ALTER TABLE `department_research_areas` DISABLE KEYS */;
INSERT INTO `department_research_areas` VALUES (1,'Cyber Security'),(1,'Distributed Systems'),(1,'Machine Learning'),(2,'Applied Mathematics'),(2,'Statistics'),(3,'Finance'),(3,'Marketing Analytics');
/*!40000 ALTER TABLE `department_research_areas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departments` (
  `dept_id` int NOT NULL AUTO_INCREMENT,
  `dept_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `faculty` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`dept_id`),
  UNIQUE KEY `dept_name` (`dept_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES (1,'Computer Science','Science & Engineering'),(2,'Mathematics','Science & Engineering'),(3,'Business','Humanities & Social Sciences');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `disciplinary_records`
--

DROP TABLE IF EXISTS `disciplinary_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `disciplinary_records` (
  `record_id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `incident_date` date NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `outcome` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`record_id`),
  KEY `fk_disc_stud` (`student_id`),
  CONSTRAINT `fk_disc_stud` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `disciplinary_records`
--

LOCK TABLES `disciplinary_records` WRITE;
/*!40000 ALTER TABLE `disciplinary_records` DISABLE KEYS */;
INSERT INTO `disciplinary_records` VALUES (1,1004,'2025-11-03','Plagiarism flag on coursework','Formal warning'),(2,1010,'2025-10-15','Repeated non-attendance','Case closed - student withdrew');
/*!40000 ALTER TABLE `disciplinary_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enrolments`
--

DROP TABLE IF EXISTS `enrolments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enrolments` (
  `enrolment_id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `course_code` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `semester` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `grade` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`enrolment_id`),
  UNIQUE KEY `uq_enrolment` (`student_id`,`course_code`,`semester`),
  KEY `fk_enr_course` (`course_code`),
  CONSTRAINT `fk_enr_course` FOREIGN KEY (`course_code`) REFERENCES `courses` (`course_code`),
  CONSTRAINT `fk_enr_stud` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`),
  CONSTRAINT `chk_enr_grade` CHECK ((`grade` between 0 and 100))
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enrolments`
--

LOCK TABLES `enrolments` WRITE;
/*!40000 ALTER TABLE `enrolments` DISABLE KEYS */;
INSERT INTO `enrolments` VALUES (1,1001,'CS101','2025-S1',82.00),(2,1001,'CS201','2025-S2',78.00),(3,1001,'CS301','2026-S1',NULL),(4,1001,'CS302','2026-S1',NULL),(5,1002,'CS101','2025-S1',74.00),(6,1002,'CS201','2025-S2',71.00),(7,1002,'CS301','2026-S1',NULL),(8,1003,'CS101','2025-S1',65.00),(9,1003,'CS201','2026-S1',NULL),(10,1004,'CS101','2025-S1',58.00),(11,1004,'CS201','2026-S1',NULL),(12,1005,'CS101','2026-S1',NULL),(13,1006,'MA101','2025-S1',88.00),(14,1006,'MA201','2025-S2',91.00),(15,1006,'MA301','2026-S1',NULL),(16,1007,'MA101','2025-S1',69.00),(17,1007,'MA201','2025-S2',72.00),(18,1007,'MA301','2026-S1',NULL),(19,1007,'BU201','2026-S1',NULL),(20,1008,'CS301','2025-S2',84.00),(21,1009,'MA201','2025-S2',76.00),(22,1010,'MA101','2025-S1',44.00);
/*!40000 ALTER TABLE `enrolments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lecturer_expertise`
--

DROP TABLE IF EXISTS `lecturer_expertise`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lecturer_expertise` (
  `lecturer_id` int NOT NULL,
  `expertise_area` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`lecturer_id`,`expertise_area`),
  CONSTRAINT `fk_lx_lect` FOREIGN KEY (`lecturer_id`) REFERENCES `lecturers` (`lecturer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lecturer_expertise`
--

LOCK TABLES `lecturer_expertise` WRITE;
/*!40000 ALTER TABLE `lecturer_expertise` DISABLE KEYS */;
INSERT INTO `lecturer_expertise` VALUES (1,'Data Mining'),(1,'Machine Learning'),(2,'Machine Learning'),(2,'Natural Language Processing'),(3,'Bayesian Inference'),(3,'Statistics'),(4,'Numerical Methods'),(4,'Optimisation'),(5,'Corporate Finance'),(5,'Risk Modelling'),(6,'Cloud Computing'),(6,'Distributed Systems');
/*!40000 ALTER TABLE `lecturer_expertise` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lecturer_qualifications`
--

DROP TABLE IF EXISTS `lecturer_qualifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lecturer_qualifications` (
  `lecturer_id` int NOT NULL,
  `qualification` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`lecturer_id`,`qualification`),
  CONSTRAINT `fk_lq_lect` FOREIGN KEY (`lecturer_id`) REFERENCES `lecturers` (`lecturer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lecturer_qualifications`
--

LOCK TABLES `lecturer_qualifications` WRITE;
/*!40000 ALTER TABLE `lecturer_qualifications` DISABLE KEYS */;
INSERT INTO `lecturer_qualifications` VALUES (1,'MSc Software Engineering'),(1,'PhD Computer Science'),(2,'PhD Artificial Intelligence'),(3,'FHEA'),(3,'PhD Statistics'),(4,'PhD Applied Mathematics'),(5,'MBA'),(5,'PhD Finance'),(6,'PhD Distributed Computing');
/*!40000 ALTER TABLE `lecturer_qualifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lecturer_research_interests`
--

DROP TABLE IF EXISTS `lecturer_research_interests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lecturer_research_interests` (
  `lecturer_id` int NOT NULL,
  `interest` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`lecturer_id`,`interest`),
  CONSTRAINT `fk_lri_lect` FOREIGN KEY (`lecturer_id`) REFERENCES `lecturers` (`lecturer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lecturer_research_interests`
--

LOCK TABLES `lecturer_research_interests` WRITE;
/*!40000 ALTER TABLE `lecturer_research_interests` DISABLE KEYS */;
INSERT INTO `lecturer_research_interests` VALUES (1,'Explainable AI'),(2,'Large Language Models'),(3,'Statistical Learning'),(4,'Convex Optimisation'),(5,'Algorithmic Trading'),(6,'Edge Computing');
/*!40000 ALTER TABLE `lecturer_research_interests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lecturers`
--

DROP TABLE IF EXISTS `lecturers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lecturers` (
  `lecturer_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dept_id` int NOT NULL,
  `course_load` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`lecturer_id`),
  UNIQUE KEY `email` (`email`),
  KEY `fk_lect_dept` (`dept_id`),
  CONSTRAINT `fk_lect_dept` FOREIGN KEY (`dept_id`) REFERENCES `departments` (`dept_id`),
  CONSTRAINT `chk_lect_load` CHECK ((`course_load` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lecturers`
--

LOCK TABLES `lecturers` WRITE;
/*!40000 ALTER TABLE `lecturers` DISABLE KEYS */;
INSERT INTO `lecturers` VALUES (1,'Dr Sara Haddad','sara.haddad@uni.ac.uk',1,3),(2,'Prof Omar Farouk','omar.farouk@uni.ac.uk',1,2),(3,'Dr Emily Watson','emily.watson@uni.ac.uk',2,3),(4,'Dr James Okafor','james.okafor@uni.ac.uk',2,2),(5,'Dr Lina Costa','lina.costa@uni.ac.uk',3,2),(6,'Prof David Chen','david.chen@uni.ac.uk',1,1);
/*!40000 ALTER TABLE `lecturers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `non_academic_staff`
--

DROP TABLE IF EXISTS `non_academic_staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `non_academic_staff` (
  `staff_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `job_title` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dept_id` int NOT NULL,
  `employment_type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contract_start` date NOT NULL,
  `contract_end` date DEFAULT NULL,
  `salary` decimal(10,2) DEFAULT NULL,
  `emergency_contact_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `emergency_contact_phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`staff_id`),
  KEY `fk_staff_dept` (`dept_id`),
  CONSTRAINT `fk_staff_dept` FOREIGN KEY (`dept_id`) REFERENCES `departments` (`dept_id`),
  CONSTRAINT `chk_staff_salary` CHECK ((`salary` >= 0)),
  CONSTRAINT `chk_staff_type` CHECK ((`employment_type` in (_cp850'Full-Time',_cp850'Part-Time',_cp850'Contract')))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `non_academic_staff`
--

LOCK TABLES `non_academic_staff` WRITE;
/*!40000 ALTER TABLE `non_academic_staff` DISABLE KEYS */;
INSERT INTO `non_academic_staff` VALUES (1,'Priya Sharma','Department Administrator',1,'Full-Time','2019-09-01',NULL,32000.00,'Raj Sharma','07700 900201'),(2,'Tom Bailey','Lab Technician',1,'Full-Time','2021-01-15',NULL,28500.00,'Sue Bailey','07700 900202'),(3,'Nadia Hussein','Finance Officer',3,'Part-Time','2022-06-01',NULL,21000.00,'Ali Hussein','07700 900203'),(4,'Mark Ellis','IT Support Analyst',1,'Contract','2025-09-01','2026-08-31',30000.00,'Jane Ellis','07700 900204'),(5,'Sofia Rossi','Student Services Advisor',2,'Full-Time','2020-03-01',NULL,27000.00,'Marco Rossi','07700 900205');
/*!40000 ALTER TABLE `non_academic_staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organization_memberships`
--

DROP TABLE IF EXISTS `organization_memberships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organization_memberships` (
  `student_id` int NOT NULL,
  `org_id` int NOT NULL,
  `joined_date` date DEFAULT NULL,
  PRIMARY KEY (`student_id`,`org_id`),
  KEY `fk_om_org` (`org_id`),
  CONSTRAINT `fk_om_org` FOREIGN KEY (`org_id`) REFERENCES `student_organizations` (`org_id`),
  CONSTRAINT `fk_om_stud` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organization_memberships`
--

LOCK TABLES `organization_memberships` WRITE;
/*!40000 ALTER TABLE `organization_memberships` DISABLE KEYS */;
INSERT INTO `organization_memberships` VALUES (1001,1,'2023-10-01'),(1001,2,'2023-10-05'),(1002,2,'2023-10-02'),(1003,1,'2024-10-01'),(1006,3,'2023-10-11'),(1007,3,'2023-10-12'),(1008,1,'2025-10-01');
/*!40000 ALTER TABLE `organization_memberships` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program_requirements`
--

DROP TABLE IF EXISTS `program_requirements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `program_requirements` (
  `program_id` int NOT NULL,
  `course_code` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`program_id`,`course_code`),
  KEY `fk_pr_course` (`course_code`),
  CONSTRAINT `fk_pr_course` FOREIGN KEY (`course_code`) REFERENCES `courses` (`course_code`),
  CONSTRAINT `fk_pr_prog` FOREIGN KEY (`program_id`) REFERENCES `programs` (`program_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program_requirements`
--

LOCK TABLES `program_requirements` WRITE;
/*!40000 ALTER TABLE `program_requirements` DISABLE KEYS */;
INSERT INTO `program_requirements` VALUES (3,'BU201'),(1,'CS101'),(1,'CS201'),(1,'CS301'),(2,'CS301'),(1,'CS302'),(3,'MA101'),(2,'MA201'),(3,'MA201'),(3,'MA301');
/*!40000 ALTER TABLE `program_requirements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `programs`
--

DROP TABLE IF EXISTS `programs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `programs` (
  `program_id` int NOT NULL AUTO_INCREMENT,
  `program_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `degree_awarded` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `duration_years` int NOT NULL,
  `dept_id` int NOT NULL,
  PRIMARY KEY (`program_id`),
  KEY `fk_prog_dept` (`dept_id`),
  CONSTRAINT `fk_prog_dept` FOREIGN KEY (`dept_id`) REFERENCES `departments` (`dept_id`),
  CONSTRAINT `chk_prog_duration` CHECK ((`duration_years` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `programs`
--

LOCK TABLES `programs` WRITE;
/*!40000 ALTER TABLE `programs` DISABLE KEYS */;
INSERT INTO `programs` VALUES (1,'Computer Science','BSc (Hons)',3,1),(2,'Data Science & AI','MSc',2,1),(3,'Mathematics with Finance','BSc (Hons)',3,2);
/*!40000 ALTER TABLE `programs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_funding`
--

DROP TABLE IF EXISTS `project_funding`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_funding` (
  `funding_id` int NOT NULL AUTO_INCREMENT,
  `project_id` int NOT NULL,
  `source` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`funding_id`),
  KEY `fk_pf_proj` (`project_id`),
  CONSTRAINT `fk_pf_proj` FOREIGN KEY (`project_id`) REFERENCES `research_projects` (`project_id`),
  CONSTRAINT `chk_pf_amount` CHECK ((`amount` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_funding`
--

LOCK TABLES `project_funding` WRITE;
/*!40000 ALTER TABLE `project_funding` DISABLE KEYS */;
INSERT INTO `project_funding` VALUES (1,1,'UKRI',120000.00),(2,1,'Industry Partner',30000.00),(3,2,'EPSRC',250000.00),(4,3,'Wellcome Trust',90000.00);
/*!40000 ALTER TABLE `project_funding` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_lecturers`
--

DROP TABLE IF EXISTS `project_lecturers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_lecturers` (
  `project_id` int NOT NULL,
  `lecturer_id` int NOT NULL,
  PRIMARY KEY (`project_id`,`lecturer_id`),
  KEY `fk_pl_lect` (`lecturer_id`),
  CONSTRAINT `fk_pl_lect` FOREIGN KEY (`lecturer_id`) REFERENCES `lecturers` (`lecturer_id`),
  CONSTRAINT `fk_pl_proj` FOREIGN KEY (`project_id`) REFERENCES `research_projects` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_lecturers`
--

LOCK TABLES `project_lecturers` WRITE;
/*!40000 ALTER TABLE `project_lecturers` DISABLE KEYS */;
INSERT INTO `project_lecturers` VALUES (1,1),(2,1),(1,2),(3,3),(3,4),(2,6);
/*!40000 ALTER TABLE `project_lecturers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_students`
--

DROP TABLE IF EXISTS `project_students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_students` (
  `project_id` int NOT NULL,
  `student_id` int NOT NULL,
  PRIMARY KEY (`project_id`,`student_id`),
  KEY `fk_ps_stud` (`student_id`),
  CONSTRAINT `fk_ps_proj` FOREIGN KEY (`project_id`) REFERENCES `research_projects` (`project_id`),
  CONSTRAINT `fk_ps_stud` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_students`
--

LOCK TABLES `project_students` WRITE;
/*!40000 ALTER TABLE `project_students` DISABLE KEYS */;
INSERT INTO `project_students` VALUES (1,1001),(2,1002),(3,1006),(3,1007),(1,1008);
/*!40000 ALTER TABLE `project_students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publications`
--

DROP TABLE IF EXISTS `publications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publications` (
  `pub_id` int NOT NULL AUTO_INCREMENT,
  `lecturer_id` int NOT NULL,
  `project_id` int DEFAULT NULL,
  `title` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pub_year` int NOT NULL,
  PRIMARY KEY (`pub_id`),
  KEY `fk_pub_lect` (`lecturer_id`),
  KEY `fk_pub_proj` (`project_id`),
  CONSTRAINT `fk_pub_lect` FOREIGN KEY (`lecturer_id`) REFERENCES `lecturers` (`lecturer_id`),
  CONSTRAINT `fk_pub_proj` FOREIGN KEY (`project_id`) REFERENCES `research_projects` (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publications`
--

LOCK TABLES `publications` WRITE;
/*!40000 ALTER TABLE `publications` DISABLE KEYS */;
INSERT INTO `publications` VALUES (1,1,1,'SHAP-Based Explanations in Credit Models',2026),(2,2,NULL,'Prompt Engineering for Domain LLMs',2025),(3,3,3,'Adaptive Bayesian Trial Designs',2026),(4,3,3,'Priors in Small-Sample Clinical Studies',2025),(5,6,2,'Consensus Protocols on Edge Devices',2026),(6,4,NULL,'Convergence Rates in Convex Optimisation',2024);
/*!40000 ALTER TABLE `publications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `research_groups`
--

DROP TABLE IF EXISTS `research_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `research_groups` (
  `group_id` int NOT NULL AUTO_INCREMENT,
  `group_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `head_lecturer_id` int NOT NULL,
  PRIMARY KEY (`group_id`),
  UNIQUE KEY `group_name` (`group_name`),
  UNIQUE KEY `head_lecturer_id` (`head_lecturer_id`),
  CONSTRAINT `fk_rg_head` FOREIGN KEY (`head_lecturer_id`) REFERENCES `lecturers` (`lecturer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `research_groups`
--

LOCK TABLES `research_groups` WRITE;
/*!40000 ALTER TABLE `research_groups` DISABLE KEYS */;
INSERT INTO `research_groups` VALUES (1,'Intelligent Systems Lab',2),(2,'Statistical Modelling Group',3),(3,'Distributed Computing Lab',6);
/*!40000 ALTER TABLE `research_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `research_projects`
--

DROP TABLE IF EXISTS `research_projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `research_projects` (
  `project_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pi_lecturer_id` int NOT NULL,
  `outcomes` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`project_id`),
  KEY `fk_rp_pi` (`pi_lecturer_id`),
  CONSTRAINT `fk_rp_pi` FOREIGN KEY (`pi_lecturer_id`) REFERENCES `lecturers` (`lecturer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `research_projects`
--

LOCK TABLES `research_projects` WRITE;
/*!40000 ALTER TABLE `research_projects` DISABLE KEYS */;
INSERT INTO `research_projects` VALUES (1,'Explainable AI for Credit Scoring',1,'Prototype delivered; paper under review'),(2,'Federated Learning at the Edge',6,'Ongoing'),(3,'Bayesian Methods for Clinical Trials',3,'Two publications');
/*!40000 ALTER TABLE `research_projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_organizations`
--

DROP TABLE IF EXISTS `student_organizations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_organizations` (
  `org_id` int NOT NULL AUTO_INCREMENT,
  `org_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`org_id`),
  UNIQUE KEY `org_name` (`org_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_organizations`
--

LOCK TABLES `student_organizations` WRITE;
/*!40000 ALTER TABLE `student_organizations` DISABLE KEYS */;
INSERT INTO `student_organizations` VALUES (1,'Computing Society'),(2,'Football Club'),(3,'Investment Society');
/*!40000 ALTER TABLE `student_organizations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `students` (
  `student_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_of_birth` date NOT NULL,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `program_id` int NOT NULL,
  `year_of_study` int NOT NULL,
  `graduation_status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Enrolled',
  `advisor_id` int DEFAULT NULL,
  PRIMARY KEY (`student_id`),
  UNIQUE KEY `email` (`email`),
  KEY `fk_stud_prog` (`program_id`),
  KEY `fk_stud_advisor` (`advisor_id`),
  CONSTRAINT `fk_stud_advisor` FOREIGN KEY (`advisor_id`) REFERENCES `lecturers` (`lecturer_id`),
  CONSTRAINT `fk_stud_prog` FOREIGN KEY (`program_id`) REFERENCES `programs` (`program_id`),
  CONSTRAINT `chk_stud_status` CHECK ((`graduation_status` in (_cp850'Enrolled',_cp850'Graduated',_cp850'Withdrawn'))),
  CONSTRAINT `chk_stud_year` CHECK ((`year_of_study` >= 1))
) ENGINE=InnoDB AUTO_INCREMENT=1011 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES (1001,'Amira Khalil','2004-03-12','a.khalil@student.uni.ac.uk','07700 900101',1,3,'Enrolled',1),(1002,'Ben Carter','2004-07-25','b.carter@student.uni.ac.uk','07700 900102',1,3,'Enrolled',1),(1003,'Chloe Nguyen','2005-01-08','c.nguyen@student.uni.ac.uk','07700 900103',1,2,'Enrolled',2),(1004,'Daniel Adeyemi','2005-11-30','d.adeyemi@student.uni.ac.uk','07700 900104',1,2,'Enrolled',2),(1005,'Eva Kowalski','2006-05-17','e.kowalski@student.uni.ac.uk','07700 900105',1,1,'Enrolled',6),(1006,'Faris Mansour','2003-09-02','f.mansour@student.uni.ac.uk','07700 900106',3,3,'Enrolled',4),(1007,'Grace Osei','2004-12-19','g.osei@student.uni.ac.uk','07700 900107',3,3,'Enrolled',3),(1008,'Hassan Ali','2000-04-06','h.ali@student.uni.ac.uk','07700 900108',2,2,'Enrolled',2),(1009,'Isla McGregor','2001-08-23','i.mcgregor@student.uni.ac.uk','07700 900109',2,1,'Enrolled',1),(1010,'Jakub Novak','2002-02-14','j.novak@student.uni.ac.uk','07700 900110',3,3,'Withdrawn',3);
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teaching_assignments`
--

DROP TABLE IF EXISTS `teaching_assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teaching_assignments` (
  `lecturer_id` int NOT NULL,
  `course_code` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `semester` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`lecturer_id`,`course_code`,`semester`),
  KEY `fk_ta_course` (`course_code`),
  CONSTRAINT `fk_ta_course` FOREIGN KEY (`course_code`) REFERENCES `courses` (`course_code`),
  CONSTRAINT `fk_ta_lect` FOREIGN KEY (`lecturer_id`) REFERENCES `lecturers` (`lecturer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teaching_assignments`
--

LOCK TABLES `teaching_assignments` WRITE;
/*!40000 ALTER TABLE `teaching_assignments` DISABLE KEYS */;
INSERT INTO `teaching_assignments` VALUES (5,'BU201','2026-S1'),(2,'CS101','2026-S1'),(1,'CS201','2026-S1'),(1,'CS301','2026-S1'),(2,'CS301','2025-S2'),(6,'CS302','2026-S1'),(3,'MA101','2025-S2'),(4,'MA101','2026-S1'),(3,'MA201','2026-S1'),(4,'MA301','2026-S1');
/*!40000 ALTER TABLE `teaching_assignments` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-16  8:45:58
