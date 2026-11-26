CREATE DATABASE  IF NOT EXISTS `helpdesk_etec_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `helpdesk_etec_db`;
-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: helpdesk_etec_db
-- ------------------------------------------------------
-- Server version	8.0.32

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
-- Table structure for table `tbl_categoria`
--

DROP TABLE IF EXISTS `tbl_categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_categoria` (
  `id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_categoria`
--

LOCK TABLES `tbl_categoria` WRITE;
/*!40000 ALTER TABLE `tbl_categoria` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_emprestimos`
--

DROP TABLE IF EXISTS `tbl_emprestimos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_emprestimos` (
  `id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `id_usuario` smallint unsigned NOT NULL,
  `id_equipamento` smallint unsigned NOT NULL,
  `data_retirada` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `data_prevista` date DEFAULT NULL,
  `data_devolucao` date DEFAULT NULL,
  PRIMARY KEY (`id`,`id_usuario`,`id_equipamento`),
  KEY `fk_tbl_emprestimos_tbl_usuarios1_idx` (`id_usuario`),
  KEY `fk_tbl_emprestimos_tbl_equipamentos1_idx` (`id_equipamento`),
  KEY `idx_data_prevista` (`data_prevista`),
  CONSTRAINT `fk_tbl_emprestimos_tbl_equipamentos1` FOREIGN KEY (`id_equipamento`) REFERENCES `tbl_equipamentos` (`id`),
  CONSTRAINT `fk_tbl_emprestimos_tbl_usuarios1` FOREIGN KEY (`id_usuario`) REFERENCES `tbl_usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_emprestimos`
--

LOCK TABLES `tbl_emprestimos` WRITE;
/*!40000 ALTER TABLE `tbl_emprestimos` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_emprestimos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_equipamentos`
--

DROP TABLE IF EXISTS `tbl_equipamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_equipamentos` (
  `id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `patrimonio` smallint unsigned NOT NULL,
  `descricao` varchar(255) NOT NULL,
  `id_categoria` smallint unsigned NOT NULL,
  `id_estado` tinyint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `patrimonio_UNIQUE` (`patrimonio`),
  KEY `fk_tbl_equipamentos_tbl_estado_equipamento1_idx` (`id_estado`),
  KEY `fk_tbl_equipamentos_tbl_categoria1_idx` (`id_categoria`),
  KEY `idx_descricao` (`descricao`),
  CONSTRAINT `fk_tbl_equipamentos_tbl_categoria1` FOREIGN KEY (`id_categoria`) REFERENCES `tbl_categoria` (`id`),
  CONSTRAINT `fk_tbl_equipamentos_tbl_estado_equipamento1` FOREIGN KEY (`id_estado`) REFERENCES `tbl_estado_equipamento` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_equipamentos`
--

LOCK TABLES `tbl_equipamentos` WRITE;
/*!40000 ALTER TABLE `tbl_equipamentos` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_equipamentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_estado_equipamento`
--

DROP TABLE IF EXISTS `tbl_estado_equipamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_estado_equipamento` (
  `id` tinyint unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_estado_equipamento`
--

LOCK TABLES `tbl_estado_equipamento` WRITE;
/*!40000 ALTER TABLE `tbl_estado_equipamento` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_estado_equipamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_tipo_usuario`
--

DROP TABLE IF EXISTS `tbl_tipo_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_tipo_usuario` (
  `id` tinyint unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(15) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_tipo_usuario`
--

LOCK TABLES `tbl_tipo_usuario` WRITE;
/*!40000 ALTER TABLE `tbl_tipo_usuario` DISABLE KEYS */;
INSERT INTO `tbl_tipo_usuario` VALUES (1,'Aluno'),(2,'Professor'),(3,'Estagiário'),(4,'Administrador');
/*!40000 ALTER TABLE `tbl_tipo_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_usuarios`
--

DROP TABLE IF EXISTS `tbl_usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_usuarios` (
  `id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(30) NOT NULL,
  `sobrenome` varchar(30) NOT NULL,
  `matricula` char(5) NOT NULL,
  `email` varchar(60) NOT NULL,
  `criado_em` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status_bloqueio` tinyint NOT NULL DEFAULT '0',
  `tipo_usuario` tinyint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `matricula_UNIQUE` (`matricula`),
  KEY `fk_tbl_usuarios_tbl_tipo_usuario_idx` (`tipo_usuario`),
  CONSTRAINT `fk_tbl_usuarios_tbl_tipo_usuario` FOREIGN KEY (`tipo_usuario`) REFERENCES `tbl_tipo_usuario` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_usuarios`
--

LOCK TABLES `tbl_usuarios` WRITE;
/*!40000 ALTER TABLE `tbl_usuarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-26 18:21:07
