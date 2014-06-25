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

DROP TABLE IF EXISTS `X_read_scores`;

CREATE TABLE `X_read_scores` (
  `id` int(250) unsigned NOT NULL AUTO_INCREMENT,
  `1_chr` float DEFAULT '0',
  `2_chr` float DEFAULT '0',
  `3_chr` float DEFAULT '0',
  `4_chr` float DEFAULT '0',
  `5_chr` float DEFAULT '0',
  `6_chr` float DEFAULT '0',
  `7_chr` float DEFAULT '0',
  `8_chr` float DEFAULT '0',
  `9_chr` float DEFAULT '0',
  `10_chr` float DEFAULT '0',
  `11_chr` float DEFAULT '0',
  `12_chr` float DEFAULT '0',
  `13_chr` float DEFAULT '0',
  `14_chr` float DEFAULT '0',
  `15_chr` float DEFAULT '0',
  `16_chr` float DEFAULT '0',
  `17_chr` float DEFAULT '0',
  `18_chr` float DEFAULT '0',
  `19_chr` float DEFAULT '0',
  `20_chr` float DEFAULT '0',
  `21_chr` float DEFAULT '0',
  `22_chr` float DEFAULT '0',
  `X_chr` float DEFAULT '0',
  `Y_chr` float DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
