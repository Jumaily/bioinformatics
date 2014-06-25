# ************************************************************
# Sequel Pro SQL dump
# Version 3408
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: localhost (MySQL 5.5.24)
# Database: yvonne
# Generation Time: 2012-07-03 23:25:25 -0400
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table drosophila_2Rresults_2L
# ------------------------------------------------------------

DROP TABLE IF EXISTS `drosophila_2Rresults_2L`;

CREATE TABLE `drosophila_2Rresults_2L` (
  `id` int(25) unsigned NOT NULL AUTO_INCREMENT,
  `bead_id` varchar(50) DEFAULT NULL,
  `tag` varchar(35) DEFAULT NULL,
  `chromosome` varchar(25) DEFAULT NULL,
  `startx` int(25) DEFAULT NULL,
  `endx` int(25) DEFAULT NULL,
  `sequence` varchar(255) DEFAULT NULL,
  `strand` varchar(5) DEFAULT NULL,
  `length` int(10) DEFAULT NULL,
  `paired_matches` int(10) DEFAULT NULL,
  `chr_length` int(10) DEFAULT NULL,
  `chr_center` int(50) DEFAULT NULL,
  `start_end_seq` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bead_id` (`bead_id`),
  KEY `start_end_seq` (`start_end_seq`),
  KEY `chr_length` (`chr_length`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table drosophila_2Rresults_2LHet
# ------------------------------------------------------------

DROP TABLE IF EXISTS `drosophila_2Rresults_2LHet`;

CREATE TABLE `drosophila_2Rresults_2LHet` (
  `id` int(25) unsigned NOT NULL AUTO_INCREMENT,
  `bead_id` varchar(50) DEFAULT NULL,
  `tag` varchar(35) DEFAULT NULL,
  `chromosome` varchar(25) DEFAULT NULL,
  `startx` int(25) DEFAULT NULL,
  `endx` int(25) DEFAULT NULL,
  `sequence` varchar(255) DEFAULT NULL,
  `strand` varchar(5) DEFAULT NULL,
  `length` int(10) DEFAULT NULL,
  `paired_matches` int(10) DEFAULT NULL,
  `chr_length` int(10) DEFAULT NULL,
  `chr_center` int(50) DEFAULT NULL,
  `start_end_seq` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bead_id` (`bead_id`),
  KEY `start_end_seq` (`start_end_seq`),
  KEY `chr_length` (`chr_length`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table drosophila_2Rresults_2R
# ------------------------------------------------------------

DROP TABLE IF EXISTS `drosophila_2Rresults_2R`;

CREATE TABLE `drosophila_2Rresults_2R` (
  `id` int(25) unsigned NOT NULL AUTO_INCREMENT,
  `bead_id` varchar(50) DEFAULT NULL,
  `tag` varchar(35) DEFAULT NULL,
  `chromosome` varchar(25) DEFAULT NULL,
  `startx` int(25) DEFAULT NULL,
  `endx` int(25) DEFAULT NULL,
  `sequence` varchar(255) DEFAULT NULL,
  `strand` varchar(5) DEFAULT NULL,
  `length` int(10) DEFAULT NULL,
  `paired_matches` int(10) DEFAULT NULL,
  `chr_length` int(10) DEFAULT NULL,
  `chr_center` int(50) DEFAULT NULL,
  `start_end_seq` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bead_id` (`bead_id`),
  KEY `start_end_seq` (`start_end_seq`),
  KEY `chr_length` (`chr_length`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table drosophila_2Rresults_2RHet
# ------------------------------------------------------------

DROP TABLE IF EXISTS `drosophila_2Rresults_2RHet`;

CREATE TABLE `drosophila_2Rresults_2RHet` (
  `id` int(25) unsigned NOT NULL AUTO_INCREMENT,
  `bead_id` varchar(50) DEFAULT NULL,
  `tag` varchar(35) DEFAULT NULL,
  `chromosome` varchar(25) DEFAULT NULL,
  `startx` int(25) DEFAULT NULL,
  `endx` int(25) DEFAULT NULL,
  `sequence` varchar(255) DEFAULT NULL,
  `strand` varchar(5) DEFAULT NULL,
  `length` int(10) DEFAULT NULL,
  `paired_matches` int(10) DEFAULT NULL,
  `chr_length` int(10) DEFAULT NULL,
  `chr_center` int(50) DEFAULT NULL,
  `start_end_seq` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bead_id` (`bead_id`),
  KEY `start_end_seq` (`start_end_seq`),
  KEY `chr_length` (`chr_length`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table drosophila_2Rresults_3L
# ------------------------------------------------------------

DROP TABLE IF EXISTS `drosophila_2Rresults_3L`;

CREATE TABLE `drosophila_2Rresults_3L` (
  `id` int(25) unsigned NOT NULL AUTO_INCREMENT,
  `bead_id` varchar(50) DEFAULT NULL,
  `tag` varchar(35) DEFAULT NULL,
  `chromosome` varchar(25) DEFAULT NULL,
  `startx` int(25) DEFAULT NULL,
  `endx` int(25) DEFAULT NULL,
  `sequence` varchar(255) DEFAULT NULL,
  `strand` varchar(5) DEFAULT NULL,
  `length` int(10) DEFAULT NULL,
  `paired_matches` int(10) DEFAULT NULL,
  `chr_length` int(10) DEFAULT NULL,
  `chr_center` int(50) DEFAULT NULL,
  `start_end_seq` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bead_id` (`bead_id`),
  KEY `start_end_seq` (`start_end_seq`),
  KEY `chr_length` (`chr_length`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table drosophila_2Rresults_3LHet
# ------------------------------------------------------------

DROP TABLE IF EXISTS `drosophila_2Rresults_3LHet`;

CREATE TABLE `drosophila_2Rresults_3LHet` (
  `id` int(25) unsigned NOT NULL AUTO_INCREMENT,
  `bead_id` varchar(50) DEFAULT NULL,
  `tag` varchar(35) DEFAULT NULL,
  `chromosome` varchar(25) DEFAULT NULL,
  `startx` int(25) DEFAULT NULL,
  `endx` int(25) DEFAULT NULL,
  `sequence` varchar(255) DEFAULT NULL,
  `strand` varchar(5) DEFAULT NULL,
  `length` int(10) DEFAULT NULL,
  `paired_matches` int(10) DEFAULT NULL,
  `chr_length` int(10) DEFAULT NULL,
  `chr_center` int(50) DEFAULT NULL,
  `start_end_seq` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bead_id` (`bead_id`),
  KEY `start_end_seq` (`start_end_seq`),
  KEY `chr_length` (`chr_length`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table drosophila_2Rresults_3R
# ------------------------------------------------------------

DROP TABLE IF EXISTS `drosophila_2Rresults_3R`;

CREATE TABLE `drosophila_2Rresults_3R` (
  `id` int(25) unsigned NOT NULL AUTO_INCREMENT,
  `bead_id` varchar(50) DEFAULT NULL,
  `tag` varchar(35) DEFAULT NULL,
  `chromosome` varchar(25) DEFAULT NULL,
  `startx` int(25) DEFAULT NULL,
  `endx` int(25) DEFAULT NULL,
  `sequence` varchar(255) DEFAULT NULL,
  `strand` varchar(5) DEFAULT NULL,
  `length` int(10) DEFAULT NULL,
  `paired_matches` int(10) DEFAULT NULL,
  `chr_length` int(10) DEFAULT NULL,
  `chr_center` int(50) DEFAULT NULL,
  `start_end_seq` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bead_id` (`bead_id`),
  KEY `start_end_seq` (`start_end_seq`),
  KEY `chr_length` (`chr_length`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table drosophila_2Rresults_3RHet
# ------------------------------------------------------------

DROP TABLE IF EXISTS `drosophila_2Rresults_3RHet`;

CREATE TABLE `drosophila_2Rresults_3RHet` (
  `id` int(25) unsigned NOT NULL AUTO_INCREMENT,
  `bead_id` varchar(50) DEFAULT NULL,
  `tag` varchar(35) DEFAULT NULL,
  `chromosome` varchar(25) DEFAULT NULL,
  `startx` int(25) DEFAULT NULL,
  `endx` int(25) DEFAULT NULL,
  `sequence` varchar(255) DEFAULT NULL,
  `strand` varchar(5) DEFAULT NULL,
  `length` int(10) DEFAULT NULL,
  `paired_matches` int(10) DEFAULT NULL,
  `chr_length` int(10) DEFAULT NULL,
  `chr_center` int(50) DEFAULT NULL,
  `start_end_seq` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bead_id` (`bead_id`),
  KEY `start_end_seq` (`start_end_seq`),
  KEY `chr_length` (`chr_length`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table drosophila_2Rresults_4
# ------------------------------------------------------------

DROP TABLE IF EXISTS `drosophila_2Rresults_4`;

CREATE TABLE `drosophila_2Rresults_4` (
  `id` int(25) unsigned NOT NULL AUTO_INCREMENT,
  `bead_id` varchar(50) DEFAULT NULL,
  `tag` varchar(35) DEFAULT NULL,
  `chromosome` varchar(25) DEFAULT NULL,
  `startx` int(25) DEFAULT NULL,
  `endx` int(25) DEFAULT NULL,
  `sequence` varchar(255) DEFAULT NULL,
  `strand` varchar(5) DEFAULT NULL,
  `length` int(10) DEFAULT NULL,
  `paired_matches` int(10) DEFAULT NULL,
  `chr_length` int(10) DEFAULT NULL,
  `chr_center` int(50) DEFAULT NULL,
  `start_end_seq` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bead_id` (`bead_id`),
  KEY `start_end_seq` (`start_end_seq`),
  KEY `chr_length` (`chr_length`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table drosophila_2Rresults_dmel_mitochondrion_genome
# ------------------------------------------------------------

DROP TABLE IF EXISTS `drosophila_2Rresults_dmel_mitochondrion_genome`;

CREATE TABLE `drosophila_2Rresults_dmel_mitochondrion_genome` (
  `id` int(25) unsigned NOT NULL AUTO_INCREMENT,
  `bead_id` varchar(50) DEFAULT NULL,
  `tag` varchar(35) DEFAULT NULL,
  `chromosome` varchar(25) DEFAULT NULL,
  `startx` int(25) DEFAULT NULL,
  `endx` int(25) DEFAULT NULL,
  `sequence` varchar(255) DEFAULT NULL,
  `strand` varchar(5) DEFAULT NULL,
  `length` int(10) DEFAULT NULL,
  `paired_matches` int(10) DEFAULT NULL,
  `chr_length` int(10) DEFAULT NULL,
  `chr_center` int(50) DEFAULT NULL,
  `start_end_seq` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bead_id` (`bead_id`),
  KEY `start_end_seq` (`start_end_seq`),
  KEY `chr_length` (`chr_length`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table drosophila_2Rresults_U
# ------------------------------------------------------------

DROP TABLE IF EXISTS `drosophila_2Rresults_U`;

CREATE TABLE `drosophila_2Rresults_U` (
  `id` int(25) unsigned NOT NULL AUTO_INCREMENT,
  `bead_id` varchar(50) DEFAULT NULL,
  `tag` varchar(35) DEFAULT NULL,
  `chromosome` varchar(25) DEFAULT NULL,
  `startx` int(25) DEFAULT NULL,
  `endx` int(25) DEFAULT NULL,
  `sequence` varchar(255) DEFAULT NULL,
  `strand` varchar(5) DEFAULT NULL,
  `length` int(10) DEFAULT NULL,
  `paired_matches` int(10) DEFAULT NULL,
  `chr_length` int(10) DEFAULT NULL,
  `chr_center` int(50) DEFAULT NULL,
  `start_end_seq` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bead_id` (`bead_id`),
  KEY `start_end_seq` (`start_end_seq`),
  KEY `chr_length` (`chr_length`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table drosophila_2Rresults_Uextra
# ------------------------------------------------------------

DROP TABLE IF EXISTS `drosophila_2Rresults_Uextra`;

CREATE TABLE `drosophila_2Rresults_Uextra` (
  `id` int(25) unsigned NOT NULL AUTO_INCREMENT,
  `bead_id` varchar(50) DEFAULT NULL,
  `tag` varchar(35) DEFAULT NULL,
  `chromosome` varchar(25) DEFAULT NULL,
  `startx` int(25) DEFAULT NULL,
  `endx` int(25) DEFAULT NULL,
  `sequence` varchar(255) DEFAULT NULL,
  `strand` varchar(5) DEFAULT NULL,
  `length` int(10) DEFAULT NULL,
  `paired_matches` int(10) DEFAULT NULL,
  `chr_length` int(10) DEFAULT NULL,
  `chr_center` int(50) DEFAULT NULL,
  `start_end_seq` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bead_id` (`bead_id`),
  KEY `start_end_seq` (`start_end_seq`),
  KEY `chr_length` (`chr_length`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table drosophila_2Rresults_X
# ------------------------------------------------------------

DROP TABLE IF EXISTS `drosophila_2Rresults_X`;

CREATE TABLE `drosophila_2Rresults_X` (
  `id` int(25) unsigned NOT NULL AUTO_INCREMENT,
  `bead_id` varchar(50) DEFAULT NULL,
  `tag` varchar(35) DEFAULT NULL,
  `chromosome` varchar(25) DEFAULT NULL,
  `startx` int(25) DEFAULT NULL,
  `endx` int(25) DEFAULT NULL,
  `sequence` varchar(255) DEFAULT NULL,
  `strand` varchar(5) DEFAULT NULL,
  `length` int(10) DEFAULT NULL,
  `paired_matches` int(10) DEFAULT NULL,
  `chr_length` int(10) DEFAULT NULL,
  `chr_center` int(50) DEFAULT NULL,
  `start_end_seq` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bead_id` (`bead_id`),
  KEY `start_end_seq` (`start_end_seq`),
  KEY `chr_length` (`chr_length`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table drosophila_2Rresults_XHet
# ------------------------------------------------------------

DROP TABLE IF EXISTS `drosophila_2Rresults_XHet`;

CREATE TABLE `drosophila_2Rresults_XHet` (
  `id` int(25) unsigned NOT NULL AUTO_INCREMENT,
  `bead_id` varchar(50) DEFAULT NULL,
  `tag` varchar(35) DEFAULT NULL,
  `chromosome` varchar(25) DEFAULT NULL,
  `startx` int(25) DEFAULT NULL,
  `endx` int(25) DEFAULT NULL,
  `sequence` varchar(255) DEFAULT NULL,
  `strand` varchar(5) DEFAULT NULL,
  `length` int(10) DEFAULT NULL,
  `paired_matches` int(10) DEFAULT NULL,
  `chr_length` int(10) DEFAULT NULL,
  `chr_center` int(50) DEFAULT NULL,
  `start_end_seq` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bead_id` (`bead_id`),
  KEY `start_end_seq` (`start_end_seq`),
  KEY `chr_length` (`chr_length`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table drosophila_2Rresults_YHet
# ------------------------------------------------------------

DROP TABLE IF EXISTS `drosophila_2Rresults_YHet`;

CREATE TABLE `drosophila_2Rresults_YHet` (
  `id` int(25) unsigned NOT NULL AUTO_INCREMENT,
  `bead_id` varchar(50) DEFAULT NULL,
  `tag` varchar(35) DEFAULT NULL,
  `chromosome` varchar(25) DEFAULT NULL,
  `startx` int(25) DEFAULT NULL,
  `endx` int(25) DEFAULT NULL,
  `sequence` varchar(255) DEFAULT NULL,
  `strand` varchar(5) DEFAULT NULL,
  `length` int(10) DEFAULT NULL,
  `paired_matches` int(10) DEFAULT NULL,
  `chr_length` int(10) DEFAULT NULL,
  `chr_center` int(50) DEFAULT NULL,
  `start_end_seq` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bead_id` (`bead_id`),
  KEY `start_end_seq` (`start_end_seq`),
  KEY `chr_length` (`chr_length`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table drosophila_ALL_Results
# ------------------------------------------------------------

DROP TABLE IF EXISTS `drosophila_ALL_Results`;

CREATE TABLE `drosophila_ALL_Results` (
  `id` int(25) unsigned NOT NULL AUTO_INCREMENT,
  `bead_id` varchar(50) DEFAULT NULL,
  `tag` varchar(35) DEFAULT NULL,
  `chromosome` varchar(25) DEFAULT NULL,
  `startx` int(25) DEFAULT NULL,
  `endx` int(25) DEFAULT NULL,
  `sequence` varchar(255) DEFAULT NULL,
  `strand` varchar(5) DEFAULT NULL,
  `length` int(10) DEFAULT NULL,
  `paired_matches` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bead_id` (`bead_id`),
  KEY `chromosome` (`chromosome`),
  KEY `paired_matches` (`paired_matches`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `drosophila_ALL_Results` WRITE;
/*!40000 ALTER TABLE `drosophila_ALL_Results` DISABLE KEYS */;

INSERT INTO `drosophila_ALL_Results` (`id`, `bead_id`, `tag`, `chromosome`, `startx`, `endx`, `sequence`, `strand`, `length`, `paired_matches`, `chr_length`, `chr_center`)
VALUES
	(1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

/*!40000 ALTER TABLE `drosophila_ALL_Results` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table drosophila_X_Results
# ------------------------------------------------------------

DROP TABLE IF EXISTS `drosophila_X_Results`;

CREATE TABLE `drosophila_X_Results` (
  `id` int(25) unsigned NOT NULL AUTO_INCREMENT,
  `bead_id` varchar(50) DEFAULT NULL,
  `tag` varchar(35) DEFAULT NULL,
  `chromosome` varchar(25) DEFAULT NULL,
  `startx` int(25) DEFAULT NULL,
  `endx` int(25) DEFAULT NULL,
  `sequence` varchar(255) DEFAULT NULL,
  `strand` varchar(5) DEFAULT NULL,
  `length` int(10) DEFAULT NULL,
  `paired_matches` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bead_id` (`bead_id`),
  KEY `chromosome` (`chromosome`),
  KEY `paired_matches` (`paired_matches`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
