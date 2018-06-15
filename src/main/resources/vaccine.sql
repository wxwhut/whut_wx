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
DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client= @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(20) AUTO_INCREMENT COMMENT 'ID' ,
  `username` varchar(255) DEFAULT NULL COMMENT '账号',
  `password` varchar(255) DEFAULT NULL COMMENT '密码',
  `leveltype` varchar(255) DEFAULT '1' COMMENT '权限',
  `email` varchar(255) DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(255) DEFAULT NULL COMMENT '电话',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin','admin','0','admin','admin'),(2,'zc','123456','0','505724935@qq.com','15271835172'),(3,'张聪','123456','1','505724935@qq.com','15271835172'),(4,'王旭','123456','1','2755317032@qq.com','18955317032');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `child`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `child` (
  `id` int(20) AUTO_INCREMENT COMMENT 'ID' ,
   `childname` varchar(255) DEFAULT NULL COMMENT '孩子姓名',
   `parentid` int(20) DEFAULT NULL COMMENT '抚养人ID',
   `birthday` varchar(255) DEFAULT NULL COMMENT '生日',
   `statement` varchar(255) DEFAULT '*' COMMENT '接种情况',
   PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `child` WRITE;
/*!40000 ALTER TABLE `child` DISABLE KEYS */;
INSERT INTO `child` VALUES (1,'张聪明',3,'2000-01-01','1_2017-05-01,2_2017-03-01');
/*!40000 ALTER TABLE `child` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `vaccine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vaccine` (
  `id` int(20) COMMENT 'ID' ,
   `vaccinename` varchar(255) DEFAULT NULL COMMENT '疫苗名称',
   `makeday` varchar(255) DEFAULT NULL COMMENT '生产日期',
   `keepday` varchar(255) DEFAULT NULL COMMENT '保质日期',
   `price` double(20,2)  DEFAULT 0.00 COMMENT  '价格',
   `introduce` varchar(255) DEFAULT NULL COMMENT '功能介绍',
   `pnumber` int(20) DEFAULT 0 COMMENT '已接种人数',
   PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `vaccine` WRITE;
/*!40000 ALTER TABLE `vaccine` DISABLE KEYS */;
INSERT INTO `vaccine` VALUES (1,'水痘疫苗','2017-01-01','2018-01-01',160.00,'水痘疫苗是经水痘病毒传代毒株制备而成，是预防水痘感染的唯一手段。接种水痘疫苗不仅能预防水痘，还能预防因水痘带状疱疹而引起的并发症。',1);
INSERT INTO `vaccine` VALUES (2,'乙肝疫苗','2017-02-01','2018-04-01',100.00,'乙肝疫苗是一种预防乙型肝炎的疫苗。即从乙型肝炎病毒携带者血浆中分离乙肝表面抗原(HbsAg)，经处理后而制成。乙肝疫苗接种后，可刺激免疫系统产生保护性抗体，这种抗体存在于人的体液之中，乙肝病毒一旦出现，抗体会立即作用，将其清除，阻止感染，并不会伤害肝脏，从而使人体具有了预防乙肝的免疫力。因此乙肝疫苗成为生活中不可缺少的一把保护伞。 预防一般至少可持续12年，因此，一般人群不需要进行抗-HBs监测或加强免疫。但对高危人群可进行抗-HBs监测，如抗-HBs<10mIU/ml，可给予加强免疫。',1);
/*!40000 ALTER TABLE `vaccine` ENABLE KEYS */;
UNLOCK TABLES;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;