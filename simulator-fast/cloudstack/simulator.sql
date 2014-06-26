-- MySQL dump 10.13  Distrib 5.6.17, for osx10.9 (x86_64)
--
-- Host: 127.0.0.1    Database: simulator
-- ------------------------------------------------------
-- Server version	5.1.73

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
-- Table structure for table `mockconfiguration`
--

DROP TABLE IF EXISTS `mockconfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mockconfiguration` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `data_center_id` bigint(20) unsigned DEFAULT NULL,
  `pod_id` bigint(20) unsigned DEFAULT NULL,
  `cluster_id` bigint(20) unsigned DEFAULT NULL,
  `host_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `values` varchar(4096) DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  `json_response` varchar(4096) DEFAULT NULL,
  `removed` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mockconfiguration`
--

LOCK TABLES `mockconfiguration` WRITE;
/*!40000 ALTER TABLE `mockconfiguration` DISABLE KEYS */;
/*!40000 ALTER TABLE `mockconfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mockhost`
--

DROP TABLE IF EXISTS `mockhost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mockhost` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `private_ip_address` char(40) DEFAULT NULL,
  `private_mac_address` varchar(17) DEFAULT NULL,
  `private_netmask` varchar(15) DEFAULT NULL,
  `storage_ip_address` char(40) DEFAULT NULL,
  `storage_netmask` varchar(15) DEFAULT NULL,
  `storage_mac_address` varchar(17) DEFAULT NULL,
  `public_ip_address` char(40) DEFAULT NULL,
  `public_netmask` varchar(15) DEFAULT NULL,
  `public_mac_address` varchar(17) DEFAULT NULL,
  `guid` varchar(255) DEFAULT NULL,
  `version` varchar(40) NOT NULL,
  `data_center_id` bigint(20) unsigned NOT NULL,
  `pod_id` bigint(20) unsigned DEFAULT NULL,
  `cluster_id` bigint(20) unsigned DEFAULT NULL COMMENT 'foreign key to cluster',
  `cpus` int(10) unsigned DEFAULT NULL,
  `speed` int(10) unsigned DEFAULT NULL,
  `ram` bigint(20) unsigned DEFAULT NULL,
  `capabilities` varchar(255) DEFAULT NULL COMMENT 'host capabilities in comma separated list',
  `vm_id` bigint(20) unsigned DEFAULT NULL,
  `resource` varchar(255) DEFAULT NULL COMMENT 'If it is a local resource, this is the class name',
  PRIMARY KEY (`id`),
  UNIQUE KEY `guid` (`guid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mockhost`
--

LOCK TABLES `mockhost` WRITE;
/*!40000 ALTER TABLE `mockhost` DISABLE KEYS */;
INSERT INTO `mockhost` VALUES (1,'SimulatedAgent.3589437a-d614-469f-a527-e1d747239b56','172.16.15.20','00:00:00:00:00:00',NULL,'172.16.15.20',NULL,'00:00:00:00:00:00','172.16.15.20',NULL,'00:00:00:00:00:00','3589437a-d614-469f-a527-e1d747239b56','4.4.0-SNAPSHOT',1,1,1,4,8000,8589934592,'hvm',0,'com.cloud.agent.AgentRoutingResource'),(2,'SimulatedAgent.5ce7d19f-3469-4f1f-aa11-44740d75db4b','172.16.15.16','00:00:00:00:00:00',NULL,'172.16.15.16',NULL,'00:00:00:00:00:00','172.16.15.16',NULL,'00:00:00:00:00:00','5ce7d19f-3469-4f1f-aa11-44740d75db4b','4.4.0-SNAPSHOT',1,1,1,4,8000,8589934592,'hvm',0,'com.cloud.agent.AgentRoutingResource'),(3,'SimulatedAgent.a1532e2b-8e2b-4801-a940-c829493f02bf','172.16.15.18','00:00:00:00:00:00',NULL,'172.16.15.18',NULL,'00:00:00:00:00:00','172.16.15.18',NULL,'00:00:00:00:00:00','a1532e2b-8e2b-4801-a940-c829493f02bf','4.4.0-SNAPSHOT',1,1,2,4,8000,8589934592,'hvm',0,'com.cloud.agent.AgentRoutingResource'),(4,'s-2-VM','172.16.15.36','06:6e:d4:00:00:23',NULL,'172.16.15.36',NULL,'06:6e:d4:00:00:23','172.16.15.36',NULL,'06:6e:d4:00:00:23','SystemVM-b6e28661-fc5a-4718-a3b4-d642675842c1','4.4.0-SNAPSHOT',1,1,NULL,4,8000,8589934592,NULL,2,'com.cloud.agent.AgentStorageResource');
/*!40000 ALTER TABLE `mockhost` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mocksecstorage`
--

DROP TABLE IF EXISTS `mocksecstorage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mocksecstorage` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `url` varchar(255) DEFAULT NULL,
  `capacity` bigint(20) unsigned DEFAULT NULL,
  `mount_point` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mocksecstorage`
--

LOCK TABLES `mocksecstorage` WRITE;
/*!40000 ALTER TABLE `mocksecstorage` DISABLE KEYS */;
INSERT INTO `mocksecstorage` VALUES (1,'nfs://10.147.28.6:/export/home/sandbox/secondary',1099511627776,'/mnt/05b33ef7-da6a-33eb-9981-b4efb90ed99b/');
/*!40000 ALTER TABLE `mocksecstorage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mocksecurityrules`
--

DROP TABLE IF EXISTS `mocksecurityrules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mocksecurityrules` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `vmid` bigint(20) unsigned DEFAULT NULL,
  `signature` varchar(255) DEFAULT NULL,
  `ruleset` varchar(4095) DEFAULT NULL,
  `hostid` varchar(255) DEFAULT NULL,
  `seqnum` bigint(20) unsigned DEFAULT NULL,
  `vmname` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `i_mocksecurityrules__vmid` (`vmid`),
  KEY `i_mocksecurityrules__hostid` (`hostid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mocksecurityrules`
--

LOCK TABLES `mocksecurityrules` WRITE;
/*!40000 ALTER TABLE `mocksecurityrules` DISABLE KEYS */;
/*!40000 ALTER TABLE `mocksecurityrules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mockstoragepool`
--

DROP TABLE IF EXISTS `mockstoragepool`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mockstoragepool` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `guid` varchar(255) DEFAULT NULL,
  `mount_point` varchar(255) DEFAULT NULL,
  `capacity` bigint(20) DEFAULT NULL,
  `pool_type` varchar(40) DEFAULT NULL,
  `hostguid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hostguid` (`hostguid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mockstoragepool`
--

LOCK TABLES `mockstoragepool` WRITE;
/*!40000 ALTER TABLE `mockstoragepool` DISABLE KEYS */;
INSERT INTO `mockstoragepool` VALUES (1,'587f7d31-17a3-4d90-8b34-02fba2817cc0','/mnt/587f7d31-17a3-4d90-8b34-02fba2817cc0',1099511627776,'Filesystem','3589437a-d614-469f-a527-e1d747239b56'),(2,'a67570b8-3af1-4060-9b7a-b85f577c522f','/mnt/a67570b8-3af1-4060-9b7a-b85f577c522f',1099511627776,'Filesystem','5ce7d19f-3469-4f1f-aa11-44740d75db4b'),(3,'7c07ec9b-a3c6-3466-ab5a-f5669ead0b22','/mnt/7c07ec9b-a3c6-3466-ab5a-f5669ead0b22',1099511627776,'NetworkFilesystem',NULL),(4,'cd360613-e1cf-3a32-b8ef-d07bad8dd92b','/mnt/cd360613-e1cf-3a32-b8ef-d07bad8dd92b',1099511627776,'NetworkFilesystem',NULL),(5,'07208434-0a75-421e-bc96-f46255cd291a','/mnt/07208434-0a75-421e-bc96-f46255cd291a',1099511627776,'Filesystem','a1532e2b-8e2b-4801-a940-c829493f02bf'),(6,'0bbd54fe-b348-3e3d-9b91-b453a21bc43a','/mnt/0bbd54fe-b348-3e3d-9b91-b453a21bc43a',1099511627776,'NetworkFilesystem',NULL);
/*!40000 ALTER TABLE `mockstoragepool` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mockvm`
--

DROP TABLE IF EXISTS `mockvm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mockvm` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `host_id` bigint(20) unsigned DEFAULT NULL,
  `type` varchar(40) DEFAULT NULL,
  `state` varchar(40) DEFAULT NULL,
  `vnc_port` bigint(20) unsigned DEFAULT NULL,
  `memory` bigint(20) unsigned DEFAULT NULL,
  `cpu` bigint(20) unsigned DEFAULT NULL,
  `bootargs` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `i_mockvm__host_id` (`host_id`),
  KEY `i_mockvm__state` (`state`),
  KEY `i_mockvm__type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mockvm`
--

LOCK TABLES `mockvm` WRITE;
/*!40000 ALTER TABLE `mockvm` DISABLE KEYS */;
INSERT INTO `mockvm` VALUES (1,'v-1-VM',1,'ConsoleProxy','Running',0,1073741824,500,' template=domP type=consoleproxy host=192.168.1.10 port=8250 name=v-1-VM zone=1 pod=1 guid=Proxy.1 proxy_vm=1 disable_rp_filter=true eth2ip=192.168.2.2 eth2mask=255.255.255.0 gateway=192.168.2.1 eth0ip=169.254.2.35 eth0mask=255.255.0.0 eth1ip=172.16.15.98'),(2,'s-2-VM',3,'SecondaryStorageVm','Running',0,536870912,500,' template=domP type=secstorage host=192.168.1.10 port=8250 name=s-2-VM zone=1 pod=1 guid=s-2-VM resource=org.apache.cloudstack.storage.resource.NfsSecondaryStorageResource instance=SecStorage sslcopy=false role=templateProcessor mtu=1500 eth2ip=192.168.2.');
/*!40000 ALTER TABLE `mockvm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mockvolume`
--

DROP TABLE IF EXISTS `mockvolume`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mockvolume` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `pool_id` bigint(20) unsigned DEFAULT NULL,
  `type` varchar(40) DEFAULT NULL,
  `status` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `i_mockvolume__pool_id` (`pool_id`),
  KEY `i_mockvolume__status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mockvolume`
--

LOCK TABLES `mockvolume` WRITE;
/*!40000 ALTER TABLE `mockvolume` DISABLE KEYS */;
INSERT INTO `mockvolume` VALUES (1,'simulator-domR',2147483648,'/mnt/05b33ef7-da6a-33eb-9981-b4efb90ed99b/template/tmpl/1/100/ef306513-04bd-4f9b-a56b-13e87ce00d77',1,'TEMPLATE','DOWNLOADED'),(2,'simulator-Centos',2147483648,'/mnt/05b33ef7-da6a-33eb-9981-b4efb90ed99b/template/tmpl/1/111/31f775d1-2df3-4a61-ae25-3ceb8379d828',1,'TEMPLATE','DOWNLOADED');
/*!40000 ALTER TABLE `mockvolume` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-06-26  3:47:41
