-- MySQL dump 10.13  Distrib 5.6.17, for osx10.9 (x86_64)
--
-- Host: 127.0.0.1    Database: cloud
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
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `account_name` varchar(100) DEFAULT NULL COMMENT 'an account name set by the creator of the account, defaults to username for single accounts',
  `uuid` varchar(40) DEFAULT NULL,
  `type` int(1) unsigned NOT NULL,
  `domain_id` bigint(20) unsigned DEFAULT NULL,
  `state` varchar(10) NOT NULL DEFAULT 'enabled',
  `removed` datetime DEFAULT NULL COMMENT 'date removed',
  `cleanup_needed` tinyint(1) NOT NULL DEFAULT '0',
  `network_domain` varchar(255) DEFAULT NULL,
  `default_zone_id` bigint(20) unsigned DEFAULT NULL,
  `default` int(1) unsigned NOT NULL DEFAULT '0' COMMENT '1 if account is default',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_account__uuid` (`uuid`),
  KEY `i_account__removed` (`removed`),
  KEY `fk_account__default_zone_id` (`default_zone_id`),
  KEY `i_account__cleanup_needed` (`cleanup_needed`),
  KEY `i_account__account_name__domain_id__removed` (`account_name`,`domain_id`,`removed`),
  KEY `i_account__domain_id` (`domain_id`),
  CONSTRAINT `fk_account__default_zone_id` FOREIGN KEY (`default_zone_id`) REFERENCES `data_center` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_account__domain_id` FOREIGN KEY (`domain_id`) REFERENCES `domain` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES (1,'system','ae61bfac-fcd8-11e3-9019-080027ce083d',1,1,'enabled',NULL,0,NULL,NULL,1),(2,'admin','ae61cb50-fcd8-11e3-9019-080027ce083d',1,1,'enabled',NULL,0,NULL,NULL,1);
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_details`
--

DROP TABLE IF EXISTS `account_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` bigint(20) unsigned NOT NULL COMMENT 'account id',
  `name` varchar(255) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_account_details__account_id` (`account_id`),
  CONSTRAINT `fk_account_details__account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_details`
--

LOCK TABLES `account_details` WRITE;
/*!40000 ALTER TABLE `account_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `account_netstats_view`
--

DROP TABLE IF EXISTS `account_netstats_view`;
/*!50001 DROP VIEW IF EXISTS `account_netstats_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `account_netstats_view` (
  `account_id` tinyint NOT NULL,
  `bytesReceived` tinyint NOT NULL,
  `bytesSent` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `account_network_ref`
--

DROP TABLE IF EXISTS `account_network_ref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_network_ref` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `account_id` bigint(20) unsigned NOT NULL COMMENT 'account id',
  `network_id` bigint(20) unsigned NOT NULL COMMENT 'network id',
  `is_owner` smallint(1) NOT NULL COMMENT 'is the owner of the network',
  PRIMARY KEY (`id`),
  KEY `fk_account_network_ref__account_id` (`account_id`),
  KEY `fk_account_network_ref__networks_id` (`network_id`),
  CONSTRAINT `fk_account_network_ref__account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_account_network_ref__networks_id` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_network_ref`
--

LOCK TABLES `account_network_ref` WRITE;
/*!40000 ALTER TABLE `account_network_ref` DISABLE KEYS */;
INSERT INTO `account_network_ref` VALUES (1,1,200,1),(2,1,201,1),(3,1,202,1),(4,1,203,1);
/*!40000 ALTER TABLE `account_network_ref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `account_view`
--

DROP TABLE IF EXISTS `account_view`;
/*!50001 DROP VIEW IF EXISTS `account_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `account_view` (
  `id` tinyint NOT NULL,
  `uuid` tinyint NOT NULL,
  `account_name` tinyint NOT NULL,
  `type` tinyint NOT NULL,
  `state` tinyint NOT NULL,
  `removed` tinyint NOT NULL,
  `cleanup_needed` tinyint NOT NULL,
  `network_domain` tinyint NOT NULL,
  `default` tinyint NOT NULL,
  `domain_id` tinyint NOT NULL,
  `domain_uuid` tinyint NOT NULL,
  `domain_name` tinyint NOT NULL,
  `domain_path` tinyint NOT NULL,
  `data_center_id` tinyint NOT NULL,
  `data_center_uuid` tinyint NOT NULL,
  `data_center_name` tinyint NOT NULL,
  `bytesReceived` tinyint NOT NULL,
  `bytesSent` tinyint NOT NULL,
  `vmLimit` tinyint NOT NULL,
  `vmTotal` tinyint NOT NULL,
  `runningVms` tinyint NOT NULL,
  `stoppedVms` tinyint NOT NULL,
  `ipLimit` tinyint NOT NULL,
  `ipTotal` tinyint NOT NULL,
  `ipFree` tinyint NOT NULL,
  `volumeLimit` tinyint NOT NULL,
  `volumeTotal` tinyint NOT NULL,
  `snapshotLimit` tinyint NOT NULL,
  `snapshotTotal` tinyint NOT NULL,
  `templateLimit` tinyint NOT NULL,
  `templateTotal` tinyint NOT NULL,
  `vpcLimit` tinyint NOT NULL,
  `vpcTotal` tinyint NOT NULL,
  `projectLimit` tinyint NOT NULL,
  `projectTotal` tinyint NOT NULL,
  `networkLimit` tinyint NOT NULL,
  `networkTotal` tinyint NOT NULL,
  `cpuLimit` tinyint NOT NULL,
  `cpuTotal` tinyint NOT NULL,
  `memoryLimit` tinyint NOT NULL,
  `memoryTotal` tinyint NOT NULL,
  `primaryStorageLimit` tinyint NOT NULL,
  `primaryStorageTotal` tinyint NOT NULL,
  `secondaryStorageLimit` tinyint NOT NULL,
  `secondaryStorageTotal` tinyint NOT NULL,
  `job_id` tinyint NOT NULL,
  `job_uuid` tinyint NOT NULL,
  `job_status` tinyint NOT NULL,
  `job_account_id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `account_vlan_map`
--

DROP TABLE IF EXISTS `account_vlan_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_vlan_map` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` bigint(20) unsigned NOT NULL COMMENT 'account id. foreign key to account table',
  `vlan_db_id` bigint(20) unsigned NOT NULL COMMENT 'database id of vlan. foreign key to vlan table',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `i_account_vlan_map__account_id` (`account_id`),
  KEY `i_account_vlan_map__vlan_id` (`vlan_db_id`),
  CONSTRAINT `fk_account_vlan_map__account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_account_vlan_map__vlan_id` FOREIGN KEY (`vlan_db_id`) REFERENCES `vlan` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_vlan_map`
--

LOCK TABLES `account_vlan_map` WRITE;
/*!40000 ALTER TABLE `account_vlan_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_vlan_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `account_vmstats_view`
--

DROP TABLE IF EXISTS `account_vmstats_view`;
/*!50001 DROP VIEW IF EXISTS `account_vmstats_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `account_vmstats_view` (
  `account_id` tinyint NOT NULL,
  `state` tinyint NOT NULL,
  `vmcount` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `account_vnet_map`
--

DROP TABLE IF EXISTS `account_vnet_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_vnet_map` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) DEFAULT NULL,
  `vnet_range` varchar(255) NOT NULL COMMENT 'dedicated guest vlan range',
  `account_id` bigint(20) unsigned NOT NULL COMMENT 'account id. foreign key to account table',
  `physical_network_id` bigint(20) unsigned NOT NULL COMMENT 'physical network id. foreign key to the the physical network table',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `i_account_vnet_map__physical_network_id` (`physical_network_id`),
  KEY `i_account_vnet_map__account_id` (`account_id`),
  CONSTRAINT `fk_account_vnet_map__physical_network_id` FOREIGN KEY (`physical_network_id`) REFERENCES `physical_network` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_account_vnet_map__account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_vnet_map`
--

LOCK TABLES `account_vnet_map` WRITE;
/*!40000 ALTER TABLE `account_vnet_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_vnet_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `affinity_group`
--

DROP TABLE IF EXISTS `affinity_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `affinity_group` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `uuid` varchar(40) DEFAULT NULL,
  `description` varchar(4096) DEFAULT NULL,
  `domain_id` bigint(20) unsigned NOT NULL,
  `account_id` bigint(20) unsigned NOT NULL,
  `acl_type` varchar(15) NOT NULL COMMENT 'ACL access type. can be Account/Domain',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`account_id`),
  UNIQUE KEY `uc_affinity_group__uuid` (`uuid`),
  KEY `fk_affinity_group__account_id` (`account_id`),
  KEY `fk_affinity_group__domain_id` (`domain_id`),
  CONSTRAINT `fk_affinity_group__account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `fk_affinity_group__domain_id` FOREIGN KEY (`domain_id`) REFERENCES `domain` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `affinity_group`
--

LOCK TABLES `affinity_group` WRITE;
/*!40000 ALTER TABLE `affinity_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `affinity_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `affinity_group_domain_map`
--

DROP TABLE IF EXISTS `affinity_group_domain_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `affinity_group_domain_map` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `domain_id` bigint(20) unsigned NOT NULL COMMENT 'domain id',
  `affinity_group_id` bigint(20) unsigned NOT NULL COMMENT 'affinity group id',
  `subdomain_access` int(1) unsigned DEFAULT '1' COMMENT '1 if affinity group can be accessible from the subdomain',
  PRIMARY KEY (`id`),
  KEY `fk_affinity_group_domain_map__domain_id` (`domain_id`),
  KEY `fk_affinity_group_domain_map__affinity_group_id` (`affinity_group_id`),
  CONSTRAINT `fk_affinity_group_domain_map__domain_id` FOREIGN KEY (`domain_id`) REFERENCES `domain` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_affinity_group_domain_map__affinity_group_id` FOREIGN KEY (`affinity_group_id`) REFERENCES `affinity_group` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `affinity_group_domain_map`
--

LOCK TABLES `affinity_group_domain_map` WRITE;
/*!40000 ALTER TABLE `affinity_group_domain_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `affinity_group_domain_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `affinity_group_view`
--

DROP TABLE IF EXISTS `affinity_group_view`;
/*!50001 DROP VIEW IF EXISTS `affinity_group_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `affinity_group_view` (
  `id` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `type` tinyint NOT NULL,
  `description` tinyint NOT NULL,
  `uuid` tinyint NOT NULL,
  `acl_type` tinyint NOT NULL,
  `account_id` tinyint NOT NULL,
  `account_uuid` tinyint NOT NULL,
  `account_name` tinyint NOT NULL,
  `account_type` tinyint NOT NULL,
  `domain_id` tinyint NOT NULL,
  `domain_uuid` tinyint NOT NULL,
  `domain_name` tinyint NOT NULL,
  `domain_path` tinyint NOT NULL,
  `vm_id` tinyint NOT NULL,
  `vm_uuid` tinyint NOT NULL,
  `vm_name` tinyint NOT NULL,
  `vm_state` tinyint NOT NULL,
  `vm_display_name` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `affinity_group_vm_map`
--

DROP TABLE IF EXISTS `affinity_group_vm_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `affinity_group_vm_map` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `affinity_group_id` bigint(20) unsigned NOT NULL,
  `instance_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_agvm__group_id` (`affinity_group_id`),
  KEY `fk_affinity_group_vm_map___instance_id` (`instance_id`),
  CONSTRAINT `fk_agvm__group_id` FOREIGN KEY (`affinity_group_id`) REFERENCES `affinity_group` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_affinity_group_vm_map___instance_id` FOREIGN KEY (`instance_id`) REFERENCES `user_vm` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `affinity_group_vm_map`
--

LOCK TABLES `affinity_group_vm_map` WRITE;
/*!40000 ALTER TABLE `affinity_group_vm_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `affinity_group_vm_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alert`
--

DROP TABLE IF EXISTS `alert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alert` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(40) DEFAULT NULL,
  `type` int(1) unsigned NOT NULL,
  `cluster_id` bigint(20) unsigned DEFAULT NULL,
  `pod_id` bigint(20) unsigned DEFAULT NULL,
  `data_center_id` bigint(20) unsigned NOT NULL,
  `subject` varchar(999) DEFAULT NULL COMMENT 'according to SMTP spec, max subject length is 1000 including the CRLF character, so allow enough space to fit long pod/zone/host names',
  `sent_count` int(3) unsigned NOT NULL,
  `created` datetime DEFAULT NULL COMMENT 'when this alert type was created',
  `last_sent` datetime DEFAULT NULL COMMENT 'Last time the alert was sent',
  `resolved` datetime DEFAULT NULL COMMENT 'when the alert status was resolved (available memory no longer at critical level, etc.)',
  `archived` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) DEFAULT NULL COMMENT 'name of the alert',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_alert__uuid` (`uuid`),
  KEY `i_alert__last_sent` (`last_sent`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alert`
--

LOCK TABLES `alert` WRITE;
/*!40000 ALTER TABLE `alert` DISABLE KEYS */;
INSERT INTO `alert` VALUES (1,'ba1e1820-6c7a-4629-9930-be884e844c2d',14,NULL,0,0,'Management network CIDR is not configured originally. Set it default to 192.168.1.0/24',1,'2014-06-26 02:23:37','2014-06-26 02:23:37',NULL,0,'ALERT.MANAGEMENT'),(2,'5ab5a781-0ded-4afc-9bf8-d8219381c3dd',14,NULL,0,0,'Management server node 127.0.0.1 is up',1,'2014-06-26 02:24:40','2014-06-26 02:24:40',NULL,0,'ALERT.MANAGEMENT');
/*!40000 ALTER TABLE `alert` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `async_job`
--

DROP TABLE IF EXISTS `async_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `async_job` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `account_id` bigint(20) unsigned NOT NULL,
  `instance_type` varchar(64) DEFAULT NULL COMMENT 'instance_type and instance_id work together to allow attaching an instance object to a job',
  `instance_id` bigint(20) unsigned DEFAULT NULL,
  `job_cmd` varchar(255) DEFAULT NULL,
  `job_cmd_info` text COMMENT 'command parameter info',
  `job_cmd_ver` int(1) DEFAULT NULL COMMENT 'command version',
  `job_status` int(1) DEFAULT NULL COMMENT 'general job execution status',
  `job_process_status` int(1) DEFAULT NULL COMMENT 'job specific process status for asynchronize progress update',
  `job_result_code` int(1) DEFAULT NULL COMMENT 'job result code, specify error code corresponding to result message',
  `job_result` text COMMENT 'job result info',
  `job_init_msid` bigint(20) DEFAULT NULL COMMENT 'the initiating msid',
  `job_complete_msid` bigint(20) DEFAULT NULL COMMENT 'completing msid',
  `created` datetime DEFAULT NULL COMMENT 'date created',
  `last_updated` datetime DEFAULT NULL COMMENT 'date created',
  `last_polled` datetime DEFAULT NULL COMMENT 'date polled',
  `removed` datetime DEFAULT NULL COMMENT 'date removed',
  `uuid` varchar(40) DEFAULT NULL,
  `related` char(40) NOT NULL,
  `job_type` varchar(32) DEFAULT NULL,
  `job_dispatcher` varchar(64) DEFAULT NULL,
  `job_executing_msid` bigint(20) DEFAULT NULL,
  `job_pending_signals` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_async__uuid` (`uuid`),
  KEY `i_async_job__removed` (`removed`),
  KEY `i_async__user_id` (`user_id`),
  KEY `i_async__account_id` (`account_id`),
  KEY `i_async__instance_type_id` (`instance_type`,`instance_id`),
  KEY `i_async__job_cmd` (`job_cmd`),
  KEY `i_async__created` (`created`),
  KEY `i_async__last_updated` (`last_updated`),
  KEY `i_async__last_poll` (`last_polled`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `async_job`
--

LOCK TABLES `async_job` WRITE;
/*!40000 ALTER TABLE `async_job` DISABLE KEYS */;
INSERT INTO `async_job` VALUES (1,2,2,NULL,NULL,'org.apache.cloudstack.api.command.admin.network.CreatePhysicalNetworkCmd','{\"id\":\"200\",\"response\":\"json\",\"ctxDetails\":\"{\\\"com.cloud.network.PhysicalNetwork\\\":\\\"2fd65c1e-0d4e-4878-bdd2-a165892f4060\\\",\\\"com.cloud.dc.DataCenter\\\":\\\"695e478b-cb1e-448e-9b59-3643e1245f91\\\"}\",\"cmdEventType\":\"PHYSICAL.NETWORK.CREATE\",\"ctxUserId\":\"2\",\"zoneid\":\"695e478b-cb1e-448e-9b59-3643e1245f91\",\"name\":\"Sandbox-pnet\",\"httpmethod\":\"GET\",\"isolationmethods\":\"VLAN\",\"uuid\":\"2fd65c1e-0d4e-4878-bdd2-a165892f4060\",\"ctxAccountId\":\"2\",\"ctxStartEventId\":\"19\",\"apiKey\":\"LBopqe-R6_9IGZ21aQCpDKHEuwg2h5WCGX5oOQqZnvGvY3yYV6N2hZyVuNm6f5LbCfp4lxH08R5c4tEqi4tN2A\",\"signature\":\"cTQ4toyRt31iAFtjSNApBBwvVtM\\u003d\"}',0,1,0,0,'org.apache.cloudstack.api.response.PhysicalNetworkResponse/physicalnetwork/{\"id\":\"2fd65c1e-0d4e-4878-bdd2-a165892f4060\",\"name\":\"Sandbox-pnet\",\"broadcastdomainrange\":\"ZONE\",\"zoneid\":\"695e478b-cb1e-448e-9b59-3643e1245f91\",\"state\":\"Disabled\",\"isolationmethods\":\"VLAN\"}',4278190080,4278190080,'2014-06-26 02:24:48','2014-06-26 02:24:48','2014-06-26 02:24:48',NULL,'7bfc8693-0fe7-4c5d-99ae-98c8d09a1226','',NULL,'ApiAsyncJobDispatcher',NULL,0),(2,2,2,NULL,NULL,'org.apache.cloudstack.api.command.admin.usage.AddTrafficTypeCmd','{\"id\":\"1\",\"physicalnetworkid\":\"2fd65c1e-0d4e-4878-bdd2-a165892f4060\",\"response\":\"json\",\"ctxDetails\":\"{\\\"com.cloud.network.PhysicalNetwork\\\":\\\"2fd65c1e-0d4e-4878-bdd2-a165892f4060\\\",\\\"com.cloud.network.PhysicalNetworkTrafficType\\\":\\\"7ba337ee-8d5f-4e17-910f-a2cf6c0e80c5\\\"}\",\"cmdEventType\":\"TRAFFIC.TYPE.CREATE\",\"ctxUserId\":\"2\",\"traffictype\":\"Guest\",\"httpmethod\":\"GET\",\"uuid\":\"7ba337ee-8d5f-4e17-910f-a2cf6c0e80c5\",\"ctxAccountId\":\"2\",\"ctxStartEventId\":\"23\",\"apiKey\":\"LBopqe-R6_9IGZ21aQCpDKHEuwg2h5WCGX5oOQqZnvGvY3yYV6N2hZyVuNm6f5LbCfp4lxH08R5c4tEqi4tN2A\",\"signature\":\"X1H9BFjN6TkMX7xwimbtPbKKa3k\\u003d\"}',0,1,0,0,'org.apache.cloudstack.api.response.TrafficTypeResponse/traffictype/{\"id\":\"7ba337ee-8d5f-4e17-910f-a2cf6c0e80c5\",\"traffictype\":\"Guest\",\"physicalnetworkid\":\"2fd65c1e-0d4e-4878-bdd2-a165892f4060\"}',4278190080,4278190080,'2014-06-26 02:24:48','2014-06-26 02:24:48','2014-06-26 02:24:53',NULL,'c96918a3-397c-499d-a48b-c1062593ad6d','',NULL,'ApiAsyncJobDispatcher',NULL,0),(3,2,2,NULL,NULL,'org.apache.cloudstack.api.command.admin.usage.AddTrafficTypeCmd','{\"id\":\"2\",\"physicalnetworkid\":\"2fd65c1e-0d4e-4878-bdd2-a165892f4060\",\"response\":\"json\",\"ctxDetails\":\"{\\\"com.cloud.network.PhysicalNetwork\\\":\\\"2fd65c1e-0d4e-4878-bdd2-a165892f4060\\\",\\\"com.cloud.network.PhysicalNetworkTrafficType\\\":\\\"e38bc02b-19b0-4876-8353-dcedb6f7b0e5\\\"}\",\"cmdEventType\":\"TRAFFIC.TYPE.CREATE\",\"ctxUserId\":\"2\",\"traffictype\":\"Management\",\"httpmethod\":\"GET\",\"uuid\":\"e38bc02b-19b0-4876-8353-dcedb6f7b0e5\",\"ctxAccountId\":\"2\",\"ctxStartEventId\":\"27\",\"apiKey\":\"LBopqe-R6_9IGZ21aQCpDKHEuwg2h5WCGX5oOQqZnvGvY3yYV6N2hZyVuNm6f5LbCfp4lxH08R5c4tEqi4tN2A\",\"signature\":\"lR49ns8f9jYGR0l3CFNlngEKmwY\\u003d\"}',0,1,0,0,'org.apache.cloudstack.api.response.TrafficTypeResponse/traffictype/{\"id\":\"e38bc02b-19b0-4876-8353-dcedb6f7b0e5\",\"traffictype\":\"Management\",\"physicalnetworkid\":\"2fd65c1e-0d4e-4878-bdd2-a165892f4060\"}',4278190080,4278190080,'2014-06-26 02:24:53','2014-06-26 02:24:53','2014-06-26 02:24:58',NULL,'828b7bc9-29cb-4a11-b56c-bf9b0ca66030','',NULL,'ApiAsyncJobDispatcher',NULL,0),(4,2,2,NULL,NULL,'org.apache.cloudstack.api.command.admin.usage.AddTrafficTypeCmd','{\"id\":\"3\",\"physicalnetworkid\":\"2fd65c1e-0d4e-4878-bdd2-a165892f4060\",\"response\":\"json\",\"ctxDetails\":\"{\\\"com.cloud.network.PhysicalNetwork\\\":\\\"2fd65c1e-0d4e-4878-bdd2-a165892f4060\\\",\\\"com.cloud.network.PhysicalNetworkTrafficType\\\":\\\"72d2f3b1-bd34-4e62-be44-883a91e5206e\\\"}\",\"cmdEventType\":\"TRAFFIC.TYPE.CREATE\",\"ctxUserId\":\"2\",\"traffictype\":\"Public\",\"httpmethod\":\"GET\",\"uuid\":\"72d2f3b1-bd34-4e62-be44-883a91e5206e\",\"ctxAccountId\":\"2\",\"ctxStartEventId\":\"31\",\"apiKey\":\"LBopqe-R6_9IGZ21aQCpDKHEuwg2h5WCGX5oOQqZnvGvY3yYV6N2hZyVuNm6f5LbCfp4lxH08R5c4tEqi4tN2A\",\"signature\":\"HrDQk+XV8t9alI9DT2wvhIYIu8I\\u003d\"}',0,1,0,0,'org.apache.cloudstack.api.response.TrafficTypeResponse/traffictype/{\"id\":\"72d2f3b1-bd34-4e62-be44-883a91e5206e\",\"traffictype\":\"Public\",\"physicalnetworkid\":\"2fd65c1e-0d4e-4878-bdd2-a165892f4060\"}',4278190080,4278190080,'2014-06-26 02:24:58','2014-06-26 02:24:58','2014-06-26 02:25:03',NULL,'3d10462c-0cbb-4e01-819f-8092a634e76f','',NULL,'ApiAsyncJobDispatcher',NULL,0),(5,2,2,NULL,NULL,'org.apache.cloudstack.api.command.admin.router.ConfigureVirtualRouterElementCmd','{\"response\":\"json\",\"id\":\"f6b02ee8-c6dc-4025-937c-efe0702bf09e\",\"enabled\":\"true\",\"ctxDetails\":\"{\\\"com.cloud.network.VirtualRouterProvider\\\":\\\"f6b02ee8-c6dc-4025-937c-efe0702bf09e\\\"}\",\"cmdEventType\":\"NETWORK.ELEMENT.CONFIGURE\",\"ctxUserId\":\"2\",\"httpmethod\":\"GET\",\"uuid\":\"f6b02ee8-c6dc-4025-937c-efe0702bf09e\",\"ctxAccountId\":\"2\",\"ctxStartEventId\":\"35\",\"apiKey\":\"LBopqe-R6_9IGZ21aQCpDKHEuwg2h5WCGX5oOQqZnvGvY3yYV6N2hZyVuNm6f5LbCfp4lxH08R5c4tEqi4tN2A\",\"signature\":\"xRB2xPj7/m/MPNNhG+g4mWxUHOQ\\u003d\"}',0,1,0,0,'org.apache.cloudstack.api.response.VirtualRouterProviderResponse/virtualrouterelement/{\"id\":\"f6b02ee8-c6dc-4025-937c-efe0702bf09e\",\"nspid\":\"f8f20235-74d2-4955-82bb-af34aac33465\",\"enabled\":true}',4278190080,4278190080,'2014-06-26 02:25:03','2014-06-26 02:25:03','2014-06-26 02:25:03',NULL,'add73c4b-f62d-47c7-badd-12888430fc27','',NULL,'ApiAsyncJobDispatcher',NULL,0),(6,2,2,NULL,NULL,'org.apache.cloudstack.api.command.admin.network.UpdateNetworkServiceProviderCmd','{\"id\":\"f8f20235-74d2-4955-82bb-af34aac33465\",\"response\":\"json\",\"ctxDetails\":\"{\\\"com.cloud.network.PhysicalNetworkServiceProvider\\\":\\\"f8f20235-74d2-4955-82bb-af34aac33465\\\"}\",\"cmdEventType\":\"SERVICE.PROVIDER.UPDATE\",\"ctxUserId\":\"2\",\"state\":\"Enabled\",\"httpmethod\":\"GET\",\"uuid\":\"f8f20235-74d2-4955-82bb-af34aac33465\",\"ctxAccountId\":\"2\",\"ctxStartEventId\":\"36\",\"apiKey\":\"LBopqe-R6_9IGZ21aQCpDKHEuwg2h5WCGX5oOQqZnvGvY3yYV6N2hZyVuNm6f5LbCfp4lxH08R5c4tEqi4tN2A\",\"signature\":\"OqVILZc2v8yagQN+/jv9gYCbLdk\\u003d\"}',0,1,0,0,'org.apache.cloudstack.api.response.ProviderResponse/networkserviceprovider/{\"name\":\"VirtualRouter\",\"physicalnetworkid\":\"2fd65c1e-0d4e-4878-bdd2-a165892f4060\",\"state\":\"Enabled\",\"id\":\"f8f20235-74d2-4955-82bb-af34aac33465\",\"servicelist\":[\"Vpn\",\"Dhcp\",\"Dns\",\"Gateway\",\"Firewall\",\"Lb\",\"SourceNat\",\"StaticNat\",\"PortForwarding\",\"UserData\"],\"canenableindividualservice\":true}',4278190080,4278190080,'2014-06-26 02:25:03','2014-06-26 02:25:03','2014-06-26 02:25:08',NULL,'4a3bd086-22ba-451b-ae5d-ec5020329a5d','',NULL,'ApiAsyncJobDispatcher',NULL,0),(7,2,2,NULL,NULL,'org.apache.cloudstack.api.command.admin.router.ConfigureVirtualRouterElementCmd','{\"response\":\"json\",\"id\":\"c71f39d5-bc58-4f8c-b36d-233ef36ce717\",\"enabled\":\"true\",\"ctxDetails\":\"{\\\"com.cloud.network.VirtualRouterProvider\\\":\\\"c71f39d5-bc58-4f8c-b36d-233ef36ce717\\\"}\",\"cmdEventType\":\"NETWORK.ELEMENT.CONFIGURE\",\"ctxUserId\":\"2\",\"httpmethod\":\"GET\",\"uuid\":\"c71f39d5-bc58-4f8c-b36d-233ef36ce717\",\"ctxAccountId\":\"2\",\"ctxStartEventId\":\"39\",\"apiKey\":\"LBopqe-R6_9IGZ21aQCpDKHEuwg2h5WCGX5oOQqZnvGvY3yYV6N2hZyVuNm6f5LbCfp4lxH08R5c4tEqi4tN2A\",\"signature\":\"0znIC/+9R/LFv9p56jsoXXVJ9mA\\u003d\"}',0,1,0,0,'org.apache.cloudstack.api.response.VirtualRouterProviderResponse/virtualrouterelement/{\"id\":\"c71f39d5-bc58-4f8c-b36d-233ef36ce717\",\"nspid\":\"42898b90-789d-4317-9561-433ba9f88340\",\"enabled\":true}',4278190080,4278190080,'2014-06-26 02:25:08','2014-06-26 02:25:08','2014-06-26 02:25:08',NULL,'7d1cc841-22f4-4b51-8d97-9fdceb4dba9a','',NULL,'ApiAsyncJobDispatcher',NULL,0),(8,2,2,NULL,NULL,'org.apache.cloudstack.api.command.admin.network.UpdateNetworkServiceProviderCmd','{\"id\":\"42898b90-789d-4317-9561-433ba9f88340\",\"response\":\"json\",\"ctxDetails\":\"{\\\"com.cloud.network.PhysicalNetworkServiceProvider\\\":\\\"42898b90-789d-4317-9561-433ba9f88340\\\"}\",\"cmdEventType\":\"SERVICE.PROVIDER.UPDATE\",\"ctxUserId\":\"2\",\"state\":\"Enabled\",\"httpmethod\":\"GET\",\"uuid\":\"42898b90-789d-4317-9561-433ba9f88340\",\"ctxAccountId\":\"2\",\"ctxStartEventId\":\"40\",\"apiKey\":\"LBopqe-R6_9IGZ21aQCpDKHEuwg2h5WCGX5oOQqZnvGvY3yYV6N2hZyVuNm6f5LbCfp4lxH08R5c4tEqi4tN2A\",\"signature\":\"PSyuezSUGimVYxg+SnNcqwJImok\\u003d\"}',0,1,0,0,'org.apache.cloudstack.api.response.ProviderResponse/networkserviceprovider/{\"name\":\"VpcVirtualRouter\",\"physicalnetworkid\":\"2fd65c1e-0d4e-4878-bdd2-a165892f4060\",\"state\":\"Enabled\",\"id\":\"42898b90-789d-4317-9561-433ba9f88340\",\"servicelist\":[\"Vpn\",\"Dhcp\",\"Dns\",\"Gateway\",\"Lb\",\"SourceNat\",\"StaticNat\",\"PortForwarding\",\"UserData\"],\"canenableindividualservice\":true}',4278190080,4278190080,'2014-06-26 02:25:08','2014-06-26 02:25:08','2014-06-26 02:25:13',NULL,'038e6558-bc49-4fb6-8ace-96a3c91d8dfd','',NULL,'ApiAsyncJobDispatcher',NULL,0),(9,2,2,NULL,NULL,'org.apache.cloudstack.api.command.admin.internallb.ConfigureInternalLoadBalancerElementCmd','{\"response\":\"json\",\"id\":\"3459a2af-15c6-4534-8bca-aea13cde00b9\",\"enabled\":\"true\",\"ctxDetails\":\"{\\\"com.cloud.network.VirtualRouterProvider\\\":\\\"3459a2af-15c6-4534-8bca-aea13cde00b9\\\"}\",\"cmdEventType\":\"NETWORK.ELEMENT.CONFIGURE\",\"ctxUserId\":\"2\",\"httpmethod\":\"GET\",\"uuid\":\"3459a2af-15c6-4534-8bca-aea13cde00b9\",\"ctxAccountId\":\"2\",\"ctxStartEventId\":\"43\",\"apiKey\":\"LBopqe-R6_9IGZ21aQCpDKHEuwg2h5WCGX5oOQqZnvGvY3yYV6N2hZyVuNm6f5LbCfp4lxH08R5c4tEqi4tN2A\",\"signature\":\"vo+z/IR5Fso80u1PNOVZeROv+YA\\u003d\"}',0,1,0,0,'org.apache.cloudstack.api.response.InternalLoadBalancerElementResponse/internalloadbalancerelement/{\"id\":\"3459a2af-15c6-4534-8bca-aea13cde00b9\",\"nspid\":\"995e590b-d6e7-4341-9570-fcd96c8c64e4\",\"enabled\":true}',4278190080,4278190080,'2014-06-26 02:25:13','2014-06-26 02:25:13','2014-06-26 02:25:14',NULL,'dc2e5629-e746-4ba2-8b76-060f81244881','',NULL,'ApiAsyncJobDispatcher',NULL,0),(10,2,2,NULL,NULL,'org.apache.cloudstack.api.command.admin.network.UpdateNetworkServiceProviderCmd','{\"id\":\"995e590b-d6e7-4341-9570-fcd96c8c64e4\",\"response\":\"json\",\"ctxDetails\":\"{\\\"com.cloud.network.PhysicalNetworkServiceProvider\\\":\\\"995e590b-d6e7-4341-9570-fcd96c8c64e4\\\"}\",\"cmdEventType\":\"SERVICE.PROVIDER.UPDATE\",\"ctxUserId\":\"2\",\"state\":\"Enabled\",\"httpmethod\":\"GET\",\"uuid\":\"995e590b-d6e7-4341-9570-fcd96c8c64e4\",\"ctxAccountId\":\"2\",\"ctxStartEventId\":\"44\",\"apiKey\":\"LBopqe-R6_9IGZ21aQCpDKHEuwg2h5WCGX5oOQqZnvGvY3yYV6N2hZyVuNm6f5LbCfp4lxH08R5c4tEqi4tN2A\",\"signature\":\"8Hs69RKlxEG9dW6a45T/PXcB0YY\\u003d\"}',0,1,0,0,'org.apache.cloudstack.api.response.ProviderResponse/networkserviceprovider/{\"name\":\"InternalLbVm\",\"physicalnetworkid\":\"2fd65c1e-0d4e-4878-bdd2-a165892f4060\",\"state\":\"Enabled\",\"id\":\"995e590b-d6e7-4341-9570-fcd96c8c64e4\",\"servicelist\":[\"Lb\"],\"canenableindividualservice\":true}',4278190080,4278190080,'2014-06-26 02:25:14','2014-06-26 02:25:14','2014-06-26 02:25:19',NULL,'6676f187-0fd4-4d11-ab0d-ff6c535a4626','',NULL,'ApiAsyncJobDispatcher',NULL,0),(11,2,2,NULL,NULL,'org.apache.cloudstack.api.command.admin.network.UpdatePhysicalNetworkCmd','{\"id\":\"2fd65c1e-0d4e-4878-bdd2-a165892f4060\",\"response\":\"json\",\"ctxDetails\":\"{\\\"com.cloud.network.PhysicalNetwork\\\":\\\"2fd65c1e-0d4e-4878-bdd2-a165892f4060\\\"}\",\"cmdEventType\":\"PHYSICAL.NETWORK.UPDATE\",\"ctxUserId\":\"2\",\"state\":\"Enabled\",\"vlan\":\"100-200\",\"httpmethod\":\"GET\",\"uuid\":\"2fd65c1e-0d4e-4878-bdd2-a165892f4060\",\"ctxAccountId\":\"2\",\"ctxStartEventId\":\"47\",\"apiKey\":\"LBopqe-R6_9IGZ21aQCpDKHEuwg2h5WCGX5oOQqZnvGvY3yYV6N2hZyVuNm6f5LbCfp4lxH08R5c4tEqi4tN2A\",\"signature\":\"nT/1aaNTPq7QA4Ezw608EwFAWlw\\u003d\"}',0,1,0,0,'org.apache.cloudstack.api.response.PhysicalNetworkResponse/physicalnetwork/{\"id\":\"2fd65c1e-0d4e-4878-bdd2-a165892f4060\",\"name\":\"Sandbox-pnet\",\"broadcastdomainrange\":\"ZONE\",\"zoneid\":\"695e478b-cb1e-448e-9b59-3643e1245f91\",\"state\":\"Enabled\",\"vlan\":\"100-200\",\"isolationmethods\":\"VLAN\"}',4278190080,4278190080,'2014-06-26 02:25:19','2014-06-26 02:25:19','2014-06-26 02:25:24',NULL,'88fc9ecb-9d21-4e95-990a-81e85a612401','',NULL,'ApiAsyncJobDispatcher',NULL,0),(12,1,1,'Thread',36,NULL,NULL,0,0,0,0,NULL,4278190080,NULL,'2014-06-26 02:25:27',NULL,NULL,NULL,'eceb9919-b59f-4214-8f69-9329554b2899','',NULL,'pseudoJobDispatcher',NULL,1),(13,1,1,'Thread',37,NULL,NULL,0,0,0,0,NULL,4278190080,NULL,'2014-06-26 02:25:27',NULL,NULL,NULL,'925b0512-583a-4c7c-8ddb-ecbd93965ce9','',NULL,'pseudoJobDispatcher',NULL,1),(14,1,1,NULL,NULL,'com.cloud.vm.VmWorkStart','rO0ABXNyABhjb20uY2xvdWQudm0uVm1Xb3JrU3RhcnR9cMGsvxz73gIAC0oABGRjSWRMAAZhdm9pZHN0ADBMY29tL2Nsb3VkL2RlcGxveS9EZXBsb3ltZW50UGxhbm5lciRFeGNsdWRlTGlzdDtMAAljbHVzdGVySWR0ABBMamF2YS9sYW5nL0xvbmc7TAAGaG9zdElkcQB-AAJMAAtqb3VybmFsTmFtZXQAEkxqYXZhL2xhbmcvU3RyaW5nO0wAEXBoeXNpY2FsTmV0d29ya0lkcQB-AAJMAAdwbGFubmVycQB-AANMAAVwb2RJZHEAfgACTAAGcG9vbElkcQB-AAJMAAlyYXdQYXJhbXN0AA9MamF2YS91dGlsL01hcDtMAA1yZXNlcnZhdGlvbklkcQB-AAN4cgATY29tLmNsb3VkLnZtLlZtV29ya5-ZtlbwJWdrAgAESgAJYWNjb3VudElkSgAGdXNlcklkSgAEdm1JZEwAC2hhbmRsZXJOYW1lcQB-AAN4cAAAAAAAAAABAAAAAAAAAAEAAAAAAAAAAXQAGVZpcnR1YWxNYWNoaW5lTWFuYWdlckltcGwAAAAAAAAAAHBwcHBwcHBwcHA',0,1,0,0,NULL,4278190080,4278190080,'2014-06-26 02:27:57','2014-06-26 02:28:00',NULL,NULL,'379627d1-e266-4079-9ec6-8850b6c8a32d','12','VmWork','VmWorkJobDispatcher',NULL,0),(15,1,1,NULL,NULL,'com.cloud.vm.VmWorkStart','rO0ABXNyABhjb20uY2xvdWQudm0uVm1Xb3JrU3RhcnR9cMGsvxz73gIAC0oABGRjSWRMAAZhdm9pZHN0ADBMY29tL2Nsb3VkL2RlcGxveS9EZXBsb3ltZW50UGxhbm5lciRFeGNsdWRlTGlzdDtMAAljbHVzdGVySWR0ABBMamF2YS9sYW5nL0xvbmc7TAAGaG9zdElkcQB-AAJMAAtqb3VybmFsTmFtZXQAEkxqYXZhL2xhbmcvU3RyaW5nO0wAEXBoeXNpY2FsTmV0d29ya0lkcQB-AAJMAAdwbGFubmVycQB-AANMAAVwb2RJZHEAfgACTAAGcG9vbElkcQB-AAJMAAlyYXdQYXJhbXN0AA9MamF2YS91dGlsL01hcDtMAA1yZXNlcnZhdGlvbklkcQB-AAN4cgATY29tLmNsb3VkLnZtLlZtV29ya5-ZtlbwJWdrAgAESgAJYWNjb3VudElkSgAGdXNlcklkSgAEdm1JZEwAC2hhbmRsZXJOYW1lcQB-AAN4cAAAAAAAAAABAAAAAAAAAAEAAAAAAAAAAnQAGVZpcnR1YWxNYWNoaW5lTWFuYWdlckltcGwAAAAAAAAAAHBwcHBwcHBwcHA',0,1,0,0,NULL,4278190080,4278190080,'2014-06-26 02:27:58','2014-06-26 02:28:00',NULL,NULL,'109cdf69-7e5e-42e2-8334-b0f50d2b441d','13','VmWork','VmWorkJobDispatcher',NULL,0);
/*!40000 ALTER TABLE `async_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `async_job_join_map`
--

DROP TABLE IF EXISTS `async_job_join_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `async_job_join_map` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `job_id` bigint(20) unsigned NOT NULL,
  `join_job_id` bigint(20) unsigned NOT NULL,
  `join_status` int(11) NOT NULL,
  `join_result` varchar(1024) DEFAULT NULL,
  `join_msid` bigint(20) DEFAULT NULL,
  `complete_msid` bigint(20) DEFAULT NULL,
  `sync_source_id` bigint(20) DEFAULT NULL COMMENT 'upper-level job sync source info before join',
  `wakeup_handler` varchar(64) DEFAULT NULL,
  `wakeup_dispatcher` varchar(64) DEFAULT NULL,
  `wakeup_interval` bigint(20) NOT NULL DEFAULT '3000' COMMENT 'wakeup interval in seconds',
  `created` datetime NOT NULL,
  `last_updated` datetime DEFAULT NULL,
  `next_wakeup` datetime DEFAULT NULL,
  `expiration` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `fk_async_job_join_map__join` (`job_id`,`join_job_id`),
  KEY `i_async_job_join_map__join_job_id` (`join_job_id`),
  KEY `i_async_job_join_map__created` (`created`),
  KEY `i_async_job_join_map__last_updated` (`last_updated`),
  KEY `i_async_job_join_map__next_wakeup` (`next_wakeup`),
  KEY `i_async_job_join_map__expiration` (`expiration`),
  CONSTRAINT `fk_async_job_join_map__job_id` FOREIGN KEY (`job_id`) REFERENCES `async_job` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_async_job_join_map__join_job_id` FOREIGN KEY (`join_job_id`) REFERENCES `async_job` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `async_job_join_map`
--

LOCK TABLES `async_job_join_map` WRITE;
/*!40000 ALTER TABLE `async_job_join_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `async_job_join_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `async_job_journal`
--

DROP TABLE IF EXISTS `async_job_journal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `async_job_journal` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `job_id` bigint(20) unsigned NOT NULL,
  `journal_type` varchar(32) DEFAULT NULL,
  `journal_text` varchar(1024) DEFAULT NULL COMMENT 'journal descriptive informaton',
  `journal_obj` varchar(1024) DEFAULT NULL COMMENT 'journal strutural information, JSON encoded object',
  `created` datetime NOT NULL COMMENT 'date created',
  PRIMARY KEY (`id`),
  KEY `fk_async_job_journal__job_id` (`job_id`),
  CONSTRAINT `fk_async_job_journal__job_id` FOREIGN KEY (`job_id`) REFERENCES `async_job` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `async_job_journal`
--

LOCK TABLES `async_job_journal` WRITE;
/*!40000 ALTER TABLE `async_job_journal` DISABLE KEYS */;
/*!40000 ALTER TABLE `async_job_journal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `async_job_view`
--

DROP TABLE IF EXISTS `async_job_view`;
/*!50001 DROP VIEW IF EXISTS `async_job_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `async_job_view` (
  `account_id` tinyint NOT NULL,
  `account_uuid` tinyint NOT NULL,
  `account_name` tinyint NOT NULL,
  `account_type` tinyint NOT NULL,
  `domain_id` tinyint NOT NULL,
  `domain_uuid` tinyint NOT NULL,
  `domain_name` tinyint NOT NULL,
  `domain_path` tinyint NOT NULL,
  `user_id` tinyint NOT NULL,
  `user_uuid` tinyint NOT NULL,
  `id` tinyint NOT NULL,
  `uuid` tinyint NOT NULL,
  `job_cmd` tinyint NOT NULL,
  `job_status` tinyint NOT NULL,
  `job_process_status` tinyint NOT NULL,
  `job_result_code` tinyint NOT NULL,
  `job_result` tinyint NOT NULL,
  `created` tinyint NOT NULL,
  `removed` tinyint NOT NULL,
  `instance_type` tinyint NOT NULL,
  `instance_id` tinyint NOT NULL,
  `instance_uuid` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `autoscale_policies`
--

DROP TABLE IF EXISTS `autoscale_policies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `autoscale_policies` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(40) DEFAULT NULL,
  `domain_id` bigint(20) unsigned NOT NULL,
  `account_id` bigint(20) unsigned NOT NULL,
  `duration` int(10) unsigned NOT NULL,
  `quiet_time` int(10) unsigned NOT NULL,
  `last_quiet_time` datetime DEFAULT NULL,
  `action` varchar(15) DEFAULT NULL,
  `created` datetime NOT NULL COMMENT 'date created',
  `removed` datetime DEFAULT NULL COMMENT 'date removed if not null',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_autoscale_policies__uuid` (`uuid`),
  KEY `fk_autoscale_policies__domain_id` (`domain_id`),
  KEY `fk_autoscale_policies__account_id` (`account_id`),
  KEY `i_autoscale_policies__removed` (`removed`),
  CONSTRAINT `fk_autoscale_policies__domain_id` FOREIGN KEY (`domain_id`) REFERENCES `domain` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_autoscale_policies__account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autoscale_policies`
--

LOCK TABLES `autoscale_policies` WRITE;
/*!40000 ALTER TABLE `autoscale_policies` DISABLE KEYS */;
/*!40000 ALTER TABLE `autoscale_policies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `autoscale_policy_condition_map`
--

DROP TABLE IF EXISTS `autoscale_policy_condition_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `autoscale_policy_condition_map` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `policy_id` bigint(20) unsigned NOT NULL,
  `condition_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_autoscale_policy_condition_map__condition_id` (`condition_id`),
  KEY `i_autoscale_policy_condition_map__policy_id` (`policy_id`),
  CONSTRAINT `fk_autoscale_policy_condition_map__policy_id` FOREIGN KEY (`policy_id`) REFERENCES `autoscale_policies` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_autoscale_policy_condition_map__condition_id` FOREIGN KEY (`condition_id`) REFERENCES `conditions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autoscale_policy_condition_map`
--

LOCK TABLES `autoscale_policy_condition_map` WRITE;
/*!40000 ALTER TABLE `autoscale_policy_condition_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `autoscale_policy_condition_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `autoscale_vmgroup_details`
--

DROP TABLE IF EXISTS `autoscale_vmgroup_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `autoscale_vmgroup_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `autoscale_vmgroup_id` bigint(20) unsigned NOT NULL COMMENT 'VPC gateway id',
  `name` varchar(255) NOT NULL,
  `value` varchar(1024) NOT NULL,
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'True if the detail can be displayed to the end user',
  PRIMARY KEY (`id`),
  KEY `fk_autoscale_vmgroup_details__autoscale_vmgroup_id` (`autoscale_vmgroup_id`),
  CONSTRAINT `fk_autoscale_vmgroup_details__autoscale_vmgroup_id` FOREIGN KEY (`autoscale_vmgroup_id`) REFERENCES `autoscale_vmgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autoscale_vmgroup_details`
--

LOCK TABLES `autoscale_vmgroup_details` WRITE;
/*!40000 ALTER TABLE `autoscale_vmgroup_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `autoscale_vmgroup_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `autoscale_vmgroup_policy_map`
--

DROP TABLE IF EXISTS `autoscale_vmgroup_policy_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `autoscale_vmgroup_policy_map` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `vmgroup_id` bigint(20) unsigned NOT NULL,
  `policy_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_autoscale_vmgroup_policy_map__policy_id` (`policy_id`),
  KEY `i_autoscale_vmgroup_policy_map__vmgroup_id` (`vmgroup_id`),
  CONSTRAINT `fk_autoscale_vmgroup_policy_map__vmgroup_id` FOREIGN KEY (`vmgroup_id`) REFERENCES `autoscale_vmgroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_autoscale_vmgroup_policy_map__policy_id` FOREIGN KEY (`policy_id`) REFERENCES `autoscale_policies` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autoscale_vmgroup_policy_map`
--

LOCK TABLES `autoscale_vmgroup_policy_map` WRITE;
/*!40000 ALTER TABLE `autoscale_vmgroup_policy_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `autoscale_vmgroup_policy_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `autoscale_vmgroup_vm_map`
--

DROP TABLE IF EXISTS `autoscale_vmgroup_vm_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `autoscale_vmgroup_vm_map` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `vmgroup_id` bigint(20) unsigned NOT NULL,
  `instance_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_autoscale_vmgroup_vm_map__instance_id` (`instance_id`),
  KEY `i_autoscale_vmgroup_vm_map__vmgroup_id` (`vmgroup_id`),
  CONSTRAINT `fk_autoscale_vmgroup_vm_map__vmgroup_id` FOREIGN KEY (`vmgroup_id`) REFERENCES `autoscale_vmgroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_autoscale_vmgroup_vm_map__instance_id` FOREIGN KEY (`instance_id`) REFERENCES `vm_instance` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autoscale_vmgroup_vm_map`
--

LOCK TABLES `autoscale_vmgroup_vm_map` WRITE;
/*!40000 ALTER TABLE `autoscale_vmgroup_vm_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `autoscale_vmgroup_vm_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `autoscale_vmgroups`
--

DROP TABLE IF EXISTS `autoscale_vmgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `autoscale_vmgroups` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(40) DEFAULT NULL,
  `zone_id` bigint(20) unsigned NOT NULL,
  `domain_id` bigint(20) unsigned NOT NULL,
  `account_id` bigint(20) unsigned NOT NULL,
  `load_balancer_id` bigint(20) unsigned NOT NULL,
  `min_members` int(10) unsigned DEFAULT '1',
  `max_members` int(10) unsigned NOT NULL,
  `member_port` int(10) unsigned NOT NULL,
  `interval` int(10) unsigned NOT NULL,
  `profile_id` bigint(20) unsigned NOT NULL,
  `state` varchar(255) NOT NULL COMMENT 'enabled or disabled, a vmgroup is disabled to stop autoscaling activity',
  `created` datetime NOT NULL COMMENT 'date created',
  `removed` datetime DEFAULT NULL COMMENT 'date removed if not null',
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'True if the entry can be displayed to the end user',
  `last_interval` datetime DEFAULT NULL COMMENT 'last updated time',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_autoscale_vmgroups__uuid` (`uuid`),
  KEY `fk_autoscale_vmgroup__autoscale_vmprofile_id` (`profile_id`),
  KEY `fk_autoscale_vmgroups__domain_id` (`domain_id`),
  KEY `fk_autoscale_vmgroups__account_id` (`account_id`),
  KEY `fk_autoscale_vmgroups__zone_id` (`zone_id`),
  KEY `i_autoscale_vmgroups__removed` (`removed`),
  KEY `i_autoscale_vmgroups__load_balancer_id` (`load_balancer_id`),
  CONSTRAINT `fk_autoscale_vmgroups__account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_autoscale_vmgroups__domain_id` FOREIGN KEY (`domain_id`) REFERENCES `domain` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_autoscale_vmgroups__zone_id` FOREIGN KEY (`zone_id`) REFERENCES `data_center` (`id`),
  CONSTRAINT `fk_autoscale_vmgroup__autoscale_vmprofile_id` FOREIGN KEY (`profile_id`) REFERENCES `autoscale_vmprofiles` (`id`),
  CONSTRAINT `fk_autoscale_vmgroup__load_balancer_id` FOREIGN KEY (`load_balancer_id`) REFERENCES `load_balancing_rules` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autoscale_vmgroups`
--

LOCK TABLES `autoscale_vmgroups` WRITE;
/*!40000 ALTER TABLE `autoscale_vmgroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `autoscale_vmgroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `autoscale_vmprofile_details`
--

DROP TABLE IF EXISTS `autoscale_vmprofile_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `autoscale_vmprofile_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `autoscale_vmprofile_id` bigint(20) unsigned NOT NULL COMMENT 'VPC gateway id',
  `name` varchar(255) NOT NULL,
  `value` varchar(1024) NOT NULL,
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'True if the detail can be displayed to the end user',
  PRIMARY KEY (`id`),
  KEY `fk_autoscale_vmprofile_details__autoscale_vmprofile_id` (`autoscale_vmprofile_id`),
  CONSTRAINT `fk_autoscale_vmprofile_details__autoscale_vmprofile_id` FOREIGN KEY (`autoscale_vmprofile_id`) REFERENCES `autoscale_vmprofiles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autoscale_vmprofile_details`
--

LOCK TABLES `autoscale_vmprofile_details` WRITE;
/*!40000 ALTER TABLE `autoscale_vmprofile_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `autoscale_vmprofile_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `autoscale_vmprofiles`
--

DROP TABLE IF EXISTS `autoscale_vmprofiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `autoscale_vmprofiles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(40) DEFAULT NULL,
  `zone_id` bigint(20) unsigned NOT NULL,
  `domain_id` bigint(20) unsigned NOT NULL,
  `account_id` bigint(20) unsigned NOT NULL,
  `autoscale_user_id` bigint(20) unsigned NOT NULL,
  `service_offering_id` bigint(20) unsigned NOT NULL,
  `template_id` bigint(20) unsigned NOT NULL,
  `other_deploy_params` varchar(1024) DEFAULT NULL COMMENT 'other deployment parameters that is in addition to zoneid,serviceofferingid,domainid',
  `destroy_vm_grace_period` int(10) unsigned DEFAULT NULL COMMENT 'the time allowed for existing connections to get closed before a vm is destroyed',
  `counter_params` varchar(1024) DEFAULT NULL COMMENT 'the parameters for the counter to be used to get metric information from VMs',
  `created` datetime NOT NULL COMMENT 'date created',
  `removed` datetime DEFAULT NULL COMMENT 'date removed if not null',
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'True if the entry can be displayed to the end user',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_autoscale_vmprofiles__uuid` (`uuid`),
  KEY `fk_autoscale_vmprofiles__domain_id` (`domain_id`),
  KEY `fk_autoscale_vmprofiles__account_id` (`account_id`),
  KEY `fk_autoscale_vmprofiles__autoscale_user_id` (`autoscale_user_id`),
  KEY `i_autoscale_vmprofiles__removed` (`removed`),
  CONSTRAINT `fk_autoscale_vmprofiles__account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_autoscale_vmprofiles__autoscale_user_id` FOREIGN KEY (`autoscale_user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_autoscale_vmprofiles__domain_id` FOREIGN KEY (`domain_id`) REFERENCES `domain` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autoscale_vmprofiles`
--

LOCK TABLES `autoscale_vmprofiles` WRITE;
/*!40000 ALTER TABLE `autoscale_vmprofiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `autoscale_vmprofiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `baremetal_dhcp_devices`
--

DROP TABLE IF EXISTS `baremetal_dhcp_devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `baremetal_dhcp_devices` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uuid` varchar(40) DEFAULT NULL,
  `nsp_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Network Service Provider ID',
  `pod_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Pod id where this dhcp server in',
  `device_type` varchar(255) DEFAULT NULL COMMENT 'type of the external device',
  `physical_network_id` bigint(20) unsigned DEFAULT NULL COMMENT 'id of the physical network in to which external dhcp device is added',
  `host_id` bigint(20) unsigned DEFAULT NULL COMMENT 'host id coresponding to the external dhcp device',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `fk_external_dhcp_devices_nsp_id` (`nsp_id`),
  KEY `fk_external_dhcp_devices_host_id` (`host_id`),
  KEY `fk_external_dhcp_devices_physical_network_id` (`physical_network_id`),
  CONSTRAINT `fk_external_dhcp_devices_physical_network_id` FOREIGN KEY (`physical_network_id`) REFERENCES `physical_network` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_external_dhcp_devices_host_id` FOREIGN KEY (`host_id`) REFERENCES `host` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_external_dhcp_devices_nsp_id` FOREIGN KEY (`nsp_id`) REFERENCES `physical_network_service_providers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `baremetal_dhcp_devices`
--

LOCK TABLES `baremetal_dhcp_devices` WRITE;
/*!40000 ALTER TABLE `baremetal_dhcp_devices` DISABLE KEYS */;
/*!40000 ALTER TABLE `baremetal_dhcp_devices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `baremetal_pxe_devices`
--

DROP TABLE IF EXISTS `baremetal_pxe_devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `baremetal_pxe_devices` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uuid` varchar(40) DEFAULT NULL,
  `nsp_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Network Service Provider ID',
  `pod_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Pod id where this pxe server in, for pxe per zone this field is null',
  `device_type` varchar(255) DEFAULT NULL COMMENT 'type of the pxe device',
  `physical_network_id` bigint(20) unsigned DEFAULT NULL COMMENT 'id of the physical network in to which external pxe device is added',
  `host_id` bigint(20) unsigned DEFAULT NULL COMMENT 'host id coresponding to the external pxe device',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `fk_external_pxe_devices_nsp_id` (`nsp_id`),
  KEY `fk_external_pxe_devices_host_id` (`host_id`),
  KEY `fk_external_pxe_devices_physical_network_id` (`physical_network_id`),
  CONSTRAINT `fk_external_pxe_devices_physical_network_id` FOREIGN KEY (`physical_network_id`) REFERENCES `physical_network` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_external_pxe_devices_host_id` FOREIGN KEY (`host_id`) REFERENCES `host` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_external_pxe_devices_nsp_id` FOREIGN KEY (`nsp_id`) REFERENCES `physical_network_service_providers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `baremetal_pxe_devices`
--

LOCK TABLES `baremetal_pxe_devices` WRITE;
/*!40000 ALTER TABLE `baremetal_pxe_devices` DISABLE KEYS */;
/*!40000 ALTER TABLE `baremetal_pxe_devices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cluster`
--

DROP TABLE IF EXISTS `cluster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cluster` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) DEFAULT NULL COMMENT 'name for the cluster',
  `uuid` varchar(40) DEFAULT NULL COMMENT 'uuid is different with following guid, while the later one is generated by hypervisor resource',
  `guid` varchar(255) DEFAULT NULL COMMENT 'guid for the cluster',
  `pod_id` bigint(20) unsigned NOT NULL COMMENT 'pod id',
  `data_center_id` bigint(20) unsigned NOT NULL COMMENT 'data center id',
  `hypervisor_type` varchar(32) DEFAULT NULL,
  `cluster_type` varchar(64) DEFAULT 'CloudManaged',
  `allocation_state` varchar(32) NOT NULL DEFAULT 'Enabled' COMMENT 'Is this cluster enabled for allocation for new resources',
  `managed_state` varchar(32) NOT NULL DEFAULT 'Managed' COMMENT 'Is this cluster managed by cloudstack',
  `removed` datetime DEFAULT NULL COMMENT 'date removed if not null',
  `owner` varchar(255) DEFAULT NULL,
  `created` datetime DEFAULT NULL COMMENT 'date created',
  `lastUpdated` datetime DEFAULT NULL COMMENT 'last updated',
  `engine_state` varchar(32) NOT NULL DEFAULT 'Disabled' COMMENT 'the engine state of the zone',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `guid` (`guid`),
  UNIQUE KEY `i_cluster__pod_id__name` (`pod_id`,`name`),
  UNIQUE KEY `uc_cluster__uuid` (`uuid`),
  KEY `fk_cluster__data_center_id` (`data_center_id`),
  KEY `i_cluster__allocation_state` (`allocation_state`),
  KEY `i_cluster__removed` (`removed`),
  CONSTRAINT `fk_cluster__data_center_id` FOREIGN KEY (`data_center_id`) REFERENCES `data_center` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_cluster__pod_id` FOREIGN KEY (`pod_id`) REFERENCES `host_pod_ref` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cluster`
--

LOCK TABLES `cluster` WRITE;
/*!40000 ALTER TABLE `cluster` DISABLE KEYS */;
INSERT INTO `cluster` VALUES (1,'C0','047fd285-ee9b-4073-a5f3-319d7f36b220','43a11b8d-32c4-4ab6-b56e-c2bc21f1c769',1,1,'Simulator','CloudManaged','Enabled','Managed',NULL,NULL,NULL,NULL,'Disabled'),(2,'C1','7aeccb48-119f-49e9-8b63-95a034e7af7c','4e20389f-5c2b-44d1-b572-082cd275209d',1,1,'Simulator','CloudManaged','Enabled','Managed',NULL,NULL,NULL,NULL,'Disabled');
/*!40000 ALTER TABLE `cluster` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cluster_details`
--

DROP TABLE IF EXISTS `cluster_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cluster_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `cluster_id` bigint(20) unsigned NOT NULL COMMENT 'cluster id',
  `name` varchar(255) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_cluster_details__cluster_id` (`cluster_id`),
  CONSTRAINT `fk_cluster_details__cluster_id` FOREIGN KEY (`cluster_id`) REFERENCES `cluster` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cluster_details`
--

LOCK TABLES `cluster_details` WRITE;
/*!40000 ALTER TABLE `cluster_details` DISABLE KEYS */;
INSERT INTO `cluster_details` VALUES (1,1,'memoryOvercommitRatio','1.0'),(2,1,'cpuOvercommitRatio','1.0'),(3,2,'memoryOvercommitRatio','1.0'),(4,2,'cpuOvercommitRatio','1.0');
/*!40000 ALTER TABLE `cluster_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cluster_vsm_map`
--

DROP TABLE IF EXISTS `cluster_vsm_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cluster_vsm_map` (
  `cluster_id` bigint(20) unsigned NOT NULL,
  `vsm_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`cluster_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cluster_vsm_map`
--

LOCK TABLES `cluster_vsm_map` WRITE;
/*!40000 ALTER TABLE `cluster_vsm_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `cluster_vsm_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmd_exec_log`
--

DROP TABLE IF EXISTS `cmd_exec_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmd_exec_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `host_id` bigint(20) unsigned NOT NULL COMMENT 'host id of the system VM agent that command is sent to',
  `instance_id` bigint(20) unsigned NOT NULL COMMENT 'instance id of the system VM that command is executed on',
  `command_name` varchar(255) NOT NULL COMMENT 'command name',
  `weight` int(11) NOT NULL DEFAULT '1' COMMENT 'command weight in consideration of the load factor added to host that is executing the command',
  `created` datetime NOT NULL COMMENT 'date created',
  PRIMARY KEY (`id`),
  KEY `i_cmd_exec_log__host_id` (`host_id`),
  KEY `i_cmd_exec_log__instance_id` (`instance_id`),
  CONSTRAINT `fk_cmd_exec_log_ref__inst_id` FOREIGN KEY (`instance_id`) REFERENCES `vm_instance` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmd_exec_log`
--

LOCK TABLES `cmd_exec_log` WRITE;
/*!40000 ALTER TABLE `cmd_exec_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmd_exec_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conditions`
--

DROP TABLE IF EXISTS `conditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conditions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uuid` varchar(40) DEFAULT NULL,
  `counter_id` bigint(20) unsigned NOT NULL COMMENT 'Counter Id',
  `threshold` bigint(20) unsigned NOT NULL COMMENT 'threshold value for the given counter',
  `relational_operator` char(2) DEFAULT NULL COMMENT 'relational operator to be used upon the counter and condition',
  `domain_id` bigint(20) unsigned NOT NULL COMMENT 'domain the Condition belongs to',
  `account_id` bigint(20) unsigned NOT NULL COMMENT 'owner of this Condition',
  `removed` datetime DEFAULT NULL COMMENT 'date removed if not null',
  `created` datetime NOT NULL COMMENT 'date created',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `uc_conditions__uuid` (`uuid`),
  KEY `fk_conditions__counter_id` (`counter_id`),
  KEY `fk_conditions__account_id` (`account_id`),
  KEY `fk_conditions__domain_id` (`domain_id`),
  KEY `i_conditions__removed` (`removed`),
  CONSTRAINT `fk_conditions__counter_id` FOREIGN KEY (`counter_id`) REFERENCES `counter` (`id`),
  CONSTRAINT `fk_conditions__account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_conditions__domain_id` FOREIGN KEY (`domain_id`) REFERENCES `domain` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conditions`
--

LOCK TABLES `conditions` WRITE;
/*!40000 ALTER TABLE `conditions` DISABLE KEYS */;
/*!40000 ALTER TABLE `conditions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `configuration`
--

DROP TABLE IF EXISTS `configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `configuration` (
  `category` varchar(255) NOT NULL DEFAULT 'Advanced',
  `instance` varchar(255) NOT NULL,
  `component` varchar(255) NOT NULL DEFAULT 'management-server',
  `name` varchar(255) NOT NULL,
  `value` varchar(4095) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `default_value` varchar(4095) DEFAULT NULL COMMENT 'Default value for a configuration parameter',
  `updated` datetime DEFAULT NULL COMMENT 'Time this was updated by the server. null means this row is obsolete.',
  `scope` varchar(255) DEFAULT NULL COMMENT 'Can this parameter be scoped',
  `is_dynamic` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Can the parameter be change dynamically without restarting the server',
  PRIMARY KEY (`name`),
  KEY `i_configuration__instance` (`instance`),
  KEY `i_configuration__name` (`name`),
  KEY `i_configuration__category` (`category`),
  KEY `i_configuration__component` (`component`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configuration`
--

LOCK TABLES `configuration` WRITE;
/*!40000 ALTER TABLE `configuration` DISABLE KEYS */;
INSERT INTO `configuration` VALUES ('Advanced','DEFAULT','management-server','account.cleanup.interval','600','The interval (in seconds) between cleanup for removed accounts',NULL,NULL,NULL,0),('Advanced','DEFAULT','ExtensionRegistry','affinity.processors.exclude',NULL,'Extensions to exclude from being registered',NULL,'2014-06-26 02:23:19','Global',0),('Advanced','DEFAULT','ExtensionRegistry','affinity.processors.order','HostAntiAffinityProcessor,ExplicitDedicationProcessor','The order of precedence for the extensions','HostAntiAffinityProcessor,ExplicitDedicationProcessor','2014-06-26 02:23:19','Global',0),('Advanced','DEFAULT','AgentManager','agent.lb.enabled','false','Enable agent load balancing between management server nodes','false','2014-06-26 02:23:21','Global',1),('Advanced','DEFAULT','AgentManager','agent.load.threshold','0.7','What percentage of the agents can be held by one management server before load balancing happens','0.7','2014-06-26 02:23:21','Global',1),('Alert','DEFAULT','management-server','alert.email.addresses',NULL,'Comma separated list of email addresses used for sending alerts.',NULL,NULL,NULL,0),('Alert','DEFAULT','management-server','alert.email.sender',NULL,'Sender of alert email (will be in the From header of the email).',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','alert.purge.delay','0','Alerts older than specified number days will be purged. Set this value to 0 to never delete alerts','0',NULL,NULL,0),('Advanced','DEFAULT','management-server','alert.purge.interval','86400','The interval (in seconds) to wait before running the alert purge thread','86400',NULL,NULL,0),('Alert','DEFAULT','management-server','alert.smtp.connectiontimeout','30000','Socket connection timeout value in milliseconds. -1 for infinite timeout.','30000',NULL,NULL,0),('Alert','DEFAULT','management-server','alert.smtp.host',NULL,'SMTP hostname used for sending out email alerts.',NULL,NULL,NULL,0),('Secure','DEFAULT','management-server','alert.smtp.password',NULL,'Password for SMTP authentication (applies only if alert.smtp.useAuth is true).',NULL,NULL,NULL,0),('Alert','DEFAULT','management-server','alert.smtp.port','465','Port the SMTP server is listening on.',NULL,NULL,NULL,0),('Alert','DEFAULT','management-server','alert.smtp.timeout','30000','Socket I/O timeout value in milliseconds. -1 for infinite timeout.','30000',NULL,NULL,0),('Alert','DEFAULT','management-server','alert.smtp.useAuth',NULL,'If true, use SMTP authentication when sending emails.',NULL,NULL,NULL,0),('Alert','DEFAULT','management-server','alert.smtp.username',NULL,'Username for SMTP authentication (applies only if alert.smtp.useAuth is true).',NULL,NULL,NULL,0),('Advanced','DEFAULT','AgentManager','alert.wait','1800','Seconds to wait before alerting on a disconnected agent','1800','2014-06-26 02:23:21','Global',1),('Advanced','DEFAULT','TemplateManager','allow.public.user.templates','true','If false, users will not be able to create public templates.','true','2014-06-26 02:23:17','Account',1),('Advanced','DEFAULT','NetworkManager','allow.subdomain.network.access','true','Allow subdomains to use networks dedicated to their parent domain(s)',NULL,NULL,NULL,0),('Project Defaults','DEFAULT','management-server','allow.user.create.projects','true','If regular user can create a project; true by default',NULL,NULL,NULL,0),('Advanced','DEFAULT','ExtensionRegistry','api.checkers.exclude',NULL,'Extensions to exclude from being registered',NULL,'2014-06-26 02:23:21','Global',0),('Advanced','DEFAULT','management-server','api.throttling.cachesize','50000','Account based API count cache size','50000',NULL,NULL,0),('Advanced','DEFAULT','management-server','api.throttling.enabled','false','Enable/Disable Api rate limit','false',NULL,NULL,0),('Advanced','DEFAULT','management-server','api.throttling.interval','1','Time interval (in seconds) to reset API count','1',NULL,NULL,0),('Advanced','DEFAULT','management-server','api.throttling.max','25','Max allowed number of APIs within fixed interval','25',NULL,NULL,0),('Advanced','DEFAULT','management-server','apply.allocation.algorithm.to.pods','false','If true, deployment planner applies the allocation heuristics at pods first in the given datacenter during VM resource allocation',NULL,NULL,NULL,0),('Storage','DEFAULT','StorageManager','backup.snapshot.wait','21600','In second, timeout for BackupSnapshotCommand',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','baremetal.ipmi.fail.retry','default','ipmi interface will be temporary out of order after power opertions(e.g. cycle, on), it leads following commands fail immediately. The value specifies retry times before accounting it as real failure','default',NULL,NULL,0),('Advanced','DEFAULT','management-server','baremetal.ipmi.lan.interface','default','option specified in -I option of impitool. candidates are: open/bmc/lipmi/lan/lanplus/free/imb, see ipmitool man page for details. default valule \"default\" means using default option of ipmitool','default',NULL,NULL,0),('Advanced','DEFAULT','VpcManager','blacklisted.routes',NULL,'Routes that are blacklisted, can not be used for Static Routes creation for the VPC Private Gateway',NULL,NULL,NULL,0),('Alert','DEFAULT','management-server','capacity.check.period','300000','The interval in milliseconds between capacity checks',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','capacity.skipcounting.hours','3600','Time (in seconds) to wait before release VM\'s cpu and memory when VM in stopped state',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','check.pod.cidrs','true','If true, different pods must belong to different CIDR subnets.',NULL,NULL,NULL,0),('Developer','DEFAULT','AgentManager','check.txn.before.sending.agent.commands','false','This parameter allows developers to enable a check to see if a transaction wraps commands that are sent to the resource.  This is not to be enabled on production systems.','false','2014-06-26 02:23:21','Global',1),('Advanced','DEFAULT','management-server','cloud.dns.name',NULL,'DNS name of the cloud for the GSLB service',NULL,NULL,NULL,0),('Hidden','DEFAULT','management-server','cloud.identifier','6bfb8c7e-e81b-4f9e-857f-b55b454ce29c','A unique identifier for the cloud.',NULL,NULL,NULL,0),('Alert','DEFAULT','DeploymentClusterPlanner','cluster.cpu.allocated.capacity.disablethreshold','0.85','Percentage (as a value between 0 and 1) of cpu utilization above which allocators will disable using the cluster for low cpu available. Keep the corresponding notification threshold lower than this to be notified beforehand.','0.85','2014-06-26 02:23:28','Cluster',1),('Alert','DEFAULT','AlertManager','cluster.cpu.allocated.capacity.notificationthreshold','0.75','Percentage (as a value between 0 and 1) of cpu utilization above which alerts will be sent about low cpu available.','0.75','2014-06-26 02:23:21','Cluster',1),('management-server','DEFAULT','ClusterManager','cluster.heartbeat.interval','1500','Interval to check for the heart beat between management server nodes','1500','2014-06-26 02:23:20','Global',0),('management-server','DEFAULT','ClusterManager','cluster.heartbeat.threshold','150000','Threshold before self-fence the management server','150000','2014-06-26 02:23:20','Global',1),('Alert','DEFAULT','management-server','cluster.localStorage.capacity.notificationthreshold','0.75','Percentage (as a value between 0 and 1) of local storage utilization above which alerts will be sent about low local storage available.',NULL,NULL,NULL,0),('Alert','DEFAULT','DeploymentClusterPlanner','cluster.memory.allocated.capacity.disablethreshold','0.85','Percentage (as a value between 0 and 1) of memory utilization above which allocators will disable using the cluster for low memory available. Keep the corresponding notification threshold lower than this to be notified beforehand.','0.85','2014-06-26 02:23:28','Cluster',1),('Alert','DEFAULT','AlertManager','cluster.memory.allocated.capacity.notificationthreshold','0.75','Percentage (as a value between 0 and 1) of memory utilization above which alerts will be sent about low memory available.','0.75','2014-06-26 02:23:21','Cluster',1),('Advanced','DEFAULT','management-server','cluster.message.timeout.seconds','300','Time (in seconds) to wait before a inter-management server message post times out.',NULL,NULL,NULL,0),('Alert','DEFAULT','AlertManager','cluster.storage.allocated.capacity.notificationthreshold','0.75','Percentage (as a value between 0 and 1) of allocated storage utilization above which alerts will be sent about low storage available.','0.75','2014-06-26 02:23:21','Cluster',1),('Alert','DEFAULT','AlertManager','cluster.storage.capacity.notificationthreshold','0.75','Percentage (as a value between 0 and 1) of storage utilization above which alerts will be sent about low storage available.','0.75','2014-06-26 02:23:21','Cluster',1),('Advanced','DEFAULT','management-server','concurrent.snapshots.threshold.perhost',NULL,'Limit number of snapshots that can be handled concurrently; default is NULL - unlimited.',NULL,NULL,NULL,0),('Advanced','DEFAULT','ExtensionRegistry','console.proxy.allocator.exclude',NULL,'Extensions to exclude from being registered',NULL,'2014-06-26 02:23:19','Global',0),('Console Proxy','DEFAULT','AgentManager','consoleproxy.capacity.standby','10','The minimal number of console proxy viewer sessions that system is able to serve immediately(standby capacity)',NULL,NULL,NULL,0),('Console Proxy','DEFAULT','AgentManager','consoleproxy.capacityscan.interval','30000','The time interval(in millisecond) to scan whether or not system needs more console proxy to ensure minimal standby capacity',NULL,NULL,NULL,0),('Console Proxy','DEFAULT','AgentManager','consoleproxy.cmd.port','8001','Console proxy command port that is used to communicate with management server',NULL,NULL,NULL,0),('Console Proxy','DEFAULT','AgentManager','consoleproxy.disable.rpfilter','true','disable rp_filter on console proxy VM public interface',NULL,NULL,NULL,0),('Console Proxy','DEFAULT','AgentManager','consoleproxy.launch.max','10','maximum number of console proxy instances per zone can be launched',NULL,NULL,NULL,0),('Console Proxy','DEFAULT','AgentManager','consoleproxy.loadscan.interval','10000','The time interval(in milliseconds) to scan console proxy working-load info',NULL,NULL,NULL,0),('Console Proxy','DEFAULT','AgentManager','consoleproxy.management.state','Auto','console proxy service management state',NULL,NULL,NULL,0),('Console Proxy','DEFAULT','AgentManager','consoleproxy.management.state.last','Auto','last console proxy service management state',NULL,NULL,NULL,0),('Console Proxy','DEFAULT','AgentManager','consoleproxy.restart','true','Console proxy restart flag, defaulted to true',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','consoleproxy.service.offering',NULL,'Uuid of the service offering used by console proxy; if NULL - system offering will be used',NULL,NULL,NULL,0),('Console Proxy','DEFAULT','AgentManager','consoleproxy.session.max','50','The max number of viewer sessions console proxy is configured to serve for',NULL,NULL,NULL,0),('Console Proxy','DEFAULT','AgentManager','consoleproxy.session.timeout','300000','Timeout(in milliseconds) that console proxy tries to maintain a viewer session before it times out the session for no activity',NULL,NULL,NULL,0),('Console Proxy','DEFAULT','AgentManager','consoleproxy.url.domain','','Console proxy url domain',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','control.cidr','169.254.0.0/16','Changes the cidr for the control network traffic.  Defaults to using link local.  Must be unique within pods',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','control.gateway','169.254.0.1','gateway for the control network traffic',NULL,NULL,NULL,0),('Storage','DEFAULT','StorageManager','copy.volume.wait','10800','In second, timeout for copy volume command',NULL,NULL,NULL,0),('Advanced','DEFAULT','CapacityManager','cpu.overprovisioning.factor','1.0','Used for CPU overprovisioning calculation; available CPU will be (actualCpuCapacity * cpu.overprovisioning.factor)','1.0','2014-06-26 02:23:21','Cluster',1),('Storage','DEFAULT','UserVmManager','create.private.template.from.snapshot.wait','10800','In second, timeout for CreatePrivateTemplateFromSnapshotCommand',NULL,NULL,NULL,0),('Storage','DEFAULT','UserVmManager','create.private.template.from.volume.wait','10800','In second, timeout for CreatePrivateTemplateFromVolumeCommand',NULL,NULL,NULL,0),('Storage','DEFAULT','StorageManager','create.volume.from.snapshot.wait','10800','In second, timeout for creating volume from snapshot',NULL,NULL,NULL,0),('Advanced','DEFAULT','VolumeOrchestrationService','custom.diskoffering.size.max','1024','Maximum size in GB for custom disk offering.','1024','2014-06-26 02:23:18','Global',1),('Advanced','DEFAULT','VolumeOrchestrationService','custom.diskoffering.size.min','1','Minimum size in GB for custom disk offering.','1','2014-06-26 02:23:18','Global',1),('Advanced','DEFAULT','ExtensionRegistry','data.motion.strategies.exclude',NULL,'Extensions to exclude from being registered',NULL,'2014-06-26 02:23:17','Global',0),('Advanced','DEFAULT','management-server','default.page.size','10000','Default page size for API list* commands',NULL,NULL,NULL,0),('Advanced','DEFAULT','ExtensionRegistry','deployment.planners.exclude','SkipHeuresticsPlanner','Extensions to exclude from being registered','SkipHeuresticsPlanner','2014-06-26 02:23:19','Global',0),('Advanced','DEFAULT','ExtensionRegistry','deployment.planners.order','FirstFitPlanner,UserDispersingPlanner,UserConcentratedPodPlanner,ImplicitDedicationPlanner,BareMetalPlanner','The order of precedence for the extensions','FirstFitPlanner,UserDispersingPlanner,UserConcentratedPodPlanner,ImplicitDedicationPlanner,BareMetalPlanner','2014-06-26 02:23:19','Global',0),('Advanced','DEFAULT','management-server','detail.batch.query.size','2000','Default entity detail batch query size for listing','2000',NULL,NULL,0),('Advanced','DEFAULT','management-server','developer','true',NULL,'true',NULL,NULL,0),('Advanced','DEFAULT','ExtensionRegistry','dhcp.providers.exclude','MidoNetElement','Extensions to exclude from being registered','MidoNetElement','2014-06-26 02:23:21','Global',0),('Advanced','DEFAULT','AgentManager','direct.agent.load.size','1000','How many agents to connect to in each round','16','2014-06-26 02:24:23','Global',1),('Advanced','DEFAULT','management-server','direct.agent.pool.size','500','Default size for DirectAgentPool','500','2014-06-26 02:23:21','Global',0),('Advanced','DEFAULT','management-server','direct.agent.scan.interval','90','Interval between scans to load agents','90','2014-06-26 02:23:21','Global',0),('Advanced','DEFAULT','AgentManager','direct.agent.thread.cap','1','Percentage (as a value between 0 and 1) of direct.agent.pool.size to be used as upper thread cap for a single direct agent to process requests','1','2014-06-26 02:23:21','Global',0),('Advanced','DEFAULT','management-server','direct.attach.network.externalIpAllocator.enabled','false','Direct-attach VMs using external DHCP server',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','direct.attach.network.externalIpAllocator.url',NULL,'Direct-attach VMs using external DHCP server (API url)',NULL,NULL,NULL,0),('Network','DEFAULT','management-server','direct.network.no.default.route','false','Direct Network Dhcp Server should not send a default route',NULL,NULL,NULL,0),('Usage','DEFAULT','management-server','direct.network.stats.interval','86400','Interval (in seconds) to collect stats from Traffic Monitor',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','disable.extraction','false','Flag for disabling extraction of template, isos and volumes',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','eip.use.multiple.netscalers','false','Should be set to true, if there will be multiple NetScaler devices providing EIP service in a zone','false',NULL,NULL,0),('Advanced','DEFAULT','management-server','enable.baremetal.securitygroup.agent.echo','false','After starting provision process, periodcially echo security agent installed in the template. Treat provisioning as success only if echo successfully','false',NULL,NULL,0),('Advanced','DEFAULT','management-server','enable.dynamic.scale.vm','false','Enables/Disables dynamically scaling a vm','false','2014-06-26 02:23:20','Zone',1),('Advanced','DEFAULT','management-server','enable.ec2.api','false','enable EC2 API on CloudStack',NULL,NULL,NULL,0),('Storage','DEFAULT','management-server','enable.ha.storage.migration','true','Enable/disable storage migration across primary storage during HA','true','2014-06-26 02:23:18','Global',1),('Advanced','DEFAULT','management-server','enable.s3.api','false','enable Amazon S3 API on CloudStack',NULL,NULL,NULL,0),('Usage','DEFAULT','management-server','enable.usage.server','true','Flag for enabling usage',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','encode.api.response','false','Do URL encoding for the api response, false by default',NULL,NULL,NULL,0),('Advanced','DEFAULT','ApiServiceConfiguration','endpointe.url','http://localhost:8080/client/api','API end point. Can be used by CS components/services deployed remotely, for sending CS API requests','http://localhost:8080/client/api','2014-06-26 02:23:30','Global',1),('Advanced','DEFAULT','management-server','event.purge.delay','15','Events older than specified number days will be purged. Set this value to 0 to never delete events',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','event.purge.interval','86400','The interval (in seconds) to wait before running the event purge thread',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','execute.in.sequence.hypervisor.commands','false','If set to true, StartCommand, StopCommand, CopyCommand, MigrateCommand will be synchronized on the agent side. If set to false, these commands become asynchronous. Default value is false.','false','2014-06-26 02:23:21','Global',0),('Advanced','DEFAULT','management-server','execute.in.sequence.network.element.commands','false','If set to true, DhcpEntryCommand, SavePasswordCommand, UserDataCommand, VmDataCommand will be synchronized on the agent side. If set to false, these commands become asynchronous. Default value is false.','false',NULL,NULL,0),('Advanced','DEFAULT','UserVmManager','expunge.delay','60','Determines how long (in seconds) to wait before actually expunging destroyed vm. The default value = the default value of expunge.interval',NULL,NULL,NULL,0),('Advanced','DEFAULT','UserVmManager','expunge.interval','60','The interval (in seconds) to wait before running the expunge thread.',NULL,NULL,NULL,0),('Advanced','DEFAULT','UserVmManager','expunge.workers','3','Number of workers performing expunge ',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','external.baremetal.resource.classname',NULL,'class name for handling external baremetal resource',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','external.baremetal.system.url',NULL,'url of external baremetal system that CloudStack will talk to',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','external.firewall.default.capacity','50','default number of networks permitted per external load firewall device',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','external.lb.default.capacity','50','default number of networks permitted per external load balancer device',NULL,NULL,NULL,0),('Advanced','DEFAULT','NetworkManager','external.network.stats.interval','300','Interval (in seconds) to report external network statistics.',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','extract.url.cleanup.interval','7200','The interval (in seconds) to wait before cleaning up the extract URL\'s ',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','extract.url.expiration.interval','14400','The life of an extract URL after which it is deleted ',NULL,NULL,NULL,0),('Advanced','DEFAULT','ExtensionRegistry','firewall.service.provider.exclude',NULL,'Extensions to exclude from being registered',NULL,'2014-06-26 02:23:19','Global',0),('Network','DEFAULT','NetworkOrchestrationService','guest.domain.suffix','sandbox.simulator','Default domain name for vms inside virtualized networks fronted by router','cloud.internal','2014-06-26 02:23:21','Zone',1),('Network','DEFAULT','management-server','guest.vlan.bits','12','The number of bits to reserve for the VLAN identifier in the guest subnet.',NULL,NULL,NULL,0),('Advanced','DEFAULT','ExtensionRegistry','ha.fence.builders.exclude','RecreatableFencer','Extensions to exclude from being registered','RecreatableFencer','2014-06-26 02:23:21','Global',0),('Advanced','DEFAULT','ExtensionRegistry','ha.investigators.exclude',NULL,'Extensions to exclude from being registered',NULL,'2014-06-26 02:23:21','Global',0),('Advanced','DEFAULT','ExtensionRegistry','ha.investigators.order','SimpleInvestigator,XenServerInvestigator,PingInvestigator,ManagementIPSysVMInvestigator,KVMInvestigator','The order of precedence for the extensions','SimpleInvestigator,XenServerInvestigator,PingInvestigator,ManagementIPSysVMInvestigator,KVMInvestigator','2014-06-26 02:23:21','Global',0),('Advanced','DEFAULT','ExtensionRegistry','ha.planners.exclude',NULL,'Extensions to exclude from being registered',NULL,'2014-06-26 02:23:21','Global',0),('Advanced','DEFAULT','management-server','ha.tag',NULL,'HA tag defining that the host marked with this tag can be used for HA purposes only',NULL,NULL,NULL,0),('Advanced','DEFAULT','AgentManager','ha.workers','5','Number of ha worker threads.',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','healthcheck.update.interval','600','Time Interval to fetch the LB health check states (in sec)','600',NULL,NULL,0),('Advanced','DEFAULT','ApiServiceConfiguration','host','192.168.1.10','The ip address of management server','localhost','2014-06-26 02:23:27','Global',1),('Advanced','DEFAULT','ExtensionRegistry','host.allocators.exclude','RandomAllocator,TestingAllocator,FirstFitAllocator,RecreateHostAllocator','Extensions to exclude from being registered','RandomAllocator,TestingAllocator,FirstFitAllocator,RecreateHostAllocator','2014-06-26 02:23:19','Global',0),('Advanced','DEFAULT','ExtensionRegistry','host.allocators.order','FirstFitRouting','The order of precedence for the extensions','FirstFitRouting','2014-06-26 02:23:19','Global',0),('Advanced','DEFAULT','management-server','host.capacityType.to.order.clusters','CPU','The host capacity type (CPU or RAM) is used by deployment planner to order clusters during VM resource allocation',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','host.reservation.release.period','300000','The interval in milliseconds between host reservation release checks','300000',NULL,NULL,0),('Advanced','DEFAULT','AgentManager','host.retry','2','Number of times to retry hosts for creating a volume',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','host.stats.interval','60000','The interval (in milliseconds) when host stats are retrieved from agents.',NULL,NULL,NULL,0),('Hidden','DEFAULT','management-server','hyperv.guest.network.device',NULL,'Specify the virtual switch on host for guest network',NULL,NULL,NULL,0),('Hidden','DEFAULT','management-server','hyperv.private.network.device',NULL,'Specify the virtual switch on host for private network',NULL,NULL,NULL,0),('Hidden','DEFAULT','management-server','hyperv.public.network.device',NULL,'Specify the public virtual switch on host for public network',NULL,NULL,NULL,0),('Advanced','DEFAULT','ExtensionRegistry','hypervisor.gurus.exclude',NULL,'Extensions to exclude from being registered',NULL,'2014-06-26 02:23:21','Global',0),('Advanced','DEFAULT','management-server','hypervisor.list','Hyperv,KVM,XenServer,VMware,BareMetal,Ovm,LXC','The list of hypervisors that this deployment will use.',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','incorrect.login.attempts.allowed','5','Incorrect login attempts allowed before the user is disabled',NULL,NULL,NULL,0),('Hidden','DEFAULT','management-server','init','true',NULL,'false',NULL,NULL,0),('Advanced','DEFAULT','AgentManager','instance.name','QA','Name of the deployment instance.',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','integration.api.port','8096',NULL,'8096',NULL,NULL,0),('Advanced','DEFAULT','NetworkManager','internallbvm.service.offering',NULL,'Uuid of the service offering used by internal lb vm; if NULL - default system internal lb offering will be used',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','interval.baremetal.securitygroup.agent.echo','10','Interval to echo baremetal security group agent, in seconds','10',NULL,NULL,0),('Advanced','DEFAULT','HighAvailabilityManager','investigate.retry.interval','60','Time (in seconds) between VM pings when agent is disconnected',NULL,NULL,NULL,0),('Advanced','DEFAULT','ExtensionRegistry','ip.deployers.exclude','MidoNetElement','Extensions to exclude from being registered','MidoNetElement','2014-06-26 02:23:21','Global',0),('Advanced','DEFAULT','AsyncJobManager','job.cancel.threshold.minutes','60','Time (in minutes) for async-jobs to be forcely cancelled if it has been in process for long','60','2014-06-26 02:23:18','Global',1),('Advanced','DEFAULT','AsyncJobManager','job.expire.minutes','1440','Time (in minutes) for async-jobs to be kept in system','1440','2014-06-26 02:23:18','Global',1),('Advanced','DEFAULT','management-server','json.content.type','text/javascript','Http response content type for .js files (default is text/javascript)',NULL,NULL,NULL,0),('Hidden','DEFAULT','management-server','kvm.guest.network.device',NULL,'Specify the private bridge on host for private network',NULL,NULL,NULL,0),('Hidden','DEFAULT','management-server','kvm.private.network.device',NULL,'Specify the private bridge on host for private network',NULL,NULL,NULL,0),('Hidden','DEFAULT','management-server','kvm.public.network.device',NULL,'Specify the public bridge on host for public network',NULL,NULL,NULL,0),('Snapshots','DEFAULT','SnapshotManager','kvm.snapshot.enabled','false','whether snapshot is enabled for KVM hosts','false',NULL,NULL,0),('Advanced','DEFAULT','management-server','kvm.ssh.to.agent','true','Specify whether or not the management server is allowed to SSH into KVM Agents','true',NULL,NULL,0),('Secure','DEFAULT','management-server','ldap.basedn',NULL,'Sets the basedn for LDAP',NULL,NULL,NULL,0),('Secure','DEFAULT','management-server','ldap.bind.password',NULL,'Specifies the password to use for binding to LDAP',NULL,NULL,NULL,0),('Secure','DEFAULT','management-server','ldap.bind.principal',NULL,'Specifies the bind principal to use for bind to LDAP',NULL,NULL,NULL,0),('Secure','DEFAULT','management-server','ldap.email.attribute','mail','Sets the email attribute used within LDAP',NULL,NULL,NULL,0),('Secure','DEFAULT','management-server','ldap.firstname.attribute','givenname','Sets the firstname attribute used within LDAP',NULL,NULL,NULL,0),('Secure','DEFAULT','management-server','ldap.group.object','groupOfUniqueNames','Sets the object type of groups within LDAP',NULL,NULL,NULL,0),('Secure','DEFAULT','management-server','ldap.group.user.uniquemember','uniquemember','Sets the attribute for uniquemembers within a group',NULL,NULL,NULL,0),('Secure','DEFAULT','management-server','ldap.lastname.attribute','sn','Sets the lastname attribute used within LDAP',NULL,NULL,NULL,0),('Secure','DEFAULT','management-server','ldap.search.group.principle',NULL,'Sets the principle of the group that users must be a member of',NULL,NULL,NULL,0),('Secure','DEFAULT','management-server','ldap.truststore',NULL,'Sets the path to the truststore to use for LDAP SSL',NULL,NULL,NULL,0),('Secure','DEFAULT','management-server','ldap.truststore.password',NULL,'Sets the password for the truststore',NULL,NULL,NULL,0),('Secure','DEFAULT','management-server','ldap.user.object','inetOrgPerson','Sets the object type of users within LDAP',NULL,NULL,NULL,0),('Secure','DEFAULT','management-server','ldap.username.attribute','uid','Sets the username attribute used within LDAP',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','linkLocalIp.nums','10','The number of link local ip that needed by domR(in power of 2)',NULL,NULL,NULL,0),('Advanced','DEFAULT','ExtensionRegistry','load.balancing.service.provider.exclude',NULL,'Extensions to exclude from being registered',NULL,'2014-06-26 02:23:20','Global',0),('Advanced','DEFAULT','management-server','management.network.cidr','192.168.1.0/24','The cidr of management server network',NULL,NULL,NULL,0),('Account Defaults','DEFAULT','management-server','max.account.cpus','40','The default maximum number of cpu cores that can be used for an account','40',NULL,NULL,0),('Account Defaults','DEFAULT','management-server','max.account.memory','40960','The default maximum memory (in MiB) that can be used for an account','40960',NULL,NULL,0),('Account Defaults','DEFAULT','management-server','max.account.networks','20','The default maximum number of networks that can be created for an account',NULL,NULL,NULL,0),('Account Defaults','DEFAULT','management-server','max.account.primary.storage','200','The default maximum primary storage space (in GiB) that can be used for an account','200',NULL,NULL,0),('Account Defaults','DEFAULT','management-server','max.account.public.ips','20','The default maximum number of public IPs that can be consumed by an account',NULL,NULL,NULL,0),('Account Defaults','DEFAULT','management-server','max.account.secondary.storage','400','The default maximum secondary storage space (in GiB) that can be used for an account','400',NULL,NULL,0),('Account Defaults','DEFAULT','management-server','max.account.snapshots','20','The default maximum number of snapshots that can be created for an account',NULL,NULL,NULL,0),('Account Defaults','DEFAULT','management-server','max.account.templates','20','The default maximum number of templates that can be deployed for an account',NULL,NULL,NULL,0),('Account Defaults','DEFAULT','management-server','max.account.user.vms','20','The default maximum number of user VMs that can be deployed for an account',NULL,NULL,NULL,0),('Account Defaults','DEFAULT','management-server','max.account.volumes','20','The default maximum number of volumes that can be created for an account',NULL,NULL,NULL,0),('Account Defaults','DEFAULT','management-server','max.account.vpcs','20','The default maximum number of vpcs that can be created for an account',NULL,NULL,NULL,0),('Project Defaults','DEFAULT','management-server','max.project.cpus','40','The default maximum number of cpu cores that can be used for a project','40',NULL,NULL,0),('Project Defaults','DEFAULT','management-server','max.project.memory','40960','The default maximum memory (in MiB) that can be used for a project','40960',NULL,NULL,0),('Project Defaults','DEFAULT','management-server','max.project.networks','20','The default maximum number of networks that can be created for a project',NULL,NULL,NULL,0),('Project Defaults','DEFAULT','management-server','max.project.primary.storage','200','The default maximum primary storage space (in GiB) that can be used for a project','200',NULL,NULL,0),('Project Defaults','DEFAULT','management-server','max.project.public.ips','20','The default maximum number of public IPs that can be consumed by a project',NULL,NULL,NULL,0),('Project Defaults','DEFAULT','management-server','max.project.secondary.storage','400','The default maximum secondary storage space (in GiB) that can be used for a project','400',NULL,NULL,0),('Project Defaults','DEFAULT','management-server','max.project.snapshots','20','The default maximum number of snapshots that can be created for a project',NULL,NULL,NULL,0),('Project Defaults','DEFAULT','management-server','max.project.templates','20','The default maximum number of templates that can be deployed for a project',NULL,NULL,NULL,0),('Project Defaults','DEFAULT','management-server','max.project.user.vms','20','The default maximum number of user VMs that can be deployed for a project',NULL,NULL,NULL,0),('Project Defaults','DEFAULT','management-server','max.project.volumes','20','The default maximum number of volumes that can be created for a project',NULL,NULL,NULL,0),('Project Defaults','DEFAULT','management-server','max.project.vpcs','20','The default maximum number of vpcs that can be created for a project',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','max.template.iso.size','50','The maximum size for a downloaded template or ISO (in GB).',NULL,NULL,NULL,0),('Advanced','DEFAULT','CapacityManager','mem.overprovisioning.factor','1.0','Used for memory overprovisioning calculation','1.0','2014-06-26 02:23:21','Cluster',1),('Advanced','DEFAULT','management-server','mgt.server.vendor','ACS','the vendor of management server','ACS',NULL,NULL,0),('Network','DEFAULT','management-server','midonet.apiserver.address','http://localhost:8081','Specify the address at which the Midonet API server can be contacted (if using Midonet)','http://localhost:8081',NULL,NULL,0),('Network','DEFAULT','management-server','midonet.providerrouter.id','d7c5e6a3-e2f4-426b-b728-b7ce6a0448e5','Specifies the UUID of the Midonet provider router (if using Midonet)','d7c5e6a3-e2f4-426b-b728-b7ce6a0448e5',NULL,NULL,0),('Advanced','DEFAULT','HighAvailabilityManager','migrate.retry.interval','120','Time (in seconds) between migration retries',NULL,NULL,NULL,0),('Advanced','DEFAULT','AgentManager','migratewait','3600','Time (in seconds) to wait for VM migrate finish',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','mount.parent','/mnt','The mount point on the Management Server for Secondary Storage.',NULL,NULL,NULL,0),('Advanced','DEFAULT','ExtensionRegistry','network.acl.service.provider.exclude',NULL,'Extensions to exclude from being registered',NULL,'2014-06-26 02:23:18','Global',0),('Network','DEFAULT','NetworkManager','network.dhcp.nondefaultnetwork.setgateway.guestos','Windows','The guest OS\'s name start with this fields would result in DHCP server response gateway information even when the network it\'s on is not default network. Names are separated by comma.','Windows',NULL,NULL,0),('Network','DEFAULT','management-server','network.disable.rpfilter','true','disable rp_filter on Domain Router VM public interfaces.',NULL,NULL,NULL,0),('Advanced','DEFAULT','NetworkManager','network.dns.basiczone.updates','all','This parameter can take 2 values: all (default) and pod. It defines if DHCP/DNS requests have to be send to all dhcp servers in cloudstack, or only to the one in the same pod',NULL,NULL,NULL,0),('Advanced','DEFAULT','ExtensionRegistry','network.elements.registry.exclude','ElasticLoadBalancerElement','Extensions to exclude from being registered','ElasticLoadBalancerElement','2014-06-26 02:23:20','Global',0),('Advanced','DEFAULT','NetworkOrchestrationService','network.gc.interval','60','Seconds to wait before checking for networks to shutdown','600','2014-06-26 02:23:21','Global',1),('Advanced','DEFAULT','NetworkOrchestrationService','network.gc.wait','60','Time (in seconds) to wait before shutting down a network that\'s not in used','600','2014-06-26 02:23:21','Global',0),('Network','DEFAULT','NetworkManager','network.guest.cidr.limit','22','size limit for guest cidr; can\'t be less than this value',NULL,NULL,NULL,0),('Advanced','DEFAULT','ExtensionRegistry','network.gurus.exclude',NULL,'Extensions to exclude from being registered',NULL,'2014-06-26 02:23:20','Global',0),('Network','DEFAULT','management-server','network.ipv6.search.retry.max','10000','The maximum number of retrying times to search for an available IPv6 address in the table','10000',NULL,NULL,0),('Advanced','DEFAULT','management-server','network.loadbalancer.basiczone.elb.enabled','false','Whether the load balancing service is enabled for basic zones',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','network.loadbalancer.basiczone.elb.gc.interval.minutes','30','Garbage collection interval to destroy unused ELB vms in minutes. Minimum of 5',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','network.loadbalancer.basiczone.elb.network','guest','Whether the elastic load balancing service public ips are taken from the public or guest network',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','network.loadbalancer.basiczone.elb.vm.cpu.mhz','128','CPU speed for the elastic load balancer vm',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','network.loadbalancer.basiczone.elb.vm.ram.size','128','Memory in MB for the elastic load balancer vm',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','network.loadbalancer.basiczone.elb.vm.vcpu.num','1','Number of VCPU  for the elastic load balancer vm',NULL,NULL,NULL,0),('Network','DEFAULT','management-server','network.loadbalancer.haproxy.max.conn','4096','Load Balancer(haproxy) maximum number of concurrent connections(global max)','4096',NULL,NULL,0),('Secure','DEFAULT','management-server','network.loadbalancer.haproxy.stats.auth','admin1:AdMiN123','Load Balancer(haproxy) authetication string in the format username:password',NULL,NULL,NULL,0),('Network','DEFAULT','management-server','network.loadbalancer.haproxy.stats.port','8081','Load Balancer(haproxy) stats port number.',NULL,NULL,NULL,0),('Network','DEFAULT','management-server','network.loadbalancer.haproxy.stats.uri','/admin?stats','Load Balancer(haproxy) uri.',NULL,NULL,NULL,0),('Network','DEFAULT','management-server','network.loadbalancer.haproxy.stats.visibility','global','Load Balancer(haproxy) stats visibilty, the value can be one of the following six parameters : global,guest-network,link-local,disabled,all,default',NULL,NULL,NULL,0),('Network','DEFAULT','NetworkOrchestrationService','network.lock.timeout','600','Lock wait timeout (seconds) while implementing network','600','2014-06-26 02:23:21','Global',1),('Advanced','DEFAULT','VirtualNetworkApplianceManagerImpl','network.router.EnableServiceMonitoring','true','service monitoring in router enable/disable option, default true','true','2014-06-26 02:23:18','Zone',1),('Network','DEFAULT','management-server','network.securitygroups.defaultadding','true','If true, the user VM would be added to the default security group by default',NULL,NULL,NULL,0),('Network','DEFAULT','management-server','network.securitygroups.work.cleanup.interval','120','Time interval (seconds) in which finished work is cleaned up from the work table',NULL,NULL,NULL,0),('Network','DEFAULT','management-server','network.securitygroups.work.lock.timeout','300','Lock wait timeout (seconds) while updating the security group work queue',NULL,NULL,NULL,0),('Network','DEFAULT','management-server','network.securitygroups.work.per.agent.queue.size','100','The number of outstanding security group work items that can be queued to a host. If exceeded, work items will get dropped to conserve memory. Security Group Sync will take care of ensuring that the host gets updated eventually',NULL,NULL,NULL,0),('Network','DEFAULT','management-server','network.securitygroups.workers.pool.size','50','Number of worker threads processing the security group update work queue',NULL,NULL,NULL,0),('Network','DEFAULT','NetworkOrchestrationService','network.throttling.rate','200','Default data transfer rate in megabits per second allowed in network.','200','2014-06-26 02:23:21','Zone',1),('Hidden','DEFAULT','management-server','ovm.guest.network.device',NULL,'Specify the private bridge on host for private network',NULL,NULL,NULL,0),('Hidden','DEFAULT','management-server','ovm.private.network.device',NULL,'Specify the private bridge on host for private network',NULL,NULL,NULL,0),('Hidden','DEFAULT','management-server','ovm.public.network.device',NULL,'Specify the public bridge on host for public network',NULL,NULL,NULL,0),('Advanced','DEFAULT','AgentManager','ping.interval','60','Interval to send application level pings to make sure the connection is still working','60','2014-06-26 02:23:21','Global',0),('Advanced','DEFAULT','AgentManager','ping.timeout','2.5','Multiplier to ping.interval before announcing an agent has timed out','2.5','2014-06-26 02:23:21','Global',1),('Advanced','DEFAULT','ExtensionRegistry','pod.allocators.exclude',NULL,'Extensions to exclude from being registered',NULL,'2014-06-26 02:23:18','Global',0),('Alert','DEFAULT','management-server','pod.privateip.capacity.notificationthreshold','0.75','Percentage (as a value between 0 and 1) of private IP address space utilization above which alerts will be sent.',NULL,NULL,NULL,0),('Alert','DEFAULT','CapacityManager','pool.storage.allocated.capacity.disablethreshold','0.85','Percentage (as a value between 0 and 1) of allocated storage utilization above which allocators will disable using the pool for low allocated storage available.','0.85','2014-06-26 02:23:21','Zone',1),('Alert','DEFAULT','CapacityManager','pool.storage.capacity.disablethreshold','0.85','Percentage (as a value between 0 and 1) of storage utilization above which allocators will disable using the pool for low storage available.','0.85','2014-06-26 02:23:21','Zone',1),('Advanced','DEFAULT','AgentManager','port','8250','Port to listen on for remote agent connections.','8250','2014-06-26 02:23:21','Global',0),('Advanced','DEFAULT','ExtensionRegistry','port.forwarding.service.provider.exclude',NULL,'Extensions to exclude from being registered',NULL,'2014-06-26 02:23:19','Global',0),('Storage','DEFAULT','TemplateManager','primary.storage.download.wait','10800','In second, timeout for download template to primary storage',NULL,NULL,NULL,0),('Project Defaults','DEFAULT','management-server','project.email.sender',NULL,'Sender of project invitation email (will be in the From header of the email)',NULL,NULL,NULL,0),('Project Defaults','DEFAULT','management-server','project.invite.required','false','If invitation confirmation is required when add account to project. Default value is false',NULL,NULL,NULL,0),('Project Defaults','DEFAULT','management-server','project.invite.timeout','86400','Invitation expiration time (in seconds). Default is 1 day - 86400 seconds',NULL,NULL,NULL,0),('Project Defaults','DEFAULT','management-server','project.smtp.host',NULL,'SMTP hostname used for sending out email project invitations',NULL,NULL,NULL,0),('Secure','DEFAULT','management-server','project.smtp.password',NULL,'Password for SMTP authentication (applies only if project.smtp.useAuth is true)',NULL,NULL,NULL,0),('Project Defaults','DEFAULT','management-server','project.smtp.port','465','Port the SMTP server is listening on',NULL,NULL,NULL,0),('Project Defaults','DEFAULT','management-server','project.smtp.useAuth',NULL,'If true, use SMTP authentication when sending emails',NULL,NULL,NULL,0),('Project Defaults','DEFAULT','management-server','project.smtp.username',NULL,'Username for SMTP authentication (applies only if project.smtp.useAuth is true)',NULL,NULL,NULL,0),('Advanced','DEFAULT','ExtensionRegistry','query.selectors.exclude',NULL,'Extensions to exclude from being registered',NULL,'2014-06-26 02:23:21','Global',0),('Advanced','DEFAULT','VolumeOrchestrationService','recreate.systemvm.enabled','false','If true, will recreate system vm root disk whenever starting system vm','false','2014-06-26 02:23:18','Global',1),('Network','DEFAULT','RemoteAccessVpnService','remote.access.vpn.client.iprange','10.1.2.1-10.1.2.8','The range of ips to be allocated to remote access vpn clients. The first ip in the range is used by the VPN server','10.1.2.1-10.1.2.8','2014-06-26 02:23:20','Account',0),('Network','DEFAULT','AgentManager','remote.access.vpn.psk.length','24','The length of the ipsec preshared key (minimum 8, maximum 256)',NULL,NULL,NULL,0),('Advanced','DEFAULT','ExtensionRegistry','remote.access.vpn.service.provider.exclude',NULL,'Extensions to exclude from being registered',NULL,'2014-06-26 02:23:20','Global',0),('Network','DEFAULT','AgentManager','remote.access.vpn.user.limit','8','The maximum number of VPN users that can be created per account',NULL,NULL,NULL,0),('Advanced','DEFAULT','ExtensionRegistry','resource.discoverers.exclude','dummyHostDiscoverer','Extensions to exclude from being registered','dummyHostDiscoverer','2014-06-26 02:23:21','Global',0),('Advanced','DEFAULT','management-server','resourcecount.check.interval','0','Time (in seconds) to wait before retrying resource count check task. Default is 0 which is to never run the task',NULL,NULL,NULL,0),('Advanced','DEFAULT','HighAvailabilityManager','restart.retry.interval','600','Time (in seconds) between retries to restart a vm',NULL,NULL,NULL,0),('Advanced','DEFAULT','NetworkOrchestrationService','router.aggregation.command.each.timeout','3','timeout in seconds for each Virtual Router command being aggregated. The final aggregation command timeout would be determined by this timeout * commands counts ','3',NULL,NULL,0),('Advanced','DEFAULT','VirtualNetworkApplianceManagerImpl','router.alerts.check.interval','1800','Interval (in seconds) to check for alerts in Virtual Router.','1800','2014-06-26 02:23:18','Global',0),('Advanced','DEFAULT','NetworkManager','router.check.interval','30','Interval (in seconds) to report redundant router status.',NULL,NULL,NULL,0),('Advanced','DEFAULT','NetworkManager','router.check.poolsize','10','Numbers of threads using to check redundant router status.','10',NULL,NULL,0),('Advanced','DEFAULT','NetworkManager','router.cpu.mhz','500','Default CPU speed (MHz) for router VM.',NULL,NULL,NULL,0),('Advanced','DEFAULT','NetworkManager','router.extra.public.nics','2','specify extra public nics used for virtual router(up to 5)',NULL,NULL,NULL,0),('Hidden','DEFAULT','NetworkManager','router.ram.size','128','Default RAM for router VM (in MB).',NULL,NULL,NULL,0),('Advanced','DEFAULT','NetworkOrchestrationService','router.redundant.vrrp.interval','1','seconds between VRRP broadcast. It would 3 times broadcast fail to trigger fail-over mechanism of redundant router','1',NULL,NULL,0),('Advanced','DEFAULT','NetworkManager','router.stats.interval','300','Interval (in seconds) to report router statistics.',NULL,NULL,NULL,0),('Advanced','DEFAULT','NetworkManager','router.template.hyperv','SystemVM Template (HyperV)','Name of the default router template on Hyperv.','SystemVM Template (HyperV)',NULL,NULL,0),('Advanced','DEFAULT','NetworkManager','router.template.kvm','SystemVM Template (KVM)','Name of the default router template on KVM.','SystemVM Template (KVM)',NULL,NULL,0),('Advanced','DEFAULT','NetworkManager','router.template.lxc','SystemVM Template (LXC)','Name of the default router template on LXC.','SystemVM Template (LXC)',NULL,NULL,0),('Advanced','DEFAULT','NetworkManager','router.template.vmware','SystemVM Template (vSphere)','Name of the default router template on Vmware.','SystemVM Template (vSphere)',NULL,NULL,0),('Advanced','DEFAULT','NetworkManager','router.template.xen','SystemVM Template (XenServer)','Name of the default router template on Xenserver.','SystemVM Template (XenServer)',NULL,NULL,0),('Advanced','DEFAULT','VirtualNetworkApplianceManagerImpl','router.version.check','true','If true, router minimum required version is checked before sending command','true','2014-06-26 02:23:18','Global',0),('Advanced','DEFAULT','management-server','s3.rrs.enabled','false','enable s3 reduced redundancy storage','false',NULL,NULL,0),('Advanced','DEFAULT','management-server','s3.singleupload.max.size','5','The maximum size limit for S3 single part upload API(in GB). If it is set to 0, then it means always use multi-part upload to upload object to S3. If it is set to -1, then it means always use single-part upload to upload object to S3.','5',NULL,NULL,0),('Advanced','DEFAULT','management-server','scale.retry','2','Number of times to retry scaling up the vm','2',NULL,NULL,0),('Network','DEFAULT','management-server','sdn.ovs.controller.default.label','cloud-public','Default network label to be used when fetching interface for GRE endpoints',NULL,NULL,NULL,0),('Hidden','DEFAULT','management-server','secondary.storage.vm','true','Deploys a VM per zone to manage secondary storage if true, otherwise secondary storage is mounted on management server',NULL,NULL,NULL,0),('Advanced','DEFAULT','ExtensionRegistry','secondary.storage.vm.allocators.exclude',NULL,'Extensions to exclude from being registered',NULL,'2014-06-26 02:23:21','Global',0),('Advanced','DEFAULT','management-server','secstorage.allowed.internal.sites','10.147.28.0/24','Comma separated list of cidrs internal to the datacenter that can host template download servers, please note 0.0.0.0 is not a valid site',NULL,NULL,NULL,0),('Advanced','DEFAULT','AgentManager','secstorage.capacity.standby','10','The minimal number of command execution sessions that system is able to serve immediately(standby capacity)',NULL,NULL,NULL,0),('Advanced','DEFAULT','AgentManager','secstorage.cmd.execution.time.max','30','The max command execution time in minute',NULL,NULL,NULL,0),('Hidden','DEFAULT','management-server','secstorage.copy.password','hF6cqbpusjfzczi','Password used to authenticate zone-to-zone template copy requests',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','secstorage.encrypt.copy','false','Use SSL method used to encrypt copy traffic between zones',NULL,NULL,NULL,0),('Advanced','DEFAULT','AgentManager','secstorage.proxy',NULL,'http proxy used by ssvm, in http://username:password@proxyserver:port format',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','secstorage.service.offering',NULL,'Service offering used by secondary storage; if NULL - system offering will be used',NULL,NULL,NULL,0),('Advanced','DEFAULT','AgentManager','secstorage.session.max','50','The max number of command execution sessions that a SSVM can handle',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','secstorage.ssl.cert.domain','','SSL certificate used to encrypt copy traffic between zones',NULL,NULL,NULL,0),('Advanced','DEFAULT','AgentManager','secstorage.vm.mtu.size','1500','MTU size (in Byte) of storage network in secondary storage vms',NULL,NULL,NULL,0),('Advanced','DEFAULT','ExtensionRegistry','security.checkers.exclude',NULL,'Extensions to exclude from being registered',NULL,'2014-06-26 02:23:17','Global',0),('Advanced','DEFAULT','ExtensionRegistry','security.checkers.order','AffinityGroupAccessChecker,DomainChecker','The order of precedence for the extensions','AffinityGroupAccessChecker,DomainChecker','2014-06-26 02:23:17','Global',0),('Hidden','DEFAULT','KeyManager','security.encryption.iv',NULL,'base64 encoded IV data',NULL,'2014-06-26 02:23:19','Global',0),('Hidden','DEFAULT','KeyManager','security.encryption.key',NULL,'base64 encoded key data',NULL,'2014-06-26 02:23:19','Global',0),('Hidden','DEFAULT','KeyManager','security.hash.key',NULL,'for generic key-ed hash',NULL,'2014-06-26 02:23:19','Global',0),('Secure','DEFAULT','management-server','security.singlesignon.key','s1waOpVsJ9AaITjH3FsGZXUtzZBCOYIEyHPOYlbS20uW0xvVLG7nU_DBqDmN_LPk5F7w40LSLv_1tytiVdhiSA','A Single Sign-On key used for logging into the cloud',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','security.singlesignon.tolerance.millis','300000','The allowable clock difference in milliseconds between when an SSO login request is made and when it is received.',NULL,NULL,NULL,0),('Network','DEFAULT','management-server','site2site.vpn.customergateway.subnets.limit','10','The maximum number of subnets per customer gateway',NULL,NULL,NULL,0),('Advanced','DEFAULT','ExtensionRegistry','site2site.vpn.service.provider.exclude',NULL,'Extensions to exclude from being registered',NULL,'2014-06-26 02:23:17','Global',0),('Network','DEFAULT','management-server','site2site.vpn.vpngateway.connection.limit','4','The maximum number of VPN connection per VPN gateway',NULL,NULL,NULL,0),('Snapshots','DEFAULT','SnapshotManager','snapshot.backup.rightafter','true','backup snapshot right after snapshot is taken','true',NULL,NULL,0),('Snapshots','DEFAULT','SnapshotManager','snapshot.delta.max','16','max delta snapshots between two full snapshots.',NULL,NULL,NULL,0),('Snapshots','DEFAULT','SnapshotManager','snapshot.max.daily','8','Maximum daily snapshots for a volume',NULL,NULL,NULL,0),('Snapshots','DEFAULT','SnapshotManager','snapshot.max.hourly','8','Maximum hourly snapshots for a volume',NULL,NULL,NULL,0),('Snapshots','DEFAULT','SnapshotManager','snapshot.max.monthly','8','Maximum monthly snapshots for a volume',NULL,NULL,NULL,0),('Snapshots','DEFAULT','SnapshotManager','snapshot.max.weekly','8','Maximum weekly snapshots for a volume',NULL,NULL,NULL,0),('Snapshots','DEFAULT','SnapshotManager','snapshot.poll.interval','300','The time interval in seconds when the management server polls for snapshots to be scheduled.',NULL,NULL,NULL,0),('Advanced','DEFAULT','ExtensionRegistry','snapshot.strategies.exclude',NULL,'Extensions to exclude from being registered',NULL,'2014-06-26 02:23:17','Global',0),('Advanced','DEFAULT','management-server','sortkey.algorithm','false','Sort algorithm for those who use sort key(template, disk offering, service offering, network offering), true means ascending sort while false means descending sort',NULL,NULL,NULL,0),('Hidden','DEFAULT','management-server','ssh.privatekey','-----BEGIN RSA PRIVATE KEY-----\nMIIEogIBAAKCAQEA3jcM+yfLCXrv+POmR4vg7SCgARJuJPKvBRSstyGkDo3wBFfB\nXtcW/iiqnsX66CZFvYmmbqKyKoq1nYOuTR058tUNe/TeJzAagg6Y1+v0NH4A+YJG\noWgN3rM7Skvlp/yo1CW/MqaoEmPOJZF1HRVNBnqsLkwkuh7nj9QdIlCnnH0uaJMO\noDDs/spYv6GFTEvqWsP5kVG8iW6zLAwQtUIm+OAD5ZdMOrQiqZp2M//iWWo56+lS\n/6uZyH2y6+6jMRsrTJQ0hwsmMlC9d7LP6XcSmwOsfEfTJGfihHx/+zC/hwkql6Mm\napU8+jxCweIJr8FSvsxlYRRSVGW9+dCbdRB/ywIDAQABAoIBAFoDLLPz64/ch6Zt\nc9aZd7Q2OfoVMB6xW2oQdOH9s4ndvvLTZVX4hKzRZkPIaJlvH2Lmhk9cghUveN/k\nPk+oXhfaa4rhprdzCdnS9eDJCHPW8qgfOGMbVjr2mTbARbflZbIB1FA9J+nDGfcn\n06vDPB86w9JBL8Ngz2X4gxCqYSrG3SAakTS0nI4KOibyPZwdUf99g8lOMx9EFSDX\neO6i7ok8UhgA45h3xIGWKjzRrzaurHLJfLdXtvxD+ifmZQEYBzdutUWbRI6ianvS\nuKQAh3NDgliGpTIMHqnU7Oexcp/3Whu/0pIzLll6SCS57IsWn/lg37nRBJSKRT+5\neZilOOECgYEA9QVqs4NIKajThGOhpj38nKu5znUkQ5YV9Mx/2+Ahi+g5PE5h8Khx\nSJ4s9OWCUN+hpgQTuYFrT+HEpC2PuBf1hbDmoJXRHsSW2oLrqr84TfmJ9I1tXeMK\nz51pmRQkhJijwfJE6i5xaYetVWQFuWfOlf1y/rTulmobZlc+q3MxRRECgYEA6CwH\nrnd9gg3fh48ErY21Lv20YRDgN1Bfk7FddT0pCruIHGF+3NOK6BJ666wM4GvyTY2w\njg7RpfJOCFAQ0YKJwDCvx4fg2yhEEFq5gU8l+wLc//Bi//Ue7PxZ0jY0vRAvttyR\nHqimAT8nUFrSg3BBZZvlbhdTQZDK6JLQzIdOxxsCgYAFk/394DtAV4uZM/t2IWsi\n1fYA8UHGGCCf1hgDFXMuEDddXBt2sx8BHDjByofQ94ZilS0tx/h9dRJY+oCPHFyG\nkqRte3urS6Zziw96b6gEfm3Zl26p+IVCfL7usTqzmhYAUFepTS1fzarwirpmoipd\n18tKaSwVWI0PI2VV2eWBQQKBgFHxsGhgnji34sw6q0ECQg+q1e5ogWqkgIdlU4Ic\nqw6xr9Gsi5UvSNiuJRpnKEhRcTz0JHuPOWmjwuzmLXl05F+kD3aSO8e+R3+qNc0w\n/UvB7/SZiKekgVzNmHo8TZLpUp3s7X9vsN/BxYNz+tcPWNWfF3Qq4WTD0QoTP4Tg\nwOo/AoGAOPwI51vywda7A2wYwHN5vEr+eXs2oc9/cVPwPOxd7Wtn/mpArcmRnBiM\nzVkAVHjeOxBrKkTdqxcV9fZ3HNaiszHvvoGu9ddREjMzQ2L4Q0KBauzBwrTqrgcB\nEkxKMna1ylRAkvPwZrRZ0PEMLBngsjjd10qyjtyr6w3UPC3vEiM=\n-----END RSA PRIVATE KEY-----','Private key for the entire CloudStack',NULL,NULL,NULL,0),('Hidden','DEFAULT','management-server','ssh.publickey','ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDeNwz7J8sJeu/486ZHi+DtIKABEm4k8q8FFKy3IaQOjfAEV8Fe1xb+KKqexfroJkW9iaZuorIqirWdg65NHTny1Q179N4nMBqCDpjX6/Q0fgD5gkahaA3esztKS+Wn/KjUJb8ypqgSY84lkXUdFU0GeqwuTCS6HueP1B0iUKecfS5okw6gMOz+yli/oYVMS+paw/mRUbyJbrMsDBC1Qib44APll0w6tCKpmnYz/+JZajnr6VL/q5nIfbLr7qMxGytMlDSHCyYyUL13ss/pdxKbA6x8R9MkZ+KEfH/7ML+HCSqXoyZqlTz6PELB4gmvwVK+zGVhFFJUZb350Jt1EH/L iduffy@lp-mac-02-0214','Public key for the entire CloudStack',NULL,NULL,NULL,0),('Hidden','DEFAULT','management-server','ssl.keystore','/u3+7QAAAAIAAAABAAAAAQAFbXlrZXkAAAFG0/UuDgAABQIwggT+MA4GCisGAQQBKgIRAQEFAASCBOqKQY0Pe5/Kw1TyOXmkD4Me+hZZE9eElM/2sckQA1FEiNfq8EuXMYSCTbd5SJAMvfrY6xprgxIqgQjD6oNtjdasOe6URl16G76Rpz6GZGlu9O214NPH28ph1qQScRnkYHSVNW7j2KlSRpfx8F3eyKbOphTehzPbfShbeGygK3PYEuSHcwTZKekdRjm1A08OwHW+SFCHxrjDJ0PlOqiEZyb0LYQgFIDVo+gqRjrbnqcVdZ47amCkCK6NZAInfjo/opqddg9DiVttT4Kw0OSFkDkG/X9Z2VW6Upt+YQaKclPChMgWQ+janEKSyV/Ll/lnnBjtxoSiPG9InA617i+iNtiNAfLn2TLnxNTrmPpEnad7nBD2sYBrSkq7ZoZ2auUPsA3RqK1yQwceVfeFAO0RDY1qowvawlm6QFazZknbTdn6Za5eugV3DiaLj6WNw/0B4R4Opt0meB3pOALDh/uDWiJrOe0MH2cRfcRa/57VGUzvXsv7S+ZxgsF8bRtxlNrPqbFgs7ZD3owVE8SDYWtYa+zYN8DcWzmeIP1rG59N1NHsYwe1SHm/RaZSGpDZm/Ab6ql8bSQSTg8III7eotQ5KA6m0xcsLwEMd/hVqHEZd/0RbF74sjZxyOPkAGsfe/CXPsjovNCGfn6vJf2IBVu30iDR5/TEF9fxMyVGELTkweuucrTY9lAflQJUPPc5/JfieGcFJY6oEO8rc8vkGj6xWxtOX2KTdDwD4G1QGV8Ev3HNDP4RSyY5FFtzWyg73/mTiEYoeSCRmE6kUIDbKIUjd9Mi5wAkELNYOyhtPXRNb5Oo6dCGRV3arzacm6oLKW82X0Eks1V10rVqEq9UIFTseRojpg1k80saV80mm2GJVqhYFUpLpelekK2AFZnn2XoefVKQ0IB9lY8HvIaZF6cOxR2JZZl8lNEJtlkbbaSxC4B79zpz43z3gpUQG4pzfS9iH/xC3Q9EABH0SCRdcURNKTTvSeEpgUS4ioGs5Rm0CMJqalJkL1fNBOzo+gMD/zkwuioF5o5nqdupBwUEg3y0rO64RoCotI6e7Ze9856OA66GDasBrgCW4Fl6QO+s85bf1UMWnyuEX0/PmeaGJ8sHKu/gy5D9xf6lJcEqDOjCp3KQf/zQF02TkQR0TCDemrd/iiZTYGE8R7DoJGh39FxjFy5Ak7GxNoa0pDCCkT6T9viCA97S3KlsOtTz3eBnXutM2CDl65I6U3jRk00lMdk+smqC1V74IevUAVCgfClMxITT0kq4Rk0P+EEwgdofYyf9BkE9xv7dHt4UI12WzDJDpf/pCCeqsaxglcTwics4bS6ojuwLJzSFv2BQsAuUAYzKYd24di6xJotbwzFFXmLHvmINF0FUAIqEpmSwkgzz/nhngH9QJJAEZCnZjFbHtcpMI1omj2/OyWU0vBhdGbVnJIzgh+3gltwWTLF6cceGamOyhyU0afziaC9BFzJEYYJ7UsuXSriGcpLaq/ttxZENY69jnYfIpnmdNpXctaq9fFnsZtEGAryOSfm6BEDQB2HJ4JX74jlwC95C2O4GMw4NSFUf16DqTVhkUwzFHrbK6moz198ruDP/ChOMNGjMARKfO9qTOkIlZRUZcSZ/L4j4hwvaRN4w5Bow51BuIflGwNlUHYC2m8xoRmvvznGWPC8t10UKXsjnGNUmWjV0AAAAAQAFWC41MDkAAANLMIIDRzCCAi+gAwIBAgIECRzMDDANBgkqhkiG9w0BAQsFADBUMRAwDgYDVQQGEwdVbmtub3duMRIwEAYDVQQKEwlsb2NhbGhvc3QxEjAQBgNVBAsTCWxvY2FsaG9zdDEYMBYGA1UEAxMPQ2xvdWRzdGFjayBVc2VyMB4XDTE0MDYyNTE2NTYzOVoXDTI0MDYyMjE2NTYzOVowVDEQMA4GA1UEBhMHVW5rbm93bjESMBAGA1UEChMJbG9jYWxob3N0MRIwEAYDVQQLEwlsb2NhbGhvc3QxGDAWBgNVBAMTD0Nsb3Vkc3RhY2sgVXNlcjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAJNkuy8NxsKLrcZmvCyo5afTr1F2PNbbg9CDtw+7FtJVr8tKGJOjERr6z38StnlB+GgdEqKZK91li4QR6dOx8TsmBoAaHg1cIB1qH71Usu+gMQVGk+J4fLtnTRdXkb7U2LIfjRR5MWUm27C0IkQ+f4WLi2bdfrzCzYxn0Tuee6w1qQNEe9zpblxD7D2+TRyD5eIcEQ3TKXFyi60+cD7aRYpDSq0c2k74PpsldHmTRTol+5ydXVUTIC+QOp07XaFbM8UikW6DTwJk2c7kh8POa4nUCRYWqWkoIRLQbLoT82loY/vARY+10dGkWtLXYAYJHSl9SwYAtsl9utlVOYIgTb8CAwEAAaMhMB8wHQYDVR0OBBYEFBbdqSB+2lw5r7gfntTTg4H0Cw+hMA0GCSqGSIb3DQEBCwUAA4IBAQApp8EospOv82CtaLwCjMFwDMITrPKkGNS+HJFNALTqRwWbeSAe9wdaSJl3mcBmWxkOwgFyUmBag8byoIx/FE3E3PdoJcGo0WjDn6SIHenFX9097Jp8IXg1QE6GKVlIVAp3jQGBhyTbU1XNgNneq/PuL/vvF03TrLAJx5iPOn50A+3eotRgv//hw6st0O5Hu/xFKS1hEOtElQyIgUt4g/O05YdN4s/4e3hkv0GExMMkihVHlaaZGYig9qJC0G+drH4SP32DKy7UTEGu3a7j+W4XbIZGM5DEYrk9VYdeDixL4xxm7WFeZf3EeyRMrCAqZ431edUDcIoxRYYwnHHomKn0JcXml2giY6NCDWSADymq76VNqYM=','SSL Keystore for the management servers',NULL,NULL,NULL,0),('Advanced','DEFAULT','VirtualMachineManager','start.retry','10','Number of times to retry create and start commands','10','2014-06-26 02:23:21','Global',1),('Advanced','DEFAULT','ExtensionRegistry','static.nat.service.provider.exclude',NULL,'Extensions to exclude from being registered',NULL,'2014-06-26 02:23:19','Global',0),('Advanced','DEFAULT','HighAvailabilityManager','stop.retry.interval','600','Time in seconds between retries to stop or destroy a vm',NULL,NULL,NULL,0),('Storage','DEFAULT','management-server','storage.cache.replacement.enabled','true','enable or disable cache storage replacement algorithm.','true',NULL,NULL,0),('Storage','DEFAULT','management-server','storage.cache.replacement.interval','86400','time interval between cache replacement threads (in seconds).','86400',NULL,NULL,0),('Storage','DEFAULT','management-server','storage.cache.replacement.lru.interval','30','time interval for unused data on cache storage (in days).','30',NULL,NULL,0),('Advanced','DEFAULT','StorageManager','storage.cleanup.enabled','true','Enables/disables the storage cleanup thread.',NULL,NULL,NULL,0),('Advanced','DEFAULT','StorageManager','storage.cleanup.interval','300','The interval (in seconds) to wait before running the storage cleanup thread.',NULL,NULL,NULL,0),('Storage','DEFAULT','VolumeOrchestrationService','storage.max.volume.size','2000','The maximum size for a volume (in GB).','2000','2014-06-26 02:23:18','Global',1),('Storage','DEFAULT','management-server','storage.max.volume.upload.size','500','The maximum size for a uploaded volume(in GB).',NULL,NULL,NULL,0),('Storage','DEFAULT','CapacityManager','storage.overprovisioning.factor','2','Used for storage overprovisioning calculation; available storage will be (actualStorageSize * storage.overprovisioning.factor)','2','2014-06-26 02:23:21','StoragePool',1),('Advanced','DEFAULT','ExtensionRegistry','storage.pool.allocators.exclude','GCStorage','Extensions to exclude from being registered','GCStorage','2014-06-26 02:23:18','Global',0),('Advanced','DEFAULT','ExtensionRegistry','storage.pool.allocators.order','LocalStorage,ClusterScopeStoragePoolAllocator,ZoneWideStoragePoolAllocator','The order of precedence for the extensions','LocalStorage,ClusterScopeStoragePoolAllocator,ZoneWideStoragePoolAllocator','2014-06-26 02:23:18','Global',0),('Storage','DEFAULT','management-server','storage.pool.max.waitseconds','3600','Timeout (in seconds) to synchronize storage pool operations.',NULL,NULL,NULL,0),('Storage','DEFAULT','management-server','storage.stats.interval','60000','The interval (in milliseconds) when storage stats (per host) are retrieved from agents.',NULL,NULL,NULL,0),('Storage','DEFAULT','management-server','storage.template.cleanup.enabled','true','Enable/disable template cleanup activity, only take effect when overall storage cleanup is enabled',NULL,NULL,NULL,0),('Advanced','DEFAULT','VirtualMachineManager','sync.interval','60','Cluster Delta sync interval in seconds','60','2014-06-26 02:23:21','Global',0),('Advanced','DEFAULT','management-server','system.vm.auto.reserve.capacity','true','Indicates whether or not to automatically reserver system VM standby capacity.',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','system.vm.default.hypervisor',NULL,'Hypervisor type used to create system vm, valid values are: XenServer, KVM, VMware, Hyperv, VirtualBox, Parralels, BareMetal, Ovm, LXC, Any',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','system.vm.random.password','false','Randomize system vm password the first time management server starts',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','system.vm.use.local.storage','false','Indicates whether to use local storage pools or shared storage pools for system VMs.',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','task.cleanup.retry.interval','600','Time (in seconds) to wait before retrying cleanup of tasks if the cleanup failed previously.  0 means to never retry.',NULL,NULL,NULL,0),('Advanced','DEFAULT','ExtensionRegistry','template.adapter.exclude',NULL,'Extensions to exclude from being registered',NULL,'2014-06-26 02:23:17','Global',0),('Advanced','DEFAULT','management-server','timeout.baremetal.securitygroup.agent.echo','3600','Timeout to echo baremetal security group agent, in seconds, the provisioning process will be treated as a failure','3600',NULL,NULL,0),('Storage','DEFAULT','AgentManager','total.retries','4','The number of times each command sent to a host should be retried in case of failure.',NULL,NULL,NULL,0),('Usage','DEFAULT','management-server','traffic.sentinel.exclude.zones','','Traffic going into specified list of zones is not metered','',NULL,NULL,0),('Usage','DEFAULT','management-server','traffic.sentinel.include.zones','EXTERNAL','Traffic going into specified list of zones is metered. For metering all traffic leave this parameter empty','EXTERNAL',NULL,NULL,0),('Advanced','DEFAULT','management-server','ucs.sync.blade.interval','3600','the interval cloudstack sync with UCS manager for available blades in case user remove blades from chassis without notifying CloudStack','3600',NULL,NULL,0),('Advanced','DEFAULT','AgentManager','update.wait','600','Time to wait (in seconds) before alerting on a updating agent',NULL,NULL,NULL,0),('Usage','DEFAULT','management-server','usage.aggregation.timezone','GMT','The timezone to use for usage stats aggregation',NULL,NULL,NULL,0),('Usage','DEFAULT','management-server','usage.execution.timezone',NULL,'The timezone to use for usage job execution time',NULL,NULL,NULL,0),('Usage','DEFAULT','management-server','usage.sanity.check.interval',NULL,'Interval (in days) to check sanity of usage data',NULL,NULL,NULL,0),('Usage','DEFAULT','management-server','usage.stats.job.aggregation.range','1440','The range of time for aggregating the user statistics specified in minutes (e.g. 1440 for daily, 60 for hourly.',NULL,NULL,NULL,0),('Usage','DEFAULT','management-server','usage.stats.job.exec.time','00:15','The time at which the usage statistics aggregation job will run as an HH24:MM time, e.g. 00:30 to run at 12:30am.',NULL,NULL,NULL,0),('Advanced','DEFAULT','VirtualNetworkApplianceManagerImpl','use.external.dns','false','Bypass internal dns, use external dns1 and dns2','false','2014-06-26 02:23:18','Zone',1),('Advanced','DEFAULT','management-server','use.system.guest.vlans','true','If true, when account has dedicated guest vlan range(s), once the vlans dedicated to the account have been consumed vlans will be allocated from the system pool','true','2014-06-26 02:23:32','Account',0),('Advanced','DEFAULT','management-server','use.system.public.ips','true','If true, when account has dedicated public ip range(s), once the ips dedicated to the account have been consumed ips will be acquired from the system pool','true','2014-06-26 02:23:20','Account',1),('Advanced','DEFAULT','ExtensionRegistry','user.authenticators.exclude',NULL,'Extensions to exclude from being registered',NULL,'2014-06-26 02:23:20','Global',0),('Advanced','DEFAULT','ExtensionRegistry','user.authenticators.order','SHA256SALT,MD5,LDAP,PLAINTEXT','The order of precedence for the extensions','SHA256SALT,MD5,LDAP,PLAINTEXT','2014-06-26 02:23:20','Global',0),('Advanced','DEFAULT','ExtensionRegistry','user.password.encoders.exclude',NULL,'Extensions to exclude from being registered',NULL,'2014-06-26 02:23:20','Global',0),('Advanced','DEFAULT','ExtensionRegistry','user.password.encoders.order','SHA256SALT,MD5,LDAP,PLAINTEXT','The order of precedence for the extensions','SHA256SALT,MD5,LDAP,PLAINTEXT','2014-06-26 02:23:20','Global',0),('Advanced','DEFAULT','management-server','vm.allocation.algorithm','random','\'random\', \'firstfit\', \'userdispersing\', \'userconcentratedpod_random\', \'userconcentratedpod_firstfit\' : Order in which hosts within a cluster will be considered for VM/volume allocation.',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','vm.deployment.planner','FirstFitPlanner','[\'FirstFitPlanner\', \'UserDispersingPlanner\', \'UserConcentratedPodPlanner\']: DeploymentPlanner heuristic that will be used for VM deployment.','FirstFitPlanner',NULL,NULL,0),('Advanced','DEFAULT','VirtualMachineManager','vm.destroy.forcestop','false','On destroy, force-stop takes this value ','false','2014-06-26 02:23:21','Global',1),('Advanced','DEFAULT','management-server','vm.disk.stats.interval','0','Interval (in seconds) to report vm disk statistics.','0',NULL,NULL,0),('Advanced','DEFAULT','management-server','vm.disk.throttling.bytes_read_rate','0','Default disk I/O read rate in bytes per second allowed in User vm\'s disk. ','0',NULL,NULL,0),('Advanced','DEFAULT','management-server','vm.disk.throttling.bytes_write_rate','0','Default disk I/O write rate in bytes per second allowed in User vm\'s disk. ','0',NULL,NULL,0),('Advanced','DEFAULT','management-server','vm.disk.throttling.iops_read_rate','0','Default disk I/O read rate in requests per second allowed in User vm\'s disk. ','0',NULL,NULL,0),('Advanced','DEFAULT','management-server','vm.disk.throttling.iops_write_rate','0','Default disk I/O write rate in requests per second allowed in User vm\'s disk. ','0',NULL,NULL,0),('Advanced','DEFAULT','management-server','vm.instancename.flag','false','If set to true, will set guest VM\'s name as it appears on the hypervisor, to its hostname','false',NULL,NULL,0),('Advanced','DEFAULT','VirtualMachineManager','vm.job.check.interval','3000','Interval in milliseconds to check if the job is complete','3000','2014-06-26 02:23:21','Global',0),('Advanced','DEFAULT','VirtualMachineManager','vm.job.report.interval','60','Interval to send application level pings to make sure the connection is still working','60','2014-06-26 02:23:21','Global',0),('Advanced','DEFAULT','VirtualMachineManager','vm.job.timeout','600000','Time in milliseconds to wait before attempting to cancel a job','600000','2014-06-26 02:23:21','Global',0),('NetworkManager','DEFAULT','management-server','vm.network.nic.max.secondary.ipaddresses',NULL,'Specify the number of secondary ip addresses per nic per vm','256',NULL,NULL,0),('Network','DEFAULT','management-server','vm.network.throttling.rate','200','Default data transfer rate in megabits per second allowed in User vm\'s default network.',NULL,NULL,NULL,0),('Advanced','DEFAULT','VirtualMachineManager','vm.op.cancel.interval','3600','Time (in seconds) to wait before cancelling a operation','3600','2014-06-26 02:23:21','Global',0),('Advanced','DEFAULT','VirtualMachineManager','vm.op.cleanup.interval','86400','Interval to run the thread that cleans up the vm operations (in seconds)','86400','2014-06-26 02:23:21','Global',0),('Advanced','DEFAULT','VirtualMachineManager','vm.op.cleanup.wait','3600','Time (in seconds) to wait before cleanuping up any vm work items','3600','2014-06-26 02:23:21','Global',1),('Advanced','DEFAULT','VirtualMachineManager','vm.op.lock.state.retry','5','Times to retry locking the state of a VM for operations, -1 means forever','5','2014-06-26 02:23:21','Global',1),('Advanced','DEFAULT','VirtualMachineManager','vm.op.wait.interval','5','Time (in seconds) to wait before checking if a previous operation has succeeded','120','2014-06-26 02:23:21','Global',1),('Secure','DEFAULT','management-server','vm.password.length','6','Specifies the length of a randomly generated password','6',NULL,NULL,0),('Advanced','DEFAULT','management-server','vm.stats.interval','60000','The interval (in milliseconds) when vm stats are retrieved from agents.',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','vm.tranisition.wait.interval','3600','Time (in seconds) to wait before taking over a VM in transition state',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','vm.user.dispersion.weight','1','Weight for user dispersion heuristic (as a value between 0 and 1) applied to resource allocation during vm deployment. Weight for capacity heuristic will be (1 - weight of user dispersion)',NULL,NULL,NULL,0),('Advanced','DEFAULT','VMSnapshotManager','vmsnapshot.create.wait','1800','In second, timeout for create vm snapshot',NULL,NULL,NULL,0),('Advanced','DEFAULT','VMSnapshotManager','vmsnapshot.max','10','Maximum vm snapshots for a vm',NULL,NULL,NULL,0),('Advanced','DEFAULT','ExtensionRegistry','vmSnapshot.strategies.exclude',NULL,'Extensions to exclude from being registered',NULL,'2014-06-26 02:23:17','Global',0),('Advanced','DEFAULT','management-server','vmware.additional.vnc.portrange.size','1000','Start port number of additional VNC port range',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','vmware.additional.vnc.portrange.start','50000','Start port number of additional VNC port range',NULL,NULL,NULL,0),('Advanced','DEFAULT','UserVmManager','vmware.create.full.clone','true','If set to true, creates VMs as full clones on ESX hypervisor','true',NULL,NULL,0),('Advanced','DEFAULT','management-server','vmware.hung.wokervm.timeout','7200','Worker VM timeout in seconds','7200',NULL,NULL,0),('Advanced','DEFAULT','management-server','vmware.management.portgroup','Management Network','Specify the management network name(for ESXi hosts)',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','vmware.nested.virtualization','false','When set to true this will enable nested virtualization when this is supported by the hypervisor','false',NULL,NULL,0),('Network','DEFAULT','management-server','vmware.ports.per.dvportgroup','256','Default number of ports per Vmware dvPortGroup in VMware environment','256',NULL,NULL,0),('Advanced','DEFAULT','management-server','vmware.recycle.hung.wokervm','false','Specify whether or not to recycle hung worker VMs',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','vmware.reserve.cpu','false','Specify whether or not to reserve CPU based on CPU overprovisioning factor',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','vmware.reserve.mem','false','Specify whether or not to reserve memory based on memory overprovisioning factor',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','vmware.root.disk.controller','ide','Specify the default disk controller for root volumes, valid values are scsi, ide',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','vmware.service.console','Service Console','Specify the service console network name(for ESX hosts)',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','vmware.systemvm.nic.device.type','E1000','Specify the default network device type for system VMs, valid values are E1000, PCNet32, Vmxnet2, Vmxnet3',NULL,NULL,NULL,0),('Network','DEFAULT','management-server','vmware.use.dvswitch','false','Enable/Disable Nexus/Vmware dvSwitch in VMware environment','false',NULL,NULL,0),('Network','DEFAULT','management-server','vmware.use.nexus.vswitch','false','Enable/Disable Cisco Nexus 1000v vSwitch in VMware environment',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','vmware.vcenter.session.timeout','1200','VMware client timeout in seconds','1200',NULL,NULL,0),('Advanced','DEFAULT','management-server','vpc.cleanup.interval','3600','The interval (in seconds) between cleanup for Inactive VPCs',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','vpc.max.networks','3','Maximum number of networks per vpc',NULL,NULL,NULL,0),('Advanced','DEFAULT','ExtensionRegistry','vpc.providers.exclude',NULL,'Extensions to exclude from being registered',NULL,'2014-06-26 02:23:16','Global',0),('Advanced','DEFAULT','AgentManager','wait','1800','Time in seconds to wait for control commands to return','1800','2014-06-26 02:23:21','Global',1),('Advanced','DEFAULT','AgentManager','workers','10','Number of worker threads handling remote agent connections.','5','2014-06-26 02:23:21','Global',0),('Advanced','DEFAULT','AgentManager','xapiwait','600','Time (in seconds) to wait for XAPI to return',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','xen.bond.storage.nics',NULL,'Attempt to bond the two networks if found',NULL,NULL,NULL,0),('Hidden','DEFAULT','management-server','xen.create.pools.in.pod','false','Should we automatically add XenServers into pools that are inside a Pod',NULL,NULL,NULL,0),('Hidden','DEFAULT','management-server','xen.guest.network.device',NULL,'Specify for guest network name label',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','xen.heartbeat.interval','60','heartbeat to use when implementing XenServer Self Fencing',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','xen.hotfix.enabled','false','Enable/Disable xenserver hot fix',NULL,NULL,NULL,0),('Advanced','DEFAULT','AgentManager','xen.nics.max','7','Maximum allowed nics for Vms created on Xen','7',NULL,NULL,0),('Hidden','DEFAULT','management-server','xen.private.network.device',NULL,'Specify when the private network name is different',NULL,NULL,NULL,0),('Hidden','DEFAULT','management-server','xen.public.network.device',NULL,'[ONLY IF THE PUBLIC NETWORK IS ON A DEDICATED NIC]:The network name label of the physical device dedicated to the public network on a XenServer host',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','xen.pvdriver.version','xenserver61','default Xen PV driver version for registered template, valid value:xenserver56,xenserver61 ',NULL,NULL,NULL,0),('Advanced','DEFAULT','management-server','xen.setup.multipath','false','Setup the host to do multipath',NULL,NULL,NULL,0),('Hidden','DEFAULT','management-server','xen.storage.network.device1',NULL,'Specify when there are storage networks',NULL,NULL,NULL,0),('Hidden','DEFAULT','management-server','xen.storage.network.device2',NULL,'Specify when there are storage networks',NULL,NULL,NULL,0),('Alert','DEFAULT','management-server','zone.directnetwork.publicip.capacity.notificationthreshold','0.75','Percentage (as a value between 0 and 1) of Direct Network Public Ip Utilization above which alerts will be sent about low number of direct network public ips.',NULL,NULL,NULL,0),('Alert','DEFAULT','management-server','zone.secstorage.capacity.notificationthreshold','0.75','Percentage (as a value between 0 and 1) of secondary storage utilization above which alerts will be sent about low storage available.',NULL,NULL,NULL,0),('Alert','DEFAULT','management-server','zone.virtualnetwork.publicip.capacity.notificationthreshold','0.75','Percentage (as a value between 0 and 1) of public IP address space utilization above which alerts will be sent.',NULL,NULL,NULL,0),('Alert','DEFAULT','management-server','zone.vlan.capacity.notificationthreshold','0.75','Percentage (as a value between 0 and 1) of Zone Vlan utilization above which alerts will be sent about low number of Zone Vlans.',NULL,NULL,NULL,0);
/*!40000 ALTER TABLE `configuration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `console_proxy`
--

DROP TABLE IF EXISTS `console_proxy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `console_proxy` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `public_mac_address` varchar(17) DEFAULT NULL COMMENT 'mac address of the public facing network card',
  `public_ip_address` char(40) DEFAULT NULL COMMENT 'public ip address for the console proxy',
  `public_netmask` varchar(15) DEFAULT NULL COMMENT 'public netmask used for the console proxy',
  `active_session` int(10) NOT NULL DEFAULT '0' COMMENT 'active session number',
  `last_update` datetime DEFAULT NULL COMMENT 'Last session update time',
  `session_details` blob COMMENT 'session detail info',
  PRIMARY KEY (`id`),
  UNIQUE KEY `public_mac_address` (`public_mac_address`),
  CONSTRAINT `fk_console_proxy__id` FOREIGN KEY (`id`) REFERENCES `vm_instance` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `console_proxy`
--

LOCK TABLES `console_proxy` WRITE;
/*!40000 ALTER TABLE `console_proxy` DISABLE KEYS */;
INSERT INTO `console_proxy` VALUES (1,'06:ed:fc:00:00:c8','192.168.2.2','255.255.255.0',0,NULL,NULL);
/*!40000 ALTER TABLE `console_proxy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `counter`
--

DROP TABLE IF EXISTS `counter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `counter` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uuid` varchar(40) DEFAULT NULL,
  `source` varchar(255) NOT NULL COMMENT 'source e.g. netscaler, snmp',
  `name` varchar(255) NOT NULL COMMENT 'Counter name',
  `value` varchar(255) NOT NULL COMMENT 'Value in case of source=snmp',
  `removed` datetime DEFAULT NULL COMMENT 'date removed if not null',
  `created` datetime NOT NULL COMMENT 'date created',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `uc_counter__uuid` (`uuid`),
  KEY `i_counter__removed` (`removed`),
  KEY `i_counter__source` (`source`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `counter`
--

LOCK TABLES `counter` WRITE;
/*!40000 ALTER TABLE `counter` DISABLE KEYS */;
INSERT INTO `counter` VALUES (1,'aec2e002-fcd8-11e3-9019-080027ce083d','snmp','Linux User CPU - percentage','1.3.6.1.4.1.2021.11.9.0',NULL,'2014-06-26 02:22:12'),(2,'aec2f358-fcd8-11e3-9019-080027ce083d','snmp','Linux System CPU - percentage','1.3.6.1.4.1.2021.11.10.0',NULL,'2014-06-26 02:22:12'),(3,'aec3056e-fcd8-11e3-9019-080027ce083d','snmp','Linux CPU Idle - percentage','1.3.6.1.4.1.2021.11.11.0',NULL,'2014-06-26 02:22:12'),(4,'aec32710-fcd8-11e3-9019-080027ce083d','cpu','Linux User CPU - percentage - native','1.3.6.1.4.1.2021.11.9.1',NULL,'2014-06-26 02:22:12'),(5,'aec3376e-fcd8-11e3-9019-080027ce083d','memory','Linux User RAM - percentage - native','1.3.6.1.4.1.2021.11.10.1',NULL,'2014-06-26 02:22:12'),(100,'aec316a8-fcd8-11e3-9019-080027ce083d','netscaler','Response Time - microseconds','RESPTIME',NULL,'2014-06-26 02:22:12');
/*!40000 ALTER TABLE `counter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_center`
--

DROP TABLE IF EXISTS `data_center`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_center` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `uuid` varchar(40) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `dns1` varchar(255) NOT NULL,
  `dns2` varchar(255) DEFAULT NULL,
  `internal_dns1` varchar(255) NOT NULL,
  `internal_dns2` varchar(255) DEFAULT NULL,
  `gateway` varchar(15) DEFAULT NULL,
  `netmask` varchar(15) DEFAULT NULL,
  `router_mac_address` varchar(17) NOT NULL DEFAULT '02:00:00:00:00:01' COMMENT 'mac address for the router within the domain',
  `mac_address` bigint(20) unsigned NOT NULL DEFAULT '1' COMMENT 'Next available mac address for the ethernet card interacting with public internet',
  `guest_network_cidr` varchar(18) DEFAULT NULL,
  `domain` varchar(100) DEFAULT NULL COMMENT 'Network domain name of the Vms of the zone',
  `domain_id` bigint(20) unsigned DEFAULT NULL COMMENT 'domain id for the parent domain to this zone (null signifies public zone)',
  `networktype` varchar(255) NOT NULL DEFAULT 'Basic' COMMENT 'Network type of the zone',
  `dns_provider` char(64) DEFAULT 'VirtualRouter',
  `gateway_provider` char(64) DEFAULT 'VirtualRouter',
  `firewall_provider` char(64) DEFAULT 'VirtualRouter',
  `dhcp_provider` char(64) DEFAULT 'VirtualRouter',
  `lb_provider` char(64) DEFAULT 'VirtualRouter',
  `vpn_provider` char(64) DEFAULT 'VirtualRouter',
  `userdata_provider` char(64) DEFAULT 'VirtualRouter',
  `allocation_state` varchar(32) NOT NULL DEFAULT 'Enabled' COMMENT 'Is this data center enabled for allocation for new resources',
  `zone_token` varchar(255) DEFAULT NULL,
  `is_security_group_enabled` tinyint(4) NOT NULL DEFAULT '0' COMMENT '1: enabled, 0: not',
  `is_local_storage_enabled` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Is local storage offering enabled for this data center; 1: enabled, 0: not',
  `removed` datetime DEFAULT NULL COMMENT 'date removed if not null',
  `owner` varchar(255) DEFAULT NULL,
  `created` datetime DEFAULT NULL COMMENT 'date created',
  `lastUpdated` datetime DEFAULT NULL COMMENT 'last updated',
  `engine_state` varchar(32) NOT NULL DEFAULT 'Disabled' COMMENT 'the engine state of the zone',
  `ip6_dns1` varchar(255) DEFAULT NULL,
  `ip6_dns2` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `uc_data_center__uuid` (`uuid`),
  KEY `i_data_center__domain_id` (`domain_id`),
  KEY `i_data_center__allocation_state` (`allocation_state`),
  KEY `i_data_center__zone_token` (`zone_token`),
  KEY `i_data_center__removed` (`removed`),
  CONSTRAINT `fk_data_center__domain_id` FOREIGN KEY (`domain_id`) REFERENCES `domain` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_center`
--

LOCK TABLES `data_center` WRITE;
/*!40000 ALTER TABLE `data_center` DISABLE KEYS */;
INSERT INTO `data_center` VALUES (1,'Sandbox-simulator','695e478b-cb1e-448e-9b59-3643e1245f91',NULL,'10.147.28.6',NULL,'10.147.28.6',NULL,NULL,NULL,'02:00:00:00:00:01',399,'10.1.1.0/24',NULL,NULL,'Advanced','VirtualRouter','VirtualRouter','VirtualRouter','VirtualRouter','VirtualRouter','VirtualRouter','VirtualRouter','Enabled','19da55b3-245d-3eff-8bec-f0851f052f11',0,0,NULL,NULL,NULL,NULL,'Disabled',NULL,NULL);
/*!40000 ALTER TABLE `data_center` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_center_details`
--

DROP TABLE IF EXISTS `data_center_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_center_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `dc_id` bigint(20) unsigned NOT NULL COMMENT 'dc id',
  `name` varchar(255) NOT NULL,
  `value` varchar(1024) DEFAULT NULL,
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'True if the detail can be displayed to the end user',
  PRIMARY KEY (`id`),
  KEY `fk_dc_details__dc_id` (`dc_id`),
  CONSTRAINT `fk_dc_details__dc_id` FOREIGN KEY (`dc_id`) REFERENCES `data_center` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_center_details`
--

LOCK TABLES `data_center_details` WRITE;
/*!40000 ALTER TABLE `data_center_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_center_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `data_center_view`
--

DROP TABLE IF EXISTS `data_center_view`;
/*!50001 DROP VIEW IF EXISTS `data_center_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `data_center_view` (
  `id` tinyint NOT NULL,
  `uuid` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `is_security_group_enabled` tinyint NOT NULL,
  `is_local_storage_enabled` tinyint NOT NULL,
  `description` tinyint NOT NULL,
  `dns1` tinyint NOT NULL,
  `dns2` tinyint NOT NULL,
  `ip6_dns1` tinyint NOT NULL,
  `ip6_dns2` tinyint NOT NULL,
  `internal_dns1` tinyint NOT NULL,
  `internal_dns2` tinyint NOT NULL,
  `guest_network_cidr` tinyint NOT NULL,
  `domain` tinyint NOT NULL,
  `networktype` tinyint NOT NULL,
  `allocation_state` tinyint NOT NULL,
  `zone_token` tinyint NOT NULL,
  `dhcp_provider` tinyint NOT NULL,
  `removed` tinyint NOT NULL,
  `domain_id` tinyint NOT NULL,
  `domain_uuid` tinyint NOT NULL,
  `domain_name` tinyint NOT NULL,
  `domain_path` tinyint NOT NULL,
  `affinity_group_id` tinyint NOT NULL,
  `account_id` tinyint NOT NULL,
  `affinity_group_uuid` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `dc_storage_network_ip_range`
--

DROP TABLE IF EXISTS `dc_storage_network_ip_range`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dc_storage_network_ip_range` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(40) DEFAULT NULL,
  `start_ip` char(40) NOT NULL COMMENT 'start ip address',
  `end_ip` char(40) NOT NULL COMMENT 'end ip address',
  `gateway` varchar(15) NOT NULL COMMENT 'gateway ip address',
  `vlan` int(10) unsigned DEFAULT NULL COMMENT 'vlan the storage network on',
  `netmask` varchar(15) NOT NULL COMMENT 'netmask for storage network',
  `data_center_id` bigint(20) unsigned NOT NULL,
  `pod_id` bigint(20) unsigned NOT NULL COMMENT 'pod it belongs to',
  `network_id` bigint(20) unsigned NOT NULL COMMENT 'id of corresponding network offering',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `uc_storage_ip_range__uuid` (`uuid`),
  KEY `fk_storage_ip_range__network_id` (`network_id`),
  KEY `fk_storage_ip_range__data_center_id` (`data_center_id`),
  KEY `fk_storage_ip_range__pod_id` (`pod_id`),
  CONSTRAINT `fk_storage_ip_range__network_id` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`),
  CONSTRAINT `fk_storage_ip_range__data_center_id` FOREIGN KEY (`data_center_id`) REFERENCES `data_center` (`id`),
  CONSTRAINT `fk_storage_ip_range__pod_id` FOREIGN KEY (`pod_id`) REFERENCES `host_pod_ref` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dc_storage_network_ip_range`
--

LOCK TABLES `dc_storage_network_ip_range` WRITE;
/*!40000 ALTER TABLE `dc_storage_network_ip_range` DISABLE KEYS */;
/*!40000 ALTER TABLE `dc_storage_network_ip_range` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dedicated_resources`
--

DROP TABLE IF EXISTS `dedicated_resources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dedicated_resources` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uuid` varchar(40) DEFAULT NULL,
  `data_center_id` bigint(20) unsigned DEFAULT NULL COMMENT 'data center id',
  `pod_id` bigint(20) unsigned DEFAULT NULL COMMENT 'pod id',
  `cluster_id` bigint(20) unsigned DEFAULT NULL COMMENT 'cluster id',
  `host_id` bigint(20) unsigned DEFAULT NULL COMMENT 'host id',
  `domain_id` bigint(20) unsigned DEFAULT NULL COMMENT 'domain id of the domain to which resource is dedicated',
  `account_id` bigint(20) unsigned DEFAULT NULL COMMENT 'account id of the account to which resource is dedicated',
  `affinity_group_id` bigint(20) unsigned NOT NULL COMMENT 'affinity group id associated',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `uc_dedicated_resources__uuid` (`uuid`),
  KEY `fk_dedicated_resources__data_center_id` (`data_center_id`),
  KEY `fk_dedicated_resources__pod_id` (`pod_id`),
  KEY `fk_dedicated_resources__cluster_id` (`cluster_id`),
  KEY `fk_dedicated_resources__host_id` (`host_id`),
  KEY `i_dedicated_resources_domain_id` (`domain_id`),
  KEY `i_dedicated_resources_account_id` (`account_id`),
  KEY `i_dedicated_resources_affinity_group_id` (`affinity_group_id`),
  CONSTRAINT `fk_dedicated_resources__data_center_id` FOREIGN KEY (`data_center_id`) REFERENCES `data_center` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_dedicated_resources__pod_id` FOREIGN KEY (`pod_id`) REFERENCES `host_pod_ref` (`id`),
  CONSTRAINT `fk_dedicated_resources__cluster_id` FOREIGN KEY (`cluster_id`) REFERENCES `cluster` (`id`),
  CONSTRAINT `fk_dedicated_resources__host_id` FOREIGN KEY (`host_id`) REFERENCES `host` (`id`),
  CONSTRAINT `fk_dedicated_resources__domain_id` FOREIGN KEY (`domain_id`) REFERENCES `domain` (`id`),
  CONSTRAINT `fk_dedicated_resources__account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `fk_dedicated_resources__affinity_group_id` FOREIGN KEY (`affinity_group_id`) REFERENCES `affinity_group` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dedicated_resources`
--

LOCK TABLES `dedicated_resources` WRITE;
/*!40000 ALTER TABLE `dedicated_resources` DISABLE KEYS */;
/*!40000 ALTER TABLE `dedicated_resources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `disk_offering`
--

DROP TABLE IF EXISTS `disk_offering`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `disk_offering` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `domain_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `uuid` varchar(40) DEFAULT NULL,
  `display_text` varchar(4096) DEFAULT NULL COMMENT 'Descrianaption text set by the admin for display purpose only',
  `disk_size` bigint(20) unsigned NOT NULL COMMENT 'disk space in byte',
  `type` varchar(32) DEFAULT NULL COMMENT 'inheritted by who?',
  `tags` varchar(4096) DEFAULT NULL COMMENT 'comma separated tags about the disk_offering',
  `recreatable` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'The root disk is always recreatable',
  `use_local_storage` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Indicates whether local storage pools should be used',
  `unique_name` varchar(32) DEFAULT NULL COMMENT 'unique name',
  `system_use` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'is this offering for system used only',
  `customized` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0 implies not customized by default',
  `removed` datetime DEFAULT NULL COMMENT 'date removed',
  `created` datetime DEFAULT NULL COMMENT 'date the disk offering was created',
  `sort_key` int(32) NOT NULL DEFAULT '0' COMMENT 'sort key used for customising sort method',
  `display_offering` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Should disk offering be displayed to the end user',
  `customized_iops` tinyint(1) unsigned DEFAULT NULL COMMENT 'Should customized IOPS be displayed to the end user',
  `min_iops` bigint(20) unsigned DEFAULT NULL COMMENT 'Minimum IOPS',
  `max_iops` bigint(20) unsigned DEFAULT NULL COMMENT 'Maximum IOPS',
  `bytes_read_rate` bigint(20) DEFAULT NULL,
  `bytes_write_rate` bigint(20) DEFAULT NULL,
  `iops_read_rate` bigint(20) DEFAULT NULL,
  `iops_write_rate` bigint(20) DEFAULT NULL,
  `state` char(40) NOT NULL DEFAULT 'Active' COMMENT 'state for disk offering',
  `hv_ss_reserve` int(32) unsigned DEFAULT NULL COMMENT 'Hypervisor snapshot reserve space as a percent of a volume (for managed storage using Xen or VMware)',
  `cache_mode` varchar(16) DEFAULT 'none' COMMENT 'The disk cache mode to use for disks created with this offering',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_name` (`unique_name`),
  UNIQUE KEY `uc_disk_offering__uuid` (`uuid`),
  KEY `i_disk_offering__removed` (`removed`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `disk_offering`
--

LOCK TABLES `disk_offering` WRITE;
/*!40000 ALTER TABLE `disk_offering` DISABLE KEYS */;
INSERT INTO `disk_offering` VALUES (1,NULL,'Small Instance','a5c8e3dd-eabb-4592-b053-3772d8a84c5d','Small Instance',0,'Service',NULL,0,0,'Cloud.Com-Small Instance',0,1,NULL,'2014-06-26 02:23:27',0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active',NULL,NULL),(2,NULL,'Medium Instance','11de2aa1-e771-48d2-ac94-ab39916765d0','Medium Instance',0,'Service',NULL,0,0,'Cloud.Com-Medium Instance',0,1,NULL,'2014-06-26 02:23:27',0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active',NULL,NULL),(3,NULL,'Small','184119d4-1e12-441a-b28b-768fa025e6e5','Small Disk, 5 GB',5368709120,'Disk',NULL,0,0,'Cloud.Com-Small',0,0,NULL,'2014-06-26 02:23:27',0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active',NULL,NULL),(4,NULL,'Medium','c18b599a-72aa-4fdf-b231-ce026cb0fce0','Medium Disk, 20 GB',21474836480,'Disk',NULL,0,0,'Cloud.Com-Medium',0,0,NULL,'2014-06-26 02:23:27',0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active',NULL,NULL),(5,NULL,'Large','89cc7e31-0c26-4079-8dc4-7578d25b7894','Large Disk, 100 GB',107374182400,'Disk',NULL,0,0,'Cloud.Com-Large',0,0,NULL,'2014-06-26 02:23:27',0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active',NULL,NULL),(6,NULL,'Custom','2c4019a8-2456-41a8-95ea-77b03e5877ab','Custom Disk',0,'Disk',NULL,0,0,'Cloud.Com-Custom',0,1,NULL,'2014-06-26 02:23:27',0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active',NULL,NULL),(7,NULL,'System Offering For Internal LB VM','db16960f-de0f-4348-a7b5-f6a8831137da',NULL,0,'Service',NULL,1,0,'Cloud.Com-InternalLBVm',1,1,NULL,'2014-06-26 02:23:27',0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active',NULL,NULL),(8,NULL,'System Offering For Software Router','078ca83a-d6d8-4019-a3c3-64394ff34826',NULL,0,'Service',NULL,1,0,'Cloud.Com-SoftwareRouter',1,1,NULL,'2014-06-26 02:23:27',0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active',NULL,NULL),(9,NULL,'System Offering For Console Proxy','93af6665-91fd-417c-b015-e567cd71e042',NULL,0,'Service',NULL,1,0,'Cloud.com-ConsoleProxy',1,1,NULL,'2014-06-26 02:23:28',0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active',NULL,NULL),(10,NULL,'System Offering For Secondary Storage VM','bc6f092f-e6b1-409d-8391-87c5fe3c1ba6',NULL,0,'Service',NULL,1,0,'Cloud.com-SecondaryStorage',1,1,NULL,'2014-06-26 02:23:28',0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active',NULL,NULL),(11,NULL,'System Offering For Elastic LB VM','78a8d144-f776-4921-8c29-256392e1b551',NULL,0,'Service',NULL,1,0,'Cloud.Com-ElasticLBVm',1,1,NULL,'2014-06-26 02:23:32',0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active',NULL,NULL);
/*!40000 ALTER TABLE `disk_offering` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `disk_offering_details`
--

DROP TABLE IF EXISTS `disk_offering_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `disk_offering_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `offering_id` bigint(20) unsigned NOT NULL COMMENT 'offering id',
  `name` varchar(255) NOT NULL,
  `value` varchar(1024) NOT NULL,
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'True if the detail can be displayed to the end user',
  PRIMARY KEY (`id`),
  KEY `fk_offering_details__offering_id` (`offering_id`),
  CONSTRAINT `fk_offering_details__offering_id` FOREIGN KEY (`offering_id`) REFERENCES `disk_offering` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `disk_offering_details`
--

LOCK TABLES `disk_offering_details` WRITE;
/*!40000 ALTER TABLE `disk_offering_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `disk_offering_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `disk_offering_view`
--

DROP TABLE IF EXISTS `disk_offering_view`;
/*!50001 DROP VIEW IF EXISTS `disk_offering_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `disk_offering_view` (
  `id` tinyint NOT NULL,
  `uuid` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `display_text` tinyint NOT NULL,
  `disk_size` tinyint NOT NULL,
  `min_iops` tinyint NOT NULL,
  `max_iops` tinyint NOT NULL,
  `created` tinyint NOT NULL,
  `tags` tinyint NOT NULL,
  `customized` tinyint NOT NULL,
  `customized_iops` tinyint NOT NULL,
  `removed` tinyint NOT NULL,
  `use_local_storage` tinyint NOT NULL,
  `system_use` tinyint NOT NULL,
  `hv_ss_reserve` tinyint NOT NULL,
  `bytes_read_rate` tinyint NOT NULL,
  `bytes_write_rate` tinyint NOT NULL,
  `iops_read_rate` tinyint NOT NULL,
  `iops_write_rate` tinyint NOT NULL,
  `cache_mode` tinyint NOT NULL,
  `sort_key` tinyint NOT NULL,
  `type` tinyint NOT NULL,
  `display_offering` tinyint NOT NULL,
  `domain_id` tinyint NOT NULL,
  `domain_uuid` tinyint NOT NULL,
  `domain_name` tinyint NOT NULL,
  `domain_path` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `domain`
--

DROP TABLE IF EXISTS `domain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domain` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `parent` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `uuid` varchar(40) DEFAULT NULL,
  `owner` bigint(20) unsigned NOT NULL,
  `path` varchar(255) NOT NULL,
  `level` int(10) NOT NULL DEFAULT '0',
  `child_count` int(10) NOT NULL DEFAULT '0',
  `next_child_seq` bigint(20) unsigned NOT NULL DEFAULT '1',
  `removed` datetime DEFAULT NULL COMMENT 'date removed',
  `state` char(32) NOT NULL DEFAULT 'Active' COMMENT 'state of the domain',
  `network_domain` varchar(255) DEFAULT NULL,
  `type` varchar(255) NOT NULL DEFAULT 'Normal' COMMENT 'type of the domain - can be Normal or Project',
  PRIMARY KEY (`id`),
  UNIQUE KEY `parent` (`parent`,`name`,`removed`),
  UNIQUE KEY `uc_domain__uuid` (`uuid`),
  KEY `i_domain__path` (`path`),
  KEY `i_domain__removed` (`removed`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domain`
--

LOCK TABLES `domain` WRITE;
/*!40000 ALTER TABLE `domain` DISABLE KEYS */;
INSERT INTO `domain` VALUES (1,NULL,'ROOT','ae61b1c4-fcd8-11e3-9019-080027ce083d',2,'/',0,0,1,NULL,'Active',NULL,'Normal');
/*!40000 ALTER TABLE `domain` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `domain_network_ref`
--

DROP TABLE IF EXISTS `domain_network_ref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domain_network_ref` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `domain_id` bigint(20) unsigned NOT NULL COMMENT 'domain id',
  `network_id` bigint(20) unsigned NOT NULL COMMENT 'network id',
  `subdomain_access` int(1) unsigned DEFAULT NULL COMMENT '1 if network can be accessible from the subdomain',
  PRIMARY KEY (`id`),
  KEY `fk_domain_network_ref__domain_id` (`domain_id`),
  KEY `fk_domain_network_ref__networks_id` (`network_id`),
  CONSTRAINT `fk_domain_network_ref__domain_id` FOREIGN KEY (`domain_id`) REFERENCES `domain` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_domain_network_ref__networks_id` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domain_network_ref`
--

LOCK TABLES `domain_network_ref` WRITE;
/*!40000 ALTER TABLE `domain_network_ref` DISABLE KEYS */;
/*!40000 ALTER TABLE `domain_network_ref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `domain_router`
--

DROP TABLE IF EXISTS `domain_router`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domain_router` (
  `id` bigint(20) unsigned NOT NULL COMMENT 'Primary Key',
  `element_id` bigint(20) unsigned NOT NULL COMMENT 'correlated virtual router provider ID',
  `public_mac_address` varchar(17) DEFAULT NULL COMMENT 'mac address of the public facing network card',
  `public_ip_address` char(40) DEFAULT NULL COMMENT 'public ip address used for source net',
  `public_netmask` varchar(15) DEFAULT NULL COMMENT 'netmask used for the domR',
  `guest_netmask` varchar(15) DEFAULT NULL COMMENT 'netmask used for the guest network',
  `guest_ip_address` char(40) DEFAULT NULL COMMENT ' ip address in the guest network',
  `is_redundant_router` int(1) unsigned NOT NULL COMMENT 'if in redundant router mode',
  `priority` int(4) unsigned DEFAULT NULL COMMENT 'priority of router in the redundant router mode',
  `is_priority_bumpup` int(1) unsigned NOT NULL COMMENT 'if the priority has been bumped up',
  `redundant_state` varchar(64) NOT NULL COMMENT 'the state of redundant virtual router',
  `stop_pending` int(1) unsigned NOT NULL COMMENT 'if this router would be stopped after we can connect to it',
  `role` varchar(64) NOT NULL COMMENT 'type of role played by this router',
  `template_version` varchar(100) DEFAULT NULL COMMENT 'template version',
  `scripts_version` varchar(100) DEFAULT NULL COMMENT 'scripts version',
  `vpc_id` bigint(20) unsigned DEFAULT NULL COMMENT 'correlated virtual router vpc ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `fk_domain_router__element_id` (`element_id`),
  KEY `fk_domain_router__vpc_id` (`vpc_id`),
  CONSTRAINT `fk_domain_router__id` FOREIGN KEY (`id`) REFERENCES `vm_instance` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_domain_router__element_id` FOREIGN KEY (`element_id`) REFERENCES `virtual_router_providers` (`id`),
  CONSTRAINT `fk_domain_router__vpc_id` FOREIGN KEY (`vpc_id`) REFERENCES `vpc` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='information about the domR instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domain_router`
--

LOCK TABLES `domain_router` WRITE;
/*!40000 ALTER TABLE `domain_router` DISABLE KEYS */;
/*!40000 ALTER TABLE `domain_router` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `domain_router_view`
--

DROP TABLE IF EXISTS `domain_router_view`;
/*!50001 DROP VIEW IF EXISTS `domain_router_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `domain_router_view` (
  `id` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `account_id` tinyint NOT NULL,
  `account_uuid` tinyint NOT NULL,
  `account_name` tinyint NOT NULL,
  `account_type` tinyint NOT NULL,
  `domain_id` tinyint NOT NULL,
  `domain_uuid` tinyint NOT NULL,
  `domain_name` tinyint NOT NULL,
  `domain_path` tinyint NOT NULL,
  `project_id` tinyint NOT NULL,
  `project_uuid` tinyint NOT NULL,
  `project_name` tinyint NOT NULL,
  `uuid` tinyint NOT NULL,
  `created` tinyint NOT NULL,
  `state` tinyint NOT NULL,
  `removed` tinyint NOT NULL,
  `pod_id` tinyint NOT NULL,
  `instance_name` tinyint NOT NULL,
  `pod_uuid` tinyint NOT NULL,
  `data_center_id` tinyint NOT NULL,
  `data_center_uuid` tinyint NOT NULL,
  `data_center_name` tinyint NOT NULL,
  `data_center_type` tinyint NOT NULL,
  `dns1` tinyint NOT NULL,
  `dns2` tinyint NOT NULL,
  `ip6_dns1` tinyint NOT NULL,
  `ip6_dns2` tinyint NOT NULL,
  `host_id` tinyint NOT NULL,
  `host_uuid` tinyint NOT NULL,
  `host_name` tinyint NOT NULL,
  `cluster_id` tinyint NOT NULL,
  `template_id` tinyint NOT NULL,
  `template_uuid` tinyint NOT NULL,
  `service_offering_id` tinyint NOT NULL,
  `service_offering_uuid` tinyint NOT NULL,
  `service_offering_name` tinyint NOT NULL,
  `nic_id` tinyint NOT NULL,
  `nic_uuid` tinyint NOT NULL,
  `network_id` tinyint NOT NULL,
  `ip_address` tinyint NOT NULL,
  `ip6_address` tinyint NOT NULL,
  `ip6_gateway` tinyint NOT NULL,
  `ip6_cidr` tinyint NOT NULL,
  `is_default_nic` tinyint NOT NULL,
  `gateway` tinyint NOT NULL,
  `netmask` tinyint NOT NULL,
  `mac_address` tinyint NOT NULL,
  `broadcast_uri` tinyint NOT NULL,
  `isolation_uri` tinyint NOT NULL,
  `vpc_id` tinyint NOT NULL,
  `vpc_uuid` tinyint NOT NULL,
  `network_uuid` tinyint NOT NULL,
  `network_name` tinyint NOT NULL,
  `network_domain` tinyint NOT NULL,
  `traffic_type` tinyint NOT NULL,
  `guest_type` tinyint NOT NULL,
  `job_id` tinyint NOT NULL,
  `job_uuid` tinyint NOT NULL,
  `job_status` tinyint NOT NULL,
  `job_account_id` tinyint NOT NULL,
  `template_version` tinyint NOT NULL,
  `scripts_version` tinyint NOT NULL,
  `is_redundant_router` tinyint NOT NULL,
  `redundant_state` tinyint NOT NULL,
  `stop_pending` tinyint NOT NULL,
  `role` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `elastic_lb_vm_map`
--

DROP TABLE IF EXISTS `elastic_lb_vm_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elastic_lb_vm_map` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ip_addr_id` bigint(20) unsigned NOT NULL,
  `elb_vm_id` bigint(20) unsigned NOT NULL,
  `lb_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_elastic_lb_vm_map__ip_id` (`ip_addr_id`),
  KEY `fk_elastic_lb_vm_map__elb_vm_id` (`elb_vm_id`),
  KEY `fk_elastic_lb_vm_map__lb_id` (`lb_id`),
  CONSTRAINT `fk_elastic_lb_vm_map__ip_id` FOREIGN KEY (`ip_addr_id`) REFERENCES `user_ip_address` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_elastic_lb_vm_map__elb_vm_id` FOREIGN KEY (`elb_vm_id`) REFERENCES `vm_instance` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_elastic_lb_vm_map__lb_id` FOREIGN KEY (`lb_id`) REFERENCES `load_balancing_rules` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elastic_lb_vm_map`
--

LOCK TABLES `elastic_lb_vm_map` WRITE;
/*!40000 ALTER TABLE `elastic_lb_vm_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `elastic_lb_vm_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(40) DEFAULT NULL,
  `type` varchar(32) NOT NULL,
  `state` varchar(32) NOT NULL DEFAULT 'Completed',
  `description` varchar(1024) NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `account_id` bigint(20) unsigned NOT NULL,
  `domain_id` bigint(20) unsigned NOT NULL,
  `created` datetime NOT NULL,
  `level` varchar(16) NOT NULL,
  `start_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `parameters` varchar(1024) DEFAULT NULL,
  `archived` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'True if the detail can be displayed to the end user',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_event__uuid` (`uuid`),
  KEY `i_event__created` (`created`),
  KEY `i_event__user_id` (`user_id`),
  KEY `i_event__account_id` (`account_id`),
  KEY `i_event__level_id` (`level`),
  KEY `i_event__type_id` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
INSERT INTO `event` VALUES (1,'06335886-5d6b-46aa-bbdb-4494cba33ca5','REGISTER.USER.KEY','Completed','Successfully completed register for the developer API keys',1,1,1,'2014-06-26 02:24:47','INFO',0,NULL,0,1),(2,'6f00b4f7-8414-4209-9fcf-15112a111f65','CONFIGURATION.VALUE.EDIT','Completed','Successfully completed updating configuration.  Name: network.gc.wait New Value: 60',2,2,1,'2014-06-26 02:24:47','INFO',0,NULL,0,1),(3,'1eb2d8e5-708d-49a7-a2da-c1204bddce2d','CONFIGURATION.VALUE.EDIT','Completed','Successfully completed updating configuration.  Name: storage.cleanup.interval New Value: 300',2,2,1,'2014-06-26 02:24:47','INFO',0,NULL,0,1),(4,'ee954e15-d37c-45b6-8945-b4e148fb5fe4','CONFIGURATION.VALUE.EDIT','Completed','Successfully completed updating configuration.  Name: vm.op.wait.interval New Value: 5',2,2,1,'2014-06-26 02:24:47','INFO',0,NULL,0,1),(5,'778742f2-e521-4d04-9be4-b676e4a4da9f','CONFIGURATION.VALUE.EDIT','Completed','Successfully completed updating configuration.  Name: default.page.size New Value: 10000',2,2,1,'2014-06-26 02:24:47','INFO',0,NULL,0,1),(6,'f6af7638-b3f1-4b11-b840-6fc480bb927d','CONFIGURATION.VALUE.EDIT','Completed','Successfully completed updating configuration.  Name: network.gc.interval New Value: 60',2,2,1,'2014-06-26 02:24:47','INFO',0,NULL,0,1),(7,'f0b52cc8-b2e0-4b97-be8a-f506f4a44587','CONFIGURATION.VALUE.EDIT','Completed','Successfully completed updating configuration.  Name: instance.name New Value: QA',2,2,1,'2014-06-26 02:24:47','INFO',0,NULL,0,1),(8,'e9796d51-17f5-4634-aae6-8040cf45a1ab','CONFIGURATION.VALUE.EDIT','Completed','Successfully completed updating configuration.  Name: workers New Value: 10',2,2,1,'2014-06-26 02:24:47','INFO',0,NULL,0,1),(9,'2563a4ad-6a5a-40cf-9b5f-f3fd7e11f66f','CONFIGURATION.VALUE.EDIT','Completed','Successfully completed updating configuration.  Name: account.cleanup.interval New Value: 600',2,2,1,'2014-06-26 02:24:47','INFO',0,NULL,0,1),(10,'d7c6fc58-7031-408e-987f-0ac702a66c9e','CONFIGURATION.VALUE.EDIT','Completed','Successfully completed updating configuration.  Name: guest.domain.suffix New Value: sandbox.simulator',2,2,1,'2014-06-26 02:24:47','INFO',0,NULL,0,1),(11,'2e107f71-874a-46d7-b684-db0d763e2716','CONFIGURATION.VALUE.EDIT','Completed','Successfully completed updating configuration.  Name: expunge.delay New Value: 60',2,2,1,'2014-06-26 02:24:47','INFO',0,NULL,0,1),(12,'a24721b0-8a34-4280-8f2c-3c13bc6db625','CONFIGURATION.VALUE.EDIT','Completed','Successfully completed updating configuration.  Name: vm.allocation.algorithm New Value: random',2,2,1,'2014-06-26 02:24:47','INFO',0,NULL,0,1),(13,'5d58b8ea-92b9-4ce4-8542-cb82d5bf3ec3','CONFIGURATION.VALUE.EDIT','Completed','Successfully completed updating configuration.  Name: expunge.interval New Value: 60',2,2,1,'2014-06-26 02:24:47','INFO',0,NULL,0,1),(14,'96229840-3e8d-4584-8ef9-163de5e5aa3e','CONFIGURATION.VALUE.EDIT','Completed','Successfully completed updating configuration.  Name: expunge.workers New Value: 3',2,2,1,'2014-06-26 02:24:47','INFO',0,NULL,0,1),(15,'2765a1f5-3b2b-4166-8f4b-4a11690b49af','CONFIGURATION.VALUE.EDIT','Completed','Successfully completed updating configuration.  Name: check.pod.cidrs New Value: true',2,2,1,'2014-06-26 02:24:47','INFO',0,NULL,0,1),(16,'5433d509-2814-4725-8d21-0b94a29c89f2','CONFIGURATION.VALUE.EDIT','Completed','Successfully completed updating configuration.  Name: secstorage.allowed.internal.sites New Value: 10.147.28.0/24',2,2,1,'2014-06-26 02:24:47','INFO',0,NULL,0,1),(17,'b8db2825-ff1a-408c-8ecc-052cf60cbcf4','CONFIGURATION.VALUE.EDIT','Completed','Successfully completed updating configuration.  Name: direct.agent.load.size New Value: 1000',2,2,1,'2014-06-26 02:24:47','INFO',0,NULL,0,1),(18,'b9d855b3-2aed-4ede-8734-08a60b00cd67','ZONE.CREATE','Completed','Successfully completed creating zone. Zone Name: Sandbox-simulator',2,2,1,'2014-06-26 02:24:47','INFO',0,NULL,0,1),(19,'675b69a4-0a0b-45a5-8bec-141058c007b3','PHYSICAL.NETWORK.CREATE','Created','Successfully created entity for Creating Physical Network',2,2,1,'2014-06-26 02:24:47','INFO',0,NULL,0,1),(20,'2c8ce3a6-adfb-4b15-ac89-d75354e48e75','PHYSICAL.NETWORK.CREATE','Scheduled','creating Physical Network. Id: 200',2,1,1,'2014-06-26 02:24:47','INFO',19,NULL,0,1),(21,'28d127ef-4bbe-469d-b7d9-218ec4e97e75','PHYSICAL.NETWORK.CREATE','Started','Creating Physical Network. Physical Network Id: 200',2,2,1,'2014-06-26 02:24:48','INFO',19,NULL,0,1),(22,'d23b560c-6235-4b6f-be95-b099f9c6381d','PHYSICAL.NETWORK.CREATE','Completed','Successfully completed Creating Physical Network. Physical Network Id: 200',2,2,1,'2014-06-26 02:24:48','INFO',19,NULL,0,1),(23,'2887753c-a4a5-4b65-b55d-d8b37fe42a18','TRAFFIC.TYPE.CREATE','Created','Successfully created entity for Creating Physical Network TrafficType',2,2,1,'2014-06-26 02:24:48','INFO',0,NULL,0,1),(24,'44d5d2c6-884a-4ca2-a761-aef66d6eb1cb','TRAFFIC.TYPE.CREATE','Scheduled','Adding physical network traffic type: 1',2,1,1,'2014-06-26 02:24:48','INFO',23,NULL,0,1),(25,'4dbc4b59-c9bb-4322-8b5f-9ee06814166f','TRAFFIC.TYPE.CREATE','Started','Creating Physical Network TrafficType. TrafficType Id: 1',2,2,1,'2014-06-26 02:24:48','INFO',23,NULL,0,1),(26,'c6aa9454-7594-4009-bbdc-2184187224d2','TRAFFIC.TYPE.CREATE','Completed','Successfully completed Creating Physical Network TrafficType. TrafficType Id: 1',2,2,1,'2014-06-26 02:24:48','INFO',23,NULL,0,1),(27,'0384f248-177b-4c52-8419-cd5d11ed3e57','TRAFFIC.TYPE.CREATE','Created','Successfully created entity for Creating Physical Network TrafficType',2,2,1,'2014-06-26 02:24:53','INFO',0,NULL,0,1),(28,'0b447cc6-02bc-4c58-9470-1b5db0fa632c','TRAFFIC.TYPE.CREATE','Scheduled','Adding physical network traffic type: 2',2,1,1,'2014-06-26 02:24:53','INFO',27,NULL,0,1),(29,'d3b55e0c-4fba-49bc-aa49-4362ae04b187','TRAFFIC.TYPE.CREATE','Started','Creating Physical Network TrafficType. TrafficType Id: 2',2,2,1,'2014-06-26 02:24:53','INFO',27,NULL,0,1),(30,'a491333f-3088-4d42-98a0-fd0b2e1c5d1e','TRAFFIC.TYPE.CREATE','Completed','Successfully completed Creating Physical Network TrafficType. TrafficType Id: 2',2,2,1,'2014-06-26 02:24:53','INFO',27,NULL,0,1),(31,'443c1588-a0cd-4cfc-b5d3-41918214a6b6','TRAFFIC.TYPE.CREATE','Created','Successfully created entity for Creating Physical Network TrafficType',2,2,1,'2014-06-26 02:24:58','INFO',0,NULL,0,1),(32,'56e78fb2-d0cd-48df-a5d4-1c9fb3963afe','TRAFFIC.TYPE.CREATE','Scheduled','Adding physical network traffic type: 3',2,1,1,'2014-06-26 02:24:58','INFO',31,NULL,0,1),(33,'1084ec16-eb91-45be-8756-ba678fbf49a5','TRAFFIC.TYPE.CREATE','Started','Creating Physical Network TrafficType. TrafficType Id: 3',2,2,1,'2014-06-26 02:24:58','INFO',31,NULL,0,1),(34,'4e465ff3-33ea-499d-9f39-b6f42885370f','TRAFFIC.TYPE.CREATE','Completed','Successfully completed Creating Physical Network TrafficType. TrafficType Id: 3',2,2,1,'2014-06-26 02:24:58','INFO',31,NULL,0,1),(35,'33c8e5c3-ac7d-4467-a306-6424d9c1e304','NETWORK.ELEMENT.CONFIGURE','Scheduled','configuring virtual router provider: 1',2,1,1,'2014-06-26 02:25:03','INFO',0,NULL,0,1),(36,'cd5aa832-092c-4e09-90d4-4f11ce451df8','SERVICE.PROVIDER.UPDATE','Scheduled','Updating physical network ServiceProvider: 1',2,1,1,'2014-06-26 02:25:03','INFO',0,NULL,0,1),(37,'337d0782-517a-4e96-804d-451b0aaeae7c','SERVICE.PROVIDER.UPDATE','Started','Updating physical network ServiceProvider',2,2,1,'2014-06-26 02:25:03','INFO',36,NULL,0,1),(38,'d232885e-0ece-44c4-bdd1-e94face37bff','SERVICE.PROVIDER.UPDATE','Completed','Successfully completed Updating physical network ServiceProvider',2,2,1,'2014-06-26 02:25:03','INFO',36,NULL,0,1),(39,'dd5c18e7-1bb7-40b9-b377-e8bdc7293b9b','NETWORK.ELEMENT.CONFIGURE','Scheduled','configuring virtual router provider: 2',2,1,1,'2014-06-26 02:25:08','INFO',0,NULL,0,1),(40,'74cb9532-33dc-4601-bf71-73fc93e4eaef','SERVICE.PROVIDER.UPDATE','Scheduled','Updating physical network ServiceProvider: 3',2,1,1,'2014-06-26 02:25:08','INFO',0,NULL,0,1),(41,'4aa18e48-c96d-45f8-96f2-dada804cce7e','SERVICE.PROVIDER.UPDATE','Started','Updating physical network ServiceProvider',2,2,1,'2014-06-26 02:25:08','INFO',40,NULL,0,1),(42,'a1fad714-8000-48a6-8e4d-08a6439cba21','SERVICE.PROVIDER.UPDATE','Completed','Successfully completed Updating physical network ServiceProvider',2,2,1,'2014-06-26 02:25:08','INFO',40,NULL,0,1),(43,'846e6a36-befb-4272-990e-e7951f4ca933','NETWORK.ELEMENT.CONFIGURE','Scheduled','configuring internal load balancer element: 3',2,1,1,'2014-06-26 02:25:13','INFO',0,NULL,0,1),(44,'1d613180-1a0f-4d39-b35a-0a30f0a4f0e8','SERVICE.PROVIDER.UPDATE','Scheduled','Updating physical network ServiceProvider: 4',2,1,1,'2014-06-26 02:25:14','INFO',0,NULL,0,1),(45,'3c18cbe4-bede-49ea-87fa-8aedcea50320','SERVICE.PROVIDER.UPDATE','Started','Updating physical network ServiceProvider',2,2,1,'2014-06-26 02:25:14','INFO',44,NULL,0,1),(46,'9232b7f3-7a64-44f6-a4d4-74b236e7f378','SERVICE.PROVIDER.UPDATE','Completed','Successfully completed Updating physical network ServiceProvider',2,2,1,'2014-06-26 02:25:14','INFO',44,NULL,0,1),(47,'c6c762be-64c2-40cb-8210-e47ee4083a8c','PHYSICAL.NETWORK.UPDATE','Scheduled','Updating Physical network: 200',2,1,1,'2014-06-26 02:25:19','INFO',0,NULL,0,1),(48,'4983fe58-83e7-48a7-9f42-55fd96859080','PHYSICAL.NETWORK.UPDATE','Started','updating physical network',2,2,1,'2014-06-26 02:25:19','INFO',47,NULL,0,1),(49,'32a8f2dd-231c-4176-b251-9eb6b918e6bc','PHYSICAL.NETWORK.UPDATE','Completed','Successfully completed updating physical network',2,2,1,'2014-06-26 02:25:19','INFO',47,NULL,0,1),(50,'cd16b816-a288-4b8e-bbe8-b52a032739b2','VLAN.IP.RANGE.CREATE','Completed','Successfully completed creating vlan ip range',2,2,1,'2014-06-26 02:27:27','INFO',0,NULL,0,1),(51,'d9bd97a1-cdd7-41f3-a265-63cc62a8963f','TRAFFIC.TYPE.CREATE','Created','Successfully created entity for Creating Physical Network TrafficType. Zone Id: 1',2,2,1,'2014-06-26 02:27:27','INFO',0,NULL,0,1),(52,'393a488c-17e4-4aa9-a8c1-281fdfacfe43','ZONE.EDIT','Completed','Successfully completed editing zone. Zone Id: 1',2,2,1,'2014-06-26 02:27:27','INFO',51,NULL,0,1),(53,'7e84dbf8-a3e6-464a-8583-aff0e11d997f','USER.LOGIN','Completed','user has logged in. The IP Address cannot be determined',2,2,1,'2014-06-26 02:27:56','INFO',0,NULL,0,1),(54,'fba08133-ab70-450e-b97b-03645e6bbbc0','FIREWALL.OPEN','Created','Successfully created entity for creating firewall rule',1,1,1,'2014-06-26 02:27:57','INFO',0,NULL,0,1),(55,'03c79d8f-5020-40c8-b4bb-eb197acd2fb3','FIREWALL.OPEN','Created','Successfully created entity for creating firewall rule',1,1,1,'2014-06-26 02:27:58','INFO',0,NULL,0,1);
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `event_view`
--

DROP TABLE IF EXISTS `event_view`;
/*!50001 DROP VIEW IF EXISTS `event_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `event_view` (
  `id` tinyint NOT NULL,
  `uuid` tinyint NOT NULL,
  `type` tinyint NOT NULL,
  `state` tinyint NOT NULL,
  `description` tinyint NOT NULL,
  `created` tinyint NOT NULL,
  `level` tinyint NOT NULL,
  `parameters` tinyint NOT NULL,
  `start_id` tinyint NOT NULL,
  `start_uuid` tinyint NOT NULL,
  `user_id` tinyint NOT NULL,
  `archived` tinyint NOT NULL,
  `display` tinyint NOT NULL,
  `user_name` tinyint NOT NULL,
  `account_id` tinyint NOT NULL,
  `account_uuid` tinyint NOT NULL,
  `account_name` tinyint NOT NULL,
  `account_type` tinyint NOT NULL,
  `domain_id` tinyint NOT NULL,
  `domain_uuid` tinyint NOT NULL,
  `domain_name` tinyint NOT NULL,
  `domain_path` tinyint NOT NULL,
  `project_id` tinyint NOT NULL,
  `project_uuid` tinyint NOT NULL,
  `project_name` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `external_bigswitch_vns_devices`
--

DROP TABLE IF EXISTS `external_bigswitch_vns_devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `external_bigswitch_vns_devices` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uuid` varchar(255) DEFAULT NULL,
  `physical_network_id` bigint(20) unsigned NOT NULL COMMENT 'id of the physical network in to which bigswitch vns device is added',
  `provider_name` varchar(255) NOT NULL COMMENT 'Service Provider name corresponding to this bigswitch vns device',
  `device_name` varchar(255) NOT NULL COMMENT 'name of the bigswitch vns device',
  `host_id` bigint(20) unsigned NOT NULL COMMENT 'host id coresponding to the external bigswitch vns device',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `fk_external_bigswitch_vns_devices__host_id` (`host_id`),
  KEY `fk_external_bigswitch_vns_devices__physical_network_id` (`physical_network_id`),
  CONSTRAINT `fk_external_bigswitch_vns_devices__host_id` FOREIGN KEY (`host_id`) REFERENCES `host` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_external_bigswitch_vns_devices__physical_network_id` FOREIGN KEY (`physical_network_id`) REFERENCES `physical_network` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `external_bigswitch_vns_devices`
--

LOCK TABLES `external_bigswitch_vns_devices` WRITE;
/*!40000 ALTER TABLE `external_bigswitch_vns_devices` DISABLE KEYS */;
/*!40000 ALTER TABLE `external_bigswitch_vns_devices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `external_cisco_asa1000v_devices`
--

DROP TABLE IF EXISTS `external_cisco_asa1000v_devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `external_cisco_asa1000v_devices` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uuid` varchar(255) DEFAULT NULL,
  `physical_network_id` bigint(20) unsigned NOT NULL COMMENT 'id of the physical network in to which cisco asa1kv device is added',
  `management_ip` varchar(255) NOT NULL COMMENT 'mgmt. ip of cisco asa1kv device',
  `in_port_profile` varchar(255) NOT NULL COMMENT 'inside port profile name of cisco asa1kv device',
  `cluster_id` bigint(20) unsigned NOT NULL COMMENT 'id of the Vmware cluster to which cisco asa1kv device is attached (cisco n1kv switch)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `management_ip` (`management_ip`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `fk_external_cisco_asa1000v_devices__physical_network_id` (`physical_network_id`),
  KEY `fk_external_cisco_asa1000v_devices__cluster_id` (`cluster_id`),
  CONSTRAINT `fk_external_cisco_asa1000v_devices__physical_network_id` FOREIGN KEY (`physical_network_id`) REFERENCES `physical_network` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_external_cisco_asa1000v_devices__cluster_id` FOREIGN KEY (`cluster_id`) REFERENCES `cluster` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `external_cisco_asa1000v_devices`
--

LOCK TABLES `external_cisco_asa1000v_devices` WRITE;
/*!40000 ALTER TABLE `external_cisco_asa1000v_devices` DISABLE KEYS */;
/*!40000 ALTER TABLE `external_cisco_asa1000v_devices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `external_cisco_vnmc_devices`
--

DROP TABLE IF EXISTS `external_cisco_vnmc_devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `external_cisco_vnmc_devices` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uuid` varchar(255) DEFAULT NULL,
  `physical_network_id` bigint(20) unsigned NOT NULL COMMENT 'id of the physical network in to which cisco vnmc device is added',
  `provider_name` varchar(255) NOT NULL COMMENT 'Service Provider name corresponding to this cisco vnmc device',
  `device_name` varchar(255) NOT NULL COMMENT 'name of the cisco vnmc device',
  `host_id` bigint(20) unsigned NOT NULL COMMENT 'host id coresponding to the external cisco vnmc device',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `fk_external_cisco_vnmc_devices__host_id` (`host_id`),
  KEY `fk_external_cisco_vnmc_devices__physical_network_id` (`physical_network_id`),
  CONSTRAINT `fk_external_cisco_vnmc_devices__host_id` FOREIGN KEY (`host_id`) REFERENCES `host` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_external_cisco_vnmc_devices__physical_network_id` FOREIGN KEY (`physical_network_id`) REFERENCES `physical_network` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `external_cisco_vnmc_devices`
--

LOCK TABLES `external_cisco_vnmc_devices` WRITE;
/*!40000 ALTER TABLE `external_cisco_vnmc_devices` DISABLE KEYS */;
/*!40000 ALTER TABLE `external_cisco_vnmc_devices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `external_firewall_devices`
--

DROP TABLE IF EXISTS `external_firewall_devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `external_firewall_devices` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uuid` varchar(255) DEFAULT NULL,
  `physical_network_id` bigint(20) unsigned NOT NULL COMMENT 'id of the physical network in to which firewall device is added',
  `provider_name` varchar(255) NOT NULL COMMENT 'Service Provider name corresponding to this firewall device',
  `device_name` varchar(255) NOT NULL COMMENT 'name of the firewall device',
  `device_state` varchar(32) NOT NULL DEFAULT 'Disabled' COMMENT 'state (enabled/disabled/shutdown) of the device',
  `is_dedicated` int(1) unsigned NOT NULL DEFAULT '0' COMMENT '1 if device/appliance meant for dedicated use only',
  `allocation_state` varchar(32) NOT NULL DEFAULT 'Free' COMMENT 'Allocation state (Free/Allocated) of the device',
  `host_id` bigint(20) unsigned NOT NULL COMMENT 'host id coresponding to the external firewall device',
  `capacity` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Capacity of the external firewall device',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `fk_external_firewall_devices__host_id` (`host_id`),
  KEY `fk_external_firewall_devices__physical_network_id` (`physical_network_id`),
  CONSTRAINT `fk_external_firewall_devices__host_id` FOREIGN KEY (`host_id`) REFERENCES `host` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_external_firewall_devices__physical_network_id` FOREIGN KEY (`physical_network_id`) REFERENCES `physical_network` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `external_firewall_devices`
--

LOCK TABLES `external_firewall_devices` WRITE;
/*!40000 ALTER TABLE `external_firewall_devices` DISABLE KEYS */;
/*!40000 ALTER TABLE `external_firewall_devices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `external_load_balancer_devices`
--

DROP TABLE IF EXISTS `external_load_balancer_devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `external_load_balancer_devices` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uuid` varchar(255) DEFAULT NULL,
  `physical_network_id` bigint(20) unsigned NOT NULL COMMENT 'id of the physical network in to which load balancer device is added',
  `provider_name` varchar(255) NOT NULL COMMENT 'Service Provider name corresponding to this load balancer device',
  `device_name` varchar(255) NOT NULL COMMENT 'name of the load balancer device',
  `capacity` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Capacity of the load balancer device',
  `device_state` varchar(32) NOT NULL DEFAULT 'Disabled' COMMENT 'state (enabled/disabled/shutdown) of the device',
  `allocation_state` varchar(32) NOT NULL DEFAULT 'Free' COMMENT 'Allocation state (Free/Shared/Dedicated/Provider) of the device',
  `is_dedicated` int(1) unsigned NOT NULL DEFAULT '0' COMMENT '1 if device/appliance is provisioned for dedicated use only',
  `is_managed` int(1) unsigned NOT NULL DEFAULT '0' COMMENT '1 if load balancer appliance is provisioned and its life cycle is managed by by cloudstack',
  `host_id` bigint(20) unsigned NOT NULL COMMENT 'host id coresponding to the external load balancer device',
  `parent_host_id` bigint(20) unsigned DEFAULT NULL COMMENT 'if the load balancer appliance is cloudstack managed, then host id on which this appliance is provisioned',
  `is_gslb_provider` int(1) unsigned NOT NULL DEFAULT '0' COMMENT '1 if load balancer appliance is acting as gslb service provider in the zone',
  `gslb_site_publicip` varchar(255) DEFAULT NULL COMMENT 'GSLB service Provider site public ip',
  `gslb_site_privateip` varchar(255) DEFAULT NULL COMMENT 'GSLB service Provider site private ip',
  `is_exclusive_gslb_provider` int(1) unsigned NOT NULL DEFAULT '0' COMMENT '1 if load balancer appliance is acting exclusively as gslb service provider in the zone and can not be used for LB',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `fk_external_lb_devices_parent_host_id` (`host_id`),
  KEY `fk_external_lb_devices_physical_network_id` (`physical_network_id`),
  CONSTRAINT `fk_external_lb_devices_host_id` FOREIGN KEY (`host_id`) REFERENCES `host` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_external_lb_devices_parent_host_id` FOREIGN KEY (`host_id`) REFERENCES `host` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_external_lb_devices_physical_network_id` FOREIGN KEY (`physical_network_id`) REFERENCES `physical_network` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `external_load_balancer_devices`
--

LOCK TABLES `external_load_balancer_devices` WRITE;
/*!40000 ALTER TABLE `external_load_balancer_devices` DISABLE KEYS */;
/*!40000 ALTER TABLE `external_load_balancer_devices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `external_nicira_nvp_devices`
--

DROP TABLE IF EXISTS `external_nicira_nvp_devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `external_nicira_nvp_devices` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uuid` varchar(255) DEFAULT NULL,
  `physical_network_id` bigint(20) unsigned NOT NULL COMMENT 'id of the physical network in to which nicira nvp device is added',
  `provider_name` varchar(255) NOT NULL COMMENT 'Service Provider name corresponding to this nicira nvp device',
  `device_name` varchar(255) NOT NULL COMMENT 'name of the nicira nvp device',
  `host_id` bigint(20) unsigned NOT NULL COMMENT 'host id coresponding to the external nicira nvp device',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `fk_external_nicira_nvp_devices__host_id` (`host_id`),
  KEY `fk_external_nicira_nvp_devices__physical_network_id` (`physical_network_id`),
  CONSTRAINT `fk_external_nicira_nvp_devices__host_id` FOREIGN KEY (`host_id`) REFERENCES `host` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_external_nicira_nvp_devices__physical_network_id` FOREIGN KEY (`physical_network_id`) REFERENCES `physical_network` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `external_nicira_nvp_devices`
--

LOCK TABLES `external_nicira_nvp_devices` WRITE;
/*!40000 ALTER TABLE `external_nicira_nvp_devices` DISABLE KEYS */;
/*!40000 ALTER TABLE `external_nicira_nvp_devices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `external_opendaylight_controllers`
--

DROP TABLE IF EXISTS `external_opendaylight_controllers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `external_opendaylight_controllers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uuid` varchar(255) DEFAULT NULL,
  `physical_network_id` bigint(20) unsigned NOT NULL COMMENT 'id of the physical network in to which the device is added',
  `provider_name` varchar(255) NOT NULL COMMENT 'Service Provider name corresponding to this device',
  `device_name` varchar(255) NOT NULL COMMENT 'name of the device',
  `host_id` bigint(20) unsigned NOT NULL COMMENT 'host id corresponding to the external device',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `fk_external_opendaylight_devices__host_id` (`host_id`),
  KEY `fk_external_opendaylight_devices__physical_network_id` (`physical_network_id`),
  CONSTRAINT `fk_external_opendaylight_devices__host_id` FOREIGN KEY (`host_id`) REFERENCES `host` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_external_opendaylight_devices__physical_network_id` FOREIGN KEY (`physical_network_id`) REFERENCES `physical_network` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `external_opendaylight_controllers`
--

LOCK TABLES `external_opendaylight_controllers` WRITE;
/*!40000 ALTER TABLE `external_opendaylight_controllers` DISABLE KEYS */;
/*!40000 ALTER TABLE `external_opendaylight_controllers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `external_stratosphere_ssp_credentials`
--

DROP TABLE IF EXISTS `external_stratosphere_ssp_credentials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `external_stratosphere_ssp_credentials` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `data_center_id` bigint(20) unsigned NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `external_stratosphere_ssp_credentials`
--

LOCK TABLES `external_stratosphere_ssp_credentials` WRITE;
/*!40000 ALTER TABLE `external_stratosphere_ssp_credentials` DISABLE KEYS */;
/*!40000 ALTER TABLE `external_stratosphere_ssp_credentials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `external_stratosphere_ssp_tenants`
--

DROP TABLE IF EXISTS `external_stratosphere_ssp_tenants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `external_stratosphere_ssp_tenants` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL COMMENT 'SSP tenant uuid',
  `zone_id` bigint(20) NOT NULL COMMENT 'cloudstack zone_id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `external_stratosphere_ssp_tenants`
--

LOCK TABLES `external_stratosphere_ssp_tenants` WRITE;
/*!40000 ALTER TABLE `external_stratosphere_ssp_tenants` DISABLE KEYS */;
/*!40000 ALTER TABLE `external_stratosphere_ssp_tenants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `external_stratosphere_ssp_uuids`
--

DROP TABLE IF EXISTS `external_stratosphere_ssp_uuids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `external_stratosphere_ssp_uuids` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL COMMENT 'uuid provided by SSP',
  `obj_class` varchar(255) NOT NULL,
  `obj_id` bigint(20) NOT NULL,
  `reservation_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `external_stratosphere_ssp_uuids`
--

LOCK TABLES `external_stratosphere_ssp_uuids` WRITE;
/*!40000 ALTER TABLE `external_stratosphere_ssp_uuids` DISABLE KEYS */;
/*!40000 ALTER TABLE `external_stratosphere_ssp_uuids` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `firewall_rule_details`
--

DROP TABLE IF EXISTS `firewall_rule_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `firewall_rule_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `firewall_rule_id` bigint(20) unsigned NOT NULL COMMENT 'Firewall rule id',
  `name` varchar(255) NOT NULL,
  `value` varchar(1024) NOT NULL,
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'True if the detail can be displayed to the end user',
  PRIMARY KEY (`id`),
  KEY `fk_firewall_rule_details__firewall_rule_id` (`firewall_rule_id`),
  CONSTRAINT `fk_firewall_rule_details__firewall_rule_id` FOREIGN KEY (`firewall_rule_id`) REFERENCES `firewall_rules` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `firewall_rule_details`
--

LOCK TABLES `firewall_rule_details` WRITE;
/*!40000 ALTER TABLE `firewall_rule_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `firewall_rule_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `firewall_rules`
--

DROP TABLE IF EXISTS `firewall_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `firewall_rules` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uuid` varchar(40) DEFAULT NULL,
  `ip_address_id` bigint(20) unsigned DEFAULT NULL COMMENT 'id of the corresponding ip address',
  `start_port` int(10) DEFAULT NULL COMMENT 'starting port of a port range',
  `end_port` int(10) DEFAULT NULL COMMENT 'end port of a port range',
  `state` char(32) NOT NULL COMMENT 'current state of this rule',
  `protocol` char(16) NOT NULL DEFAULT 'TCP' COMMENT 'protocol to open these ports for',
  `purpose` char(32) NOT NULL COMMENT 'why are these ports opened?',
  `account_id` bigint(20) unsigned NOT NULL COMMENT 'owner id',
  `domain_id` bigint(20) unsigned NOT NULL COMMENT 'domain id',
  `network_id` bigint(20) unsigned NOT NULL COMMENT 'network id',
  `xid` char(40) NOT NULL COMMENT 'external id',
  `created` datetime DEFAULT NULL COMMENT 'Date created',
  `icmp_code` int(10) DEFAULT NULL COMMENT 'The ICMP code (if protocol=ICMP). A value of -1 means all codes for the given ICMP type.',
  `icmp_type` int(10) DEFAULT NULL COMMENT 'The ICMP type (if protocol=ICMP). A value of -1 means all types.',
  `related` bigint(20) unsigned DEFAULT NULL COMMENT 'related to what other firewall rule',
  `type` varchar(10) NOT NULL DEFAULT 'USER',
  `vpc_id` bigint(20) unsigned DEFAULT NULL COMMENT 'vpc the firewall rule is associated with',
  `traffic_type` char(32) DEFAULT NULL COMMENT 'the traffic type of the rule, can be Ingress or Egress',
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'True if the rule can be displayed to the end user',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_firewall_rules__uuid` (`uuid`),
  KEY `fk_firewall_rules__ip_address_id` (`ip_address_id`),
  KEY `fk_firewall_rules__network_id` (`network_id`),
  KEY `fk_firewall_rules__account_id` (`account_id`),
  KEY `fk_firewall_rules__domain_id` (`domain_id`),
  KEY `fk_firewall_rules__related` (`related`),
  KEY `fk_firewall_rules__vpc_id` (`vpc_id`),
  KEY `i_firewall_rules__purpose` (`purpose`),
  CONSTRAINT `fk_firewall_rules__account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_firewall_rules__domain_id` FOREIGN KEY (`domain_id`) REFERENCES `domain` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_firewall_rules__ip_address_id` FOREIGN KEY (`ip_address_id`) REFERENCES `user_ip_address` (`id`),
  CONSTRAINT `fk_firewall_rules__network_id` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_firewall_rules__related` FOREIGN KEY (`related`) REFERENCES `firewall_rules` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_firewall_rules__vpc_id` FOREIGN KEY (`vpc_id`) REFERENCES `vpc` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `firewall_rules`
--

LOCK TABLES `firewall_rules` WRITE;
/*!40000 ALTER TABLE `firewall_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `firewall_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `firewall_rules_cidrs`
--

DROP TABLE IF EXISTS `firewall_rules_cidrs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `firewall_rules_cidrs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `firewall_rule_id` bigint(20) unsigned NOT NULL COMMENT 'firewall rule id',
  `source_cidr` varchar(18) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_rule_cidrs` (`firewall_rule_id`,`source_cidr`),
  KEY `fk_firewall_cidrs_firewall_rules` (`firewall_rule_id`),
  CONSTRAINT `fk_firewall_cidrs_firewall_rules` FOREIGN KEY (`firewall_rule_id`) REFERENCES `firewall_rules` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `firewall_rules_cidrs`
--

LOCK TABLES `firewall_rules_cidrs` WRITE;
/*!40000 ALTER TABLE `firewall_rules_cidrs` DISABLE KEYS */;
/*!40000 ALTER TABLE `firewall_rules_cidrs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `free_ip_view`
--

DROP TABLE IF EXISTS `free_ip_view`;
/*!50001 DROP VIEW IF EXISTS `free_ip_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `free_ip_view` (
  `free_ip` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `global_load_balancer_lb_rule_map`
--

DROP TABLE IF EXISTS `global_load_balancer_lb_rule_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `global_load_balancer_lb_rule_map` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `gslb_rule_id` bigint(20) unsigned NOT NULL,
  `lb_rule_id` bigint(20) unsigned NOT NULL,
  `weight` bigint(20) unsigned NOT NULL DEFAULT '1' COMMENT 'weight of the site in gslb',
  `revoke` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '1 is when rule is set for Revoke',
  PRIMARY KEY (`id`),
  UNIQUE KEY `gslb_rule_id` (`gslb_rule_id`,`lb_rule_id`),
  KEY `fk_lb_rule_id` (`lb_rule_id`),
  CONSTRAINT `fk_gslb_rule_id` FOREIGN KEY (`gslb_rule_id`) REFERENCES `global_load_balancing_rules` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_lb_rule_id` FOREIGN KEY (`lb_rule_id`) REFERENCES `load_balancing_rules` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `global_load_balancer_lb_rule_map`
--

LOCK TABLES `global_load_balancer_lb_rule_map` WRITE;
/*!40000 ALTER TABLE `global_load_balancer_lb_rule_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `global_load_balancer_lb_rule_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `global_load_balancing_rules`
--

DROP TABLE IF EXISTS `global_load_balancing_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `global_load_balancing_rules` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uuid` varchar(40) DEFAULT NULL,
  `account_id` bigint(20) unsigned NOT NULL COMMENT 'account id',
  `domain_id` bigint(20) unsigned NOT NULL COMMENT 'domain id',
  `region_id` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(4096) DEFAULT NULL COMMENT 'description',
  `state` char(32) NOT NULL COMMENT 'current state of this rule',
  `algorithm` varchar(255) NOT NULL COMMENT 'load balancing algorithm used to distribbute traffic across zones',
  `persistence` varchar(255) NOT NULL COMMENT 'session persistence used across the zone',
  `service_type` varchar(255) NOT NULL COMMENT 'GSLB service type (tcp/udp)',
  `gslb_domain_name` varchar(255) NOT NULL COMMENT 'DNS name for the GSLB service that is used to provide a FQDN for the GSLB service',
  PRIMARY KEY (`id`),
  KEY `fk_global_load_balancing_rules_account_id` (`account_id`),
  KEY `fk_global_load_balancing_rules_region_id` (`region_id`),
  CONSTRAINT `fk_global_load_balancing_rules_account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_global_load_balancing_rules_region_id` FOREIGN KEY (`region_id`) REFERENCES `region` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `global_load_balancing_rules`
--

LOCK TABLES `global_load_balancing_rules` WRITE;
/*!40000 ALTER TABLE `global_load_balancing_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `global_load_balancing_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guest_os`
--

DROP TABLE IF EXISTS `guest_os`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `guest_os` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `uuid` varchar(40) DEFAULT NULL,
  `display_name` varchar(255) NOT NULL,
  `created` datetime DEFAULT NULL COMMENT 'Time when Guest OS was created in system',
  `removed` datetime DEFAULT NULL COMMENT 'Time when Guest OS was removed if deleted, else NULL',
  `is_user_defined` int(1) unsigned DEFAULT '0' COMMENT 'True if this guest OS type was added by admin',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_guest_os__uuid` (`uuid`),
  KEY `fk_guest_os__category_id` (`category_id`),
  CONSTRAINT `fk_guest_os__category_id` FOREIGN KEY (`category_id`) REFERENCES `guest_os_category` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=231 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guest_os`
--

LOCK TABLES `guest_os` WRITE;
/*!40000 ALTER TABLE `guest_os` DISABLE KEYS */;
INSERT INTO `guest_os` VALUES (1,1,NULL,'ae13b172-fcd8-11e3-9019-080027ce083d','CentOS 4.5 (32-bit)','2014-06-26 02:22:14',NULL,0),(2,1,NULL,'ae13bc4e-fcd8-11e3-9019-080027ce083d','CentOS 4.6 (32-bit)','2014-06-26 02:22:14',NULL,0),(3,1,NULL,'ae13c644-fcd8-11e3-9019-080027ce083d','CentOS 4.7 (32-bit)','2014-06-26 02:22:14',NULL,0),(4,1,NULL,'ae13d062-fcd8-11e3-9019-080027ce083d','CentOS 4.8 (32-bit)','2014-06-26 02:22:14',NULL,0),(5,1,NULL,'ae13da62-fcd8-11e3-9019-080027ce083d','CentOS 5.0 (32-bit)','2014-06-26 02:22:14',NULL,0),(6,1,NULL,'ae13e462-fcd8-11e3-9019-080027ce083d','CentOS 5.0 (64-bit)','2014-06-26 02:22:14',NULL,0),(7,1,NULL,'ae13ee08-fcd8-11e3-9019-080027ce083d','CentOS 5.1 (32-bit)','2014-06-26 02:22:14',NULL,0),(8,1,NULL,'ae13f75e-fcd8-11e3-9019-080027ce083d','CentOS 5.1 (64-bit)','2014-06-26 02:22:14',NULL,0),(9,1,NULL,'ae140082-fcd8-11e3-9019-080027ce083d','CentOS 5.2 (32-bit)','2014-06-26 02:22:14',NULL,0),(10,1,NULL,'ae140ab4-fcd8-11e3-9019-080027ce083d','CentOS 5.2 (64-bit)','2014-06-26 02:22:14',NULL,0),(11,1,NULL,'ae1414b4-fcd8-11e3-9019-080027ce083d','CentOS 5.3 (32-bit)','2014-06-26 02:22:14',NULL,0),(12,1,NULL,'ae141e96-fcd8-11e3-9019-080027ce083d','CentOS 5.3 (64-bit)','2014-06-26 02:22:14',NULL,0),(13,1,NULL,'ae14285a-fcd8-11e3-9019-080027ce083d','CentOS 5.4 (32-bit)','2014-06-26 02:22:14',NULL,0),(14,1,NULL,'ae14325a-fcd8-11e3-9019-080027ce083d','CentOS 5.4 (64-bit)','2014-06-26 02:22:14',NULL,0),(15,2,NULL,'ae143c82-fcd8-11e3-9019-080027ce083d','Debian GNU/Linux 5.0 (64-bit)','2014-06-26 02:22:14',NULL,0),(16,3,NULL,'ae144e52-fcd8-11e3-9019-080027ce083d','Oracle Enterprise Linux 5.0 (32-bit)','2014-06-26 02:22:14',NULL,0),(17,3,NULL,'ae14596a-fcd8-11e3-9019-080027ce083d','Oracle Enterprise Linux 5.0 (64-bit)','2014-06-26 02:22:14',NULL,0),(18,3,NULL,'ae146446-fcd8-11e3-9019-080027ce083d','Oracle Enterprise Linux 5.1 (32-bit)','2014-06-26 02:22:14',NULL,0),(19,3,NULL,'ae146f7c-fcd8-11e3-9019-080027ce083d','Oracle Enterprise Linux 5.1 (64-bit)','2014-06-26 02:22:14',NULL,0),(20,3,NULL,'ae147a3a-fcd8-11e3-9019-080027ce083d','Oracle Enterprise Linux 5.2 (32-bit)','2014-06-26 02:22:14',NULL,0),(21,3,NULL,'ae148502-fcd8-11e3-9019-080027ce083d','Oracle Enterprise Linux 5.2 (64-bit)','2014-06-26 02:22:14',NULL,0),(22,3,NULL,'ae148f98-fcd8-11e3-9019-080027ce083d','Oracle Enterprise Linux 5.3 (32-bit)','2014-06-26 02:22:14',NULL,0),(23,3,NULL,'ae149b1e-fcd8-11e3-9019-080027ce083d','Oracle Enterprise Linux 5.3 (64-bit)','2014-06-26 02:22:14',NULL,0),(24,3,NULL,'ae14a488-fcd8-11e3-9019-080027ce083d','Oracle Enterprise Linux 5.4 (32-bit)','2014-06-26 02:22:14',NULL,0),(25,3,NULL,'ae14ad84-fcd8-11e3-9019-080027ce083d','Oracle Enterprise Linux 5.4 (64-bit)','2014-06-26 02:22:14',NULL,0),(26,4,NULL,'ae14b69e-fcd8-11e3-9019-080027ce083d','Red Hat Enterprise Linux 4.5 (32-bit)','2014-06-26 02:22:14',NULL,0),(27,4,NULL,'ae14c094-fcd8-11e3-9019-080027ce083d','Red Hat Enterprise Linux 4.6 (32-bit)','2014-06-26 02:22:14',NULL,0),(28,4,NULL,'ae14c9cc-fcd8-11e3-9019-080027ce083d','Red Hat Enterprise Linux 4.7 (32-bit)','2014-06-26 02:22:14',NULL,0),(29,4,NULL,'ae14d35e-fcd8-11e3-9019-080027ce083d','Red Hat Enterprise Linux 4.8 (32-bit)','2014-06-26 02:22:14',NULL,0),(30,4,NULL,'ae14dca0-fcd8-11e3-9019-080027ce083d','Red Hat Enterprise Linux 5.0 (32-bit)','2014-06-26 02:22:14',NULL,0),(31,4,NULL,'ae14e65a-fcd8-11e3-9019-080027ce083d','Red Hat Enterprise Linux 5.0 (64-bit)','2014-06-26 02:22:14',NULL,0),(32,4,NULL,'ae14eede-fcd8-11e3-9019-080027ce083d','Red Hat Enterprise Linux 5.1 (32-bit)','2014-06-26 02:22:14',NULL,0),(33,4,NULL,'ae14f910-fcd8-11e3-9019-080027ce083d','Red Hat Enterprise Linux 5.1 (64-bit)','2014-06-26 02:22:14',NULL,0),(34,4,NULL,'ae1502ca-fcd8-11e3-9019-080027ce083d','Red Hat Enterprise Linux 5.2 (32-bit)','2014-06-26 02:22:14',NULL,0),(35,4,NULL,'ae150be4-fcd8-11e3-9019-080027ce083d','Red Hat Enterprise Linux 5.2 (64-bit)','2014-06-26 02:22:14',NULL,0),(36,4,NULL,'ae1515f8-fcd8-11e3-9019-080027ce083d','Red Hat Enterprise Linux 5.3 (32-bit)','2014-06-26 02:22:14',NULL,0),(37,4,NULL,'ae152084-fcd8-11e3-9019-080027ce083d','Red Hat Enterprise Linux 5.3 (64-bit)','2014-06-26 02:22:14',NULL,0),(38,4,NULL,'ae152aa2-fcd8-11e3-9019-080027ce083d','Red Hat Enterprise Linux 5.4 (32-bit)','2014-06-26 02:22:14',NULL,0),(39,4,NULL,'ae153498-fcd8-11e3-9019-080027ce083d','Red Hat Enterprise Linux 5.4 (64-bit)','2014-06-26 02:22:14',NULL,0),(40,5,NULL,'ae153ce0-fcd8-11e3-9019-080027ce083d','SUSE Linux Enterprise Server 9 SP4 (32-bit)','2014-06-26 02:22:14',NULL,0),(41,5,NULL,'ae1546b8-fcd8-11e3-9019-080027ce083d','SUSE Linux Enterprise Server 10 SP1 (32-bit)','2014-06-26 02:22:14',NULL,0),(42,5,NULL,'ae15534c-fcd8-11e3-9019-080027ce083d','SUSE Linux Enterprise Server 10 SP1 (64-bit)','2014-06-26 02:22:14',NULL,0),(43,5,NULL,'ae155edc-fcd8-11e3-9019-080027ce083d','SUSE Linux Enterprise Server 10 SP2 (32-bit)','2014-06-26 02:22:14',NULL,0),(44,5,NULL,'ae156a26-fcd8-11e3-9019-080027ce083d','SUSE Linux Enterprise Server 10 SP2 (64-bit)','2014-06-26 02:22:14',NULL,0),(45,5,NULL,'ae15753e-fcd8-11e3-9019-080027ce083d','SUSE Linux Enterprise Server 10 SP3 (64-bit)','2014-06-26 02:22:14',NULL,0),(46,5,NULL,'ae157fac-fcd8-11e3-9019-080027ce083d','SUSE Linux Enterprise Server 11 (32-bit)','2014-06-26 02:22:14',NULL,0),(47,5,NULL,'ae15897a-fcd8-11e3-9019-080027ce083d','SUSE Linux Enterprise Server 11 (64-bit)','2014-06-26 02:22:14',NULL,0),(48,6,NULL,'ae159410-fcd8-11e3-9019-080027ce083d','Windows 7 (32-bit)','2014-06-26 02:22:14',NULL,0),(49,6,NULL,'ae159e9c-fcd8-11e3-9019-080027ce083d','Windows 7 (64-bit)','2014-06-26 02:22:14',NULL,0),(50,6,NULL,'ae15a900-fcd8-11e3-9019-080027ce083d','Windows Server 2003 Enterprise Edition(32-bit)','2014-06-26 02:22:14',NULL,0),(51,6,NULL,'ae15b378-fcd8-11e3-9019-080027ce083d','Windows Server 2003 Enterprise Edition(64-bit)','2014-06-26 02:22:14',NULL,0),(52,6,NULL,'ae15be9a-fcd8-11e3-9019-080027ce083d','Windows Server 2008 (32-bit)','2014-06-26 02:22:14',NULL,0),(53,6,NULL,'ae15c76e-fcd8-11e3-9019-080027ce083d','Windows Server 2008 (64-bit)','2014-06-26 02:22:14',NULL,0),(54,6,NULL,'ae15d114-fcd8-11e3-9019-080027ce083d','Windows Server 2008 R2 (64-bit)','2014-06-26 02:22:14',NULL,0),(55,6,NULL,'ae15da42-fcd8-11e3-9019-080027ce083d','Windows 2000 Server SP4 (32-bit)','2014-06-26 02:22:14',NULL,0),(56,6,NULL,'ae15e5be-fcd8-11e3-9019-080027ce083d','Windows Vista (32-bit)','2014-06-26 02:22:14',NULL,0),(57,6,NULL,'ae15ef6e-fcd8-11e3-9019-080027ce083d','Windows XP SP2 (32-bit)','2014-06-26 02:22:14',NULL,0),(58,6,NULL,'ae15fa0e-fcd8-11e3-9019-080027ce083d','Windows XP SP3 (32-bit)','2014-06-26 02:22:14',NULL,0),(59,10,NULL,'ae1603dc-fcd8-11e3-9019-080027ce083d','Other Ubuntu (32-bit)','2014-06-26 02:22:14',NULL,0),(60,7,NULL,'ae160e4a-fcd8-11e3-9019-080027ce083d','Other (32-bit)','2014-06-26 02:22:14',NULL,0),(61,6,NULL,'ae162772-fcd8-11e3-9019-080027ce083d','Windows 2000 Server','2014-06-26 02:22:14',NULL,0),(62,6,NULL,'ae1630be-fcd8-11e3-9019-080027ce083d','Windows 98','2014-06-26 02:22:14',NULL,0),(63,6,NULL,'ae163be0-fcd8-11e3-9019-080027ce083d','Windows 95','2014-06-26 02:22:14',NULL,0),(64,6,NULL,'ae1647d4-fcd8-11e3-9019-080027ce083d','Windows NT 4','2014-06-26 02:22:14',NULL,0),(65,6,NULL,'ae165170-fcd8-11e3-9019-080027ce083d','Windows 3.1','2014-06-26 02:22:14',NULL,0),(66,4,NULL,'ae165b34-fcd8-11e3-9019-080027ce083d','Red Hat Enterprise Linux 3(32-bit)','2014-06-26 02:22:14',NULL,0),(67,4,NULL,'ae1664e4-fcd8-11e3-9019-080027ce083d','Red Hat Enterprise Linux 3(64-bit)','2014-06-26 02:22:14',NULL,0),(68,7,NULL,'ae166e8a-fcd8-11e3-9019-080027ce083d','Open Enterprise Server','2014-06-26 02:22:14',NULL,0),(69,7,NULL,'ae167984-fcd8-11e3-9019-080027ce083d','Asianux 3(32-bit)','2014-06-26 02:22:14',NULL,0),(70,7,NULL,'ae168398-fcd8-11e3-9019-080027ce083d','Asianux 3(64-bit)','2014-06-26 02:22:14',NULL,0),(72,2,NULL,'ae168d48-fcd8-11e3-9019-080027ce083d','Debian GNU/Linux 5(64-bit)','2014-06-26 02:22:14',NULL,0),(73,2,NULL,'ae169680-fcd8-11e3-9019-080027ce083d','Debian GNU/Linux 4(32-bit)','2014-06-26 02:22:14',NULL,0),(74,2,NULL,'ae16a314-fcd8-11e3-9019-080027ce083d','Debian GNU/Linux 4(64-bit)','2014-06-26 02:22:14',NULL,0),(75,7,NULL,'ae16acc4-fcd8-11e3-9019-080027ce083d','Other 2.6x Linux (32-bit)','2014-06-26 02:22:14',NULL,0),(76,7,NULL,'ae16b660-fcd8-11e3-9019-080027ce083d','Other 2.6x Linux (64-bit)','2014-06-26 02:22:14',NULL,0),(77,8,NULL,'ae16c024-fcd8-11e3-9019-080027ce083d','Novell Netware 6.x','2014-06-26 02:22:14',NULL,0),(78,8,NULL,'ae16c948-fcd8-11e3-9019-080027ce083d','Novell Netware 5.1','2014-06-26 02:22:14',NULL,0),(79,9,NULL,'ae16d33e-fcd8-11e3-9019-080027ce083d','Sun Solaris 10(32-bit)','2014-06-26 02:22:14',NULL,0),(80,9,NULL,'ae16dd70-fcd8-11e3-9019-080027ce083d','Sun Solaris 10(64-bit)','2014-06-26 02:22:14',NULL,0),(81,9,NULL,'ae16e9b4-fcd8-11e3-9019-080027ce083d','Sun Solaris 9(Experimental)','2014-06-26 02:22:14',NULL,0),(82,9,NULL,'ae16f35a-fcd8-11e3-9019-080027ce083d','Sun Solaris 8(Experimental)','2014-06-26 02:22:14',NULL,0),(83,9,NULL,'ae16fdc8-fcd8-11e3-9019-080027ce083d','FreeBSD (32-bit)','2014-06-26 02:22:14',NULL,0),(84,9,NULL,'ae1707aa-fcd8-11e3-9019-080027ce083d','FreeBSD (64-bit)','2014-06-26 02:22:14',NULL,0),(85,9,NULL,'ae171146-fcd8-11e3-9019-080027ce083d','SCO OpenServer 5','2014-06-26 02:22:14',NULL,0),(86,9,NULL,'ae171aba-fcd8-11e3-9019-080027ce083d','SCO UnixWare 7','2014-06-26 02:22:14',NULL,0),(87,6,NULL,'ae172424-fcd8-11e3-9019-080027ce083d','Windows Server 2003 DataCenter Edition(32-bit)','2014-06-26 02:22:14',NULL,0),(88,6,NULL,'ae172d52-fcd8-11e3-9019-080027ce083d','Windows Server 2003 DataCenter Edition(64-bit)','2014-06-26 02:22:14',NULL,0),(89,6,NULL,'ae1738e2-fcd8-11e3-9019-080027ce083d','Windows Server 2003 Standard Edition(32-bit)','2014-06-26 02:22:14',NULL,0),(90,6,NULL,'ae174404-fcd8-11e3-9019-080027ce083d','Windows Server 2003 Standard Edition(64-bit)','2014-06-26 02:22:14',NULL,0),(91,6,NULL,'ae174d5a-fcd8-11e3-9019-080027ce083d','Windows Server 2003 Web Edition','2014-06-26 02:22:14',NULL,0),(92,6,NULL,'ae175714-fcd8-11e3-9019-080027ce083d','Microsoft Small Bussiness Server 2003','2014-06-26 02:22:14',NULL,0),(93,6,NULL,'ae176100-fcd8-11e3-9019-080027ce083d','Windows XP (32-bit)','2014-06-26 02:22:14',NULL,0),(94,6,NULL,'ae176a7e-fcd8-11e3-9019-080027ce083d','Windows XP (64-bit)','2014-06-26 02:22:14',NULL,0),(95,6,NULL,'ae1774ba-fcd8-11e3-9019-080027ce083d','Windows 2000 Advanced Server','2014-06-26 02:22:14',NULL,0),(96,5,NULL,'ae177eba-fcd8-11e3-9019-080027ce083d','SUSE Linux Enterprise 8(32-bit)','2014-06-26 02:22:14',NULL,0),(97,5,NULL,'ae1786b2-fcd8-11e3-9019-080027ce083d','SUSE Linux Enterprise 8(64-bit)','2014-06-26 02:22:14',NULL,0),(98,7,NULL,'ae179076-fcd8-11e3-9019-080027ce083d','Other Linux (32-bit)','2014-06-26 02:22:14',NULL,0),(99,7,NULL,'ae179954-fcd8-11e3-9019-080027ce083d','Other Linux (64-bit)','2014-06-26 02:22:14',NULL,0),(100,10,NULL,'ae17ac6e-fcd8-11e3-9019-080027ce083d','Other Ubuntu (64-bit)','2014-06-26 02:22:14',NULL,0),(101,6,NULL,'ae17bb3c-fcd8-11e3-9019-080027ce083d','Windows Vista (64-bit)','2014-06-26 02:22:14',NULL,0),(102,6,NULL,'ae17cbfe-fcd8-11e3-9019-080027ce083d','DOS','2014-06-26 02:22:14',NULL,0),(103,7,NULL,'ae17daf4-fcd8-11e3-9019-080027ce083d','Other (64-bit)','2014-06-26 02:22:14',NULL,0),(104,7,NULL,'ae17eaee-fcd8-11e3-9019-080027ce083d','OS/2','2014-06-26 02:22:14',NULL,0),(105,6,NULL,'ae17f854-fcd8-11e3-9019-080027ce083d','Windows 2000 Professional','2014-06-26 02:22:14',NULL,0),(106,4,NULL,'ae1804ca-fcd8-11e3-9019-080027ce083d','Red Hat Enterprise Linux 4(64-bit)','2014-06-26 02:22:14',NULL,0),(107,5,NULL,'ae181136-fcd8-11e3-9019-080027ce083d','SUSE Linux Enterprise 9(32-bit)','2014-06-26 02:22:14',NULL,0),(108,5,NULL,'ae181cbc-fcd8-11e3-9019-080027ce083d','SUSE Linux Enterprise 9(64-bit)','2014-06-26 02:22:14',NULL,0),(109,5,NULL,'ae182f5e-fcd8-11e3-9019-080027ce083d','SUSE Linux Enterprise 10(32-bit)','2014-06-26 02:22:14',NULL,0),(110,5,NULL,'ae183b16-fcd8-11e3-9019-080027ce083d','SUSE Linux Enterprise 10(64-bit)','2014-06-26 02:22:14',NULL,0),(111,1,NULL,'ae184750-fcd8-11e3-9019-080027ce083d','CentOS 5.5 (32-bit)','2014-06-26 02:22:14',NULL,0),(112,1,NULL,'ae1851c8-fcd8-11e3-9019-080027ce083d','CentOS 5.5 (64-bit)','2014-06-26 02:22:14',NULL,0),(113,4,NULL,'ae185d80-fcd8-11e3-9019-080027ce083d','Red Hat Enterprise Linux 5.5 (32-bit)','2014-06-26 02:22:14',NULL,0),(114,4,NULL,'ae1869b0-fcd8-11e3-9019-080027ce083d','Red Hat Enterprise Linux 5.5 (64-bit)','2014-06-26 02:22:14',NULL,0),(115,4,NULL,'ae1872ac-fcd8-11e3-9019-080027ce083d','Fedora 13','2014-06-26 02:22:14',NULL,0),(116,4,NULL,'ae187d6a-fcd8-11e3-9019-080027ce083d','Fedora 12','2014-06-26 02:22:14',NULL,0),(117,4,NULL,'ae1887e2-fcd8-11e3-9019-080027ce083d','Fedora 11','2014-06-26 02:22:14',NULL,0),(118,4,NULL,'ae189368-fcd8-11e3-9019-080027ce083d','Fedora 10','2014-06-26 02:22:14',NULL,0),(119,4,NULL,'ae189e26-fcd8-11e3-9019-080027ce083d','Fedora 9','2014-06-26 02:22:14',NULL,0),(120,4,NULL,'ae18a862-fcd8-11e3-9019-080027ce083d','Fedora 8','2014-06-26 02:22:14',NULL,0),(121,10,NULL,'ae18b38e-fcd8-11e3-9019-080027ce083d','Ubuntu 10.04 (32-bit)','2014-06-26 02:22:14',NULL,0),(122,10,NULL,'ae18bee2-fcd8-11e3-9019-080027ce083d','Ubuntu 9.10 (32-bit)','2014-06-26 02:22:14',NULL,0),(123,10,NULL,'ae18c9be-fcd8-11e3-9019-080027ce083d','Ubuntu 9.04 (32-bit)','2014-06-26 02:22:14',NULL,0),(124,10,NULL,'ae18d468-fcd8-11e3-9019-080027ce083d','Ubuntu 8.10 (32-bit)','2014-06-26 02:22:14',NULL,0),(125,10,NULL,'ae18df8a-fcd8-11e3-9019-080027ce083d','Ubuntu 8.04 (32-bit)','2014-06-26 02:22:14',NULL,0),(126,10,NULL,'ae18ea5c-fcd8-11e3-9019-080027ce083d','Ubuntu 10.04 (64-bit)','2014-06-26 02:22:14',NULL,0),(127,10,NULL,'ae18f51a-fcd8-11e3-9019-080027ce083d','Ubuntu 9.10 (64-bit)','2014-06-26 02:22:14',NULL,0),(128,10,NULL,'ae190ab4-fcd8-11e3-9019-080027ce083d','Ubuntu 9.04 (64-bit)','2014-06-26 02:22:14',NULL,0),(129,10,NULL,'ae191554-fcd8-11e3-9019-080027ce083d','Ubuntu 8.10 (64-bit)','2014-06-26 02:22:14',NULL,0),(130,10,NULL,'ae192256-fcd8-11e3-9019-080027ce083d','Ubuntu 8.04 (64-bit)','2014-06-26 02:22:14',NULL,0),(131,4,NULL,'ae192e9a-fcd8-11e3-9019-080027ce083d','Red Hat Enterprise Linux 2','2014-06-26 02:22:14',NULL,0),(132,2,NULL,'ae19398a-fcd8-11e3-9019-080027ce083d','Debian GNU/Linux 6(32-bit)','2014-06-26 02:22:14',NULL,0),(133,2,NULL,'ae194452-fcd8-11e3-9019-080027ce083d','Debian GNU/Linux 6(64-bit)','2014-06-26 02:22:14',NULL,0),(134,3,NULL,'ae194f74-fcd8-11e3-9019-080027ce083d','Oracle Enterprise Linux 5.5 (32-bit)','2014-06-26 02:22:14',NULL,0),(135,3,NULL,'ae197fda-fcd8-11e3-9019-080027ce083d','Oracle Enterprise Linux 5.5 (64-bit)','2014-06-26 02:22:14',NULL,0),(136,4,NULL,'ae198ae8-fcd8-11e3-9019-080027ce083d','Red Hat Enterprise Linux 6.0 (32-bit)','2014-06-26 02:22:14',NULL,0),(137,4,NULL,'ae199682-fcd8-11e3-9019-080027ce083d','Red Hat Enterprise Linux 6.0 (64-bit)','2014-06-26 02:22:14',NULL,0),(138,7,NULL,'ae19a1e0-fcd8-11e3-9019-080027ce083d','None','2014-06-26 02:22:14',NULL,0),(139,7,NULL,'ae19aad2-fcd8-11e3-9019-080027ce083d','Other PV (32-bit)','2014-06-26 02:22:14',NULL,0),(140,7,NULL,'ae19b608-fcd8-11e3-9019-080027ce083d','Other PV (64-bit)','2014-06-26 02:22:14',NULL,0),(141,1,NULL,'ae19c166-fcd8-11e3-9019-080027ce083d','CentOS 5.6 (32-bit)','2014-06-26 02:22:14',NULL,0),(142,1,NULL,'ae19cd1e-fcd8-11e3-9019-080027ce083d','CentOS 5.6 (64-bit)','2014-06-26 02:22:14',NULL,0),(143,1,NULL,'ae19d980-fcd8-11e3-9019-080027ce083d','CentOS 6.0 (32-bit)','2014-06-26 02:22:14',NULL,0),(144,1,NULL,'ae19e524-fcd8-11e3-9019-080027ce083d','CentOS 6.0 (64-bit)','2014-06-26 02:22:14',NULL,0),(145,3,NULL,'ae19f21c-fcd8-11e3-9019-080027ce083d','Oracle Enterprise Linux 5.6 (32-bit)','2014-06-26 02:22:14',NULL,0),(146,3,NULL,'ae19fdde-fcd8-11e3-9019-080027ce083d','Oracle Enterprise Linux 5.6 (64-bit)','2014-06-26 02:22:14',NULL,0),(147,3,NULL,'ae1a08b0-fcd8-11e3-9019-080027ce083d','Oracle Enterprise Linux 6.0 (32-bit)','2014-06-26 02:22:14',NULL,0),(148,3,NULL,'ae1a1616-fcd8-11e3-9019-080027ce083d','Oracle Enterprise Linux 6.0 (64-bit)','2014-06-26 02:22:14',NULL,0),(149,4,NULL,'ae1a1fee-fcd8-11e3-9019-080027ce083d','Red Hat Enterprise Linux 5.6 (32-bit)','2014-06-26 02:22:14',NULL,0),(150,4,NULL,'ae1a2b10-fcd8-11e3-9019-080027ce083d','Red Hat Enterprise Linux 5.6 (64-bit)','2014-06-26 02:22:14',NULL,0),(151,5,NULL,'ae1a3768-fcd8-11e3-9019-080027ce083d','SUSE Linux Enterprise Server 10 SP3 (32-bit)','2014-06-26 02:22:14',NULL,0),(152,5,NULL,'ae1a41ae-fcd8-11e3-9019-080027ce083d','SUSE Linux Enterprise Server 10 SP4 (64-bit)','2014-06-26 02:22:14',NULL,0),(153,5,NULL,'ae1a4be0-fcd8-11e3-9019-080027ce083d','SUSE Linux Enterprise Server 10 SP4 (32-bit)','2014-06-26 02:22:14',NULL,0),(154,5,NULL,'ae1a5cca-fcd8-11e3-9019-080027ce083d','SUSE Linux Enterprise Server 11 SP1 (64-bit)','2014-06-26 02:22:14',NULL,0),(155,5,NULL,'ae1a6756-fcd8-11e3-9019-080027ce083d','SUSE Linux Enterprise Server 11 SP1 (32-bit)','2014-06-26 02:22:14',NULL,0),(156,10,NULL,'ae1a753e-fcd8-11e3-9019-080027ce083d','Ubuntu 10.10 (32-bit)','2014-06-26 02:22:14',NULL,0),(157,10,NULL,'ae1a82cc-fcd8-11e3-9019-080027ce083d','Ubuntu 10.10 (64-bit)','2014-06-26 02:22:14',NULL,0),(158,9,NULL,'ae1a8e66-fcd8-11e3-9019-080027ce083d','Sun Solaris 11 (64-bit)','2014-06-26 02:22:14',NULL,0),(159,9,NULL,'ae1a98de-fcd8-11e3-9019-080027ce083d','Sun Solaris 11 (32-bit)','2014-06-26 02:22:14',NULL,0),(160,6,NULL,'ae1aa306-fcd8-11e3-9019-080027ce083d','Windows PV','2014-06-26 02:22:14',NULL,0),(161,1,NULL,'ae1aadec-fcd8-11e3-9019-080027ce083d','CentOS 5.7 (32-bit)','2014-06-26 02:22:14',NULL,0),(162,1,NULL,'ae1aba08-fcd8-11e3-9019-080027ce083d','CentOS 5.7 (64-bit)','2014-06-26 02:22:14',NULL,0),(163,10,NULL,'ae1ad092-fcd8-11e3-9019-080027ce083d','Ubuntu 12.04 (32-bit)','2014-06-26 02:22:14',NULL,0),(164,10,NULL,'ae1adc40-fcd8-11e3-9019-080027ce083d','Ubuntu 12.04 (64-bit)','2014-06-26 02:22:14',NULL,0),(165,6,NULL,'ae1ae712-fcd8-11e3-9019-080027ce083d','Windows 8 (32-bit)','2014-06-26 02:22:14',NULL,0),(166,6,NULL,'ae1af18a-fcd8-11e3-9019-080027ce083d','Windows 8 (64-bit)','2014-06-26 02:22:14',NULL,0),(167,6,NULL,'ae1afbda-fcd8-11e3-9019-080027ce083d','Windows Server 2012 (64-bit)','2014-06-26 02:22:14',NULL,0),(168,6,NULL,'afd744d8-fcd8-11e3-9019-080027ce083d','Windows Server 2012 R2 (64-bit)','2014-06-26 02:22:14',NULL,0),(169,10,NULL,'ae1b1138-fcd8-11e3-9019-080027ce083d','Ubuntu 11.04 (32-bit)','2014-06-26 02:22:14',NULL,0),(170,10,NULL,'ae1b1d9a-fcd8-11e3-9019-080027ce083d','Ubuntu 11.04 (64-bit)','2014-06-26 02:22:14',NULL,0),(171,1,NULL,'ae1b28d0-fcd8-11e3-9019-080027ce083d','CentOS 6.3 (32-bit)','2014-06-26 02:22:14',NULL,0),(172,1,NULL,'ae1b3190-fcd8-11e3-9019-080027ce083d','CentOS 6.3 (64-bit)','2014-06-26 02:22:14',NULL,0),(173,1,NULL,'ae1b3c80-fcd8-11e3-9019-080027ce083d','CentOS 5.8 (32-bit)','2014-06-26 02:22:14',NULL,0),(174,1,NULL,'ae1b472a-fcd8-11e3-9019-080027ce083d','CentOS 5.8 (64-bit)','2014-06-26 02:22:14',NULL,0),(175,1,NULL,'ae1b51b6-fcd8-11e3-9019-080027ce083d','CentOS 5.9 (32-bit)','2014-06-26 02:22:14',NULL,0),(176,1,NULL,'ae1b5c7e-fcd8-11e3-9019-080027ce083d','CentOS 5.9 (64-bit)','2014-06-26 02:22:14',NULL,0),(177,1,NULL,'ae1b6746-fcd8-11e3-9019-080027ce083d','CentOS 6.1 (32-bit)','2014-06-26 02:22:14',NULL,0),(178,1,NULL,'ae1b727c-fcd8-11e3-9019-080027ce083d','CentOS 6.1 (64-bit)','2014-06-26 02:22:14',NULL,0),(179,1,NULL,'ae1b7c40-fcd8-11e3-9019-080027ce083d','CentOS 6.2 (32-bit)','2014-06-26 02:22:14',NULL,0),(180,1,NULL,'ae1b88ca-fcd8-11e3-9019-080027ce083d','CentOS 6.2 (64-bit)','2014-06-26 02:22:14',NULL,0),(181,1,NULL,'ae1b9536-fcd8-11e3-9019-080027ce083d','CentOS 6.4 (32-bit)','2014-06-26 02:22:14',NULL,0),(182,1,NULL,'ae1ba256-fcd8-11e3-9019-080027ce083d','CentOS 6.4 (64-bit)','2014-06-26 02:22:14',NULL,0),(183,2,NULL,'ae1bad6e-fcd8-11e3-9019-080027ce083d','Debian GNU/Linux 7(32-bit)','2014-06-26 02:22:14',NULL,0),(184,2,NULL,'ae1bb7fa-fcd8-11e3-9019-080027ce083d','Debian GNU/Linux 7(64-bit)','2014-06-26 02:22:14',NULL,0),(185,5,NULL,'ae1bc218-fcd8-11e3-9019-080027ce083d','SUSE Linux Enterprise Server 11 SP2 (64-bit)','2014-06-26 02:22:14',NULL,0),(186,5,NULL,'ae1bcd76-fcd8-11e3-9019-080027ce083d','SUSE Linux Enterprise Server 11 SP2 (32-bit)','2014-06-26 02:22:14',NULL,0),(187,5,NULL,'ae1be810-fcd8-11e3-9019-080027ce083d','SUSE Linux Enterprise Server 11 SP3 (64-bit)','2014-06-26 02:22:14',NULL,0),(188,5,NULL,'ae1c02fa-fcd8-11e3-9019-080027ce083d','SUSE Linux Enterprise Server 11 SP3 (32-bit)','2014-06-26 02:22:14',NULL,0),(189,4,NULL,'ae1c1092-fcd8-11e3-9019-080027ce083d','Red Hat Enterprise Linux 5.7 (32-bit)','2014-06-26 02:22:14',NULL,0),(190,4,NULL,'ae1c1d12-fcd8-11e3-9019-080027ce083d','Red Hat Enterprise Linux 5.7 (64-bit)','2014-06-26 02:22:14',NULL,0),(191,4,NULL,'ae1c2a00-fcd8-11e3-9019-080027ce083d','Red Hat Enterprise Linux 5.8 (32-bit)','2014-06-26 02:22:14',NULL,0),(192,4,NULL,'ae1c418e-fcd8-11e3-9019-080027ce083d','Red Hat Enterprise Linux 5.8 (64-bit)','2014-06-26 02:22:14',NULL,0),(193,4,NULL,'ae1c4d32-fcd8-11e3-9019-080027ce083d','Red Hat Enterprise Linux 5.9 (32-bit)','2014-06-26 02:22:14',NULL,0),(194,4,NULL,'ae1c5930-fcd8-11e3-9019-080027ce083d','Red Hat Enterprise Linux 5.9 (64-bit)','2014-06-26 02:22:14',NULL,0),(195,4,NULL,'ae1c6664-fcd8-11e3-9019-080027ce083d','Red Hat Enterprise Linux 6.1 (32-bit)','2014-06-26 02:22:14',NULL,0),(196,4,NULL,'ae1c72f8-fcd8-11e3-9019-080027ce083d','Red Hat Enterprise Linux 6.1 (64-bit)','2014-06-26 02:22:14',NULL,0),(197,4,NULL,'ae1c7ec4-fcd8-11e3-9019-080027ce083d','Red Hat Enterprise Linux 6.2 (32-bit)','2014-06-26 02:22:14',NULL,0),(198,4,NULL,'ae1c8b30-fcd8-11e3-9019-080027ce083d','Red Hat Enterprise Linux 6.2 (64-bit)','2014-06-26 02:22:14',NULL,0),(199,4,NULL,'ae1c96d4-fcd8-11e3-9019-080027ce083d','Red Hat Enterprise Linux 6.3 (32-bit)','2014-06-26 02:22:14',NULL,0),(200,1,NULL,'ae1d973c-fcd8-11e3-9019-080027ce083d','Other CentOS (32-bit)','2014-06-26 02:22:14',NULL,0),(201,1,NULL,'ae1da150-fcd8-11e3-9019-080027ce083d','Other CentOS (64-bit)','2014-06-26 02:22:14',NULL,0),(202,5,NULL,'ae1dab96-fcd8-11e3-9019-080027ce083d','Other SUSE Linux(32-bit)','2014-06-26 02:22:14',NULL,0),(203,5,NULL,'ae1db7bc-fcd8-11e3-9019-080027ce083d','Other SUSE Linux(64-bit)','2014-06-26 02:22:14',NULL,0),(204,4,NULL,'ae1ca138-fcd8-11e3-9019-080027ce083d','Red Hat Enterprise Linux 6.3 (64-bit)','2014-06-26 02:22:14',NULL,0),(205,4,NULL,'ae1cabec-fcd8-11e3-9019-080027ce083d','Red Hat Enterprise Linux 6.4 (32-bit)','2014-06-26 02:22:14',NULL,0),(206,4,NULL,'aef99020-fcd8-11e3-9019-080027ce083d','Red Hat Enterprise Linux 6.4 (64-bit)','2014-06-26 02:22:14',NULL,0),(207,3,NULL,'ae1cbe70-fcd8-11e3-9019-080027ce083d','Oracle Enterprise Linux 5.7 (32-bit)','2014-06-26 02:22:14',NULL,0),(208,3,NULL,'ae1cc820-fcd8-11e3-9019-080027ce083d','Oracle Enterprise Linux 5.7 (64-bit)','2014-06-26 02:22:14',NULL,0),(209,3,NULL,'ae1cd158-fcd8-11e3-9019-080027ce083d','Oracle Enterprise Linux 5.8 (32-bit)','2014-06-26 02:22:14',NULL,0),(210,3,NULL,'ae1cdf0e-fcd8-11e3-9019-080027ce083d','Oracle Enterprise Linux 5.8 (64-bit)','2014-06-26 02:22:14',NULL,0),(211,3,NULL,'ae1ce97c-fcd8-11e3-9019-080027ce083d','Oracle Enterprise Linux 5.9 (32-bit)','2014-06-26 02:22:14',NULL,0),(212,3,NULL,'ae1cf2fa-fcd8-11e3-9019-080027ce083d','Oracle Enterprise Linux 5.9 (64-bit)','2014-06-26 02:22:14',NULL,0),(213,3,NULL,'ae1cfcfa-fcd8-11e3-9019-080027ce083d','Oracle Enterprise Linux 6.1 (32-bit)','2014-06-26 02:22:14',NULL,0),(214,3,NULL,'ae1d0556-fcd8-11e3-9019-080027ce083d','Oracle Enterprise Linux 6.1 (64-bit)','2014-06-26 02:22:14',NULL,0),(215,3,NULL,'ae1d0f6a-fcd8-11e3-9019-080027ce083d','Oracle Enterprise Linux 6.2 (32-bit)','2014-06-26 02:22:14',NULL,0),(216,3,NULL,'ae1d1bea-fcd8-11e3-9019-080027ce083d','Oracle Enterprise Linux 6.2 (64-bit)','2014-06-26 02:22:14',NULL,0),(217,3,NULL,'ae1d25ea-fcd8-11e3-9019-080027ce083d','Oracle Enterprise Linux 6.3 (32-bit)','2014-06-26 02:22:14',NULL,0),(218,3,NULL,'ae1d2fc2-fcd8-11e3-9019-080027ce083d','Oracle Enterprise Linux 6.3 (64-bit)','2014-06-26 02:22:14',NULL,0),(219,3,NULL,'ae1d3a12-fcd8-11e3-9019-080027ce083d','Oracle Enterprise Linux 6.4 (32-bit)','2014-06-26 02:22:14',NULL,0),(220,3,NULL,'ae1d443a-fcd8-11e3-9019-080027ce083d','Oracle Enterprise Linux 6.4 (64-bit)','2014-06-26 02:22:14',NULL,0),(221,7,NULL,'ae1d4f5c-fcd8-11e3-9019-080027ce083d','Apple Mac OS X 10.6 (32-bit)','2014-06-26 02:22:14',NULL,0),(222,7,NULL,'ae1d59b6-fcd8-11e3-9019-080027ce083d','Apple Mac OS X 10.6 (64-bit)','2014-06-26 02:22:14',NULL,0),(223,7,NULL,'ae1d637a-fcd8-11e3-9019-080027ce083d','Apple Mac OS X 10.7 (32-bit)','2014-06-26 02:22:14',NULL,0),(224,7,NULL,'ae1d6c9e-fcd8-11e3-9019-080027ce083d','Apple Mac OS X 10.7 (64-bit)','2014-06-26 02:22:14',NULL,0),(225,9,NULL,'ae1d8170-fcd8-11e3-9019-080027ce083d','FreeBSD 10 (32-bit)','2014-06-26 02:22:14',NULL,0),(226,9,NULL,'ae1d8e18-fcd8-11e3-9019-080027ce083d','FreeBSD 10 (64-bit)','2014-06-26 02:22:14',NULL,0),(227,1,NULL,'b0003dfc-fcd8-11e3-9019-080027ce083d','CentOS 6.5 (32-bit)','2014-06-26 02:22:14',NULL,0),(228,1,NULL,'b0004bbc-fcd8-11e3-9019-080027ce083d','CentOS 6.5 (64-bit)','2014-06-26 02:22:14',NULL,0),(229,6,NULL,'b0005d82-fcd8-11e3-9019-080027ce083d','Windows 8.1 (64-bit)','2014-06-26 02:22:14',NULL,0),(230,6,NULL,'b0006bb0-fcd8-11e3-9019-080027ce083d','Windows 8.1 (32-bit)','2014-06-26 02:22:14',NULL,0);
/*!40000 ALTER TABLE `guest_os` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guest_os_category`
--

DROP TABLE IF EXISTS `guest_os_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `guest_os_category` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `uuid` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_guest_os_category__uuid` (`uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guest_os_category`
--

LOCK TABLES `guest_os_category` WRITE;
/*!40000 ALTER TABLE `guest_os_category` DISABLE KEYS */;
INSERT INTO `guest_os_category` VALUES (1,'CentOS','ae133260-fcd8-11e3-9019-080027ce083d'),(2,'Debian','ae133d6e-fcd8-11e3-9019-080027ce083d'),(3,'Oracle','ae1347aa-fcd8-11e3-9019-080027ce083d'),(4,'RedHat','ae13524a-fcd8-11e3-9019-080027ce083d'),(5,'SUSE','ae135c54-fcd8-11e3-9019-080027ce083d'),(6,'Windows','ae136bd6-fcd8-11e3-9019-080027ce083d'),(7,'Other','ae137784-fcd8-11e3-9019-080027ce083d'),(8,'Novel','ae1383dc-fcd8-11e3-9019-080027ce083d'),(9,'Unix','ae138f26-fcd8-11e3-9019-080027ce083d'),(10,'Ubuntu','ae1399d0-fcd8-11e3-9019-080027ce083d'),(11,'None','ae13a524-fcd8-11e3-9019-080027ce083d');
/*!40000 ALTER TABLE `guest_os_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guest_os_hypervisor`
--

DROP TABLE IF EXISTS `guest_os_hypervisor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `guest_os_hypervisor` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `hypervisor_type` varchar(32) NOT NULL,
  `guest_os_name` varchar(255) NOT NULL,
  `guest_os_id` bigint(20) unsigned NOT NULL,
  `hypervisor_version` varchar(32) NOT NULL DEFAULT 'default' COMMENT 'Hypervisor version for this mapping',
  `uuid` varchar(40) DEFAULT NULL COMMENT 'UUID of the mapping',
  `created` datetime DEFAULT NULL COMMENT 'Time when mapping was created',
  `removed` datetime DEFAULT NULL COMMENT 'Time when mapping was removed if deleted, else NULL',
  `is_user_defined` int(1) unsigned DEFAULT '0' COMMENT 'True if this guest OS mapping was added by admin',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_guest_os_hypervisor__uuid` (`uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=1939 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guest_os_hypervisor`
--

LOCK TABLES `guest_os_hypervisor` WRITE;
/*!40000 ALTER TABLE `guest_os_hypervisor` DISABLE KEYS */;
INSERT INTO `guest_os_hypervisor` VALUES (1,'XenServer','CentOS 4.5 (32-bit)',1,'default','b010c528-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(2,'XenServer','CentOS 4.6 (32-bit)',2,'default','b010c67c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(3,'XenServer','CentOS 4.7 (32-bit)',3,'default','b010c726-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(4,'XenServer','CentOS 4.8 (32-bit)',4,'default','b010c7b2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(5,'XenServer','CentOS 5.0 (32-bit)',5,'default','b010c834-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(6,'XenServer','CentOS 5.0 (64-bit)',6,'default','b010c8b6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(7,'XenServer','CentOS 5.1 (32-bit)',7,'default','b010c938-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(8,'XenServer','CentOS 5.1 (32-bit)',8,'default','b010c9ba-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(9,'XenServer','CentOS 5.2 (32-bit)',9,'default','b010ca3c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(10,'XenServer','CentOS 5.2 (64-bit)',10,'default','b010cabe-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(11,'XenServer','CentOS 5.3 (32-bit)',11,'default','b010cc12-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(12,'XenServer','CentOS 5.3 (64-bit)',12,'default','b010cc9e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(13,'XenServer','CentOS 5.4 (32-bit)',13,'default','b010cd16-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(14,'XenServer','CentOS 5.4 (64-bit)',14,'default','b010cd98-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(15,'XenServer','CentOS 5.5 (32-bit)',111,'default','b010ce10-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(16,'XenServer','CentOS 5.5 (64-bit)',112,'default','b010ce92-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(17,'XenServer','CentOS 5.6 (32-bit)',141,'default','b010cf0a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(18,'XenServer','CentOS 5.6 (64-bit)',142,'default','b010cf82-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(19,'XenServer','CentOS 5.7 (32-bit)',161,'default','b010d004-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(20,'XenServer','CentOS 5.7 (64-bit)',162,'default','b010d07c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(21,'XenServer','CentOS 5.8 (32-bit)',173,'default','b010d0d6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(22,'XenServer','CentOS 5.8 (64-bit)',174,'default','b010d130-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(23,'XenServer','CentOS 5.9 (32-bit)',175,'default','b010d18a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(24,'XenServer','CentOS 5.9 (64-bit)',176,'default','b010d1da-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(25,'XenServer','CentOS 6.0 (32-bit)',143,'default','b010d22a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(26,'XenServer','CentOS 6.0 (64-bit)',144,'default','b010d888-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(27,'XenServer','CentOS 6.1 (32-bit)',177,'default','b010d8e2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(28,'XenServer','CentOS 6.1 (64-bit)',178,'default','b010d93c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(29,'XenServer','CentOS 6.2 (32-bit)',179,'default','b010d98c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(30,'XenServer','CentOS 6.2 (64-bit)',180,'default','b010d9dc-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(31,'XenServer','CentOS 6.3 (32-bit)',171,'default','b010da36-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(32,'XenServer','CentOS 6.3 (64-bit)',172,'default','b010da86-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(33,'XenServer','CentOS 6.4 (32-bit)',181,'default','b010dae0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(34,'XenServer','CentOS 6.4 (64-bit)',182,'default','b010db30-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(35,'XenServer','Debian Lenny 5.0 (32-bit)',15,'default','b010db8a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(36,'XenServer','Oracle Enterprise Linux 5.0 (32-bit)',16,'default','b010dbda-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(37,'XenServer','Oracle Enterprise Linux 5.0 (64-bit)',17,'default','b010dd60-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(38,'XenServer','Oracle Enterprise Linux 5.1 (32-bit)',18,'default','b010ddc4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(39,'XenServer','Oracle Enterprise Linux 5.1 (64-bit)',19,'default','b010de14-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(40,'XenServer','Oracle Enterprise Linux 5.2 (32-bit)',20,'default','b010de6e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(41,'XenServer','Oracle Enterprise Linux 5.2 (64-bit)',21,'default','b010debe-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(42,'XenServer','Oracle Enterprise Linux 5.3 (32-bit)',22,'default','b010df18-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(43,'XenServer','Oracle Enterprise Linux 5.3 (64-bit)',23,'default','b010df68-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(44,'XenServer','Oracle Enterprise Linux 5.4 (32-bit)',24,'default','b010dfc2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(45,'XenServer','Oracle Enterprise Linux 5.4 (64-bit)',25,'default','b010e012-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(46,'XenServer','Red Hat Enterprise Linux 4.5 (32-bit)',26,'default','b010e06c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(47,'XenServer','Red Hat Enterprise Linux 4.6 (32-bit)',27,'default','b010e0c6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(48,'XenServer','Red Hat Enterprise Linux 4.7 (32-bit)',28,'default','b010e116-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(49,'XenServer','Red Hat Enterprise Linux 4.8 (32-bit)',29,'default','b010e170-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(50,'XenServer','Red Hat Enterprise Linux 5.0 (32-bit)',30,'default','b010e1c0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(51,'XenServer','Red Hat Enterprise Linux 5.0 (64-bit)',31,'default','b010e21a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(52,'XenServer','Red Hat Enterprise Linux 5.1 (32-bit)',32,'default','b010e26a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(53,'XenServer','Red Hat Enterprise Linux 5.1 (64-bit)',33,'default','b010e2ba-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(54,'XenServer','Red Hat Enterprise Linux 5.2 (32-bit)',34,'default','b010eada-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(55,'XenServer','Red Hat Enterprise Linux 5.2 (64-bit)',35,'default','b010eb66-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(56,'XenServer','Red Hat Enterprise Linux 5.3 (32-bit)',36,'default','b010ebc0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(57,'XenServer','Red Hat Enterprise Linux 5.3 (64-bit)',37,'default','b010ec10-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(58,'XenServer','Red Hat Enterprise Linux 5.4 (32-bit)',38,'default','b010ec6a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(59,'XenServer','Red Hat Enterprise Linux 5.4 (64-bit)',39,'default','b010ecba-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(60,'XenServer','SUSE Linux Enterprise Server 9 SP4 (32-bit)',40,'default','b010ed14-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(61,'XenServer','SUSE Linux Enterprise Server 10 SP1 (32-bit)',41,'default','b010ed6e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(62,'XenServer','SUSE Linux Enterprise Server 10 SP1 (64-bit)',42,'default','b010edbe-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(63,'XenServer','SUSE Linux Enterprise Server 10 SP2 (32-bit)',43,'default','b010ee18-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(64,'XenServer','SUSE Linux Enterprise Server 10 SP2 (64-bit)',44,'default','b010ee68-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(65,'XenServer','SUSE Linux Enterprise Server 10 SP3 (64-bit)',45,'default','b010eeb8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(66,'XenServer','SUSE Linux Enterprise Server 11 (32-bit)',46,'default','b010ef12-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(67,'XenServer','SUSE Linux Enterprise Server 11 (64-bit)',47,'default','b010ef62-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(68,'XenServer','Windows 7 (32-bit)',48,'default','b010efbc-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(69,'XenServer','Windows 7 (64-bit)',49,'default','b010f00c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(70,'XenServer','Windows Server 2003 (32-bit)',50,'default','b010f066-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(71,'XenServer','Windows Server 2003 (64-bit)',51,'default','b010f0c0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(72,'XenServer','Windows Server 2008 (32-bit)',52,'default','b010f110-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(73,'XenServer','Windows Server 2008 (64-bit)',53,'default','b010f160-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(74,'XenServer','Windows Server 2008 R2 (64-bit)',54,'default','b010f1ba-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(75,'XenServer','Windows 2000 SP4 (32-bit)',55,'default','b010f20a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(76,'XenServer','Windows Vista (32-bit)',56,'default','b010f264-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(77,'XenServer','Windows XP SP2 (32-bit)',57,'default','b010f2b4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(78,'XenServer','Windows XP SP3 (32-bit)',58,'default','b010f30e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(79,'XenServer','Other install media',59,'default','b010f43a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(80,'XenServer','Other install media',100,'default','b010f494-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(81,'XenServer','Other install media',60,'default','b010f4e4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(82,'XenServer','Other install media',103,'default','b010fc96-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(83,'XenServer','Other install media',121,'default','b010fcf0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(84,'XenServer','Other install media',126,'default','b010fd40-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(85,'XenServer','Other install media',122,'default','b010fd9a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(86,'XenServer','Other install media',127,'default','b010fdea-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(87,'XenServer','Other install media',123,'default','b010fe3a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(88,'XenServer','Other install media',128,'default','b010fe94-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(89,'XenServer','Other install media',124,'default','b010feee-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(90,'XenServer','Other install media',129,'default','b010ff52-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(91,'XenServer','Other install media',125,'default','b010ffac-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(92,'XenServer','Other install media',130,'default','b010fffc-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(93,'XenServer','Other PV (32-bit)',139,'default','b0110056-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(94,'XenServer','Other PV (64-bit)',140,'default','b01100b0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(95,'XenServer','Windows 8 (32-bit)',165,'default','b011010a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(96,'XenServer','Windows 8 (64-bit)',166,'default','b0110164-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(97,'XenServer','Windows Server 2012 (64-bit)',167,'default','b01101b4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(99,'VmWare','Microsoft Windows 7(32-bit)',48,'default','b011059c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(100,'VmWare','Microsoft Windows 7(64-bit)',49,'default','b0110862-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(101,'VmWare','Microsoft Windows Server 2008 R2(64-bit)',54,'default','b01108d0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(102,'VmWare','Microsoft Windows Server 2008(32-bit)',52,'default','b011092a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(103,'VmWare','Microsoft Windows Server 2008(64-bit)',53,'default','b0110a10-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(104,'VmWare','Microsoft Windows Server 2003, Enterprise Edition (32-bit)',50,'default','b0110a74-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(105,'VmWare','Microsoft Windows Server 2003, Enterprise Edition (64-bit)',51,'default','b0110ace-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(106,'VmWare','Microsoft Windows Server 2003, Datacenter Edition (32-bit)',87,'default','b0110d3a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(107,'VmWare','Microsoft Windows Server 2003, Datacenter Edition (64-bit)',88,'default','b0110d94-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(108,'VmWare','Microsoft Windows Server 2003, Standard Edition (32-bit)',89,'default','b0110dee-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(109,'VmWare','Microsoft Windows Server 2003, Standard Edition (64-bit)',90,'default','b0110e3e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(110,'VmWare','Microsoft Windows Server 2003, Web Edition',91,'default','b0111046-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(111,'VmWare','Microsoft Small Bussiness Server 2003',92,'default','b01118c0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(112,'VmWare','Microsoft Windows Vista (32-bit)',56,'default','b0111938-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(113,'VmWare','Microsoft Windows Vista (64-bit)',101,'default','b0111c12-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(114,'VmWare','Microsoft Windows XP Professional (32-bit)',93,'default','b0111c8a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(115,'VmWare','Microsoft Windows XP Professional (32-bit)',57,'default','b0111e7e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(116,'VmWare','Microsoft Windows XP Professional (32-bit)',58,'default','b0111eec-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(117,'VmWare','Microsoft Windows XP Professional (64-bit)',94,'default','b01120d6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(118,'VmWare','Microsoft Windows 2000 Advanced Server',95,'default','b01122c0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(119,'VmWare','Microsoft Windows 2000 Server',61,'default','b0112504-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(120,'VmWare','Microsoft Windows 2000 Professional',105,'default','b0112ca2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(121,'VmWare','Microsoft Windows 2000 Server',55,'default','b0112d10-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(122,'VmWare','Microsoft Windows 98',62,'default','b0112d6a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(123,'VmWare','Microsoft Windows 95',63,'default','b0112dc4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(124,'VmWare','Microsoft Windows NT 4',64,'default','b0112e14-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(125,'VmWare','Microsoft Windows 3.1',65,'default','b0112ea0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(126,'VmWare','Windows 8 (32-bit)',165,'default','b0112efa-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(127,'VmWare','Windows 8 (64-bit)',166,'default','b0112f54-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(128,'VmWare','Windows Server 2012 (64-bit)',167,'default','b0112fa4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(130,'VmWare','Red Hat Enterprise Linux 5.0(32-bit)',30,'default','b0112ffe-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(131,'VmWare','Red Hat Enterprise Linux 5.1(32-bit)',32,'default','b0113058-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(132,'VmWare','Red Hat Enterprise Linux 5.2(32-bit)',34,'default','b01130b2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(133,'VmWare','Red Hat Enterprise Linux 5.3(32-bit)',36,'default','b011310c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(134,'VmWare','Red Hat Enterprise Linux 5.4(32-bit)',38,'default','b0113166-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(135,'VmWare','Red Hat Enterprise Linux 5.0(64-bit)',31,'default','b01131c0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(136,'VmWare','Red Hat Enterprise Linux 5.1(64-bit)',33,'default','b011321a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(137,'VmWare','Red Hat Enterprise Linux 5.2(64-bit)',35,'default','b0113274-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(138,'VmWare','Red Hat Enterprise Linux 5.3(64-bit)',37,'default','b01132c4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(139,'VmWare','Red Hat Enterprise Linux 5.4(64-bit)',39,'default','b011331e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(140,'VmWare','Red Hat Enterprise Linux 4.5(32-bit)',26,'default','b0114d7c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(141,'VmWare','Red Hat Enterprise Linux 4.6(32-bit)',27,'default','b0114eda-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(142,'VmWare','Red Hat Enterprise Linux 4.7(32-bit)',28,'default','b0114ffc-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(143,'VmWare','Red Hat Enterprise Linux 4.8(32-bit)',29,'default','b0115100-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(144,'VmWare','Red Hat Enterprise Linux 4(64-bit)',106,'default','b0115268-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(145,'VmWare','Red Hat Enterprise Linux 3(32-bit)',66,'default','b01154ac-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(146,'VmWare','Red Hat Enterprise Linux 3(64-bit)',67,'default','b011556a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(147,'VmWare','Red Hat Enterprise Linux 2',131,'default','b01155c4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(148,'VmWare','Red Hat Enterprise Linux 6(32-bit)',136,'default','b011561e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(149,'VmWare','Red Hat Enterprise Linux 6(64-bit)',137,'default','b0115678-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(150,'VmWare','Suse Linux Enterprise 11(32-bit)',46,'default','b01156d2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(151,'VmWare','Suse Linux Enterprise 11(64-bit)',47,'default','b0115768-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(152,'VmWare','Suse Linux Enterprise 10(32-bit)',41,'default','b01157c2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(153,'VmWare','Suse Linux Enterprise 10(32-bit)',43,'default','b011581c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(154,'VmWare','Suse Linux Enterprise 10(64-bit)',42,'default','b0115876-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(155,'VmWare','Suse Linux Enterprise 10(64-bit)',44,'default','b01158c6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(156,'VmWare','Suse Linux Enterprise 10(64-bit)',45,'default','b0115920-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(157,'VmWare','Suse Linux Enterprise 10(32-bit)',109,'default','b011597a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(158,'VmWare','Suse Linux Enterprise 10(64-bit)',110,'default','b01159ca-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(159,'VmWare','Suse Linux Enterprise 8/9(32-bit)',40,'default','b0115a24-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(160,'VmWare','Suse Linux Enterprise 8/9(32-bit)',96,'default','b0115a7e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(161,'VmWare','Suse Linux Enterprise 8/9(64-bit)',97,'default','b0115ad8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(162,'VmWare','Suse Linux Enterprise 8/9(32-bit)',107,'default','b0115b28-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(163,'VmWare','Suse Linux Enterprise 8/9(64-bit)',108,'default','b0115b82-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(164,'VmWare','Other Suse Linux Enterprise(32-bit)',202,'default','b0115bdc-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(165,'VmWare','Other Suse Linux Enterprise(64-bit)',203,'default','b0115c2c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(166,'VmWare','Open Enterprise Server',68,'default','b0115c86-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(167,'VmWare','Asianux 3(32-bit)',69,'default','b0115ce0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(168,'VmWare','Asianux 3(64-bit)',70,'default','b0115d3a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(169,'VmWare','Debian GNU/Linux 5(32-bit)',15,'default','b0115d8a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(170,'VmWare','Debian GNU/Linux 5(64-bit)',72,'default','b0115de4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(171,'VmWare','Debian GNU/Linux 4(32-bit)',73,'default','b0115e3e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(172,'VmWare','Debian GNU/Linux 4(64-bit)',74,'default','b0115e98-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(173,'VmWare','Ubuntu 12.04 (32-bit)',162,'default','b0115ee8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(174,'VmWare','Ubuntu 10.04 (32-bit)',121,'default','b0115f42-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(175,'VmWare','Ubuntu 9.10 (32-bit)',122,'default','b0115f9c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(176,'VmWare','Ubuntu 9.04 (32-bit)',123,'default','b0115fec-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(177,'VmWare','Ubuntu 8.10 (32-bit)',124,'default','b01161ae-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(178,'VmWare','Ubuntu 8.04 (32-bit)',125,'default','b0116212-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(179,'VmWare','Ubuntu 12.04 (64-bit)',163,'default','b0116262-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(180,'VmWare','Ubuntu 10.04 (64-bit)',126,'default','b01162bc-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(181,'VmWare','Ubuntu 9.10 (64-bit)',127,'default','b0116d8e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(182,'VmWare','Ubuntu 9.04 (64-bit)',128,'default','b0116df2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(183,'VmWare','Ubuntu 8.10 (64-bit)',129,'default','b0116e42-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(184,'VmWare','Ubuntu 8.04 (64-bit)',130,'default','b0116ea6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(185,'VmWare','Ubuntu 10.10 (32-bit)',59,'default','b0116f00-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(186,'VmWare','Ubuntu 10.10 (64-bit)',100,'default','b0116f5a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(187,'VmWare','Other Ubuntu Linux (32-bit)',59,'default','b0116faa-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(188,'VmWare','Other Ubuntu (64-bit)',100,'default','b011700e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(189,'VmWare','Other 2.6x Linux (32-bit)',75,'default','b01170a4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(190,'VmWare','Other 2.6x Linux (64-bit)',76,'default','b0117126-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(191,'VmWare','Other Linux (32-bit)',98,'default','b011719e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(192,'VmWare','Other Linux (64-bit)',99,'default','b0117252-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(193,'VmWare','Novell Netware 6.x',77,'default','b01172de-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(194,'VmWare','Novell Netware 5.1',78,'default','b0117360-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(195,'VmWare','Sun Solaris 10(32-bit)',79,'default','b01173e2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(196,'VmWare','Sun Solaris 10(64-bit)',80,'default','b0117464-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(197,'VmWare','Sun Solaris 9(Experimental)',81,'default','b01174e6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(198,'VmWare','Sun Solaris 8(Experimental)',82,'default','b0117568-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(199,'VmWare','FreeBSD (32-bit)',83,'default','b01175e0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(200,'VmWare','FreeBSD (64-bit)',84,'default','b0117662-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(201,'VmWare','OS/2',104,'default','b01179dc-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(202,'VmWare','SCO OpenServer 5',85,'default','b0117a5e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(203,'VmWare','SCO UnixWare 7',86,'default','b0117ae0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(204,'VmWare','DOS',102,'default','b0117b62-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(205,'VmWare','Other (32-bit)',60,'default','b0117be4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(206,'VmWare','Other (64-bit)',103,'default','b0117c66-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(207,'VmWare','CentOS (32-bit)',200,'default','b0117ce8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(208,'VmWare','CentOS (64-bit)',201,'default','b0117d6a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(209,'KVM','CentOS 4.5',1,'default','b0117dec-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(210,'KVM','CentOS 4.6',2,'default','b0117e6e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(211,'KVM','CentOS 4.7',3,'default','b0117ef0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(212,'KVM','CentOS 4.8',4,'default','b0117f68-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(213,'KVM','CentOS 5.0',5,'default','b0117fea-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(214,'KVM','CentOS 5.0',6,'default','b011806c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(215,'KVM','CentOS 5.1',7,'default','b01180f8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(216,'KVM','CentOS 5.1',8,'default','b0118170-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(217,'KVM','CentOS 5.2',9,'default','b01181f2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(218,'KVM','CentOS 5.2',10,'default','b0118274-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(219,'KVM','CentOS 5.3',11,'default','b01182f6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(220,'KVM','CentOS 5.3',12,'default','b0118378-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(221,'KVM','CentOS 5.4',13,'default','b01183fa-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(222,'KVM','CentOS 5.4',14,'default','b0118ae4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(223,'KVM','CentOS 5.5',111,'default','b0118ae5-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(224,'KVM','CentOS 5.5',112,'default','b0118fb2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(225,'KVM','Red Hat Enterprise Linux 4.5',26,'default','b0119110-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(226,'KVM','Red Hat Enterprise Linux 4.6',27,'default','b0119214-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(227,'KVM','Red Hat Enterprise Linux 4.7',28,'default','b011930e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(228,'KVM','Red Hat Enterprise Linux 4.8',29,'default','b01193b8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(229,'KVM','Red Hat Enterprise Linux 5.0',30,'default','b0119458-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(230,'KVM','Red Hat Enterprise Linux 5.0',31,'default','b01194e4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(231,'KVM','Red Hat Enterprise Linux 5.1',32,'default','b011957a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(232,'KVM','Red Hat Enterprise Linux 5.1',33,'default','b011961a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(233,'KVM','Red Hat Enterprise Linux 5.2',34,'default','b01196b0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(234,'KVM','Red Hat Enterprise Linux 5.2',35,'default','b0119750-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(235,'KVM','Red Hat Enterprise Linux 5.3',36,'default','b01197f0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(236,'KVM','Red Hat Enterprise Linux 5.3',37,'default','b01198a4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(237,'KVM','Red Hat Enterprise Linux 5.4',38,'default','b011994e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(238,'KVM','Red Hat Enterprise Linux 5.4',39,'default','b01199e4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(239,'KVM','Red Hat Enterprise Linux 5.5',113,'default','b0119a84-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(240,'KVM','Red Hat Enterprise Linux 5.5',114,'default','b0119b24-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(241,'KVM','Red Hat Enterprise Linux 4',106,'default','b0119bc4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(242,'KVM','Red Hat Enterprise Linux 3',66,'default','b0119c64-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(243,'KVM','Red Hat Enterprise Linux 3',67,'default','b0119d04-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(244,'KVM','Red Hat Enterprise Linux 2',131,'default','b0119dae-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(245,'KVM','Fedora 13',115,'default','b0119e44-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(246,'KVM','Fedora 12',116,'default','b0119ee4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(247,'KVM','Fedora 11',117,'default','b0119f84-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(248,'KVM','Fedora 10',118,'default','b011b5aa-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(249,'KVM','Fedora 9',119,'default','b011b794-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(250,'KVM','Fedora 8',120,'default','b011b94c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(251,'KVM','Ubuntu 10.04',121,'default','b011bac8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(252,'KVM','Ubuntu 10.04',126,'default','b011bc30-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(253,'KVM','Ubuntu 10.04',162,'default','b011bd84-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(254,'KVM','Ubuntu 10.04',163,'default','b011bed8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(255,'KVM','Ubuntu 9.10',122,'default','b011c022-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(256,'KVM','Ubuntu 9.10',127,'default','b011c162-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(257,'KVM','Ubuntu 9.04',123,'default','b011c2a2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(258,'KVM','Ubuntu 9.04',128,'default','b011c3d8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(259,'KVM','Ubuntu 8.10',124,'default','b011c518-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(260,'KVM','Ubuntu 8.10',129,'default','b011c644-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(261,'KVM','Ubuntu 8.04',125,'default','b011c752-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(262,'KVM','Ubuntu 8.04',130,'default','b011c860-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(263,'KVM','Debian GNU/Linux 5',15,'default','b011d17a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(264,'KVM','Debian GNU/Linux 5',72,'default','b011d238-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(265,'KVM','Debian GNU/Linux 4',73,'default','b011d29c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(266,'KVM','Debian GNU/Linux 4',74,'default','b011d2f6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(267,'KVM','Other Linux 2.6x',75,'default','b011d35a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(268,'KVM','Other Linux 2.6x',76,'default','b011d3b4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(269,'KVM','Other Ubuntu',59,'default','b011d40e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(270,'KVM','Other Ubuntu',100,'default','b011d472-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(271,'KVM','Other Linux',98,'default','b011d4cc-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(272,'KVM','Other Linux',99,'default','b011d526-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(273,'KVM','Windows 7',48,'default','b011d58a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(274,'KVM','Windows 7',49,'default','b011d5e4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(275,'KVM','Windows Server 2003',50,'default','b011d63e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(276,'KVM','Windows Server 2003',51,'default','b011d698-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(277,'KVM','Windows Server 2003',87,'default','b011d8c8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(278,'KVM','Windows Server 2003',88,'default','b011db02-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(279,'KVM','Windows Server 2003',89,'default','b011db98-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(280,'KVM','Windows Server 2003',90,'default','b011dbfc-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(281,'KVM','Windows Server 2003',91,'default','b011dc56-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(282,'KVM','Windows Server 2003',92,'default','b011dcba-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(283,'KVM','Windows Server 2008',52,'default','b011dd1e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(284,'KVM','Windows Server 2008',53,'default','b011dd78-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(285,'KVM','Windows 2000',55,'default','b011dddc-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(286,'KVM','Windows 2000',61,'default','b011e1b0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(287,'KVM','Windows 2000',95,'default','b011e228-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(288,'KVM','Windows 98',62,'default','b011e28c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(289,'KVM','Windows Vista',56,'default','b011e2e6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(290,'KVM','Windows Vista',101,'default','b011e340-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(291,'KVM','Windows XP SP2',57,'default','b011e3a4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(292,'KVM','Windows XP SP3',58,'default','b011e408-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(293,'KVM','Windows XP ',93,'default','b011e462-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(294,'KVM','Windows XP ',94,'default','b011e610-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(295,'KVM','DOS',102,'default','b011e67e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(296,'KVM','Other',60,'default','b011e6e2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(297,'KVM','Other',103,'default','b011e73c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(298,'VmWare','Windows 8 (32-bit)',165,'default','b011e796-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(299,'VmWare','Windows 8 (64-bit)',166,'default','b011e7fa-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(300,'VmWare','Windows Server 2012 (64-bit)',167,'default','b011e854-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(302,'XenServer','Windows 8 (32-bit)',165,'default','b011e976-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(303,'XenServer','Windows 8 (64-bit)',166,'default','b011eab6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(304,'XenServer','Windows Server 2012 (64-bit)',167,'default','b011ee44-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(306,'XenServer','CentOS 5.5 (32-bit)',111,'default','b011f204-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(307,'XenServer','CentOS 5.5 (64-bit)',112,'default','b011f268-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(308,'XenServer','CentOS 5.6 (32-bit)',141,'default','b011f2c2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(309,'XenServer','CentOS 5.6 (64-bit)',142,'default','b011f31c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(310,'XenServer','CentOS 5.7 (32-bit)',161,'default','b011f380-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(311,'XenServer','CentOS 5.7 (64-bit)',162,'default','b011f3da-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(312,'XenServer','CentOS 5.8 (32-bit)',173,'default','b011f434-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(313,'XenServer','CentOS 5.8 (64-bit)',174,'default','b011f48e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(314,'XenServer','CentOS 5.9 (32-bit)',175,'default','b011f4e8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(315,'XenServer','CentOS 5.9 (64-bit)',176,'default','b011f754-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(316,'XenServer','CentOS 6.0 (32-bit)',143,'default','b011f7ae-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(317,'XenServer','CentOS 6.0 (64-bit)',144,'default','b011f808-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(318,'XenServer','CentOS 6.1 (32-bit)',177,'default','b011f862-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(319,'XenServer','CentOS 6.1 (64-bit)',178,'default','b011f8c6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(320,'XenServer','CentOS 6.2 (32-bit)',179,'default','b011f916-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(321,'XenServer','CentOS 6.2 (64-bit)',180,'default','b011f97a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(322,'XenServer','CentOS 6.3 (32-bit)',171,'default','b011fb96-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(323,'XenServer','CentOS 6.3 (64-bit)',172,'default','b011fbf0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(324,'XenServer','CentOS 6.4 (32-bit)',181,'default','b011fcb8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(325,'XenServer','CentOS 6.4 (64-bit)',182,'default','b011fd30-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(326,'XenServer','Debian GNU/Linux 7(32-bit)',183,'default','b011fe98-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(327,'XenServer','Debian GNU/Linux 7(64-bit)',184,'default','b011fe99-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(328,'VmWare','Apple Mac OS X 10.6 (32-bit)',221,'default','b011fe9a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(329,'VmWare','Apple Mac OS X 10.6 (64-bit)',222,'default','b011fe9b-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(330,'VmWare','Apple Mac OS X 10.7 (32-bit)',223,'default','b011fe9c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(331,'VmWare','Apple Mac OS X 10.7 (64-bit)',224,'default','b011fe9d-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(332,'XenServer','Windows Server 2012 R2 (64-bit)',168,'default','b011fe9e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(333,'VmWare','Windows Server 2012 R2 (64-bit)',168,'default','b011fe9f-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(334,'XenServer','Windows 8.1 (64-bit)',229,'default','b011fef2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(335,'VmWare','Windows 8.1 (64-bit)',229,'default','b01203ac-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(336,'XenServer','Windows 8.1 (32-bit)',230,'default','b012041a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(337,'VmWare','Windows 8.1 (32-bit)',230,'default','b012046a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(338,'XenServer','CentOS 6.5 (32-bit)',227,'default','b01204ce-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(339,'VmWare','CentOS 6.5 (32-bit)',227,'default','b0120550-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(340,'VmWare','CentOS 6.5 (64-bit)',228,'default','b012060e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(341,'XenServer','CentOS 6.5 (64-bit)',228,'default','b0120668-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(342,'Xenserver','CentOS 4.5 (32-bit)',1,'XCP 1.0','b0230b48-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(343,'Xenserver','CentOS 4.6 (32-bit)',2,'XCP 1.0','b0231e6c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(344,'Xenserver','CentOS 4.7 (32-bit)',3,'XCP 1.0','b02330aa-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(345,'Xenserver','CentOS 4.8 (32-bit)',4,'XCP 1.0','b023409a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(346,'Xenserver','CentOS 5 (32-bit)',5,'XCP 1.0','b023529c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(347,'Xenserver','CentOS 5 (64-bit)',6,'XCP 1.0','b023643a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(348,'Xenserver','CentOS 5 (32-bit)',7,'XCP 1.0','b0237592-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(349,'Xenserver','CentOS 5 (64-bit)',8,'XCP 1.0','b0238528-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(350,'Xenserver','CentOS 5 (32-bit)',9,'XCP 1.0','b02395f4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(351,'Xenserver','CentOS 5 (64-bit)',10,'XCP 1.0','b023a51c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(352,'Xenserver','CentOS 5 (32-bit)',11,'XCP 1.0','b023b3cc-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(353,'Xenserver','CentOS 5 (64-bit)',12,'XCP 1.0','b023c538-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(354,'Xenserver','CentOS 5 (32-bit)',13,'XCP 1.0','b023d5a0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(355,'Xenserver','CentOS 5 (64-bit)',14,'XCP 1.0','b023e310-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(356,'Xenserver','CentOS 5 (32-bit)',111,'XCP 1.0','b023f12a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(357,'Xenserver','CentOS 5 (64-bit)',112,'XCP 1.0','b023f9f4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(358,'Xenserver','Debian Lenny 5.0 (32-bit)',15,'XCP 1.0','b024049e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(359,'Xenserver','Debian Squeeze 6.0 (32-bit)',132,'XCP 1.0','b02410a6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(360,'Xenserver','Debian Squeeze 6.0 (64-bit) (experimental)',133,'XCP 1.0','b0241e70-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(361,'Xenserver','Debian Squeeze 6.0 (32-bit)',183,'XCP 1.0','b0242b4a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(362,'Xenserver','Debian Squeeze 6.0 (64-bit) (experimental)',184,'XCP 1.0','b024378e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(363,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',16,'XCP 1.0','b02443a0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(364,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',17,'XCP 1.0','b0244e2c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(365,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',18,'XCP 1.0','b02458cc-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(366,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',19,'XCP 1.0','b024645c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(367,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',20,'XCP 1.0','b0247050-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(368,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',21,'XCP 1.0','b0247f0a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(369,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',22,'XCP 1.0','b0248a22-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(370,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',23,'XCP 1.0','b0249472-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(371,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',24,'XCP 1.0','b0249ed6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(372,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',25,'XCP 1.0','b024a9c6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(373,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',134,'XCP 1.0','b024b4ac-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(374,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',135,'XCP 1.0','b024bd44-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(375,'Xenserver','Red Hat Enterprise Linux 4.5 (32-bit)',26,'XCP 1.0','b024c4b0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(376,'Xenserver','Red Hat Enterprise Linux 4.6 (32-bit)',27,'XCP 1.0','b024cea6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(377,'Xenserver','Red Hat Enterprise Linux 4.7 (32-bit)',28,'XCP 1.0','b024d766-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(378,'Xenserver','Red Hat Enterprise Linux 4.8 (32-bit)',29,'XCP 1.0','b024e346-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(379,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',30,'XCP 1.0','b024ecf6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(380,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',31,'XCP 1.0','b024f8d6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(381,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',32,'XCP 1.0','b0250344-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(382,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',33,'XCP 1.0','b0250d30-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(383,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',34,'XCP 1.0','b0251708-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(384,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',35,'XCP 1.0','b0252220-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(385,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',36,'XCP 1.0','b0252b6c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(386,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',37,'XCP 1.0','b0253512-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(387,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',38,'XCP 1.0','b0255a88-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(388,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',39,'XCP 1.0','b0256550-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(389,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',113,'XCP 1.0','b0257068-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(390,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',114,'XCP 1.0','b02579c8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(391,'Xenserver','Red Hat Enterprise Linux 6 (32-bit)',136,'XCP 1.0','b0258422-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(392,'Xenserver','Red Hat Enterprise Linux 6 (64-bit)',137,'XCP 1.0','b0258fa8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(393,'Xenserver','SUSE Linux Enterprise Server 9 SP4',40,'XCP 1.0','b025a006-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(394,'Xenserver','SUSE Linux Enterprise Server 10 SP1',41,'XCP 1.0','b025abe6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(395,'Xenserver','SUSE Linux Enterprise Server 10 SP1 x64',42,'XCP 1.0','b025b5aa-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(396,'Xenserver','SUSE Linux Enterprise Server 10 SP2',43,'XCP 1.0','b025bfb4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(397,'Xenserver','SUSE Linux Enterprise Server 10 SP2 x64',44,'XCP 1.0','b025c806-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(398,'Xenserver','Other install media',45,'XCP 1.0','b025d4c2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(399,'Xenserver','SUSE Linux Enterprise Server 11',46,'XCP 1.0','b025dde6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(400,'Xenserver','SUSE Linux Enterprise Server 11 x64',47,'XCP 1.0','b025ea52-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(401,'Xenserver','SUSE Linux Enterprise Server 11 SP1 (32-bit)',155,'XCP 1.0','b025f4a2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(402,'Xenserver','SUSE Linux Enterprise Server 11 SP1 (64-bit)',154,'XCP 1.0','b025ff24-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(403,'Xenserver','Windows 7 (32-bit)',48,'XCP 1.0','b0260848-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(404,'Xenserver','Windows 7 (64-bit)',49,'XCP 1.0','b026107c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(405,'Xenserver','Windows Server 2003 (32-bit)',50,'XCP 1.0','b0261aea-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(406,'Xenserver','Windows Server 2003 (64-bit)',51,'XCP 1.0','b026277e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(407,'Xenserver','Windows Server 2003 (32-bit)',87,'XCP 1.0','b02632dc-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(408,'Xenserver','Windows Server 2003 (64-bit)',88,'XCP 1.0','b0263c96-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(409,'Xenserver','Windows Server 2003 (32-bit)',89,'XCP 1.0','b0264678-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(410,'Xenserver','Windows Server 2003 (64-bit)',90,'XCP 1.0','b02653fc-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(411,'Xenserver','Windows Server 2008 (32-bit)',52,'XCP 1.0','b02664c8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(412,'Xenserver','Windows Server 2008 (64-bit)',53,'XCP 1.0','b0266e00-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(413,'Xenserver','Windows Server 2008 R2 (64-bit)',54,'XCP 1.0','b0267620-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(414,'Xenserver','Windows XP SP3 (32-bit)',58,'XCP 1.0','b026826e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(415,'Xenserver','Windows Vista (32-bit)',56,'XCP 1.0','b0268b92-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(416,'Xenserver','Ubuntu Lucid Lynx 10.04 (32-bit) (experimental)',121,'XCP 1.0','b02697d6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(417,'Xenserver','Ubuntu Lucid Lynx 10.04 (64-bit) (experimental)',126,'XCP 1.0','b0269fe2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(418,'Xenserver','Other install media',98,'XCP 1.0','b026a8b6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(419,'Xenserver','Other install media',99,'XCP 1.0','b026b57c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(420,'Xenserver','CentOS 5 (32-bit)',139,'XCP 1.0','b026bedc-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(421,'Xenserver','CentOS 5 (64-bit)',140,'XCP 1.0','b026c706-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(422,'Xenserver','CentOS 4.5 (32-bit)',1,'5.6 FP1','b026d106-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(423,'Xenserver','CentOS 4.6 (32-bit)',2,'5.6 FP1','b026dbe2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(424,'Xenserver','CentOS 4.7 (32-bit)',3,'5.6 FP1','b026e6b4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(425,'Xenserver','CentOS 4.8 (32-bit)',4,'5.6 FP1','b026f30c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(426,'Xenserver','CentOS 5 (32-bit)',5,'5.6 FP1','b026fe7e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(427,'Xenserver','CentOS 5 (64-bit)',6,'5.6 FP1','b0270734-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(428,'Xenserver','CentOS 5 (32-bit)',7,'5.6 FP1','b02713f0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(429,'Xenserver','CentOS 5 (64-bit)',8,'5.6 FP1','b0271e9a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(430,'Xenserver','CentOS 5 (32-bit)',9,'5.6 FP1','b0272b24-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(431,'Xenserver','CentOS 5 (64-bit)',10,'5.6 FP1','b02734c0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(432,'Xenserver','CentOS 5 (32-bit)',11,'5.6 FP1','b0273d58-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(433,'Xenserver','CentOS 5 (64-bit)',12,'5.6 FP1','b0274ad2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(434,'Xenserver','CentOS 5 (32-bit)',13,'5.6 FP1','b027540a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(435,'Xenserver','CentOS 5 (64-bit)',14,'5.6 FP1','b0275ee6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(436,'Xenserver','CentOS 5 (32-bit)',111,'5.6 FP1','b0276ae4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(437,'Xenserver','CentOS 5 (64-bit)',112,'5.6 FP1','b027764c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(438,'Xenserver','Debian Lenny 5.0 (32-bit)',15,'5.6 FP1','b0277f8e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(439,'Xenserver','Debian Squeeze 6.0 (32-bit)',132,'5.6 FP1','b0278b82-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(440,'Xenserver','Debian Squeeze 6.0 (64-bit) (experimental)',133,'5.6 FP1','b027a036-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(441,'Xenserver','Debian Squeeze 6.0 (32-bit)',183,'5.6 FP1','b027ab94-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(442,'Xenserver','Debian Squeeze 6.0 (64-bit) (experimental)',184,'5.6 FP1','b027b8b4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(443,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',16,'5.6 FP1','b027cdcc-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(444,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',17,'5.6 FP1','b027db96-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(445,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',18,'5.6 FP1','b027e7e4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(446,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',19,'5.6 FP1','b027f194-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(447,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',20,'5.6 FP1','b027fd88-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(448,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',21,'5.6 FP1','b0280a4e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(449,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',22,'5.6 FP1','b028158e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(450,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',23,'5.6 FP1','b02821e6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(451,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',24,'5.6 FP1','b0282e48-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(452,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',25,'5.6 FP1','b0283a28-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(453,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',134,'5.6 FP1','b02847d4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(454,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',135,'5.6 FP1','b02853e6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(455,'Xenserver','Red Hat Enterprise Linux 4.5 (32-bit)',26,'5.6 FP1','b0286048-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(456,'Xenserver','Red Hat Enterprise Linux 4.6 (32-bit)',27,'5.6 FP1','b0286b74-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(457,'Xenserver','Red Hat Enterprise Linux 4.7 (32-bit)',28,'5.6 FP1','b028783a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(458,'Xenserver','Red Hat Enterprise Linux 4.8 (32-bit)',29,'5.6 FP1','b0288636-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(459,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',30,'5.6 FP1','b0289c70-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(460,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',31,'5.6 FP1','b028b52a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(461,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',32,'5.6 FP1','b028c31c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(462,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',33,'5.6 FP1','b028ceac-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(463,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',34,'5.6 FP1','b028d7da-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(464,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',35,'5.6 FP1','b028e2b6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(465,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',36,'5.6 FP1','b028ed88-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(466,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',37,'5.6 FP1','b028f954-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(467,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',38,'5.6 FP1','b02903fe-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(468,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',39,'5.6 FP1','b0291024-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(469,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',113,'5.6 FP1','b0291c0e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(470,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',114,'5.6 FP1','b02927da-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(471,'Xenserver','Red Hat Enterprise Linux 6 (32-bit) (experimental)',136,'5.6 FP1','b029331a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(472,'Xenserver','Red Hat Enterprise Linux 6 (64-bit) (experimental)',137,'5.6 FP1','b0293f04-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(473,'Xenserver','SUSE Linux Enterprise Server 9 SP4 (32-bit)',40,'5.6 FP1','b0294cb0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(474,'Xenserver','SUSE Linux Enterprise Server 10 SP1 (32-bit)',41,'5.6 FP1','b0295570-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(475,'Xenserver','SUSE Linux Enterprise Server 10 SP1 (64-bit)',42,'5.6 FP1','b0295fe8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(476,'Xenserver','SUSE Linux Enterprise Server 10 SP2 (32-bit)',43,'5.6 FP1','b0296b1e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(477,'Xenserver','SUSE Linux Enterprise Server 10 SP2 (64-bit)',44,'5.6 FP1','b0297492-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(478,'Xenserver','SUSE Linux Enterprise Server 10 SP3 (64-bit)',45,'5.6 FP1','b0297eec-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(479,'Xenserver','SUSE Linux Enterprise Server 11 (32-bit)',46,'5.6 FP1','b0298982-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(480,'Xenserver','SUSE Linux Enterprise Server 11 (64-bit)',47,'5.6 FP1','b02993aa-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(481,'Xenserver','Windows 7 (32-bit)',48,'5.6 FP1','b0299e72-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(482,'Xenserver','Windows 7 (64-bit)',49,'5.6 FP1','b029aa48-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(483,'Xenserver','Windows Server 2003 (32-bit)',50,'5.6 FP1','b029b59c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(484,'Xenserver','Windows Server 2003 (64-bit)',51,'5.6 FP1','b029c064-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(485,'Xenserver','Windows Server 2003 (32-bit)',87,'5.6 FP1','b029cf5a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(486,'Xenserver','Windows Server 2003 (64-bit)',88,'5.6 FP1','b029dbee-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(487,'Xenserver','Windows Server 2008 (32-bit)',52,'5.6 FP1','b029e620-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(488,'Xenserver','Windows Server 2008 (64-bit)',53,'5.6 FP1','b029f976-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(489,'Xenserver','Windows Server 2008 R2 (64-bit)',54,'5.6 FP1','b02a04b6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(490,'Xenserver','Windows 2000 SP4 (32-bit)',55,'5.6 FP1','b02a0f74-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(491,'Xenserver','Windows Vista (32-bit)',56,'5.6 FP1','b02a1a00-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(492,'Xenserver','Windows XP SP3 (32-bit)',58,'5.6 FP1','b02a245a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(493,'Xenserver','Ubuntu Lucid Lynx 10.04 (32-bit) (experimental)',121,'5.6 FP1','b02a2f7c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(494,'Xenserver','Ubuntu Lucid Lynx 10.04 (64-bit) (experimental)',126,'5.6 FP1','b02a3a4e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(495,'Xenserver','Other install media',98,'5.6 FP1','b02a4516-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(496,'Xenserver','Other install media',99,'5.6 FP1','b02a4f3e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(497,'Xenserver','CentOS 5 (32-bit)',139,'5.6 FP1','b02a59ca-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(498,'Xenserver','CentOS 5 (64-bit)',140,'5.6 FP1','b02a6276-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(499,'Xenserver','CentOS 4.5 (32-bit)',1,'5.6 SP2','b02a6ece-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(500,'Xenserver','CentOS 4.6 (32-bit)',2,'5.6 SP2','b02a7afe-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(501,'Xenserver','CentOS 4.7 (32-bit)',3,'5.6 SP2','b02a86d4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(502,'Xenserver','CentOS 4.8 (32-bit)',4,'5.6 SP2','b02a925a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(503,'Xenserver','CentOS 5 (32-bit)',5,'5.6 SP2','b02a9e6c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(504,'Xenserver','CentOS 5 (64-bit)',6,'5.6 SP2','b02aa9ac-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(505,'Xenserver','CentOS 5 (32-bit)',7,'5.6 SP2','b02ab582-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(506,'Xenserver','CentOS 5 (64-bit)',8,'5.6 SP2','b02ac40a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(507,'Xenserver','CentOS 5 (32-bit)',9,'5.6 SP2','b02acea0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(508,'Xenserver','CentOS 5 (64-bit)',10,'5.6 SP2','b02af254-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(509,'Xenserver','CentOS 5 (32-bit)',11,'5.6 SP2','b02afd44-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(510,'Xenserver','CentOS 5 (64-bit)',12,'5.6 SP2','b02b078a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(511,'Xenserver','CentOS 5 (32-bit)',13,'5.6 SP2','b02b1248-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(512,'Xenserver','CentOS 5 (64-bit)',14,'5.6 SP2','b02b1e00-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:14',NULL,0),(513,'Xenserver','CentOS 5 (32-bit)',111,'5.6 SP2','b02b2850-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(514,'Xenserver','CentOS 5 (64-bit)',112,'5.6 SP2','b02b3232-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(515,'Xenserver','Debian Lenny 5.0 (32-bit)',15,'5.6 SP2','b02b3c1e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(516,'Xenserver','Debian Squeeze 6.0 (32-bit)',132,'5.6 SP2','b02b4448-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(517,'Xenserver','Debian Squeeze 6.0 (64-bit) (experimental)',133,'5.6 SP2','b02b4c4a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(518,'Xenserver','Debian Squeeze 6.0 (32-bit)',183,'5.6 SP2','b02b5686-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(519,'Xenserver','Debian Squeeze 6.0 (64-bit) (experimental)',184,'5.6 SP2','b02b5f50-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(520,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',16,'5.6 SP2','b02b6928-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(521,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',17,'5.6 SP2','b02b72b0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(522,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',18,'5.6 SP2','b02b7fe4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(523,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',19,'5.6 SP2','b02b891c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(524,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',20,'5.6 SP2','b02b9358-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(525,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',21,'5.6 SP2','b02b9cfe-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(526,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',22,'5.6 SP2','b02ba956-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(527,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',23,'5.6 SP2','b02bb2ac-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(528,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',24,'5.6 SP2','b02bbbf8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(529,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',25,'5.6 SP2','b02bc5a8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(530,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',134,'5.6 SP2','b02bce5e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(531,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',135,'5.6 SP2','b02bd6d8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(532,'Xenserver','Red Hat Enterprise Linux 4.5 (32-bit)',26,'5.6 SP2','b02be024-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(533,'Xenserver','Red Hat Enterprise Linux 4.6 (32-bit)',27,'5.6 SP2','b02be812-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(534,'Xenserver','Red Hat Enterprise Linux 4.7 (32-bit)',28,'5.6 SP2','b02bf12c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(535,'Xenserver','Red Hat Enterprise Linux 4.8 (32-bit)',29,'5.6 SP2','b02bfbb8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(536,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',30,'5.6 SP2','b02c064e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(537,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',31,'5.6 SP2','b02c103a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(538,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',32,'5.6 SP2','b02c1a1c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(539,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',33,'5.6 SP2','b02c2c82-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(540,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',34,'5.6 SP2','b02c3682-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(541,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',35,'5.6 SP2','b02c3fa6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(542,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',36,'5.6 SP2','b02c59c8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(543,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',37,'5.6 SP2','b02c66ca-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(544,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',38,'5.6 SP2','b02c7084-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(545,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',39,'5.6 SP2','b02c7962-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(546,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',113,'5.6 SP2','b02c8470-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(547,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',114,'5.6 SP2','b02c8e52-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(548,'Xenserver','Red Hat Enterprise Linux 6 (32-bit)',136,'5.6 SP2','b02c97a8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(549,'Xenserver','Red Hat Enterprise Linux 6 (64-bit)',137,'5.6 SP2','b02ca496-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(550,'Xenserver','SUSE Linux Enterprise Server 9 SP4 (32-bit)',40,'5.6 SP2','b02cae8c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(551,'Xenserver','SUSE Linux Enterprise Server 10 SP1 (32-bit)',41,'5.6 SP2','b02cbdf0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(552,'Xenserver','SUSE Linux Enterprise Server 10 SP1 (64-bit)',42,'5.6 SP2','b02cca0c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(553,'Xenserver','SUSE Linux Enterprise Server 10 SP2 (32-bit)',43,'5.6 SP2','b02cf23e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(554,'Xenserver','SUSE Linux Enterprise Server 10 SP2 (64-bit)',44,'5.6 SP2','b02cfbc6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(555,'Xenserver','SUSE Linux Enterprise Server 10 SP3 (64-bit)',45,'5.6 SP2','b02d0684-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(556,'Xenserver','SUSE Linux Enterprise Server 11 (32-bit)',46,'5.6 SP2','b02d1156-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(557,'Xenserver','SUSE Linux Enterprise Server 11 (64-bit)',47,'5.6 SP2','b02d1dae-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(558,'Xenserver','Windows 7 (32-bit)',48,'5.6 SP2','b02d29ac-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(559,'Xenserver','Windows 7 (64-bit)',49,'5.6 SP2','b02d3596-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(560,'Xenserver','Windows Server 2008 (32-bit)',52,'5.6 SP2','b02d4126-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(561,'Xenserver','Windows Server 2008 (64-bit)',53,'5.6 SP2','b02d4cb6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(562,'Xenserver','Windows Server 2008 R2 (64-bit)',54,'5.6 SP2','b02d57ba-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(563,'Xenserver','Windows Vista (32-bit)',56,'5.6 SP2','b02d62be-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(564,'Xenserver','Windows XP SP3 (32-bit)',58,'5.6 SP2','b02d6cdc-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(565,'Xenserver','Ubuntu Lucid Lynx 10.04 (32-bit) (experimental)',121,'5.6 SP2','b02d7916-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(566,'Xenserver','Ubuntu Lucid Lynx 10.04 (64-bit) (experimental)',126,'5.6 SP2','b02d8758-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(567,'Xenserver','Other install media',98,'5.6 SP2','b02d93ba-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(568,'Xenserver','Other install media',99,'5.6 SP2','b02da0f8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(569,'Xenserver','CentOS 5 (32-bit)',139,'5.6 SP2','b02dadbe-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(570,'Xenserver','CentOS 5 (64-bit)',140,'5.6 SP2','b02dbb2e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(571,'Xenserver','CentOS 4.5 (32-bit)',1,'6.0','b02dc844-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(572,'Xenserver','CentOS 4.6 (32-bit)',2,'6.0','b02dd3ca-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(573,'Xenserver','CentOS 4.7 (32-bit)',3,'6.0','b02de126-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(574,'Xenserver','CentOS 4.8 (32-bit)',4,'6.0','b02ded42-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(575,'Xenserver','CentOS 5 (32-bit)',5,'6.0','b02df742-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(576,'Xenserver','CentOS 5 (64-bit)',6,'6.0','b02e064c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(577,'Xenserver','CentOS 5 (32-bit)',7,'6.0','b02e1132-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(578,'Xenserver','CentOS 5 (64-bit)',8,'6.0','b02e1cf4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(579,'Xenserver','CentOS 5 (32-bit)',9,'6.0','b02e274e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(580,'Xenserver','CentOS 5 (64-bit)',10,'6.0','b02e3112-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(581,'Xenserver','CentOS 5 (32-bit)',11,'6.0','b02e3ba8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(582,'Xenserver','CentOS 5 (64-bit)',12,'6.0','b02e4616-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(583,'Xenserver','CentOS 5 (32-bit)',13,'6.0','b02e511a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(584,'Xenserver','CentOS 5 (64-bit)',14,'6.0','b02e59f8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(585,'Xenserver','CentOS 5 (32-bit)',111,'6.0','b02e65ba-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(586,'Xenserver','CentOS 5 (64-bit)',112,'6.0','b02e72b2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(587,'Xenserver','CentOS 5 (32-bit)',141,'6.0','b02e7e10-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(588,'Xenserver','CentOS 5 (64-bit)',142,'6.0','b02e94d6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(589,'Xenserver','CentOS 6.0 (32-bit) (experimental)',143,'6.0','b02ea0de-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(590,'Xenserver','CentOS 6.0 (64-bit) (experimental)',144,'6.0','b02eaba6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(591,'Xenserver','Debian Lenny 5.0 (32-bit)',15,'6.0','b02eb5ce-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(592,'Xenserver','Debian Squeeze 6.0 (32-bit)',132,'6.0','b02ebfa6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(593,'Xenserver','Debian Squeeze 6.0 (64-bit)',133,'6.0','b02ec960-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(594,'Xenserver','Debian Squeeze 6.0 (32-bit)',183,'6.0','b02ed32e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(595,'Xenserver','Debian Squeeze 6.0 (64-bit)',184,'6.0','b02edd1a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(596,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',16,'6.0','b02ee6f2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(597,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',17,'6.0','b02ef0a2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(598,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',18,'6.0','b02efa66-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(599,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',19,'6.0','b02f0416-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(600,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',20,'6.0','b02f0e20-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(601,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',21,'6.0','b02f19ba-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(602,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',22,'6.0','b02f2478-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(603,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',23,'6.0','b02f2f86-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(604,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',24,'6.0','b02f3b98-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(605,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',25,'6.0','b02f44da-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(606,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',134,'6.0','b02f4ffc-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(607,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',135,'6.0','b02f5aec-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(608,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',145,'6.0','b02f65be-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(609,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',146,'6.0','b02f7130-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(610,'Xenserver','Oracle Enterprise Linux 6.0 (32-bit)',147,'6.0','b02f7d10-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(611,'Xenserver','Oracle Enterprise Linux 6.0 (64-bit)',148,'6.0','b02f88aa-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(612,'Xenserver','Red Hat Enterprise Linux 4.5 (32-bit)',26,'6.0','b02f8c74-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(613,'Xenserver','Red Hat Enterprise Linux 4.6 (32-bit)',27,'6.0','b02f9a52-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(614,'Xenserver','Red Hat Enterprise Linux 4.7 (32-bit)',28,'6.0','b02fa77c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(615,'Xenserver','Red Hat Enterprise Linux 4.8 (32-bit)',29,'6.0','b02fb1b8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(616,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',30,'6.0','b02fbb4a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(617,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',31,'6.0','b02fc4aa-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(618,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',32,'6.0','b02fcf04-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(619,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',33,'6.0','b02fda6c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(620,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',34,'6.0','b02fe3b8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(621,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',35,'6.0','b02feda4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(622,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',36,'6.0','b02ff7ae-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(623,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',37,'6.0','b0300244-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(624,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',38,'6.0','b0300c4e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(625,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',39,'6.0','b0301518-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(626,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',113,'6.0','b0301e28-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(627,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',114,'6.0','b030297c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(628,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',149,'6.0','b03035ac-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(629,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',150,'6.0','b0303ec6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(630,'Xenserver','Red Hat Enterprise Linux 6.0 (32-bit)',136,'6.0','b0304a2e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(631,'Xenserver','Red Hat Enterprise Linux 6.0 (64-bit)',137,'6.0','b03053e8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(632,'Xenserver','SUSE Linux Enterprise Server 9 SP4 (32-bit)',40,'6.0','b0305eb0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(633,'Xenserver','SUSE Linux Enterprise Server 10 SP1 (32-bit)',41,'6.0','b0306a5e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(634,'Xenserver','SUSE Linux Enterprise Server 10 SP1 (64-bit)',42,'6.0','b03075c6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(635,'Xenserver','SUSE Linux Enterprise Server 10 SP2 (32-bit)',43,'6.0','b03080b6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(636,'Xenserver','SUSE Linux Enterprise Server 10 SP2 (64-bit)',44,'6.0','b0308bc4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(637,'Xenserver','SUSE Linux Enterprise Server 10 SP3 (32-bit)',151,'6.0','b0309f7e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(638,'Xenserver','SUSE Linux Enterprise Server 10 SP3 (64-bit)',45,'6.0','b030aa1e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(639,'Xenserver','SUSE Linux Enterprise Server 10 SP4 (32-bit)',153,'6.0','b030b586-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(640,'Xenserver','SUSE Linux Enterprise Server 10 SP4 (64-bit)',152,'6.0','b030c01c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(641,'Xenserver','SUSE Linux Enterprise Server 11 (32-bit)',46,'6.0','b030caa8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(642,'Xenserver','SUSE Linux Enterprise Server 11 (64-bit)',47,'6.0','b030d52a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(643,'Xenserver','SUSE Linux Enterprise Server 11 SP1 (32-bit)',155,'6.0','b030edbc-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(644,'Xenserver','SUSE Linux Enterprise Server 11 SP1 (64-bit)',154,'6.0','b030f85c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(645,'Xenserver','Windows 7 (32-bit)',48,'6.0','b031039c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(646,'Xenserver','Windows 7 (64-bit)',49,'6.0','b0310ebe-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(647,'Xenserver','Windows Server 2003 (32-bit)',50,'6.0','b03118be-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(648,'Xenserver','Windows Server 2003 (64-bit)',51,'6.0','b031244e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(649,'Xenserver','Windows Server 2003 (32-bit)',87,'6.0','b0312e9e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(650,'Xenserver','Windows Server 2003 (64-bit)',88,'6.0','b031393e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(651,'Xenserver','Windows Server 2003 (32-bit)',89,'6.0','b03143a2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(652,'Xenserver','Windows Server 2003 (64-bit)',90,'6.0','b0314d98-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(653,'Xenserver','Windows Server 2008 (32-bit)',52,'6.0','b031581a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(654,'Xenserver','Windows Server 2008 (64-bit)',53,'6.0','b031644a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(655,'Xenserver','Windows Server 2008 R2 (64-bit)',54,'6.0','b0316e90-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(656,'Xenserver','Windows Vista (32-bit)',56,'6.0','b0317912-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(657,'Xenserver','Windows XP SP3 (32-bit)',58,'6.0','b03183d0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(658,'Xenserver','Ubuntu Lucid Lynx 10.04 (32-bit)',121,'6.0','b0318dc6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(659,'Xenserver','Ubuntu Lucid Lynx 10.04 (64-bit)',126,'6.0','b031982a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(660,'Xenserver','Ubuntu Maverick Meerkat 10.10 (32-bit) (experimental)',156,'6.0','b031a3ba-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(661,'Xenserver','Ubuntu Maverick Meerkat 10.10 (64-bit) (experimental)',157,'6.0','b031af90-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(662,'Xenserver','Other install media',98,'6.0','b031bfa8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(663,'Xenserver','Other install media',99,'6.0','b031ca8e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(664,'Xenserver','Other install media',60,'6.0','b031d556-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(665,'Xenserver','Other install media',103,'6.0','b031dfb0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(666,'Xenserver','Other install media',200,'6.0','b031ea96-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(667,'Xenserver','Other install media',201,'6.0','b031f4dc-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(668,'Xenserver','Other install media',59,'6.0','b031ffae-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(669,'Xenserver','Other install media',100,'6.0','b03209cc-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(670,'Xenserver','Other install media',202,'6.0','b0321368-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(671,'Xenserver','Other install media',203,'6.0','b0321d04-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(672,'Xenserver','CentOS 5 (32-bit)',139,'6.0','b03226aa-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(673,'Xenserver','CentOS 5 (64-bit)',140,'6.0','b032303c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(674,'Xenserver','CentOS 4.5 (32-bit)',1,'6.0.2','b03239c4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(675,'Xenserver','CentOS 4.6 (32-bit)',2,'6.0.2','b032432e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(676,'Xenserver','CentOS 4.7 (32-bit)',3,'6.0.2','b0324cb6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(677,'Xenserver','CentOS 4.8 (32-bit)',4,'6.0.2','b0325616-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(678,'Xenserver','CentOS 5 (32-bit)',5,'6.0.2','b0325fb2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(679,'Xenserver','CentOS 5 (64-bit)',6,'6.0.2','b0326a98-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(680,'Xenserver','CentOS 5 (32-bit)',7,'6.0.2','b0327696-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(681,'Xenserver','CentOS 5 (64-bit)',8,'6.0.2','b0328032-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(682,'Xenserver','CentOS 5 (32-bit)',9,'6.0.2','b0328be0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(683,'Xenserver','CentOS 5 (64-bit)',10,'6.0.2','b03297de-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(684,'Xenserver','CentOS 5 (32-bit)',11,'6.0.2','b032a382-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(685,'Xenserver','CentOS 5 (64-bit)',12,'6.0.2','b032b0d4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(686,'Xenserver','CentOS 5 (32-bit)',13,'6.0.2','b032baca-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(687,'Xenserver','CentOS 5 (64-bit)',14,'6.0.2','b032c4ac-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(688,'Xenserver','CentOS 5 (32-bit)',111,'6.0.2','b032cff6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(689,'Xenserver','CentOS 5 (64-bit)',112,'6.0.2','b032dc6c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(690,'Xenserver','CentOS 5 (32-bit)',141,'6.0.2','b032e7e8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(691,'Xenserver','CentOS 5 (64-bit)',142,'6.0.2','b032f35a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(692,'Xenserver','CentOS 5 (32-bit)',161,'6.0.2','b032fe18-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(693,'Xenserver','CentOS 5 (64-bit)',162,'6.0.2','b03308ae-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(694,'Xenserver','CentOS 6.0 (32-bit)',143,'6.0.2','b033127c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(695,'Xenserver','CentOS 6.0 (64-bit)',144,'6.0.2','b0331e52-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(696,'Xenserver','Debian Lenny 5.0 (32-bit)',15,'6.0.2','b033297e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(697,'Xenserver','Debian Squeeze 6.0 (32-bit)',132,'6.0.2','b0333590-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(698,'Xenserver','Debian Squeeze 6.0 (64-bit)',133,'6.0.2','b0334b5c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(699,'Xenserver','Debian Squeeze 6.0 (32-bit)',183,'6.0.2','b0335728-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(700,'Xenserver','Debian Squeeze 6.0 (64-bit)',184,'6.0.2','b033618c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(701,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',16,'6.0.2','b0336db2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(702,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',17,'6.0.2','b033788e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(703,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',18,'6.0.2','b0338342-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(704,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',19,'6.0.2','b0338dd8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(705,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',20,'6.0.2','b033981e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(706,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',21,'6.0.2','b033a1e2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(707,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',22,'6.0.2','b033abb0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(708,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',23,'6.0.2','b033b77c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(709,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',24,'6.0.2','b033c26c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(710,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',25,'6.0.2','b033cd02-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(711,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',134,'6.0.2','b033d6da-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(712,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',135,'6.0.2','b033e170-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(713,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',145,'6.0.2','b033ec10-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(714,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',146,'6.0.2','b033f62e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(715,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',207,'6.0.2','b03414ce-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(716,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',208,'6.0.2','b0341dd4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(717,'Xenserver','Oracle Enterprise Linux 6.0 (32-bit)',147,'6.0.2','b0342522-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(718,'Xenserver','Oracle Enterprise Linux 6.0 (64-bit)',148,'6.0.2','b0342e00-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(719,'Xenserver','Red Hat Enterprise Linux 4.5 (32-bit)',26,'6.0.2','b0343666-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(720,'Xenserver','Red Hat Enterprise Linux 4.6 (32-bit)',27,'6.0.2','b03441d8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(721,'Xenserver','Red Hat Enterprise Linux 4.7 (32-bit)',28,'6.0.2','b0344c32-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(722,'Xenserver','Red Hat Enterprise Linux 4.8 (32-bit)',29,'6.0.2','b0345646-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(723,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',30,'6.0.2','b034615e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(724,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',31,'6.0.2','b0346c94-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(725,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',32,'6.0.2','b0347716-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(726,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',33,'6.0.2','b0348080-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(727,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',34,'6.0.2','b03489fe-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(728,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',35,'6.0.2','b03492dc-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(729,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',36,'6.0.2','b034b834-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(730,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',37,'6.0.2','b034c126-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(731,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',38,'6.0.2','b034cae0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(732,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',39,'6.0.2','b034d558-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(733,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',113,'6.0.2','b034e318-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(734,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',114,'6.0.2','b034eda4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(735,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',149,'6.0.2','b034fc5e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(736,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',150,'6.0.2','b0350726-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(737,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',189,'6.0.2','b0350faa-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(738,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',190,'6.0.2','b03518f6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(739,'Xenserver','Red Hat Enterprise Linux 6.0 (32-bit)',136,'6.0.2','b03521f2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(740,'Xenserver','Red Hat Enterprise Linux 6.0 (64-bit)',137,'6.0.2','b0352aee-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(741,'Xenserver','SUSE Linux Enterprise Server 10 SP1 (32-bit)',40,'6.0.2','b03534a8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(742,'Xenserver','SUSE Linux Enterprise Server 10 SP1 (32-bit)',41,'6.0.2','b0353ff2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(743,'Xenserver','SUSE Linux Enterprise Server 10 SP1 (64-bit)',42,'6.0.2','b035495c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(744,'Xenserver','SUSE Linux Enterprise Server 10 SP2 (32-bit)',43,'6.0.2','b035537a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(745,'Xenserver','SUSE Linux Enterprise Server 10 SP2 (64-bit)',44,'6.0.2','b0355eec-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(746,'Xenserver','SUSE Linux Enterprise Server 10 SP3 (32-bit)',151,'6.0.2','b0356950-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(747,'Xenserver','SUSE Linux Enterprise Server 10 SP3 (64-bit)',45,'6.0.2','b035740e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(748,'Xenserver','SUSE Linux Enterprise Server 10 SP4 (32-bit)',153,'6.0.2','b0357d14-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(749,'Xenserver','SUSE Linux Enterprise Server 10 SP4 (64-bit)',152,'6.0.2','b0359466-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(750,'Xenserver','SUSE Linux Enterprise Server 11 (32-bit)',46,'6.0.2','b0359e16-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(751,'Xenserver','SUSE Linux Enterprise Server 11 (64-bit)',47,'6.0.2','b035ab68-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(752,'Xenserver','SUSE Linux Enterprise Server 11 SP1 (32-bit)',155,'6.0.2','b035b63a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(753,'Xenserver','SUSE Linux Enterprise Server 11 SP1 (64-bit)',154,'6.0.2','b035c1e8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(754,'Xenserver','Windows 7 (32-bit)',48,'6.0.2','b035cc6a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(755,'Xenserver','Windows 7 (64-bit)',49,'6.0.2','b035d6d8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(756,'Xenserver','Windows 8 (32-bit) (experimental)',165,'6.0.2','b035e07e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(757,'Xenserver','Windows 8 (64-bit) (experimental)',166,'6.0.2','b035ea06-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(758,'Xenserver','Windows Server 2003 (32-bit)',50,'6.0.2','b035f33e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(759,'Xenserver','Windows Server 2003 (64-bit)',51,'6.0.2','b035fca8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(760,'Xenserver','Windows Server 2003 (32-bit)',87,'6.0.2','b0360662-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(761,'Xenserver','Windows Server 2003 (64-bit)',88,'6.0.2','b0360fea-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(762,'Xenserver','Windows Server 2003 (32-bit)',89,'6.0.2','b0362386-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(763,'Xenserver','Windows Server 2003 (64-bit)',90,'6.0.2','b03632ea-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(764,'Xenserver','Windows Server 2008 (32-bit)',52,'6.0.2','b03646fe-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(765,'Xenserver','Windows Server 2008 (64-bit)',53,'6.0.2','b0365496-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(766,'Xenserver','Windows Server 2008 R2 (64-bit)',54,'6.0.2','b03660e4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(767,'Xenserver','Windows Vista (32-bit)',56,'6.0.2','b0366e2c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(768,'Xenserver','Windows XP SP3 (32-bit)',58,'6.0.2','b03679d0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(769,'Xenserver','Ubuntu Lucid Lynx 10.04 (32-bit)',121,'6.0.2','b0368470-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(770,'Xenserver','Ubuntu Lucid Lynx 10.04 (64-bit)',126,'6.0.2','b0368f92-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(771,'Xenserver','Ubuntu Maverick Meerkat 10.10 (32-bit) (experimental)',156,'6.0.2','b0369a1e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(772,'Xenserver','Ubuntu Maverick Meerkat 10.10 (64-bit) (experimental)',157,'6.0.2','b036a522-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(773,'Xenserver','Other install media',98,'6.0.2','b036af72-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(774,'Xenserver','Other install media',99,'6.0.2','b036ba94-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(775,'Xenserver','Other install media',60,'6.0.2','b036c598-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(776,'Xenserver','Other install media',103,'6.0.2','b036d178-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(777,'Xenserver','Other install media',200,'6.0.2','b036dd26-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(778,'Xenserver','Other install media',201,'6.0.2','b036e5aa-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(779,'Xenserver','Other install media',59,'6.0.2','b036f1ee-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(780,'Xenserver','Other install media',100,'6.0.2','b036fce8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(781,'Xenserver','Other install media',202,'6.0.2','b03707ba-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(782,'Xenserver','Other install media',203,'6.0.2','b03712d2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(783,'Xenserver','CentOS 5 (32-bit)',139,'6.0.2','b0371db8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(784,'Xenserver','CentOS 5 (64-bit)',140,'6.0.2','b0372998-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(785,'Xenserver','CentOS 4.5 (32-bit)',1,'6.1.0','b03734ba-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(786,'Xenserver','CentOS 4.6 (32-bit)',2,'6.1.0','b0373eec-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(787,'Xenserver','CentOS 4.7 (32-bit)',3,'6.1.0','b0374964-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(788,'Xenserver','CentOS 4.8 (32-bit)',4,'6.1.0','b0375382-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(789,'Xenserver','CentOS 5 (32-bit)',5,'6.1.0','b0375d96-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(790,'Xenserver','CentOS 5 (64-bit)',6,'6.1.0','b0376854-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(791,'Xenserver','CentOS 5 (32-bit)',7,'6.1.0','b037747a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(792,'Xenserver','CentOS 5 (64-bit)',8,'6.1.0','b0377e66-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(793,'Xenserver','CentOS 5 (32-bit)',9,'6.1.0','b0378910-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(794,'Xenserver','CentOS 5 (64-bit)',10,'6.1.0','b03793c4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(795,'Xenserver','CentOS 5 (32-bit)',11,'6.1.0','b0379f36-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(796,'Xenserver','CentOS 5 (64-bit)',12,'6.1.0','b037a878-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(797,'Xenserver','CentOS 5 (32-bit)',13,'6.1.0','b037b278-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(798,'Xenserver','CentOS 5 (64-bit)',14,'6.1.0','b037bcb4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(799,'Xenserver','CentOS 5 (32-bit)',111,'6.1.0','b037c6fa-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(800,'Xenserver','CentOS 5 (64-bit)',112,'6.1.0','b037d032-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(801,'Xenserver','CentOS 5 (32-bit)',141,'6.1.0','b037db36-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(802,'Xenserver','CentOS 5 (64-bit)',142,'6.1.0','b037e5e0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(803,'Xenserver','CentOS 5 (32-bit)',161,'6.1.0','b037f062-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(804,'Xenserver','CentOS 5 (64-bit)',162,'6.1.0','b0380048-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(805,'Xenserver','CentOS 6 (32-bit)',143,'6.1.0','b0380bb0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(806,'Xenserver','CentOS 6 (64-bit)',144,'6.1.0','b03816aa-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(807,'Xenserver','CentOS 6 (32-bit)',177,'6.1.0','b03821ea-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(808,'Xenserver','CentOS 6 (64-bit)',178,'6.1.0','b0382cd0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(809,'Xenserver','CentOS 6 (32-bit)',179,'6.1.0','b038382e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(810,'Xenserver','CentOS 6 (64-bit)',180,'6.1.0','b0384300-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(811,'Xenserver','CentOS 6 (32-bit)',171,'6.1.0','b0384f4e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(812,'Xenserver','CentOS 6 (64-bit)',172,'6.1.0','b0385ade-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(813,'Xenserver','Debian Squeeze 6.0 (32-bit)',132,'6.1.0','b0386650-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(814,'Xenserver','Debian Squeeze 6.0 (64-bit)',133,'6.1.0','b03870aa-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(815,'Xenserver','Debian Squeeze 6.0 (32-bit)',183,'6.1.0','b0387a8c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(816,'Xenserver','Debian Squeeze 6.0 (64-bit)',184,'6.1.0','b0388766-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(817,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',16,'6.1.0','b0389166-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(818,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',17,'6.1.0','b0389ba2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(819,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',18,'6.1.0','b038b272-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(820,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',19,'6.1.0','b038bc9a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(821,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',20,'6.1.0','b038c654-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(822,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',21,'6.1.0','b038cfbe-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(823,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',22,'6.1.0','b038d888-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(824,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',23,'6.1.0','b038e030-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(825,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',24,'6.1.0','b038e9a4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(826,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',25,'6.1.0','b038f368-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(827,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',134,'6.1.0','b038fde0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(828,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',135,'6.1.0','b0390740-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(829,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',145,'6.1.0','b0390fa6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(830,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',146,'6.1.0','b0391834-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(831,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',207,'6.1.0','b0392126-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(832,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',208,'6.1.0','b0392964-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(833,'Xenserver','Oracle Enterprise Linux 6 (32-bit)',147,'6.1.0','b0393224-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(834,'Xenserver','Oracle Enterprise Linux 6 (64-bit)',148,'6.1.0','b0393f44-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(835,'Xenserver','Oracle Enterprise Linux 6 (32-bit)',213,'6.1.0','b03952c2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(836,'Xenserver','Oracle Enterprise Linux 6 (64-bit)',214,'6.1.0','b0395df8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(837,'Xenserver','Oracle Enterprise Linux 6 (32-bit)',215,'6.1.0','b0396a00-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(838,'Xenserver','Oracle Enterprise Linux 6 (64-bit)',216,'6.1.0','b0397392-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(839,'Xenserver','Red Hat Enterprise Linux 4.5 (32-bit)',26,'6.1.0','b0397c66-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(840,'Xenserver','Red Hat Enterprise Linux 4.6 (32-bit)',27,'6.1.0','b0398594-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(841,'Xenserver','Red Hat Enterprise Linux 4.7 (32-bit)',28,'6.1.0','b0398e4a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(842,'Xenserver','Red Hat Enterprise Linux 4.8 (32-bit)',29,'6.1.0','b03996f6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(843,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',30,'6.1.0','b039a2d6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(844,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',31,'6.1.0','b039abc8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(845,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',32,'6.1.0','b039b4b0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(846,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',33,'6.1.0','b039bd98-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(847,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',34,'6.1.0','b039ca04-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(848,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',35,'6.1.0','b039d260-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(849,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',36,'6.1.0','b039dee0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(850,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',37,'6.1.0','b039e8b8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(851,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',38,'6.1.0','b039f196-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(852,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',39,'6.1.0','b039faf6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(853,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',113,'6.1.0','b03a082a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(854,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',114,'6.1.0','b03a139c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(855,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',149,'6.1.0','b03a2d82-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(856,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',150,'6.1.0','b03a36f6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(857,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',189,'6.1.0','b03a3ff2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(858,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',190,'6.1.0','b03a49b6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(859,'Xenserver','Red Hat Enterprise Linux 6 (32-bit)',136,'6.1.0','b03a533e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(860,'Xenserver','Red Hat Enterprise Linux 6 (64-bit)',137,'6.1.0','b03a5cd0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(861,'Xenserver','Red Hat Enterprise Linux 6 (32-bit)',195,'6.1.0','b03a6752-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(862,'Xenserver','Red Hat Enterprise Linux 6 (64-bit)',196,'6.1.0','b03a724c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(863,'Xenserver','Red Hat Enterprise Linux 6 (32-bit)',197,'6.1.0','b03a7c10-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(864,'Xenserver','Red Hat Enterprise Linux 6 (64-bit)',198,'6.1.0','b03a870a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(865,'Xenserver','SUSE Linux Enterprise Server 10 SP1 (32-bit)',40,'6.1.0','b03a9434-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(866,'Xenserver','SUSE Linux Enterprise Server 10 SP1 (32-bit)',41,'6.1.0','b03a9ee8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(867,'Xenserver','SUSE Linux Enterprise Server 10 SP1 (64-bit)',42,'6.1.0','b03aa9ec-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(868,'Xenserver','SUSE Linux Enterprise Server 10 SP2 (32-bit)',43,'6.1.0','b03ab41e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(869,'Xenserver','SUSE Linux Enterprise Server 10 SP2 (64-bit)',44,'6.1.0','b03abfd6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(870,'Xenserver','SUSE Linux Enterprise Server 10 SP3 (32-bit)',151,'6.1.0','b03ac9c2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(871,'Xenserver','SUSE Linux Enterprise Server 10 SP3 (64-bit)',45,'6.1.0','b03ad336-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(872,'Xenserver','SUSE Linux Enterprise Server 10 SP4 (32-bit)',153,'6.1.0','b03adc1e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(873,'Xenserver','SUSE Linux Enterprise Server 10 SP4 (64-bit)',152,'6.1.0','b03ae542-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(874,'Xenserver','SUSE Linux Enterprise Server 11 (32-bit)',46,'6.1.0','b03af0f0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(875,'Xenserver','SUSE Linux Enterprise Server 11 (64-bit)',47,'6.1.0','b03afa82-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(876,'Xenserver','SUSE Linux Enterprise Server 11 SP1 (32-bit)',155,'6.1.0','b03b036a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(877,'Xenserver','SUSE Linux Enterprise Server 11 SP1 (64-bit)',154,'6.1.0','b03b0c16-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(878,'Xenserver','Windows 7 (32-bit)',48,'6.1.0','b03b1594-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(879,'Xenserver','Windows 7 (64-bit)',49,'6.1.0','b03b1fb2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(880,'Xenserver','Windows 8 (32-bit) (experimental)',165,'6.1.0','b03b2ae8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(881,'Xenserver','Windows 8 (64-bit) (experimental)',166,'6.1.0','b03b3628-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(882,'Xenserver','Windows Server 2003 (32-bit)',50,'6.1.0','b03b41a4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(883,'Xenserver','Windows Server 2003 (64-bit)',51,'6.1.0','b03b4d34-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(884,'Xenserver','Windows Server 2003 (32-bit)',87,'6.1.0','b03b57e8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(885,'Xenserver','Windows Server 2003 (64-bit)',88,'6.1.0','b03b62b0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(886,'Xenserver','Windows Server 2003 (32-bit)',89,'6.1.0','b03b6c92-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(887,'Xenserver','Windows Server 2003 (64-bit)',90,'6.1.0','b03b789a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(888,'Xenserver','Windows Server 2008 (32-bit)',52,'6.1.0','b03b8358-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(889,'Xenserver','Windows Server 2008 (64-bit)',53,'6.1.0','b03b8f2e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(890,'Xenserver','Windows Server 2008 R2 (64-bit)',54,'6.1.0','b03b9afa-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(891,'Xenserver','Windows Server 2012 (64-bit) (experimental)',167,'6.1.0','b03ba6c6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(892,'Xenserver','Windows Vista (32-bit)',56,'6.1.0','b03bb954-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(893,'Xenserver','Windows XP SP3 (32-bit)',58,'6.1.0','b03bc3e0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(894,'Xenserver','Ubuntu Lucid Lynx 10.04 (32-bit)',121,'6.1.0','b03bcd72-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(895,'Xenserver','Ubuntu Lucid Lynx 10.04 (64-bit)',126,'6.1.0','b03bd92a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(896,'Xenserver','Ubuntu Maverick Meerkat 10.10 (32-bit) (experimental)',156,'6.1.0','b03be6c2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(897,'Xenserver','Ubuntu Maverick Meerkat 10.10 (64-bit) (experimental)',157,'6.1.0','b03bf298-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(898,'Xenserver','Ubuntu Precise Pangolin 12.04 (32-bit)',163,'6.1.0','b03bff4a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(899,'Xenserver','Ubuntu Precise Pangolin 12.04 (64-bit)',164,'6.1.0','b03c0e40-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(900,'Xenserver','Other install media',169,'6.1.0','b03c1a8e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(901,'Xenserver','Other install media',170,'6.1.0','b03c25f6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(902,'Xenserver','Other install media',98,'6.1.0','b03c315e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(903,'Xenserver','Other install media',99,'6.1.0','b03c3c30-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(904,'Xenserver','Other install media',60,'6.1.0','b03c45d6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(905,'Xenserver','Other install media',103,'6.1.0','b03c4f5e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(906,'Xenserver','Other install media',200,'6.1.0','b03c6250-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(907,'Xenserver','Other install media',201,'6.1.0','b03c6c50-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(908,'Xenserver','Other install media',59,'6.1.0','b03c76aa-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(909,'Xenserver','Other install media',100,'6.1.0','b03c817c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(910,'Xenserver','Other install media',202,'6.1.0','b03c89ce-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(911,'Xenserver','Other install media',203,'6.1.0','b03c93a6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(912,'Xenserver','CentOS 5 (32-bit)',139,'6.1.0','b03c9e64-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(913,'Xenserver','CentOS 5 (64-bit)',140,'6.1.0','b03cad0a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(914,'Xenserver','CentOS 4.5 (32-bit)',1,'6.2.0','b03cb778-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(915,'Xenserver','CentOS 4.6 (32-bit)',2,'6.2.0','b03cc254-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(916,'Xenserver','CentOS 4.7 (32-bit)',3,'6.2.0','b03ccd9e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(917,'Xenserver','CentOS 4.8 (32-bit)',4,'6.2.0','b03cd8de-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(918,'Xenserver','CentOS 5 (32-bit)',5,'6.2.0','b03ce400-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(919,'Xenserver','CentOS 5 (64-bit)',6,'6.2.0','b03ceeb4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(920,'Xenserver','CentOS 5 (32-bit)',7,'6.2.0','b03cf954-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(921,'Xenserver','CentOS 5 (64-bit)',8,'6.2.0','b03d0426-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(922,'Xenserver','CentOS 5 (32-bit)',9,'6.2.0','b03d0ec6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(923,'Xenserver','CentOS 5 (64-bit)',10,'6.2.0','b03d192a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(924,'Xenserver','CentOS 5 (32-bit)',11,'6.2.0','b03d23a2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(925,'Xenserver','CentOS 5 (64-bit)',12,'6.2.0','b03d2de8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(926,'Xenserver','CentOS 5 (32-bit)',13,'6.2.0','b03d3914-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(927,'Xenserver','CentOS 5 (64-bit)',14,'6.2.0','b03d4670-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(928,'Xenserver','CentOS 5 (32-bit)',111,'6.2.0','b03d5318-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(929,'Xenserver','CentOS 5 (64-bit)',112,'6.2.0','b03d5caa-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(930,'Xenserver','CentOS 5 (32-bit)',141,'6.2.0','b03d6614-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(931,'Xenserver','CentOS 5 (64-bit)',142,'6.2.0','b03d6f38-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(932,'Xenserver','CentOS 5 (32-bit)',161,'6.2.0','b03d7834-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(933,'Xenserver','CentOS 5 (64-bit)',162,'6.2.0','b03d8356-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(934,'Xenserver','CentOS 5 (32-bit)',173,'6.2.0','b03d8e1e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(935,'Xenserver','CentOS 5 (64-bit)',174,'6.2.0','b03d9760-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(936,'Xenserver','CentOS 5 (32-bit)',175,'6.2.0','b03da14c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(937,'Xenserver','CentOS 5 (64-bit)',176,'6.2.0','b03daa48-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(938,'Xenserver','CentOS 6 (32-bit)',143,'6.2.0','b03db3bc-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(939,'Xenserver','CentOS 6 (64-bit)',144,'6.2.0','b03dbcd6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(940,'Xenserver','CentOS 6 (32-bit)',177,'6.2.0','b03dc8f2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(941,'Xenserver','CentOS 6 (64-bit)',178,'6.2.0','b03dd234-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(942,'Xenserver','CentOS 6 (32-bit)',179,'6.2.0','b03ddbda-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(943,'Xenserver','CentOS 6 (64-bit)',180,'6.2.0','b03de8e6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(944,'Xenserver','CentOS 6 (32-bit)',171,'6.2.0','b03df3ae-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(945,'Xenserver','CentOS 6 (64-bit)',172,'6.2.0','b03dfdb8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(946,'Xenserver','CentOS 6 (32-bit)',181,'6.2.0','b03e06be-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(947,'Xenserver','CentOS 6 (64-bit)',182,'6.2.0','b03e0fce-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(948,'Xenserver','Debian Squeeze 6.0 (32-bit)',132,'6.2.0','b03e1c44-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(949,'Xenserver','Debian Squeeze 6.0 (64-bit)',133,'6.2.0','b03e27b6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(950,'Xenserver','Debian Wheezy 7.0 (32-bit)',183,'6.2.0','b03e30e4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(951,'Xenserver','Debian Wheezy 7.0 (64-bit)',184,'6.2.0','b03e3a58-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(952,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',16,'6.2.0','b03e4700-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(953,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',17,'6.2.0','b03e50a6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(954,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',18,'6.2.0','b03e592a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(955,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',19,'6.2.0','b03e62b2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(956,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',20,'6.2.0','b03e6d8e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(957,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',21,'6.2.0','b03e76f8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(958,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',22,'6.2.0','b03e8044-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(959,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',23,'6.2.0','b03e8a30-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(960,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',24,'6.2.0','b03e92b4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(961,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',25,'6.2.0','b03e9b1a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(962,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',134,'6.2.0','b03ea3da-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(963,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',135,'6.2.0','b03eb6e0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(964,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',145,'6.2.0','b03ec068-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(965,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',146,'6.2.0','b03eca90-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(966,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',207,'6.2.0','b03ed436-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(967,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',208,'6.2.0','b03ede90-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(968,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',209,'6.2.0','b03eea02-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(969,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',210,'6.2.0','b03ef6dc-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(970,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',211,'6.2.0','b03f02f8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(971,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',212,'6.2.0','b03f0ef6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(972,'Xenserver','Oracle Enterprise Linux 6 (32-bit)',147,'6.2.0','b03f1e00-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(973,'Xenserver','Oracle Enterprise Linux 6 (64-bit)',148,'6.2.0','b03f2ab2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(974,'Xenserver','Oracle Enterprise Linux 6 (32-bit)',213,'6.2.0','b03f37fa-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(975,'Xenserver','Oracle Enterprise Linux 6 (64-bit)',214,'6.2.0','b03f44b6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(976,'Xenserver','Oracle Enterprise Linux 6 (32-bit)',215,'6.2.0','b03f5c1c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(977,'Xenserver','Oracle Enterprise Linux 6 (64-bit)',216,'6.2.0','b03f687e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(978,'Xenserver','Oracle Enterprise Linux 6 (32-bit)',217,'6.2.0','b03f73dc-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(979,'Xenserver','Oracle Enterprise Linux 6 (64-bit)',218,'6.2.0','b03f7ec2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(980,'Xenserver','Oracle Enterprise Linux 6 (32-bit)',219,'6.2.0','b03f88ea-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(981,'Xenserver','Oracle Enterprise Linux 6 (64-bit)',220,'6.2.0','b03f92f4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(982,'Xenserver','Red Hat Enterprise Linux 4.5 (32-bit)',26,'6.2.0','b03f9d9e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(983,'Xenserver','Red Hat Enterprise Linux 4.6 (32-bit)',27,'6.2.0','b03fa94c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(984,'Xenserver','Red Hat Enterprise Linux 4.7 (32-bit)',28,'6.2.0','b03fb482-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(985,'Xenserver','Red Hat Enterprise Linux 4.8 (32-bit)',29,'6.2.0','b03fbe00-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(986,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',30,'6.2.0','b03fc896-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(987,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',31,'6.2.0','b03fd390-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(988,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',32,'6.2.0','b03fdf8e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(989,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',33,'6.2.0','b03fea7e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(990,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',34,'6.2.0','b03ff4c4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(991,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',35,'6.2.0','b03ffece-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(992,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',36,'6.2.0','b0400a0e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(993,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',37,'6.2.0','b0401652-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(994,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',38,'6.2.0','b040217e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(995,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',39,'6.2.0','b0402d72-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(996,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',113,'6.2.0','b04039b6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(997,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',114,'6.2.0','b0403bbe-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(998,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',149,'6.2.0','b0404622-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(999,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',150,'6.2.0','b04050b8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1000,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',189,'6.2.0','b0405aea-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1001,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',190,'6.2.0','b040660c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1002,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',191,'6.2.0','b0407052-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1003,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',192,'6.2.0','b0407caa-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1004,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',193,'6.2.0','b0408786-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1005,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',194,'6.2.0','b0409212-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1006,'Xenserver','Red Hat Enterprise Linux 6 (32-bit)',136,'6.2.0','b0409cf8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1007,'Xenserver','Red Hat Enterprise Linux 6 (64-bit)',137,'6.2.0','b040a66c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1008,'Xenserver','Red Hat Enterprise Linux 6 (32-bit)',195,'6.2.0','b040b15c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1009,'Xenserver','Red Hat Enterprise Linux 6 (64-bit)',196,'6.2.0','b040bca6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1010,'Xenserver','Red Hat Enterprise Linux 6 (32-bit)',197,'6.2.0','b040c7b4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1011,'Xenserver','Red Hat Enterprise Linux 6 (64-bit)',198,'6.2.0','b040d006-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1012,'Xenserver','Red Hat Enterprise Linux 6 (32-bit)',199,'6.2.0','b040dace-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1013,'Xenserver','Red Hat Enterprise Linux 6 (64-bit)',204,'6.2.0','b040e596-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1014,'Xenserver','Red Hat Enterprise Linux 6 (32-bit)',205,'6.2.0','b040f0e0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1015,'Xenserver','Red Hat Enterprise Linux 6 (64-bit)',206,'6.2.0','b040fbbc-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1016,'Xenserver','SUSE Linux Enterprise Server 10 SP1 (32-bit)',41,'6.2.0','b04106ca-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1017,'Xenserver','SUSE Linux Enterprise Server 10 SP1 (64-bit)',42,'6.2.0','b0411174-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1018,'Xenserver','SUSE Linux Enterprise Server 10 SP2 (32-bit)',43,'6.2.0','b0411bd8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1019,'Xenserver','SUSE Linux Enterprise Server 10 SP2 (64-bit)',44,'6.2.0','b041260a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1020,'Xenserver','SUSE Linux Enterprise Server 10 SP3 (32-bit)',151,'6.2.0','b0412ff6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1021,'Xenserver','SUSE Linux Enterprise Server 10 SP3 (64-bit)',45,'6.2.0','b04139d8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1022,'Xenserver','SUSE Linux Enterprise Server 10 SP4 (32-bit)',153,'6.2.0','b04144a0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1023,'Xenserver','SUSE Linux Enterprise Server 10 SP4 (64-bit)',152,'6.2.0','b0415274-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1024,'Xenserver','SUSE Linux Enterprise Server 11 (32-bit)',46,'6.2.0','b0415d3c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1025,'Xenserver','SUSE Linux Enterprise Server 11 (64-bit)',47,'6.2.0','b0416854-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1026,'Xenserver','SUSE Linux Enterprise Server 11 SP1 (32-bit)',155,'6.2.0','b041745c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1027,'Xenserver','SUSE Linux Enterprise Server 11 SP1 (64-bit)',154,'6.2.0','b0417f06-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1028,'Xenserver','SUSE Linux Enterprise Server 11 SP2 (32-bit)',186,'6.2.0','b0418910-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1029,'Xenserver','SUSE Linux Enterprise Server 11 SP2 (64-bit)',185,'6.2.0','b0419360-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1030,'Xenserver','Windows 7 (32-bit)',48,'6.2.0','b0419f18-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1031,'Xenserver','Windows 7 (64-bit)',49,'6.2.0','b041aa8a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1032,'Xenserver','Windows 8 (32-bit)',165,'6.2.0','b041b5fc-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1033,'Xenserver','Windows 8 (64-bit)',166,'6.2.0','b041c092-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1034,'Xenserver','Windows Server 2003 (32-bit)',50,'6.2.0','b041cbaa-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1035,'Xenserver','Windows Server 2003 (64-bit)',51,'6.2.0','b041d6e0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1036,'Xenserver','Windows Server 2003 (32-bit)',87,'6.2.0','b041e090-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1037,'Xenserver','Windows Server 2003 (64-bit)',88,'6.2.0','b041ea86-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1038,'Xenserver','Windows Server 2003 (32-bit)',89,'6.2.0','b041f51c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1039,'Xenserver','Windows Server 2003 (64-bit)',90,'6.2.0','b041fefe-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1040,'Xenserver','Windows Server 2008 R2 (64-bit)',54,'6.2.0','b04207c8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1041,'Xenserver','Windows Server 2012 (64-bit)',167,'6.2.0','b042104c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1042,'Xenserver','Windows XP SP3 (32-bit)',58,'6.2.0','b04219ac-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1043,'Xenserver','Ubuntu Lucid Lynx 10.04 (32-bit)',121,'6.2.0','b04223ac-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1044,'Xenserver','Ubuntu Lucid Lynx 10.04 (64-bit)',126,'6.2.0','b0422f96-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1045,'Xenserver','Ubuntu Maverick Meerkat 10.10 (32-bit) (experimental)',156,'6.2.0','b04238b0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1046,'Xenserver','Ubuntu Maverick Meerkat 10.10 (64-bit) (experimental)',157,'6.2.0','b042426a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1047,'Xenserver','Ubuntu Precise Pangolin 12.04 (32-bit)',163,'6.2.0','b0424c38-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1048,'Xenserver','Ubuntu Precise Pangolin 12.04 (64-bit)',164,'6.2.0','b04254e4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1049,'Xenserver','Other install media',169,'6.2.0','b0425e58-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1050,'Xenserver','Other install media',170,'6.2.0','b042695c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1051,'Xenserver','Other install media',98,'6.2.0','b042742e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1052,'Xenserver','Other install media',99,'6.2.0','b0427f14-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1053,'Xenserver','Other install media',60,'6.2.0','b0428928-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1054,'Xenserver','Other install media',103,'6.2.0','b04292d8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1055,'Xenserver','Other install media',200,'6.2.0','b0429fb2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1056,'Xenserver','Other install media',201,'6.2.0','b042a8f4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1057,'Xenserver','Other install media',59,'6.2.0','b042b218-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1058,'Xenserver','Other install media',100,'6.2.0','b042bc22-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1059,'Xenserver','Other install media',202,'6.2.0','b042c5a0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1060,'Xenserver','Other install media',203,'6.2.0','b042ced8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1061,'Xenserver','CentOS 5 (32-bit)',139,'6.2.0','b042d7d4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1062,'Xenserver','CentOS 5 (64-bit)',140,'6.2.0','b042e170-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1063,'Xenserver','CentOS 4.5 (32-bit)',1,'6.2.5','b042f408-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1064,'Xenserver','CentOS 4.6 (32-bit)',2,'6.2.5','b042feda-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1065,'Xenserver','CentOS 4.7 (32-bit)',3,'6.2.5','b0430858-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1066,'Xenserver','CentOS 4.8 (32-bit)',4,'6.2.5','b04313de-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1067,'Xenserver','CentOS 5 (32-bit)',5,'6.2.5','b0431f1e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1068,'Xenserver','CentOS 5 (64-bit)',6,'6.2.5','b0432a04-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1069,'Xenserver','CentOS 5 (32-bit)',7,'6.2.5','b043356c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1070,'Xenserver','CentOS 5 (64-bit)',8,'6.2.5','b04340d4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1071,'Xenserver','CentOS 5 (32-bit)',9,'6.2.5','b0434de0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1072,'Xenserver','CentOS 5 (64-bit)',10,'6.2.5','b0435786-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1073,'Xenserver','CentOS 5 (32-bit)',11,'6.2.5','b04360e6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1074,'Xenserver','CentOS 5 (64-bit)',12,'6.2.5','b0436bfe-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1075,'Xenserver','CentOS 5 (32-bit)',13,'6.2.5','b0437536-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1076,'Xenserver','CentOS 5 (64-bit)',14,'6.2.5','b0437f40-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1077,'Xenserver','CentOS 5 (32-bit)',111,'6.2.5','b0438be8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1078,'Xenserver','CentOS 5 (64-bit)',112,'6.2.5','b043985e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1079,'Xenserver','CentOS 5 (32-bit)',141,'6.2.5','b043a27c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1080,'Xenserver','CentOS 5 (64-bit)',142,'6.2.5','b043af42-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1081,'Xenserver','CentOS 5 (32-bit)',161,'6.2.5','b043b7bc-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1082,'Xenserver','CentOS 5 (64-bit)',162,'6.2.5','b043c018-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1083,'Xenserver','CentOS 5 (32-bit)',173,'6.2.5','b043ca5e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1084,'Xenserver','CentOS 5 (64-bit)',174,'6.2.5','b043d38c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1085,'Xenserver','CentOS 5 (32-bit)',175,'6.2.5','b043dcb0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1086,'Xenserver','CentOS 5 (64-bit)',176,'6.2.5','b043e836-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1087,'Xenserver','CentOS 6 (32-bit)',143,'6.2.5','b043f236-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1088,'Xenserver','CentOS 6 (64-bit)',144,'6.2.5','b043fbaa-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1089,'Xenserver','CentOS 6 (32-bit)',177,'6.2.5','b04421de-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1090,'Xenserver','CentOS 6 (64-bit)',178,'6.2.5','b0442a62-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1091,'Xenserver','CentOS 6 (32-bit)',179,'6.2.5','b04433d6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1092,'Xenserver','CentOS 6 (64-bit)',180,'6.2.5','b044402e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1093,'Xenserver','CentOS 6 (32-bit)',171,'6.2.5','b0444a6a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1094,'Xenserver','CentOS 6 (64-bit)',172,'6.2.5','b0445294-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1095,'Xenserver','CentOS 6 (32-bit)',181,'6.2.5','b0445c12-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1096,'Xenserver','CentOS 6 (64-bit)',182,'6.2.5','b04468c4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1097,'Xenserver','Debian Squeeze 6.0 (32-bit)',132,'6.2.5','b0447486-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1098,'Xenserver','Debian Squeeze 6.0 (64-bit)',133,'6.2.5','b0448016-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1099,'Xenserver','Debian Wheezy 7.0 (32-bit)',183,'6.2.5','b0448bba-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1100,'Xenserver','Debian Wheezy 7.0 (64-bit)',184,'6.2.5','b044972c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1101,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',16,'6.2.5','b044a1b8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1102,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',17,'6.2.5','b044abe0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1103,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',18,'6.2.5','b044b6e4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1104,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',19,'6.2.5','b044c0bc-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1105,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',20,'6.2.5','b044ca9e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1106,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',21,'6.2.5','b044dbb0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1107,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',22,'6.2.5','b044e682-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1108,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',23,'6.2.5','b044ef38-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1109,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',24,'6.2.5','b044f88e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1110,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',25,'6.2.5','b045052c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1111,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',134,'6.2.5','b0450fb8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1112,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',135,'6.2.5','b0451b0c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1113,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',145,'6.2.5','b04527aa-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1114,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',146,'6.2.5','b045324a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1115,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',207,'6.2.5','b0453b64-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1116,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',208,'6.2.5','b0454686-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1117,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',209,'6.2.5','b04550cc-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1118,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',210,'6.2.5','b0455c66-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1119,'Xenserver','Oracle Enterprise Linux 5 (32-bit)',211,'6.2.5','b04566ac-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1120,'Xenserver','Oracle Enterprise Linux 5 (64-bit)',212,'6.2.5','b045711a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1121,'Xenserver','Oracle Enterprise Linux 6 (32-bit)',147,'6.2.5','b0457b60-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1122,'Xenserver','Oracle Enterprise Linux 6 (64-bit)',148,'6.2.5','b0458632-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1123,'Xenserver','Oracle Enterprise Linux 6 (32-bit)',213,'6.2.5','b0459140-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1124,'Xenserver','Oracle Enterprise Linux 6 (64-bit)',214,'6.2.5','b0459be0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1125,'Xenserver','Oracle Enterprise Linux 6 (32-bit)',215,'6.2.5','b045a5fe-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1126,'Xenserver','Oracle Enterprise Linux 6 (64-bit)',216,'6.2.5','b045af0e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1127,'Xenserver','Oracle Enterprise Linux 6 (32-bit)',217,'6.2.5','b045b90e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1128,'Xenserver','Oracle Enterprise Linux 6 (64-bit)',218,'6.2.5','b045c2b4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1129,'Xenserver','Oracle Enterprise Linux 6 (32-bit)',219,'6.2.5','b045ce3a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1130,'Xenserver','Oracle Enterprise Linux 6 (64-bit)',220,'6.2.5','b045d7c2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1131,'Xenserver','Red Hat Enterprise Linux 4.5 (32-bit)',26,'6.2.5','b045e26c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1132,'Xenserver','Red Hat Enterprise Linux 4.6 (32-bit)',27,'6.2.5','b045ed84-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1133,'Xenserver','Red Hat Enterprise Linux 4.7 (32-bit)',28,'6.2.5','b045f950-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1134,'Xenserver','Red Hat Enterprise Linux 4.8 (32-bit)',29,'6.2.5','b04604fe-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1135,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',30,'6.2.5','b046108e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1136,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',31,'6.2.5','b0461b7e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1137,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',32,'6.2.5','b046260a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1138,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',33,'6.2.5','b0463140-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1139,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',34,'6.2.5','b0463c62-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1140,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',35,'6.2.5','b046470c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1141,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',36,'6.2.5','b0465300-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1142,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',37,'6.2.5','b04660ac-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1143,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',38,'6.2.5','b0466b38-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1144,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',39,'6.2.5','b04674fc-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1145,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',113,'6.2.5','b04680a0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1146,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',114,'6.2.5','b0468b68-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1147,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',149,'6.2.5','b0469c02-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1148,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',150,'6.2.5','b046a5a8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1149,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',189,'6.2.5','b046afb2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1150,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',190,'6.2.5','b046b99e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1151,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',191,'6.2.5','b046c470-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1152,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',192,'6.2.5','b046cf9c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1153,'Xenserver','Red Hat Enterprise Linux 5 (32-bit)',193,'6.2.5','b046daaa-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1154,'Xenserver','Red Hat Enterprise Linux 5 (64-bit)',194,'6.2.5','b046e54a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1155,'Xenserver','Red Hat Enterprise Linux 6 (32-bit)',136,'6.2.5','b046efea-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1156,'Xenserver','Red Hat Enterprise Linux 6 (64-bit)',137,'6.2.5','b046faa8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1157,'Xenserver','Red Hat Enterprise Linux 6 (32-bit)',195,'6.2.5','b047061a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1158,'Xenserver','Red Hat Enterprise Linux 6 (64-bit)',196,'6.2.5','b0471132-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1159,'Xenserver','Red Hat Enterprise Linux 6 (32-bit)',197,'6.2.5','b0471c22-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1160,'Xenserver','Red Hat Enterprise Linux 6 (64-bit)',198,'6.2.5','b04725f0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1161,'Xenserver','Red Hat Enterprise Linux 6 (32-bit)',199,'6.2.5','b0473158-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1162,'Xenserver','Red Hat Enterprise Linux 6 (64-bit)',204,'6.2.5','b0473c5c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1163,'Xenserver','Red Hat Enterprise Linux 6 (32-bit)',205,'6.2.5','b0474738-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1164,'Xenserver','Red Hat Enterprise Linux 6 (64-bit)',206,'6.2.5','b04751b0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1165,'Xenserver','SUSE Linux Enterprise Server 10 SP1 (32-bit)',41,'6.2.5','b0475bec-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1166,'Xenserver','SUSE Linux Enterprise Server 10 SP1 (64-bit)',42,'6.2.5','b0476696-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1167,'Xenserver','SUSE Linux Enterprise Server 10 SP2 (32-bit)',43,'6.2.5','b0477136-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1168,'Xenserver','SUSE Linux Enterprise Server 10 SP2 (64-bit)',44,'6.2.5','b0477b5e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1169,'Xenserver','SUSE Linux Enterprise Server 10 SP3 (32-bit)',151,'6.2.5','b0478626-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1170,'Xenserver','SUSE Linux Enterprise Server 10 SP3 (64-bit)',45,'6.2.5','b0479094-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1171,'Xenserver','SUSE Linux Enterprise Server 10 SP4 (32-bit)',153,'6.2.5','b0479b5c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1172,'Xenserver','SUSE Linux Enterprise Server 10 SP4 (64-bit)',152,'6.2.5','b047a674-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1173,'Xenserver','SUSE Linux Enterprise Server 11 (32-bit)',46,'6.2.5','b047b1a0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1174,'Xenserver','SUSE Linux Enterprise Server 11 (64-bit)',47,'6.2.5','b047bd08-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1175,'Xenserver','SUSE Linux Enterprise Server 11 SP1 (32-bit)',155,'6.2.5','b047c866-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1176,'Xenserver','SUSE Linux Enterprise Server 11 SP1 (64-bit)',154,'6.2.5','b047d3ba-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1177,'Xenserver','SUSE Linux Enterprise Server 11 SP2 (32-bit)',186,'6.2.5','b047d932-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1178,'Xenserver','SUSE Linux Enterprise Server 11 SP2 (64-bit)',185,'6.2.5','b047e1f2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1179,'Xenserver','Windows 7 (32-bit)',48,'6.2.5','b047eec2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1180,'Xenserver','Windows 7 (64-bit)',49,'6.2.5','b047f944-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1181,'Xenserver','Windows 8 (32-bit)',165,'6.2.5','b0480466-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1182,'Xenserver','Windows 8 (64-bit)',166,'6.2.5','b0480f88-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1183,'Xenserver','Windows Server 2003 (32-bit)',50,'6.2.5','b0481a82-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1184,'Xenserver','Windows Server 2003 (64-bit)',51,'6.2.5','b048232e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1185,'Xenserver','Windows Server 2003 (32-bit)',87,'6.2.5','b0482e46-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1186,'Xenserver','Windows Server 2003 (64-bit)',88,'6.2.5','b048392c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1187,'Xenserver','Windows Server 2003 (32-bit)',89,'6.2.5','b0484462-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1188,'Xenserver','Windows Server 2003 (64-bit)',90,'6.2.5','b0484eee-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1189,'Xenserver','Windows Server 2008 R2 (64-bit)',54,'6.2.5','b04859b6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1190,'Xenserver','Windows Server 2012 (64-bit)',167,'6.2.5','b04863ca-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1191,'Xenserver','Windows Server 2012 (64-bit)',168,'6.2.5','b0487194-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1192,'Xenserver','Windows XP SP3 (32-bit)',58,'6.2.5','b0487c3e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1193,'Xenserver','Ubuntu Lucid Lynx 10.04 (32-bit)',121,'6.2.5','b0488864-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1194,'Xenserver','Ubuntu Lucid Lynx 10.04 (64-bit)',126,'6.2.5','b04894a8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1195,'Xenserver','Ubuntu Maverick Meerkat 10.10 (32-bit) (experimental)',156,'6.2.5','b0489f52-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1196,'Xenserver','Ubuntu Maverick Meerkat 10.10 (64-bit) (experimental)',157,'6.2.5','b048aa38-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1197,'Xenserver','Ubuntu Precise Pangolin 12.04 (32-bit)',163,'6.2.5','b048b758-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1198,'Xenserver','Ubuntu Precise Pangolin 12.04 (64-bit)',164,'6.2.5','b048c0c2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1199,'Xenserver','Other install media',169,'6.2.5','b048cc52-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1200,'Xenserver','Other install media',170,'6.2.5','b048d80a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1201,'Xenserver','Other install media',98,'6.2.5','b048e2e6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1202,'Xenserver','Other install media',99,'6.2.5','b048ed4a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1203,'Xenserver','Other install media',60,'6.2.5','b048f7cc-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1204,'Xenserver','Other install media',103,'6.2.5','b049029e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1205,'Xenserver','Other install media',200,'6.2.5','b0490c58-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1206,'Xenserver','Other install media',201,'6.2.5','b04916c6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1207,'Xenserver','Other install media',59,'6.2.5','b04920b2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1208,'Xenserver','Other install media',100,'6.2.5','b0492c24-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1209,'Xenserver','Other install media',202,'6.2.5','b0493778-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1210,'Xenserver','Other install media',203,'6.2.5','b049424a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1211,'Xenserver','CentOS 5 (32-bit)',139,'6.2.5','b0494e16-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1212,'Xenserver','CentOS 5 (64-bit)',140,'6.2.5','b0495d84-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1213,'KVM','CentOS 5 (64-bit)',140,'default','b04cff20-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1214,'KVM','Red Hat Enterprise Linux 6.0',136,'default','b04d11b8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1215,'KVM','Red Hat Enterprise Linux 6.0',137,'default','b04d245a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1216,'KVM','Ubuntu 12.04',164,'default','b04d3076-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1217,'KVM','Ubuntu 10.10',156,'default','b04d417e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1218,'KVM','Ubuntu 10.10',157,'default','b04d5128-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1219,'KVM','Debian GNU/Linux 5',72,'default','b04d63f2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1220,'KVM','Debian GNU/Linux 5',15,'default','b04d7478-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1221,'KVM','Debian GNU/Linux 6',133,'default','b04d8404-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1222,'KVM','Debian GNU/Linux 6',132,'default','b04d9250-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1223,'KVM','Other Linux',69,'default','b04da128-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1224,'KVM','Other Linux',70,'default','b04daf88-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1225,'KVM','Windows Server 2008',54,'default','b04dbde8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1226,'KVM','Windows 2000',105,'default','b04dcd24-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1227,'KVM','Windows NT',64,'default','b04ddc7e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1228,'KVM','Windows 3.1',65,'default','b04dec5a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1229,'KVM','Other PV',160,'default','b04dfa88-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1230,'KVM','FreeBSD 10',225,'default','b04e0cb2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1231,'KVM','FreeBSD 10',226,'default','b04e1932-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1232,'KVM','Other PV',139,'default','b04e27d8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1233,'KVM','Other PV',140,'default','b04e32f0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1234,'VMware','rhel5Guest',149,'4.0','b04e3e1c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1235,'VMware','windows8Server64Guest',168,'4.0','b04e497a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1236,'VMware','rhel5_64Guest',114,'4.0','b04e547e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1237,'VMware','rhel6Guest',205,'4.0','b04e60b8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1238,'VMware','rhel5Guest',34,'4.0','b04e6e14-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1239,'VMware','rhel5_64Guest',33,'4.0','b04e78d2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1240,'VMware','winVistaGuest',56,'4.0','b04e8390-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1241,'VMware','rhel6Guest',197,'4.0','b04e8cbe-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1242,'VMware','suse64Guest',203,'4.0','b04e97c2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1243,'VMware','centosGuest',143,'4.0','b04eaf28-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1244,'VMware','rhel6_64Guest',204,'4.0','b04eba86-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1245,'VMware','ubuntu64Guest',130,'4.0','b04ec53a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1246,'VMware','rhel5Guest',38,'4.0','b04ecfb2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1247,'VMware','win2000ServGuest',55,'4.0','b04ed91c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1248,'VMware','darwin11_64Guest',224,'4.0','b04ee2fe-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1249,'VMware','rhel4Guest',28,'4.0','b04eee84-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1250,'VMware','debian4Guest',73,'4.0','b04efb7c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1251,'VMware','winNetEnterprise64Guest',51,'4.0','b04f0a40-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1252,'VMware','darwin10_64Guest',222,'4.0','b04f1742-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1253,'VMware','rhel5Guest',32,'4.0','b04f235e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1254,'VMware','suseGuest',96,'4.0','b04f2eee-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1255,'VMware','other26xLinuxGuest',75,'4.0','b04f3ba0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1256,'VMware','winXPProGuest',93,'4.0','b04f4afa-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1257,'VMware','suseGuest',202,'4.0','b04f55a4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1258,'VMware','winNetDatacenterGuest',87,'4.0','b04f64f4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1259,'VMware','ubuntu64Guest',100,'4.0','b04f6fc6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1260,'VMware','darwin11Guest',223,'4.0','b04f7ab6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1261,'VMware','windows8_64Guest',166,'4.0','b04f86e6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1262,'VMware','debian4_64Guest',74,'4.0','b04f910e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1263,'VMware','rhel5_64Guest',37,'4.0','b04f978a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1264,'VMware','windows7Guest',48,'4.0','b04fa298-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1265,'VMware','asianux3Guest',69,'4.0','b04fab9e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1266,'VMware','otherGuest64',103,'4.0','b04fb59e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1267,'VMware','winVista64Guest',101,'4.0','b04fbefe-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1268,'VMware','centosGuest',111,'4.0','b04fc962-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1269,'VMware','ubuntu64Guest',128,'4.0','b04fd420-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1270,'VMware','rhel5Guest',191,'4.0','b04fdf4c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1271,'VMware','rhel6Guest',195,'4.0','b04fe988-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1272,'VMware','winLonghorn64Guest',54,'4.0','b04ff2ca-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1273,'VMware','darwin10Guest',221,'4.0','b04ffd4c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1274,'VMware','centosGuest',11,'4.0','b050090e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1275,'VMware','winNetWebGuest',91,'4.0','b0501192-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1276,'VMware','asianux3_64Guest',70,'4.0','b0501ac0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1277,'VMware','solaris10Guest',79,'4.0','b05023d0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1278,'VMware','ubuntuGuest',124,'4.0','b0502bd2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1279,'VMware','otherLinux64Guest',99,'4.0','b0503852-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1280,'VMware','rhel6Guest',199,'4.0','b05042a2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1281,'VMware','freebsdGuest',83,'4.0','b0504d2e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1282,'VMware','winNetStandardGuest',89,'4.0','b05059ea-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1283,'VMware','solaris10_64Guest',80,'4.0','b0506642-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1284,'VMware','win98Guest',62,'4.0','b0506ef8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1285,'VMware','ubuntu64Guest',129,'4.0','b0507baa-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1286,'VMware','rhel5_64Guest',35,'4.0','b0508866-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1287,'VMware','winNetStandard64Guest',90,'4.0','b05093d8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1288,'VMware','winNetEnterpriseGuest',50,'4.0','b0509c5c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1289,'VMware','rhel6Guest',136,'4.0','b050a576-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1290,'VMware','win95Guest',63,'4.0','b050ade6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1291,'VMware','win31Guest',65,'4.0','b050b656-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1292,'VMware','centosGuest',5,'4.0','b050be9e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1293,'VMware','suse64Guest',110,'4.0','b050c72c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1294,'VMware','debian5Guest',15,'4.0','b050d08c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1295,'VMware','rhel6_64Guest',198,'4.0','b050dcc6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1296,'VMware','debian5_64Guest',72,'4.0','b050e4dc-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1297,'VMware','ubuntuGuest',123,'4.0','b050edf6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1298,'VMware','rhel6_64Guest',196,'4.0','b050f800-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1299,'VMware','rhel5_64Guest',192,'4.0','b05102e6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1300,'VMware','centos64Guest',8,'4.0','b0511916-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1301,'VMware','winXPProGuest',58,'4.0','b0512348-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1302,'VMware','windows8Guest',165,'4.0','b0512d8e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1303,'VMware','rhel4Guest',26,'4.0','b0513784-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1304,'VMware','rhel6_64Guest',206,'4.0','b0514102-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1305,'VMware','winNetDatacenter64Guest',88,'4.0','b0514a26-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1306,'VMware','rhel5Guest',30,'4.0','b05152f0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1307,'VMware','rhel6_64Guest',137,'4.0','b0515c64-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1308,'VMware','ubuntuGuest',163,'4.0','b0516646-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1309,'VMware','ubuntuGuest',156,'4.0','b051701e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1310,'VMware','rhel5Guest',36,'4.0','b0517d52-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1311,'VMware','centosGuest',13,'4.0','b0518770-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1312,'VMware','windows8Server64Guest',167,'4.0','b05190da-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1313,'VMware','winXPProGuest',57,'4.0','b05198a0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1314,'VMware','centosGuest',141,'4.0','b051a228-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1315,'VMware','centos64Guest',12,'4.0','b051ad7c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1316,'VMware','ubuntuGuest',59,'4.0','b051b72c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1317,'VMware','netware6Guest',77,'4.0','b051bfba-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1318,'VMware','suse64Guest',97,'4.0','b051cc94-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1319,'VMware','suseGuest',109,'4.0','b051d4f0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1320,'VMware','centosGuest',1,'4.0','b051dd4c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1321,'VMware','rhel4Guest',27,'4.0','b051e788-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1322,'VMware','rhel5_64Guest',31,'4.0','b051f124-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1323,'VMware','rhel5Guest',193,'4.0','b051fc3c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1324,'VMware','solaris8Guest',82,'4.0','b052079a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1325,'VMware','rhel5_64Guest',150,'4.0','b052133e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1326,'VMware','rhel5_64Guest',39,'4.0','b0521e9c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1327,'VMware','rhel5_64Guest',190,'4.0','b0522ab8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1328,'VMware','ubuntuGuest',125,'4.0','b052347c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1329,'VMware','os2Guest',104,'4.0','b0523e4a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1330,'VMware','rhel2Guest',131,'4.0','b05246b0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1331,'VMware','centos64Guest',112,'4.0','b0524f8e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1332,'VMware','centos64Guest',201,'4.0','b0525b64-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1333,'VMware','rhel5Guest',189,'4.0','b05265be-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1334,'VMware','winXPPro64Guest',94,'4.0','b0526ec4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1335,'VMware','otherLinuxGuest',98,'4.0','b05277b6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1336,'VMware','suse64Guest',108,'4.0','b05281f2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1337,'VMware','ubuntu64Guest',157,'4.0','b0528b66-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1338,'VMware','centos64Guest',6,'4.0','b052955c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1339,'VMware','ubuntu64Guest',126,'4.0','b052aa06-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1340,'VMware','rhel5_64Guest',194,'4.0','b052b3b6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1341,'VMware','unixWare7Guest',86,'4.0','b052bd2a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1342,'VMware','win2000AdvServGuest',95,'4.0','b052c59a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1343,'VMware','centos64Guest',144,'4.0','b052d0b2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1344,'VMware','ubuntu64Guest',127,'4.0','b052da80-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1345,'VMware','winNetBusinessGuest',92,'4.0','b052e444-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1346,'VMware','dosGuest',102,'4.0','b052f146-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1347,'VMware','win2000ServGuest',61,'4.0','b052f9c0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1348,'VMware','windows7_64Guest',49,'4.0','b05302f8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1349,'VMware','win2000ProGuest',105,'4.0','b0530c94-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1350,'VMware','netware5Guest',78,'4.0','b05314fa-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1351,'VMware','centosGuest',7,'4.0','b0531eb4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1352,'VMware','otherGuest',85,'4.0','b0532724-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1353,'VMware','centosGuest',200,'4.0','b05330a2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1354,'VMware','ubuntuGuest',122,'4.0','b0533a20-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1355,'VMware','ubuntuGuest',121,'4.0','b053459c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1356,'VMware','oesGuest',68,'4.0','b0534e5c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1357,'VMware','winLonghornGuest',52,'4.0','b053574e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1358,'VMware','centosGuest',3,'4.0','b053604a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1359,'VMware','rhel4Guest',29,'4.0','b0536f7c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1360,'VMware','other26xLinux64Guest',76,'4.0','b0537aee-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1361,'VMware','freebsd64Guest',84,'4.0','b0538674-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1362,'VMware','centosGuest',9,'4.0','b0538fa2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1363,'VMware','solaris9Guest',81,'4.0','b053988a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1364,'VMware','otherGuest',60,'4.0','b053a316-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1365,'VMware','winLonghorn64Guest',53,'4.0','b053abea-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1366,'VMware','rhel5Guest',113,'4.0','b053b59a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1367,'VMware','suseGuest',107,'4.0','b053c0f8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1368,'VMware','centosGuest',4,'4.0','b053cc10-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1369,'VMware','centos64Guest',14,'4.0','b053d6f6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1370,'VMware','centos64Guest',10,'4.0','b053e222-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1371,'VMware','winNTGuest',64,'4.0','b053ebdc-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1372,'VMware','centos64Guest',142,'4.0','b053f55a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1373,'VMware','centosGuest',2,'4.0','b053ff8c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1374,'VMware','ubuntu64Guest',164,'4.0','b0540a04-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1375,'VMware','rhel5Guest',149,'4.1','b05416a2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1376,'VMware','windows8Server64Guest',168,'4.1','b0542142-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1377,'VMware','rhel5_64Guest',114,'4.1','b0542cd2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1378,'VMware','rhel6Guest',205,'4.1','b054377c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1379,'VMware','rhel5Guest',34,'4.1','b05442f8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1380,'VMware','rhel5_64Guest',33,'4.1','b0544e4c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1381,'VMware','winVistaGuest',56,'4.1','b05458b0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1382,'VMware','rhel6Guest',197,'4.1','b05463f0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1383,'VMware','suse64Guest',203,'4.1','b0546de6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1384,'VMware','centosGuest',143,'4.1','b05477dc-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1385,'VMware','rhel6_64Guest',204,'4.1','b05481aa-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1386,'VMware','ubuntu64Guest',130,'4.1','b0548ba0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1387,'VMware','rhel5Guest',38,'4.1','b054965e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1388,'VMware','win2000ServGuest',55,'4.1','b054a0fe-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1389,'VMware','darwin11_64Guest',224,'4.1','b054ab08-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1390,'VMware','rhel4Guest',28,'4.1','b054b698-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1391,'VMware','debian4Guest',73,'4.1','b054c228-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1392,'VMware','winNetEnterprise64Guest',51,'4.1','b054cdea-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1393,'VMware','darwin10_64Guest',222,'4.1','b054d93e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1394,'VMware','rhel5Guest',32,'4.1','b054e5be-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1395,'VMware','suseGuest',96,'4.1','b054f004-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1396,'VMware','other26xLinuxGuest',75,'4.1','b054fa18-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1397,'VMware','winXPProGuest',93,'4.1','b05503e6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1398,'VMware','suseGuest',202,'4.1','b0550e54-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1399,'VMware','winNetDatacenterGuest',87,'4.1','b0551b42-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1400,'VMware','ubuntu64Guest',100,'4.1','b05526be-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1401,'VMware','darwin11Guest',223,'4.1','b05531f4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1402,'VMware','windows8_64Guest',166,'4.1','b0553d2a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1403,'VMware','debian4_64Guest',74,'4.1','b055481a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1404,'VMware','rhel5_64Guest',37,'4.1','b055522e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1405,'VMware','windows7Guest',48,'4.1','b0555c10-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1406,'VMware','asianux3Guest',69,'4.1','b05565e8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1407,'VMware','otherGuest64',103,'4.1','b0556fac-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1408,'VMware','winVista64Guest',101,'4.1','b055795c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1409,'VMware','centosGuest',111,'4.1','b0558370-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1410,'VMware','ubuntu64Guest',128,'4.1','b0558d3e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1411,'VMware','rhel5Guest',191,'4.1','b0559702-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1412,'VMware','rhel6Guest',195,'4.1','b055a54e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1413,'VMware','winLonghorn64Guest',54,'4.1','b055af94-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1414,'VMware','darwin10Guest',221,'4.1','b055b80e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1415,'VMware','centosGuest',11,'4.1','b055c312-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1416,'VMware','winNetWebGuest',91,'4.1','b055cf6a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1417,'VMware','asianux3_64Guest',70,'4.1','b055d988-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1418,'VMware','solaris10Guest',79,'4.1','b055e37e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1419,'VMware','ubuntuGuest',124,'4.1','b055ed56-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1420,'VMware','otherLinux64Guest',99,'4.1','b055f76a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1421,'VMware','rhel6Guest',199,'4.1','b05601c4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1422,'VMware','freebsdGuest',83,'4.1','b0560bd8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1423,'VMware','winNetStandardGuest',89,'4.1','b0561650-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1424,'VMware','solaris10_64Guest',80,'4.1','b05623b6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1425,'VMware','win98Guest',62,'4.1','b0562c3a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1426,'VMware','ubuntu64Guest',129,'4.1','b056370c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1427,'VMware','rhel5_64Guest',35,'4.1','b05641de-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1428,'VMware','winNetStandard64Guest',90,'4.1','b0564d32-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1429,'VMware','winNetEnterpriseGuest',50,'4.1','b05658b8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1430,'VMware','rhel6Guest',136,'4.1','b05664b6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1431,'VMware','win95Guest',63,'4.1','b0566fec-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1432,'VMware','win31Guest',65,'4.1','b0567b22-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1433,'VMware','centosGuest',5,'4.1','b05686f8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1434,'VMware','suse64Guest',110,'4.1','b0569210-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1435,'VMware','debian5Guest',15,'4.1','b0569cf6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1436,'VMware','rhel6_64Guest',198,'4.1','b056a700-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1437,'VMware','debian5_64Guest',72,'4.1','b056b272-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1438,'VMware','ubuntuGuest',123,'4.1','b056c03c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1439,'VMware','rhel6_64Guest',196,'4.1','b056ca5a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1440,'VMware','rhel5_64Guest',192,'4.1','b056d61c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1441,'VMware','centos64Guest',8,'4.1','b056ec56-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1442,'VMware','winXPProGuest',58,'4.1','b056f746-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1443,'VMware','windows8Guest',165,'4.1','b0570326-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1444,'VMware','rhel4Guest',26,'4.1','b0570dda-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1445,'VMware','rhel6_64Guest',206,'4.1','b05717d0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1446,'VMware','winNetDatacenter64Guest',88,'4.1','b05722a2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1447,'VMware','rhel5Guest',30,'4.1','b0573152-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1448,'VMware','rhel6_64Guest',137,'4.1','b0573ada-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1449,'VMware','ubuntuGuest',163,'4.1','b05743ea-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1450,'VMware','ubuntuGuest',156,'4.1','b0574d04-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1451,'VMware','rhel5Guest',36,'4.1','b0575650-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1452,'VMware','centosGuest',13,'4.1','b0576406-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1453,'VMware','windows8Server64Guest',167,'4.1','b0576dca-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1454,'VMware','winXPProGuest',57,'4.1','b05776c6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1455,'VMware','centosGuest',141,'4.1','b0577fea-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1456,'VMware','centos64Guest',12,'4.1','b05788f0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1457,'VMware','ubuntuGuest',59,'4.1','b0579250-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1458,'VMware','netware6Guest',77,'4.1','b0579be2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1459,'VMware','suse64Guest',97,'4.1','b057a7ae-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1460,'VMware','suseGuest',109,'4.1','b057b168-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1461,'VMware','centosGuest',1,'4.1','b057bc26-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1462,'VMware','rhel4Guest',27,'4.1','b057c61c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1463,'VMware','rhel5_64Guest',31,'4.1','b057cf90-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1464,'VMware','rhel5Guest',193,'4.1','b057da62-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1465,'VMware','solaris8Guest',82,'4.1','b057e502-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1466,'VMware','rhel5_64Guest',150,'4.1','b057f02e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1467,'VMware','rhel5_64Guest',39,'4.1','b057fac4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1468,'VMware','rhel5_64Guest',190,'4.1','b058053c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1469,'VMware','ubuntuGuest',125,'4.1','b05810c2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1470,'VMware','os2Guest',104,'4.1','b0581bc6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1471,'VMware','rhel2Guest',131,'4.1','b05825d0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1472,'VMware','centos64Guest',112,'4.1','b0583138-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1473,'VMware','centos64Guest',201,'4.1','b0583ad4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1474,'VMware','rhel5Guest',189,'4.1','b0584614-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1475,'VMware','winXPPro64Guest',94,'4.1','b05852ee-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1476,'VMware','otherLinuxGuest',98,'4.1','b0585cf8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1477,'VMware','suse64Guest',108,'4.1','b0586766-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1478,'VMware','ubuntu64Guest',157,'4.1','b058736e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1479,'VMware','centos64Guest',6,'4.1','b0587ecc-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1480,'VMware','ubuntu64Guest',126,'4.1','b0588c5a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1481,'VMware','rhel5_64Guest',194,'4.1','b0589858-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1482,'VMware','unixWare7Guest',86,'4.1','b058af00-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1483,'VMware','win2000AdvServGuest',95,'4.1','b058baa4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1484,'VMware','centos64Guest',144,'4.1','b058c5d0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1485,'VMware','ubuntu64Guest',127,'4.1','b058d0a2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1486,'VMware','winNetBusinessGuest',92,'4.1','b058db7e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1487,'VMware','dosGuest',102,'4.1','b058e696-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1488,'VMware','win2000ServGuest',61,'4.1','b058f474-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1489,'VMware','windows7_64Guest',49,'4.1','b058fd8e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1490,'VMware','win2000ProGuest',105,'4.1','b0590798-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1491,'VMware','netware5Guest',78,'4.1','b05910a8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1492,'VMware','centosGuest',7,'4.1','b0591b84-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1493,'VMware','otherGuest',85,'4.1','b05926a6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1494,'VMware','centosGuest',200,'4.1','b05930e2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1495,'VMware','ubuntuGuest',122,'4.1','b0593ae2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1496,'VMware','ubuntuGuest',121,'4.1','b05943de-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1497,'VMware','oesGuest',68,'4.1','b0594df2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1498,'VMware','winLonghornGuest',52,'4.1','b05956e4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1499,'VMware','centosGuest',3,'4.1','b0596152-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1500,'VMware','rhel4Guest',29,'4.1','b0596d00-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1501,'VMware','other26xLinux64Guest',76,'4.1','b059773c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1502,'VMware','freebsd64Guest',84,'4.1','b0598196-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1503,'VMware','centosGuest',9,'4.1','b0598cae-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1504,'VMware','solaris9Guest',81,'4.1','b05997d0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1505,'VMware','otherGuest',60,'4.1','b059a61c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1506,'VMware','winLonghorn64Guest',53,'4.1','b059b09e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1507,'VMware','rhel5Guest',113,'4.1','b059bb8e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1508,'VMware','suseGuest',107,'4.1','b059c598-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1509,'VMware','centosGuest',4,'4.1','b059d0ba-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1510,'VMware','centos64Guest',14,'4.1','b059dbdc-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1511,'VMware','centos64Guest',10,'4.1','b059e618-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1512,'VMware','winNTGuest',64,'4.1','b059f00e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1513,'VMware','centos64Guest',142,'4.1','b059fa4a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1514,'VMware','centosGuest',2,'4.1','b05a04c2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1515,'VMware','ubuntu64Guest',164,'4.1','b05a0e7c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1516,'VMware','rhel5Guest',149,'5.0','b05a1a0c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1517,'VMware','windows8Server64Guest',168,'5.0','b05a236c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1518,'VMware','rhel5_64Guest',114,'5.0','b05a2d08-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1519,'VMware','rhel6Guest',205,'5.0','b05a353c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1520,'VMware','rhel5Guest',34,'5.0','b05a3ee2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1521,'VMware','rhel5_64Guest',33,'5.0','b05a4766-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1522,'VMware','winVistaGuest',56,'5.0','b05a510c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1523,'VMware','rhel6Guest',197,'5.0','b05a5b20-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1524,'VMware','suse64Guest',203,'5.0','b05a64e4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1525,'VMware','centosGuest',143,'5.0','b05a6f70-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1526,'VMware','rhel6_64Guest',204,'5.0','b05a7948-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1527,'VMware','ubuntu64Guest',130,'5.0','b05a8316-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1528,'VMware','rhel5Guest',38,'5.0','b05a8ee2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1529,'VMware','win2000ServGuest',55,'5.0','b05a9a0e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1530,'VMware','darwin11_64Guest',224,'5.0','b05aa562-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1531,'VMware','rhel4Guest',28,'5.0','b05ab002-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1532,'VMware','debian4Guest',73,'5.0','b05aba52-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1533,'VMware','winNetEnterprise64Guest',51,'5.0','b05ac434-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1534,'VMware','darwin10_64Guest',222,'5.0','b05ace70-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1535,'VMware','rhel5Guest',32,'5.0','b05ad852-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1536,'VMware','suseGuest',96,'5.0','b05ae266-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1537,'VMware','other26xLinuxGuest',75,'5.0','b05aedc4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1538,'VMware','winXPProGuest',93,'5.0','b05af850-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1539,'VMware','suseGuest',202,'5.0','b05b0296-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1540,'VMware','winNetDatacenterGuest',87,'5.0','b05b0c14-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1541,'VMware','ubuntu64Guest',100,'5.0','b05b1632-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1542,'VMware','darwin11Guest',223,'5.0','b05b223a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1543,'VMware','windows8_64Guest',166,'5.0','b05b2c94-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1544,'VMware','debian4_64Guest',74,'5.0','b05b53a4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1545,'VMware','rhel5_64Guest',37,'5.0','b05b5ca0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1546,'VMware','windows7Guest',48,'5.0','b05b674a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1547,'VMware','asianux3Guest',69,'5.0','b05b7460-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1548,'VMware','otherGuest64',103,'5.0','b05b8022-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1549,'VMware','winVista64Guest',101,'5.0','b05b8bf8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1550,'VMware','centosGuest',111,'5.0','b05b976a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1551,'VMware','ubuntu64Guest',128,'5.0','b05ba890-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1552,'VMware','rhel5Guest',191,'5.0','b05bb5ba-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1553,'VMware','rhel6Guest',195,'5.0','b05bc06e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1554,'VMware','winLonghorn64Guest',54,'5.0','b05bc7a8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1555,'VMware','darwin10Guest',221,'5.0','b05bd2ca-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1556,'VMware','centosGuest',11,'5.0','b05bdd4c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1557,'VMware','winNetWebGuest',91,'5.0','b05be850-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1558,'VMware','asianux3_64Guest',70,'5.0','b05bf3c2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1559,'VMware','solaris10Guest',79,'5.0','b05c0966-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1560,'VMware','ubuntuGuest',124,'5.0','b05c1456-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1561,'VMware','otherLinux64Guest',99,'5.0','b05c1fc8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1562,'VMware','rhel6Guest',199,'5.0','b05c2a0e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1563,'VMware','freebsdGuest',83,'5.0','b05c3472-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1564,'VMware','winNetStandardGuest',89,'5.0','b05c3f76-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1565,'VMware','solaris10_64Guest',80,'5.0','b05c469c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1566,'VMware','win98Guest',62,'5.0','b05c4fa2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1567,'VMware','ubuntu64Guest',129,'5.0','b05c5920-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1568,'VMware','rhel5_64Guest',35,'5.0','b05c62ee-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1569,'VMware','winNetStandard64Guest',90,'5.0','b05c6d0c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1570,'VMware','winNetEnterpriseGuest',50,'5.0','b05c773e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1571,'VMware','rhel6Guest',136,'5.0','b05c81b6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1572,'VMware','win95Guest',63,'5.0','b05c8c2e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1573,'VMware','win31Guest',65,'5.0','b05c9502-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1574,'VMware','centosGuest',5,'5.0','b05c9f5c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1575,'VMware','suse64Guest',110,'5.0','b05ca952-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1576,'VMware','debian5Guest',15,'5.0','b05cb334-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1577,'VMware','rhel6_64Guest',198,'5.0','b05cbca8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1578,'VMware','debian5_64Guest',72,'5.0','b05cc77a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1579,'VMware','ubuntuGuest',123,'5.0','b05cd1c0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1580,'VMware','rhel6_64Guest',196,'5.0','b05cdbac-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1581,'VMware','rhel5_64Guest',192,'5.0','b05ce39a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1582,'VMware','centos64Guest',8,'5.0','b05cee76-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1583,'VMware','winXPProGuest',58,'5.0','b05cf83a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1584,'VMware','windows8Guest',165,'5.0','b05d0366-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1585,'VMware','rhel4Guest',26,'5.0','b05d0e06-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1586,'VMware','rhel6_64Guest',206,'5.0','b05d209e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1587,'VMware','winNetDatacenter64Guest',88,'5.0','b05d2b98-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1588,'VMware','rhel5Guest',30,'5.0','b05d3610-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1589,'VMware','rhel6_64Guest',137,'5.0','b05d415a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1590,'VMware','ubuntuGuest',163,'5.0','b05d51b8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1591,'VMware','ubuntuGuest',156,'5.0','b05d5d2a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1592,'VMware','rhel5Guest',36,'5.0','b05d6964-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1593,'VMware','centosGuest',13,'5.0','b05d7440-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1594,'VMware','windows8Server64Guest',167,'5.0','b05d8066-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1595,'VMware','winXPProGuest',57,'5.0','b05d8994-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1596,'VMware','centosGuest',141,'5.0','b05d9402-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1597,'VMware','centos64Guest',12,'5.0','b05d9f24-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1598,'VMware','ubuntuGuest',59,'5.0','b05da7da-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1599,'VMware','netware6Guest',77,'5.0','b05db5b8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1600,'VMware','suse64Guest',97,'5.0','b05dbfe0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1601,'VMware','suseGuest',109,'5.0','b05dc990-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1602,'VMware','centosGuest',1,'5.0','b05dd41c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1603,'VMware','rhel4Guest',27,'5.0','b05ddd86-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1604,'VMware','rhel5_64Guest',31,'5.0','b05de7ea-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1605,'VMware','rhel5Guest',193,'5.0','b05df212-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1606,'VMware','solaris8Guest',82,'5.0','b05dfc80-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1607,'VMware','rhel5_64Guest',150,'5.0','b05e0766-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1608,'VMware','rhel5_64Guest',39,'5.0','b05e10c6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1609,'VMware','rhel5_64Guest',190,'5.0','b05e1b5c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1610,'VMware','ubuntuGuest',125,'5.0','b05e2408-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1611,'VMware','os2Guest',104,'5.0','b05e2f02-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1612,'VMware','rhel2Guest',131,'5.0','b05e397a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1613,'VMware','centos64Guest',112,'5.0','b05e6094-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1614,'VMware','centos64Guest',201,'5.0','b05e6972-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1615,'VMware','rhel5Guest',189,'5.0','b05e72b4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1616,'VMware','winXPPro64Guest',94,'5.0','b05e7cf0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1617,'VMware','otherLinuxGuest',98,'5.0','b05e8740-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1618,'VMware','suse64Guest',108,'5.0','b05e90b4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1619,'VMware','ubuntu64Guest',157,'5.0','b05e9d5c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1620,'VMware','centos64Guest',6,'5.0','b05ea6b2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1621,'VMware','ubuntu64Guest',126,'5.0','b05eb0a8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1622,'VMware','rhel5_64Guest',194,'5.0','b05eb954-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1623,'VMware','unixWare7Guest',86,'5.0','b05ec444-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1624,'VMware','win2000AdvServGuest',95,'5.0','b05ed5e2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1625,'VMware','centos64Guest',144,'5.0','b05ee10e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1626,'VMware','ubuntu64Guest',127,'5.0','b05eee1a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1627,'VMware','winNetBusinessGuest',92,'5.0','b05ef838-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1628,'VMware','dosGuest',102,'5.0','b05f029c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1629,'VMware','win2000ServGuest',61,'5.0','b05f0bb6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1630,'VMware','windows7_64Guest',49,'5.0','b05f16b0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1631,'VMware','win2000ProGuest',105,'5.0','b05f2074-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1632,'VMware','netware5Guest',78,'5.0','b05f2af6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1633,'VMware','centosGuest',7,'5.0','b05f35c8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1634,'VMware','otherGuest',85,'5.0','b05f42b6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1635,'VMware','centosGuest',200,'5.0','b05f4c16-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1636,'VMware','ubuntuGuest',122,'5.0','b05f53e6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1637,'VMware','ubuntuGuest',121,'5.0','b05f5cb0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1638,'VMware','oesGuest',68,'5.0','b05f661a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1639,'VMware','winLonghornGuest',52,'5.0','b05f7114-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1640,'VMware','centosGuest',3,'5.0','b05f7b8c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1641,'VMware','rhel4Guest',29,'5.0','b05f84c4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1642,'VMware','other26xLinux64Guest',76,'5.0','b05f9112-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1643,'VMware','freebsd64Guest',84,'5.0','b05f9aa4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1644,'VMware','centosGuest',9,'5.0','b05fa21a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1645,'VMware','solaris9Guest',81,'5.0','b05faac6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1646,'VMware','otherGuest',60,'5.0','b05fb3cc-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1647,'VMware','winLonghorn64Guest',53,'5.0','b05fbef8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1648,'VMware','rhel5Guest',113,'5.0','b05fc9ca-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1649,'VMware','suseGuest',107,'5.0','b05fd4e2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1650,'VMware','centosGuest',4,'5.0','b05fdfb4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1651,'VMware','centos64Guest',14,'5.0','b05fea9a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1652,'VMware','centos64Guest',10,'5.0','b05ff53a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1653,'VMware','winNTGuest',64,'5.0','b0600070-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1654,'VMware','centos64Guest',142,'5.0','b0600d7c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1655,'VMware','centosGuest',2,'5.0','b06016c8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1656,'VMware','ubuntu64Guest',164,'5.0','b0601f60-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1657,'VMware','rhel5Guest',149,'5.1','b0602884-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1658,'VMware','windows8Server64Guest',168,'5.1','b0603356-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1659,'VMware','rhel5_64Guest',114,'5.1','b0603e0a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1660,'VMware','rhel6Guest',205,'5.1','b0604918-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1661,'VMware','rhel5Guest',34,'5.1','b0605ebc-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1662,'VMware','rhel5_64Guest',33,'5.1','b06069de-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1663,'VMware','winVistaGuest',56,'5.1','b06074c4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1664,'VMware','rhel6Guest',197,'5.1','b0608504-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1665,'VMware','suse64Guest',203,'5.1','b0608d4c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1666,'VMware','centosGuest',143,'5.1','b060981e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1667,'VMware','rhel6_64Guest',204,'5.1','b060a1d8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1668,'VMware','ubuntu64Guest',130,'5.1','b060abd8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1669,'VMware','rhel5Guest',38,'5.1','b060b308-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1670,'VMware','win2000ServGuest',55,'5.1','b060be16-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1671,'VMware','darwin11_64Guest',224,'5.1','b060c87a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1672,'VMware','rhel4Guest',28,'5.1','b060d338-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1673,'VMware','debian4Guest',73,'5.1','b060da04-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1674,'VMware','winNetEnterprise64Guest',51,'5.1','b060e486-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1675,'VMware','darwin10_64Guest',222,'5.1','b060eec2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1676,'VMware','rhel5Guest',32,'5.1','b060f912-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1677,'VMware','suseGuest',96,'5.1','b061025e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1678,'VMware','other26xLinuxGuest',75,'5.1','b0610c36-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1679,'VMware','winXPProGuest',93,'5.1','b0611708-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1680,'VMware','suseGuest',202,'5.1','b061298c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1681,'VMware','winNetDatacenterGuest',87,'5.1','b0613418-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1682,'VMware','ubuntu64Guest',100,'5.1','b0613ed6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1683,'VMware','darwin11Guest',223,'5.1','b0614930-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1684,'VMware','windows8_64Guest',166,'5.1','b061533a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1685,'VMware','debian4_64Guest',74,'5.1','b0615d94-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1686,'VMware','rhel5_64Guest',37,'5.1','b0616910-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1687,'VMware','windows7Guest',48,'5.1','b061748c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1688,'VMware','asianux3Guest',69,'5.1','b0617f90-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1689,'VMware','otherGuest64',103,'5.1','b0618a62-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1690,'VMware','winVista64Guest',101,'5.1','b0619566-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1691,'VMware','centosGuest',111,'5.1','b061bd66-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1692,'VMware','ubuntu64Guest',128,'5.1','b061c4f0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1693,'VMware','rhel5Guest',191,'5.1','b061cf90-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1694,'VMware','rhel6Guest',195,'5.1','b061db34-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1695,'VMware','winLonghorn64Guest',54,'5.1','b061e73c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1696,'VMware','darwin10Guest',221,'5.1','b061f268-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1697,'VMware','centosGuest',11,'5.1','b061fb8c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1698,'VMware','winNetWebGuest',91,'5.1','b0620564-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1699,'VMware','asianux3_64Guest',70,'5.1','b0620f1e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1700,'VMware','solaris10Guest',79,'5.1','b0621a9a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1701,'VMware','ubuntuGuest',124,'5.1','b0622486-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1702,'VMware','otherLinux64Guest',99,'5.1','b0622dd2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1703,'VMware','rhel6Guest',199,'5.1','b06238a4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1704,'VMware','freebsdGuest',83,'5.1','b0624358-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1705,'VMware','winNetStandardGuest',89,'5.1','b0624e84-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1706,'VMware','solaris10_64Guest',80,'5.1','b06259d8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1707,'VMware','win98Guest',62,'5.1','b0626360-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1708,'VMware','ubuntu64Guest',129,'5.1','b0627094-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1709,'VMware','rhel5_64Guest',35,'5.1','b0627f9e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1710,'VMware','winNetStandard64Guest',90,'5.1','b0628caa-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1711,'VMware','winNetEnterpriseGuest',50,'5.1','b06298c6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1712,'VMware','rhel6Guest',136,'5.1','b062a366-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1713,'VMware','win95Guest',63,'5.1','b062ae2e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1714,'VMware','win31Guest',65,'5.1','b062b748-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1715,'VMware','centosGuest',5,'5.1','b062c1b6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1716,'VMware','suse64Guest',110,'5.1','b062cc9c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1717,'VMware','debian5Guest',15,'5.1','b062d61a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1718,'VMware','rhel6_64Guest',198,'5.1','b062e2ae-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1719,'VMware','debian5_64Guest',72,'5.1','b062ebf0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1720,'VMware','ubuntuGuest',123,'5.1','b062f53c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1721,'VMware','rhel6_64Guest',196,'5.1','b062fdde-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1722,'VMware','rhel5_64Guest',192,'5.1','b0630752-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1723,'VMware','centos64Guest',8,'5.1','b06314cc-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1724,'VMware','winXPProGuest',58,'5.1','b06320de-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1725,'VMware','windows8Guest',165,'5.1','b06329b2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1726,'VMware','rhel4Guest',26,'5.1','b0633646-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1727,'VMware','rhel6_64Guest',206,'5.1','b0633eac-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1728,'VMware','winNetDatacenter64Guest',88,'5.1','b0634b04-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1729,'VMware','rhel5Guest',30,'5.1','b0635568-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1730,'VMware','rhel6_64Guest',137,'5.1','b0635ea0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1731,'VMware','ubuntuGuest',163,'5.1','b06373d6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1732,'VMware','ubuntuGuest',156,'5.1','b0637d86-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1733,'VMware','rhel5Guest',36,'5.1','b06386aa-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1734,'VMware','centosGuest',13,'5.1','b0638fa6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1735,'VMware','windows8Server64Guest',167,'5.1','b0639adc-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1736,'VMware','winXPProGuest',57,'5.1','b063a48c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1737,'VMware','centosGuest',141,'5.1','b063af7c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1738,'VMware','centos64Guest',12,'5.1','b063baa8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1739,'VMware','ubuntuGuest',59,'5.1','b063c5e8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1740,'VMware','netware6Guest',77,'5.1','b063d0d8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1741,'VMware','suse64Guest',97,'5.1','b063dba0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1742,'VMware','suseGuest',109,'5.1','b063e53c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1743,'VMware','centosGuest',1,'5.1','b063effa-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1744,'VMware','rhel4Guest',27,'5.1','b063fa5e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1745,'VMware','rhel5_64Guest',31,'5.1','b0640652-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1746,'VMware','rhel5Guest',193,'5.1','b0640f44-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1747,'VMware','solaris8Guest',82,'5.1','b06419b2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1748,'VMware','rhel5_64Guest',150,'5.1','b0642498-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1749,'VMware','rhel5_64Guest',39,'5.1','b0642f24-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1750,'VMware','rhel5_64Guest',190,'5.1','b0644068-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1751,'VMware','ubuntuGuest',125,'5.1','b0644ac2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1752,'VMware','os2Guest',104,'5.1','b064558a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1753,'VMware','rhel2Guest',131,'5.1','b0645df0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1754,'VMware','centos64Guest',112,'5.1','b0646962-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1755,'VMware','centos64Guest',201,'5.1','b0647574-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1756,'VMware','rhel5Guest',189,'5.1','b0648140-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1757,'VMware','winXPPro64Guest',94,'5.1','b0648cda-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1758,'VMware','otherLinuxGuest',98,'5.1','b06497ac-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1759,'VMware','suse64Guest',108,'5.1','b064a2ba-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1760,'VMware','ubuntu64Guest',157,'5.1','b064ac7e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1761,'VMware','centos64Guest',6,'5.1','b064b872-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1762,'VMware','ubuntu64Guest',126,'5.1','b064c38a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1763,'VMware','rhel5_64Guest',194,'5.1','b064cea2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1764,'VMware','unixWare7Guest',86,'5.1','b064daf0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1765,'VMware','win2000AdvServGuest',95,'5.1','b064e586-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1766,'VMware','centos64Guest',144,'5.1','b064eee6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1767,'VMware','ubuntu64Guest',127,'5.1','b064f8b4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1768,'VMware','winNetBusinessGuest',92,'5.1','b06502b4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1769,'VMware','dosGuest',102,'5.1','b0650f2a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1770,'VMware','win2000ServGuest',61,'5.1','b0651ac4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1771,'VMware','windows7_64Guest',49,'5.1','b0652500-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1772,'VMware','win2000ProGuest',105,'5.1','b0652f3c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1773,'VMware','netware5Guest',78,'5.1','b0653a0e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1774,'VMware','centosGuest',7,'5.1','b0654508-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1775,'VMware','otherGuest',85,'5.1','b0654fe4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1776,'VMware','centosGuest',200,'5.1','b0655aac-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1777,'VMware','ubuntuGuest',122,'5.1','b06565b0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1778,'VMware','ubuntuGuest',121,'5.1','b0656e5c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1779,'VMware','oesGuest',68,'5.1','b06578ca-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1780,'VMware','winLonghornGuest',52,'5.1','b065839c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1781,'VMware','centosGuest',3,'5.1','b0658fc2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1782,'VMware','rhel4Guest',29,'5.1','b0659ae4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1783,'VMware','other26xLinux64Guest',76,'5.1','b065a4e4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1784,'VMware','freebsd64Guest',84,'5.1','b065afd4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1785,'VMware','centosGuest',9,'5.1','b065b934-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1786,'VMware','solaris9Guest',81,'5.1','b065c424-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1787,'VMware','otherGuest',60,'5.1','b065dba8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1788,'VMware','winLonghorn64Guest',53,'5.1','b065e594-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1789,'VMware','rhel5Guest',113,'5.1','b065f340-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1790,'VMware','suseGuest',107,'5.1','b065fe3a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1791,'VMware','centosGuest',4,'5.1','b0660cb8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1792,'VMware','centos64Guest',14,'5.1','b06617d0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1793,'VMware','centos64Guest',10,'5.1','b06622ca-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1794,'VMware','winNTGuest',64,'5.1','b0662d56-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1795,'VMware','centos64Guest',142,'5.1','b066383c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1796,'VMware','centosGuest',2,'5.1','b06643cc-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1797,'VMware','ubuntu64Guest',164,'5.1','b06650e2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1798,'VMware','rhel5Guest',149,'5.5','b0665a92-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1799,'VMware','windows8Server64Guest',168,'5.5','b06665be-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1800,'VMware','rhel5_64Guest',114,'5.5','b0667964-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1801,'VMware','rhel6Guest',205,'5.5','b0668314-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1802,'VMware','rhel5Guest',34,'5.5','b0668e2c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1803,'VMware','rhel5_64Guest',33,'5.5','b066a38a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1804,'VMware','winVistaGuest',56,'5.5','b066add0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1805,'VMware','rhel6Guest',197,'5.5','b066b730-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1806,'VMware','suse64Guest',203,'5.5','b066c41e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1807,'VMware','centosGuest',143,'5.5','b066cd88-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1808,'VMware','rhel6_64Guest',204,'5.5','b066d706-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1809,'VMware','ubuntu64Guest',130,'5.5','b066e200-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1810,'VMware','rhel5Guest',38,'5.5','b066ec3c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1811,'VMware','win2000ServGuest',55,'5.5','b066f68c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1812,'VMware','darwin11_64Guest',224,'5.5','b067035c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1813,'VMware','rhel4Guest',28,'5.5','b0670d02-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1814,'VMware','debian4Guest',73,'5.5','b067164e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1815,'VMware','winNetEnterprise64Guest',51,'5.5','b0671ed2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1816,'VMware','darwin10_64Guest',222,'5.5','b0672738-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1817,'VMware','rhel5Guest',32,'5.5','b06733ea-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1818,'VMware','suseGuest',96,'5.5','b0673cc8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1819,'VMware','other26xLinuxGuest',75,'5.5','b0674600-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1820,'VMware','winXPProGuest',93,'5.5','b0674f10-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1821,'VMware','suseGuest',202,'5.5','b0675988-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1822,'VMware','winNetDatacenterGuest',87,'5.5','b067664e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1823,'VMware','ubuntu64Guest',100,'5.5','b0677058-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1824,'VMware','darwin11Guest',223,'5.5','b0677b02-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1825,'VMware','windows8_64Guest',166,'5.5','b06784c6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1826,'VMware','debian4_64Guest',74,'5.5','b0678d5e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1827,'VMware','rhel5_64Guest',37,'5.5','b067993e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1828,'VMware','windows7Guest',48,'5.5','b067a366-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1829,'VMware','asianux3Guest',69,'5.5','b067adc0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1830,'VMware','otherGuest64',103,'5.5','b067b766-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1831,'VMware','winVista64Guest',101,'5.5','b067c13e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1832,'VMware','centosGuest',111,'5.5','b067cac6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1833,'VMware','ubuntu64Guest',128,'5.5','b067d48a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1834,'VMware','rhel5Guest',191,'5.5','b067e182-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1835,'VMware','rhel6Guest',195,'5.5','b067edd0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1836,'VMware','winLonghorn64Guest',54,'5.5','b067f8f2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1837,'VMware','darwin10Guest',221,'5.5','b06804be-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1838,'VMware','centosGuest',11,'5.5','b06810bc-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1839,'VMware','winNetWebGuest',91,'5.5','b0681c1a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1840,'VMware','asianux3_64Guest',70,'5.5','b06826f6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1841,'VMware','solaris10Guest',79,'5.5','b06832cc-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1842,'VMware','ubuntuGuest',124,'5.5','b0683d6c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1843,'VMware','otherLinux64Guest',99,'5.5','b0684816-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1844,'VMware','rhel6Guest',199,'5.5','b068525c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1845,'VMware','freebsdGuest',83,'5.5','b0685c34-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1846,'VMware','winNetStandardGuest',89,'5.5','b0686684-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1847,'VMware','solaris10_64Guest',80,'5.5','b0687804-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1848,'VMware','win98Guest',62,'5.5','b0688344-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1849,'VMware','ubuntu64Guest',129,'5.5','b0688e8e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1850,'VMware','rhel5_64Guest',35,'5.5','b0689a64-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1851,'VMware','winNetStandard64Guest',90,'5.5','b068a4fa-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1852,'VMware','winNetEnterpriseGuest',50,'5.5','b068b044-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1853,'VMware','rhel6Guest',136,'5.5','b068bc2e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1854,'VMware','win95Guest',63,'5.5','b068caf2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1855,'VMware','win31Guest',65,'5.5','b068d4ca-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1856,'VMware','centosGuest',5,'5.5','b068deac-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1857,'VMware','suse64Guest',110,'5.5','b068e898-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1858,'VMware','debian5Guest',15,'5.5','b068f16c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1859,'VMware','rhel6_64Guest',198,'5.5','b068fc98-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1860,'VMware','debian5_64Guest',72,'5.5','b06907b0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1861,'VMware','ubuntuGuest',123,'5.5','b069132c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1862,'VMware','rhel6_64Guest',196,'5.5','b0691db8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1863,'VMware','rhel5_64Guest',192,'5.5','b069288a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1864,'VMware','centos64Guest',8,'5.5','b06932e4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1865,'VMware','winXPProGuest',58,'5.5','b0693c76-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1866,'VMware','windows8Guest',165,'5.5','b06948b0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1867,'VMware','rhel4Guest',26,'5.5','b0695364-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1868,'VMware','rhel6_64Guest',206,'5.5','b0695d50-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1869,'VMware','winNetDatacenter64Guest',88,'5.5','b0696890-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1870,'VMware','rhel5Guest',30,'5.5','b069747a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1871,'VMware','rhel6_64Guest',137,'5.5','b0698078-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1872,'VMware','ubuntuGuest',163,'5.5','b069a8b4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1873,'VMware','ubuntuGuest',156,'5.5','b069b4e4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1874,'VMware','rhel5Guest',36,'5.5','b069bf8e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1875,'VMware','centosGuest',13,'5.5','b069ca06-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1876,'VMware','windows8Server64Guest',167,'5.5','b069d50a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1877,'VMware','winXPProGuest',57,'5.5','b069dfc8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1878,'VMware','centosGuest',141,'5.5','b069ead6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1879,'VMware','centos64Guest',12,'5.5','b069f670-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1880,'VMware','ubuntuGuest',59,'5.5','b06a00b6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1881,'VMware','netware6Guest',77,'5.5','b06a0b56-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1882,'VMware','suse64Guest',97,'5.5','b06a1678-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1883,'VMware','suseGuest',109,'5.5','b06a20dc-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1884,'VMware','centosGuest',1,'5.5','b06a2a28-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1885,'VMware','rhel4Guest',27,'5.5','b06a34c8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1886,'VMware','rhel5_64Guest',31,'5.5','b06a3ff4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1887,'VMware','rhel5Guest',193,'5.5','b06a4bc0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1888,'VMware','solaris8Guest',82,'5.5','b06a5796-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1889,'VMware','rhel5_64Guest',150,'5.5','b06a643e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1890,'VMware','rhel5_64Guest',39,'5.5','b06a6f92-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1891,'VMware','rhel5_64Guest',190,'5.5','b06a7906-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1892,'VMware','ubuntuGuest',125,'5.5','b06a8414-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1893,'VMware','os2Guest',104,'5.5','b06a8f0e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1894,'VMware','rhel2Guest',131,'5.5','b06a9ac6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1895,'VMware','centos64Guest',112,'5.5','b06aa6d8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1896,'VMware','centos64Guest',201,'5.5','b06ab33a-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1897,'VMware','rhel5Guest',189,'5.5','b06abf38-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1898,'VMware','winXPPro64Guest',94,'5.5','b06aca6e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1899,'VMware','otherLinuxGuest',98,'5.5','b06ad590-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1900,'VMware','suse64Guest',108,'5.5','b06ae080-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1901,'VMware','ubuntu64Guest',157,'5.5','b06aebac-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1902,'VMware','centos64Guest',6,'5.5','b06af692-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1903,'VMware','ubuntu64Guest',126,'5.5','b06b0286-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1904,'VMware','rhel5_64Guest',194,'5.5','b06b0dc6-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1905,'VMware','unixWare7Guest',86,'5.5','b06b197e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1906,'VMware','win2000AdvServGuest',95,'5.5','b06b2360-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1907,'VMware','centos64Guest',144,'5.5','b06b2eb4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1908,'VMware','ubuntu64Guest',127,'5.5','b06b388c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1909,'VMware','winNetBusinessGuest',92,'5.5','b06b4250-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1910,'VMware','dosGuest',102,'5.5','b06b4ad4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1911,'VMware','win2000ServGuest',61,'5.5','b06b54c0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1912,'VMware','windows7_64Guest',49,'5.5','b06b5f38-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1913,'VMware','win2000ProGuest',105,'5.5','b06b68d4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1914,'VMware','netware5Guest',78,'5.5','b06b72de-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1915,'VMware','centosGuest',7,'5.5','b06b7c48-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1916,'VMware','otherGuest',85,'5.5','b06b85a8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1917,'VMware','centosGuest',200,'5.5','b06b8f08-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1918,'VMware','ubuntuGuest',122,'5.5','b06b9804-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1919,'VMware','ubuntuGuest',121,'5.5','b06ba218-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1920,'VMware','oesGuest',68,'5.5','b06bacae-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1921,'VMware','winLonghornGuest',52,'5.5','b06bb7e4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1922,'VMware','centosGuest',3,'5.5','b06bc040-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1923,'VMware','rhel4Guest',29,'5.5','b06bc888-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1924,'VMware','other26xLinux64Guest',76,'5.5','b06bd0d0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1925,'VMware','freebsd64Guest',84,'5.5','b06bd9ae-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1926,'VMware','centosGuest',9,'5.5','b06be2d2-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1927,'VMware','solaris9Guest',81,'5.5','b06bede0-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1928,'VMware','otherGuest',60,'5.5','b06bf77c-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1929,'VMware','winLonghorn64Guest',53,'5.5','b06c0064-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1930,'VMware','rhel5Guest',113,'5.5','b06c09c4-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1931,'VMware','suseGuest',107,'5.5','b06c137e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1932,'VMware','centosGuest',4,'5.5','b06c1dce-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1933,'VMware','centos64Guest',14,'5.5','b06c2562-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1934,'VMware','centos64Guest',10,'5.5','b06c2f80-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1935,'VMware','winNTGuest',64,'5.5','b06c39a8-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1936,'VMware','centos64Guest',142,'5.5','b06c475e-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1937,'VMware','centosGuest',2,'5.5','b06c5168-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0),(1938,'VMware','ubuntu64Guest',164,'5.5','b06c5b72-fcd8-11e3-9019-080027ce083d','2014-06-26 02:22:15',NULL,0);
/*!40000 ALTER TABLE `guest_os_hypervisor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `host`
--

DROP TABLE IF EXISTS `host`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `uuid` varchar(40) DEFAULT NULL COMMENT 'this uuid is different with guid below, the later one is used by hypervisor resource',
  `status` varchar(32) NOT NULL,
  `type` varchar(32) NOT NULL,
  `private_ip_address` char(40) NOT NULL,
  `private_netmask` varchar(15) DEFAULT NULL,
  `private_mac_address` varchar(17) DEFAULT NULL,
  `storage_ip_address` char(40) DEFAULT NULL,
  `storage_netmask` varchar(15) DEFAULT NULL,
  `storage_mac_address` varchar(17) DEFAULT NULL,
  `storage_ip_address_2` char(40) DEFAULT NULL,
  `storage_mac_address_2` varchar(17) DEFAULT NULL,
  `storage_netmask_2` varchar(15) DEFAULT NULL,
  `cluster_id` bigint(20) unsigned DEFAULT NULL COMMENT 'foreign key to cluster',
  `public_ip_address` char(40) DEFAULT NULL,
  `public_netmask` varchar(15) DEFAULT NULL,
  `public_mac_address` varchar(17) DEFAULT NULL,
  `proxy_port` int(10) unsigned DEFAULT NULL,
  `data_center_id` bigint(20) unsigned NOT NULL,
  `pod_id` bigint(20) unsigned DEFAULT NULL,
  `cpu_sockets` int(10) unsigned DEFAULT NULL COMMENT 'the number of CPU sockets on the host',
  `cpus` int(10) unsigned DEFAULT NULL,
  `speed` int(10) unsigned DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL COMMENT 'iqn for the servers',
  `fs_type` varchar(32) DEFAULT NULL,
  `hypervisor_type` varchar(32) DEFAULT NULL COMMENT 'hypervisor type, can be NONE for storage',
  `hypervisor_version` varchar(32) DEFAULT NULL COMMENT 'hypervisor version',
  `ram` bigint(20) unsigned DEFAULT NULL,
  `resource` varchar(255) DEFAULT NULL COMMENT 'If it is a local resource, this is the class name',
  `version` varchar(40) NOT NULL,
  `parent` varchar(255) DEFAULT NULL COMMENT 'parent path for the storage server',
  `total_size` bigint(20) unsigned DEFAULT NULL COMMENT 'TotalSize',
  `capabilities` varchar(255) DEFAULT NULL COMMENT 'host capabilities in comma separated list',
  `guid` varchar(255) DEFAULT NULL,
  `available` int(1) unsigned NOT NULL DEFAULT '1' COMMENT 'Is this host ready for more resources?',
  `setup` int(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Is this host already setup?',
  `dom0_memory` bigint(20) unsigned NOT NULL COMMENT 'memory used by dom0 for computing and routing servers',
  `last_ping` int(10) unsigned NOT NULL COMMENT 'time in seconds from the start of machine of the last ping',
  `mgmt_server_id` bigint(20) unsigned DEFAULT NULL COMMENT 'ManagementServer this host is connected to.',
  `disconnected` datetime DEFAULT NULL COMMENT 'Time this was disconnected',
  `created` datetime DEFAULT NULL COMMENT 'date the host first signed on',
  `removed` datetime DEFAULT NULL COMMENT 'date removed if not null',
  `update_count` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'atomic increase count making status update operation atomical',
  `resource_state` varchar(32) NOT NULL DEFAULT 'Enabled' COMMENT 'Is this host enabled for allocation for new resources',
  `owner` varchar(255) DEFAULT NULL,
  `lastUpdated` datetime DEFAULT NULL COMMENT 'last updated',
  `engine_state` varchar(32) NOT NULL DEFAULT 'Disabled' COMMENT 'the engine state of the zone',
  PRIMARY KEY (`id`),
  UNIQUE KEY `guid` (`guid`),
  UNIQUE KEY `uc_host__uuid` (`uuid`),
  KEY `i_host__removed` (`removed`),
  KEY `i_host__last_ping` (`last_ping`),
  KEY `i_host__status` (`status`),
  KEY `i_host__data_center_id` (`data_center_id`),
  KEY `i_host__pod_id` (`pod_id`),
  KEY `fk_host__cluster_id` (`cluster_id`),
  CONSTRAINT `fk_host__cluster_id` FOREIGN KEY (`cluster_id`) REFERENCES `cluster` (`id`),
  CONSTRAINT `fk_host__pod_id` FOREIGN KEY (`pod_id`) REFERENCES `host_pod_ref` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `host`
--

LOCK TABLES `host` WRITE;
/*!40000 ALTER TABLE `host` DISABLE KEYS */;
INSERT INTO `host` VALUES (1,'SimulatedAgent.3589437a-d614-469f-a527-e1d747239b56','58d117bb-95b4-4575-ac50-28d9c14b92da','Up','Routing','172.16.15.20',NULL,'00:00:00:00:00:00','172.16.15.20',NULL,'00:00:00:00:00:00','172.16.15.20','172.16.15.20',NULL,1,NULL,NULL,NULL,NULL,1,1,NULL,4,8000,NULL,NULL,'Simulator',NULL,8589934592,'com.cloud.resource.AgentRoutingResource','4.4.0-SNAPSHOT',NULL,NULL,'hvm','3589437a-d614-469f-a527-e1d747239b56',1,0,0,1370849146,4278190080,NULL,'2014-06-26 02:25:26',NULL,2,'Enabled',NULL,NULL,'Disabled'),(2,'SimulatedAgent.5ce7d19f-3469-4f1f-aa11-44740d75db4b','58b2bdf5-ea34-498e-9b35-9f584c6fed59','Up','Routing','172.16.15.16',NULL,'00:00:00:00:00:00','172.16.15.16',NULL,'00:00:00:00:00:00','172.16.15.16','172.16.15.16',NULL,1,NULL,NULL,NULL,NULL,1,1,NULL,4,8000,NULL,NULL,'Simulator',NULL,8589934592,'com.cloud.resource.AgentRoutingResource','4.4.0-SNAPSHOT',NULL,NULL,'hvm','5ce7d19f-3469-4f1f-aa11-44740d75db4b',1,0,0,1370849146,4278190080,NULL,'2014-06-26 02:25:26',NULL,2,'Enabled',NULL,NULL,'Disabled'),(3,'SimulatedAgent.a1532e2b-8e2b-4801-a940-c829493f02bf','7d2c140c-1752-4072-939c-b83a54db81fb','Up','Routing','172.16.15.18',NULL,'00:00:00:00:00:00','172.16.15.18',NULL,'00:00:00:00:00:00','172.16.15.18','172.16.15.18',NULL,2,NULL,NULL,NULL,NULL,1,1,NULL,4,8000,NULL,NULL,'Simulator',NULL,8589934592,'com.cloud.resource.AgentRoutingResource','4.4.0-SNAPSHOT',NULL,NULL,'hvm','a1532e2b-8e2b-4801-a940-c829493f02bf',1,0,0,1370849205,4278190080,NULL,'2014-06-26 02:26:26',NULL,2,'Enabled',NULL,NULL,'Disabled'),(4,'s-2-VM','6ec91ac1-3b5a-4ee5-92d3-f47863e29b8a','Up','SecondaryStorageVM','172.16.15.36',NULL,'06:6e:d4:00:00:23','172.16.15.36',NULL,'06:6e:d4:00:00:23',NULL,NULL,NULL,NULL,'172.16.15.36',NULL,NULL,NULL,1,1,NULL,NULL,NULL,'NoIqn',NULL,NULL,NULL,0,'com.cloud.resource.AgentStorageResource','4.4.0-SNAPSHOT',NULL,NULL,NULL,'SystemVM-b6e28661-fc5a-4718-a3b4-d642675842c1',1,0,0,1370849297,4278190080,NULL,'2014-06-26 02:28:00',NULL,2,'Enabled',NULL,NULL,'Disabled');
/*!40000 ALTER TABLE `host` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `host_details`
--

DROP TABLE IF EXISTS `host_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `host_id` bigint(20) unsigned NOT NULL COMMENT 'host id',
  `name` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_host_id_name` (`host_id`,`name`),
  KEY `fk_host_details__host_id` (`host_id`),
  CONSTRAINT `fk_host_details__host_id` FOREIGN KEY (`host_id`) REFERENCES `host` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `host_details`
--

LOCK TABLES `host_details` WRITE;
/*!40000 ALTER TABLE `host_details` DISABLE KEYS */;
INSERT INTO `host_details` VALUES (1,1,'com.cloud.network.Networks.RouterPrivateIpStrategy','DcGlobal'),(2,2,'com.cloud.network.Networks.RouterPrivateIpStrategy','DcGlobal'),(3,3,'com.cloud.network.Networks.RouterPrivateIpStrategy','DcGlobal');
/*!40000 ALTER TABLE `host_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `host_gpu_groups`
--

DROP TABLE IF EXISTS `host_gpu_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host_gpu_groups` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `group_name` varchar(255) NOT NULL,
  `host_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_host_gpu_groups__host_id` (`host_id`),
  CONSTRAINT `fk_host_gpu_groups__host_id` FOREIGN KEY (`host_id`) REFERENCES `host` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `host_gpu_groups`
--

LOCK TABLES `host_gpu_groups` WRITE;
/*!40000 ALTER TABLE `host_gpu_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `host_gpu_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `host_pod_ref`
--

DROP TABLE IF EXISTS `host_pod_ref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host_pod_ref` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `uuid` varchar(40) DEFAULT NULL,
  `data_center_id` bigint(20) unsigned NOT NULL,
  `gateway` varchar(255) NOT NULL COMMENT 'gateway for the pod',
  `cidr_address` varchar(15) NOT NULL COMMENT 'CIDR address for the pod',
  `cidr_size` bigint(20) unsigned NOT NULL COMMENT 'CIDR size for the pod',
  `description` varchar(255) DEFAULT NULL COMMENT 'store private ip range in startIP-endIP format',
  `allocation_state` varchar(32) NOT NULL DEFAULT 'Enabled' COMMENT 'Is this Pod enabled for allocation for new resources',
  `external_dhcp` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Is this Pod using external DHCP',
  `removed` datetime DEFAULT NULL COMMENT 'date removed if not null',
  `owner` varchar(255) DEFAULT NULL,
  `created` datetime DEFAULT NULL COMMENT 'date created',
  `lastUpdated` datetime DEFAULT NULL COMMENT 'last updated',
  `engine_state` varchar(32) NOT NULL DEFAULT 'Disabled' COMMENT 'the engine state of the zone',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `name` (`name`,`data_center_id`),
  UNIQUE KEY `uc_host_pod_ref__uuid` (`uuid`),
  KEY `i_host_pod_ref__data_center_id` (`data_center_id`),
  KEY `i_host_pod_ref__allocation_state` (`allocation_state`),
  KEY `i_host_pod_ref__removed` (`removed`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `host_pod_ref`
--

LOCK TABLES `host_pod_ref` WRITE;
/*!40000 ALTER TABLE `host_pod_ref` DISABLE KEYS */;
INSERT INTO `host_pod_ref` VALUES (1,'POD0','36df0f39-4673-47ad-bf1d-d7ae41328517',1,'172.16.15.1','172.16.15.0',24,'172.16.15.2-172.16.15.200','Enabled',0,NULL,NULL,NULL,NULL,'Disabled');
/*!40000 ALTER TABLE `host_pod_ref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `host_tags`
--

DROP TABLE IF EXISTS `host_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host_tags` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `host_id` bigint(20) unsigned NOT NULL COMMENT 'host id',
  `tag` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_host_tags__host_id` (`host_id`),
  CONSTRAINT `fk_host_tags__host_id` FOREIGN KEY (`host_id`) REFERENCES `host` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `host_tags`
--

LOCK TABLES `host_tags` WRITE;
/*!40000 ALTER TABLE `host_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `host_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `host_view`
--

DROP TABLE IF EXISTS `host_view`;
/*!50001 DROP VIEW IF EXISTS `host_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `host_view` (
  `id` tinyint NOT NULL,
  `uuid` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `status` tinyint NOT NULL,
  `disconnected` tinyint NOT NULL,
  `type` tinyint NOT NULL,
  `private_ip_address` tinyint NOT NULL,
  `version` tinyint NOT NULL,
  `hypervisor_type` tinyint NOT NULL,
  `hypervisor_version` tinyint NOT NULL,
  `capabilities` tinyint NOT NULL,
  `last_ping` tinyint NOT NULL,
  `created` tinyint NOT NULL,
  `removed` tinyint NOT NULL,
  `resource_state` tinyint NOT NULL,
  `mgmt_server_id` tinyint NOT NULL,
  `cpu_sockets` tinyint NOT NULL,
  `cpus` tinyint NOT NULL,
  `speed` tinyint NOT NULL,
  `ram` tinyint NOT NULL,
  `cluster_id` tinyint NOT NULL,
  `cluster_uuid` tinyint NOT NULL,
  `cluster_name` tinyint NOT NULL,
  `cluster_type` tinyint NOT NULL,
  `data_center_id` tinyint NOT NULL,
  `data_center_uuid` tinyint NOT NULL,
  `data_center_name` tinyint NOT NULL,
  `data_center_type` tinyint NOT NULL,
  `pod_id` tinyint NOT NULL,
  `pod_uuid` tinyint NOT NULL,
  `pod_name` tinyint NOT NULL,
  `tag` tinyint NOT NULL,
  `guest_os_category_id` tinyint NOT NULL,
  `guest_os_category_uuid` tinyint NOT NULL,
  `guest_os_category_name` tinyint NOT NULL,
  `memory_used_capacity` tinyint NOT NULL,
  `memory_reserved_capacity` tinyint NOT NULL,
  `cpu_used_capacity` tinyint NOT NULL,
  `cpu_reserved_capacity` tinyint NOT NULL,
  `job_id` tinyint NOT NULL,
  `job_uuid` tinyint NOT NULL,
  `job_status` tinyint NOT NULL,
  `job_account_id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `hypervisor_capabilities`
--

DROP TABLE IF EXISTS `hypervisor_capabilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hypervisor_capabilities` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(40) DEFAULT NULL,
  `hypervisor_type` varchar(32) NOT NULL,
  `hypervisor_version` varchar(32) DEFAULT NULL,
  `max_guests_limit` bigint(20) unsigned DEFAULT '50',
  `security_group_enabled` int(1) unsigned DEFAULT '1' COMMENT 'Is security group supported',
  `max_data_volumes_limit` int(10) unsigned DEFAULT '6' COMMENT 'Max. data volumes per VM supported by hypervisor',
  `max_hosts_per_cluster` int(10) unsigned DEFAULT NULL COMMENT 'Max. hosts in cluster supported by hypervisor',
  `storage_motion_supported` int(1) unsigned DEFAULT '0' COMMENT 'Is storage motion supported',
  `vm_snapshot_enabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Whether VM snapshot is supported by hypervisor',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_hypervisor_capabilities__uuid` (`uuid`),
  UNIQUE KEY `uc_hypervisor` (`hypervisor_type`,`hypervisor_version`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hypervisor_capabilities`
--

LOCK TABLES `hypervisor_capabilities` WRITE;
/*!40000 ALTER TABLE `hypervisor_capabilities` DISABLE KEYS */;
INSERT INTO `hypervisor_capabilities` VALUES (1,'1','XenServer','default',50,1,6,NULL,0,1),(2,'2','XenServer','XCP 1.0',50,1,6,NULL,0,1),(3,'3','XenServer','5.6',50,1,6,NULL,0,1),(4,'4','XenServer','5.6 FP1',50,1,6,NULL,0,1),(5,'5','XenServer','5.6 SP2',50,1,6,NULL,0,1),(6,'6','XenServer','6.0',50,1,13,NULL,0,1),(7,'7','XenServer','6.0.2',50,1,13,NULL,0,1),(8,'8','VMware','default',128,0,13,32,0,1),(9,'9','VMware','4.0',128,0,13,32,0,1),(10,'10','VMware','4.1',128,0,13,32,0,1),(11,'11','VMware','5.0',128,0,13,32,1,1),(12,'12','VMware','5.1',128,0,13,32,1,1),(13,'13','KVM','default',50,1,6,NULL,0,0),(14,'14','Ovm','default',25,1,6,NULL,0,0),(15,'15','Ovm','2.3',25,1,6,NULL,0,0),(16,'aee50506-fcd8-11e3-9019-080027ce083d','XenServer','6.1.0',150,1,13,NULL,1,1),(17,'aee51410-fcd8-11e3-9019-080027ce083d','XenServer','6.2.0',500,1,13,NULL,1,1),(19,'af27a258-fcd8-11e3-9019-080027ce083d','LXC','default',50,1,6,NULL,0,0),(20,'afcd9e4c-fcd8-11e3-9019-080027ce083d','Hyperv','6.2',1024,0,64,NULL,1,0),(21,'afd521d0-fcd8-11e3-9019-080027ce083d','VMware','5.5',128,0,13,32,1,1),(22,'b6031d14-fcd8-11e3-9019-080027ce083d','Simulator','default',50,1,6,NULL,0,1);
/*!40000 ALTER TABLE `hypervisor_capabilities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `iam_account_policy_map`
--

DROP TABLE IF EXISTS `iam_account_policy_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `iam_account_policy_map` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` bigint(20) unsigned NOT NULL,
  `policy_id` bigint(20) unsigned NOT NULL,
  `removed` datetime DEFAULT NULL COMMENT 'date the policy was revoked from the account',
  `created` datetime DEFAULT NULL COMMENT 'date the policy was attached to the account',
  PRIMARY KEY (`id`),
  KEY `fk_iam_account_policy_map__account_id` (`account_id`),
  KEY `fk_iam_account_policy_map__policy_id` (`policy_id`),
  CONSTRAINT `fk_iam_account_policy_map__account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_iam_account_policy_map__policy_id` FOREIGN KEY (`policy_id`) REFERENCES `iam_policy` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `iam_account_policy_map`
--

LOCK TABLES `iam_account_policy_map` WRITE;
/*!40000 ALTER TABLE `iam_account_policy_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `iam_account_policy_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `iam_group`
--

DROP TABLE IF EXISTS `iam_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `iam_group` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `uuid` varchar(40) DEFAULT NULL,
  `path` varchar(255) NOT NULL,
  `account_id` bigint(20) unsigned NOT NULL,
  `view` varchar(40) DEFAULT 'User' COMMENT 'response review this group account should see for result',
  `removed` datetime DEFAULT NULL COMMENT 'date the group was removed',
  `created` datetime DEFAULT NULL COMMENT 'date the group was created',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `uc_iam_group__uuid` (`uuid`),
  KEY `i_iam_group__removed` (`removed`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `iam_group`
--

LOCK TABLES `iam_group` WRITE;
/*!40000 ALTER TABLE `iam_group` DISABLE KEYS */;
INSERT INTO `iam_group` VALUES (1,'NORMAL','Domain user group','afe65ab8-fcd8-11e3-9019-080027ce083d','/',1,'User',NULL,'2014-06-26 02:22:14'),(2,'ADMIN','Root admin group','afe667c4-fcd8-11e3-9019-080027ce083d','/',1,'User',NULL,'2014-06-26 02:22:14'),(3,'DOMAIN_ADMIN','Domain admin group','afe67624-fcd8-11e3-9019-080027ce083d','/',1,'User',NULL,'2014-06-26 02:22:14'),(4,'RESOURCE_DOMAIN_ADMIN','Resource domain admin group','afe680c4-fcd8-11e3-9019-080027ce083d','/',1,'User',NULL,'2014-06-26 02:22:14'),(5,'READ_ONLY_ADMIN','Read only admin group','afe68ad8-fcd8-11e3-9019-080027ce083d','/',1,'User',NULL,'2014-06-26 02:22:14');
/*!40000 ALTER TABLE `iam_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `iam_group_account_map`
--

DROP TABLE IF EXISTS `iam_group_account_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `iam_group_account_map` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` bigint(20) unsigned NOT NULL,
  `account_id` bigint(20) unsigned NOT NULL,
  `removed` datetime DEFAULT NULL COMMENT 'date the account was removed from the group',
  `created` datetime DEFAULT NULL COMMENT 'date the account was assigned to the group',
  PRIMARY KEY (`id`),
  KEY `fk_iam_group_vm_map__group_id` (`group_id`),
  KEY `fk_iam_group_vm_map__account_id` (`account_id`),
  CONSTRAINT `fk_iam_group_vm_map__group_id` FOREIGN KEY (`group_id`) REFERENCES `iam_group` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_iam_group_vm_map__account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `iam_group_account_map`
--

LOCK TABLES `iam_group_account_map` WRITE;
/*!40000 ALTER TABLE `iam_group_account_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `iam_group_account_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `iam_group_policy_map`
--

DROP TABLE IF EXISTS `iam_group_policy_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `iam_group_policy_map` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` bigint(20) unsigned NOT NULL,
  `policy_id` bigint(20) unsigned NOT NULL,
  `removed` datetime DEFAULT NULL COMMENT 'date the policy was revoked from the group',
  `created` datetime DEFAULT NULL COMMENT 'date the policy was attached to the group',
  PRIMARY KEY (`id`),
  KEY `fk_iam_group_policy_map__group_id` (`group_id`),
  KEY `fk_iam_group_policy_map__policy_id` (`policy_id`),
  CONSTRAINT `fk_iam_group_policy_map__group_id` FOREIGN KEY (`group_id`) REFERENCES `iam_group` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_iam_group_policy_map__policy_id` FOREIGN KEY (`policy_id`) REFERENCES `iam_policy` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `iam_group_policy_map`
--

LOCK TABLES `iam_group_policy_map` WRITE;
/*!40000 ALTER TABLE `iam_group_policy_map` DISABLE KEYS */;
INSERT INTO `iam_group_policy_map` VALUES (1,1,1,NULL,'2014-06-26 02:22:14'),(2,2,2,NULL,'2014-06-26 02:22:14'),(3,3,3,NULL,'2014-06-26 02:22:14'),(4,4,4,NULL,'2014-06-26 02:22:14'),(5,5,5,NULL,'2014-06-26 02:22:14');
/*!40000 ALTER TABLE `iam_group_policy_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `iam_policy`
--

DROP TABLE IF EXISTS `iam_policy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `iam_policy` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `uuid` varchar(40) DEFAULT NULL,
  `path` varchar(255) NOT NULL,
  `account_id` bigint(20) unsigned NOT NULL,
  `removed` datetime DEFAULT NULL COMMENT 'date the role was removed',
  `created` datetime DEFAULT NULL COMMENT 'date the role was created',
  `policy_type` varchar(64) DEFAULT 'Static' COMMENT 'Static or Dynamic',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `uc_iam_policy__uuid` (`uuid`),
  KEY `i_iam_policy__removed` (`removed`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `iam_policy`
--

LOCK TABLES `iam_policy` WRITE;
/*!40000 ALTER TABLE `iam_policy` DISABLE KEYS */;
INSERT INTO `iam_policy` VALUES (1,'NORMAL','Domain user role','afe5efec-fcd8-11e3-9019-080027ce083d','/',1,NULL,'2014-06-26 02:22:14','Static'),(2,'ADMIN','Root admin role','afe60270-fcd8-11e3-9019-080027ce083d','/',1,NULL,'2014-06-26 02:22:14','Static'),(3,'DOMAIN_ADMIN','Domain admin role','afe61206-fcd8-11e3-9019-080027ce083d','/',1,NULL,'2014-06-26 02:22:14','Static'),(4,'RESOURCE_DOMAIN_ADMIN','Resource domain admin role','afe621e2-fcd8-11e3-9019-080027ce083d','/',1,NULL,'2014-06-26 02:22:14','Static'),(5,'READ_ONLY_ADMIN','Read only admin role','afe633a8-fcd8-11e3-9019-080027ce083d','/',1,NULL,'2014-06-26 02:22:14','Static'),(6,'RESOURCE_OWNER','Resource owner role','afe64b9a-fcd8-11e3-9019-080027ce083d','/',1,NULL,'2014-06-26 02:22:14','Dynamic');
/*!40000 ALTER TABLE `iam_policy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `iam_policy_permission`
--

DROP TABLE IF EXISTS `iam_policy_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `iam_policy_permission` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `policy_id` bigint(20) unsigned NOT NULL,
  `action` varchar(100) NOT NULL,
  `resource_type` varchar(100) DEFAULT NULL,
  `scope_id` bigint(20) DEFAULT NULL,
  `scope` varchar(40) DEFAULT NULL,
  `access_type` varchar(40) DEFAULT NULL,
  `permission` varchar(40) NOT NULL COMMENT 'Allow or Deny',
  `recursive` int(1) unsigned NOT NULL DEFAULT '0' COMMENT '1 if this permission applies recursively in a group/policy hierarchy',
  `removed` datetime DEFAULT NULL COMMENT 'date the permission was revoked',
  `created` datetime DEFAULT NULL COMMENT 'date the permission was granted',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `fk_iam_policy_permission__policy_id` (`policy_id`),
  CONSTRAINT `fk_iam_policy_permission__policy_id` FOREIGN KEY (`policy_id`) REFERENCES `iam_policy` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `iam_policy_permission`
--

LOCK TABLES `iam_policy_permission` WRITE;
/*!40000 ALTER TABLE `iam_policy_permission` DISABLE KEYS */;
/*!40000 ALTER TABLE `iam_policy_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image_store`
--

DROP TABLE IF EXISTS `image_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `image_store` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) NOT NULL COMMENT 'name of data store',
  `image_provider_name` varchar(255) NOT NULL COMMENT 'id of image_store_provider',
  `protocol` varchar(255) NOT NULL COMMENT 'protocol of data store',
  `url` varchar(255) DEFAULT NULL COMMENT 'url for image data store',
  `data_center_id` bigint(20) unsigned DEFAULT NULL COMMENT 'datacenter id of data store',
  `scope` varchar(255) DEFAULT NULL COMMENT 'scope of data store',
  `role` varchar(255) DEFAULT NULL COMMENT 'role of data store',
  `uuid` varchar(255) DEFAULT NULL COMMENT 'uuid of data store',
  `parent` varchar(255) DEFAULT NULL COMMENT 'parent path for the storage server',
  `created` datetime DEFAULT NULL COMMENT 'date the image store first signed on',
  `removed` datetime DEFAULT NULL COMMENT 'date removed if not null',
  `total_size` bigint(20) unsigned DEFAULT NULL COMMENT 'storage total size statistics',
  `used_bytes` bigint(20) unsigned DEFAULT NULL COMMENT 'storage available bytes statistics',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image_store`
--

LOCK TABLES `image_store` WRITE;
/*!40000 ALTER TABLE `image_store` DISABLE KEYS */;
INSERT INTO `image_store` VALUES (1,'nfs://10.147.28.6:/export/home/sandbox/secondary','NFS','nfs','nfs://10.147.28.6:/export/home/sandbox/secondary',1,'ZONE','Image','d6397bc0-cbcf-4201-83e0-ff59598b2790','/mnt/05b33ef7-da6a-33eb-9981-b4efb90ed99b/','2014-06-26 02:27:27',NULL,NULL,NULL);
/*!40000 ALTER TABLE `image_store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image_store_details`
--

DROP TABLE IF EXISTS `image_store_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `image_store_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `store_id` bigint(20) unsigned NOT NULL COMMENT 'store the detail is related to',
  `name` varchar(255) NOT NULL COMMENT 'name of the detail',
  `value` varchar(255) NOT NULL COMMENT 'value of the detail',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `fk_image_store_details__store_id` (`store_id`),
  KEY `i_image_store__name__value` (`name`(128),`value`(128)),
  CONSTRAINT `fk_image_store_details__store_id` FOREIGN KEY (`store_id`) REFERENCES `image_store` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image_store_details`
--

LOCK TABLES `image_store_details` WRITE;
/*!40000 ALTER TABLE `image_store_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `image_store_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `image_store_view`
--

DROP TABLE IF EXISTS `image_store_view`;
/*!50001 DROP VIEW IF EXISTS `image_store_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `image_store_view` (
  `id` tinyint NOT NULL,
  `uuid` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `image_provider_name` tinyint NOT NULL,
  `protocol` tinyint NOT NULL,
  `url` tinyint NOT NULL,
  `scope` tinyint NOT NULL,
  `role` tinyint NOT NULL,
  `removed` tinyint NOT NULL,
  `data_center_id` tinyint NOT NULL,
  `data_center_uuid` tinyint NOT NULL,
  `data_center_name` tinyint NOT NULL,
  `detail_name` tinyint NOT NULL,
  `detail_value` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `inline_load_balancer_nic_map`
--

DROP TABLE IF EXISTS `inline_load_balancer_nic_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inline_load_balancer_nic_map` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `public_ip_address` char(40) NOT NULL,
  `nic_id` bigint(20) unsigned DEFAULT NULL COMMENT 'nic id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `nic_id` (`nic_id`),
  CONSTRAINT `fk_inline_load_balancer_nic_map__nic_id` FOREIGN KEY (`nic_id`) REFERENCES `nics` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inline_load_balancer_nic_map`
--

LOCK TABLES `inline_load_balancer_nic_map` WRITE;
/*!40000 ALTER TABLE `inline_load_balancer_nic_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `inline_load_balancer_nic_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instance_group`
--

DROP TABLE IF EXISTS `instance_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instance_group` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` bigint(20) unsigned NOT NULL COMMENT 'owner.  foreign key to account table',
  `name` varchar(255) NOT NULL,
  `uuid` varchar(40) DEFAULT NULL,
  `removed` datetime DEFAULT NULL COMMENT 'date the group was removed',
  `created` datetime DEFAULT NULL COMMENT 'date the group was created',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `uc_instance_group__uuid` (`uuid`),
  KEY `i_instance_group__removed` (`removed`),
  KEY `fk_instance_group__account_id` (`account_id`),
  CONSTRAINT `fk_instance_group__account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instance_group`
--

LOCK TABLES `instance_group` WRITE;
/*!40000 ALTER TABLE `instance_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `instance_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `instance_group_view`
--

DROP TABLE IF EXISTS `instance_group_view`;
/*!50001 DROP VIEW IF EXISTS `instance_group_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `instance_group_view` (
  `id` tinyint NOT NULL,
  `uuid` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `removed` tinyint NOT NULL,
  `created` tinyint NOT NULL,
  `account_id` tinyint NOT NULL,
  `account_uuid` tinyint NOT NULL,
  `account_name` tinyint NOT NULL,
  `account_type` tinyint NOT NULL,
  `domain_id` tinyint NOT NULL,
  `domain_uuid` tinyint NOT NULL,
  `domain_name` tinyint NOT NULL,
  `domain_path` tinyint NOT NULL,
  `project_id` tinyint NOT NULL,
  `project_uuid` tinyint NOT NULL,
  `project_name` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `instance_group_vm_map`
--

DROP TABLE IF EXISTS `instance_group_vm_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instance_group_vm_map` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` bigint(20) unsigned NOT NULL,
  `instance_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_instance_group_vm_map___group_id` (`group_id`),
  KEY `fk_instance_group_vm_map___instance_id` (`instance_id`),
  CONSTRAINT `fk_instance_group_vm_map___group_id` FOREIGN KEY (`group_id`) REFERENCES `instance_group` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_instance_group_vm_map___instance_id` FOREIGN KEY (`instance_id`) REFERENCES `user_vm` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instance_group_vm_map`
--

LOCK TABLES `instance_group_vm_map` WRITE;
/*!40000 ALTER TABLE `instance_group_vm_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `instance_group_vm_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `keystore`
--

DROP TABLE IF EXISTS `keystore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `keystore` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(64) NOT NULL COMMENT 'unique name for the certifiation',
  `certificate` text NOT NULL COMMENT 'the actual certificate being stored in the db',
  `key` text COMMENT 'private key associated wih the certificate',
  `domain_suffix` varchar(256) NOT NULL COMMENT 'DNS domain suffix associated with the certificate',
  `seq` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `keystore`
--

LOCK TABLES `keystore` WRITE;
/*!40000 ALTER TABLE `keystore` DISABLE KEYS */;
INSERT INTO `keystore` VALUES (1,'CPVMCertificate','-----BEGIN CERTIFICATE-----\nMIIFZTCCBE2gAwIBAgIHKBCduBUoKDANBgkqhkiG9w0BAQUFADCByjELMAkGA1UE\nBhMCVVMxEDAOBgNVBAgTB0FyaXpvbmExEzARBgNVBAcTClNjb3R0c2RhbGUxGjAY\nBgNVBAoTEUdvRGFkZHkuY29tLCBJbmMuMTMwMQYDVQQLEypodHRwOi8vY2VydGlm\naWNhdGVzLmdvZGFkZHkuY29tL3JlcG9zaXRvcnkxMDAuBgNVBAMTJ0dvIERhZGR5\nIFNlY3VyZSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTERMA8GA1UEBRMIMDc5Njky\nODcwHhcNMTIwMjAzMDMzMDQwWhcNMTcwMjA3MDUxMTIzWjBZMRkwFwYDVQQKDBAq\nLnJlYWxob3N0aXAuY29tMSEwHwYDVQQLDBhEb21haW4gQ29udHJvbCBWYWxpZGF0\nZWQxGTAXBgNVBAMMECoucmVhbGhvc3RpcC5jb20wggEiMA0GCSqGSIb3DQEBAQUA\nA4IBDwAwggEKAoIBAQCDT9AtEfs+s/I8QXp6rrCw0iNJ0+GgsybNHheU+JpL39LM\nTZykCrZhZnyDvwdxCoOfE38Sa32baHKNds+y2SHnMNsOkw8OcNucHEBX1FIpOBGp\nh9D6xC+umx9od6xMWETUv7j6h2u+WC3OhBM8fHCBqIiAol31/IkcqDxxsHlQ8S/o\nCfTlXJUY6Yn628OA1XijKdRnadV0hZ829cv/PZKljjwQUTyrd0KHQeksBH+YAYSo\n2JUl8ekNLsOi8/cPtfojnltzRI1GXi0ZONs8VnDzJ0a2gqZY+uxlz+CGbLnGnlN4\nj9cBpE+MfUE+35Dq121sTpsSgF85Mz+pVhn2S633AgMBAAGjggG+MIIBujAPBgNV\nHRMBAf8EBTADAQEAMB0GA1UdJQQWMBQGCCsGAQUFBwMBBggrBgEFBQcDAjAOBgNV\nHQ8BAf8EBAMCBaAwMwYDVR0fBCwwKjAooCagJIYiaHR0cDovL2NybC5nb2RhZGR5\nLmNvbS9nZHMxLTY0LmNybDBTBgNVHSAETDBKMEgGC2CGSAGG/W0BBxcBMDkwNwYI\nKwYBBQUHAgEWK2h0dHA6Ly9jZXJ0aWZpY2F0ZXMuZ29kYWRkeS5jb20vcmVwb3Np\ndG9yeS8wgYAGCCsGAQUFBwEBBHQwcjAkBggrBgEFBQcwAYYYaHR0cDovL29jc3Au\nZ29kYWRkeS5jb20vMEoGCCsGAQUFBzAChj5odHRwOi8vY2VydGlmaWNhdGVzLmdv\nZGFkZHkuY29tL3JlcG9zaXRvcnkvZ2RfaW50ZXJtZWRpYXRlLmNydDAfBgNVHSME\nGDAWgBT9rGEyk2xF1uLuhV+auud2mWjM5zArBgNVHREEJDAighAqLnJlYWxob3N0\naXAuY29tgg5yZWFsaG9zdGlwLmNvbTAdBgNVHQ4EFgQUZyJz9/QLy5TWIIscTXID\nE8Xk47YwDQYJKoZIhvcNAQEFBQADggEBAKiUV3KK16mP0NpS92fmQkCLqm+qUWyN\nBfBVgf9/M5pcT8EiTZlS5nAtzAE/eRpBeR3ubLlaAogj4rdH7YYVJcDDLLoB2qM3\nqeCHu8LFoblkb93UuFDWqRaVPmMlJRnhsRkL1oa2gM2hwQTkBDkP7w5FG1BELCgl\ngZI2ij2yxjge6pOEwSyZCzzbCcg9pN+dNrYyGEtB4k+BBnPA3N4r14CWbk+uxjrQ\n6j2Ip+b7wOc5IuMEMl8xwTyjuX3lsLbAZyFI9RCyofwA9NqIZ1GeB6Zd196rubQp\n93cmBqGGjZUs3wMrGlm7xdjlX6GQ9UvmvkMub9+lL99A5W50QgCmFeI=\n-----END CERTIFICATE-----\n','-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCDT9AtEfs+s/I8QXp6rrCw0iNJ\n0+GgsybNHheU+JpL39LMTZykCrZhZnyDvwdxCoOfE38Sa32baHKNds+y2SHnMNsOkw8OcNucHEBX\n1FIpOBGph9D6xC+umx9od6xMWETUv7j6h2u+WC3OhBM8fHCBqIiAol31/IkcqDxxsHlQ8S/oCfTl\nXJUY6Yn628OA1XijKdRnadV0hZ829cv/PZKljjwQUTyrd0KHQeksBH+YAYSo2JUl8ekNLsOi8/cP\ntfojnltzRI1GXi0ZONs8VnDzJ0a2gqZY+uxlz+CGbLnGnlN4j9cBpE+MfUE+35Dq121sTpsSgF85\nMz+pVhn2S633AgMBAAECggEAH/Szd9RxbVADenCA6wxKSa3KErRyq1YN8ksJeCKMAj0FIt0caruE\nqO11DebWW8cwQu1Otl/cYI6pmg24/BBldMrp9IELX/tNJo+lhPpRyGAxxC0eSXinFfoASb8d+jJd\nBd1mmemM6fSxqRlxSP4LrzIhjhR1g2CiyYuTsiM9UtoVKGyHwe7KfFwirUOJo3Mr18zUVNm7YqY4\nIVhOSq59zkH3ULBlYq4bG50jpxa5mNSCZ7IpafPY/kE/CbR+FWNt30+rk69T+qb5abg6+XGm+OAm\nbnQ18yZEqX6nJLk7Ch0cfA5orGgrTMOrM71wK7tBBDQ308kOxDGebx6j0qD36QKBgQDTRDr8kuhA\n9sUyKr9vk2DQCMpNvEeiwI3JRMqmmxpNAtg01aJ3Ya57vX5Fc+zcuV87kP6FM1xgpHQvnw5LWo2J\ns7ANwQcP8ricEW5zkZhSjI4ssMeAubmsHOloGxmLFYZqwx0JI7CWViGTLMcUlqKblmHcjeQDeDfP\nP1TaCItFmwKBgQCfHZwVvIcaDs5vxVpZ4ftvflIrW8qq0uOVK6QIf9A/YTGhCXl2qxxTg2A6+0rg\nZqI7zKzUDxIbVv0KlgCbpHDC9d5+sdtDB3wW2pimuJ3p1z4/RHb4n/lDwXCACZl1S5l24yXX2pFZ\nwdPCXmy5PYkHMssFLNhI24pprUIQs66M1QKBgQDQwjAjWisD3pRXESSfZRsaFkWJcM28hdbVFhPF\nc6gWhwQLmTp0CuL2RPXcPUPFi6sN2iWWi3zxxi9Eyz+9uBn6AsOpo56N5MME/LiOnETO9TKb+Ib6\nrQtKhjshcv3XkIqFPo2XdVvOAgglPO7vajX91iiXXuH7h7RmJud6l0y/lwKBgE+bi90gLuPtpoEr\nVzIDKz40ED5bNYHT80NNy0rpT7J2GVN9nwStRYXPBBVeZq7xCpgqpgmO5LtDAWULeZBlbHlOdBwl\nNhNKKl5wzdEUKwW0yBL1WSS5PQgWPwgARYP25/ggW22sj+49WIo1neXsEKPGWObk8e050f1fTt92\nVo1lAoGAb1gCoyBCzvi7sqFxm4V5oapnJeiQQJFjhoYWqGa26rQ+AvXXNuBcigIeDXNJPctSF0Uc\np11KbbCgiruBbckvM1vGsk6Sx4leRk+IFHRpJktFUek4o0eUg0shOsyyvyet48Dfg0a8FvcxROs0\ngD+IYds5doiob/hcm1hnNB/3vk4=\n-----END PRIVATE KEY-----\n','realhostip.com',NULL),(2,'root','-----BEGIN CERTIFICATE-----\nMIIE3jCCA8agAwIBAgICAwEwDQYJKoZIhvcNAQEFBQAwYzELMAkGA1UEBhMCVVMx\nITAfBgNVBAoTGFRoZSBHbyBEYWRkeSBHcm91cCwgSW5jLjExMC8GA1UECxMoR28g\nRGFkZHkgQ2xhc3MgMiBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTAeFw0wNjExMTYw\nMTU0MzdaFw0yNjExMTYwMTU0MzdaMIHKMQswCQYDVQQGEwJVUzEQMA4GA1UECBMH\nQXJpem9uYTETMBEGA1UEBxMKU2NvdHRzZGFsZTEaMBgGA1UEChMRR29EYWRkeS5j\nb20sIEluYy4xMzAxBgNVBAsTKmh0dHA6Ly9jZXJ0aWZpY2F0ZXMuZ29kYWRkeS5j\nb20vcmVwb3NpdG9yeTEwMC4GA1UEAxMnR28gRGFkZHkgU2VjdXJlIENlcnRpZmlj\nYXRpb24gQXV0aG9yaXR5MREwDwYDVQQFEwgwNzk2OTI4NzCCASIwDQYJKoZIhvcN\nAQEBBQADggEPADCCAQoCggEBAMQt1RWMnCZM7DI161+4WQFapmGBWTtwY6vj3D3H\nKrjJM9N55DrtPDAjhI6zMBS2sofDPZVUBJ7fmd0LJR4h3mUpfjWoqVTr9vcyOdQm\nVZWt7/v+WIbXnvQAjYwqDL1CBM6nPwT27oDyqu9SoWlm2r4arV3aLGbqGmu75RpR\nSgAvSMeYddi5Kcju+GZtCpyz8/x4fKL4o/K1w/O5epHBp+YlLpyo7RJlbmr2EkRT\ncDCVw5wrWCs9CHRK8r5RsL+H0EwnWGu1NcWdrxcx+AuP7q2BNgWJCJjPOq8lh8BJ\n6qf9Z/dFjpfMFDniNoW1fho3/Rb2cRGadDAW/hOUoz+EDU8CAwEAAaOCATIwggEu\nMB0GA1UdDgQWBBT9rGEyk2xF1uLuhV+auud2mWjM5zAfBgNVHSMEGDAWgBTSxLDS\nkdRMEXGzYcs9of7dqGrU4zASBgNVHRMBAf8ECDAGAQH/AgEAMDMGCCsGAQUFBwEB\nBCcwJTAjBggrBgEFBQcwAYYXaHR0cDovL29jc3AuZ29kYWRkeS5jb20wRgYDVR0f\nBD8wPTA7oDmgN4Y1aHR0cDovL2NlcnRpZmljYXRlcy5nb2RhZGR5LmNvbS9yZXBv\nc2l0b3J5L2dkcm9vdC5jcmwwSwYDVR0gBEQwQjBABgRVHSAAMDgwNgYIKwYBBQUH\nAgEWKmh0dHA6Ly9jZXJ0aWZpY2F0ZXMuZ29kYWRkeS5jb20vcmVwb3NpdG9yeTAO\nBgNVHQ8BAf8EBAMCAQYwDQYJKoZIhvcNAQEFBQADggEBANKGwOy9+aG2Z+5mC6IG\nOgRQjhVyrEp0lVPLN8tESe8HkGsz2ZbwlFalEzAFPIUyIXvJxwqoJKSQ3kbTJSMU\nA2fCENZvD117esyfxVgqwcSeIaha86ykRvOe5GPLL5CkKSkB2XIsKd83ASe8T+5o\n0yGPwLPk9Qnt0hCqU7S+8MxZC9Y7lhyVJEnfzuz9p0iRFEUOOjZv2kWzRaJBydTX\nRE4+uXR21aITVSzGh6O1mawGhId/dQb8vxRMDsxuxN89txJx9OjxUUAiKEngHUuH\nqDTMBqLdElrRhjZkAzVvb3du6/KFUJheqwNTrZEjYx8WnM25sgVjOuH0aBsXBTWV\nU+4=\n-----END CERTIFICATE-----\n-----BEGIN CERTIFICATE-----\nMIIE+zCCBGSgAwIBAgICAQ0wDQYJKoZIhvcNAQEFBQAwgbsxJDAiBgNVBAcTG1Zh\nbGlDZXJ0IFZhbGlkYXRpb24gTmV0d29yazEXMBUGA1UEChMOVmFsaUNlcnQsIElu\nYy4xNTAzBgNVBAsTLFZhbGlDZXJ0IENsYXNzIDIgUG9saWN5IFZhbGlkYXRpb24g\nQXV0aG9yaXR5MSEwHwYDVQQDExhodHRwOi8vd3d3LnZhbGljZXJ0LmNvbS8xIDAe\nBgkqhkiG9w0BCQEWEWluZm9AdmFsaWNlcnQuY29tMB4XDTA0MDYyOTE3MDYyMFoX\nDTI0MDYyOTE3MDYyMFowYzELMAkGA1UEBhMCVVMxITAfBgNVBAoTGFRoZSBHbyBE\nYWRkeSBHcm91cCwgSW5jLjExMC8GA1UECxMoR28gRGFkZHkgQ2xhc3MgMiBDZXJ0\naWZpY2F0aW9uIEF1dGhvcml0eTCCASAwDQYJKoZIhvcNAQEBBQADggENADCCAQgC\nggEBAN6d1+pXGEmhW+vXX0iG6r7d/+TvZxz0ZWizV3GgXne77ZtJ6XCAPVYYYwhv\n2vLM0D9/AlQiVBDYsoHUwHU9S3/Hd8M+eKsaA7Ugay9qK7HFiH7Eux6wwdhFJ2+q\nN1j3hybX2C32qRe3H3I2TqYXP2WYktsqbl2i/ojgC95/5Y0V4evLOtXiEqITLdiO\nr18SPaAIBQi2XKVlOARFmR6jYGB0xUGlcmIbYsUfb18aQr4CUWWoriMYavx4A6lN\nf4DD+qta/KFApMoZFv6yyO9ecw3ud72a9nmYvLEHZ6IVDd2gWMZEewo+YihfukEH\nU1jPEX44dMX4/7VpkI+EdOqXG68CAQOjggHhMIIB3TAdBgNVHQ4EFgQU0sSw0pHU\nTBFxs2HLPaH+3ahq1OMwgdIGA1UdIwSByjCBx6GBwaSBvjCBuzEkMCIGA1UEBxMb\nVmFsaUNlcnQgVmFsaWRhdGlvbiBOZXR3b3JrMRcwFQYDVQQKEw5WYWxpQ2VydCwg\nSW5jLjE1MDMGA1UECxMsVmFsaUNlcnQgQ2xhc3MgMiBQb2xpY3kgVmFsaWRhdGlv\nbiBBdXRob3JpdHkxITAfBgNVBAMTGGh0dHA6Ly93d3cudmFsaWNlcnQuY29tLzEg\nMB4GCSqGSIb3DQEJARYRaW5mb0B2YWxpY2VydC5jb22CAQEwDwYDVR0TAQH/BAUw\nAwEB/zAzBggrBgEFBQcBAQQnMCUwIwYIKwYBBQUHMAGGF2h0dHA6Ly9vY3NwLmdv\nZGFkZHkuY29tMEQGA1UdHwQ9MDswOaA3oDWGM2h0dHA6Ly9jZXJ0aWZpY2F0ZXMu\nZ29kYWRkeS5jb20vcmVwb3NpdG9yeS9yb290LmNybDBLBgNVHSAERDBCMEAGBFUd\nIAAwODA2BggrBgEFBQcCARYqaHR0cDovL2NlcnRpZmljYXRlcy5nb2RhZGR5LmNv\nbS9yZXBvc2l0b3J5MA4GA1UdDwEB/wQEAwIBBjANBgkqhkiG9w0BAQUFAAOBgQC1\nQPmnHfbq/qQaQlpE9xXUhUaJwL6e4+PrxeNYiY+Sn1eocSxI0YGyeR+sBjUZsE4O\nWBsUs5iB0QQeyAfJg594RAoYC5jcdnplDQ1tgMQLARzLrUc+cb53S8wGd9D0Vmsf\nSxOaFIqII6hR8INMqzW/Rn453HWkrugp++85j09VZw==\n-----END CERTIFICATE-----\n-----BEGIN CERTIFICATE-----\nMIIC5zCCAlACAQEwDQYJKoZIhvcNAQEFBQAwgbsxJDAiBgNVBAcTG1ZhbGlDZXJ0\nIFZhbGlkYXRpb24gTmV0d29yazEXMBUGA1UEChMOVmFsaUNlcnQsIEluYy4xNTAz\nBgNVBAsTLFZhbGlDZXJ0IENsYXNzIDIgUG9saWN5IFZhbGlkYXRpb24gQXV0aG9y\naXR5MSEwHwYDVQQDExhodHRwOi8vd3d3LnZhbGljZXJ0LmNvbS8xIDAeBgkqhkiG\n9w0BCQEWEWluZm9AdmFsaWNlcnQuY29tMB4XDTk5MDYyNjAwMTk1NFoXDTE5MDYy\nNjAwMTk1NFowgbsxJDAiBgNVBAcTG1ZhbGlDZXJ0IFZhbGlkYXRpb24gTmV0d29y\nazEXMBUGA1UEChMOVmFsaUNlcnQsIEluYy4xNTAzBgNVBAsTLFZhbGlDZXJ0IENs\nYXNzIDIgUG9saWN5IFZhbGlkYXRpb24gQXV0aG9yaXR5MSEwHwYDVQQDExhodHRw\nOi8vd3d3LnZhbGljZXJ0LmNvbS8xIDAeBgkqhkiG9w0BCQEWEWluZm9AdmFsaWNl\ncnQuY29tMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDOOnHK5avIWZJV16vY\ndA757tn2VUdZZUcOBVXc65g2PFxTXdMwzzjsvUGJ7SVCCSRrCl6zfN1SLUzm1NZ9\nWlmpZdRJEy0kTRxQb7XBhVQ7/nHk01xC+YDgkRoKWzk2Z/M/VXwbP7RfZHM047QS\nv4dk+NoS/zcnwbNDu+97bi5p9wIDAQABMA0GCSqGSIb3DQEBBQUAA4GBADt/UG9v\nUJSZSWI4OB9L+KXIPqeCgfYrx+jFzug6EILLGACOTb2oWH+heQC1u+mNr0HZDzTu\nIYEZoDJJKPTEjlbVUjP9UNV+mWwD5MlM/Mtsq2azSiGM5bUMMj4QssxsodyamEwC\nW/POuZ6lcg5Ktz885hZo+L7tdEy8W9ViH0Pd\n-----END CERTIFICATE-----\n',NULL,'realhostip.com',0);
/*!40000 ALTER TABLE `keystore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `launch_permission`
--

DROP TABLE IF EXISTS `launch_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `launch_permission` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `template_id` bigint(20) unsigned NOT NULL,
  `account_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `i_launch_permission_template_id` (`template_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `launch_permission`
--

LOCK TABLES `launch_permission` WRITE;
/*!40000 ALTER TABLE `launch_permission` DISABLE KEYS */;
/*!40000 ALTER TABLE `launch_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ldap_configuration`
--

DROP TABLE IF EXISTS `ldap_configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ldap_configuration` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `hostname` varchar(255) NOT NULL COMMENT 'the hostname of the ldap server',
  `port` int(10) DEFAULT NULL COMMENT 'port that the ldap server is listening on',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ldap_configuration`
--

LOCK TABLES `ldap_configuration` WRITE;
/*!40000 ALTER TABLE `ldap_configuration` DISABLE KEYS */;
/*!40000 ALTER TABLE `ldap_configuration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `legacy_zones`
--

DROP TABLE IF EXISTS `legacy_zones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `legacy_zones` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `zone_id` bigint(20) unsigned NOT NULL COMMENT 'id of CloudStack zone',
  PRIMARY KEY (`id`),
  UNIQUE KEY `zone_id` (`zone_id`),
  CONSTRAINT `fk_legacy_zones__zone_id` FOREIGN KEY (`zone_id`) REFERENCES `data_center` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `legacy_zones`
--

LOCK TABLES `legacy_zones` WRITE;
/*!40000 ALTER TABLE `legacy_zones` DISABLE KEYS */;
/*!40000 ALTER TABLE `legacy_zones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `load_balancer_cert_map`
--

DROP TABLE IF EXISTS `load_balancer_cert_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `load_balancer_cert_map` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(40) DEFAULT NULL,
  `load_balancer_id` bigint(20) unsigned NOT NULL,
  `certificate_id` bigint(20) unsigned NOT NULL,
  `revoke` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_load_balancer_cert_map__certificate_id` (`certificate_id`),
  KEY `fk_load_balancer_cert_map__load_balancer_id` (`load_balancer_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `load_balancer_cert_map`
--

LOCK TABLES `load_balancer_cert_map` WRITE;
/*!40000 ALTER TABLE `load_balancer_cert_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `load_balancer_cert_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `load_balancer_healthcheck_policies`
--

DROP TABLE IF EXISTS `load_balancer_healthcheck_policies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `load_balancer_healthcheck_policies` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(40) DEFAULT NULL,
  `load_balancer_id` bigint(20) unsigned NOT NULL,
  `pingpath` varchar(225) DEFAULT '/',
  `description` varchar(4096) DEFAULT NULL,
  `response_time` int(11) DEFAULT '5',
  `healthcheck_interval` int(11) DEFAULT '5',
  `healthcheck_thresshold` int(11) DEFAULT '2',
  `unhealth_thresshold` int(11) DEFAULT '10',
  `revoke` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '1 is when rule is set for Revoke',
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'True if the policy can be displayed to the end user',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_load_balancer_healthcheck_policies_loadbalancer_id` (`load_balancer_id`),
  CONSTRAINT `fk_load_balancer_healthcheck_policies_loadbalancer_id` FOREIGN KEY (`load_balancer_id`) REFERENCES `load_balancing_rules` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `load_balancer_healthcheck_policies`
--

LOCK TABLES `load_balancer_healthcheck_policies` WRITE;
/*!40000 ALTER TABLE `load_balancer_healthcheck_policies` DISABLE KEYS */;
/*!40000 ALTER TABLE `load_balancer_healthcheck_policies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `load_balancer_healthcheck_policy_details`
--

DROP TABLE IF EXISTS `load_balancer_healthcheck_policy_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `load_balancer_healthcheck_policy_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `lb_policy_id` bigint(20) NOT NULL COMMENT 'resource id',
  `name` varchar(255) NOT NULL,
  `value` varchar(1024) NOT NULL,
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'True if the detail can be displayed to the end user',
  PRIMARY KEY (`id`),
  KEY `fk_lb_healthcheck_policy_details__lb_healthcheck_policy_id` (`lb_policy_id`),
  CONSTRAINT `fk_lb_healthcheck_policy_details__lb_healthcheck_policy_id` FOREIGN KEY (`lb_policy_id`) REFERENCES `load_balancer_healthcheck_policies` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `load_balancer_healthcheck_policy_details`
--

LOCK TABLES `load_balancer_healthcheck_policy_details` WRITE;
/*!40000 ALTER TABLE `load_balancer_healthcheck_policy_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `load_balancer_healthcheck_policy_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `load_balancer_stickiness_policies`
--

DROP TABLE IF EXISTS `load_balancer_stickiness_policies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `load_balancer_stickiness_policies` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(40) DEFAULT NULL,
  `load_balancer_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(4096) DEFAULT NULL COMMENT 'description',
  `method_name` varchar(255) NOT NULL,
  `params` varchar(4096) NOT NULL,
  `revoke` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '1 is when rule is set for Revoke',
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'True if the policy can be displayed to the end user',
  PRIMARY KEY (`id`),
  KEY `fk_load_balancer_stickiness_policies__load_balancer_id` (`load_balancer_id`),
  CONSTRAINT `fk_load_balancer_stickiness_policies__load_balancer_id` FOREIGN KEY (`load_balancer_id`) REFERENCES `load_balancing_rules` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `load_balancer_stickiness_policies`
--

LOCK TABLES `load_balancer_stickiness_policies` WRITE;
/*!40000 ALTER TABLE `load_balancer_stickiness_policies` DISABLE KEYS */;
/*!40000 ALTER TABLE `load_balancer_stickiness_policies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `load_balancer_stickiness_policy_details`
--

DROP TABLE IF EXISTS `load_balancer_stickiness_policy_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `load_balancer_stickiness_policy_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `lb_policy_id` bigint(20) unsigned NOT NULL COMMENT 'resource id',
  `name` varchar(255) NOT NULL,
  `value` varchar(1024) NOT NULL,
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'True if the detail can be displayed to the end user',
  PRIMARY KEY (`id`),
  KEY `fk_lb_stickiness_policy_details__lb_stickiness_policy_id` (`lb_policy_id`),
  CONSTRAINT `fk_lb_stickiness_policy_details__lb_stickiness_policy_id` FOREIGN KEY (`lb_policy_id`) REFERENCES `load_balancer_stickiness_policies` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `load_balancer_stickiness_policy_details`
--

LOCK TABLES `load_balancer_stickiness_policy_details` WRITE;
/*!40000 ALTER TABLE `load_balancer_stickiness_policy_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `load_balancer_stickiness_policy_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `load_balancer_vm_map`
--

DROP TABLE IF EXISTS `load_balancer_vm_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `load_balancer_vm_map` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `load_balancer_id` bigint(20) unsigned NOT NULL,
  `instance_id` bigint(20) unsigned NOT NULL,
  `revoke` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '1 is when rule is set for Revoke',
  `state` varchar(40) DEFAULT NULL COMMENT 'service status updated by LB healthcheck manager',
  `instance_ip` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `load_balancer_id` (`load_balancer_id`,`instance_id`,`instance_ip`),
  KEY `fk_load_balancer_vm_map__instance_id` (`instance_id`),
  CONSTRAINT `fk_load_balancer_vm_map__instance_id` FOREIGN KEY (`instance_id`) REFERENCES `vm_instance` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_load_balancer_vm_map__load_balancer_id` FOREIGN KEY (`load_balancer_id`) REFERENCES `load_balancing_rules` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `load_balancer_vm_map`
--

LOCK TABLES `load_balancer_vm_map` WRITE;
/*!40000 ALTER TABLE `load_balancer_vm_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `load_balancer_vm_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `load_balancing_rules`
--

DROP TABLE IF EXISTS `load_balancing_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `load_balancing_rules` (
  `id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(4096) DEFAULT NULL COMMENT 'description',
  `default_port_start` int(10) NOT NULL COMMENT 'default private port range start',
  `default_port_end` int(10) NOT NULL COMMENT 'default destination port range end',
  `algorithm` varchar(255) NOT NULL,
  `source_ip_address` varchar(40) DEFAULT NULL COMMENT 'source ip address for the load balancer rule',
  `source_ip_address_network_id` bigint(20) unsigned DEFAULT NULL COMMENT 'the id of the network where source ip belongs to',
  `scheme` varchar(40) NOT NULL COMMENT 'load balancer scheme; can be Internal or Public',
  `lb_protocol` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_load_balancing_rules__id` FOREIGN KEY (`id`) REFERENCES `firewall_rules` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `load_balancing_rules`
--

LOCK TABLES `load_balancing_rules` WRITE;
/*!40000 ALTER TABLE `load_balancing_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `load_balancing_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `monitoring_services`
--

DROP TABLE IF EXISTS `monitoring_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `monitoring_services` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uuid` varchar(40) DEFAULT NULL,
  `service` varchar(255) DEFAULT NULL COMMENT 'Service name',
  `process_name` varchar(255) DEFAULT NULL COMMENT 'running process name',
  `service_name` varchar(255) DEFAULT NULL COMMENT 'exact name of the running service',
  `service_path` varchar(255) DEFAULT NULL COMMENT 'path of the service in system',
  `pidfile` varchar(255) DEFAULT NULL COMMENT 'path of the pid file of the service',
  `isDefault` tinyint(1) DEFAULT NULL COMMENT 'Default service',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `monitoring_services`
--

LOCK TABLES `monitoring_services` WRITE;
/*!40000 ALTER TABLE `monitoring_services` DISABLE KEYS */;
INSERT INTO `monitoring_services` VALUES (1,'afc5eb7a-fcd8-11e3-9019-080027ce083d','ssh','sshd','ssh','/etc/init.d/ssh','/var/run/sshd.pid',1),(2,'afc5fa5c-fcd8-11e3-9019-080027ce083d','dhcp','dnsmasq','dnsmasq','/etc/init.d/dnsmasq','/var/run/dnsmasq/dnsmasq.pid',0),(3,'afc60a88-fcd8-11e3-9019-080027ce083d','loadbalancing','haproxy','haproxy','/etc/init.d/haproxy','/var/run/haproxy.pid',0),(4,'afc61d8e-fcd8-11e3-9019-080027ce083d','webserver','apache2','apache2','/etc/init.d/apache2','/var/run/apache2.pid',1);
/*!40000 ALTER TABLE `monitoring_services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mshost`
--

DROP TABLE IF EXISTS `mshost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mshost` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `msid` bigint(20) unsigned NOT NULL COMMENT 'management server id derived from MAC address',
  `runid` bigint(20) NOT NULL DEFAULT '0' COMMENT 'run id, combined with msid to form a cluster session',
  `name` varchar(255) DEFAULT NULL,
  `state` varchar(10) NOT NULL DEFAULT 'Down',
  `version` varchar(255) DEFAULT NULL,
  `service_ip` char(40) NOT NULL,
  `service_port` int(11) NOT NULL,
  `last_update` datetime DEFAULT NULL COMMENT 'Last record update time',
  `removed` datetime DEFAULT NULL COMMENT 'date removed if not null',
  `alert_count` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `msid` (`msid`),
  KEY `i_mshost__removed` (`removed`),
  KEY `i_mshost__last_update` (`last_update`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mshost`
--

LOCK TABLES `mshost` WRITE;
/*!40000 ALTER TABLE `mshost` DISABLE KEYS */;
INSERT INTO `mshost` VALUES (1,4278190080,1403749462271,'lp-mac-02-0214','Up','4.4.0-SNAPSHOT','127.0.0.1',9090,'2014-06-26 02:28:07',NULL,0);
/*!40000 ALTER TABLE `mshost` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mshost_peer`
--

DROP TABLE IF EXISTS `mshost_peer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mshost_peer` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `owner_mshost` bigint(20) unsigned NOT NULL,
  `peer_mshost` bigint(20) unsigned NOT NULL,
  `peer_runid` bigint(20) NOT NULL,
  `peer_state` varchar(10) NOT NULL DEFAULT 'Down',
  `last_update` datetime DEFAULT NULL COMMENT 'Last record update time',
  PRIMARY KEY (`id`),
  UNIQUE KEY `i_mshost_peer__owner_peer_runid` (`owner_mshost`,`peer_mshost`,`peer_runid`),
  KEY `fk_mshost_peer__peer_mshost` (`peer_mshost`),
  CONSTRAINT `fk_mshost_peer__owner_mshost` FOREIGN KEY (`owner_mshost`) REFERENCES `mshost` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_mshost_peer__peer_mshost` FOREIGN KEY (`peer_mshost`) REFERENCES `mshost` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mshost_peer`
--

LOCK TABLES `mshost_peer` WRITE;
/*!40000 ALTER TABLE `mshost_peer` DISABLE KEYS */;
INSERT INTO `mshost_peer` VALUES (1,1,1,1403749462271,'Up','2014-06-26 02:24:39');
/*!40000 ALTER TABLE `mshost_peer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `netapp_lun`
--

DROP TABLE IF EXISTS `netapp_lun`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `netapp_lun` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `lun_name` varchar(255) NOT NULL COMMENT 'lun name',
  `target_iqn` varchar(255) NOT NULL COMMENT 'target iqn',
  `path` varchar(255) NOT NULL COMMENT 'lun path',
  `size` bigint(20) NOT NULL COMMENT 'lun size',
  `volume_id` bigint(20) unsigned NOT NULL COMMENT 'parent volume id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `i_netapp_lun__volume_id` (`volume_id`),
  KEY `i_netapp_lun__lun_name` (`lun_name`),
  CONSTRAINT `fk_netapp_lun__volume_id` FOREIGN KEY (`volume_id`) REFERENCES `netapp_volume` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `netapp_lun`
--

LOCK TABLES `netapp_lun` WRITE;
/*!40000 ALTER TABLE `netapp_lun` DISABLE KEYS */;
/*!40000 ALTER TABLE `netapp_lun` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `netapp_pool`
--

DROP TABLE IF EXISTS `netapp_pool`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `netapp_pool` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) NOT NULL COMMENT 'name for the pool',
  `algorithm` varchar(255) NOT NULL COMMENT 'algorithm',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `netapp_pool`
--

LOCK TABLES `netapp_pool` WRITE;
/*!40000 ALTER TABLE `netapp_pool` DISABLE KEYS */;
/*!40000 ALTER TABLE `netapp_pool` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `netapp_volume`
--

DROP TABLE IF EXISTS `netapp_volume`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `netapp_volume` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `ip_address` varchar(255) NOT NULL COMMENT 'ip address/fqdn of the volume',
  `pool_id` bigint(20) unsigned NOT NULL COMMENT 'id for the pool',
  `pool_name` varchar(255) NOT NULL COMMENT 'name for the pool',
  `aggregate_name` varchar(255) NOT NULL COMMENT 'name for the aggregate',
  `volume_name` varchar(255) NOT NULL COMMENT 'name for the volume',
  `volume_size` varchar(255) NOT NULL COMMENT 'volume size',
  `snapshot_policy` varchar(255) NOT NULL COMMENT 'snapshot policy',
  `snapshot_reservation` int(11) NOT NULL COMMENT 'snapshot reservation',
  `username` varchar(255) NOT NULL COMMENT 'username',
  `password` varchar(200) DEFAULT NULL COMMENT 'password',
  `round_robin_marker` int(11) DEFAULT NULL COMMENT 'This marks the volume to be picked up for lun creation, RR fashion',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `i_netapp_volume__pool_id` (`pool_id`),
  CONSTRAINT `fk_netapp_volume__pool_id` FOREIGN KEY (`pool_id`) REFERENCES `netapp_pool` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `netapp_volume`
--

LOCK TABLES `netapp_volume` WRITE;
/*!40000 ALTER TABLE `netapp_volume` DISABLE KEYS */;
/*!40000 ALTER TABLE `netapp_volume` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `netscaler_pod_ref`
--

DROP TABLE IF EXISTS `netscaler_pod_ref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `netscaler_pod_ref` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `external_load_balancer_device_id` bigint(20) unsigned NOT NULL COMMENT 'id of external load balancer device',
  `pod_id` bigint(20) unsigned NOT NULL COMMENT 'pod id',
  PRIMARY KEY (`id`),
  KEY `fk_ns_pod_ref__pod_id` (`pod_id`),
  KEY `fk_ns_pod_ref__device_id` (`external_load_balancer_device_id`),
  CONSTRAINT `fk_ns_pod_ref__pod_id` FOREIGN KEY (`pod_id`) REFERENCES `host_pod_ref` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ns_pod_ref__device_id` FOREIGN KEY (`external_load_balancer_device_id`) REFERENCES `external_load_balancer_devices` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `netscaler_pod_ref`
--

LOCK TABLES `netscaler_pod_ref` WRITE;
/*!40000 ALTER TABLE `netscaler_pod_ref` DISABLE KEYS */;
/*!40000 ALTER TABLE `netscaler_pod_ref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `network_acl`
--

DROP TABLE IF EXISTS `network_acl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `network_acl` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) NOT NULL COMMENT 'name of the network acl',
  `uuid` varchar(40) DEFAULT NULL,
  `vpc_id` bigint(20) unsigned DEFAULT NULL COMMENT 'vpc this network acl belongs to',
  `description` varchar(1024) DEFAULT NULL,
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'True if the entry can be displayed to the end user',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `network_acl`
--

LOCK TABLES `network_acl` WRITE;
/*!40000 ALTER TABLE `network_acl` DISABLE KEYS */;
INSERT INTO `network_acl` VALUES (1,'default_deny','af59483a-fcd8-11e3-9019-080027ce083d',0,'Default Network ACL Deny All',1),(2,'default_allow','af597db4-fcd8-11e3-9019-080027ce083d',0,'Default Network ACL Allow All',1);
/*!40000 ALTER TABLE `network_acl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `network_acl_details`
--

DROP TABLE IF EXISTS `network_acl_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `network_acl_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `network_acl_id` bigint(20) unsigned NOT NULL COMMENT 'VPC gateway id',
  `name` varchar(255) NOT NULL,
  `value` varchar(1024) NOT NULL,
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'True if the detail can be displayed to the end user',
  PRIMARY KEY (`id`),
  KEY `fk_network_acl_details__network_acl_id` (`network_acl_id`),
  CONSTRAINT `fk_network_acl_details__network_acl_id` FOREIGN KEY (`network_acl_id`) REFERENCES `network_acl` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `network_acl_details`
--

LOCK TABLES `network_acl_details` WRITE;
/*!40000 ALTER TABLE `network_acl_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `network_acl_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `network_acl_item`
--

DROP TABLE IF EXISTS `network_acl_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `network_acl_item` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uuid` varchar(40) DEFAULT NULL,
  `acl_id` bigint(20) unsigned NOT NULL COMMENT 'network acl id',
  `start_port` int(10) DEFAULT NULL COMMENT 'starting port of a port range',
  `end_port` int(10) DEFAULT NULL COMMENT 'end port of a port range',
  `state` char(32) NOT NULL COMMENT 'current state of this rule',
  `protocol` char(16) NOT NULL DEFAULT 'TCP' COMMENT 'protocol to open these ports for',
  `created` datetime DEFAULT NULL COMMENT 'Date created',
  `icmp_code` int(10) DEFAULT NULL COMMENT 'The ICMP code (if protocol=ICMP). A value of -1 means all codes for the given ICMP type.',
  `icmp_type` int(10) DEFAULT NULL COMMENT 'The ICMP type (if protocol=ICMP). A value of -1 means all types.',
  `traffic_type` char(32) DEFAULT NULL COMMENT 'the traffic type of the rule, can be Ingress or Egress',
  `number` int(10) NOT NULL COMMENT 'priority number of the acl item',
  `action` varchar(10) NOT NULL COMMENT 'rule action, allow or deny',
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'True if the entry can be displayed to the end user',
  PRIMARY KEY (`id`),
  UNIQUE KEY `acl_id` (`acl_id`,`number`),
  UNIQUE KEY `uc_network_acl_item__uuid` (`uuid`),
  CONSTRAINT `fk_network_acl_item__acl_id` FOREIGN KEY (`acl_id`) REFERENCES `network_acl` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `network_acl_item`
--

LOCK TABLES `network_acl_item` WRITE;
/*!40000 ALTER TABLE `network_acl_item` DISABLE KEYS */;
INSERT INTO `network_acl_item` VALUES (1,'af595b22-fcd8-11e3-9019-080027ce083d',1,NULL,NULL,'Active','all','2014-06-26 02:22:13',NULL,NULL,'Ingress',1,'Deny',1),(2,'af596b30-fcd8-11e3-9019-080027ce083d',1,NULL,NULL,'Active','all','2014-06-26 02:22:13',NULL,NULL,'Egress',2,'Deny',1),(3,'af598d90-fcd8-11e3-9019-080027ce083d',2,NULL,NULL,'Active','all','2014-06-26 02:22:13',NULL,NULL,'Ingress',1,'Allow',1),(4,'af59a050-fcd8-11e3-9019-080027ce083d',2,NULL,NULL,'Active','all','2014-06-26 02:22:13',NULL,NULL,'Egress',2,'Allow',1);
/*!40000 ALTER TABLE `network_acl_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `network_acl_item_cidrs`
--

DROP TABLE IF EXISTS `network_acl_item_cidrs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `network_acl_item_cidrs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `network_acl_item_id` bigint(20) unsigned NOT NULL COMMENT 'Network ACL Item id',
  `cidr` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `fk_network_acl_item_id` (`network_acl_item_id`),
  CONSTRAINT `fk_network_acl_item_id` FOREIGN KEY (`network_acl_item_id`) REFERENCES `network_acl_item` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `network_acl_item_cidrs`
--

LOCK TABLES `network_acl_item_cidrs` WRITE;
/*!40000 ALTER TABLE `network_acl_item_cidrs` DISABLE KEYS */;
INSERT INTO `network_acl_item_cidrs` VALUES (1,1,'0.0.0.0/0'),(2,2,'0.0.0.0/0'),(3,3,'0.0.0.0/0'),(4,4,'0.0.0.0/0');
/*!40000 ALTER TABLE `network_acl_item_cidrs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `network_acl_item_details`
--

DROP TABLE IF EXISTS `network_acl_item_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `network_acl_item_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `network_acl_item_id` bigint(20) unsigned NOT NULL COMMENT 'VPC gateway id',
  `name` varchar(255) NOT NULL,
  `value` varchar(1024) NOT NULL,
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'True if the detail can be displayed to the end user',
  PRIMARY KEY (`id`),
  KEY `fk_network_acl_item_details__network_acl_item_id` (`network_acl_item_id`),
  CONSTRAINT `fk_network_acl_item_details__network_acl_item_id` FOREIGN KEY (`network_acl_item_id`) REFERENCES `network_acl_item` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `network_acl_item_details`
--

LOCK TABLES `network_acl_item_details` WRITE;
/*!40000 ALTER TABLE `network_acl_item_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `network_acl_item_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `network_asa1000v_map`
--

DROP TABLE IF EXISTS `network_asa1000v_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `network_asa1000v_map` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `network_id` bigint(20) unsigned NOT NULL COMMENT 'id of guest network',
  `asa1000v_id` bigint(20) unsigned NOT NULL COMMENT 'id of asa1000v device',
  PRIMARY KEY (`id`),
  UNIQUE KEY `network_id` (`network_id`),
  UNIQUE KEY `asa1000v_id` (`asa1000v_id`),
  CONSTRAINT `fk_network_asa1000v_map__network_id` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_network_asa1000v_map__asa1000v_id` FOREIGN KEY (`asa1000v_id`) REFERENCES `external_cisco_asa1000v_devices` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `network_asa1000v_map`
--

LOCK TABLES `network_asa1000v_map` WRITE;
/*!40000 ALTER TABLE `network_asa1000v_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `network_asa1000v_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `network_details`
--

DROP TABLE IF EXISTS `network_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `network_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `network_id` bigint(20) unsigned NOT NULL COMMENT 'network id',
  `name` varchar(255) NOT NULL,
  `value` varchar(1024) NOT NULL,
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'True if the detail can be displayed to the end user',
  PRIMARY KEY (`id`),
  KEY `fk_network_details__network_id` (`network_id`),
  CONSTRAINT `fk_network_details__network_id` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `network_details`
--

LOCK TABLES `network_details` WRITE;
/*!40000 ALTER TABLE `network_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `network_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `network_external_firewall_device_map`
--

DROP TABLE IF EXISTS `network_external_firewall_device_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `network_external_firewall_device_map` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uuid` varchar(255) DEFAULT NULL,
  `network_id` bigint(20) unsigned NOT NULL COMMENT ' guest network id',
  `external_firewall_device_id` bigint(20) unsigned NOT NULL COMMENT 'id of external firewall device assigned for this device',
  `created` datetime DEFAULT NULL COMMENT 'Date from when network started using the device',
  `removed` datetime DEFAULT NULL COMMENT 'Date till the network stopped using the device ',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `fk_network_external_firewall_devices_network_id` (`network_id`),
  KEY `fk_network_external_firewall_devices_device_id` (`external_firewall_device_id`),
  CONSTRAINT `fk_network_external_firewall_devices_network_id` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_network_external_firewall_devices_device_id` FOREIGN KEY (`external_firewall_device_id`) REFERENCES `external_firewall_devices` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `network_external_firewall_device_map`
--

LOCK TABLES `network_external_firewall_device_map` WRITE;
/*!40000 ALTER TABLE `network_external_firewall_device_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `network_external_firewall_device_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `network_external_lb_device_map`
--

DROP TABLE IF EXISTS `network_external_lb_device_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `network_external_lb_device_map` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uuid` varchar(255) DEFAULT NULL,
  `network_id` bigint(20) unsigned NOT NULL COMMENT ' guest network id',
  `external_load_balancer_device_id` bigint(20) unsigned NOT NULL COMMENT 'id of external load balancer device assigned for this network',
  `created` datetime DEFAULT NULL COMMENT 'Date from when network started using the device',
  `removed` datetime DEFAULT NULL COMMENT 'Date till the network stopped using the device ',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `fk_network_external_lb_devices_network_id` (`network_id`),
  KEY `fk_network_external_lb_devices_device_id` (`external_load_balancer_device_id`),
  CONSTRAINT `fk_network_external_lb_devices_network_id` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_network_external_lb_devices_device_id` FOREIGN KEY (`external_load_balancer_device_id`) REFERENCES `external_load_balancer_devices` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `network_external_lb_device_map`
--

LOCK TABLES `network_external_lb_device_map` WRITE;
/*!40000 ALTER TABLE `network_external_lb_device_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `network_external_lb_device_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `network_offering_details`
--

DROP TABLE IF EXISTS `network_offering_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `network_offering_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `network_offering_id` bigint(20) unsigned NOT NULL COMMENT 'network offering id',
  `name` varchar(255) NOT NULL,
  `value` varchar(1024) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_network_offering_details__network_offering_id` (`network_offering_id`),
  CONSTRAINT `fk_network_offering_details__network_offering_id` FOREIGN KEY (`network_offering_id`) REFERENCES `network_offerings` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `network_offering_details`
--

LOCK TABLES `network_offering_details` WRITE;
/*!40000 ALTER TABLE `network_offering_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `network_offering_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `network_offerings`
--

DROP TABLE IF EXISTS `network_offerings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `network_offerings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(64) DEFAULT NULL COMMENT 'name of the network offering',
  `uuid` varchar(40) DEFAULT NULL,
  `unique_name` varchar(64) DEFAULT NULL COMMENT 'unique name of the network offering',
  `display_text` varchar(255) NOT NULL COMMENT 'text to display to users',
  `nw_rate` smallint(5) unsigned DEFAULT NULL COMMENT 'network rate throttle mbits/s',
  `mc_rate` smallint(5) unsigned DEFAULT NULL COMMENT 'mcast rate throttle mbits/s',
  `traffic_type` varchar(32) NOT NULL COMMENT 'traffic type carried on this network',
  `tags` varchar(4096) DEFAULT NULL COMMENT 'tags supported by this offering',
  `system_only` int(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Is this network offering for system use only',
  `specify_vlan` int(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Should the user specify vlan',
  `service_offering_id` bigint(20) unsigned DEFAULT NULL COMMENT 'service offering id that virtual router is tied to',
  `conserve_mode` int(1) unsigned NOT NULL DEFAULT '1' COMMENT 'Is this network offering is IP conserve mode enabled',
  `created` datetime NOT NULL COMMENT 'time the entry was created',
  `removed` datetime DEFAULT NULL COMMENT 'time the entry was removed',
  `default` int(1) unsigned NOT NULL DEFAULT '0' COMMENT '1 if network offering is default',
  `availability` varchar(255) NOT NULL COMMENT 'availability of the network',
  `dedicated_lb_service` int(1) unsigned NOT NULL DEFAULT '1' COMMENT 'true if the network offering provides a dedicated load balancer for each network',
  `shared_source_nat_service` int(1) unsigned NOT NULL DEFAULT '0' COMMENT 'true if the network offering provides the shared source nat service',
  `sort_key` int(32) NOT NULL DEFAULT '0' COMMENT 'sort key used for customising sort method',
  `redundant_router_service` int(1) unsigned NOT NULL DEFAULT '0' COMMENT 'true if the network offering provides the redundant router service',
  `state` char(32) DEFAULT NULL COMMENT 'state of the network offering that has Disabled value by default',
  `guest_type` char(32) DEFAULT NULL COMMENT 'type of guest network that can be shared or isolated',
  `elastic_ip_service` int(1) unsigned NOT NULL DEFAULT '0' COMMENT 'true if the network offering provides elastic ip service',
  `eip_associate_public_ip` int(1) unsigned NOT NULL DEFAULT '0' COMMENT 'true if public IP is associated with user VM creation by default when EIP service is enabled.',
  `elastic_lb_service` int(1) unsigned NOT NULL DEFAULT '0' COMMENT 'true if the network offering provides elastic lb service',
  `specify_ip_ranges` int(1) unsigned NOT NULL DEFAULT '0' COMMENT 'true if the network offering provides an ability to define ip ranges',
  `inline` int(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Is this network offering LB provider is in inline mode',
  `is_persistent` int(1) unsigned NOT NULL DEFAULT '0' COMMENT 'true if the network offering provides an ability to create persistent networks',
  `internal_lb` int(1) unsigned NOT NULL DEFAULT '0' COMMENT 'true if the network offering supports Internal lb service',
  `public_lb` int(1) unsigned NOT NULL DEFAULT '0' COMMENT 'true if the network offering supports Public lb service',
  `egress_default_policy` tinyint(1) DEFAULT '0',
  `concurrent_connections` int(10) unsigned DEFAULT NULL COMMENT 'Load Balancer(haproxy) maximum number of concurrent connections(global max)',
  `keep_alive_enabled` int(1) unsigned NOT NULL DEFAULT '1' COMMENT 'true if connection should be reset after requests.',
  `supports_streched_l2` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `unique_name` (`unique_name`),
  UNIQUE KEY `uc_network_offerings__uuid` (`uuid`),
  KEY `i_network_offerings__system_only` (`system_only`),
  KEY `i_network_offerings__removed` (`removed`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `network_offerings`
--

LOCK TABLES `network_offerings` WRITE;
/*!40000 ALTER TABLE `network_offerings` DISABLE KEYS */;
INSERT INTO `network_offerings` VALUES (1,'System-Public-Network','2ab64b7c-8e6a-4a37-be63-7cd6d2594c14','System-Public-Network','System Offering for System-Public-Network',0,0,'Public',NULL,1,0,NULL,1,'2014-06-26 02:23:27',NULL,1,'Required',1,0,0,0,'Enabled',NULL,0,1,0,1,0,0,0,0,0,NULL,0,0),(2,'System-Management-Network','42b06b82-9198-431f-8b6c-ea7739fdd028','System-Management-Network','System Offering for System-Management-Network',0,0,'Management',NULL,1,0,NULL,1,'2014-06-26 02:23:27',NULL,1,'Required',1,0,0,0,'Enabled',NULL,0,1,0,0,0,0,0,0,0,NULL,0,0),(3,'System-Control-Network','e0eb3449-43f4-41bd-a5de-b35fc09b1198','System-Control-Network','System Offering for System-Control-Network',0,0,'Control',NULL,1,0,NULL,1,'2014-06-26 02:23:27',NULL,1,'Required',1,0,0,0,'Enabled',NULL,0,1,0,0,0,0,0,0,0,NULL,0,0),(4,'System-Storage-Network','e9fe5ff7-ec92-4d9f-ad06-7ba3e2551505','System-Storage-Network','System Offering for System-Storage-Network',0,0,'Storage',NULL,1,0,NULL,1,'2014-06-26 02:23:27',NULL,1,'Required',1,0,0,0,'Enabled',NULL,0,1,0,1,0,0,0,0,0,NULL,0,0),(5,'System-Private-Gateway-Network-Offering','2c8f045c-295e-4656-8e98-a5083c08e420','System-Private-Gateway-Network-Offering','System Offering for System-Private-Gateway-Network-Offering',0,0,'Guest',NULL,1,1,NULL,1,'2014-06-26 02:23:27',NULL,1,'Optional',1,0,0,0,'Enabled','Isolated',0,1,0,0,0,0,0,0,0,NULL,0,0),(6,'DefaultSharedNetworkOfferingWithSGService','7b3e27f9-7857-40a7-ae6e-4b407aada65d','DefaultSharedNetworkOfferingWithSGService','Offering for Shared Security group enabled networks',NULL,NULL,'Guest',NULL,0,1,NULL,1,'2014-06-26 02:23:27',NULL,1,'Optional',1,0,0,0,'Enabled','Shared',0,1,0,1,0,0,0,0,0,NULL,0,0),(7,'DefaultSharedNetworkOffering','3616abb5-6588-49d9-ab93-b848586ec9c3','DefaultSharedNetworkOffering','Offering for Shared networks',NULL,NULL,'Guest',NULL,0,1,NULL,1,'2014-06-26 02:23:27',NULL,1,'Optional',1,0,0,0,'Enabled','Shared',0,1,0,1,0,0,0,0,0,NULL,0,0),(8,'DefaultIsolatedNetworkOfferingWithSourceNatService','016ae9f7-67de-4bca-8ff2-866de3d7fff7','DefaultIsolatedNetworkOfferingWithSourceNatService','Offering for Isolated networks with Source Nat service enabled',NULL,NULL,'Guest',NULL,0,0,NULL,1,'2014-06-26 02:23:27',NULL,1,'Required',1,0,0,0,'Enabled','Isolated',0,1,0,0,0,0,0,1,0,NULL,0,0),(9,'DefaultIsolatedNetworkOffering','320d75ac-076d-4856-b804-63376fe0128d','DefaultIsolatedNetworkOffering','Offering for Isolated networks with no Source Nat service',NULL,NULL,'Guest',NULL,0,1,NULL,1,'2014-06-26 02:23:27',NULL,1,'Optional',1,0,0,0,'Enabled','Isolated',0,1,0,1,0,0,0,0,0,NULL,0,0),(10,'DefaultSharedNetscalerEIPandELBNetworkOffering','fd33377f-b512-4c6f-976d-5aa14e0b0d11','DefaultSharedNetscalerEIPandELBNetworkOffering','Offering for Shared networks with Elastic IP and Elastic LB capabilities',NULL,NULL,'Guest',NULL,0,1,NULL,1,'2014-06-26 02:23:27',NULL,1,'Optional',0,0,0,0,'Enabled','Shared',1,1,1,1,0,0,0,1,0,NULL,0,0),(11,'DefaultIsolatedNetworkOfferingForVpcNetworks','78ceb386-a862-4fec-a367-02c7f39952af','DefaultIsolatedNetworkOfferingForVpcNetworks','Offering for Isolated Vpc networks with Source Nat service enabled',NULL,NULL,'Guest',NULL,0,0,NULL,0,'2014-06-26 02:23:27',NULL,1,'Optional',1,0,0,0,'Enabled','Isolated',0,1,0,0,0,0,0,1,0,NULL,0,0),(12,'DefaultIsolatedNetworkOfferingForVpcNetworksNoLB','021dc937-6a69-4b91-a366-52ccdf0b870f','DefaultIsolatedNetworkOfferingForVpcNetworksNoLB','Offering for Isolated Vpc networks with Source Nat service enabled and LB service Disabled',NULL,NULL,'Guest',NULL,0,0,NULL,0,'2014-06-26 02:23:27',NULL,1,'Optional',1,0,0,0,'Enabled','Isolated',0,1,0,0,0,0,0,0,0,NULL,0,0),(13,'DefaultIsolatedNetworkOfferingForVpcNetworksWithInternalLB','d7dad98f-b285-48da-b9b9-b9852e80f115','DefaultIsolatedNetworkOfferingForVpcNetworksWithInternalLB','Offering for Isolated Vpc networks with Internal LB support',NULL,NULL,'Guest',NULL,0,0,NULL,0,'2014-06-26 02:23:27',NULL,1,'Optional',1,0,0,0,'Enabled','Isolated',0,1,0,0,0,0,1,0,0,NULL,0,0),(14,'QuickCloudNoServices','bd796052-e2ce-4760-8c45-d297930914be','QuickCloudNoServices','Offering for QuickCloud with no services',NULL,10,'Guest',NULL,0,1,NULL,1,'2014-06-26 02:23:27',NULL,1,'Optional',0,0,0,0,'Enabled','Shared',0,0,0,1,0,0,0,0,0,NULL,1,0);
/*!40000 ALTER TABLE `network_offerings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `network_rule_config`
--

DROP TABLE IF EXISTS `network_rule_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `network_rule_config` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `security_group_id` bigint(20) unsigned NOT NULL,
  `public_port` varchar(10) DEFAULT NULL,
  `private_port` varchar(10) DEFAULT NULL,
  `protocol` varchar(16) NOT NULL DEFAULT 'TCP',
  `create_status` varchar(32) DEFAULT NULL COMMENT 'rule creation status',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `network_rule_config`
--

LOCK TABLES `network_rule_config` WRITE;
/*!40000 ALTER TABLE `network_rule_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `network_rule_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `networks`
--

DROP TABLE IF EXISTS `networks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `networks` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) DEFAULT NULL COMMENT 'name for this network',
  `uuid` varchar(40) DEFAULT NULL,
  `display_text` varchar(255) DEFAULT NULL COMMENT 'display text for this network',
  `traffic_type` varchar(32) NOT NULL COMMENT 'type of traffic going through this network',
  `broadcast_domain_type` varchar(32) NOT NULL COMMENT 'type of broadcast domain used',
  `broadcast_uri` varchar(255) DEFAULT NULL COMMENT 'broadcast domain specifier',
  `gateway` varchar(15) DEFAULT NULL COMMENT 'gateway for this network configuration',
  `cidr` varchar(18) DEFAULT NULL COMMENT 'CloudStack managed vms get IP address from cidr.In general this cidr also serves as the network CIDR. But in case IP reservation feature is being used by a Guest network, networkcidr is the Effective network CIDR for that network',
  `mode` varchar(32) DEFAULT NULL COMMENT 'How to retrieve ip address in this network',
  `network_offering_id` bigint(20) unsigned NOT NULL COMMENT 'network offering id that this configuration is created from',
  `physical_network_id` bigint(20) unsigned DEFAULT NULL COMMENT 'physical network id that this configuration is based on',
  `data_center_id` bigint(20) unsigned NOT NULL COMMENT 'data center id that this configuration is used in',
  `guru_name` varchar(255) NOT NULL COMMENT 'who is responsible for this type of network configuration',
  `state` varchar(32) NOT NULL COMMENT 'what state is this configuration in',
  `related` bigint(20) unsigned NOT NULL COMMENT 'related to what other network configuration',
  `domain_id` bigint(20) unsigned NOT NULL COMMENT 'foreign key to domain id',
  `account_id` bigint(20) unsigned NOT NULL COMMENT 'owner of this network',
  `dns1` varchar(255) DEFAULT NULL COMMENT 'comma separated DNS list',
  `dns2` varchar(255) DEFAULT NULL COMMENT 'comma separated DNS list',
  `guru_data` varchar(1024) DEFAULT NULL COMMENT 'data stored by the network guru that setup this network',
  `set_fields` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'which fields are set already',
  `acl_type` varchar(15) DEFAULT NULL COMMENT 'ACL access type. Null for system networks, can be Account/Domain for Guest networks',
  `network_domain` varchar(255) DEFAULT NULL COMMENT 'domain',
  `reservation_id` char(40) DEFAULT NULL COMMENT 'reservation id',
  `guest_type` char(32) DEFAULT NULL COMMENT 'type of guest network that can be shared or isolated',
  `restart_required` int(1) unsigned NOT NULL DEFAULT '0' COMMENT '1 if restart is required for the network',
  `created` datetime NOT NULL COMMENT 'date created',
  `removed` datetime DEFAULT NULL COMMENT 'date removed if not null',
  `specify_ip_ranges` int(1) unsigned NOT NULL DEFAULT '0' COMMENT 'true if the network provides an ability to define ip ranges',
  `vpc_id` bigint(20) unsigned DEFAULT NULL COMMENT 'vpc this network belongs to',
  `ip6_gateway` varchar(50) DEFAULT NULL COMMENT 'IPv6 gateway for this network',
  `ip6_cidr` varchar(50) DEFAULT NULL COMMENT 'IPv6 cidr for this network',
  `network_cidr` varchar(18) DEFAULT NULL COMMENT 'The network cidr for the isolated guest network which uses IP Reservation facility.For networks not using IP reservation, network_cidr is always null.',
  `display_network` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Should network be displayed to the end user',
  `network_acl_id` bigint(20) unsigned DEFAULT NULL COMMENT 'network acl id',
  `streched_l2` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_networks__uuid` (`uuid`),
  KEY `fk_networks__network_offering_id` (`network_offering_id`),
  KEY `fk_networks__data_center_id` (`data_center_id`),
  KEY `fk_networks__related` (`related`),
  KEY `fk_networks__account_id` (`account_id`),
  KEY `fk_networks__domain_id` (`domain_id`),
  KEY `fk_networks__vpc_id` (`vpc_id`),
  KEY `i_networks__removed` (`removed`),
  CONSTRAINT `fk_networks__account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `fk_networks__data_center_id` FOREIGN KEY (`data_center_id`) REFERENCES `data_center` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_networks__domain_id` FOREIGN KEY (`domain_id`) REFERENCES `domain` (`id`),
  CONSTRAINT `fk_networks__network_offering_id` FOREIGN KEY (`network_offering_id`) REFERENCES `network_offerings` (`id`),
  CONSTRAINT `fk_networks__related` FOREIGN KEY (`related`) REFERENCES `networks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_networks__vpc_id` FOREIGN KEY (`vpc_id`) REFERENCES `vpc` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=204 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `networks`
--

LOCK TABLES `networks` WRITE;
/*!40000 ALTER TABLE `networks` DISABLE KEYS */;
INSERT INTO `networks` VALUES (200,NULL,'25930054-12f2-4ae3-995d-fcec1fe5f3bd',NULL,'Public','Vlan',NULL,NULL,NULL,'Static',1,NULL,1,'PublicNetworkGuru','Setup',200,1,1,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,'2014-06-26 02:24:47',NULL,1,NULL,NULL,NULL,NULL,1,NULL,0),(201,NULL,'39da5134-5f95-479e-a130-2b8f79154860',NULL,'Management','Native',NULL,NULL,NULL,'Static',2,NULL,1,'PodBasedNetworkGuru','Setup',201,1,1,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,'2014-06-26 02:24:47',NULL,0,NULL,NULL,NULL,NULL,1,NULL,0),(202,NULL,'84c6174d-0245-45f6-a4c5-a2024b9de030',NULL,'Control','LinkLocal',NULL,'169.254.0.1','169.254.0.0/16','Static',3,NULL,1,'ControlNetworkGuru','Setup',202,1,1,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,'2014-06-26 02:24:47',NULL,0,NULL,NULL,NULL,NULL,1,NULL,0),(203,NULL,'64c97152-27f1-4682-87f0-8b1beda8ebf8',NULL,'Storage','Native',NULL,NULL,NULL,'Static',4,NULL,1,'StorageNetworkGuru','Setup',203,1,1,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,'2014-06-26 02:24:47',NULL,1,NULL,NULL,NULL,NULL,1,NULL,0);
/*!40000 ALTER TABLE `networks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nic_details`
--

DROP TABLE IF EXISTS `nic_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nic_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nic_id` bigint(20) unsigned NOT NULL COMMENT 'nic id',
  `name` varchar(255) NOT NULL,
  `value` varchar(1024) NOT NULL,
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'True if the detail can be displayed to the end user',
  PRIMARY KEY (`id`),
  KEY `fk_nic_details__nic_id` (`nic_id`),
  CONSTRAINT `fk_nic_details__nic_id` FOREIGN KEY (`nic_id`) REFERENCES `nics` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nic_details`
--

LOCK TABLES `nic_details` WRITE;
/*!40000 ALTER TABLE `nic_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `nic_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nic_ip_alias`
--

DROP TABLE IF EXISTS `nic_ip_alias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nic_ip_alias` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(40) NOT NULL,
  `nic_id` bigint(20) unsigned DEFAULT NULL,
  `ip4_address` char(40) DEFAULT NULL,
  `ip6_address` char(40) DEFAULT NULL,
  `netmask` char(40) DEFAULT NULL,
  `gateway` char(40) DEFAULT NULL,
  `start_ip_of_subnet` char(40) DEFAULT NULL,
  `network_id` bigint(20) unsigned DEFAULT NULL,
  `vmId` bigint(20) unsigned DEFAULT NULL,
  `alias_count` bigint(20) unsigned DEFAULT NULL,
  `created` datetime NOT NULL,
  `account_id` bigint(20) unsigned NOT NULL,
  `domain_id` bigint(20) unsigned NOT NULL,
  `state` char(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nic_ip_alias`
--

LOCK TABLES `nic_ip_alias` WRITE;
/*!40000 ALTER TABLE `nic_ip_alias` DISABLE KEYS */;
/*!40000 ALTER TABLE `nic_ip_alias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nic_secondary_ips`
--

DROP TABLE IF EXISTS `nic_secondary_ips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nic_secondary_ips` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(40) DEFAULT NULL,
  `vmId` bigint(20) unsigned DEFAULT NULL COMMENT 'vm instance id',
  `nicId` bigint(20) unsigned NOT NULL,
  `ip4_address` char(40) DEFAULT NULL COMMENT 'ip4 address',
  `ip6_address` char(40) DEFAULT NULL COMMENT 'ip6 address',
  `network_id` bigint(20) unsigned NOT NULL COMMENT 'network configuration id',
  `created` datetime NOT NULL COMMENT 'date created',
  `account_id` bigint(20) unsigned NOT NULL COMMENT 'owner.  foreign key to   account table',
  `domain_id` bigint(20) unsigned NOT NULL COMMENT 'the domain that the owner belongs to',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `uc_nic_secondary_ip__uuid` (`uuid`),
  KEY `fk_nic_secondary_ip__vmId` (`vmId`),
  KEY `fk_nic_secondary_ip__networks_id` (`network_id`),
  CONSTRAINT `fk_nic_secondary_ip__vmId` FOREIGN KEY (`vmId`) REFERENCES `vm_instance` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_nic_secondary_ip__networks_id` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nic_secondary_ips`
--

LOCK TABLES `nic_secondary_ips` WRITE;
/*!40000 ALTER TABLE `nic_secondary_ips` DISABLE KEYS */;
/*!40000 ALTER TABLE `nic_secondary_ips` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nicira_nvp_nic_map`
--

DROP TABLE IF EXISTS `nicira_nvp_nic_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nicira_nvp_nic_map` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `logicalswitch` varchar(255) NOT NULL COMMENT 'nicira uuid of logical switch this port is provisioned on',
  `logicalswitchport` varchar(255) DEFAULT NULL COMMENT 'nicira uuid of this logical switch port',
  `nic` varchar(255) DEFAULT NULL COMMENT 'cloudstack uuid of the nic connected to this logical switch port',
  PRIMARY KEY (`id`),
  UNIQUE KEY `logicalswitchport` (`logicalswitchport`),
  UNIQUE KEY `nic` (`nic`),
  CONSTRAINT `fk_nicira_nvp_nic_map__nic` FOREIGN KEY (`nic`) REFERENCES `nics` (`uuid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nicira_nvp_nic_map`
--

LOCK TABLES `nicira_nvp_nic_map` WRITE;
/*!40000 ALTER TABLE `nicira_nvp_nic_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `nicira_nvp_nic_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nicira_nvp_router_map`
--

DROP TABLE IF EXISTS `nicira_nvp_router_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nicira_nvp_router_map` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `logicalrouter_uuid` varchar(255) NOT NULL COMMENT 'nicira uuid of logical router',
  `network_id` bigint(20) unsigned NOT NULL COMMENT 'cloudstack id of the network',
  PRIMARY KEY (`id`),
  UNIQUE KEY `logicalrouter_uuid` (`logicalrouter_uuid`),
  UNIQUE KEY `network_id` (`network_id`),
  CONSTRAINT `fk_nicira_nvp_router_map__network_id` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nicira_nvp_router_map`
--

LOCK TABLES `nicira_nvp_router_map` WRITE;
/*!40000 ALTER TABLE `nicira_nvp_router_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `nicira_nvp_router_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nics`
--

DROP TABLE IF EXISTS `nics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nics` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uuid` varchar(40) DEFAULT NULL,
  `instance_id` bigint(20) unsigned DEFAULT NULL COMMENT 'vm instance id',
  `mac_address` varchar(17) DEFAULT NULL COMMENT 'mac address',
  `ip4_address` char(40) DEFAULT NULL COMMENT 'ip4 address',
  `netmask` varchar(15) DEFAULT NULL COMMENT 'netmask for ip4 address',
  `gateway` varchar(15) DEFAULT NULL COMMENT 'gateway',
  `ip_type` varchar(32) DEFAULT NULL COMMENT 'type of ip',
  `broadcast_uri` varchar(255) DEFAULT NULL COMMENT 'broadcast uri',
  `network_id` bigint(20) unsigned NOT NULL COMMENT 'network configuration id',
  `mode` varchar(32) DEFAULT NULL COMMENT 'mode of getting ip address',
  `state` varchar(32) NOT NULL COMMENT 'state of the creation',
  `strategy` varchar(32) NOT NULL COMMENT 'reservation strategy',
  `reserver_name` varchar(255) DEFAULT NULL COMMENT 'Name of the component that reserved the ip address',
  `reservation_id` varchar(64) DEFAULT NULL COMMENT 'id for the reservation',
  `device_id` int(10) DEFAULT NULL COMMENT 'device id for the network when plugged into the virtual machine',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the state was changed',
  `isolation_uri` varchar(255) DEFAULT NULL COMMENT 'id for isolation',
  `ip6_address` char(40) DEFAULT NULL COMMENT 'ip6 address',
  `default_nic` tinyint(4) NOT NULL COMMENT 'None',
  `vm_type` varchar(32) DEFAULT NULL COMMENT 'type of vm: System or User vm',
  `created` datetime NOT NULL COMMENT 'date created',
  `removed` datetime DEFAULT NULL COMMENT 'date removed if not null',
  `ip6_gateway` varchar(50) DEFAULT NULL COMMENT 'gateway for ip6 address',
  `ip6_cidr` varchar(50) DEFAULT NULL COMMENT 'cidr for ip6 address',
  `secondary_ip` smallint(6) DEFAULT '0' COMMENT 'secondary ips configured for the nic',
  `display_nic` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Should nic be displayed to the end user',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `uc_nics__uuid` (`uuid`),
  KEY `fk_nics__instance_id` (`instance_id`),
  KEY `fk_nics__networks_id` (`network_id`),
  KEY `i_nics__removed` (`removed`),
  CONSTRAINT `fk_nics__instance_id` FOREIGN KEY (`instance_id`) REFERENCES `vm_instance` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_nics__networks_id` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nics`
--

LOCK TABLES `nics` WRITE;
/*!40000 ALTER TABLE `nics` DISABLE KEYS */;
INSERT INTO `nics` VALUES (1,'c2f62e53-bb9a-49d4-967f-7d091d623cb0',1,'06:ed:fc:00:00:c8','192.168.2.2','255.255.255.0','192.168.2.1','Ip4','vlan://50',200,'Static','Reserved','Create','PublicNetworkGuru',NULL,2,'2014-06-26 02:27:59','vlan://50',NULL,1,'ConsoleProxy','2014-06-26 02:27:57',NULL,NULL,NULL,0,1),(2,'5c24c46c-ee64-4d53-92f4-84a9e55590f3',1,'0e:00:a9:fe:02:23','169.254.2.35','255.255.0.0','169.254.0.1','Ip4',NULL,202,'Static','Reserved','Start','ControlNetworkGuru','84d9c349-c24b-4df6-a59a-e5e0fa33c96b',0,'2014-06-26 02:27:59',NULL,NULL,0,'ConsoleProxy','2014-06-26 02:27:57',NULL,NULL,NULL,0,1),(3,'c432c2c4-cf3c-41fa-a77c-5cf5e57bdc7d',1,'06:be:e8:00:00:61','172.16.15.98','255.255.255.0','172.16.15.1','Ip4',NULL,201,'Static','Reserved','Start','PodBasedNetworkGuru','84d9c349-c24b-4df6-a59a-e5e0fa33c96b',1,'2014-06-26 02:27:59',NULL,NULL,0,'ConsoleProxy','2014-06-26 02:27:57',NULL,NULL,NULL,0,1),(4,'d8e1849d-338b-4880-b7cc-1731f0d30e1e',2,'06:f3:82:00:00:c9','192.168.2.3','255.255.255.0','192.168.2.1','Ip4','vlan://50',200,'Static','Reserved','Create','PublicNetworkGuru',NULL,2,'2014-06-26 02:27:59','vlan://50',NULL,1,'SecondaryStorageVm','2014-06-26 02:27:58',NULL,NULL,NULL,0,1),(5,'c0b9a995-b51c-40ad-827e-4b231a314d50',2,'0e:00:a9:fe:00:9e','169.254.0.158','255.255.0.0','169.254.0.1','Ip4',NULL,202,'Static','Reserved','Start','ControlNetworkGuru','757c5413-7e8f-4a79-9e93-04be9c524687',0,'2014-06-26 02:27:59',NULL,NULL,0,'SecondaryStorageVm','2014-06-26 02:27:58',NULL,NULL,NULL,0,1),(6,'c8d4c9ce-4d41-4887-b325-55cd76e1d5e3',2,'06:6e:d4:00:00:23','172.16.15.36','255.255.255.0','172.16.15.1','Ip4',NULL,201,'Static','Reserved','Start','PodBasedNetworkGuru','757c5413-7e8f-4a79-9e93-04be9c524687',1,'2014-06-26 02:27:59',NULL,NULL,0,'SecondaryStorageVm','2014-06-26 02:27:58',NULL,NULL,NULL,0,1),(7,'6787c5d4-bf0f-4b61-b5cc-f76c4687cfea',2,'06:b6:d4:00:00:31','172.16.15.50','255.255.255.0','172.16.15.1','Ip4',NULL,203,'Static','Reserved','Start','StorageNetworkGuru','757c5413-7e8f-4a79-9e93-04be9c524687',3,'2014-06-26 02:27:59',NULL,NULL,0,'SecondaryStorageVm','2014-06-26 02:27:58',NULL,NULL,NULL,0,1);
/*!40000 ALTER TABLE `nics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ntwk_offering_service_map`
--

DROP TABLE IF EXISTS `ntwk_offering_service_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ntwk_offering_service_map` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `network_offering_id` bigint(20) unsigned NOT NULL COMMENT 'network_offering_id',
  `service` varchar(255) NOT NULL COMMENT 'service',
  `provider` varchar(255) DEFAULT NULL COMMENT 'service provider',
  `created` datetime DEFAULT NULL COMMENT 'date created',
  PRIMARY KEY (`id`),
  UNIQUE KEY `network_offering_id` (`network_offering_id`,`service`,`provider`),
  CONSTRAINT `fk_ntwk_offering_service_map__network_offering_id` FOREIGN KEY (`network_offering_id`) REFERENCES `network_offerings` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ntwk_offering_service_map`
--

LOCK TABLES `ntwk_offering_service_map` WRITE;
/*!40000 ALTER TABLE `ntwk_offering_service_map` DISABLE KEYS */;
INSERT INTO `ntwk_offering_service_map` VALUES (1,6,'Dhcp','VirtualRouter','2014-06-26 02:23:27'),(2,6,'Dns','VirtualRouter','2014-06-26 02:23:27'),(3,6,'SecurityGroup','SecurityGroupProvider','2014-06-26 02:23:27'),(4,6,'UserData','VirtualRouter','2014-06-26 02:23:27'),(5,7,'Dhcp','VirtualRouter','2014-06-26 02:23:27'),(6,7,'Dns','VirtualRouter','2014-06-26 02:23:27'),(7,7,'UserData','VirtualRouter','2014-06-26 02:23:27'),(8,8,'PortForwarding','VirtualRouter','2014-06-26 02:23:27'),(9,8,'Dhcp','VirtualRouter','2014-06-26 02:23:27'),(10,8,'Firewall','VirtualRouter','2014-06-26 02:23:27'),(11,8,'Dns','VirtualRouter','2014-06-26 02:23:27'),(12,8,'Lb','VirtualRouter','2014-06-26 02:23:27'),(13,8,'StaticNat','VirtualRouter','2014-06-26 02:23:27'),(14,8,'Vpn','VirtualRouter','2014-06-26 02:23:27'),(15,8,'SourceNat','VirtualRouter','2014-06-26 02:23:27'),(16,8,'Gateway','VirtualRouter','2014-06-26 02:23:27'),(17,8,'UserData','VirtualRouter','2014-06-26 02:23:27'),(18,9,'Dhcp','VirtualRouter','2014-06-26 02:23:27'),(19,9,'Dns','VirtualRouter','2014-06-26 02:23:27'),(20,9,'UserData','VirtualRouter','2014-06-26 02:23:27'),(21,10,'Dhcp','VirtualRouter','2014-06-26 02:23:27'),(22,10,'Dns','VirtualRouter','2014-06-26 02:23:27'),(23,10,'Lb','Netscaler','2014-06-26 02:23:27'),(24,10,'StaticNat','Netscaler','2014-06-26 02:23:27'),(25,10,'SecurityGroup','SecurityGroupProvider','2014-06-26 02:23:27'),(26,10,'UserData','VirtualRouter','2014-06-26 02:23:27'),(27,11,'PortForwarding','VpcVirtualRouter','2014-06-26 02:23:27'),(28,11,'Dhcp','VpcVirtualRouter','2014-06-26 02:23:27'),(29,11,'Dns','VpcVirtualRouter','2014-06-26 02:23:27'),(30,11,'Lb','VpcVirtualRouter','2014-06-26 02:23:27'),(31,11,'StaticNat','VpcVirtualRouter','2014-06-26 02:23:27'),(32,11,'Vpn','VpcVirtualRouter','2014-06-26 02:23:27'),(33,11,'SourceNat','VpcVirtualRouter','2014-06-26 02:23:27'),(34,11,'Gateway','VpcVirtualRouter','2014-06-26 02:23:27'),(35,11,'UserData','VpcVirtualRouter','2014-06-26 02:23:27'),(36,11,'NetworkACL','VpcVirtualRouter','2014-06-26 02:23:27'),(37,12,'PortForwarding','VpcVirtualRouter','2014-06-26 02:23:27'),(38,12,'Dhcp','VpcVirtualRouter','2014-06-26 02:23:27'),(39,12,'Dns','VpcVirtualRouter','2014-06-26 02:23:27'),(40,12,'StaticNat','VpcVirtualRouter','2014-06-26 02:23:27'),(41,12,'Vpn','VpcVirtualRouter','2014-06-26 02:23:27'),(42,12,'SourceNat','VpcVirtualRouter','2014-06-26 02:23:27'),(43,12,'Gateway','VpcVirtualRouter','2014-06-26 02:23:27'),(44,12,'UserData','VpcVirtualRouter','2014-06-26 02:23:27'),(45,12,'NetworkACL','VpcVirtualRouter','2014-06-26 02:23:27'),(46,13,'Dhcp','VpcVirtualRouter','2014-06-26 02:23:27'),(47,13,'Dns','VpcVirtualRouter','2014-06-26 02:23:27'),(48,13,'Lb','InternalLbVm','2014-06-26 02:23:27'),(49,13,'SourceNat','VpcVirtualRouter','2014-06-26 02:23:27'),(50,13,'Gateway','VpcVirtualRouter','2014-06-26 02:23:27'),(51,13,'UserData','VpcVirtualRouter','2014-06-26 02:23:27'),(52,13,'NetworkACL','VpcVirtualRouter','2014-06-26 02:23:27');
/*!40000 ALTER TABLE `ntwk_offering_service_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ntwk_service_map`
--

DROP TABLE IF EXISTS `ntwk_service_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ntwk_service_map` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `network_id` bigint(20) unsigned NOT NULL COMMENT 'network_id',
  `service` varchar(255) NOT NULL COMMENT 'service',
  `provider` varchar(255) DEFAULT NULL COMMENT 'service provider',
  `created` datetime DEFAULT NULL COMMENT 'date created',
  PRIMARY KEY (`id`),
  UNIQUE KEY `network_id` (`network_id`,`service`,`provider`),
  CONSTRAINT `fk_ntwk_service_map__network_id` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ntwk_service_map`
--

LOCK TABLES `ntwk_service_map` WRITE;
/*!40000 ALTER TABLE `ntwk_service_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `ntwk_service_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `object_datastore_ref`
--

DROP TABLE IF EXISTS `object_datastore_ref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `object_datastore_ref` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `datastore_uuid` varchar(255) NOT NULL,
  `datastore_role` varchar(255) NOT NULL,
  `object_uuid` varchar(255) NOT NULL,
  `object_type` varchar(255) NOT NULL,
  `created` datetime NOT NULL,
  `last_updated` datetime DEFAULT NULL,
  `job_id` varchar(255) DEFAULT NULL,
  `download_pct` int(10) unsigned DEFAULT NULL,
  `download_state` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `checksum` varchar(255) DEFAULT NULL,
  `error_str` varchar(255) DEFAULT NULL,
  `local_path` varchar(255) DEFAULT NULL,
  `install_path` varchar(255) DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL COMMENT 'the size of the template on the pool',
  `state` varchar(255) NOT NULL,
  `update_count` bigint(20) unsigned NOT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `object_datastore_ref`
--

LOCK TABLES `object_datastore_ref` WRITE;
/*!40000 ALTER TABLE `object_datastore_ref` DISABLE KEYS */;
/*!40000 ALTER TABLE `object_datastore_ref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `op_dc_ip_address_alloc`
--

DROP TABLE IF EXISTS `op_dc_ip_address_alloc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `op_dc_ip_address_alloc` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `ip_address` char(40) NOT NULL COMMENT 'ip address',
  `data_center_id` bigint(20) unsigned NOT NULL COMMENT 'data center it belongs to',
  `pod_id` bigint(20) unsigned NOT NULL COMMENT 'pod it belongs to',
  `nic_id` bigint(20) unsigned DEFAULT NULL COMMENT 'nic id',
  `reservation_id` char(40) DEFAULT NULL COMMENT 'reservation id',
  `taken` datetime DEFAULT NULL COMMENT 'Date taken',
  `mac_address` bigint(20) unsigned NOT NULL COMMENT 'mac address for management ips',
  PRIMARY KEY (`id`),
  UNIQUE KEY `i_op_dc_ip_address_alloc__ip_address__data_center_id` (`ip_address`,`data_center_id`),
  KEY `fk_op_dc_ip_address_alloc__data_center_id` (`data_center_id`),
  KEY `i_op_dc_ip_address_alloc__pod_id__data_center_id__taken` (`pod_id`,`data_center_id`,`taken`,`nic_id`),
  KEY `i_op_dc_ip_address_alloc__pod_id` (`pod_id`),
  CONSTRAINT `fk_op_dc_ip_address_alloc__data_center_id` FOREIGN KEY (`data_center_id`) REFERENCES `data_center` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_op_dc_ip_address_alloc__pod_id` FOREIGN KEY (`pod_id`) REFERENCES `host_pod_ref` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=200 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `op_dc_ip_address_alloc`
--

LOCK TABLES `op_dc_ip_address_alloc` WRITE;
/*!40000 ALTER TABLE `op_dc_ip_address_alloc` DISABLE KEYS */;
INSERT INTO `op_dc_ip_address_alloc` VALUES (1,'172.16.15.2',1,1,NULL,NULL,NULL,1),(2,'172.16.15.3',1,1,NULL,NULL,NULL,2),(3,'172.16.15.4',1,1,NULL,NULL,NULL,3),(4,'172.16.15.5',1,1,NULL,NULL,NULL,4),(5,'172.16.15.6',1,1,NULL,NULL,NULL,5),(6,'172.16.15.7',1,1,NULL,NULL,NULL,6),(7,'172.16.15.8',1,1,NULL,NULL,NULL,7),(8,'172.16.15.9',1,1,NULL,NULL,NULL,8),(9,'172.16.15.10',1,1,NULL,NULL,NULL,9),(10,'172.16.15.11',1,1,NULL,NULL,NULL,10),(11,'172.16.15.12',1,1,NULL,NULL,NULL,11),(12,'172.16.15.13',1,1,NULL,NULL,NULL,12),(13,'172.16.15.14',1,1,NULL,NULL,NULL,13),(14,'172.16.15.15',1,1,NULL,NULL,NULL,14),(15,'172.16.15.16',1,1,NULL,NULL,'2014-06-26 02:25:26',15),(16,'172.16.15.17',1,1,NULL,NULL,NULL,16),(17,'172.16.15.18',1,1,NULL,NULL,'2014-06-26 02:26:26',17),(18,'172.16.15.19',1,1,NULL,NULL,NULL,18),(19,'172.16.15.20',1,1,NULL,NULL,'2014-06-26 02:25:25',19),(20,'172.16.15.21',1,1,NULL,NULL,NULL,20),(21,'172.16.15.22',1,1,NULL,NULL,NULL,21),(22,'172.16.15.23',1,1,NULL,NULL,NULL,22),(23,'172.16.15.24',1,1,NULL,NULL,NULL,23),(24,'172.16.15.25',1,1,NULL,NULL,NULL,24),(25,'172.16.15.26',1,1,NULL,NULL,NULL,25),(26,'172.16.15.27',1,1,NULL,NULL,NULL,26),(27,'172.16.15.28',1,1,NULL,NULL,NULL,27),(28,'172.16.15.29',1,1,NULL,NULL,NULL,28),(29,'172.16.15.30',1,1,NULL,NULL,NULL,29),(30,'172.16.15.31',1,1,NULL,NULL,NULL,30),(31,'172.16.15.32',1,1,NULL,NULL,NULL,31),(32,'172.16.15.33',1,1,NULL,NULL,NULL,32),(33,'172.16.15.34',1,1,NULL,NULL,NULL,33),(34,'172.16.15.35',1,1,NULL,NULL,NULL,34),(35,'172.16.15.36',1,1,6,'757c5413-7e8f-4a79-9e93-04be9c524687','2014-06-26 02:27:59',35),(36,'172.16.15.37',1,1,NULL,NULL,NULL,36),(37,'172.16.15.38',1,1,NULL,NULL,NULL,37),(38,'172.16.15.39',1,1,NULL,NULL,NULL,38),(39,'172.16.15.40',1,1,NULL,NULL,NULL,39),(40,'172.16.15.41',1,1,NULL,NULL,NULL,40),(41,'172.16.15.42',1,1,NULL,NULL,NULL,41),(42,'172.16.15.43',1,1,NULL,NULL,NULL,42),(43,'172.16.15.44',1,1,NULL,NULL,NULL,43),(44,'172.16.15.45',1,1,NULL,NULL,NULL,44),(45,'172.16.15.46',1,1,NULL,NULL,NULL,45),(46,'172.16.15.47',1,1,NULL,NULL,NULL,46),(47,'172.16.15.48',1,1,NULL,NULL,NULL,47),(48,'172.16.15.49',1,1,NULL,NULL,NULL,48),(49,'172.16.15.50',1,1,7,'757c5413-7e8f-4a79-9e93-04be9c524687','2014-06-26 02:28:00',49),(50,'172.16.15.51',1,1,NULL,NULL,NULL,50),(51,'172.16.15.52',1,1,NULL,NULL,NULL,51),(52,'172.16.15.53',1,1,NULL,NULL,NULL,52),(53,'172.16.15.54',1,1,NULL,NULL,NULL,53),(54,'172.16.15.55',1,1,NULL,NULL,NULL,54),(55,'172.16.15.56',1,1,NULL,NULL,NULL,55),(56,'172.16.15.57',1,1,NULL,NULL,NULL,56),(57,'172.16.15.58',1,1,NULL,NULL,NULL,57),(58,'172.16.15.59',1,1,NULL,NULL,NULL,58),(59,'172.16.15.60',1,1,NULL,NULL,NULL,59),(60,'172.16.15.61',1,1,NULL,NULL,NULL,60),(61,'172.16.15.62',1,1,NULL,NULL,NULL,61),(62,'172.16.15.63',1,1,NULL,NULL,NULL,62),(63,'172.16.15.64',1,1,NULL,NULL,NULL,63),(64,'172.16.15.65',1,1,NULL,NULL,NULL,64),(65,'172.16.15.66',1,1,NULL,NULL,NULL,65),(66,'172.16.15.67',1,1,NULL,NULL,NULL,66),(67,'172.16.15.68',1,1,NULL,NULL,NULL,67),(68,'172.16.15.69',1,1,NULL,NULL,NULL,68),(69,'172.16.15.70',1,1,NULL,NULL,NULL,69),(70,'172.16.15.71',1,1,NULL,NULL,NULL,70),(71,'172.16.15.72',1,1,NULL,NULL,NULL,71),(72,'172.16.15.73',1,1,NULL,NULL,NULL,72),(73,'172.16.15.74',1,1,NULL,NULL,NULL,73),(74,'172.16.15.75',1,1,NULL,NULL,NULL,74),(75,'172.16.15.76',1,1,NULL,NULL,NULL,75),(76,'172.16.15.77',1,1,NULL,NULL,NULL,76),(77,'172.16.15.78',1,1,NULL,NULL,NULL,77),(78,'172.16.15.79',1,1,NULL,NULL,NULL,78),(79,'172.16.15.80',1,1,NULL,NULL,NULL,79),(80,'172.16.15.81',1,1,NULL,NULL,NULL,80),(81,'172.16.15.82',1,1,NULL,NULL,NULL,81),(82,'172.16.15.83',1,1,NULL,NULL,NULL,82),(83,'172.16.15.84',1,1,NULL,NULL,NULL,83),(84,'172.16.15.85',1,1,NULL,NULL,NULL,84),(85,'172.16.15.86',1,1,NULL,NULL,NULL,85),(86,'172.16.15.87',1,1,NULL,NULL,NULL,86),(87,'172.16.15.88',1,1,NULL,NULL,NULL,87),(88,'172.16.15.89',1,1,NULL,NULL,NULL,88),(89,'172.16.15.90',1,1,NULL,NULL,NULL,89),(90,'172.16.15.91',1,1,NULL,NULL,NULL,90),(91,'172.16.15.92',1,1,NULL,NULL,NULL,91),(92,'172.16.15.93',1,1,NULL,NULL,NULL,92),(93,'172.16.15.94',1,1,NULL,NULL,NULL,93),(94,'172.16.15.95',1,1,NULL,NULL,NULL,94),(95,'172.16.15.96',1,1,NULL,NULL,NULL,95),(96,'172.16.15.97',1,1,NULL,NULL,NULL,96),(97,'172.16.15.98',1,1,3,'84d9c349-c24b-4df6-a59a-e5e0fa33c96b','2014-06-26 02:27:59',97),(98,'172.16.15.99',1,1,NULL,NULL,NULL,98),(99,'172.16.15.100',1,1,NULL,NULL,NULL,99),(100,'172.16.15.101',1,1,NULL,NULL,NULL,100),(101,'172.16.15.102',1,1,NULL,NULL,NULL,101),(102,'172.16.15.103',1,1,NULL,NULL,NULL,102),(103,'172.16.15.104',1,1,NULL,NULL,NULL,103),(104,'172.16.15.105',1,1,NULL,NULL,NULL,104),(105,'172.16.15.106',1,1,NULL,NULL,NULL,105),(106,'172.16.15.107',1,1,NULL,NULL,NULL,106),(107,'172.16.15.108',1,1,NULL,NULL,NULL,107),(108,'172.16.15.109',1,1,NULL,NULL,NULL,108),(109,'172.16.15.110',1,1,NULL,NULL,NULL,109),(110,'172.16.15.111',1,1,NULL,NULL,NULL,110),(111,'172.16.15.112',1,1,NULL,NULL,NULL,111),(112,'172.16.15.113',1,1,NULL,NULL,NULL,112),(113,'172.16.15.114',1,1,NULL,NULL,NULL,113),(114,'172.16.15.115',1,1,NULL,NULL,NULL,114),(115,'172.16.15.116',1,1,NULL,NULL,NULL,115),(116,'172.16.15.117',1,1,NULL,NULL,NULL,116),(117,'172.16.15.118',1,1,NULL,NULL,NULL,117),(118,'172.16.15.119',1,1,NULL,NULL,NULL,118),(119,'172.16.15.120',1,1,NULL,NULL,NULL,119),(120,'172.16.15.121',1,1,NULL,NULL,NULL,120),(121,'172.16.15.122',1,1,NULL,NULL,NULL,121),(122,'172.16.15.123',1,1,NULL,NULL,NULL,122),(123,'172.16.15.124',1,1,NULL,NULL,NULL,123),(124,'172.16.15.125',1,1,NULL,NULL,NULL,124),(125,'172.16.15.126',1,1,NULL,NULL,NULL,125),(126,'172.16.15.127',1,1,NULL,NULL,NULL,126),(127,'172.16.15.128',1,1,NULL,NULL,NULL,127),(128,'172.16.15.129',1,1,NULL,NULL,NULL,128),(129,'172.16.15.130',1,1,NULL,NULL,NULL,129),(130,'172.16.15.131',1,1,NULL,NULL,NULL,130),(131,'172.16.15.132',1,1,NULL,NULL,NULL,131),(132,'172.16.15.133',1,1,NULL,NULL,NULL,132),(133,'172.16.15.134',1,1,NULL,NULL,NULL,133),(134,'172.16.15.135',1,1,NULL,NULL,NULL,134),(135,'172.16.15.136',1,1,NULL,NULL,NULL,135),(136,'172.16.15.137',1,1,NULL,NULL,NULL,136),(137,'172.16.15.138',1,1,NULL,NULL,NULL,137),(138,'172.16.15.139',1,1,NULL,NULL,NULL,138),(139,'172.16.15.140',1,1,NULL,NULL,NULL,139),(140,'172.16.15.141',1,1,NULL,NULL,NULL,140),(141,'172.16.15.142',1,1,NULL,NULL,NULL,141),(142,'172.16.15.143',1,1,NULL,NULL,NULL,142),(143,'172.16.15.144',1,1,NULL,NULL,NULL,143),(144,'172.16.15.145',1,1,NULL,NULL,NULL,144),(145,'172.16.15.146',1,1,NULL,NULL,NULL,145),(146,'172.16.15.147',1,1,NULL,NULL,NULL,146),(147,'172.16.15.148',1,1,NULL,NULL,NULL,147),(148,'172.16.15.149',1,1,NULL,NULL,NULL,148),(149,'172.16.15.150',1,1,NULL,NULL,NULL,149),(150,'172.16.15.151',1,1,NULL,NULL,NULL,150),(151,'172.16.15.152',1,1,NULL,NULL,NULL,151),(152,'172.16.15.153',1,1,NULL,NULL,NULL,152),(153,'172.16.15.154',1,1,NULL,NULL,NULL,153),(154,'172.16.15.155',1,1,NULL,NULL,NULL,154),(155,'172.16.15.156',1,1,NULL,NULL,NULL,155),(156,'172.16.15.157',1,1,NULL,NULL,NULL,156),(157,'172.16.15.158',1,1,NULL,NULL,NULL,157),(158,'172.16.15.159',1,1,NULL,NULL,NULL,158),(159,'172.16.15.160',1,1,NULL,NULL,NULL,159),(160,'172.16.15.161',1,1,NULL,NULL,NULL,160),(161,'172.16.15.162',1,1,NULL,NULL,NULL,161),(162,'172.16.15.163',1,1,NULL,NULL,NULL,162),(163,'172.16.15.164',1,1,NULL,NULL,NULL,163),(164,'172.16.15.165',1,1,NULL,NULL,NULL,164),(165,'172.16.15.166',1,1,NULL,NULL,NULL,165),(166,'172.16.15.167',1,1,NULL,NULL,NULL,166),(167,'172.16.15.168',1,1,NULL,NULL,NULL,167),(168,'172.16.15.169',1,1,NULL,NULL,NULL,168),(169,'172.16.15.170',1,1,NULL,NULL,NULL,169),(170,'172.16.15.171',1,1,NULL,NULL,NULL,170),(171,'172.16.15.172',1,1,NULL,NULL,NULL,171),(172,'172.16.15.173',1,1,NULL,NULL,NULL,172),(173,'172.16.15.174',1,1,NULL,NULL,NULL,173),(174,'172.16.15.175',1,1,NULL,NULL,NULL,174),(175,'172.16.15.176',1,1,NULL,NULL,NULL,175),(176,'172.16.15.177',1,1,NULL,NULL,NULL,176),(177,'172.16.15.178',1,1,NULL,NULL,NULL,177),(178,'172.16.15.179',1,1,NULL,NULL,NULL,178),(179,'172.16.15.180',1,1,NULL,NULL,NULL,179),(180,'172.16.15.181',1,1,NULL,NULL,NULL,180),(181,'172.16.15.182',1,1,NULL,NULL,NULL,181),(182,'172.16.15.183',1,1,NULL,NULL,NULL,182),(183,'172.16.15.184',1,1,NULL,NULL,NULL,183),(184,'172.16.15.185',1,1,NULL,NULL,NULL,184),(185,'172.16.15.186',1,1,NULL,NULL,NULL,185),(186,'172.16.15.187',1,1,NULL,NULL,NULL,186),(187,'172.16.15.188',1,1,NULL,NULL,NULL,187),(188,'172.16.15.189',1,1,NULL,NULL,NULL,188),(189,'172.16.15.190',1,1,NULL,NULL,NULL,189),(190,'172.16.15.191',1,1,NULL,NULL,NULL,190),(191,'172.16.15.192',1,1,NULL,NULL,NULL,191),(192,'172.16.15.193',1,1,NULL,NULL,NULL,192),(193,'172.16.15.194',1,1,NULL,NULL,NULL,193),(194,'172.16.15.195',1,1,NULL,NULL,NULL,194),(195,'172.16.15.196',1,1,NULL,NULL,NULL,195),(196,'172.16.15.197',1,1,NULL,NULL,NULL,196),(197,'172.16.15.198',1,1,NULL,NULL,NULL,197),(198,'172.16.15.199',1,1,NULL,NULL,NULL,198),(199,'172.16.15.200',1,1,NULL,NULL,NULL,199);
/*!40000 ALTER TABLE `op_dc_ip_address_alloc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `op_dc_link_local_ip_address_alloc`
--

DROP TABLE IF EXISTS `op_dc_link_local_ip_address_alloc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `op_dc_link_local_ip_address_alloc` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `ip_address` char(40) NOT NULL COMMENT 'ip address',
  `data_center_id` bigint(20) unsigned NOT NULL COMMENT 'data center it belongs to',
  `pod_id` bigint(20) unsigned NOT NULL COMMENT 'pod it belongs to',
  `nic_id` bigint(20) unsigned DEFAULT NULL COMMENT 'instance id',
  `reservation_id` char(40) DEFAULT NULL COMMENT 'reservation id used to reserve this network',
  `taken` datetime DEFAULT NULL COMMENT 'Date taken',
  PRIMARY KEY (`id`),
  KEY `i_op_dc_link_local_ip_address_alloc__pod_id` (`pod_id`),
  KEY `i_op_dc_link_local_ip_address_alloc__data_center_id` (`data_center_id`),
  KEY `i_op_dc_link_local_ip_address_alloc__nic_id_reservation_id` (`nic_id`,`reservation_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1022 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `op_dc_link_local_ip_address_alloc`
--

LOCK TABLES `op_dc_link_local_ip_address_alloc` WRITE;
/*!40000 ALTER TABLE `op_dc_link_local_ip_address_alloc` DISABLE KEYS */;
INSERT INTO `op_dc_link_local_ip_address_alloc` VALUES (1,'169.254.0.2',1,1,NULL,NULL,NULL),(2,'169.254.0.3',1,1,NULL,NULL,NULL),(3,'169.254.0.4',1,1,NULL,NULL,NULL),(4,'169.254.0.5',1,1,NULL,NULL,NULL),(5,'169.254.0.6',1,1,NULL,NULL,NULL),(6,'169.254.0.7',1,1,NULL,NULL,NULL),(7,'169.254.0.8',1,1,NULL,NULL,NULL),(8,'169.254.0.9',1,1,NULL,NULL,NULL),(9,'169.254.0.10',1,1,NULL,NULL,NULL),(10,'169.254.0.11',1,1,NULL,NULL,NULL),(11,'169.254.0.12',1,1,NULL,NULL,NULL),(12,'169.254.0.13',1,1,NULL,NULL,NULL),(13,'169.254.0.14',1,1,NULL,NULL,NULL),(14,'169.254.0.15',1,1,NULL,NULL,NULL),(15,'169.254.0.16',1,1,NULL,NULL,NULL),(16,'169.254.0.17',1,1,NULL,NULL,NULL),(17,'169.254.0.18',1,1,NULL,NULL,NULL),(18,'169.254.0.19',1,1,NULL,NULL,NULL),(19,'169.254.0.20',1,1,NULL,NULL,NULL),(20,'169.254.0.21',1,1,NULL,NULL,NULL),(21,'169.254.0.22',1,1,NULL,NULL,NULL),(22,'169.254.0.23',1,1,NULL,NULL,NULL),(23,'169.254.0.24',1,1,NULL,NULL,NULL),(24,'169.254.0.25',1,1,NULL,NULL,NULL),(25,'169.254.0.26',1,1,NULL,NULL,NULL),(26,'169.254.0.27',1,1,NULL,NULL,NULL),(27,'169.254.0.28',1,1,NULL,NULL,NULL),(28,'169.254.0.29',1,1,NULL,NULL,NULL),(29,'169.254.0.30',1,1,NULL,NULL,NULL),(30,'169.254.0.31',1,1,NULL,NULL,NULL),(31,'169.254.0.32',1,1,NULL,NULL,NULL),(32,'169.254.0.33',1,1,NULL,NULL,NULL),(33,'169.254.0.34',1,1,NULL,NULL,NULL),(34,'169.254.0.35',1,1,NULL,NULL,NULL),(35,'169.254.0.36',1,1,NULL,NULL,NULL),(36,'169.254.0.37',1,1,NULL,NULL,NULL),(37,'169.254.0.38',1,1,NULL,NULL,NULL),(38,'169.254.0.39',1,1,NULL,NULL,NULL),(39,'169.254.0.40',1,1,NULL,NULL,NULL),(40,'169.254.0.41',1,1,NULL,NULL,NULL),(41,'169.254.0.42',1,1,NULL,NULL,NULL),(42,'169.254.0.43',1,1,NULL,NULL,NULL),(43,'169.254.0.44',1,1,NULL,NULL,NULL),(44,'169.254.0.45',1,1,NULL,NULL,NULL),(45,'169.254.0.46',1,1,NULL,NULL,NULL),(46,'169.254.0.47',1,1,NULL,NULL,NULL),(47,'169.254.0.48',1,1,NULL,NULL,NULL),(48,'169.254.0.49',1,1,NULL,NULL,NULL),(49,'169.254.0.50',1,1,NULL,NULL,NULL),(50,'169.254.0.51',1,1,NULL,NULL,NULL),(51,'169.254.0.52',1,1,NULL,NULL,NULL),(52,'169.254.0.53',1,1,NULL,NULL,NULL),(53,'169.254.0.54',1,1,NULL,NULL,NULL),(54,'169.254.0.55',1,1,NULL,NULL,NULL),(55,'169.254.0.56',1,1,NULL,NULL,NULL),(56,'169.254.0.57',1,1,NULL,NULL,NULL),(57,'169.254.0.58',1,1,NULL,NULL,NULL),(58,'169.254.0.59',1,1,NULL,NULL,NULL),(59,'169.254.0.60',1,1,NULL,NULL,NULL),(60,'169.254.0.61',1,1,NULL,NULL,NULL),(61,'169.254.0.62',1,1,NULL,NULL,NULL),(62,'169.254.0.63',1,1,NULL,NULL,NULL),(63,'169.254.0.64',1,1,NULL,NULL,NULL),(64,'169.254.0.65',1,1,NULL,NULL,NULL),(65,'169.254.0.66',1,1,NULL,NULL,NULL),(66,'169.254.0.67',1,1,NULL,NULL,NULL),(67,'169.254.0.68',1,1,NULL,NULL,NULL),(68,'169.254.0.69',1,1,NULL,NULL,NULL),(69,'169.254.0.70',1,1,NULL,NULL,NULL),(70,'169.254.0.71',1,1,NULL,NULL,NULL),(71,'169.254.0.72',1,1,NULL,NULL,NULL),(72,'169.254.0.73',1,1,NULL,NULL,NULL),(73,'169.254.0.74',1,1,NULL,NULL,NULL),(74,'169.254.0.75',1,1,NULL,NULL,NULL),(75,'169.254.0.76',1,1,NULL,NULL,NULL),(76,'169.254.0.77',1,1,NULL,NULL,NULL),(77,'169.254.0.78',1,1,NULL,NULL,NULL),(78,'169.254.0.79',1,1,NULL,NULL,NULL),(79,'169.254.0.80',1,1,NULL,NULL,NULL),(80,'169.254.0.81',1,1,NULL,NULL,NULL),(81,'169.254.0.82',1,1,NULL,NULL,NULL),(82,'169.254.0.83',1,1,NULL,NULL,NULL),(83,'169.254.0.84',1,1,NULL,NULL,NULL),(84,'169.254.0.85',1,1,NULL,NULL,NULL),(85,'169.254.0.86',1,1,NULL,NULL,NULL),(86,'169.254.0.87',1,1,NULL,NULL,NULL),(87,'169.254.0.88',1,1,NULL,NULL,NULL),(88,'169.254.0.89',1,1,NULL,NULL,NULL),(89,'169.254.0.90',1,1,NULL,NULL,NULL),(90,'169.254.0.91',1,1,NULL,NULL,NULL),(91,'169.254.0.92',1,1,NULL,NULL,NULL),(92,'169.254.0.93',1,1,NULL,NULL,NULL),(93,'169.254.0.94',1,1,NULL,NULL,NULL),(94,'169.254.0.95',1,1,NULL,NULL,NULL),(95,'169.254.0.96',1,1,NULL,NULL,NULL),(96,'169.254.0.97',1,1,NULL,NULL,NULL),(97,'169.254.0.98',1,1,NULL,NULL,NULL),(98,'169.254.0.99',1,1,NULL,NULL,NULL),(99,'169.254.0.100',1,1,NULL,NULL,NULL),(100,'169.254.0.101',1,1,NULL,NULL,NULL),(101,'169.254.0.102',1,1,NULL,NULL,NULL),(102,'169.254.0.103',1,1,NULL,NULL,NULL),(103,'169.254.0.104',1,1,NULL,NULL,NULL),(104,'169.254.0.105',1,1,NULL,NULL,NULL),(105,'169.254.0.106',1,1,NULL,NULL,NULL),(106,'169.254.0.107',1,1,NULL,NULL,NULL),(107,'169.254.0.108',1,1,NULL,NULL,NULL),(108,'169.254.0.109',1,1,NULL,NULL,NULL),(109,'169.254.0.110',1,1,NULL,NULL,NULL),(110,'169.254.0.111',1,1,NULL,NULL,NULL),(111,'169.254.0.112',1,1,NULL,NULL,NULL),(112,'169.254.0.113',1,1,NULL,NULL,NULL),(113,'169.254.0.114',1,1,NULL,NULL,NULL),(114,'169.254.0.115',1,1,NULL,NULL,NULL),(115,'169.254.0.116',1,1,NULL,NULL,NULL),(116,'169.254.0.117',1,1,NULL,NULL,NULL),(117,'169.254.0.118',1,1,NULL,NULL,NULL),(118,'169.254.0.119',1,1,NULL,NULL,NULL),(119,'169.254.0.120',1,1,NULL,NULL,NULL),(120,'169.254.0.121',1,1,NULL,NULL,NULL),(121,'169.254.0.122',1,1,NULL,NULL,NULL),(122,'169.254.0.123',1,1,NULL,NULL,NULL),(123,'169.254.0.124',1,1,NULL,NULL,NULL),(124,'169.254.0.125',1,1,NULL,NULL,NULL),(125,'169.254.0.126',1,1,NULL,NULL,NULL),(126,'169.254.0.127',1,1,NULL,NULL,NULL),(127,'169.254.0.128',1,1,NULL,NULL,NULL),(128,'169.254.0.129',1,1,NULL,NULL,NULL),(129,'169.254.0.130',1,1,NULL,NULL,NULL),(130,'169.254.0.131',1,1,NULL,NULL,NULL),(131,'169.254.0.132',1,1,NULL,NULL,NULL),(132,'169.254.0.133',1,1,NULL,NULL,NULL),(133,'169.254.0.134',1,1,NULL,NULL,NULL),(134,'169.254.0.135',1,1,NULL,NULL,NULL),(135,'169.254.0.136',1,1,NULL,NULL,NULL),(136,'169.254.0.137',1,1,NULL,NULL,NULL),(137,'169.254.0.138',1,1,NULL,NULL,NULL),(138,'169.254.0.139',1,1,NULL,NULL,NULL),(139,'169.254.0.140',1,1,NULL,NULL,NULL),(140,'169.254.0.141',1,1,NULL,NULL,NULL),(141,'169.254.0.142',1,1,NULL,NULL,NULL),(142,'169.254.0.143',1,1,NULL,NULL,NULL),(143,'169.254.0.144',1,1,NULL,NULL,NULL),(144,'169.254.0.145',1,1,NULL,NULL,NULL),(145,'169.254.0.146',1,1,NULL,NULL,NULL),(146,'169.254.0.147',1,1,NULL,NULL,NULL),(147,'169.254.0.148',1,1,NULL,NULL,NULL),(148,'169.254.0.149',1,1,NULL,NULL,NULL),(149,'169.254.0.150',1,1,NULL,NULL,NULL),(150,'169.254.0.151',1,1,NULL,NULL,NULL),(151,'169.254.0.152',1,1,NULL,NULL,NULL),(152,'169.254.0.153',1,1,NULL,NULL,NULL),(153,'169.254.0.154',1,1,NULL,NULL,NULL),(154,'169.254.0.155',1,1,NULL,NULL,NULL),(155,'169.254.0.156',1,1,NULL,NULL,NULL),(156,'169.254.0.157',1,1,NULL,NULL,NULL),(157,'169.254.0.158',1,1,5,'757c5413-7e8f-4a79-9e93-04be9c524687','2014-06-26 02:27:59'),(158,'169.254.0.159',1,1,NULL,NULL,NULL),(159,'169.254.0.160',1,1,NULL,NULL,NULL),(160,'169.254.0.161',1,1,NULL,NULL,NULL),(161,'169.254.0.162',1,1,NULL,NULL,NULL),(162,'169.254.0.163',1,1,NULL,NULL,NULL),(163,'169.254.0.164',1,1,NULL,NULL,NULL),(164,'169.254.0.165',1,1,NULL,NULL,NULL),(165,'169.254.0.166',1,1,NULL,NULL,NULL),(166,'169.254.0.167',1,1,NULL,NULL,NULL),(167,'169.254.0.168',1,1,NULL,NULL,NULL),(168,'169.254.0.169',1,1,NULL,NULL,NULL),(169,'169.254.0.170',1,1,NULL,NULL,NULL),(170,'169.254.0.171',1,1,NULL,NULL,NULL),(171,'169.254.0.172',1,1,NULL,NULL,NULL),(172,'169.254.0.173',1,1,NULL,NULL,NULL),(173,'169.254.0.174',1,1,NULL,NULL,NULL),(174,'169.254.0.175',1,1,NULL,NULL,NULL),(175,'169.254.0.176',1,1,NULL,NULL,NULL),(176,'169.254.0.177',1,1,NULL,NULL,NULL),(177,'169.254.0.178',1,1,NULL,NULL,NULL),(178,'169.254.0.179',1,1,NULL,NULL,NULL),(179,'169.254.0.180',1,1,NULL,NULL,NULL),(180,'169.254.0.181',1,1,NULL,NULL,NULL),(181,'169.254.0.182',1,1,NULL,NULL,NULL),(182,'169.254.0.183',1,1,NULL,NULL,NULL),(183,'169.254.0.184',1,1,NULL,NULL,NULL),(184,'169.254.0.185',1,1,NULL,NULL,NULL),(185,'169.254.0.186',1,1,NULL,NULL,NULL),(186,'169.254.0.187',1,1,NULL,NULL,NULL),(187,'169.254.0.188',1,1,NULL,NULL,NULL),(188,'169.254.0.189',1,1,NULL,NULL,NULL),(189,'169.254.0.190',1,1,NULL,NULL,NULL),(190,'169.254.0.191',1,1,NULL,NULL,NULL),(191,'169.254.0.192',1,1,NULL,NULL,NULL),(192,'169.254.0.193',1,1,NULL,NULL,NULL),(193,'169.254.0.194',1,1,NULL,NULL,NULL),(194,'169.254.0.195',1,1,NULL,NULL,NULL),(195,'169.254.0.196',1,1,NULL,NULL,NULL),(196,'169.254.0.197',1,1,NULL,NULL,NULL),(197,'169.254.0.198',1,1,NULL,NULL,NULL),(198,'169.254.0.199',1,1,NULL,NULL,NULL),(199,'169.254.0.200',1,1,NULL,NULL,NULL),(200,'169.254.0.201',1,1,NULL,NULL,NULL),(201,'169.254.0.202',1,1,NULL,NULL,NULL),(202,'169.254.0.203',1,1,NULL,NULL,NULL),(203,'169.254.0.204',1,1,NULL,NULL,NULL),(204,'169.254.0.205',1,1,NULL,NULL,NULL),(205,'169.254.0.206',1,1,NULL,NULL,NULL),(206,'169.254.0.207',1,1,NULL,NULL,NULL),(207,'169.254.0.208',1,1,NULL,NULL,NULL),(208,'169.254.0.209',1,1,NULL,NULL,NULL),(209,'169.254.0.210',1,1,NULL,NULL,NULL),(210,'169.254.0.211',1,1,NULL,NULL,NULL),(211,'169.254.0.212',1,1,NULL,NULL,NULL),(212,'169.254.0.213',1,1,NULL,NULL,NULL),(213,'169.254.0.214',1,1,NULL,NULL,NULL),(214,'169.254.0.215',1,1,NULL,NULL,NULL),(215,'169.254.0.216',1,1,NULL,NULL,NULL),(216,'169.254.0.217',1,1,NULL,NULL,NULL),(217,'169.254.0.218',1,1,NULL,NULL,NULL),(218,'169.254.0.219',1,1,NULL,NULL,NULL),(219,'169.254.0.220',1,1,NULL,NULL,NULL),(220,'169.254.0.221',1,1,NULL,NULL,NULL),(221,'169.254.0.222',1,1,NULL,NULL,NULL),(222,'169.254.0.223',1,1,NULL,NULL,NULL),(223,'169.254.0.224',1,1,NULL,NULL,NULL),(224,'169.254.0.225',1,1,NULL,NULL,NULL),(225,'169.254.0.226',1,1,NULL,NULL,NULL),(226,'169.254.0.227',1,1,NULL,NULL,NULL),(227,'169.254.0.228',1,1,NULL,NULL,NULL),(228,'169.254.0.229',1,1,NULL,NULL,NULL),(229,'169.254.0.230',1,1,NULL,NULL,NULL),(230,'169.254.0.231',1,1,NULL,NULL,NULL),(231,'169.254.0.232',1,1,NULL,NULL,NULL),(232,'169.254.0.233',1,1,NULL,NULL,NULL),(233,'169.254.0.234',1,1,NULL,NULL,NULL),(234,'169.254.0.235',1,1,NULL,NULL,NULL),(235,'169.254.0.236',1,1,NULL,NULL,NULL),(236,'169.254.0.237',1,1,NULL,NULL,NULL),(237,'169.254.0.238',1,1,NULL,NULL,NULL),(238,'169.254.0.239',1,1,NULL,NULL,NULL),(239,'169.254.0.240',1,1,NULL,NULL,NULL),(240,'169.254.0.241',1,1,NULL,NULL,NULL),(241,'169.254.0.242',1,1,NULL,NULL,NULL),(242,'169.254.0.243',1,1,NULL,NULL,NULL),(243,'169.254.0.244',1,1,NULL,NULL,NULL),(244,'169.254.0.245',1,1,NULL,NULL,NULL),(245,'169.254.0.246',1,1,NULL,NULL,NULL),(246,'169.254.0.247',1,1,NULL,NULL,NULL),(247,'169.254.0.248',1,1,NULL,NULL,NULL),(248,'169.254.0.249',1,1,NULL,NULL,NULL),(249,'169.254.0.250',1,1,NULL,NULL,NULL),(250,'169.254.0.251',1,1,NULL,NULL,NULL),(251,'169.254.0.252',1,1,NULL,NULL,NULL),(252,'169.254.0.253',1,1,NULL,NULL,NULL),(253,'169.254.0.254',1,1,NULL,NULL,NULL),(254,'169.254.0.255',1,1,NULL,NULL,NULL),(255,'169.254.1.0',1,1,NULL,NULL,NULL),(256,'169.254.1.1',1,1,NULL,NULL,NULL),(257,'169.254.1.2',1,1,NULL,NULL,NULL),(258,'169.254.1.3',1,1,NULL,NULL,NULL),(259,'169.254.1.4',1,1,NULL,NULL,NULL),(260,'169.254.1.5',1,1,NULL,NULL,NULL),(261,'169.254.1.6',1,1,NULL,NULL,NULL),(262,'169.254.1.7',1,1,NULL,NULL,NULL),(263,'169.254.1.8',1,1,NULL,NULL,NULL),(264,'169.254.1.9',1,1,NULL,NULL,NULL),(265,'169.254.1.10',1,1,NULL,NULL,NULL),(266,'169.254.1.11',1,1,NULL,NULL,NULL),(267,'169.254.1.12',1,1,NULL,NULL,NULL),(268,'169.254.1.13',1,1,NULL,NULL,NULL),(269,'169.254.1.14',1,1,NULL,NULL,NULL),(270,'169.254.1.15',1,1,NULL,NULL,NULL),(271,'169.254.1.16',1,1,NULL,NULL,NULL),(272,'169.254.1.17',1,1,NULL,NULL,NULL),(273,'169.254.1.18',1,1,NULL,NULL,NULL),(274,'169.254.1.19',1,1,NULL,NULL,NULL),(275,'169.254.1.20',1,1,NULL,NULL,NULL),(276,'169.254.1.21',1,1,NULL,NULL,NULL),(277,'169.254.1.22',1,1,NULL,NULL,NULL),(278,'169.254.1.23',1,1,NULL,NULL,NULL),(279,'169.254.1.24',1,1,NULL,NULL,NULL),(280,'169.254.1.25',1,1,NULL,NULL,NULL),(281,'169.254.1.26',1,1,NULL,NULL,NULL),(282,'169.254.1.27',1,1,NULL,NULL,NULL),(283,'169.254.1.28',1,1,NULL,NULL,NULL),(284,'169.254.1.29',1,1,NULL,NULL,NULL),(285,'169.254.1.30',1,1,NULL,NULL,NULL),(286,'169.254.1.31',1,1,NULL,NULL,NULL),(287,'169.254.1.32',1,1,NULL,NULL,NULL),(288,'169.254.1.33',1,1,NULL,NULL,NULL),(289,'169.254.1.34',1,1,NULL,NULL,NULL),(290,'169.254.1.35',1,1,NULL,NULL,NULL),(291,'169.254.1.36',1,1,NULL,NULL,NULL),(292,'169.254.1.37',1,1,NULL,NULL,NULL),(293,'169.254.1.38',1,1,NULL,NULL,NULL),(294,'169.254.1.39',1,1,NULL,NULL,NULL),(295,'169.254.1.40',1,1,NULL,NULL,NULL),(296,'169.254.1.41',1,1,NULL,NULL,NULL),(297,'169.254.1.42',1,1,NULL,NULL,NULL),(298,'169.254.1.43',1,1,NULL,NULL,NULL),(299,'169.254.1.44',1,1,NULL,NULL,NULL),(300,'169.254.1.45',1,1,NULL,NULL,NULL),(301,'169.254.1.46',1,1,NULL,NULL,NULL),(302,'169.254.1.47',1,1,NULL,NULL,NULL),(303,'169.254.1.48',1,1,NULL,NULL,NULL),(304,'169.254.1.49',1,1,NULL,NULL,NULL),(305,'169.254.1.50',1,1,NULL,NULL,NULL),(306,'169.254.1.51',1,1,NULL,NULL,NULL),(307,'169.254.1.52',1,1,NULL,NULL,NULL),(308,'169.254.1.53',1,1,NULL,NULL,NULL),(309,'169.254.1.54',1,1,NULL,NULL,NULL),(310,'169.254.1.55',1,1,NULL,NULL,NULL),(311,'169.254.1.56',1,1,NULL,NULL,NULL),(312,'169.254.1.57',1,1,NULL,NULL,NULL),(313,'169.254.1.58',1,1,NULL,NULL,NULL),(314,'169.254.1.59',1,1,NULL,NULL,NULL),(315,'169.254.1.60',1,1,NULL,NULL,NULL),(316,'169.254.1.61',1,1,NULL,NULL,NULL),(317,'169.254.1.62',1,1,NULL,NULL,NULL),(318,'169.254.1.63',1,1,NULL,NULL,NULL),(319,'169.254.1.64',1,1,NULL,NULL,NULL),(320,'169.254.1.65',1,1,NULL,NULL,NULL),(321,'169.254.1.66',1,1,NULL,NULL,NULL),(322,'169.254.1.67',1,1,NULL,NULL,NULL),(323,'169.254.1.68',1,1,NULL,NULL,NULL),(324,'169.254.1.69',1,1,NULL,NULL,NULL),(325,'169.254.1.70',1,1,NULL,NULL,NULL),(326,'169.254.1.71',1,1,NULL,NULL,NULL),(327,'169.254.1.72',1,1,NULL,NULL,NULL),(328,'169.254.1.73',1,1,NULL,NULL,NULL),(329,'169.254.1.74',1,1,NULL,NULL,NULL),(330,'169.254.1.75',1,1,NULL,NULL,NULL),(331,'169.254.1.76',1,1,NULL,NULL,NULL),(332,'169.254.1.77',1,1,NULL,NULL,NULL),(333,'169.254.1.78',1,1,NULL,NULL,NULL),(334,'169.254.1.79',1,1,NULL,NULL,NULL),(335,'169.254.1.80',1,1,NULL,NULL,NULL),(336,'169.254.1.81',1,1,NULL,NULL,NULL),(337,'169.254.1.82',1,1,NULL,NULL,NULL),(338,'169.254.1.83',1,1,NULL,NULL,NULL),(339,'169.254.1.84',1,1,NULL,NULL,NULL),(340,'169.254.1.85',1,1,NULL,NULL,NULL),(341,'169.254.1.86',1,1,NULL,NULL,NULL),(342,'169.254.1.87',1,1,NULL,NULL,NULL),(343,'169.254.1.88',1,1,NULL,NULL,NULL),(344,'169.254.1.89',1,1,NULL,NULL,NULL),(345,'169.254.1.90',1,1,NULL,NULL,NULL),(346,'169.254.1.91',1,1,NULL,NULL,NULL),(347,'169.254.1.92',1,1,NULL,NULL,NULL),(348,'169.254.1.93',1,1,NULL,NULL,NULL),(349,'169.254.1.94',1,1,NULL,NULL,NULL),(350,'169.254.1.95',1,1,NULL,NULL,NULL),(351,'169.254.1.96',1,1,NULL,NULL,NULL),(352,'169.254.1.97',1,1,NULL,NULL,NULL),(353,'169.254.1.98',1,1,NULL,NULL,NULL),(354,'169.254.1.99',1,1,NULL,NULL,NULL),(355,'169.254.1.100',1,1,NULL,NULL,NULL),(356,'169.254.1.101',1,1,NULL,NULL,NULL),(357,'169.254.1.102',1,1,NULL,NULL,NULL),(358,'169.254.1.103',1,1,NULL,NULL,NULL),(359,'169.254.1.104',1,1,NULL,NULL,NULL),(360,'169.254.1.105',1,1,NULL,NULL,NULL),(361,'169.254.1.106',1,1,NULL,NULL,NULL),(362,'169.254.1.107',1,1,NULL,NULL,NULL),(363,'169.254.1.108',1,1,NULL,NULL,NULL),(364,'169.254.1.109',1,1,NULL,NULL,NULL),(365,'169.254.1.110',1,1,NULL,NULL,NULL),(366,'169.254.1.111',1,1,NULL,NULL,NULL),(367,'169.254.1.112',1,1,NULL,NULL,NULL),(368,'169.254.1.113',1,1,NULL,NULL,NULL),(369,'169.254.1.114',1,1,NULL,NULL,NULL),(370,'169.254.1.115',1,1,NULL,NULL,NULL),(371,'169.254.1.116',1,1,NULL,NULL,NULL),(372,'169.254.1.117',1,1,NULL,NULL,NULL),(373,'169.254.1.118',1,1,NULL,NULL,NULL),(374,'169.254.1.119',1,1,NULL,NULL,NULL),(375,'169.254.1.120',1,1,NULL,NULL,NULL),(376,'169.254.1.121',1,1,NULL,NULL,NULL),(377,'169.254.1.122',1,1,NULL,NULL,NULL),(378,'169.254.1.123',1,1,NULL,NULL,NULL),(379,'169.254.1.124',1,1,NULL,NULL,NULL),(380,'169.254.1.125',1,1,NULL,NULL,NULL),(381,'169.254.1.126',1,1,NULL,NULL,NULL),(382,'169.254.1.127',1,1,NULL,NULL,NULL),(383,'169.254.1.128',1,1,NULL,NULL,NULL),(384,'169.254.1.129',1,1,NULL,NULL,NULL),(385,'169.254.1.130',1,1,NULL,NULL,NULL),(386,'169.254.1.131',1,1,NULL,NULL,NULL),(387,'169.254.1.132',1,1,NULL,NULL,NULL),(388,'169.254.1.133',1,1,NULL,NULL,NULL),(389,'169.254.1.134',1,1,NULL,NULL,NULL),(390,'169.254.1.135',1,1,NULL,NULL,NULL),(391,'169.254.1.136',1,1,NULL,NULL,NULL),(392,'169.254.1.137',1,1,NULL,NULL,NULL),(393,'169.254.1.138',1,1,NULL,NULL,NULL),(394,'169.254.1.139',1,1,NULL,NULL,NULL),(395,'169.254.1.140',1,1,NULL,NULL,NULL),(396,'169.254.1.141',1,1,NULL,NULL,NULL),(397,'169.254.1.142',1,1,NULL,NULL,NULL),(398,'169.254.1.143',1,1,NULL,NULL,NULL),(399,'169.254.1.144',1,1,NULL,NULL,NULL),(400,'169.254.1.145',1,1,NULL,NULL,NULL),(401,'169.254.1.146',1,1,NULL,NULL,NULL),(402,'169.254.1.147',1,1,NULL,NULL,NULL),(403,'169.254.1.148',1,1,NULL,NULL,NULL),(404,'169.254.1.149',1,1,NULL,NULL,NULL),(405,'169.254.1.150',1,1,NULL,NULL,NULL),(406,'169.254.1.151',1,1,NULL,NULL,NULL),(407,'169.254.1.152',1,1,NULL,NULL,NULL),(408,'169.254.1.153',1,1,NULL,NULL,NULL),(409,'169.254.1.154',1,1,NULL,NULL,NULL),(410,'169.254.1.155',1,1,NULL,NULL,NULL),(411,'169.254.1.156',1,1,NULL,NULL,NULL),(412,'169.254.1.157',1,1,NULL,NULL,NULL),(413,'169.254.1.158',1,1,NULL,NULL,NULL),(414,'169.254.1.159',1,1,NULL,NULL,NULL),(415,'169.254.1.160',1,1,NULL,NULL,NULL),(416,'169.254.1.161',1,1,NULL,NULL,NULL),(417,'169.254.1.162',1,1,NULL,NULL,NULL),(418,'169.254.1.163',1,1,NULL,NULL,NULL),(419,'169.254.1.164',1,1,NULL,NULL,NULL),(420,'169.254.1.165',1,1,NULL,NULL,NULL),(421,'169.254.1.166',1,1,NULL,NULL,NULL),(422,'169.254.1.167',1,1,NULL,NULL,NULL),(423,'169.254.1.168',1,1,NULL,NULL,NULL),(424,'169.254.1.169',1,1,NULL,NULL,NULL),(425,'169.254.1.170',1,1,NULL,NULL,NULL),(426,'169.254.1.171',1,1,NULL,NULL,NULL),(427,'169.254.1.172',1,1,NULL,NULL,NULL),(428,'169.254.1.173',1,1,NULL,NULL,NULL),(429,'169.254.1.174',1,1,NULL,NULL,NULL),(430,'169.254.1.175',1,1,NULL,NULL,NULL),(431,'169.254.1.176',1,1,NULL,NULL,NULL),(432,'169.254.1.177',1,1,NULL,NULL,NULL),(433,'169.254.1.178',1,1,NULL,NULL,NULL),(434,'169.254.1.179',1,1,NULL,NULL,NULL),(435,'169.254.1.180',1,1,NULL,NULL,NULL),(436,'169.254.1.181',1,1,NULL,NULL,NULL),(437,'169.254.1.182',1,1,NULL,NULL,NULL),(438,'169.254.1.183',1,1,NULL,NULL,NULL),(439,'169.254.1.184',1,1,NULL,NULL,NULL),(440,'169.254.1.185',1,1,NULL,NULL,NULL),(441,'169.254.1.186',1,1,NULL,NULL,NULL),(442,'169.254.1.187',1,1,NULL,NULL,NULL),(443,'169.254.1.188',1,1,NULL,NULL,NULL),(444,'169.254.1.189',1,1,NULL,NULL,NULL),(445,'169.254.1.190',1,1,NULL,NULL,NULL),(446,'169.254.1.191',1,1,NULL,NULL,NULL),(447,'169.254.1.192',1,1,NULL,NULL,NULL),(448,'169.254.1.193',1,1,NULL,NULL,NULL),(449,'169.254.1.194',1,1,NULL,NULL,NULL),(450,'169.254.1.195',1,1,NULL,NULL,NULL),(451,'169.254.1.196',1,1,NULL,NULL,NULL),(452,'169.254.1.197',1,1,NULL,NULL,NULL),(453,'169.254.1.198',1,1,NULL,NULL,NULL),(454,'169.254.1.199',1,1,NULL,NULL,NULL),(455,'169.254.1.200',1,1,NULL,NULL,NULL),(456,'169.254.1.201',1,1,NULL,NULL,NULL),(457,'169.254.1.202',1,1,NULL,NULL,NULL),(458,'169.254.1.203',1,1,NULL,NULL,NULL),(459,'169.254.1.204',1,1,NULL,NULL,NULL),(460,'169.254.1.205',1,1,NULL,NULL,NULL),(461,'169.254.1.206',1,1,NULL,NULL,NULL),(462,'169.254.1.207',1,1,NULL,NULL,NULL),(463,'169.254.1.208',1,1,NULL,NULL,NULL),(464,'169.254.1.209',1,1,NULL,NULL,NULL),(465,'169.254.1.210',1,1,NULL,NULL,NULL),(466,'169.254.1.211',1,1,NULL,NULL,NULL),(467,'169.254.1.212',1,1,NULL,NULL,NULL),(468,'169.254.1.213',1,1,NULL,NULL,NULL),(469,'169.254.1.214',1,1,NULL,NULL,NULL),(470,'169.254.1.215',1,1,NULL,NULL,NULL),(471,'169.254.1.216',1,1,NULL,NULL,NULL),(472,'169.254.1.217',1,1,NULL,NULL,NULL),(473,'169.254.1.218',1,1,NULL,NULL,NULL),(474,'169.254.1.219',1,1,NULL,NULL,NULL),(475,'169.254.1.220',1,1,NULL,NULL,NULL),(476,'169.254.1.221',1,1,NULL,NULL,NULL),(477,'169.254.1.222',1,1,NULL,NULL,NULL),(478,'169.254.1.223',1,1,NULL,NULL,NULL),(479,'169.254.1.224',1,1,NULL,NULL,NULL),(480,'169.254.1.225',1,1,NULL,NULL,NULL),(481,'169.254.1.226',1,1,NULL,NULL,NULL),(482,'169.254.1.227',1,1,NULL,NULL,NULL),(483,'169.254.1.228',1,1,NULL,NULL,NULL),(484,'169.254.1.229',1,1,NULL,NULL,NULL),(485,'169.254.1.230',1,1,NULL,NULL,NULL),(486,'169.254.1.231',1,1,NULL,NULL,NULL),(487,'169.254.1.232',1,1,NULL,NULL,NULL),(488,'169.254.1.233',1,1,NULL,NULL,NULL),(489,'169.254.1.234',1,1,NULL,NULL,NULL),(490,'169.254.1.235',1,1,NULL,NULL,NULL),(491,'169.254.1.236',1,1,NULL,NULL,NULL),(492,'169.254.1.237',1,1,NULL,NULL,NULL),(493,'169.254.1.238',1,1,NULL,NULL,NULL),(494,'169.254.1.239',1,1,NULL,NULL,NULL),(495,'169.254.1.240',1,1,NULL,NULL,NULL),(496,'169.254.1.241',1,1,NULL,NULL,NULL),(497,'169.254.1.242',1,1,NULL,NULL,NULL),(498,'169.254.1.243',1,1,NULL,NULL,NULL),(499,'169.254.1.244',1,1,NULL,NULL,NULL),(500,'169.254.1.245',1,1,NULL,NULL,NULL),(501,'169.254.1.246',1,1,NULL,NULL,NULL),(502,'169.254.1.247',1,1,NULL,NULL,NULL),(503,'169.254.1.248',1,1,NULL,NULL,NULL),(504,'169.254.1.249',1,1,NULL,NULL,NULL),(505,'169.254.1.250',1,1,NULL,NULL,NULL),(506,'169.254.1.251',1,1,NULL,NULL,NULL),(507,'169.254.1.252',1,1,NULL,NULL,NULL),(508,'169.254.1.253',1,1,NULL,NULL,NULL),(509,'169.254.1.254',1,1,NULL,NULL,NULL),(510,'169.254.1.255',1,1,NULL,NULL,NULL),(511,'169.254.2.0',1,1,NULL,NULL,NULL),(512,'169.254.2.1',1,1,NULL,NULL,NULL),(513,'169.254.2.2',1,1,NULL,NULL,NULL),(514,'169.254.2.3',1,1,NULL,NULL,NULL),(515,'169.254.2.4',1,1,NULL,NULL,NULL),(516,'169.254.2.5',1,1,NULL,NULL,NULL),(517,'169.254.2.6',1,1,NULL,NULL,NULL),(518,'169.254.2.7',1,1,NULL,NULL,NULL),(519,'169.254.2.8',1,1,NULL,NULL,NULL),(520,'169.254.2.9',1,1,NULL,NULL,NULL),(521,'169.254.2.10',1,1,NULL,NULL,NULL),(522,'169.254.2.11',1,1,NULL,NULL,NULL),(523,'169.254.2.12',1,1,NULL,NULL,NULL),(524,'169.254.2.13',1,1,NULL,NULL,NULL),(525,'169.254.2.14',1,1,NULL,NULL,NULL),(526,'169.254.2.15',1,1,NULL,NULL,NULL),(527,'169.254.2.16',1,1,NULL,NULL,NULL),(528,'169.254.2.17',1,1,NULL,NULL,NULL),(529,'169.254.2.18',1,1,NULL,NULL,NULL),(530,'169.254.2.19',1,1,NULL,NULL,NULL),(531,'169.254.2.20',1,1,NULL,NULL,NULL),(532,'169.254.2.21',1,1,NULL,NULL,NULL),(533,'169.254.2.22',1,1,NULL,NULL,NULL),(534,'169.254.2.23',1,1,NULL,NULL,NULL),(535,'169.254.2.24',1,1,NULL,NULL,NULL),(536,'169.254.2.25',1,1,NULL,NULL,NULL),(537,'169.254.2.26',1,1,NULL,NULL,NULL),(538,'169.254.2.27',1,1,NULL,NULL,NULL),(539,'169.254.2.28',1,1,NULL,NULL,NULL),(540,'169.254.2.29',1,1,NULL,NULL,NULL),(541,'169.254.2.30',1,1,NULL,NULL,NULL),(542,'169.254.2.31',1,1,NULL,NULL,NULL),(543,'169.254.2.32',1,1,NULL,NULL,NULL),(544,'169.254.2.33',1,1,NULL,NULL,NULL),(545,'169.254.2.34',1,1,NULL,NULL,NULL),(546,'169.254.2.35',1,1,2,'84d9c349-c24b-4df6-a59a-e5e0fa33c96b','2014-06-26 02:27:59'),(547,'169.254.2.36',1,1,NULL,NULL,NULL),(548,'169.254.2.37',1,1,NULL,NULL,NULL),(549,'169.254.2.38',1,1,NULL,NULL,NULL),(550,'169.254.2.39',1,1,NULL,NULL,NULL),(551,'169.254.2.40',1,1,NULL,NULL,NULL),(552,'169.254.2.41',1,1,NULL,NULL,NULL),(553,'169.254.2.42',1,1,NULL,NULL,NULL),(554,'169.254.2.43',1,1,NULL,NULL,NULL),(555,'169.254.2.44',1,1,NULL,NULL,NULL),(556,'169.254.2.45',1,1,NULL,NULL,NULL),(557,'169.254.2.46',1,1,NULL,NULL,NULL),(558,'169.254.2.47',1,1,NULL,NULL,NULL),(559,'169.254.2.48',1,1,NULL,NULL,NULL),(560,'169.254.2.49',1,1,NULL,NULL,NULL),(561,'169.254.2.50',1,1,NULL,NULL,NULL),(562,'169.254.2.51',1,1,NULL,NULL,NULL),(563,'169.254.2.52',1,1,NULL,NULL,NULL),(564,'169.254.2.53',1,1,NULL,NULL,NULL),(565,'169.254.2.54',1,1,NULL,NULL,NULL),(566,'169.254.2.55',1,1,NULL,NULL,NULL),(567,'169.254.2.56',1,1,NULL,NULL,NULL),(568,'169.254.2.57',1,1,NULL,NULL,NULL),(569,'169.254.2.58',1,1,NULL,NULL,NULL),(570,'169.254.2.59',1,1,NULL,NULL,NULL),(571,'169.254.2.60',1,1,NULL,NULL,NULL),(572,'169.254.2.61',1,1,NULL,NULL,NULL),(573,'169.254.2.62',1,1,NULL,NULL,NULL),(574,'169.254.2.63',1,1,NULL,NULL,NULL),(575,'169.254.2.64',1,1,NULL,NULL,NULL),(576,'169.254.2.65',1,1,NULL,NULL,NULL),(577,'169.254.2.66',1,1,NULL,NULL,NULL),(578,'169.254.2.67',1,1,NULL,NULL,NULL),(579,'169.254.2.68',1,1,NULL,NULL,NULL),(580,'169.254.2.69',1,1,NULL,NULL,NULL),(581,'169.254.2.70',1,1,NULL,NULL,NULL),(582,'169.254.2.71',1,1,NULL,NULL,NULL),(583,'169.254.2.72',1,1,NULL,NULL,NULL),(584,'169.254.2.73',1,1,NULL,NULL,NULL),(585,'169.254.2.74',1,1,NULL,NULL,NULL),(586,'169.254.2.75',1,1,NULL,NULL,NULL),(587,'169.254.2.76',1,1,NULL,NULL,NULL),(588,'169.254.2.77',1,1,NULL,NULL,NULL),(589,'169.254.2.78',1,1,NULL,NULL,NULL),(590,'169.254.2.79',1,1,NULL,NULL,NULL),(591,'169.254.2.80',1,1,NULL,NULL,NULL),(592,'169.254.2.81',1,1,NULL,NULL,NULL),(593,'169.254.2.82',1,1,NULL,NULL,NULL),(594,'169.254.2.83',1,1,NULL,NULL,NULL),(595,'169.254.2.84',1,1,NULL,NULL,NULL),(596,'169.254.2.85',1,1,NULL,NULL,NULL),(597,'169.254.2.86',1,1,NULL,NULL,NULL),(598,'169.254.2.87',1,1,NULL,NULL,NULL),(599,'169.254.2.88',1,1,NULL,NULL,NULL),(600,'169.254.2.89',1,1,NULL,NULL,NULL),(601,'169.254.2.90',1,1,NULL,NULL,NULL),(602,'169.254.2.91',1,1,NULL,NULL,NULL),(603,'169.254.2.92',1,1,NULL,NULL,NULL),(604,'169.254.2.93',1,1,NULL,NULL,NULL),(605,'169.254.2.94',1,1,NULL,NULL,NULL),(606,'169.254.2.95',1,1,NULL,NULL,NULL),(607,'169.254.2.96',1,1,NULL,NULL,NULL),(608,'169.254.2.97',1,1,NULL,NULL,NULL),(609,'169.254.2.98',1,1,NULL,NULL,NULL),(610,'169.254.2.99',1,1,NULL,NULL,NULL),(611,'169.254.2.100',1,1,NULL,NULL,NULL),(612,'169.254.2.101',1,1,NULL,NULL,NULL),(613,'169.254.2.102',1,1,NULL,NULL,NULL),(614,'169.254.2.103',1,1,NULL,NULL,NULL),(615,'169.254.2.104',1,1,NULL,NULL,NULL),(616,'169.254.2.105',1,1,NULL,NULL,NULL),(617,'169.254.2.106',1,1,NULL,NULL,NULL),(618,'169.254.2.107',1,1,NULL,NULL,NULL),(619,'169.254.2.108',1,1,NULL,NULL,NULL),(620,'169.254.2.109',1,1,NULL,NULL,NULL),(621,'169.254.2.110',1,1,NULL,NULL,NULL),(622,'169.254.2.111',1,1,NULL,NULL,NULL),(623,'169.254.2.112',1,1,NULL,NULL,NULL),(624,'169.254.2.113',1,1,NULL,NULL,NULL),(625,'169.254.2.114',1,1,NULL,NULL,NULL),(626,'169.254.2.115',1,1,NULL,NULL,NULL),(627,'169.254.2.116',1,1,NULL,NULL,NULL),(628,'169.254.2.117',1,1,NULL,NULL,NULL),(629,'169.254.2.118',1,1,NULL,NULL,NULL),(630,'169.254.2.119',1,1,NULL,NULL,NULL),(631,'169.254.2.120',1,1,NULL,NULL,NULL),(632,'169.254.2.121',1,1,NULL,NULL,NULL),(633,'169.254.2.122',1,1,NULL,NULL,NULL),(634,'169.254.2.123',1,1,NULL,NULL,NULL),(635,'169.254.2.124',1,1,NULL,NULL,NULL),(636,'169.254.2.125',1,1,NULL,NULL,NULL),(637,'169.254.2.126',1,1,NULL,NULL,NULL),(638,'169.254.2.127',1,1,NULL,NULL,NULL),(639,'169.254.2.128',1,1,NULL,NULL,NULL),(640,'169.254.2.129',1,1,NULL,NULL,NULL),(641,'169.254.2.130',1,1,NULL,NULL,NULL),(642,'169.254.2.131',1,1,NULL,NULL,NULL),(643,'169.254.2.132',1,1,NULL,NULL,NULL),(644,'169.254.2.133',1,1,NULL,NULL,NULL),(645,'169.254.2.134',1,1,NULL,NULL,NULL),(646,'169.254.2.135',1,1,NULL,NULL,NULL),(647,'169.254.2.136',1,1,NULL,NULL,NULL),(648,'169.254.2.137',1,1,NULL,NULL,NULL),(649,'169.254.2.138',1,1,NULL,NULL,NULL),(650,'169.254.2.139',1,1,NULL,NULL,NULL),(651,'169.254.2.140',1,1,NULL,NULL,NULL),(652,'169.254.2.141',1,1,NULL,NULL,NULL),(653,'169.254.2.142',1,1,NULL,NULL,NULL),(654,'169.254.2.143',1,1,NULL,NULL,NULL),(655,'169.254.2.144',1,1,NULL,NULL,NULL),(656,'169.254.2.145',1,1,NULL,NULL,NULL),(657,'169.254.2.146',1,1,NULL,NULL,NULL),(658,'169.254.2.147',1,1,NULL,NULL,NULL),(659,'169.254.2.148',1,1,NULL,NULL,NULL),(660,'169.254.2.149',1,1,NULL,NULL,NULL),(661,'169.254.2.150',1,1,NULL,NULL,NULL),(662,'169.254.2.151',1,1,NULL,NULL,NULL),(663,'169.254.2.152',1,1,NULL,NULL,NULL),(664,'169.254.2.153',1,1,NULL,NULL,NULL),(665,'169.254.2.154',1,1,NULL,NULL,NULL),(666,'169.254.2.155',1,1,NULL,NULL,NULL),(667,'169.254.2.156',1,1,NULL,NULL,NULL),(668,'169.254.2.157',1,1,NULL,NULL,NULL),(669,'169.254.2.158',1,1,NULL,NULL,NULL),(670,'169.254.2.159',1,1,NULL,NULL,NULL),(671,'169.254.2.160',1,1,NULL,NULL,NULL),(672,'169.254.2.161',1,1,NULL,NULL,NULL),(673,'169.254.2.162',1,1,NULL,NULL,NULL),(674,'169.254.2.163',1,1,NULL,NULL,NULL),(675,'169.254.2.164',1,1,NULL,NULL,NULL),(676,'169.254.2.165',1,1,NULL,NULL,NULL),(677,'169.254.2.166',1,1,NULL,NULL,NULL),(678,'169.254.2.167',1,1,NULL,NULL,NULL),(679,'169.254.2.168',1,1,NULL,NULL,NULL),(680,'169.254.2.169',1,1,NULL,NULL,NULL),(681,'169.254.2.170',1,1,NULL,NULL,NULL),(682,'169.254.2.171',1,1,NULL,NULL,NULL),(683,'169.254.2.172',1,1,NULL,NULL,NULL),(684,'169.254.2.173',1,1,NULL,NULL,NULL),(685,'169.254.2.174',1,1,NULL,NULL,NULL),(686,'169.254.2.175',1,1,NULL,NULL,NULL),(687,'169.254.2.176',1,1,NULL,NULL,NULL),(688,'169.254.2.177',1,1,NULL,NULL,NULL),(689,'169.254.2.178',1,1,NULL,NULL,NULL),(690,'169.254.2.179',1,1,NULL,NULL,NULL),(691,'169.254.2.180',1,1,NULL,NULL,NULL),(692,'169.254.2.181',1,1,NULL,NULL,NULL),(693,'169.254.2.182',1,1,NULL,NULL,NULL),(694,'169.254.2.183',1,1,NULL,NULL,NULL),(695,'169.254.2.184',1,1,NULL,NULL,NULL),(696,'169.254.2.185',1,1,NULL,NULL,NULL),(697,'169.254.2.186',1,1,NULL,NULL,NULL),(698,'169.254.2.187',1,1,NULL,NULL,NULL),(699,'169.254.2.188',1,1,NULL,NULL,NULL),(700,'169.254.2.189',1,1,NULL,NULL,NULL),(701,'169.254.2.190',1,1,NULL,NULL,NULL),(702,'169.254.2.191',1,1,NULL,NULL,NULL),(703,'169.254.2.192',1,1,NULL,NULL,NULL),(704,'169.254.2.193',1,1,NULL,NULL,NULL),(705,'169.254.2.194',1,1,NULL,NULL,NULL),(706,'169.254.2.195',1,1,NULL,NULL,NULL),(707,'169.254.2.196',1,1,NULL,NULL,NULL),(708,'169.254.2.197',1,1,NULL,NULL,NULL),(709,'169.254.2.198',1,1,NULL,NULL,NULL),(710,'169.254.2.199',1,1,NULL,NULL,NULL),(711,'169.254.2.200',1,1,NULL,NULL,NULL),(712,'169.254.2.201',1,1,NULL,NULL,NULL),(713,'169.254.2.202',1,1,NULL,NULL,NULL),(714,'169.254.2.203',1,1,NULL,NULL,NULL),(715,'169.254.2.204',1,1,NULL,NULL,NULL),(716,'169.254.2.205',1,1,NULL,NULL,NULL),(717,'169.254.2.206',1,1,NULL,NULL,NULL),(718,'169.254.2.207',1,1,NULL,NULL,NULL),(719,'169.254.2.208',1,1,NULL,NULL,NULL),(720,'169.254.2.209',1,1,NULL,NULL,NULL),(721,'169.254.2.210',1,1,NULL,NULL,NULL),(722,'169.254.2.211',1,1,NULL,NULL,NULL),(723,'169.254.2.212',1,1,NULL,NULL,NULL),(724,'169.254.2.213',1,1,NULL,NULL,NULL),(725,'169.254.2.214',1,1,NULL,NULL,NULL),(726,'169.254.2.215',1,1,NULL,NULL,NULL),(727,'169.254.2.216',1,1,NULL,NULL,NULL),(728,'169.254.2.217',1,1,NULL,NULL,NULL),(729,'169.254.2.218',1,1,NULL,NULL,NULL),(730,'169.254.2.219',1,1,NULL,NULL,NULL),(731,'169.254.2.220',1,1,NULL,NULL,NULL),(732,'169.254.2.221',1,1,NULL,NULL,NULL),(733,'169.254.2.222',1,1,NULL,NULL,NULL),(734,'169.254.2.223',1,1,NULL,NULL,NULL),(735,'169.254.2.224',1,1,NULL,NULL,NULL),(736,'169.254.2.225',1,1,NULL,NULL,NULL),(737,'169.254.2.226',1,1,NULL,NULL,NULL),(738,'169.254.2.227',1,1,NULL,NULL,NULL),(739,'169.254.2.228',1,1,NULL,NULL,NULL),(740,'169.254.2.229',1,1,NULL,NULL,NULL),(741,'169.254.2.230',1,1,NULL,NULL,NULL),(742,'169.254.2.231',1,1,NULL,NULL,NULL),(743,'169.254.2.232',1,1,NULL,NULL,NULL),(744,'169.254.2.233',1,1,NULL,NULL,NULL),(745,'169.254.2.234',1,1,NULL,NULL,NULL),(746,'169.254.2.235',1,1,NULL,NULL,NULL),(747,'169.254.2.236',1,1,NULL,NULL,NULL),(748,'169.254.2.237',1,1,NULL,NULL,NULL),(749,'169.254.2.238',1,1,NULL,NULL,NULL),(750,'169.254.2.239',1,1,NULL,NULL,NULL),(751,'169.254.2.240',1,1,NULL,NULL,NULL),(752,'169.254.2.241',1,1,NULL,NULL,NULL),(753,'169.254.2.242',1,1,NULL,NULL,NULL),(754,'169.254.2.243',1,1,NULL,NULL,NULL),(755,'169.254.2.244',1,1,NULL,NULL,NULL),(756,'169.254.2.245',1,1,NULL,NULL,NULL),(757,'169.254.2.246',1,1,NULL,NULL,NULL),(758,'169.254.2.247',1,1,NULL,NULL,NULL),(759,'169.254.2.248',1,1,NULL,NULL,NULL),(760,'169.254.2.249',1,1,NULL,NULL,NULL),(761,'169.254.2.250',1,1,NULL,NULL,NULL),(762,'169.254.2.251',1,1,NULL,NULL,NULL),(763,'169.254.2.252',1,1,NULL,NULL,NULL),(764,'169.254.2.253',1,1,NULL,NULL,NULL),(765,'169.254.2.254',1,1,NULL,NULL,NULL),(766,'169.254.2.255',1,1,NULL,NULL,NULL),(767,'169.254.3.0',1,1,NULL,NULL,NULL),(768,'169.254.3.1',1,1,NULL,NULL,NULL),(769,'169.254.3.2',1,1,NULL,NULL,NULL),(770,'169.254.3.3',1,1,NULL,NULL,NULL),(771,'169.254.3.4',1,1,NULL,NULL,NULL),(772,'169.254.3.5',1,1,NULL,NULL,NULL),(773,'169.254.3.6',1,1,NULL,NULL,NULL),(774,'169.254.3.7',1,1,NULL,NULL,NULL),(775,'169.254.3.8',1,1,NULL,NULL,NULL),(776,'169.254.3.9',1,1,NULL,NULL,NULL),(777,'169.254.3.10',1,1,NULL,NULL,NULL),(778,'169.254.3.11',1,1,NULL,NULL,NULL),(779,'169.254.3.12',1,1,NULL,NULL,NULL),(780,'169.254.3.13',1,1,NULL,NULL,NULL),(781,'169.254.3.14',1,1,NULL,NULL,NULL),(782,'169.254.3.15',1,1,NULL,NULL,NULL),(783,'169.254.3.16',1,1,NULL,NULL,NULL),(784,'169.254.3.17',1,1,NULL,NULL,NULL),(785,'169.254.3.18',1,1,NULL,NULL,NULL),(786,'169.254.3.19',1,1,NULL,NULL,NULL),(787,'169.254.3.20',1,1,NULL,NULL,NULL),(788,'169.254.3.21',1,1,NULL,NULL,NULL),(789,'169.254.3.22',1,1,NULL,NULL,NULL),(790,'169.254.3.23',1,1,NULL,NULL,NULL),(791,'169.254.3.24',1,1,NULL,NULL,NULL),(792,'169.254.3.25',1,1,NULL,NULL,NULL),(793,'169.254.3.26',1,1,NULL,NULL,NULL),(794,'169.254.3.27',1,1,NULL,NULL,NULL),(795,'169.254.3.28',1,1,NULL,NULL,NULL),(796,'169.254.3.29',1,1,NULL,NULL,NULL),(797,'169.254.3.30',1,1,NULL,NULL,NULL),(798,'169.254.3.31',1,1,NULL,NULL,NULL),(799,'169.254.3.32',1,1,NULL,NULL,NULL),(800,'169.254.3.33',1,1,NULL,NULL,NULL),(801,'169.254.3.34',1,1,NULL,NULL,NULL),(802,'169.254.3.35',1,1,NULL,NULL,NULL),(803,'169.254.3.36',1,1,NULL,NULL,NULL),(804,'169.254.3.37',1,1,NULL,NULL,NULL),(805,'169.254.3.38',1,1,NULL,NULL,NULL),(806,'169.254.3.39',1,1,NULL,NULL,NULL),(807,'169.254.3.40',1,1,NULL,NULL,NULL),(808,'169.254.3.41',1,1,NULL,NULL,NULL),(809,'169.254.3.42',1,1,NULL,NULL,NULL),(810,'169.254.3.43',1,1,NULL,NULL,NULL),(811,'169.254.3.44',1,1,NULL,NULL,NULL),(812,'169.254.3.45',1,1,NULL,NULL,NULL),(813,'169.254.3.46',1,1,NULL,NULL,NULL),(814,'169.254.3.47',1,1,NULL,NULL,NULL),(815,'169.254.3.48',1,1,NULL,NULL,NULL),(816,'169.254.3.49',1,1,NULL,NULL,NULL),(817,'169.254.3.50',1,1,NULL,NULL,NULL),(818,'169.254.3.51',1,1,NULL,NULL,NULL),(819,'169.254.3.52',1,1,NULL,NULL,NULL),(820,'169.254.3.53',1,1,NULL,NULL,NULL),(821,'169.254.3.54',1,1,NULL,NULL,NULL),(822,'169.254.3.55',1,1,NULL,NULL,NULL),(823,'169.254.3.56',1,1,NULL,NULL,NULL),(824,'169.254.3.57',1,1,NULL,NULL,NULL),(825,'169.254.3.58',1,1,NULL,NULL,NULL),(826,'169.254.3.59',1,1,NULL,NULL,NULL),(827,'169.254.3.60',1,1,NULL,NULL,NULL),(828,'169.254.3.61',1,1,NULL,NULL,NULL),(829,'169.254.3.62',1,1,NULL,NULL,NULL),(830,'169.254.3.63',1,1,NULL,NULL,NULL),(831,'169.254.3.64',1,1,NULL,NULL,NULL),(832,'169.254.3.65',1,1,NULL,NULL,NULL),(833,'169.254.3.66',1,1,NULL,NULL,NULL),(834,'169.254.3.67',1,1,NULL,NULL,NULL),(835,'169.254.3.68',1,1,NULL,NULL,NULL),(836,'169.254.3.69',1,1,NULL,NULL,NULL),(837,'169.254.3.70',1,1,NULL,NULL,NULL),(838,'169.254.3.71',1,1,NULL,NULL,NULL),(839,'169.254.3.72',1,1,NULL,NULL,NULL),(840,'169.254.3.73',1,1,NULL,NULL,NULL),(841,'169.254.3.74',1,1,NULL,NULL,NULL),(842,'169.254.3.75',1,1,NULL,NULL,NULL),(843,'169.254.3.76',1,1,NULL,NULL,NULL),(844,'169.254.3.77',1,1,NULL,NULL,NULL),(845,'169.254.3.78',1,1,NULL,NULL,NULL),(846,'169.254.3.79',1,1,NULL,NULL,NULL),(847,'169.254.3.80',1,1,NULL,NULL,NULL),(848,'169.254.3.81',1,1,NULL,NULL,NULL),(849,'169.254.3.82',1,1,NULL,NULL,NULL),(850,'169.254.3.83',1,1,NULL,NULL,NULL),(851,'169.254.3.84',1,1,NULL,NULL,NULL),(852,'169.254.3.85',1,1,NULL,NULL,NULL),(853,'169.254.3.86',1,1,NULL,NULL,NULL),(854,'169.254.3.87',1,1,NULL,NULL,NULL),(855,'169.254.3.88',1,1,NULL,NULL,NULL),(856,'169.254.3.89',1,1,NULL,NULL,NULL),(857,'169.254.3.90',1,1,NULL,NULL,NULL),(858,'169.254.3.91',1,1,NULL,NULL,NULL),(859,'169.254.3.92',1,1,NULL,NULL,NULL),(860,'169.254.3.93',1,1,NULL,NULL,NULL),(861,'169.254.3.94',1,1,NULL,NULL,NULL),(862,'169.254.3.95',1,1,NULL,NULL,NULL),(863,'169.254.3.96',1,1,NULL,NULL,NULL),(864,'169.254.3.97',1,1,NULL,NULL,NULL),(865,'169.254.3.98',1,1,NULL,NULL,NULL),(866,'169.254.3.99',1,1,NULL,NULL,NULL),(867,'169.254.3.100',1,1,NULL,NULL,NULL),(868,'169.254.3.101',1,1,NULL,NULL,NULL),(869,'169.254.3.102',1,1,NULL,NULL,NULL),(870,'169.254.3.103',1,1,NULL,NULL,NULL),(871,'169.254.3.104',1,1,NULL,NULL,NULL),(872,'169.254.3.105',1,1,NULL,NULL,NULL),(873,'169.254.3.106',1,1,NULL,NULL,NULL),(874,'169.254.3.107',1,1,NULL,NULL,NULL),(875,'169.254.3.108',1,1,NULL,NULL,NULL),(876,'169.254.3.109',1,1,NULL,NULL,NULL),(877,'169.254.3.110',1,1,NULL,NULL,NULL),(878,'169.254.3.111',1,1,NULL,NULL,NULL),(879,'169.254.3.112',1,1,NULL,NULL,NULL),(880,'169.254.3.113',1,1,NULL,NULL,NULL),(881,'169.254.3.114',1,1,NULL,NULL,NULL),(882,'169.254.3.115',1,1,NULL,NULL,NULL),(883,'169.254.3.116',1,1,NULL,NULL,NULL),(884,'169.254.3.117',1,1,NULL,NULL,NULL),(885,'169.254.3.118',1,1,NULL,NULL,NULL),(886,'169.254.3.119',1,1,NULL,NULL,NULL),(887,'169.254.3.120',1,1,NULL,NULL,NULL),(888,'169.254.3.121',1,1,NULL,NULL,NULL),(889,'169.254.3.122',1,1,NULL,NULL,NULL),(890,'169.254.3.123',1,1,NULL,NULL,NULL),(891,'169.254.3.124',1,1,NULL,NULL,NULL),(892,'169.254.3.125',1,1,NULL,NULL,NULL),(893,'169.254.3.126',1,1,NULL,NULL,NULL),(894,'169.254.3.127',1,1,NULL,NULL,NULL),(895,'169.254.3.128',1,1,NULL,NULL,NULL),(896,'169.254.3.129',1,1,NULL,NULL,NULL),(897,'169.254.3.130',1,1,NULL,NULL,NULL),(898,'169.254.3.131',1,1,NULL,NULL,NULL),(899,'169.254.3.132',1,1,NULL,NULL,NULL),(900,'169.254.3.133',1,1,NULL,NULL,NULL),(901,'169.254.3.134',1,1,NULL,NULL,NULL),(902,'169.254.3.135',1,1,NULL,NULL,NULL),(903,'169.254.3.136',1,1,NULL,NULL,NULL),(904,'169.254.3.137',1,1,NULL,NULL,NULL),(905,'169.254.3.138',1,1,NULL,NULL,NULL),(906,'169.254.3.139',1,1,NULL,NULL,NULL),(907,'169.254.3.140',1,1,NULL,NULL,NULL),(908,'169.254.3.141',1,1,NULL,NULL,NULL),(909,'169.254.3.142',1,1,NULL,NULL,NULL),(910,'169.254.3.143',1,1,NULL,NULL,NULL),(911,'169.254.3.144',1,1,NULL,NULL,NULL),(912,'169.254.3.145',1,1,NULL,NULL,NULL),(913,'169.254.3.146',1,1,NULL,NULL,NULL),(914,'169.254.3.147',1,1,NULL,NULL,NULL),(915,'169.254.3.148',1,1,NULL,NULL,NULL),(916,'169.254.3.149',1,1,NULL,NULL,NULL),(917,'169.254.3.150',1,1,NULL,NULL,NULL),(918,'169.254.3.151',1,1,NULL,NULL,NULL),(919,'169.254.3.152',1,1,NULL,NULL,NULL),(920,'169.254.3.153',1,1,NULL,NULL,NULL),(921,'169.254.3.154',1,1,NULL,NULL,NULL),(922,'169.254.3.155',1,1,NULL,NULL,NULL),(923,'169.254.3.156',1,1,NULL,NULL,NULL),(924,'169.254.3.157',1,1,NULL,NULL,NULL),(925,'169.254.3.158',1,1,NULL,NULL,NULL),(926,'169.254.3.159',1,1,NULL,NULL,NULL),(927,'169.254.3.160',1,1,NULL,NULL,NULL),(928,'169.254.3.161',1,1,NULL,NULL,NULL),(929,'169.254.3.162',1,1,NULL,NULL,NULL),(930,'169.254.3.163',1,1,NULL,NULL,NULL),(931,'169.254.3.164',1,1,NULL,NULL,NULL),(932,'169.254.3.165',1,1,NULL,NULL,NULL),(933,'169.254.3.166',1,1,NULL,NULL,NULL),(934,'169.254.3.167',1,1,NULL,NULL,NULL),(935,'169.254.3.168',1,1,NULL,NULL,NULL),(936,'169.254.3.169',1,1,NULL,NULL,NULL),(937,'169.254.3.170',1,1,NULL,NULL,NULL),(938,'169.254.3.171',1,1,NULL,NULL,NULL),(939,'169.254.3.172',1,1,NULL,NULL,NULL),(940,'169.254.3.173',1,1,NULL,NULL,NULL),(941,'169.254.3.174',1,1,NULL,NULL,NULL),(942,'169.254.3.175',1,1,NULL,NULL,NULL),(943,'169.254.3.176',1,1,NULL,NULL,NULL),(944,'169.254.3.177',1,1,NULL,NULL,NULL),(945,'169.254.3.178',1,1,NULL,NULL,NULL),(946,'169.254.3.179',1,1,NULL,NULL,NULL),(947,'169.254.3.180',1,1,NULL,NULL,NULL),(948,'169.254.3.181',1,1,NULL,NULL,NULL),(949,'169.254.3.182',1,1,NULL,NULL,NULL),(950,'169.254.3.183',1,1,NULL,NULL,NULL),(951,'169.254.3.184',1,1,NULL,NULL,NULL),(952,'169.254.3.185',1,1,NULL,NULL,NULL),(953,'169.254.3.186',1,1,NULL,NULL,NULL),(954,'169.254.3.187',1,1,NULL,NULL,NULL),(955,'169.254.3.188',1,1,NULL,NULL,NULL),(956,'169.254.3.189',1,1,NULL,NULL,NULL),(957,'169.254.3.190',1,1,NULL,NULL,NULL),(958,'169.254.3.191',1,1,NULL,NULL,NULL),(959,'169.254.3.192',1,1,NULL,NULL,NULL),(960,'169.254.3.193',1,1,NULL,NULL,NULL),(961,'169.254.3.194',1,1,NULL,NULL,NULL),(962,'169.254.3.195',1,1,NULL,NULL,NULL),(963,'169.254.3.196',1,1,NULL,NULL,NULL),(964,'169.254.3.197',1,1,NULL,NULL,NULL),(965,'169.254.3.198',1,1,NULL,NULL,NULL),(966,'169.254.3.199',1,1,NULL,NULL,NULL),(967,'169.254.3.200',1,1,NULL,NULL,NULL),(968,'169.254.3.201',1,1,NULL,NULL,NULL),(969,'169.254.3.202',1,1,NULL,NULL,NULL),(970,'169.254.3.203',1,1,NULL,NULL,NULL),(971,'169.254.3.204',1,1,NULL,NULL,NULL),(972,'169.254.3.205',1,1,NULL,NULL,NULL),(973,'169.254.3.206',1,1,NULL,NULL,NULL),(974,'169.254.3.207',1,1,NULL,NULL,NULL),(975,'169.254.3.208',1,1,NULL,NULL,NULL),(976,'169.254.3.209',1,1,NULL,NULL,NULL),(977,'169.254.3.210',1,1,NULL,NULL,NULL),(978,'169.254.3.211',1,1,NULL,NULL,NULL),(979,'169.254.3.212',1,1,NULL,NULL,NULL),(980,'169.254.3.213',1,1,NULL,NULL,NULL),(981,'169.254.3.214',1,1,NULL,NULL,NULL),(982,'169.254.3.215',1,1,NULL,NULL,NULL),(983,'169.254.3.216',1,1,NULL,NULL,NULL),(984,'169.254.3.217',1,1,NULL,NULL,NULL),(985,'169.254.3.218',1,1,NULL,NULL,NULL),(986,'169.254.3.219',1,1,NULL,NULL,NULL),(987,'169.254.3.220',1,1,NULL,NULL,NULL),(988,'169.254.3.221',1,1,NULL,NULL,NULL),(989,'169.254.3.222',1,1,NULL,NULL,NULL),(990,'169.254.3.223',1,1,NULL,NULL,NULL),(991,'169.254.3.224',1,1,NULL,NULL,NULL),(992,'169.254.3.225',1,1,NULL,NULL,NULL),(993,'169.254.3.226',1,1,NULL,NULL,NULL),(994,'169.254.3.227',1,1,NULL,NULL,NULL),(995,'169.254.3.228',1,1,NULL,NULL,NULL),(996,'169.254.3.229',1,1,NULL,NULL,NULL),(997,'169.254.3.230',1,1,NULL,NULL,NULL),(998,'169.254.3.231',1,1,NULL,NULL,NULL),(999,'169.254.3.232',1,1,NULL,NULL,NULL),(1000,'169.254.3.233',1,1,NULL,NULL,NULL),(1001,'169.254.3.234',1,1,NULL,NULL,NULL),(1002,'169.254.3.235',1,1,NULL,NULL,NULL),(1003,'169.254.3.236',1,1,NULL,NULL,NULL),(1004,'169.254.3.237',1,1,NULL,NULL,NULL),(1005,'169.254.3.238',1,1,NULL,NULL,NULL),(1006,'169.254.3.239',1,1,NULL,NULL,NULL),(1007,'169.254.3.240',1,1,NULL,NULL,NULL),(1008,'169.254.3.241',1,1,NULL,NULL,NULL),(1009,'169.254.3.242',1,1,NULL,NULL,NULL),(1010,'169.254.3.243',1,1,NULL,NULL,NULL),(1011,'169.254.3.244',1,1,NULL,NULL,NULL),(1012,'169.254.3.245',1,1,NULL,NULL,NULL),(1013,'169.254.3.246',1,1,NULL,NULL,NULL),(1014,'169.254.3.247',1,1,NULL,NULL,NULL),(1015,'169.254.3.248',1,1,NULL,NULL,NULL),(1016,'169.254.3.249',1,1,NULL,NULL,NULL),(1017,'169.254.3.250',1,1,NULL,NULL,NULL),(1018,'169.254.3.251',1,1,NULL,NULL,NULL),(1019,'169.254.3.252',1,1,NULL,NULL,NULL),(1020,'169.254.3.253',1,1,NULL,NULL,NULL),(1021,'169.254.3.254',1,1,NULL,NULL,NULL);
/*!40000 ALTER TABLE `op_dc_link_local_ip_address_alloc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `op_dc_storage_network_ip_address`
--

DROP TABLE IF EXISTS `op_dc_storage_network_ip_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `op_dc_storage_network_ip_address` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `range_id` bigint(20) unsigned NOT NULL COMMENT 'id of ip range in dc_storage_network_ip_range',
  `ip_address` char(40) NOT NULL COMMENT 'ip address',
  `mac_address` bigint(20) unsigned NOT NULL COMMENT 'mac address for storage ips',
  `taken` datetime DEFAULT NULL COMMENT 'Date taken',
  PRIMARY KEY (`id`),
  KEY `fk_storage_ip_address__range_id` (`range_id`),
  CONSTRAINT `fk_storage_ip_address__range_id` FOREIGN KEY (`range_id`) REFERENCES `dc_storage_network_ip_range` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `op_dc_storage_network_ip_address`
--

LOCK TABLES `op_dc_storage_network_ip_address` WRITE;
/*!40000 ALTER TABLE `op_dc_storage_network_ip_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `op_dc_storage_network_ip_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `op_dc_vnet_alloc`
--

DROP TABLE IF EXISTS `op_dc_vnet_alloc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `op_dc_vnet_alloc` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary id',
  `vnet` varchar(18) NOT NULL COMMENT 'vnet',
  `physical_network_id` bigint(20) unsigned NOT NULL COMMENT 'physical network the vnet belongs to',
  `data_center_id` bigint(20) unsigned NOT NULL COMMENT 'data center the vnet belongs to',
  `reservation_id` char(40) DEFAULT NULL COMMENT 'reservation id',
  `account_id` bigint(20) unsigned DEFAULT NULL COMMENT 'account the vnet belongs to right now',
  `taken` datetime DEFAULT NULL COMMENT 'Date taken',
  `account_vnet_map_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `i_op_dc_vnet_alloc__vnet__data_center_id` (`vnet`,`physical_network_id`,`data_center_id`),
  KEY `i_op_dc_vnet_alloc__dc_taken` (`data_center_id`,`taken`),
  KEY `fk_op_dc_vnet_alloc__physical_network_id` (`physical_network_id`),
  KEY `fk_op_dc_vnet_alloc__account_vnet_map_id` (`account_vnet_map_id`),
  CONSTRAINT `fk_op_dc_vnet_alloc__account_vnet_map_id` FOREIGN KEY (`account_vnet_map_id`) REFERENCES `account_vnet_map` (`id`),
  CONSTRAINT `fk_op_dc_vnet_alloc__data_center_id` FOREIGN KEY (`data_center_id`) REFERENCES `data_center` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_op_dc_vnet_alloc__physical_network_id` FOREIGN KEY (`physical_network_id`) REFERENCES `physical_network` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `op_dc_vnet_alloc`
--

LOCK TABLES `op_dc_vnet_alloc` WRITE;
/*!40000 ALTER TABLE `op_dc_vnet_alloc` DISABLE KEYS */;
INSERT INTO `op_dc_vnet_alloc` VALUES (1,'159',200,1,NULL,NULL,NULL,NULL),(2,'158',200,1,NULL,NULL,NULL,NULL),(3,'157',200,1,NULL,NULL,NULL,NULL),(4,'156',200,1,NULL,NULL,NULL,NULL),(5,'155',200,1,NULL,NULL,NULL,NULL),(6,'154',200,1,NULL,NULL,NULL,NULL),(7,'152',200,1,NULL,NULL,NULL,NULL),(8,'153',200,1,NULL,NULL,NULL,NULL),(9,'150',200,1,NULL,NULL,NULL,NULL),(10,'151',200,1,NULL,NULL,NULL,NULL),(11,'200',200,1,NULL,NULL,NULL,NULL),(12,'169',200,1,NULL,NULL,NULL,NULL),(13,'166',200,1,NULL,NULL,NULL,NULL),(14,'165',200,1,NULL,NULL,NULL,NULL),(15,'168',200,1,NULL,NULL,NULL,NULL),(16,'167',200,1,NULL,NULL,NULL,NULL),(17,'161',200,1,NULL,NULL,NULL,NULL),(18,'162',200,1,NULL,NULL,NULL,NULL),(19,'163',200,1,NULL,NULL,NULL,NULL),(20,'164',200,1,NULL,NULL,NULL,NULL),(21,'160',200,1,NULL,NULL,NULL,NULL),(22,'179',200,1,NULL,NULL,NULL,NULL),(23,'178',200,1,NULL,NULL,NULL,NULL),(24,'177',200,1,NULL,NULL,NULL,NULL),(25,'176',200,1,NULL,NULL,NULL,NULL),(26,'170',200,1,NULL,NULL,NULL,NULL),(27,'171',200,1,NULL,NULL,NULL,NULL),(28,'174',200,1,NULL,NULL,NULL,NULL),(29,'109',200,1,NULL,NULL,NULL,NULL),(30,'175',200,1,NULL,NULL,NULL,NULL),(31,'108',200,1,NULL,NULL,NULL,NULL),(32,'172',200,1,NULL,NULL,NULL,NULL),(33,'107',200,1,NULL,NULL,NULL,NULL),(34,'173',200,1,NULL,NULL,NULL,NULL),(35,'106',200,1,NULL,NULL,NULL,NULL),(36,'105',200,1,NULL,NULL,NULL,NULL),(37,'104',200,1,NULL,NULL,NULL,NULL),(38,'103',200,1,NULL,NULL,NULL,NULL),(39,'102',200,1,NULL,NULL,NULL,NULL),(40,'101',200,1,NULL,NULL,NULL,NULL),(41,'100',200,1,NULL,NULL,NULL,NULL),(42,'188',200,1,NULL,NULL,NULL,NULL),(43,'187',200,1,NULL,NULL,NULL,NULL),(44,'189',200,1,NULL,NULL,NULL,NULL),(45,'180',200,1,NULL,NULL,NULL,NULL),(46,'181',200,1,NULL,NULL,NULL,NULL),(47,'182',200,1,NULL,NULL,NULL,NULL),(48,'183',200,1,NULL,NULL,NULL,NULL),(49,'184',200,1,NULL,NULL,NULL,NULL),(50,'185',200,1,NULL,NULL,NULL,NULL),(51,'186',200,1,NULL,NULL,NULL,NULL),(52,'116',200,1,NULL,NULL,NULL,NULL),(53,'117',200,1,NULL,NULL,NULL,NULL),(54,'114',200,1,NULL,NULL,NULL,NULL),(55,'115',200,1,NULL,NULL,NULL,NULL),(56,'112',200,1,NULL,NULL,NULL,NULL),(57,'113',200,1,NULL,NULL,NULL,NULL),(58,'110',200,1,NULL,NULL,NULL,NULL),(59,'111',200,1,NULL,NULL,NULL,NULL),(60,'195',200,1,NULL,NULL,NULL,NULL),(61,'194',200,1,NULL,NULL,NULL,NULL),(62,'197',200,1,NULL,NULL,NULL,NULL),(63,'196',200,1,NULL,NULL,NULL,NULL),(64,'191',200,1,NULL,NULL,NULL,NULL),(65,'190',200,1,NULL,NULL,NULL,NULL),(66,'118',200,1,NULL,NULL,NULL,NULL),(67,'193',200,1,NULL,NULL,NULL,NULL),(68,'119',200,1,NULL,NULL,NULL,NULL),(69,'192',200,1,NULL,NULL,NULL,NULL),(70,'198',200,1,NULL,NULL,NULL,NULL),(71,'199',200,1,NULL,NULL,NULL,NULL),(72,'125',200,1,NULL,NULL,NULL,NULL),(73,'126',200,1,NULL,NULL,NULL,NULL),(74,'127',200,1,NULL,NULL,NULL,NULL),(75,'128',200,1,NULL,NULL,NULL,NULL),(76,'121',200,1,NULL,NULL,NULL,NULL),(77,'122',200,1,NULL,NULL,NULL,NULL),(78,'123',200,1,NULL,NULL,NULL,NULL),(79,'124',200,1,NULL,NULL,NULL,NULL),(80,'129',200,1,NULL,NULL,NULL,NULL),(81,'120',200,1,NULL,NULL,NULL,NULL),(82,'134',200,1,NULL,NULL,NULL,NULL),(83,'135',200,1,NULL,NULL,NULL,NULL),(84,'132',200,1,NULL,NULL,NULL,NULL),(85,'133',200,1,NULL,NULL,NULL,NULL),(86,'138',200,1,NULL,NULL,NULL,NULL),(87,'139',200,1,NULL,NULL,NULL,NULL),(88,'136',200,1,NULL,NULL,NULL,NULL),(89,'137',200,1,NULL,NULL,NULL,NULL),(90,'131',200,1,NULL,NULL,NULL,NULL),(91,'130',200,1,NULL,NULL,NULL,NULL),(92,'143',200,1,NULL,NULL,NULL,NULL),(93,'144',200,1,NULL,NULL,NULL,NULL),(94,'145',200,1,NULL,NULL,NULL,NULL),(95,'146',200,1,NULL,NULL,NULL,NULL),(96,'147',200,1,NULL,NULL,NULL,NULL),(97,'148',200,1,NULL,NULL,NULL,NULL),(98,'149',200,1,NULL,NULL,NULL,NULL),(99,'140',200,1,NULL,NULL,NULL,NULL),(100,'142',200,1,NULL,NULL,NULL,NULL),(101,'141',200,1,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `op_dc_vnet_alloc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `op_ha_work`
--

DROP TABLE IF EXISTS `op_ha_work`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `op_ha_work` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `instance_id` bigint(20) unsigned NOT NULL COMMENT 'vm instance that needs to be ha.',
  `type` varchar(32) NOT NULL COMMENT 'type of work',
  `vm_type` varchar(32) NOT NULL COMMENT 'VM type',
  `state` varchar(32) NOT NULL COMMENT 'state of the vm instance when this happened.',
  `mgmt_server_id` bigint(20) unsigned DEFAULT NULL COMMENT 'management server that has taken up the work of doing ha',
  `host_id` bigint(20) unsigned DEFAULT NULL COMMENT 'host that the vm is suppose to be on',
  `created` datetime NOT NULL COMMENT 'time the entry was requested',
  `tried` int(10) unsigned DEFAULT NULL COMMENT '# of times tried',
  `taken` datetime DEFAULT NULL COMMENT 'time it was taken by the management server',
  `step` varchar(32) NOT NULL COMMENT 'Step in the work',
  `time_to_try` bigint(20) DEFAULT NULL COMMENT 'time to try do this work',
  `updated` bigint(20) unsigned NOT NULL COMMENT 'time the VM state was updated when it was stored into work queue',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `i_op_ha_work__instance_id` (`instance_id`),
  KEY `i_op_ha_work__host_id` (`host_id`),
  KEY `i_op_ha_work__step` (`step`),
  KEY `i_op_ha_work__type` (`type`),
  KEY `i_op_ha_work__mgmt_server_id` (`mgmt_server_id`),
  CONSTRAINT `fk_op_ha_work__instance_id` FOREIGN KEY (`instance_id`) REFERENCES `vm_instance` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_op_ha_work__host_id` FOREIGN KEY (`host_id`) REFERENCES `host` (`id`),
  CONSTRAINT `fk_op_ha_work__mgmt_server_id` FOREIGN KEY (`mgmt_server_id`) REFERENCES `mshost` (`msid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `op_ha_work`
--

LOCK TABLES `op_ha_work` WRITE;
/*!40000 ALTER TABLE `op_ha_work` DISABLE KEYS */;
/*!40000 ALTER TABLE `op_ha_work` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `op_host`
--

DROP TABLE IF EXISTS `op_host`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `op_host` (
  `id` bigint(20) unsigned NOT NULL COMMENT 'host id',
  `sequence` bigint(20) unsigned NOT NULL DEFAULT '1' COMMENT 'sequence for the host communication',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  CONSTRAINT `fk_op_host__id` FOREIGN KEY (`id`) REFERENCES `host` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `op_host`
--

LOCK TABLES `op_host` WRITE;
/*!40000 ALTER TABLE `op_host` DISABLE KEYS */;
INSERT INTO `op_host` VALUES (1,1),(2,1),(3,1),(4,1);
/*!40000 ALTER TABLE `op_host` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `op_host_capacity`
--

DROP TABLE IF EXISTS `op_host_capacity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `op_host_capacity` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `host_id` bigint(20) unsigned DEFAULT NULL,
  `data_center_id` bigint(20) unsigned NOT NULL,
  `pod_id` bigint(20) unsigned DEFAULT NULL,
  `cluster_id` bigint(20) unsigned DEFAULT NULL COMMENT 'foreign key to cluster',
  `used_capacity` bigint(20) NOT NULL,
  `reserved_capacity` bigint(20) NOT NULL,
  `total_capacity` bigint(20) NOT NULL,
  `capacity_type` int(1) unsigned NOT NULL,
  `capacity_state` varchar(32) NOT NULL DEFAULT 'Enabled' COMMENT 'Is this capacity enabled for allocation for new resources',
  `update_time` datetime DEFAULT NULL COMMENT 'time the capacity was last updated',
  `created` datetime DEFAULT NULL COMMENT 'date created',
  PRIMARY KEY (`id`),
  KEY `i_op_host_capacity__host_type` (`host_id`,`capacity_type`),
  KEY `i_op_host_capacity__pod_id` (`pod_id`),
  KEY `i_op_host_capacity__data_center_id` (`data_center_id`),
  KEY `i_op_host_capacity__cluster_id` (`cluster_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `op_host_capacity`
--

LOCK TABLES `op_host_capacity` WRITE;
/*!40000 ALTER TABLE `op_host_capacity` DISABLE KEYS */;
INSERT INTO `op_host_capacity` VALUES (1,NULL,1,NULL,NULL,0,0,0,4,'Enabled','2014-06-26 02:25:07','2014-06-26 02:25:07'),(2,NULL,1,NULL,NULL,0,0,0,8,'Enabled','2014-06-26 02:25:07','2014-06-26 02:25:07'),(3,NULL,1,NULL,NULL,0,0,0,7,'Enabled','2014-06-26 02:25:07','2014-06-26 02:25:07'),(4,1,1,1,1,1073741824,0,8589934592,0,'Enabled','2014-06-26 02:27:59','2014-06-26 02:25:26'),(5,1,1,1,1,500,0,32000,1,'Enabled','2014-06-26 02:27:59','2014-06-26 02:25:26'),(6,2,1,1,1,0,0,8589934592,0,'Enabled','2014-06-26 02:25:26','2014-06-26 02:25:26'),(7,2,1,1,1,0,0,32000,1,'Enabled','2014-06-26 02:25:26','2014-06-26 02:25:26'),(8,1,1,1,1,0,0,2199023255552,3,'Enabled','2014-06-26 02:26:26','2014-06-26 02:26:26'),(9,2,1,1,1,0,0,2199023255552,3,'Enabled','2014-06-26 02:26:26','2014-06-26 02:26:26'),(10,3,1,1,2,536870912,0,8589934592,0,'Enabled','2014-06-26 02:27:59','2014-06-26 02:26:26'),(11,3,1,1,2,500,0,32000,1,'Enabled','2014-06-26 02:27:59','2014-06-26 02:26:26'),(12,3,1,1,2,0,0,2199023255552,3,'Enabled','2014-06-26 02:27:27','2014-06-26 02:27:27');
/*!40000 ALTER TABLE `op_host_capacity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `op_host_planner_reservation`
--

DROP TABLE IF EXISTS `op_host_planner_reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `op_host_planner_reservation` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `data_center_id` bigint(20) unsigned NOT NULL,
  `pod_id` bigint(20) unsigned DEFAULT NULL,
  `cluster_id` bigint(20) unsigned DEFAULT NULL,
  `host_id` bigint(20) unsigned DEFAULT NULL,
  `resource_usage` varchar(255) DEFAULT NULL COMMENT 'Shared(between planners) Vs Dedicated (exclusive usage to a planner)',
  PRIMARY KEY (`id`),
  KEY `i_op_host_planner_reservation__host_resource_usage` (`host_id`,`resource_usage`),
  KEY `fk_planner_reservation__data_center_id` (`data_center_id`),
  KEY `fk_planner_reservation__pod_id` (`pod_id`),
  KEY `fk_planner_reservation__cluster_id` (`cluster_id`),
  CONSTRAINT `fk_planner_reservation__host_id` FOREIGN KEY (`host_id`) REFERENCES `host` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_planner_reservation__data_center_id` FOREIGN KEY (`data_center_id`) REFERENCES `data_center` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_planner_reservation__pod_id` FOREIGN KEY (`pod_id`) REFERENCES `host_pod_ref` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_planner_reservation__cluster_id` FOREIGN KEY (`cluster_id`) REFERENCES `cluster` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `op_host_planner_reservation`
--

LOCK TABLES `op_host_planner_reservation` WRITE;
/*!40000 ALTER TABLE `op_host_planner_reservation` DISABLE KEYS */;
INSERT INTO `op_host_planner_reservation` VALUES (1,1,1,1,1,'Shared'),(2,1,1,1,2,NULL),(3,1,1,2,3,'Shared');
/*!40000 ALTER TABLE `op_host_planner_reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `op_host_transfer`
--

DROP TABLE IF EXISTS `op_host_transfer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `op_host_transfer` (
  `id` bigint(20) unsigned NOT NULL COMMENT 'Id of the host',
  `initial_mgmt_server_id` bigint(20) unsigned DEFAULT NULL COMMENT 'management server the host is transfered from',
  `future_mgmt_server_id` bigint(20) unsigned DEFAULT NULL COMMENT 'management server the host is transfered to',
  `state` varchar(32) NOT NULL COMMENT 'the transfer state of the host',
  `created` datetime NOT NULL COMMENT 'date created',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `fk_op_host_transfer__initial_mgmt_server_id` (`initial_mgmt_server_id`),
  KEY `fk_op_host_transfer__future_mgmt_server_id` (`future_mgmt_server_id`),
  CONSTRAINT `fk_op_host_transfer__id` FOREIGN KEY (`id`) REFERENCES `host` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_op_host_transfer__initial_mgmt_server_id` FOREIGN KEY (`initial_mgmt_server_id`) REFERENCES `mshost` (`msid`),
  CONSTRAINT `fk_op_host_transfer__future_mgmt_server_id` FOREIGN KEY (`future_mgmt_server_id`) REFERENCES `mshost` (`msid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `op_host_transfer`
--

LOCK TABLES `op_host_transfer` WRITE;
/*!40000 ALTER TABLE `op_host_transfer` DISABLE KEYS */;
/*!40000 ALTER TABLE `op_host_transfer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `op_host_upgrade`
--

DROP TABLE IF EXISTS `op_host_upgrade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `op_host_upgrade` (
  `host_id` bigint(20) unsigned NOT NULL COMMENT 'host id',
  `version` varchar(20) NOT NULL COMMENT 'version',
  `state` varchar(20) NOT NULL COMMENT 'state',
  PRIMARY KEY (`host_id`),
  UNIQUE KEY `host_id` (`host_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `op_host_upgrade`
--

LOCK TABLES `op_host_upgrade` WRITE;
/*!40000 ALTER TABLE `op_host_upgrade` DISABLE KEYS */;
/*!40000 ALTER TABLE `op_host_upgrade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `op_it_work`
--

DROP TABLE IF EXISTS `op_it_work`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `op_it_work` (
  `id` char(40) NOT NULL DEFAULT '' COMMENT 'reservation id',
  `mgmt_server_id` bigint(20) unsigned DEFAULT NULL COMMENT 'management server id',
  `created_at` bigint(20) unsigned NOT NULL COMMENT 'when was this work detail created',
  `thread` varchar(255) NOT NULL COMMENT 'thread name',
  `type` char(32) NOT NULL COMMENT 'type of work',
  `vm_type` char(32) NOT NULL COMMENT 'type of vm',
  `step` char(32) NOT NULL COMMENT 'state',
  `updated_at` bigint(20) unsigned NOT NULL COMMENT 'time it was taken over',
  `instance_id` bigint(20) unsigned NOT NULL COMMENT 'vm instance',
  `resource_type` char(32) DEFAULT NULL COMMENT 'type of resource being worked on',
  `resource_id` bigint(20) unsigned DEFAULT NULL COMMENT 'resource id being worked on',
  PRIMARY KEY (`id`),
  KEY `fk_op_it_work__mgmt_server_id` (`mgmt_server_id`),
  KEY `fk_op_it_work__instance_id` (`instance_id`),
  KEY `i_op_it_work__step` (`step`),
  CONSTRAINT `fk_op_it_work__mgmt_server_id` FOREIGN KEY (`mgmt_server_id`) REFERENCES `mshost` (`msid`),
  CONSTRAINT `fk_op_it_work__instance_id` FOREIGN KEY (`instance_id`) REFERENCES `vm_instance` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `op_it_work`
--

LOCK TABLES `op_it_work` WRITE;
/*!40000 ALTER TABLE `op_it_work` DISABLE KEYS */;
INSERT INTO `op_it_work` VALUES ('757c5413-7e8f-4a79-9e93-04be9c524687',4278190080,1403749662,'Work-Job-Executor-2','Starting','SecondaryStorageVm','Done',1403749662,2,NULL,0),('84d9c349-c24b-4df6-a59a-e5e0fa33c96b',4278190080,1403749662,'Work-Job-Executor-1','Starting','ConsoleProxy','Done',1403749662,1,NULL,0);
/*!40000 ALTER TABLE `op_it_work` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `op_lock`
--

DROP TABLE IF EXISTS `op_lock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `op_lock` (
  `key` varchar(128) NOT NULL COMMENT 'primary key of the table',
  `mac` varchar(17) NOT NULL COMMENT 'management server id of the server that holds this lock',
  `ip` char(40) NOT NULL COMMENT 'name of the thread that holds this lock',
  `thread` varchar(255) NOT NULL COMMENT 'Thread id that acquired this lock',
  `acquired_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Time acquired',
  `waiters` int(11) NOT NULL DEFAULT '0' COMMENT 'How many have the thread acquired this lock (reentrant)',
  PRIMARY KEY (`key`),
  UNIQUE KEY `key` (`key`),
  KEY `i_op_lock__mac_ip_thread` (`mac`,`ip`,`thread`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `op_lock`
--

LOCK TABLES `op_lock` WRITE;
/*!40000 ALTER TABLE `op_lock` DISABLE KEYS */;
/*!40000 ALTER TABLE `op_lock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `op_networks`
--

DROP TABLE IF EXISTS `op_networks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `op_networks` (
  `id` bigint(20) unsigned NOT NULL,
  `mac_address_seq` bigint(20) unsigned NOT NULL DEFAULT '1' COMMENT 'mac address',
  `nics_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '# of nics',
  `gc` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'gc this network or not',
  `check_for_gc` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'check this network for gc or not',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  CONSTRAINT `fk_op_networks__id` FOREIGN KEY (`id`) REFERENCES `networks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `op_networks`
--

LOCK TABLES `op_networks` WRITE;
/*!40000 ALTER TABLE `op_networks` DISABLE KEYS */;
INSERT INTO `op_networks` VALUES (200,1,0,0,0),(201,1,0,0,0),(202,1,0,0,0),(203,1,0,0,0);
/*!40000 ALTER TABLE `op_networks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `op_nwgrp_work`
--

DROP TABLE IF EXISTS `op_nwgrp_work`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `op_nwgrp_work` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `instance_id` bigint(20) unsigned NOT NULL COMMENT 'vm instance that needs rules to be synced.',
  `mgmt_server_id` bigint(20) unsigned DEFAULT NULL COMMENT 'management server that has taken up the work of doing rule sync',
  `created` datetime NOT NULL COMMENT 'time the entry was requested',
  `taken` datetime DEFAULT NULL COMMENT 'time it was taken by the management server',
  `step` varchar(32) NOT NULL COMMENT 'Step in the work',
  `seq_no` bigint(20) unsigned DEFAULT NULL COMMENT 'seq number to be sent to agent, uniquely identifies ruleset update',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `i_op_nwgrp_work__instance_id` (`instance_id`),
  KEY `i_op_nwgrp_work__mgmt_server_id` (`mgmt_server_id`),
  KEY `i_op_nwgrp_work__taken` (`taken`),
  KEY `i_op_nwgrp_work__step` (`step`),
  KEY `i_op_nwgrp_work__seq_no` (`seq_no`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `op_nwgrp_work`
--

LOCK TABLES `op_nwgrp_work` WRITE;
/*!40000 ALTER TABLE `op_nwgrp_work` DISABLE KEYS */;
/*!40000 ALTER TABLE `op_nwgrp_work` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `op_pod_vlan_alloc`
--

DROP TABLE IF EXISTS `op_pod_vlan_alloc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `op_pod_vlan_alloc` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary id',
  `vlan` varchar(18) NOT NULL COMMENT 'vlan id',
  `data_center_id` bigint(20) unsigned NOT NULL COMMENT 'data center the pod belongs to',
  `pod_id` bigint(20) unsigned NOT NULL COMMENT 'pod the vlan belongs to',
  `account_id` bigint(20) unsigned DEFAULT NULL COMMENT 'account the vlan belongs to right now',
  `taken` datetime DEFAULT NULL COMMENT 'Date taken',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `op_pod_vlan_alloc`
--

LOCK TABLES `op_pod_vlan_alloc` WRITE;
/*!40000 ALTER TABLE `op_pod_vlan_alloc` DISABLE KEYS */;
/*!40000 ALTER TABLE `op_pod_vlan_alloc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `op_router_monitoring_services`
--

DROP TABLE IF EXISTS `op_router_monitoring_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `op_router_monitoring_services` (
  `vm_id` bigint(20) unsigned NOT NULL COMMENT 'Primary Key',
  `router_name` varchar(255) NOT NULL COMMENT 'Name of the Virtual Router',
  `last_alert_timestamp` varchar(255) NOT NULL COMMENT 'Timestamp of the last alert received from Virtual Router',
  PRIMARY KEY (`vm_id`),
  UNIQUE KEY `vm_id` (`vm_id`),
  CONSTRAINT `fk_virtual_router__id` FOREIGN KEY (`vm_id`) REFERENCES `vm_instance` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `op_router_monitoring_services`
--

LOCK TABLES `op_router_monitoring_services` WRITE;
/*!40000 ALTER TABLE `op_router_monitoring_services` DISABLE KEYS */;
/*!40000 ALTER TABLE `op_router_monitoring_services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `op_user_stats_log`
--

DROP TABLE IF EXISTS `op_user_stats_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `op_user_stats_log` (
  `user_stats_id` bigint(20) unsigned NOT NULL,
  `net_bytes_received` bigint(20) unsigned NOT NULL DEFAULT '0',
  `net_bytes_sent` bigint(20) unsigned NOT NULL DEFAULT '0',
  `current_bytes_received` bigint(20) unsigned NOT NULL DEFAULT '0',
  `current_bytes_sent` bigint(20) unsigned NOT NULL DEFAULT '0',
  `agg_bytes_received` bigint(20) unsigned NOT NULL DEFAULT '0',
  `agg_bytes_sent` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated` datetime DEFAULT NULL COMMENT 'stats update timestamp',
  UNIQUE KEY `user_stats_id` (`user_stats_id`,`updated`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `op_user_stats_log`
--

LOCK TABLES `op_user_stats_log` WRITE;
/*!40000 ALTER TABLE `op_user_stats_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `op_user_stats_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `op_vm_ruleset_log`
--

DROP TABLE IF EXISTS `op_vm_ruleset_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `op_vm_ruleset_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `instance_id` bigint(20) unsigned NOT NULL COMMENT 'vm instance that needs rules to be synced.',
  `created` datetime NOT NULL COMMENT 'time the entry was requested',
  `logsequence` bigint(20) unsigned DEFAULT NULL COMMENT 'seq number to be sent to agent, uniquely identifies ruleset update',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `u_op_vm_ruleset_log__instance_id` (`instance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `op_vm_ruleset_log`
--

LOCK TABLES `op_vm_ruleset_log` WRITE;
/*!40000 ALTER TABLE `op_vm_ruleset_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `op_vm_ruleset_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `op_vpc_distributed_router_sequence_no`
--

DROP TABLE IF EXISTS `op_vpc_distributed_router_sequence_no`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `op_vpc_distributed_router_sequence_no` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `vpc_id` bigint(20) unsigned NOT NULL COMMENT 'vpc id.',
  `topology_update_sequence_no` bigint(20) unsigned DEFAULT NULL COMMENT 'sequence number to be sent to hypervisor, uniquely identifies a VPC topology update',
  `routing_policy__update_sequence_no` bigint(20) unsigned DEFAULT NULL COMMENT 'sequence number to be sent to hypervisor, uniquely identifies a routing policy update',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `u_op_vpc_distributed_router_sequence_no_vpc_id` (`vpc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `op_vpc_distributed_router_sequence_no`
--

LOCK TABLES `op_vpc_distributed_router_sequence_no` WRITE;
/*!40000 ALTER TABLE `op_vpc_distributed_router_sequence_no` DISABLE KEYS */;
/*!40000 ALTER TABLE `op_vpc_distributed_router_sequence_no` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ovs_providers`
--

DROP TABLE IF EXISTS `ovs_providers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ovs_providers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `nsp_id` bigint(20) unsigned NOT NULL COMMENT 'Network Service Provider ID',
  `uuid` varchar(40) DEFAULT NULL,
  `enabled` int(1) NOT NULL COMMENT 'Enabled or disabled',
  `removed` datetime DEFAULT NULL COMMENT 'date removed if not null',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_ovs_providers__uuid` (`uuid`),
  KEY `fk_ovs_providers__nsp_id` (`nsp_id`),
  CONSTRAINT `fk_ovs_providers__nsp_id` FOREIGN KEY (`nsp_id`) REFERENCES `physical_network_service_providers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ovs_providers`
--

LOCK TABLES `ovs_providers` WRITE;
/*!40000 ALTER TABLE `ovs_providers` DISABLE KEYS */;
/*!40000 ALTER TABLE `ovs_providers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ovs_tunnel_interface`
--

DROP TABLE IF EXISTS `ovs_tunnel_interface`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ovs_tunnel_interface` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ip` varchar(16) DEFAULT NULL,
  `netmask` varchar(16) DEFAULT NULL,
  `mac` varchar(18) DEFAULT NULL,
  `host_id` bigint(20) DEFAULT NULL,
  `label` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ovs_tunnel_interface`
--

LOCK TABLES `ovs_tunnel_interface` WRITE;
/*!40000 ALTER TABLE `ovs_tunnel_interface` DISABLE KEYS */;
INSERT INTO `ovs_tunnel_interface` VALUES (1,'0','0','0',0,'lock');
/*!40000 ALTER TABLE `ovs_tunnel_interface` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ovs_tunnel_network`
--

DROP TABLE IF EXISTS `ovs_tunnel_network`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ovs_tunnel_network` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `from` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'from host id',
  `to` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'to host id',
  `network_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'network identifier',
  `key` int(10) unsigned DEFAULT NULL COMMENT 'gre key',
  `port_name` varchar(32) DEFAULT NULL COMMENT 'in port on open vswitch',
  `state` varchar(16) DEFAULT 'FAILED' COMMENT 'result of tunnel creatation',
  PRIMARY KEY (`from`,`to`,`network_id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ovs_tunnel_network`
--

LOCK TABLES `ovs_tunnel_network` WRITE;
/*!40000 ALTER TABLE `ovs_tunnel_network` DISABLE KEYS */;
INSERT INTO `ovs_tunnel_network` VALUES (1,0,0,0,0,'lock','SUCCESS');
/*!40000 ALTER TABLE `ovs_tunnel_network` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `physical_network`
--

DROP TABLE IF EXISTS `physical_network`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `physical_network` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uuid` varchar(40) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `data_center_id` bigint(20) unsigned NOT NULL COMMENT 'data center id that this physical network belongs to',
  `vnet` varchar(255) DEFAULT NULL,
  `speed` varchar(32) DEFAULT NULL,
  `domain_id` bigint(20) unsigned DEFAULT NULL COMMENT 'foreign key to domain id',
  `broadcast_domain_range` varchar(32) NOT NULL DEFAULT 'POD' COMMENT 'range of broadcast domain : POD/ZONE',
  `state` varchar(32) NOT NULL DEFAULT 'Disabled' COMMENT 'what state is this configuration in',
  `created` datetime DEFAULT NULL COMMENT 'date created',
  `removed` datetime DEFAULT NULL COMMENT 'date removed if not null',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_physical_networks__uuid` (`uuid`),
  KEY `fk_physical_network__data_center_id` (`data_center_id`),
  KEY `fk_physical_network__domain_id` (`domain_id`),
  KEY `i_physical_network__removed` (`removed`),
  CONSTRAINT `fk_physical_network__data_center_id` FOREIGN KEY (`data_center_id`) REFERENCES `data_center` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_physical_network__domain_id` FOREIGN KEY (`domain_id`) REFERENCES `domain` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `physical_network`
--

LOCK TABLES `physical_network` WRITE;
/*!40000 ALTER TABLE `physical_network` DISABLE KEYS */;
INSERT INTO `physical_network` VALUES (200,'2fd65c1e-0d4e-4878-bdd2-a165892f4060','Sandbox-pnet',1,'100-200',NULL,NULL,'ZONE','Enabled','2014-06-26 02:24:47',NULL);
/*!40000 ALTER TABLE `physical_network` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `physical_network_isolation_methods`
--

DROP TABLE IF EXISTS `physical_network_isolation_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `physical_network_isolation_methods` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `physical_network_id` bigint(20) unsigned NOT NULL COMMENT 'id of the physical network',
  `isolation_method` varchar(255) NOT NULL COMMENT 'isolation method(VLAN, L3 or GRE)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `physical_network_id` (`physical_network_id`,`isolation_method`),
  CONSTRAINT `fk_physical_network_imethods__physical_network_id` FOREIGN KEY (`physical_network_id`) REFERENCES `physical_network` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `physical_network_isolation_methods`
--

LOCK TABLES `physical_network_isolation_methods` WRITE;
/*!40000 ALTER TABLE `physical_network_isolation_methods` DISABLE KEYS */;
INSERT INTO `physical_network_isolation_methods` VALUES (1,200,'VLAN');
/*!40000 ALTER TABLE `physical_network_isolation_methods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `physical_network_service_providers`
--

DROP TABLE IF EXISTS `physical_network_service_providers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `physical_network_service_providers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uuid` varchar(40) DEFAULT NULL,
  `physical_network_id` bigint(20) unsigned NOT NULL COMMENT 'id of the physical network',
  `provider_name` varchar(255) NOT NULL COMMENT 'Service Provider name',
  `state` varchar(32) NOT NULL DEFAULT 'Disabled' COMMENT 'provider state',
  `destination_physical_network_id` bigint(20) unsigned DEFAULT NULL COMMENT 'id of the physical network to bridge to',
  `vpn_service_provided` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Is VPN service provided',
  `dhcp_service_provided` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Is DHCP service provided',
  `dns_service_provided` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Is DNS service provided',
  `gateway_service_provided` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Gateway service provided',
  `firewall_service_provided` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Firewall service provided',
  `source_nat_service_provided` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Source NAT service provided',
  `load_balance_service_provided` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Is LB service provided',
  `static_nat_service_provided` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Static NAT service provided',
  `port_forwarding_service_provided` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Port Forwarding service provided',
  `user_data_service_provided` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Is UserData service provided',
  `security_group_service_provided` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Is SG service provided',
  `networkacl_service_provided` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Network ACL service provided',
  `removed` datetime DEFAULT NULL COMMENT 'date removed if not null',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_service_providers__uuid` (`uuid`),
  KEY `fk_pnetwork_service_providers__physical_network_id` (`physical_network_id`),
  CONSTRAINT `fk_pnetwork_service_providers__physical_network_id` FOREIGN KEY (`physical_network_id`) REFERENCES `physical_network` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `physical_network_service_providers`
--

LOCK TABLES `physical_network_service_providers` WRITE;
/*!40000 ALTER TABLE `physical_network_service_providers` DISABLE KEYS */;
INSERT INTO `physical_network_service_providers` VALUES (1,'f8f20235-74d2-4955-82bb-af34aac33465',200,'VirtualRouter','Enabled',0,1,1,1,1,1,1,1,1,1,1,0,0,NULL),(2,'4636994e-1ab2-40b3-b120-90be5ce8e870',200,'SecurityGroupProvider','Disabled',0,0,0,0,0,0,0,0,0,0,0,1,0,NULL),(3,'42898b90-789d-4317-9561-433ba9f88340',200,'VpcVirtualRouter','Enabled',0,1,1,1,1,0,1,1,1,1,1,0,1,NULL),(4,'995e590b-d6e7-4341-9570-fcd96c8c64e4',200,'InternalLbVm','Enabled',0,0,0,0,0,0,0,1,0,0,0,0,0,NULL);
/*!40000 ALTER TABLE `physical_network_service_providers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `physical_network_tags`
--

DROP TABLE IF EXISTS `physical_network_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `physical_network_tags` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `physical_network_id` bigint(20) unsigned NOT NULL COMMENT 'id of the physical network',
  `tag` varchar(255) NOT NULL COMMENT 'tag',
  PRIMARY KEY (`id`),
  UNIQUE KEY `physical_network_id` (`physical_network_id`,`tag`),
  CONSTRAINT `fk_physical_network_tags__physical_network_id` FOREIGN KEY (`physical_network_id`) REFERENCES `physical_network` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `physical_network_tags`
--

LOCK TABLES `physical_network_tags` WRITE;
/*!40000 ALTER TABLE `physical_network_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `physical_network_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `physical_network_traffic_types`
--

DROP TABLE IF EXISTS `physical_network_traffic_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `physical_network_traffic_types` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uuid` varchar(40) DEFAULT NULL,
  `physical_network_id` bigint(20) unsigned NOT NULL COMMENT 'id of the physical network',
  `traffic_type` varchar(32) NOT NULL COMMENT 'type of traffic going through this network',
  `xen_network_label` varchar(255) DEFAULT NULL COMMENT 'The network name label of the physical device dedicated to this traffic on a XenServer host',
  `kvm_network_label` varchar(255) DEFAULT 'cloudbr0' COMMENT 'The network name label of the physical device dedicated to this traffic on a KVM host',
  `vmware_network_label` varchar(255) DEFAULT 'vSwitch0' COMMENT 'The network name label of the physical device dedicated to this traffic on a VMware host',
  `simulator_network_label` varchar(255) DEFAULT NULL COMMENT 'The name labels needed for identifying the simulator',
  `ovm_network_label` varchar(255) DEFAULT NULL COMMENT 'The network name label of the physical device dedicated to this traffic on a Ovm host',
  `vlan` varchar(255) DEFAULT NULL COMMENT 'The vlan tag to be sent down to a VMware host',
  `lxc_network_label` varchar(255) DEFAULT 'cloudbr0' COMMENT 'The network name label of the physical device dedicated to this traffic on a LXC host',
  `hyperv_network_label` varchar(255) DEFAULT NULL COMMENT 'The network name label of the physical device dedicated to this traffic on a HyperV host',
  PRIMARY KEY (`id`),
  UNIQUE KEY `physical_network_id` (`physical_network_id`,`traffic_type`),
  UNIQUE KEY `uc_traffic_types__uuid` (`uuid`),
  CONSTRAINT `fk_physical_network_traffic_types__physical_network_id` FOREIGN KEY (`physical_network_id`) REFERENCES `physical_network` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `physical_network_traffic_types`
--

LOCK TABLES `physical_network_traffic_types` WRITE;
/*!40000 ALTER TABLE `physical_network_traffic_types` DISABLE KEYS */;
INSERT INTO `physical_network_traffic_types` VALUES (1,'7ba337ee-8d5f-4e17-910f-a2cf6c0e80c5',200,'Guest',NULL,NULL,NULL,NULL,NULL,NULL,'cloudbr0',NULL),(2,'e38bc02b-19b0-4876-8353-dcedb6f7b0e5',200,'Management',NULL,NULL,NULL,NULL,NULL,NULL,'cloudbr0',NULL),(3,'72d2f3b1-bd34-4e62-be44-883a91e5206e',200,'Public',NULL,NULL,NULL,NULL,NULL,NULL,'cloudbr0',NULL),(4,'7c193e77-62f1-4665-baf0-6ad509782c77',200,'Storage',NULL,NULL,NULL,NULL,NULL,NULL,'cloudbr0',NULL);
/*!40000 ALTER TABLE `physical_network_traffic_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pod_vlan_map`
--

DROP TABLE IF EXISTS `pod_vlan_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pod_vlan_map` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pod_id` bigint(20) unsigned NOT NULL COMMENT 'pod id. foreign key to pod table',
  `vlan_db_id` bigint(20) unsigned NOT NULL COMMENT 'database id of vlan. foreign key to vlan table',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `i_pod_vlan_map__pod_id` (`pod_id`),
  KEY `i_pod_vlan_map__vlan_id` (`vlan_db_id`),
  CONSTRAINT `fk_pod_vlan_map__pod_id` FOREIGN KEY (`pod_id`) REFERENCES `host_pod_ref` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_pod_vlan_map__vlan_id` FOREIGN KEY (`vlan_db_id`) REFERENCES `vlan` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pod_vlan_map`
--

LOCK TABLES `pod_vlan_map` WRITE;
/*!40000 ALTER TABLE `pod_vlan_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `pod_vlan_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `port_forwarding_rules`
--

DROP TABLE IF EXISTS `port_forwarding_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `port_forwarding_rules` (
  `id` bigint(20) unsigned NOT NULL COMMENT 'id',
  `instance_id` bigint(20) unsigned NOT NULL COMMENT 'vm instance id',
  `dest_ip_address` char(40) NOT NULL COMMENT 'id_address',
  `dest_port_start` int(10) NOT NULL COMMENT 'starting port of the port range to map to',
  `dest_port_end` int(10) NOT NULL COMMENT 'end port of the the port range to map to',
  PRIMARY KEY (`id`),
  KEY `fk_port_forwarding_rules__instance_id` (`instance_id`),
  CONSTRAINT `fk_port_forwarding_rules__id` FOREIGN KEY (`id`) REFERENCES `firewall_rules` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_port_forwarding_rules__instance_id` FOREIGN KEY (`instance_id`) REFERENCES `vm_instance` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `port_forwarding_rules`
--

LOCK TABLES `port_forwarding_rules` WRITE;
/*!40000 ALTER TABLE `port_forwarding_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `port_forwarding_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `port_profile`
--

DROP TABLE IF EXISTS `port_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `port_profile` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uuid` varchar(40) DEFAULT NULL,
  `port_profile_name` varchar(255) DEFAULT NULL,
  `port_mode` varchar(10) DEFAULT NULL,
  `vsm_id` bigint(20) unsigned NOT NULL,
  `trunk_low_vlan_id` int(11) DEFAULT NULL,
  `trunk_high_vlan_id` int(11) DEFAULT NULL,
  `access_vlan_id` int(11) DEFAULT NULL,
  `port_type` varchar(20) NOT NULL,
  `port_binding` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `port_profile`
--

LOCK TABLES `port_profile` WRITE;
/*!40000 ALTER TABLE `port_profile` DISABLE KEYS */;
/*!40000 ALTER TABLE `port_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `portable_ip_address`
--

DROP TABLE IF EXISTS `portable_ip_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portable_ip_address` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` bigint(20) unsigned DEFAULT NULL,
  `domain_id` bigint(20) unsigned DEFAULT NULL,
  `allocated` datetime DEFAULT NULL COMMENT 'Date portable ip was allocated',
  `state` char(32) NOT NULL DEFAULT 'Free' COMMENT 'state of the portable ip address',
  `region_id` int(10) unsigned NOT NULL,
  `vlan` varchar(255) DEFAULT NULL,
  `gateway` varchar(255) DEFAULT NULL,
  `netmask` varchar(255) DEFAULT NULL,
  `portable_ip_address` varchar(255) DEFAULT NULL,
  `portable_ip_range_id` bigint(20) unsigned NOT NULL,
  `data_center_id` bigint(20) unsigned DEFAULT NULL COMMENT 'zone to which portable IP is associated',
  `physical_network_id` bigint(20) unsigned DEFAULT NULL COMMENT 'physical network id in the zone to which portable IP is associated',
  `network_id` bigint(20) unsigned DEFAULT NULL COMMENT 'guest network to which portable ip address is associated with',
  `vpc_id` bigint(20) unsigned DEFAULT NULL COMMENT 'vpc to which portable ip address is associated with',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `fk_portable_ip_address__portable_ip_range_id` (`portable_ip_range_id`),
  KEY `fk_portable_ip_address__region_id` (`region_id`),
  CONSTRAINT `fk_portable_ip_address__portable_ip_range_id` FOREIGN KEY (`portable_ip_range_id`) REFERENCES `portable_ip_range` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_portable_ip_address__region_id` FOREIGN KEY (`region_id`) REFERENCES `region` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portable_ip_address`
--

LOCK TABLES `portable_ip_address` WRITE;
/*!40000 ALTER TABLE `portable_ip_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `portable_ip_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `portable_ip_range`
--

DROP TABLE IF EXISTS `portable_ip_range`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portable_ip_range` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(40) DEFAULT NULL,
  `region_id` int(10) unsigned NOT NULL,
  `vlan_id` varchar(255) DEFAULT NULL,
  `gateway` varchar(255) DEFAULT NULL,
  `netmask` varchar(255) DEFAULT NULL,
  `start_ip` varchar(255) DEFAULT NULL,
  `end_ip` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `fk_portableip__region_id` (`region_id`),
  CONSTRAINT `fk_portableip__region_id` FOREIGN KEY (`region_id`) REFERENCES `region` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portable_ip_range`
--

LOCK TABLES `portable_ip_range` WRITE;
/*!40000 ALTER TABLE `portable_ip_range` DISABLE KEYS */;
/*!40000 ALTER TABLE `portable_ip_range` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `private_ip_address`
--

DROP TABLE IF EXISTS `private_ip_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `private_ip_address` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `ip_address` char(40) NOT NULL COMMENT 'ip address',
  `network_id` bigint(20) unsigned NOT NULL COMMENT 'id of the network ip belongs to',
  `reservation_id` char(40) DEFAULT NULL COMMENT 'reservation id',
  `mac_address` varchar(17) DEFAULT NULL COMMENT 'mac address',
  `vpc_id` bigint(20) unsigned DEFAULT NULL COMMENT 'vpc this ip belongs to',
  `taken` datetime DEFAULT NULL COMMENT 'Date taken',
  `source_nat` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_private_ip_address__vpc_id` (`vpc_id`),
  KEY `fk_private_ip_address__network_id` (`network_id`),
  CONSTRAINT `fk_private_ip_address__network_id` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_private_ip_address__vpc_id` FOREIGN KEY (`vpc_id`) REFERENCES `vpc` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `private_ip_address`
--

LOCK TABLES `private_ip_address` WRITE;
/*!40000 ALTER TABLE `private_ip_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `private_ip_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_account`
--

DROP TABLE IF EXISTS `project_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_account` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` bigint(20) unsigned NOT NULL COMMENT 'account id',
  `account_role` varchar(255) NOT NULL DEFAULT 'Regular' COMMENT 'Account role in the project (Owner or Regular)',
  `project_id` bigint(20) unsigned NOT NULL COMMENT 'project id',
  `project_account_id` bigint(20) unsigned NOT NULL,
  `created` datetime DEFAULT NULL COMMENT 'date created',
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_id` (`account_id`,`project_id`),
  KEY `fk_project_account__project_id` (`project_id`),
  KEY `fk_project_account__project_account_id` (`project_account_id`),
  CONSTRAINT `fk_project_account__account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_project_account__project_id` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_project_account__project_account_id` FOREIGN KEY (`project_account_id`) REFERENCES `account` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_account`
--

LOCK TABLES `project_account` WRITE;
/*!40000 ALTER TABLE `project_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `project_account_view`
--

DROP TABLE IF EXISTS `project_account_view`;
/*!50001 DROP VIEW IF EXISTS `project_account_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `project_account_view` (
  `id` tinyint NOT NULL,
  `account_id` tinyint NOT NULL,
  `account_uuid` tinyint NOT NULL,
  `account_name` tinyint NOT NULL,
  `account_type` tinyint NOT NULL,
  `account_role` tinyint NOT NULL,
  `project_id` tinyint NOT NULL,
  `project_uuid` tinyint NOT NULL,
  `project_name` tinyint NOT NULL,
  `domain_id` tinyint NOT NULL,
  `domain_uuid` tinyint NOT NULL,
  `domain_name` tinyint NOT NULL,
  `domain_path` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `project_invitation_view`
--

DROP TABLE IF EXISTS `project_invitation_view`;
/*!50001 DROP VIEW IF EXISTS `project_invitation_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `project_invitation_view` (
  `id` tinyint NOT NULL,
  `uuid` tinyint NOT NULL,
  `email` tinyint NOT NULL,
  `created` tinyint NOT NULL,
  `state` tinyint NOT NULL,
  `project_id` tinyint NOT NULL,
  `project_uuid` tinyint NOT NULL,
  `project_name` tinyint NOT NULL,
  `account_id` tinyint NOT NULL,
  `account_uuid` tinyint NOT NULL,
  `account_name` tinyint NOT NULL,
  `account_type` tinyint NOT NULL,
  `domain_id` tinyint NOT NULL,
  `domain_uuid` tinyint NOT NULL,
  `domain_name` tinyint NOT NULL,
  `domain_path` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `project_invitations`
--

DROP TABLE IF EXISTS `project_invitations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_invitations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(40) DEFAULT NULL,
  `project_id` bigint(20) unsigned NOT NULL COMMENT 'project id',
  `account_id` bigint(20) unsigned DEFAULT NULL COMMENT 'account id',
  `domain_id` bigint(20) unsigned DEFAULT NULL COMMENT 'domain id',
  `email` varchar(255) DEFAULT NULL COMMENT 'email',
  `token` varchar(255) DEFAULT NULL COMMENT 'token',
  `state` varchar(255) NOT NULL DEFAULT 'Pending' COMMENT 'the state of the invitation',
  `created` datetime DEFAULT NULL COMMENT 'date created',
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_id` (`project_id`,`account_id`),
  UNIQUE KEY `project_id_2` (`project_id`,`email`),
  UNIQUE KEY `project_id_3` (`project_id`,`token`),
  UNIQUE KEY `uc_project_invitations__uuid` (`uuid`),
  KEY `fk_project_invitations__account_id` (`account_id`),
  KEY `fk_project_invitations__domain_id` (`domain_id`),
  CONSTRAINT `fk_project_invitations__account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_project_invitations__domain_id` FOREIGN KEY (`domain_id`) REFERENCES `domain` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_project_invitations__project_id` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_invitations`
--

LOCK TABLES `project_invitations` WRITE;
/*!40000 ALTER TABLE `project_invitations` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_invitations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `project_view`
--

DROP TABLE IF EXISTS `project_view`;
/*!50001 DROP VIEW IF EXISTS `project_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `project_view` (
  `id` tinyint NOT NULL,
  `uuid` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `display_text` tinyint NOT NULL,
  `state` tinyint NOT NULL,
  `removed` tinyint NOT NULL,
  `created` tinyint NOT NULL,
  `project_account_id` tinyint NOT NULL,
  `owner` tinyint NOT NULL,
  `account_id` tinyint NOT NULL,
  `domain_id` tinyint NOT NULL,
  `domain_uuid` tinyint NOT NULL,
  `domain_name` tinyint NOT NULL,
  `domain_path` tinyint NOT NULL,
  `tag_id` tinyint NOT NULL,
  `tag_uuid` tinyint NOT NULL,
  `tag_key` tinyint NOT NULL,
  `tag_value` tinyint NOT NULL,
  `tag_domain_id` tinyint NOT NULL,
  `tag_account_id` tinyint NOT NULL,
  `tag_resource_id` tinyint NOT NULL,
  `tag_resource_uuid` tinyint NOT NULL,
  `tag_resource_type` tinyint NOT NULL,
  `tag_customer` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projects` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT 'project name',
  `uuid` varchar(40) DEFAULT NULL,
  `display_text` varchar(255) DEFAULT NULL COMMENT 'project name',
  `project_account_id` bigint(20) unsigned NOT NULL,
  `domain_id` bigint(20) unsigned NOT NULL,
  `created` datetime DEFAULT NULL COMMENT 'date created',
  `removed` datetime DEFAULT NULL COMMENT 'date removed',
  `state` varchar(255) NOT NULL COMMENT 'state of the project (Active/Inactive/Suspended)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_projects__uuid` (`uuid`),
  KEY `fk_projects__project_account_id` (`project_account_id`),
  KEY `fk_projects__domain_id` (`domain_id`),
  KEY `i_projects__removed` (`removed`),
  CONSTRAINT `fk_projects__project_account_id` FOREIGN KEY (`project_account_id`) REFERENCES `account` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_projects__domain_id` FOREIGN KEY (`domain_id`) REFERENCES `domain` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `region`
--

DROP TABLE IF EXISTS `region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `region` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `end_point` varchar(255) NOT NULL,
  `portableip_service_enabled` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Portable IP service enalbed in the Region',
  `gslb_service_enabled` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT 'Is GSLB service enalbed in the Region',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `region`
--

LOCK TABLES `region` WRITE;
/*!40000 ALTER TABLE `region` DISABLE KEYS */;
INSERT INTO `region` VALUES (1,'Local','http://localhost:8080/client/',0,1);
/*!40000 ALTER TABLE `region` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `remote_access_vpn`
--

DROP TABLE IF EXISTS `remote_access_vpn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `remote_access_vpn` (
  `vpn_server_addr_id` bigint(20) unsigned NOT NULL,
  `account_id` bigint(20) unsigned NOT NULL,
  `network_id` bigint(20) unsigned DEFAULT NULL,
  `domain_id` bigint(20) unsigned NOT NULL,
  `local_ip` char(40) NOT NULL,
  `ip_range` varchar(32) NOT NULL,
  `ipsec_psk` varchar(256) NOT NULL,
  `state` char(32) NOT NULL,
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uuid` varchar(40) DEFAULT NULL,
  `vpc_id` bigint(20) unsigned DEFAULT NULL,
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'True if the entry can be displayed to the end user',
  PRIMARY KEY (`id`),
  UNIQUE KEY `vpn_server_addr_id` (`vpn_server_addr_id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `fk_remote_access_vpn__account_id` (`account_id`),
  KEY `fk_remote_access_vpn__domain_id` (`domain_id`),
  KEY `fk_remote_access_vpn__network_id` (`network_id`),
  CONSTRAINT `fk_remote_access_vpn__vpn_server_addr_id` FOREIGN KEY (`vpn_server_addr_id`) REFERENCES `user_ip_address` (`id`),
  CONSTRAINT `fk_remote_access_vpn__account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_remote_access_vpn__domain_id` FOREIGN KEY (`domain_id`) REFERENCES `domain` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_remote_access_vpn__network_id` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `remote_access_vpn`
--

LOCK TABLES `remote_access_vpn` WRITE;
/*!40000 ALTER TABLE `remote_access_vpn` DISABLE KEYS */;
/*!40000 ALTER TABLE `remote_access_vpn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `remote_access_vpn_details`
--

DROP TABLE IF EXISTS `remote_access_vpn_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `remote_access_vpn_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `remote_access_vpn_id` bigint(20) unsigned NOT NULL COMMENT 'Remote access vpn id',
  `name` varchar(255) NOT NULL,
  `value` varchar(1024) NOT NULL,
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'True if the detail can be displayed to the end user',
  PRIMARY KEY (`id`),
  KEY `fk_remote_access_vpn_details__remote_access_vpn_id` (`remote_access_vpn_id`),
  CONSTRAINT `fk_remote_access_vpn_details__remote_access_vpn_id` FOREIGN KEY (`remote_access_vpn_id`) REFERENCES `remote_access_vpn` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `remote_access_vpn_details`
--

LOCK TABLES `remote_access_vpn_details` WRITE;
/*!40000 ALTER TABLE `remote_access_vpn_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `remote_access_vpn_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resource_count`
--

DROP TABLE IF EXISTS `resource_count`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_count` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` bigint(20) unsigned DEFAULT NULL,
  `domain_id` bigint(20) unsigned DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `count` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `i_resource_count__type_accountId` (`type`,`account_id`),
  UNIQUE KEY `i_resource_count__type_domaintId` (`type`,`domain_id`),
  KEY `fk_resource_count__account_id` (`account_id`),
  KEY `fk_resource_count__domain_id` (`domain_id`),
  KEY `i_resource_count__type` (`type`),
  CONSTRAINT `fk_resource_count__account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_resource_count__domain_id` FOREIGN KEY (`domain_id`) REFERENCES `domain` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resource_count`
--

LOCK TABLES `resource_count` WRITE;
/*!40000 ALTER TABLE `resource_count` DISABLE KEYS */;
INSERT INTO `resource_count` VALUES (1,1,NULL,'cpu',0),(2,1,NULL,'memory',0),(3,1,NULL,'primary_storage',0),(4,1,NULL,'secondary_storage',0),(5,2,NULL,'cpu',0),(6,2,NULL,'memory',0),(7,2,NULL,'primary_storage',0),(8,2,NULL,'secondary_storage',0),(9,NULL,1,'cpu',0),(10,NULL,1,'memory',0),(11,NULL,1,'primary_storage',0),(12,NULL,1,'secondary_storage',0),(33,NULL,1,'user_vm',0),(34,NULL,1,'public_ip',0),(35,NULL,1,'volume',0),(36,NULL,1,'snapshot',0),(37,NULL,1,'template',0),(38,NULL,1,'project',0),(39,NULL,1,'network',0),(40,NULL,1,'vpc',0),(41,1,NULL,'user_vm',0),(42,1,NULL,'public_ip',0),(43,1,NULL,'volume',0),(44,1,NULL,'snapshot',0),(45,1,NULL,'template',0),(46,1,NULL,'project',0),(47,1,NULL,'network',0),(48,1,NULL,'vpc',0),(49,2,NULL,'user_vm',0),(50,2,NULL,'public_ip',0),(51,2,NULL,'volume',0),(52,2,NULL,'snapshot',0),(53,2,NULL,'template',0),(54,2,NULL,'project',0),(55,2,NULL,'network',0),(56,2,NULL,'vpc',0);
/*!40000 ALTER TABLE `resource_count` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resource_limit`
--

DROP TABLE IF EXISTS `resource_limit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_limit` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `domain_id` bigint(20) unsigned DEFAULT NULL,
  `account_id` bigint(20) unsigned DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `max` bigint(20) NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`),
  KEY `i_resource_limit__domain_id` (`domain_id`),
  KEY `i_resource_limit__account_id` (`account_id`),
  CONSTRAINT `fk_resource_limit__domain_id` FOREIGN KEY (`domain_id`) REFERENCES `domain` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_resource_limit__account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resource_limit`
--

LOCK TABLES `resource_limit` WRITE;
/*!40000 ALTER TABLE `resource_limit` DISABLE KEYS */;
/*!40000 ALTER TABLE `resource_limit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `resource_tag_view`
--

DROP TABLE IF EXISTS `resource_tag_view`;
/*!50001 DROP VIEW IF EXISTS `resource_tag_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `resource_tag_view` (
  `id` tinyint NOT NULL,
  `uuid` tinyint NOT NULL,
  `key` tinyint NOT NULL,
  `value` tinyint NOT NULL,
  `resource_id` tinyint NOT NULL,
  `resource_uuid` tinyint NOT NULL,
  `resource_type` tinyint NOT NULL,
  `customer` tinyint NOT NULL,
  `account_id` tinyint NOT NULL,
  `account_uuid` tinyint NOT NULL,
  `account_name` tinyint NOT NULL,
  `account_type` tinyint NOT NULL,
  `domain_id` tinyint NOT NULL,
  `domain_uuid` tinyint NOT NULL,
  `domain_name` tinyint NOT NULL,
  `domain_path` tinyint NOT NULL,
  `project_id` tinyint NOT NULL,
  `project_uuid` tinyint NOT NULL,
  `project_name` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `resource_tags`
--

DROP TABLE IF EXISTS `resource_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_tags` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uuid` varchar(40) DEFAULT NULL,
  `key` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `resource_id` bigint(20) unsigned NOT NULL,
  `resource_uuid` varchar(40) DEFAULT NULL,
  `resource_type` varchar(255) DEFAULT NULL,
  `customer` varchar(255) DEFAULT NULL,
  `domain_id` bigint(20) unsigned NOT NULL COMMENT 'foreign key to domain id',
  `account_id` bigint(20) unsigned NOT NULL COMMENT 'owner of this network',
  PRIMARY KEY (`id`),
  UNIQUE KEY `i_tags__resource_id__resource_type__key` (`resource_id`,`resource_type`,`key`),
  UNIQUE KEY `uc_resource_tags__uuid` (`uuid`),
  KEY `fk_tags__account_id` (`account_id`),
  KEY `fk_tags__domain_id` (`domain_id`),
  CONSTRAINT `fk_tags__account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `fk_tags__domain_id` FOREIGN KEY (`domain_id`) REFERENCES `domain` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resource_tags`
--

LOCK TABLES `resource_tags` WRITE;
/*!40000 ALTER TABLE `resource_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `resource_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `router_network_ref`
--

DROP TABLE IF EXISTS `router_network_ref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `router_network_ref` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `router_id` bigint(20) unsigned NOT NULL COMMENT 'router id',
  `network_id` bigint(20) unsigned NOT NULL COMMENT 'network id',
  `guest_type` char(32) DEFAULT NULL COMMENT 'type of guest network that can be shared or isolated',
  PRIMARY KEY (`id`),
  UNIQUE KEY `i_router_network_ref__router_id__network_id` (`router_id`,`network_id`),
  KEY `fk_router_network_ref__networks_id` (`network_id`),
  CONSTRAINT `fk_router_network_ref__router_id` FOREIGN KEY (`router_id`) REFERENCES `domain_router` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_router_network_ref__networks_id` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `router_network_ref`
--

LOCK TABLES `router_network_ref` WRITE;
/*!40000 ALTER TABLE `router_network_ref` DISABLE KEYS */;
/*!40000 ALTER TABLE `router_network_ref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `s2s_customer_gateway`
--

DROP TABLE IF EXISTS `s2s_customer_gateway`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `s2s_customer_gateway` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uuid` varchar(40) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `gateway_ip` char(40) NOT NULL,
  `guest_cidr_list` varchar(200) NOT NULL,
  `ipsec_psk` varchar(256) DEFAULT NULL,
  `ike_policy` varchar(30) NOT NULL,
  `esp_policy` varchar(30) NOT NULL,
  `ike_lifetime` int(11) NOT NULL DEFAULT '86400',
  `esp_lifetime` int(11) NOT NULL DEFAULT '3600',
  `dpd` int(1) NOT NULL DEFAULT '0',
  `domain_id` bigint(20) unsigned NOT NULL,
  `account_id` bigint(20) unsigned NOT NULL,
  `removed` datetime DEFAULT NULL COMMENT 'date removed if not null',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_s2s_customer_gateway__uuid` (`uuid`),
  KEY `fk_s2s_customer_gateway__account_id` (`account_id`),
  KEY `fk_s2s_customer_gateway__domain_id` (`domain_id`),
  CONSTRAINT `fk_s2s_customer_gateway__account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_s2s_customer_gateway__domain_id` FOREIGN KEY (`domain_id`) REFERENCES `domain` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `s2s_customer_gateway`
--

LOCK TABLES `s2s_customer_gateway` WRITE;
/*!40000 ALTER TABLE `s2s_customer_gateway` DISABLE KEYS */;
/*!40000 ALTER TABLE `s2s_customer_gateway` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `s2s_customer_gateway_details`
--

DROP TABLE IF EXISTS `s2s_customer_gateway_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `s2s_customer_gateway_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `s2s_customer_gateway_id` bigint(20) unsigned NOT NULL COMMENT 'VPC gateway id',
  `name` varchar(255) NOT NULL,
  `value` varchar(1024) NOT NULL,
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'True if the detail can be displayed to the end user',
  PRIMARY KEY (`id`),
  KEY `fk_s2s_customer_gateway_details__s2s_customer_gateway_id` (`s2s_customer_gateway_id`),
  CONSTRAINT `fk_s2s_customer_gateway_details__s2s_customer_gateway_id` FOREIGN KEY (`s2s_customer_gateway_id`) REFERENCES `s2s_customer_gateway` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `s2s_customer_gateway_details`
--

LOCK TABLES `s2s_customer_gateway_details` WRITE;
/*!40000 ALTER TABLE `s2s_customer_gateway_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `s2s_customer_gateway_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `s2s_vpn_connection`
--

DROP TABLE IF EXISTS `s2s_vpn_connection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `s2s_vpn_connection` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uuid` varchar(40) DEFAULT NULL,
  `vpn_gateway_id` bigint(20) unsigned DEFAULT NULL,
  `customer_gateway_id` bigint(20) unsigned DEFAULT NULL,
  `state` varchar(32) NOT NULL,
  `domain_id` bigint(20) unsigned NOT NULL,
  `account_id` bigint(20) unsigned NOT NULL,
  `created` datetime NOT NULL COMMENT 'date created',
  `removed` datetime DEFAULT NULL COMMENT 'date removed if not null',
  `passive` int(1) unsigned NOT NULL DEFAULT '0',
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'True if the entry can be displayed to the end user',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_s2s_vpn_connection__uuid` (`uuid`),
  KEY `fk_s2s_vpn_connection__vpn_gateway_id` (`vpn_gateway_id`),
  KEY `fk_s2s_vpn_connection__customer_gateway_id` (`customer_gateway_id`),
  KEY `fk_s2s_vpn_connection__account_id` (`account_id`),
  KEY `fk_s2s_vpn_connection__domain_id` (`domain_id`),
  CONSTRAINT `fk_s2s_vpn_connection__account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_s2s_vpn_connection__customer_gateway_id` FOREIGN KEY (`customer_gateway_id`) REFERENCES `s2s_customer_gateway` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_s2s_vpn_connection__domain_id` FOREIGN KEY (`domain_id`) REFERENCES `domain` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_s2s_vpn_connection__vpn_gateway_id` FOREIGN KEY (`vpn_gateway_id`) REFERENCES `s2s_vpn_gateway` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `s2s_vpn_connection`
--

LOCK TABLES `s2s_vpn_connection` WRITE;
/*!40000 ALTER TABLE `s2s_vpn_connection` DISABLE KEYS */;
/*!40000 ALTER TABLE `s2s_vpn_connection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `s2s_vpn_connection_details`
--

DROP TABLE IF EXISTS `s2s_vpn_connection_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `s2s_vpn_connection_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `s2s_vpn_connection_id` bigint(20) unsigned NOT NULL COMMENT 'VPC gateway id',
  `name` varchar(255) NOT NULL,
  `value` varchar(1024) NOT NULL,
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'True if the detail can be displayed to the end user',
  PRIMARY KEY (`id`),
  KEY `fk_s2s_vpn_connection_details__s2s_vpn_connection_id` (`s2s_vpn_connection_id`),
  CONSTRAINT `fk_s2s_vpn_connection_details__s2s_vpn_connection_id` FOREIGN KEY (`s2s_vpn_connection_id`) REFERENCES `s2s_vpn_connection` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `s2s_vpn_connection_details`
--

LOCK TABLES `s2s_vpn_connection_details` WRITE;
/*!40000 ALTER TABLE `s2s_vpn_connection_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `s2s_vpn_connection_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `s2s_vpn_gateway`
--

DROP TABLE IF EXISTS `s2s_vpn_gateway`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `s2s_vpn_gateway` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uuid` varchar(40) DEFAULT NULL,
  `addr_id` bigint(20) unsigned NOT NULL,
  `vpc_id` bigint(20) unsigned NOT NULL,
  `domain_id` bigint(20) unsigned NOT NULL,
  `account_id` bigint(20) unsigned NOT NULL,
  `removed` datetime DEFAULT NULL COMMENT 'date removed if not null',
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'True if the entry can be displayed to the end user',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_s2s_vpn_gateway__uuid` (`uuid`),
  KEY `fk_s2s_vpn_gateway__addr_id` (`addr_id`),
  KEY `fk_s2s_vpn_gateway__vpc_id` (`vpc_id`),
  KEY `fk_s2s_vpn_gateway__account_id` (`account_id`),
  KEY `fk_s2s_vpn_gateway__domain_id` (`domain_id`),
  CONSTRAINT `fk_s2s_vpn_gateway__account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_s2s_vpn_gateway__addr_id` FOREIGN KEY (`addr_id`) REFERENCES `user_ip_address` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_s2s_vpn_gateway__domain_id` FOREIGN KEY (`domain_id`) REFERENCES `domain` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_s2s_vpn_gateway__vpc_id` FOREIGN KEY (`vpc_id`) REFERENCES `vpc` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `s2s_vpn_gateway`
--

LOCK TABLES `s2s_vpn_gateway` WRITE;
/*!40000 ALTER TABLE `s2s_vpn_gateway` DISABLE KEYS */;
/*!40000 ALTER TABLE `s2s_vpn_gateway` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `s2s_vpn_gateway_details`
--

DROP TABLE IF EXISTS `s2s_vpn_gateway_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `s2s_vpn_gateway_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `s2s_vpn_gateway_id` bigint(20) unsigned NOT NULL COMMENT 'VPC gateway id',
  `name` varchar(255) NOT NULL,
  `value` varchar(1024) NOT NULL,
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'True if the detail can be displayed to the end user',
  PRIMARY KEY (`id`),
  KEY `fk_s2s_vpn_gateway_details__s2s_vpn_gateway_id` (`s2s_vpn_gateway_id`),
  CONSTRAINT `fk_s2s_vpn_gateway_details__s2s_vpn_gateway_id` FOREIGN KEY (`s2s_vpn_gateway_id`) REFERENCES `s2s_vpn_gateway` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `s2s_vpn_gateway_details`
--

LOCK TABLES `s2s_vpn_gateway_details` WRITE;
/*!40000 ALTER TABLE `s2s_vpn_gateway_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `s2s_vpn_gateway_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `s3`
--

DROP TABLE IF EXISTS `s3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `s3` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uuid` varchar(40) DEFAULT NULL,
  `access_key` varchar(20) NOT NULL COMMENT ' The S3 access key',
  `secret_key` varchar(40) NOT NULL COMMENT ' The S3 secret key',
  `end_point` varchar(1024) DEFAULT NULL COMMENT ' The S3 host',
  `bucket` varchar(63) NOT NULL COMMENT ' The S3 host',
  `https` tinyint(3) unsigned DEFAULT NULL COMMENT ' Flag indicating whether or not to connect over HTTPS',
  `connection_timeout` int(11) DEFAULT NULL COMMENT ' The amount of time to wait (in milliseconds) when initially establishing a connection before giving up and timing out.',
  `max_error_retry` int(11) DEFAULT NULL COMMENT ' The maximum number of retry attempts for failed retryable requests (ex: 5xx error responses from services).',
  `socket_timeout` int(11) DEFAULT NULL COMMENT ' The amount of time to wait (in milliseconds) for data to be transfered over an established, open connection before the connection times out and is closed.',
  `created` datetime DEFAULT NULL COMMENT 'date the s3 first signed on',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_s3__uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `s3`
--

LOCK TABLES `s3` WRITE;
/*!40000 ALTER TABLE `s3` DISABLE KEYS */;
/*!40000 ALTER TABLE `s3` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `secondary_storage_vm`
--

DROP TABLE IF EXISTS `secondary_storage_vm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `secondary_storage_vm` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `public_mac_address` varchar(17) DEFAULT NULL COMMENT 'mac address of the public facing network card',
  `public_ip_address` char(40) DEFAULT NULL COMMENT 'public ip address for the sec storage vm',
  `public_netmask` varchar(15) DEFAULT NULL COMMENT 'public netmask used for the sec storage vm',
  `guid` varchar(255) DEFAULT NULL COMMENT 'copied from guid of secondary storage host',
  `nfs_share` varchar(255) DEFAULT NULL COMMENT 'server and path exported by the nfs server ',
  `last_update` datetime DEFAULT NULL COMMENT 'Last session update time',
  `role` varchar(64) NOT NULL DEFAULT 'templateProcessor' COMMENT 'work role of secondary storage host(templateProcessor | commandExecutor)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `public_mac_address` (`public_mac_address`),
  CONSTRAINT `fk_secondary_storage_vm__id` FOREIGN KEY (`id`) REFERENCES `vm_instance` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `secondary_storage_vm`
--

LOCK TABLES `secondary_storage_vm` WRITE;
/*!40000 ALTER TABLE `secondary_storage_vm` DISABLE KEYS */;
INSERT INTO `secondary_storage_vm` VALUES (2,'06:f3:82:00:00:c9','192.168.2.3','255.255.255.0',NULL,NULL,NULL,'templateProcessor');
/*!40000 ALTER TABLE `secondary_storage_vm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `security_group`
--

DROP TABLE IF EXISTS `security_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `security_group` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `uuid` varchar(40) DEFAULT NULL,
  `description` varchar(4096) DEFAULT NULL,
  `domain_id` bigint(20) unsigned NOT NULL,
  `account_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`account_id`),
  UNIQUE KEY `uc_security_group__uuid` (`uuid`),
  KEY `fk_security_group__account_id` (`account_id`),
  KEY `fk_security_group__domain_id` (`domain_id`),
  KEY `i_security_group_name` (`name`),
  CONSTRAINT `fk_security_group__account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_security_group__domain_id` FOREIGN KEY (`domain_id`) REFERENCES `domain` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `security_group`
--

LOCK TABLES `security_group` WRITE;
/*!40000 ALTER TABLE `security_group` DISABLE KEYS */;
INSERT INTO `security_group` VALUES (1,'default','d9bbbc70-fcd8-11e3-9019-080027ce083d','Default Security Group',1,2);
/*!40000 ALTER TABLE `security_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `security_group_rule`
--

DROP TABLE IF EXISTS `security_group_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `security_group_rule` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(40) DEFAULT NULL,
  `security_group_id` bigint(20) unsigned NOT NULL,
  `type` varchar(10) DEFAULT 'ingress',
  `start_port` varchar(10) DEFAULT NULL,
  `end_port` varchar(10) DEFAULT NULL,
  `protocol` varchar(16) NOT NULL DEFAULT 'TCP',
  `allowed_network_id` bigint(20) unsigned DEFAULT NULL,
  `allowed_ip_cidr` varchar(44) DEFAULT NULL,
  `create_status` varchar(32) DEFAULT NULL COMMENT 'rule creation status',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_security_group_rule__uuid` (`uuid`),
  KEY `i_security_group_rule_network_id` (`security_group_id`),
  KEY `i_security_group_rule_allowed_network` (`allowed_network_id`),
  CONSTRAINT `fk_security_group_rule___security_group_id` FOREIGN KEY (`security_group_id`) REFERENCES `security_group` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_security_group_rule___allowed_network_id` FOREIGN KEY (`allowed_network_id`) REFERENCES `security_group` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `security_group_rule`
--

LOCK TABLES `security_group_rule` WRITE;
/*!40000 ALTER TABLE `security_group_rule` DISABLE KEYS */;
/*!40000 ALTER TABLE `security_group_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `security_group_view`
--

DROP TABLE IF EXISTS `security_group_view`;
/*!50001 DROP VIEW IF EXISTS `security_group_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `security_group_view` (
  `id` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `description` tinyint NOT NULL,
  `uuid` tinyint NOT NULL,
  `account_id` tinyint NOT NULL,
  `account_uuid` tinyint NOT NULL,
  `account_name` tinyint NOT NULL,
  `account_type` tinyint NOT NULL,
  `domain_id` tinyint NOT NULL,
  `domain_uuid` tinyint NOT NULL,
  `domain_name` tinyint NOT NULL,
  `domain_path` tinyint NOT NULL,
  `project_id` tinyint NOT NULL,
  `project_uuid` tinyint NOT NULL,
  `project_name` tinyint NOT NULL,
  `rule_id` tinyint NOT NULL,
  `rule_uuid` tinyint NOT NULL,
  `rule_type` tinyint NOT NULL,
  `rule_start_port` tinyint NOT NULL,
  `rule_end_port` tinyint NOT NULL,
  `rule_protocol` tinyint NOT NULL,
  `rule_allowed_network_id` tinyint NOT NULL,
  `rule_allowed_ip_cidr` tinyint NOT NULL,
  `rule_create_status` tinyint NOT NULL,
  `tag_id` tinyint NOT NULL,
  `tag_uuid` tinyint NOT NULL,
  `tag_key` tinyint NOT NULL,
  `tag_value` tinyint NOT NULL,
  `tag_domain_id` tinyint NOT NULL,
  `tag_account_id` tinyint NOT NULL,
  `tag_resource_id` tinyint NOT NULL,
  `tag_resource_uuid` tinyint NOT NULL,
  `tag_resource_type` tinyint NOT NULL,
  `tag_customer` tinyint NOT NULL,
  `job_id` tinyint NOT NULL,
  `job_uuid` tinyint NOT NULL,
  `job_status` tinyint NOT NULL,
  `job_account_id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `security_group_vm_map`
--

DROP TABLE IF EXISTS `security_group_vm_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `security_group_vm_map` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `security_group_id` bigint(20) unsigned NOT NULL,
  `instance_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_security_group_vm_map___security_group_id` (`security_group_id`),
  KEY `fk_security_group_vm_map___instance_id` (`instance_id`),
  CONSTRAINT `fk_security_group_vm_map___security_group_id` FOREIGN KEY (`security_group_id`) REFERENCES `security_group` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_security_group_vm_map___instance_id` FOREIGN KEY (`instance_id`) REFERENCES `user_vm` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `security_group_vm_map`
--

LOCK TABLES `security_group_vm_map` WRITE;
/*!40000 ALTER TABLE `security_group_vm_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `security_group_vm_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sequence`
--

DROP TABLE IF EXISTS `sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sequence` (
  `name` varchar(64) NOT NULL COMMENT 'name of the sequence',
  `value` bigint(20) unsigned NOT NULL COMMENT 'sequence value',
  PRIMARY KEY (`name`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sequence`
--

LOCK TABLES `sequence` WRITE;
/*!40000 ALTER TABLE `sequence` DISABLE KEYS */;
INSERT INTO `sequence` VALUES ('checkpoint_seq',1),('networks_seq',204),('physical_networks_seq',201),('private_mac_address_seq',1),('public_mac_address_seq',1),('storage_pool_seq',200),('vm_instance_seq',3),('vm_template_seq',201),('volume_seq',1);
/*!40000 ALTER TABLE `sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_offering`
--

DROP TABLE IF EXISTS `service_offering`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service_offering` (
  `id` bigint(20) unsigned NOT NULL,
  `cpu` int(10) unsigned DEFAULT NULL COMMENT '# of cores',
  `speed` int(10) unsigned DEFAULT NULL COMMENT 'speed per core in mhz',
  `ram_size` bigint(20) unsigned DEFAULT NULL,
  `nw_rate` smallint(5) unsigned DEFAULT '200' COMMENT 'network rate throttle mbits/s',
  `mc_rate` smallint(5) unsigned DEFAULT '10' COMMENT 'mcast rate throttle mbits/s',
  `ha_enabled` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Enable HA',
  `limit_cpu_use` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Limit the CPU usage to service offering',
  `host_tag` varchar(255) DEFAULT NULL COMMENT 'host tag specified by the service_offering',
  `default_use` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'is this offering a default system offering',
  `vm_type` varchar(32) DEFAULT NULL COMMENT 'type of offering specified for system offerings',
  `sort_key` int(32) NOT NULL DEFAULT '0' COMMENT 'sort key used for customising sort method',
  `is_volatile` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'true if the vm needs to be volatile, i.e., on every reboot of vm from API root disk is discarded and creates a new root disk',
  `deployment_planner` varchar(255) DEFAULT NULL COMMENT 'Planner heuristics used to deploy a VM of this offering; if null global config vm.deployment.planner is used',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_service_offering__id` FOREIGN KEY (`id`) REFERENCES `disk_offering` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_offering`
--

LOCK TABLES `service_offering` WRITE;
/*!40000 ALTER TABLE `service_offering` DISABLE KEYS */;
INSERT INTO `service_offering` VALUES (1,1,500,512,NULL,NULL,0,0,NULL,0,NULL,0,0,NULL),(2,1,1000,1024,NULL,NULL,0,0,NULL,0,NULL,0,0,NULL),(7,1,256,128,NULL,NULL,1,0,NULL,1,'internalloadbalancervm',0,0,NULL),(8,1,500,128,NULL,NULL,1,0,NULL,1,'domainrouter',0,0,NULL),(9,1,500,1024,0,0,0,0,NULL,1,'consoleproxy',0,0,NULL),(10,1,500,512,NULL,NULL,0,0,NULL,1,'secondarystoragevm',0,0,NULL),(11,1,128,128,0,0,1,0,NULL,1,'elasticloadbalancervm',0,0,NULL);
/*!40000 ALTER TABLE `service_offering` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_offering_details`
--

DROP TABLE IF EXISTS `service_offering_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service_offering_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `service_offering_id` bigint(20) unsigned NOT NULL COMMENT 'service offering id',
  `name` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'True if the detail can be displayed to the end user',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_service_offering_id_name` (`service_offering_id`,`name`),
  CONSTRAINT `fk_service_offering_details__service_offering_id` FOREIGN KEY (`service_offering_id`) REFERENCES `service_offering` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_offering_details`
--

LOCK TABLES `service_offering_details` WRITE;
/*!40000 ALTER TABLE `service_offering_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `service_offering_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `service_offering_view`
--

DROP TABLE IF EXISTS `service_offering_view`;
/*!50001 DROP VIEW IF EXISTS `service_offering_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `service_offering_view` (
  `id` tinyint NOT NULL,
  `uuid` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `display_text` tinyint NOT NULL,
  `created` tinyint NOT NULL,
  `tags` tinyint NOT NULL,
  `removed` tinyint NOT NULL,
  `use_local_storage` tinyint NOT NULL,
  `system_use` tinyint NOT NULL,
  `customized_iops` tinyint NOT NULL,
  `min_iops` tinyint NOT NULL,
  `max_iops` tinyint NOT NULL,
  `hv_ss_reserve` tinyint NOT NULL,
  `bytes_read_rate` tinyint NOT NULL,
  `bytes_write_rate` tinyint NOT NULL,
  `iops_read_rate` tinyint NOT NULL,
  `iops_write_rate` tinyint NOT NULL,
  `cache_mode` tinyint NOT NULL,
  `cpu` tinyint NOT NULL,
  `speed` tinyint NOT NULL,
  `ram_size` tinyint NOT NULL,
  `nw_rate` tinyint NOT NULL,
  `mc_rate` tinyint NOT NULL,
  `ha_enabled` tinyint NOT NULL,
  `limit_cpu_use` tinyint NOT NULL,
  `host_tag` tinyint NOT NULL,
  `default_use` tinyint NOT NULL,
  `vm_type` tinyint NOT NULL,
  `sort_key` tinyint NOT NULL,
  `is_volatile` tinyint NOT NULL,
  `deployment_planner` tinyint NOT NULL,
  `domain_id` tinyint NOT NULL,
  `domain_uuid` tinyint NOT NULL,
  `domain_name` tinyint NOT NULL,
  `domain_path` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `snapshot_details`
--

DROP TABLE IF EXISTS `snapshot_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `snapshot_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `snapshot_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'True if the detail can be displayed to the end user',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `snapshot_details`
--

LOCK TABLES `snapshot_details` WRITE;
/*!40000 ALTER TABLE `snapshot_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `snapshot_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `snapshot_policy`
--

DROP TABLE IF EXISTS `snapshot_policy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `snapshot_policy` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(40) DEFAULT NULL,
  `volume_id` bigint(20) unsigned NOT NULL,
  `schedule` varchar(100) NOT NULL COMMENT 'schedule time of execution',
  `timezone` varchar(100) NOT NULL COMMENT 'the timezone in which the schedule time is specified',
  `interval` int(4) NOT NULL DEFAULT '4' COMMENT 'backup schedule, e.g. hourly, daily, etc.',
  `max_snaps` int(8) NOT NULL DEFAULT '0' COMMENT 'maximum number of snapshots to maintain',
  `active` tinyint(1) unsigned NOT NULL COMMENT 'Is the policy active',
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'True if the policy can be displayed to the end user',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_snapshot_policy__uuid` (`uuid`),
  KEY `i_snapshot_policy__volume_id` (`volume_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `snapshot_policy`
--

LOCK TABLES `snapshot_policy` WRITE;
/*!40000 ALTER TABLE `snapshot_policy` DISABLE KEYS */;
/*!40000 ALTER TABLE `snapshot_policy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `snapshot_policy_details`
--

DROP TABLE IF EXISTS `snapshot_policy_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `snapshot_policy_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `policy_id` bigint(20) unsigned NOT NULL COMMENT 'snapshot policy id',
  `name` varchar(255) NOT NULL,
  `value` varchar(1024) NOT NULL,
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'True if the detail can be displayed to the end user',
  PRIMARY KEY (`id`),
  KEY `fk_snapshot_policy_details__snapshot_policy_id` (`policy_id`),
  CONSTRAINT `fk_snapshot_policy_details__snapshot_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `snapshot_policy` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `snapshot_policy_details`
--

LOCK TABLES `snapshot_policy_details` WRITE;
/*!40000 ALTER TABLE `snapshot_policy_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `snapshot_policy_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `snapshot_schedule`
--

DROP TABLE IF EXISTS `snapshot_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `snapshot_schedule` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(40) DEFAULT NULL,
  `volume_id` bigint(20) unsigned NOT NULL COMMENT 'The volume for which this snapshot is being taken',
  `policy_id` bigint(20) unsigned NOT NULL COMMENT 'One of the policyIds for which this snapshot was taken',
  `scheduled_timestamp` datetime NOT NULL COMMENT 'Time at which the snapshot was scheduled for execution',
  `async_job_id` bigint(20) unsigned DEFAULT NULL COMMENT 'If this schedule is being executed, it is the id of the create aysnc_job. Before that it is null',
  `snapshot_id` bigint(20) unsigned DEFAULT NULL COMMENT 'If this schedule is being executed, then the corresponding snapshot has this id. Before that it is null',
  PRIMARY KEY (`id`),
  UNIQUE KEY `volume_id` (`volume_id`,`policy_id`),
  UNIQUE KEY `uc_snapshot_schedule__uuid` (`uuid`),
  KEY `i_snapshot_schedule__volume_id` (`volume_id`),
  KEY `i_snapshot_schedule__policy_id` (`policy_id`),
  KEY `i_snapshot_schedule__async_job_id` (`async_job_id`),
  KEY `i_snapshot_schedule__snapshot_id` (`snapshot_id`),
  KEY `i_snapshot_schedule__scheduled_timestamp` (`scheduled_timestamp`),
  CONSTRAINT `fk__snapshot_schedule_volume_id` FOREIGN KEY (`volume_id`) REFERENCES `volumes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk__snapshot_schedule_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `snapshot_policy` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk__snapshot_schedule_async_job_id` FOREIGN KEY (`async_job_id`) REFERENCES `async_job` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk__snapshot_schedule_snapshot_id` FOREIGN KEY (`snapshot_id`) REFERENCES `snapshots` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `snapshot_schedule`
--

LOCK TABLES `snapshot_schedule` WRITE;
/*!40000 ALTER TABLE `snapshot_schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `snapshot_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `snapshot_store_ref`
--

DROP TABLE IF EXISTS `snapshot_store_ref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `snapshot_store_ref` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `store_id` bigint(20) unsigned NOT NULL,
  `snapshot_id` bigint(20) unsigned NOT NULL,
  `created` datetime NOT NULL,
  `last_updated` datetime DEFAULT NULL,
  `job_id` varchar(255) DEFAULT NULL,
  `store_role` varchar(255) DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `physical_size` bigint(20) unsigned DEFAULT '0',
  `parent_snapshot_id` bigint(20) unsigned DEFAULT '0',
  `install_path` varchar(255) DEFAULT NULL,
  `state` varchar(255) NOT NULL,
  `update_count` bigint(20) unsigned DEFAULT NULL,
  `ref_cnt` bigint(20) unsigned DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `volume_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `i_snapshot_store_ref__store_id` (`store_id`),
  KEY `i_snapshot_store_ref__snapshot_id` (`snapshot_id`),
  CONSTRAINT `fk_snapshot_store_ref__snapshot_id` FOREIGN KEY (`snapshot_id`) REFERENCES `snapshots` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `snapshot_store_ref`
--

LOCK TABLES `snapshot_store_ref` WRITE;
/*!40000 ALTER TABLE `snapshot_store_ref` DISABLE KEYS */;
/*!40000 ALTER TABLE `snapshot_store_ref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `snapshots`
--

DROP TABLE IF EXISTS `snapshots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `snapshots` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `data_center_id` bigint(20) unsigned NOT NULL,
  `account_id` bigint(20) unsigned NOT NULL COMMENT 'owner.  foreign key to account table',
  `domain_id` bigint(20) unsigned NOT NULL COMMENT 'the domain that the owner belongs to',
  `volume_id` bigint(20) unsigned NOT NULL COMMENT 'volume it belongs to. foreign key to volume table',
  `disk_offering_id` bigint(20) unsigned NOT NULL COMMENT 'from original volume',
  `status` varchar(32) DEFAULT NULL COMMENT 'snapshot creation status',
  `path` varchar(255) DEFAULT NULL COMMENT 'Path',
  `name` varchar(255) NOT NULL COMMENT 'snapshot name',
  `uuid` varchar(40) DEFAULT NULL,
  `snapshot_type` int(4) NOT NULL COMMENT 'type of snapshot, e.g. manual, recurring',
  `type_description` varchar(25) DEFAULT NULL COMMENT 'description of the type of snapshot, e.g. manual, recurring',
  `size` bigint(20) unsigned NOT NULL COMMENT 'original disk size of snapshot',
  `created` datetime DEFAULT NULL COMMENT 'Date Created',
  `removed` datetime DEFAULT NULL COMMENT 'Date removed.  not null if removed',
  `backup_snap_id` varchar(255) DEFAULT NULL COMMENT 'Back up uuid of the snapshot',
  `swift_id` bigint(20) unsigned DEFAULT NULL COMMENT 'which swift',
  `sechost_id` bigint(20) unsigned DEFAULT NULL COMMENT 'secondary storage host id',
  `prev_snap_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Id of the most recent snapshot',
  `hypervisor_type` varchar(32) NOT NULL COMMENT 'hypervisor that the snapshot was taken under',
  `version` varchar(32) DEFAULT NULL COMMENT 'snapshot version',
  `s3_id` bigint(20) unsigned DEFAULT NULL COMMENT 'S3 to which this snapshot will be stored',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `uc_snapshots__uuid` (`uuid`),
  KEY `i_snapshots__account_id` (`account_id`),
  KEY `i_snapshots__volume_id` (`volume_id`),
  KEY `i_snapshots__name` (`name`),
  KEY `i_snapshots__snapshot_type` (`snapshot_type`),
  KEY `i_snapshots__prev_snap_id` (`prev_snap_id`),
  KEY `i_snapshots__removed` (`removed`),
  KEY `fk_snapshots__s3_id` (`s3_id`),
  CONSTRAINT `fk_snapshots__s3_id` FOREIGN KEY (`s3_id`) REFERENCES `s3` (`id`),
  CONSTRAINT `fk_snapshots__account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `snapshots`
--

LOCK TABLES `snapshots` WRITE;
/*!40000 ALTER TABLE `snapshots` DISABLE KEYS */;
/*!40000 ALTER TABLE `snapshots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ssh_keypairs`
--

DROP TABLE IF EXISTS `ssh_keypairs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ssh_keypairs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `account_id` bigint(20) unsigned NOT NULL COMMENT 'owner, foreign key to account table',
  `domain_id` bigint(20) unsigned NOT NULL COMMENT 'domain, foreign key to domain table',
  `keypair_name` varchar(256) NOT NULL COMMENT 'name of the key pair',
  `fingerprint` varchar(128) NOT NULL COMMENT 'fingerprint for the ssh public key',
  `public_key` varchar(5120) NOT NULL COMMENT 'public key of the ssh key pair',
  PRIMARY KEY (`id`),
  KEY `fk_ssh_keypairs__account_id` (`account_id`),
  KEY `fk_ssh_keypairs__domain_id` (`domain_id`),
  CONSTRAINT `fk_ssh_keypairs__account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ssh_keypairs__domain_id` FOREIGN KEY (`domain_id`) REFERENCES `domain` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ssh_keypairs`
--

LOCK TABLES `ssh_keypairs` WRITE;
/*!40000 ALTER TABLE `ssh_keypairs` DISABLE KEYS */;
/*!40000 ALTER TABLE `ssh_keypairs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sslcerts`
--

DROP TABLE IF EXISTS `sslcerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sslcerts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(40) DEFAULT NULL,
  `account_id` bigint(20) unsigned NOT NULL,
  `domain_id` bigint(20) unsigned NOT NULL,
  `certificate` text NOT NULL,
  `fingerprint` varchar(62) NOT NULL,
  `key` text NOT NULL,
  `chain` text,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_sslcert__account_id` (`account_id`),
  KEY `fk_sslcert__domain_id` (`domain_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sslcerts`
--

LOCK TABLES `sslcerts` WRITE;
/*!40000 ALTER TABLE `sslcerts` DISABLE KEYS */;
/*!40000 ALTER TABLE `sslcerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stack_maid`
--

DROP TABLE IF EXISTS `stack_maid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stack_maid` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `msid` bigint(20) unsigned NOT NULL,
  `thread_id` bigint(20) unsigned NOT NULL,
  `seq` int(10) unsigned NOT NULL,
  `cleanup_delegate` varchar(128) DEFAULT NULL,
  `cleanup_context` text,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `i_stack_maid_msid_thread_id` (`msid`,`thread_id`),
  KEY `i_stack_maid_seq` (`msid`,`seq`),
  KEY `i_stack_maid_created` (`created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stack_maid`
--

LOCK TABLES `stack_maid` WRITE;
/*!40000 ALTER TABLE `stack_maid` DISABLE KEYS */;
/*!40000 ALTER TABLE `stack_maid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `static_routes`
--

DROP TABLE IF EXISTS `static_routes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `static_routes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uuid` varchar(40) DEFAULT NULL,
  `vpc_gateway_id` bigint(20) unsigned DEFAULT NULL COMMENT 'id of the corresponding ip address',
  `cidr` varchar(18) DEFAULT NULL COMMENT 'cidr for the static route',
  `state` char(32) NOT NULL COMMENT 'current state of this rule',
  `vpc_id` bigint(20) unsigned DEFAULT NULL COMMENT 'vpc the firewall rule is associated with',
  `account_id` bigint(20) unsigned NOT NULL COMMENT 'owner id',
  `domain_id` bigint(20) unsigned NOT NULL COMMENT 'domain id',
  `created` datetime DEFAULT NULL COMMENT 'Date created',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_static_routes__uuid` (`uuid`),
  KEY `fk_static_routes__vpc_gateway_id` (`vpc_gateway_id`),
  KEY `fk_static_routes__vpc_id` (`vpc_id`),
  KEY `fk_static_routes__account_id` (`account_id`),
  KEY `fk_static_routes__domain_id` (`domain_id`),
  CONSTRAINT `fk_static_routes__vpc_gateway_id` FOREIGN KEY (`vpc_gateway_id`) REFERENCES `vpc_gateways` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_static_routes__vpc_id` FOREIGN KEY (`vpc_id`) REFERENCES `vpc` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_static_routes__account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_static_routes__domain_id` FOREIGN KEY (`domain_id`) REFERENCES `domain` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `static_routes`
--

LOCK TABLES `static_routes` WRITE;
/*!40000 ALTER TABLE `static_routes` DISABLE KEYS */;
/*!40000 ALTER TABLE `static_routes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `storage_pool`
--

DROP TABLE IF EXISTS `storage_pool`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `storage_pool` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT 'should be NOT NULL',
  `uuid` varchar(255) DEFAULT NULL,
  `pool_type` varchar(32) NOT NULL,
  `port` int(10) unsigned NOT NULL,
  `data_center_id` bigint(20) unsigned NOT NULL,
  `pod_id` bigint(20) unsigned DEFAULT NULL,
  `cluster_id` bigint(20) unsigned DEFAULT NULL COMMENT 'foreign key to cluster',
  `used_bytes` bigint(20) unsigned DEFAULT NULL,
  `capacity_bytes` bigint(20) unsigned DEFAULT NULL,
  `host_address` varchar(255) NOT NULL COMMENT 'FQDN or IP of storage server',
  `user_info` varchar(255) DEFAULT NULL COMMENT 'Authorization information for the storage pool. Used by network filesystems',
  `path` varchar(255) NOT NULL COMMENT 'Filesystem path that is shared',
  `created` datetime DEFAULT NULL COMMENT 'date the pool created',
  `removed` datetime DEFAULT NULL COMMENT 'date removed if not null',
  `update_time` datetime DEFAULT NULL,
  `status` varchar(32) DEFAULT NULL,
  `storage_provider_name` varchar(255) DEFAULT NULL,
  `scope` varchar(255) DEFAULT NULL,
  `hypervisor` varchar(32) DEFAULT NULL,
  `managed` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Should CloudStack manage this storage',
  `capacity_iops` bigint(20) unsigned DEFAULT NULL COMMENT 'IOPS CloudStack can provision from this storage pool',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `id_2` (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `i_storage_pool__pod_id` (`pod_id`),
  KEY `fk_storage_pool__cluster_id` (`cluster_id`),
  KEY `i_storage_pool__removed` (`removed`),
  CONSTRAINT `fk_storage_pool__cluster_id` FOREIGN KEY (`cluster_id`) REFERENCES `cluster` (`id`),
  CONSTRAINT `fk_storage_pool__pod_id` FOREIGN KEY (`pod_id`) REFERENCES `host_pod_ref` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `storage_pool`
--

LOCK TABLES `storage_pool` WRITE;
/*!40000 ALTER TABLE `storage_pool` DISABLE KEYS */;
INSERT INTO `storage_pool` VALUES (1,'PS0','7c07ec9b-a3c6-3466-ab5a-f5669ead0b22','NetworkFilesystem',2049,1,1,1,0,1099511627776,'10.147.28.6',NULL,'/export/home/sandbox/primary0','2014-06-26 02:26:26',NULL,NULL,'Up','DefaultPrimary','CLUSTER',NULL,0,NULL),(2,'PS1','cd360613-e1cf-3a32-b8ef-d07bad8dd92b','NetworkFilesystem',2049,1,1,1,0,1099511627776,'10.147.28.6',NULL,'/export/home/sandbox/primary1','2014-06-26 02:26:26',NULL,NULL,'Up','DefaultPrimary','CLUSTER',NULL,0,NULL),(3,'PS2','0bbd54fe-b348-3e3d-9b91-b453a21bc43a','NetworkFilesystem',2049,1,1,2,0,1099511627776,'10.147.28.6',NULL,'/export/home/sandbox/primary2','2014-06-26 02:27:27',NULL,NULL,'Up','DefaultPrimary','CLUSTER',NULL,0,NULL);
/*!40000 ALTER TABLE `storage_pool` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `storage_pool_details`
--

DROP TABLE IF EXISTS `storage_pool_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `storage_pool_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `pool_id` bigint(20) unsigned NOT NULL COMMENT 'pool the detail is related to',
  `name` varchar(255) NOT NULL COMMENT 'name of the detail',
  `value` varchar(255) DEFAULT NULL,
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'True if the detail can be displayed to the end user',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `fk_storage_pool_details__pool_id` (`pool_id`),
  KEY `i_storage_pool_details__name__value` (`name`(128),`value`(128)),
  CONSTRAINT `fk_storage_pool_details__pool_id` FOREIGN KEY (`pool_id`) REFERENCES `storage_pool` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `storage_pool_details`
--

LOCK TABLES `storage_pool_details` WRITE;
/*!40000 ALTER TABLE `storage_pool_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `storage_pool_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `storage_pool_host_ref`
--

DROP TABLE IF EXISTS `storage_pool_host_ref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `storage_pool_host_ref` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `host_id` bigint(20) unsigned NOT NULL,
  `pool_id` bigint(20) unsigned NOT NULL,
  `created` datetime NOT NULL,
  `last_updated` datetime DEFAULT NULL,
  `local_path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_storage_pool_host_ref__host_id` (`host_id`),
  KEY `fk_storage_pool_host_ref__pool_id` (`pool_id`),
  CONSTRAINT `fk_storage_pool_host_ref__host_id` FOREIGN KEY (`host_id`) REFERENCES `host` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_storage_pool_host_ref__pool_id` FOREIGN KEY (`pool_id`) REFERENCES `storage_pool` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `storage_pool_host_ref`
--

LOCK TABLES `storage_pool_host_ref` WRITE;
/*!40000 ALTER TABLE `storage_pool_host_ref` DISABLE KEYS */;
INSERT INTO `storage_pool_host_ref` VALUES (1,1,1,'2014-06-26 02:26:26',NULL,'/mnt/7c07ec9b-a3c6-3466-ab5a-f5669ead0b22'),(2,2,1,'2014-06-26 02:26:26',NULL,'/mnt/7c07ec9b-a3c6-3466-ab5a-f5669ead0b22'),(3,1,2,'2014-06-26 02:26:26',NULL,'/mnt/cd360613-e1cf-3a32-b8ef-d07bad8dd92b'),(4,2,2,'2014-06-26 02:26:26',NULL,'/mnt/cd360613-e1cf-3a32-b8ef-d07bad8dd92b'),(5,3,3,'2014-06-26 02:27:27',NULL,'/mnt/0bbd54fe-b348-3e3d-9b91-b453a21bc43a');
/*!40000 ALTER TABLE `storage_pool_host_ref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `storage_pool_view`
--

DROP TABLE IF EXISTS `storage_pool_view`;
/*!50001 DROP VIEW IF EXISTS `storage_pool_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `storage_pool_view` (
  `id` tinyint NOT NULL,
  `uuid` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `status` tinyint NOT NULL,
  `path` tinyint NOT NULL,
  `pool_type` tinyint NOT NULL,
  `host_address` tinyint NOT NULL,
  `created` tinyint NOT NULL,
  `removed` tinyint NOT NULL,
  `capacity_bytes` tinyint NOT NULL,
  `capacity_iops` tinyint NOT NULL,
  `scope` tinyint NOT NULL,
  `hypervisor` tinyint NOT NULL,
  `storage_provider_name` tinyint NOT NULL,
  `cluster_id` tinyint NOT NULL,
  `cluster_uuid` tinyint NOT NULL,
  `cluster_name` tinyint NOT NULL,
  `cluster_type` tinyint NOT NULL,
  `data_center_id` tinyint NOT NULL,
  `data_center_uuid` tinyint NOT NULL,
  `data_center_name` tinyint NOT NULL,
  `data_center_type` tinyint NOT NULL,
  `pod_id` tinyint NOT NULL,
  `pod_uuid` tinyint NOT NULL,
  `pod_name` tinyint NOT NULL,
  `tag` tinyint NOT NULL,
  `disk_used_capacity` tinyint NOT NULL,
  `disk_reserved_capacity` tinyint NOT NULL,
  `job_id` tinyint NOT NULL,
  `job_uuid` tinyint NOT NULL,
  `job_status` tinyint NOT NULL,
  `job_account_id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `storage_pool_work`
--

DROP TABLE IF EXISTS `storage_pool_work`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `storage_pool_work` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `pool_id` bigint(20) unsigned NOT NULL COMMENT 'storage pool associated with the vm',
  `vm_id` bigint(20) unsigned NOT NULL COMMENT 'vm identifier',
  `stopped_for_maintenance` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'this flag denoted whether the vm was stopped during maintenance',
  `started_after_maintenance` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'this flag denoted whether the vm was started after maintenance',
  `mgmt_server_id` bigint(20) unsigned NOT NULL COMMENT 'management server id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `pool_id` (`pool_id`,`vm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `storage_pool_work`
--

LOCK TABLES `storage_pool_work` WRITE;
/*!40000 ALTER TABLE `storage_pool_work` DISABLE KEYS */;
/*!40000 ALTER TABLE `storage_pool_work` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `swift`
--

DROP TABLE IF EXISTS `swift`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `swift` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(40) DEFAULT NULL,
  `url` varchar(255) NOT NULL,
  `account` varchar(255) NOT NULL COMMENT ' account in swift',
  `username` varchar(255) NOT NULL COMMENT ' username in swift',
  `key` varchar(255) NOT NULL COMMENT 'token for this user',
  `created` datetime DEFAULT NULL COMMENT 'date the swift first signed on',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_swift__uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `swift`
--

LOCK TABLES `swift` WRITE;
/*!40000 ALTER TABLE `swift` DISABLE KEYS */;
/*!40000 ALTER TABLE `swift` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sync_queue`
--

DROP TABLE IF EXISTS `sync_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sync_queue` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `sync_objtype` varchar(64) NOT NULL,
  `sync_objid` bigint(20) unsigned NOT NULL,
  `queue_proc_number` bigint(20) DEFAULT NULL COMMENT 'process number, increase 1 for each iteration',
  `created` datetime DEFAULT NULL COMMENT 'date created',
  `last_updated` datetime DEFAULT NULL COMMENT 'date created',
  `queue_size` smallint(6) NOT NULL DEFAULT '0' COMMENT 'number of items being processed by the queue',
  `queue_size_limit` smallint(6) NOT NULL DEFAULT '1' COMMENT 'max number of items the queue can process concurrently',
  PRIMARY KEY (`id`),
  UNIQUE KEY `i_sync_queue__objtype__objid` (`sync_objtype`,`sync_objid`),
  KEY `i_sync_queue__created` (`created`),
  KEY `i_sync_queue__last_updated` (`last_updated`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sync_queue`
--

LOCK TABLES `sync_queue` WRITE;
/*!40000 ALTER TABLE `sync_queue` DISABLE KEYS */;
INSERT INTO `sync_queue` VALUES (1,'VmWorkJobQueue',1,1,'2014-06-26 02:27:57','2014-06-26 02:28:00',0,1),(2,'VmWorkJobQueue',2,1,'2014-06-26 02:27:58','2014-06-26 02:28:00',0,1);
/*!40000 ALTER TABLE `sync_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sync_queue_item`
--

DROP TABLE IF EXISTS `sync_queue_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sync_queue_item` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue_id` bigint(20) unsigned NOT NULL,
  `content_type` varchar(64) DEFAULT NULL,
  `content_id` bigint(20) DEFAULT NULL,
  `queue_proc_msid` bigint(20) DEFAULT NULL COMMENT 'owner msid when the queue item is being processed',
  `queue_proc_number` bigint(20) DEFAULT NULL COMMENT 'used to distinguish raw items and items being in process',
  `queue_proc_time` datetime DEFAULT NULL COMMENT 'when processing started for the item',
  `created` datetime DEFAULT NULL COMMENT 'time created',
  PRIMARY KEY (`id`),
  KEY `i_sync_queue_item__queue_id` (`queue_id`),
  KEY `i_sync_queue_item__created` (`created`),
  KEY `i_sync_queue_item__queue_proc_number` (`queue_proc_number`),
  KEY `i_sync_queue_item__queue_proc_msid` (`queue_proc_msid`),
  KEY `i_sync_queue__queue_proc_time` (`queue_proc_time`),
  CONSTRAINT `fk_sync_queue_item__queue_id` FOREIGN KEY (`queue_id`) REFERENCES `sync_queue` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sync_queue_item`
--

LOCK TABLES `sync_queue_item` WRITE;
/*!40000 ALTER TABLE `sync_queue_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `sync_queue_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `template_host_ref`
--

DROP TABLE IF EXISTS `template_host_ref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `template_host_ref` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `host_id` bigint(20) unsigned NOT NULL,
  `template_id` bigint(20) unsigned NOT NULL,
  `created` datetime NOT NULL,
  `last_updated` datetime DEFAULT NULL,
  `job_id` varchar(255) DEFAULT NULL,
  `download_pct` int(10) unsigned DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `physical_size` bigint(20) unsigned DEFAULT '0',
  `download_state` varchar(255) DEFAULT NULL,
  `error_str` varchar(255) DEFAULT NULL,
  `local_path` varchar(255) DEFAULT NULL,
  `install_path` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `destroyed` tinyint(1) DEFAULT NULL COMMENT 'indicates whether the template_host entry was destroyed by the user or not',
  `is_copy` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'indicates whether this was copied ',
  PRIMARY KEY (`id`),
  KEY `i_template_host_ref__host_id` (`host_id`),
  KEY `i_template_host_ref__template_id` (`template_id`),
  CONSTRAINT `fk_template_host_ref__host_id` FOREIGN KEY (`host_id`) REFERENCES `host` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_template_host_ref__template_id` FOREIGN KEY (`template_id`) REFERENCES `vm_template` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `template_host_ref`
--

LOCK TABLES `template_host_ref` WRITE;
/*!40000 ALTER TABLE `template_host_ref` DISABLE KEYS */;
/*!40000 ALTER TABLE `template_host_ref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `template_s3_ref`
--

DROP TABLE IF EXISTS `template_s3_ref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `template_s3_ref` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `s3_id` bigint(20) unsigned NOT NULL COMMENT ' Associated S3 instance id',
  `template_id` bigint(20) unsigned NOT NULL COMMENT ' Associated template id',
  `created` datetime NOT NULL COMMENT ' The creation timestamp',
  `size` bigint(20) unsigned DEFAULT NULL COMMENT ' The size of the object',
  `physical_size` bigint(20) unsigned DEFAULT '0' COMMENT ' The physical size of the object',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_template_s3_ref__template_id` (`template_id`),
  KEY `i_template_s3_ref__s3_id` (`s3_id`),
  KEY `i_template_s3_ref__template_id` (`template_id`),
  CONSTRAINT `fk_template_s3_ref__s3_id` FOREIGN KEY (`s3_id`) REFERENCES `s3` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_template_s3_ref__template_id` FOREIGN KEY (`template_id`) REFERENCES `vm_template` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `template_s3_ref`
--

LOCK TABLES `template_s3_ref` WRITE;
/*!40000 ALTER TABLE `template_s3_ref` DISABLE KEYS */;
/*!40000 ALTER TABLE `template_s3_ref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `template_spool_ref`
--

DROP TABLE IF EXISTS `template_spool_ref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `template_spool_ref` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pool_id` bigint(20) unsigned NOT NULL,
  `template_id` bigint(20) unsigned NOT NULL,
  `created` datetime NOT NULL,
  `last_updated` datetime DEFAULT NULL,
  `job_id` varchar(255) DEFAULT NULL,
  `download_pct` int(10) unsigned DEFAULT NULL,
  `download_state` varchar(255) DEFAULT NULL,
  `error_str` varchar(255) DEFAULT NULL,
  `local_path` varchar(255) DEFAULT NULL,
  `install_path` varchar(255) DEFAULT NULL,
  `template_size` bigint(20) unsigned NOT NULL COMMENT 'the size of the template on the pool',
  `marked_for_gc` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'if true, the garbage collector will evict the template from this pool.',
  `state` varchar(255) DEFAULT NULL,
  `update_count` bigint(20) unsigned DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `i_template_spool_ref__template_id__pool_id` (`template_id`,`pool_id`),
  KEY `fk_template_spool_ref__pool_id` (`pool_id`),
  CONSTRAINT `fk_template_spool_ref__pool_id` FOREIGN KEY (`pool_id`) REFERENCES `storage_pool` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_template_spool_ref__template_id` FOREIGN KEY (`template_id`) REFERENCES `vm_template` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `template_spool_ref`
--

LOCK TABLES `template_spool_ref` WRITE;
/*!40000 ALTER TABLE `template_spool_ref` DISABLE KEYS */;
INSERT INTO `template_spool_ref` VALUES (1,2,100,'2014-06-26 02:28:00',NULL,NULL,100,'DOWNLOADED',NULL,'3be80525-4cf1-4d01-a66b-22fd38846332','3be80525-4cf1-4d01-a66b-22fd38846332',0,0,'Ready',2,'2014-06-26 02:28:00'),(2,3,100,'2014-06-26 02:28:00',NULL,NULL,100,'DOWNLOADED',NULL,'bb47f2d3-b312-47d4-b6dc-35ff3d0d2e33','bb47f2d3-b312-47d4-b6dc-35ff3d0d2e33',0,0,'Ready',2,'2014-06-26 02:28:00');
/*!40000 ALTER TABLE `template_spool_ref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `template_store_ref`
--

DROP TABLE IF EXISTS `template_store_ref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `template_store_ref` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `store_id` bigint(20) unsigned DEFAULT NULL,
  `template_id` bigint(20) unsigned NOT NULL,
  `created` datetime NOT NULL,
  `last_updated` datetime DEFAULT NULL,
  `job_id` varchar(255) DEFAULT NULL,
  `download_pct` int(10) unsigned DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `store_role` varchar(255) DEFAULT NULL,
  `physical_size` bigint(20) unsigned DEFAULT '0',
  `download_state` varchar(255) DEFAULT NULL,
  `error_str` varchar(255) DEFAULT NULL,
  `local_path` varchar(255) DEFAULT NULL,
  `install_path` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `state` varchar(255) NOT NULL,
  `destroyed` tinyint(1) DEFAULT NULL COMMENT 'indicates whether the template_store entry was destroyed by the user or not',
  `is_copy` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'indicates whether this was copied ',
  `update_count` bigint(20) unsigned DEFAULT NULL,
  `ref_cnt` bigint(20) unsigned DEFAULT '0',
  `updated` datetime DEFAULT NULL,
  `download_url_created` datetime DEFAULT NULL,
  `download_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `i_template_store_ref__store_id` (`store_id`),
  KEY `i_template_store_ref__template_id` (`template_id`),
  CONSTRAINT `fk_template_store_ref__template_id` FOREIGN KEY (`template_id`) REFERENCES `vm_template` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `template_store_ref`
--

LOCK TABLES `template_store_ref` WRITE;
/*!40000 ALTER TABLE `template_store_ref` DISABLE KEYS */;
INSERT INTO `template_store_ref` VALUES (1,1,100,'2014-06-26 02:27:27','2014-06-26 02:28:00',NULL,100,2147483648,'Image',2147483648,'DOWNLOADED',NULL,NULL,'template/tmpl/1/100/ef306513-04bd-4f9b-a56b-13e87ce00d77','http://nfs1.lab.vmops.com/templates/routing/debian/latest/systemvm.vhd.bz2','Ready',0,0,0,0,NULL,NULL,NULL),(7,1,111,'2014-06-26 02:28:00','2014-06-26 02:28:00',NULL,100,2147483648,'Image',2147483648,'DOWNLOADED',NULL,NULL,'template/tmpl/1/111/31f775d1-2df3-4a61-ae25-3ceb8379d828','http://nfs1.lab.vmops.com/templates/centos53-x86_64/latest/f59f18fb-ae94-4f97-afd2-f84755767aca.vhd.bz2','Ready',0,0,0,0,NULL,NULL,NULL);
/*!40000 ALTER TABLE `template_store_ref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `template_swift_ref`
--

DROP TABLE IF EXISTS `template_swift_ref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `template_swift_ref` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `swift_id` bigint(20) unsigned NOT NULL,
  `template_id` bigint(20) unsigned NOT NULL,
  `created` datetime NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `physical_size` bigint(20) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `i_template_swift_ref__swift_id` (`swift_id`),
  KEY `i_template_swift_ref__template_id` (`template_id`),
  CONSTRAINT `fk_template_swift_ref__swift_id` FOREIGN KEY (`swift_id`) REFERENCES `swift` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_template_swift_ref__template_id` FOREIGN KEY (`template_id`) REFERENCES `vm_template` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `template_swift_ref`
--

LOCK TABLES `template_swift_ref` WRITE;
/*!40000 ALTER TABLE `template_swift_ref` DISABLE KEYS */;
/*!40000 ALTER TABLE `template_swift_ref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `template_view`
--

DROP TABLE IF EXISTS `template_view`;
/*!50001 DROP VIEW IF EXISTS `template_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `template_view` (
  `id` tinyint NOT NULL,
  `uuid` tinyint NOT NULL,
  `unique_name` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `public` tinyint NOT NULL,
  `featured` tinyint NOT NULL,
  `type` tinyint NOT NULL,
  `hvm` tinyint NOT NULL,
  `bits` tinyint NOT NULL,
  `url` tinyint NOT NULL,
  `format` tinyint NOT NULL,
  `created` tinyint NOT NULL,
  `checksum` tinyint NOT NULL,
  `display_text` tinyint NOT NULL,
  `enable_password` tinyint NOT NULL,
  `dynamically_scalable` tinyint NOT NULL,
  `template_state` tinyint NOT NULL,
  `guest_os_id` tinyint NOT NULL,
  `guest_os_uuid` tinyint NOT NULL,
  `guest_os_name` tinyint NOT NULL,
  `bootable` tinyint NOT NULL,
  `prepopulate` tinyint NOT NULL,
  `cross_zones` tinyint NOT NULL,
  `hypervisor_type` tinyint NOT NULL,
  `extractable` tinyint NOT NULL,
  `template_tag` tinyint NOT NULL,
  `sort_key` tinyint NOT NULL,
  `removed` tinyint NOT NULL,
  `enable_sshkey` tinyint NOT NULL,
  `source_template_id` tinyint NOT NULL,
  `source_template_uuid` tinyint NOT NULL,
  `account_id` tinyint NOT NULL,
  `account_uuid` tinyint NOT NULL,
  `account_name` tinyint NOT NULL,
  `account_type` tinyint NOT NULL,
  `domain_id` tinyint NOT NULL,
  `domain_uuid` tinyint NOT NULL,
  `domain_name` tinyint NOT NULL,
  `domain_path` tinyint NOT NULL,
  `project_id` tinyint NOT NULL,
  `project_uuid` tinyint NOT NULL,
  `project_name` tinyint NOT NULL,
  `data_center_id` tinyint NOT NULL,
  `data_center_uuid` tinyint NOT NULL,
  `data_center_name` tinyint NOT NULL,
  `lp_account_id` tinyint NOT NULL,
  `store_id` tinyint NOT NULL,
  `store_scope` tinyint NOT NULL,
  `state` tinyint NOT NULL,
  `download_state` tinyint NOT NULL,
  `download_pct` tinyint NOT NULL,
  `error_str` tinyint NOT NULL,
  `size` tinyint NOT NULL,
  `destroyed` tinyint NOT NULL,
  `created_on_store` tinyint NOT NULL,
  `detail_name` tinyint NOT NULL,
  `detail_value` tinyint NOT NULL,
  `tag_id` tinyint NOT NULL,
  `tag_uuid` tinyint NOT NULL,
  `tag_key` tinyint NOT NULL,
  `tag_value` tinyint NOT NULL,
  `tag_domain_id` tinyint NOT NULL,
  `tag_account_id` tinyint NOT NULL,
  `tag_resource_id` tinyint NOT NULL,
  `tag_resource_uuid` tinyint NOT NULL,
  `tag_resource_type` tinyint NOT NULL,
  `tag_customer` tinyint NOT NULL,
  `temp_zone_pair` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `template_zone_ref`
--

DROP TABLE IF EXISTS `template_zone_ref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `template_zone_ref` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `zone_id` bigint(20) unsigned NOT NULL,
  `template_id` bigint(20) unsigned NOT NULL,
  `created` datetime NOT NULL,
  `last_updated` datetime DEFAULT NULL,
  `removed` datetime DEFAULT NULL COMMENT 'date removed if not null',
  PRIMARY KEY (`id`),
  KEY `i_template_zone_ref__zone_id` (`zone_id`),
  KEY `i_template_zone_ref__template_id` (`template_id`),
  KEY `i_template_zone_ref__removed` (`removed`),
  CONSTRAINT `fk_template_zone_ref__zone_id` FOREIGN KEY (`zone_id`) REFERENCES `data_center` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_template_zone_ref__template_id` FOREIGN KEY (`template_id`) REFERENCES `vm_template` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `template_zone_ref`
--

LOCK TABLES `template_zone_ref` WRITE;
/*!40000 ALTER TABLE `template_zone_ref` DISABLE KEYS */;
INSERT INTO `template_zone_ref` VALUES (1,1,1,'2014-06-26 02:25:26','2014-06-26 02:25:26',NULL),(2,1,2,'2014-06-26 02:25:26','2014-06-26 02:25:26',NULL),(3,1,3,'2014-06-26 02:25:26','2014-06-26 02:25:26',NULL),(4,1,4,'2014-06-26 02:25:26','2014-06-26 02:25:26',NULL),(5,1,5,'2014-06-26 02:25:26','2014-06-26 02:25:26',NULL),(6,1,6,'2014-06-26 02:25:26','2014-06-26 02:25:26',NULL),(7,1,7,'2014-06-26 02:25:26','2014-06-26 02:25:26',NULL),(8,1,8,'2014-06-26 02:25:26','2014-06-26 02:25:26',NULL),(9,1,9,'2014-06-26 02:25:26','2014-06-26 02:25:26',NULL),(10,1,10,'2014-06-26 02:25:26','2014-06-26 02:25:26',NULL),(11,1,100,'2014-06-26 02:25:26','2014-06-26 02:25:26',NULL),(12,1,111,'2014-06-26 02:25:26','2014-06-26 02:28:00',NULL);
/*!40000 ALTER TABLE `template_zone_ref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ucs_blade`
--

DROP TABLE IF EXISTS `ucs_blade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ucs_blade` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uuid` varchar(40) DEFAULT NULL,
  `ucs_manager_id` bigint(20) unsigned NOT NULL,
  `host_id` bigint(20) unsigned DEFAULT NULL,
  `dn` varchar(512) NOT NULL,
  `profile_dn` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ucs_blade`
--

LOCK TABLES `ucs_blade` WRITE;
/*!40000 ALTER TABLE `ucs_blade` DISABLE KEYS */;
/*!40000 ALTER TABLE `ucs_blade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ucs_manager`
--

DROP TABLE IF EXISTS `ucs_manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ucs_manager` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uuid` varchar(40) DEFAULT NULL,
  `zone_id` bigint(20) unsigned NOT NULL,
  `name` varchar(128) DEFAULT NULL,
  `url` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ucs_manager`
--

LOCK TABLES `ucs_manager` WRITE;
/*!40000 ALTER TABLE `ucs_manager` DISABLE KEYS */;
/*!40000 ALTER TABLE `ucs_manager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `upload`
--

DROP TABLE IF EXISTS `upload`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `upload` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `host_id` bigint(20) unsigned NOT NULL,
  `type_id` bigint(20) unsigned NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `mode` varchar(255) DEFAULT NULL,
  `created` datetime NOT NULL,
  `last_updated` datetime DEFAULT NULL,
  `job_id` varchar(255) DEFAULT NULL,
  `upload_pct` int(10) unsigned DEFAULT NULL,
  `upload_state` varchar(255) DEFAULT NULL,
  `error_str` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `install_path` varchar(255) DEFAULT NULL,
  `uuid` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `i_upload__host_id` (`host_id`),
  KEY `i_upload__type_id` (`type_id`),
  CONSTRAINT `fk_upload__store_id` FOREIGN KEY (`host_id`) REFERENCES `image_store` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `upload`
--

LOCK TABLES `upload` WRITE;
/*!40000 ALTER TABLE `upload` DISABLE KEYS */;
/*!40000 ALTER TABLE `upload` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usage_event`
--

DROP TABLE IF EXISTS `usage_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usage_event` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(32) NOT NULL,
  `account_id` bigint(20) unsigned NOT NULL,
  `created` datetime NOT NULL,
  `zone_id` bigint(20) unsigned NOT NULL,
  `resource_id` bigint(20) unsigned DEFAULT NULL,
  `resource_name` varchar(255) DEFAULT NULL,
  `offering_id` bigint(20) unsigned DEFAULT NULL,
  `template_id` bigint(20) unsigned DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `resource_type` varchar(32) DEFAULT NULL,
  `processed` tinyint(4) NOT NULL DEFAULT '0',
  `virtual_size` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `i_usage_event__created` (`created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usage_event`
--

LOCK TABLES `usage_event` WRITE;
/*!40000 ALTER TABLE `usage_event` DISABLE KEYS */;
/*!40000 ALTER TABLE `usage_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usage_event_details`
--

DROP TABLE IF EXISTS `usage_event_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usage_event_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `usage_event_id` bigint(20) unsigned NOT NULL COMMENT 'usage event id',
  `name` varchar(255) NOT NULL,
  `value` varchar(1024) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_usage_event_details__usage_event_id` (`usage_event_id`),
  CONSTRAINT `fk_usage_event_details__usage_event_id` FOREIGN KEY (`usage_event_id`) REFERENCES `usage_event` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usage_event_details`
--

LOCK TABLES `usage_event_details` WRITE;
/*!40000 ALTER TABLE `usage_event_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `usage_event_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(40) DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `account_id` bigint(20) unsigned NOT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `state` varchar(10) NOT NULL DEFAULT 'enabled',
  `api_key` varchar(255) DEFAULT NULL,
  `secret_key` varchar(255) DEFAULT NULL,
  `created` datetime NOT NULL COMMENT 'date created',
  `removed` datetime DEFAULT NULL COMMENT 'date removed',
  `timezone` varchar(30) DEFAULT NULL,
  `registration_token` varchar(255) DEFAULT NULL,
  `is_registered` tinyint(4) NOT NULL DEFAULT '0' COMMENT '1: yes, 0: no',
  `incorrect_login_attempts` int(10) unsigned NOT NULL DEFAULT '0',
  `default` int(1) unsigned NOT NULL DEFAULT '0' COMMENT '1 if user is default',
  PRIMARY KEY (`id`),
  UNIQUE KEY `i_user__api_key` (`api_key`),
  UNIQUE KEY `uc_user__uuid` (`uuid`),
  KEY `i_user__removed` (`removed`),
  KEY `i_user__secret_key_removed` (`secret_key`,`removed`),
  KEY `i_user__account_id` (`account_id`),
  CONSTRAINT `fk_user__account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'ae61d910-fcd8-11e3-9019-080027ce083d','system','0.844699833397474',1,'system','cloud',NULL,'enabled',NULL,NULL,'2014-06-26 02:22:12',NULL,NULL,NULL,0,0,1),(2,'ae61ee1e-fcd8-11e3-9019-080027ce083d','admin','iRvYWyGL2ETI5VvkAEe5nfYGQBaQQfPxnWiDY5I4w08=:4a6bZz6FnKxWY6x3gxIrvbhKJL1btbDg2F3hLJStoYk=',2,'Admin','User','admin@mailprovider.com','enabled','LBopqe-R6_9IGZ21aQCpDKHEuwg2h5WCGX5oOQqZnvGvY3yYV6N2hZyVuNm6f5LbCfp4lxH08R5c4tEqi4tN2A','VQ3MfgXBYnL4twK3HZsYnwNuRBC01vmOL4gK1ImWJVXGVrGXDSlpo2XWTWpHH4bIlXCUXBkYKvz9xAmH-brXog','2014-06-26 02:22:12',NULL,NULL,NULL,0,0,1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_details`
--

DROP TABLE IF EXISTS `user_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL COMMENT 'VPC gateway id',
  `name` varchar(255) NOT NULL,
  `value` varchar(1024) NOT NULL,
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'True if the detail can be displayed to the end user',
  PRIMARY KEY (`id`),
  KEY `fk_user_details__user_id` (`user_id`),
  CONSTRAINT `fk_user_details__user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_details`
--

LOCK TABLES `user_details` WRITE;
/*!40000 ALTER TABLE `user_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_ip_address`
--

DROP TABLE IF EXISTS `user_ip_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_ip_address` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(40) DEFAULT NULL,
  `account_id` bigint(20) unsigned DEFAULT NULL,
  `domain_id` bigint(20) unsigned DEFAULT NULL,
  `public_ip_address` char(40) NOT NULL,
  `data_center_id` bigint(20) unsigned NOT NULL COMMENT 'zone that it belongs to',
  `source_nat` int(1) unsigned NOT NULL DEFAULT '0',
  `allocated` datetime DEFAULT NULL COMMENT 'Date this ip was allocated to someone',
  `vlan_db_id` bigint(20) unsigned NOT NULL,
  `one_to_one_nat` int(1) unsigned NOT NULL DEFAULT '0',
  `vm_id` bigint(20) unsigned DEFAULT NULL COMMENT 'vm id the one_to_one nat ip is assigned to',
  `state` char(32) NOT NULL DEFAULT 'Free' COMMENT 'state of the ip address',
  `mac_address` bigint(20) unsigned NOT NULL COMMENT 'mac address of this ip',
  `source_network_id` bigint(20) unsigned NOT NULL COMMENT 'network id ip belongs to',
  `network_id` bigint(20) unsigned DEFAULT NULL COMMENT 'network this public ip address is associated with',
  `physical_network_id` bigint(20) unsigned NOT NULL COMMENT 'physical network id that this configuration is based on',
  `is_system` int(1) unsigned NOT NULL DEFAULT '0',
  `vpc_id` bigint(20) unsigned DEFAULT NULL COMMENT 'vpc the ip address is associated with',
  `dnat_vmip` varchar(40) DEFAULT NULL,
  `is_portable` int(1) unsigned NOT NULL DEFAULT '0',
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'True if the ip address can be displayed to the end user',
  `removed` datetime DEFAULT NULL COMMENT 'date removed',
  `created` datetime DEFAULT NULL COMMENT 'date created',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `uc_user_ip_address__uuid` (`uuid`),
  UNIQUE KEY `public_ip_address` (`public_ip_address`,`source_network_id`,`removed`),
  KEY `fk_user_ip_address__source_network_id` (`source_network_id`),
  KEY `fk_user_ip_address__network_id` (`network_id`),
  KEY `fk_user_ip_address__account_id` (`account_id`),
  KEY `fk_user_ip_address__vm_id` (`vm_id`),
  KEY `fk_user_ip_address__vlan_db_id` (`vlan_db_id`),
  KEY `fk_user_ip_address__data_center_id` (`data_center_id`),
  KEY `fk_user_ip_address__physical_network_id` (`physical_network_id`),
  KEY `fk_user_ip_address__vpc_id` (`vpc_id`),
  KEY `i_user_ip_address__allocated` (`allocated`),
  KEY `i_user_ip_address__source_nat` (`source_nat`),
  CONSTRAINT `fk_user_ip_address__account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `fk_user_ip_address__data_center_id` FOREIGN KEY (`data_center_id`) REFERENCES `data_center` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_user_ip_address__network_id` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`),
  CONSTRAINT `fk_user_ip_address__physical_network_id` FOREIGN KEY (`physical_network_id`) REFERENCES `physical_network` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_user_ip_address__source_network_id` FOREIGN KEY (`source_network_id`) REFERENCES `networks` (`id`),
  CONSTRAINT `fk_user_ip_address__vlan_db_id` FOREIGN KEY (`vlan_db_id`) REFERENCES `vlan` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_user_ip_address__vm_id` FOREIGN KEY (`vm_id`) REFERENCES `vm_instance` (`id`),
  CONSTRAINT `fk_user_ip_address__vpc_id` FOREIGN KEY (`vpc_id`) REFERENCES `vpc` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=200 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_ip_address`
--

LOCK TABLES `user_ip_address` WRITE;
/*!40000 ALTER TABLE `user_ip_address` DISABLE KEYS */;
INSERT INTO `user_ip_address` VALUES (1,'96c06e9f-d8ba-4862-b64b-3a305cc57dbf',1,1,'192.168.2.2',1,0,'2014-06-26 02:27:57',1,0,NULL,'Allocated',200,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(2,'f4efc650-3837-42e0-b6fb-a282643c11f6',1,1,'192.168.2.3',1,0,'2014-06-26 02:27:58',1,0,NULL,'Allocated',201,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(3,'49a0fab3-f07e-4259-9a69-4c2f21ebcc5f',NULL,NULL,'192.168.2.4',1,0,NULL,1,0,NULL,'Free',202,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(4,'6fc6ef3e-d5aa-4ca0-affb-6bc3e82a5009',NULL,NULL,'192.168.2.5',1,0,NULL,1,0,NULL,'Free',203,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(5,'9095e609-926f-4807-ae9a-521c6b6cf1a8',NULL,NULL,'192.168.2.6',1,0,NULL,1,0,NULL,'Free',204,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(6,'c0082323-9238-449d-ba52-bd2c978f8cb8',NULL,NULL,'192.168.2.7',1,0,NULL,1,0,NULL,'Free',205,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(7,'11590ff2-e272-40eb-9054-7d74206e3f1d',NULL,NULL,'192.168.2.8',1,0,NULL,1,0,NULL,'Free',206,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(8,'22302da9-c92d-48f1-b2fa-1c91558fc492',NULL,NULL,'192.168.2.9',1,0,NULL,1,0,NULL,'Free',207,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(9,'76dfc3b0-b740-4f26-9d13-e21f1bbd2f1b',NULL,NULL,'192.168.2.10',1,0,NULL,1,0,NULL,'Free',208,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(10,'22a16752-671f-4ca8-a452-5b3fe8cde3c8',NULL,NULL,'192.168.2.11',1,0,NULL,1,0,NULL,'Free',209,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(11,'998becc1-77cb-47af-bfec-fe31c4e67547',NULL,NULL,'192.168.2.12',1,0,NULL,1,0,NULL,'Free',210,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(12,'151e1f4c-89b4-4a92-9969-ae8084ea6090',NULL,NULL,'192.168.2.13',1,0,NULL,1,0,NULL,'Free',211,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(13,'399bd1a7-53de-419d-addc-6e6e21bff47e',NULL,NULL,'192.168.2.14',1,0,NULL,1,0,NULL,'Free',212,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(14,'99b560c6-1362-48fa-a780-787e67d88fed',NULL,NULL,'192.168.2.15',1,0,NULL,1,0,NULL,'Free',213,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(15,'903077c8-f196-4859-9ab5-6b0f4a67b9f7',NULL,NULL,'192.168.2.16',1,0,NULL,1,0,NULL,'Free',214,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(16,'5ea5f6b1-2392-4a30-9c8a-5191e05b740e',NULL,NULL,'192.168.2.17',1,0,NULL,1,0,NULL,'Free',215,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(17,'3b5b504c-9fa8-48f6-9560-07f118d83b51',NULL,NULL,'192.168.2.18',1,0,NULL,1,0,NULL,'Free',216,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(18,'e2cb103c-febe-4cb3-889e-f2c91252fb7c',NULL,NULL,'192.168.2.19',1,0,NULL,1,0,NULL,'Free',217,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(19,'ffb56139-76e6-45c1-bcef-27f6e0d1bdbe',NULL,NULL,'192.168.2.20',1,0,NULL,1,0,NULL,'Free',218,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(20,'bd6cd2f5-b3ab-44e1-a581-85c58856b6da',NULL,NULL,'192.168.2.21',1,0,NULL,1,0,NULL,'Free',219,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(21,'023fcd81-6bf9-43cc-9f2b-cfe39c13d758',NULL,NULL,'192.168.2.22',1,0,NULL,1,0,NULL,'Free',220,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(22,'a6bbb954-05f9-4a67-9238-c0988f86a12a',NULL,NULL,'192.168.2.23',1,0,NULL,1,0,NULL,'Free',221,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(23,'d35010bd-3233-48c8-8cca-215d420cc60d',NULL,NULL,'192.168.2.24',1,0,NULL,1,0,NULL,'Free',222,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(24,'ca88db57-04e2-4579-9e7f-b60b8c8c2d26',NULL,NULL,'192.168.2.25',1,0,NULL,1,0,NULL,'Free',223,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(25,'8dcf0e06-5e4b-48ea-87ca-221177d2fc7d',NULL,NULL,'192.168.2.26',1,0,NULL,1,0,NULL,'Free',224,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(26,'a303abdb-7729-4ef2-be73-b50f57f86501',NULL,NULL,'192.168.2.27',1,0,NULL,1,0,NULL,'Free',225,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(27,'fd4ec268-2b45-41f8-bf9a-feb171e6baf1',NULL,NULL,'192.168.2.28',1,0,NULL,1,0,NULL,'Free',226,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(28,'051fac22-8f2f-4fd8-8890-92ab561a7abb',NULL,NULL,'192.168.2.29',1,0,NULL,1,0,NULL,'Free',227,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(29,'1573ff92-b15b-4e9d-be49-e5cc1113319f',NULL,NULL,'192.168.2.30',1,0,NULL,1,0,NULL,'Free',228,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(30,'50a903be-6b3c-45da-aa4e-52bd338d7ded',NULL,NULL,'192.168.2.31',1,0,NULL,1,0,NULL,'Free',229,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(31,'4771af9e-a00d-4e0f-809a-154450fe6f62',NULL,NULL,'192.168.2.32',1,0,NULL,1,0,NULL,'Free',230,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(32,'8169824f-be89-454e-adec-07b85b2e2e51',NULL,NULL,'192.168.2.33',1,0,NULL,1,0,NULL,'Free',231,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(33,'aef48cba-c429-47ed-8b23-ea53d3a9bf62',NULL,NULL,'192.168.2.34',1,0,NULL,1,0,NULL,'Free',232,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(34,'829fa679-d32d-4e81-ae8d-5bfef99a2390',NULL,NULL,'192.168.2.35',1,0,NULL,1,0,NULL,'Free',233,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(35,'dcca92cf-fe3e-456d-a7b9-58dc5756ad9d',NULL,NULL,'192.168.2.36',1,0,NULL,1,0,NULL,'Free',234,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(36,'2aa32522-0531-46c6-bf83-2cab0db7bcbc',NULL,NULL,'192.168.2.37',1,0,NULL,1,0,NULL,'Free',235,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(37,'8ac05de5-3b13-4c66-93d3-08c4ec32fd4d',NULL,NULL,'192.168.2.38',1,0,NULL,1,0,NULL,'Free',236,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(38,'0ff0033d-f1d1-40d0-b798-637351dc92b8',NULL,NULL,'192.168.2.39',1,0,NULL,1,0,NULL,'Free',237,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(39,'d6340e8f-1abc-45b7-868b-88e3a37a3d4f',NULL,NULL,'192.168.2.40',1,0,NULL,1,0,NULL,'Free',238,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(40,'201397d3-3f2f-42a6-9392-571ee0c67ebf',NULL,NULL,'192.168.2.41',1,0,NULL,1,0,NULL,'Free',239,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(41,'fe9211b5-66b5-4963-a397-8b3be795ad1c',NULL,NULL,'192.168.2.42',1,0,NULL,1,0,NULL,'Free',240,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(42,'ab5a0e5c-60b8-487c-9e27-a5657e951814',NULL,NULL,'192.168.2.43',1,0,NULL,1,0,NULL,'Free',241,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(43,'5d58a6af-2d8f-4890-9b16-25283ad1c7b5',NULL,NULL,'192.168.2.44',1,0,NULL,1,0,NULL,'Free',242,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(44,'1f90d9a5-7217-4d2f-8f9c-b4584e5936ed',NULL,NULL,'192.168.2.45',1,0,NULL,1,0,NULL,'Free',243,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(45,'ab365674-c4e2-4c2c-8503-f9d5849cdd62',NULL,NULL,'192.168.2.46',1,0,NULL,1,0,NULL,'Free',244,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(46,'435be0a9-68bd-4f74-8649-f4d6e420fcb7',NULL,NULL,'192.168.2.47',1,0,NULL,1,0,NULL,'Free',245,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(47,'af95af41-c3d5-44c4-baf6-540096a215c9',NULL,NULL,'192.168.2.48',1,0,NULL,1,0,NULL,'Free',246,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(48,'e8f94edc-f6b5-415a-9c31-abec7d4b5dec',NULL,NULL,'192.168.2.49',1,0,NULL,1,0,NULL,'Free',247,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(49,'4248dc34-fb51-45d3-8ea3-2ef8507a7f13',NULL,NULL,'192.168.2.50',1,0,NULL,1,0,NULL,'Free',248,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(50,'3fd3d44c-0b3e-4480-8d23-abeed4deec4a',NULL,NULL,'192.168.2.51',1,0,NULL,1,0,NULL,'Free',249,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(51,'e8cfa557-056c-4f99-a056-2ebbd8762ee1',NULL,NULL,'192.168.2.52',1,0,NULL,1,0,NULL,'Free',250,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(52,'6d7fe0de-dd46-4f31-8480-56dadabd173f',NULL,NULL,'192.168.2.53',1,0,NULL,1,0,NULL,'Free',251,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(53,'f825d346-e504-44eb-b326-72f2afd0a7bc',NULL,NULL,'192.168.2.54',1,0,NULL,1,0,NULL,'Free',252,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(54,'741b654d-9eb1-47ba-be34-a270101a0790',NULL,NULL,'192.168.2.55',1,0,NULL,1,0,NULL,'Free',253,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(55,'08e16937-fc9d-4f82-9e02-de88b9b4198f',NULL,NULL,'192.168.2.56',1,0,NULL,1,0,NULL,'Free',254,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(56,'d3f4e6d3-71cb-4ee0-8d41-6ec039db9e16',NULL,NULL,'192.168.2.57',1,0,NULL,1,0,NULL,'Free',255,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(57,'aed5124b-4c59-4018-99ed-d65331ac1da4',NULL,NULL,'192.168.2.58',1,0,NULL,1,0,NULL,'Free',256,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(58,'fa91deed-186a-45a6-afe0-471db562633a',NULL,NULL,'192.168.2.59',1,0,NULL,1,0,NULL,'Free',257,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(59,'3a10e728-106a-4dba-affa-9a72a6b85c98',NULL,NULL,'192.168.2.60',1,0,NULL,1,0,NULL,'Free',258,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(60,'17e32121-a676-4d3d-bf2e-13ebaa663ab4',NULL,NULL,'192.168.2.61',1,0,NULL,1,0,NULL,'Free',259,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(61,'9fd18e83-21d0-4a13-a65b-c266708cb219',NULL,NULL,'192.168.2.62',1,0,NULL,1,0,NULL,'Free',260,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(62,'1f6f024f-b2ed-476d-808c-c856cfefdb92',NULL,NULL,'192.168.2.63',1,0,NULL,1,0,NULL,'Free',261,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(63,'e40a36b1-6306-4ed0-84f8-074797b6d639',NULL,NULL,'192.168.2.64',1,0,NULL,1,0,NULL,'Free',262,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(64,'3e0d4acd-ac43-4f17-9064-6bf890784311',NULL,NULL,'192.168.2.65',1,0,NULL,1,0,NULL,'Free',263,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(65,'c613911d-abdb-42b8-a5ba-c95d7359e5cf',NULL,NULL,'192.168.2.66',1,0,NULL,1,0,NULL,'Free',264,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(66,'c2923aa7-8735-404c-9641-84e2114e8fba',NULL,NULL,'192.168.2.67',1,0,NULL,1,0,NULL,'Free',265,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(67,'3aa41658-a3cf-4555-99e7-ab7d4b03d8ac',NULL,NULL,'192.168.2.68',1,0,NULL,1,0,NULL,'Free',266,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(68,'77a456ae-d3a5-42f7-ae38-46e05b140e22',NULL,NULL,'192.168.2.69',1,0,NULL,1,0,NULL,'Free',267,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(69,'d1c49f48-a7c6-46de-be7d-6b043c9a012f',NULL,NULL,'192.168.2.70',1,0,NULL,1,0,NULL,'Free',268,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(70,'3c2f4d9f-0862-484e-89c0-be3ef9517101',NULL,NULL,'192.168.2.71',1,0,NULL,1,0,NULL,'Free',269,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(71,'41e406d9-8421-4081-b3f6-a54fae1c163c',NULL,NULL,'192.168.2.72',1,0,NULL,1,0,NULL,'Free',270,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(72,'22b6d5d0-322d-4fea-abc9-01ed08eb7f87',NULL,NULL,'192.168.2.73',1,0,NULL,1,0,NULL,'Free',271,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(73,'bacfb9c4-dee7-4650-b447-940048beffb4',NULL,NULL,'192.168.2.74',1,0,NULL,1,0,NULL,'Free',272,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(74,'3a9a6b4a-368e-403d-bb48-10c821bcd18b',NULL,NULL,'192.168.2.75',1,0,NULL,1,0,NULL,'Free',273,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(75,'0cb75691-b95b-45f5-9deb-fef6ce5fce80',NULL,NULL,'192.168.2.76',1,0,NULL,1,0,NULL,'Free',274,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(76,'96bad1b8-aacc-427a-83e5-2d70edc2c0f7',NULL,NULL,'192.168.2.77',1,0,NULL,1,0,NULL,'Free',275,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(77,'8616eb5d-7a06-4710-9fa3-86416acc14bb',NULL,NULL,'192.168.2.78',1,0,NULL,1,0,NULL,'Free',276,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(78,'d7a61032-aacd-4302-9d66-0899275cef06',NULL,NULL,'192.168.2.79',1,0,NULL,1,0,NULL,'Free',277,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(79,'21333d6d-59a1-462b-9b31-3c3755cb930a',NULL,NULL,'192.168.2.80',1,0,NULL,1,0,NULL,'Free',278,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(80,'67ad7e34-39dd-4fcc-befa-b8723e739de6',NULL,NULL,'192.168.2.81',1,0,NULL,1,0,NULL,'Free',279,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(81,'a856e4a8-e391-4291-b704-e6cb2a0091ae',NULL,NULL,'192.168.2.82',1,0,NULL,1,0,NULL,'Free',280,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(82,'bdc1d39d-0167-478d-859d-20ac66b395f7',NULL,NULL,'192.168.2.83',1,0,NULL,1,0,NULL,'Free',281,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(83,'9aa24879-af63-467c-82e1-d1c74f277e61',NULL,NULL,'192.168.2.84',1,0,NULL,1,0,NULL,'Free',282,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(84,'bfc74a50-8a00-4c96-8639-95246f9aef1e',NULL,NULL,'192.168.2.85',1,0,NULL,1,0,NULL,'Free',283,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(85,'faada154-8fc2-4046-b1b0-9eccf914b053',NULL,NULL,'192.168.2.86',1,0,NULL,1,0,NULL,'Free',284,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(86,'a51fe37c-34c0-42fb-9c6b-2a40f1c8ac2d',NULL,NULL,'192.168.2.87',1,0,NULL,1,0,NULL,'Free',285,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(87,'992bd885-8ba8-40a7-8711-d65ae94227bb',NULL,NULL,'192.168.2.88',1,0,NULL,1,0,NULL,'Free',286,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(88,'ee192efe-e7db-44b0-af0a-f70772b3bb80',NULL,NULL,'192.168.2.89',1,0,NULL,1,0,NULL,'Free',287,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(89,'5271d785-3d7a-41b3-91ac-6740ddd62c52',NULL,NULL,'192.168.2.90',1,0,NULL,1,0,NULL,'Free',288,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(90,'1ffb9072-359b-4eb1-bd8b-3ace53279eaf',NULL,NULL,'192.168.2.91',1,0,NULL,1,0,NULL,'Free',289,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(91,'ecd5ad28-7a30-4f2e-8fea-04caf4cc588c',NULL,NULL,'192.168.2.92',1,0,NULL,1,0,NULL,'Free',290,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(92,'9b6ec995-c749-4c6a-b662-189f2495edb0',NULL,NULL,'192.168.2.93',1,0,NULL,1,0,NULL,'Free',291,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(93,'0641128f-f239-4532-bd8c-fa59f95b49ac',NULL,NULL,'192.168.2.94',1,0,NULL,1,0,NULL,'Free',292,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(94,'8226e76b-09d5-4610-ac33-d502a2e5a166',NULL,NULL,'192.168.2.95',1,0,NULL,1,0,NULL,'Free',293,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(95,'14a53055-d168-45b0-8244-a786e3261223',NULL,NULL,'192.168.2.96',1,0,NULL,1,0,NULL,'Free',294,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(96,'2107d7b0-859d-4ef0-ae7d-e57e0b2a33a5',NULL,NULL,'192.168.2.97',1,0,NULL,1,0,NULL,'Free',295,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(97,'9fd4f19a-a763-4f7d-aeb7-559e63e81f21',NULL,NULL,'192.168.2.98',1,0,NULL,1,0,NULL,'Free',296,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(98,'54a52db4-4c53-472d-9073-97203d953d77',NULL,NULL,'192.168.2.99',1,0,NULL,1,0,NULL,'Free',297,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(99,'4ce93fc4-1b54-4151-8575-dea4450c4a62',NULL,NULL,'192.168.2.100',1,0,NULL,1,0,NULL,'Free',298,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(100,'fb0f0c3e-86b7-4ce5-b7a0-40ceb50963f0',NULL,NULL,'192.168.2.101',1,0,NULL,1,0,NULL,'Free',299,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(101,'4400937c-57e2-46e9-95d7-d60c66712bfa',NULL,NULL,'192.168.2.102',1,0,NULL,1,0,NULL,'Free',300,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(102,'98d7f568-f549-417b-9b25-9b436a957564',NULL,NULL,'192.168.2.103',1,0,NULL,1,0,NULL,'Free',301,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(103,'79bfe7d2-fbfc-4f1c-9779-9377adf4f9e0',NULL,NULL,'192.168.2.104',1,0,NULL,1,0,NULL,'Free',302,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(104,'98a7f6f6-8da1-40d0-acf2-aa73a399df60',NULL,NULL,'192.168.2.105',1,0,NULL,1,0,NULL,'Free',303,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(105,'ff50a795-eb05-4855-8710-4547007cfbe2',NULL,NULL,'192.168.2.106',1,0,NULL,1,0,NULL,'Free',304,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(106,'6a12d989-f97b-4df4-8deb-1c80422067e2',NULL,NULL,'192.168.2.107',1,0,NULL,1,0,NULL,'Free',305,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(107,'2a4e4aea-1a43-4ba5-abdc-6584c865a1a6',NULL,NULL,'192.168.2.108',1,0,NULL,1,0,NULL,'Free',306,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(108,'1fa56060-bce0-4bd7-9244-3c532d49f7dd',NULL,NULL,'192.168.2.109',1,0,NULL,1,0,NULL,'Free',307,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(109,'a8094e41-cc00-4c40-b946-edd2f44b3172',NULL,NULL,'192.168.2.110',1,0,NULL,1,0,NULL,'Free',308,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(110,'df997c7e-35bf-4dcb-9729-a143095f2ff8',NULL,NULL,'192.168.2.111',1,0,NULL,1,0,NULL,'Free',309,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(111,'d5b14a7f-e60c-4a9b-a3de-4881987af6f9',NULL,NULL,'192.168.2.112',1,0,NULL,1,0,NULL,'Free',310,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(112,'559b53c9-ab4d-4256-bdab-78307f363b5e',NULL,NULL,'192.168.2.113',1,0,NULL,1,0,NULL,'Free',311,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(113,'e2b18c24-07e2-4375-83c9-01744a34f6bb',NULL,NULL,'192.168.2.114',1,0,NULL,1,0,NULL,'Free',312,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(114,'cc2145e3-8ca9-4b65-8f5e-45c933debf0f',NULL,NULL,'192.168.2.115',1,0,NULL,1,0,NULL,'Free',313,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(115,'c63406ce-0838-49ff-8620-3eab7481b6d7',NULL,NULL,'192.168.2.116',1,0,NULL,1,0,NULL,'Free',314,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(116,'b5897b40-52ec-400c-b624-6618f97f1a88',NULL,NULL,'192.168.2.117',1,0,NULL,1,0,NULL,'Free',315,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(117,'5449a313-6d92-4e20-9223-59c76cd7d5a0',NULL,NULL,'192.168.2.118',1,0,NULL,1,0,NULL,'Free',316,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(118,'080c7be4-4aeb-48e4-a7b8-7024d4d70479',NULL,NULL,'192.168.2.119',1,0,NULL,1,0,NULL,'Free',317,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(119,'11ce2db9-1a45-4f3c-becf-bab7cea51e9f',NULL,NULL,'192.168.2.120',1,0,NULL,1,0,NULL,'Free',318,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(120,'f71f574b-73fb-46d6-9ab8-6c902ba0c556',NULL,NULL,'192.168.2.121',1,0,NULL,1,0,NULL,'Free',319,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(121,'0e264333-49b1-4e2e-a822-8aa6302982ef',NULL,NULL,'192.168.2.122',1,0,NULL,1,0,NULL,'Free',320,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(122,'d5c5f993-2d63-413e-be2e-b8f4b2bf6598',NULL,NULL,'192.168.2.123',1,0,NULL,1,0,NULL,'Free',321,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(123,'582dd5a1-8e8e-4d4f-aa16-175c01aeb4ce',NULL,NULL,'192.168.2.124',1,0,NULL,1,0,NULL,'Free',322,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(124,'1143579d-3c94-4c94-bac8-4c8e74ef831b',NULL,NULL,'192.168.2.125',1,0,NULL,1,0,NULL,'Free',323,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(125,'ee8317ec-c441-4520-a0b6-404d5f25e52a',NULL,NULL,'192.168.2.126',1,0,NULL,1,0,NULL,'Free',324,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(126,'17967c8a-106a-47fa-96fd-bef8a71f8644',NULL,NULL,'192.168.2.127',1,0,NULL,1,0,NULL,'Free',325,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(127,'b38464f7-b394-4e08-b0b2-ccbe08dc60e6',NULL,NULL,'192.168.2.128',1,0,NULL,1,0,NULL,'Free',326,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(128,'59c21a95-e586-4533-8a2e-89c2bb4c379e',NULL,NULL,'192.168.2.129',1,0,NULL,1,0,NULL,'Free',327,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(129,'4544ee25-4e12-4487-8afe-2f6a199c7cb3',NULL,NULL,'192.168.2.130',1,0,NULL,1,0,NULL,'Free',328,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(130,'10afb46e-6952-4800-bb84-5e018ce2d92f',NULL,NULL,'192.168.2.131',1,0,NULL,1,0,NULL,'Free',329,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(131,'abcfcfd8-b643-4bb6-8a3b-8a2493b47c73',NULL,NULL,'192.168.2.132',1,0,NULL,1,0,NULL,'Free',330,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(132,'bdf4324d-621f-4abc-9bf4-ffe18359c9d9',NULL,NULL,'192.168.2.133',1,0,NULL,1,0,NULL,'Free',331,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(133,'5f610cb5-46b9-48fe-90c4-82f6158d53a0',NULL,NULL,'192.168.2.134',1,0,NULL,1,0,NULL,'Free',332,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(134,'ecff01c2-1446-4ea2-8ce8-43d3b82c4a58',NULL,NULL,'192.168.2.135',1,0,NULL,1,0,NULL,'Free',333,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(135,'9f5a9d81-df3d-48d9-b7d7-2816e84c2413',NULL,NULL,'192.168.2.136',1,0,NULL,1,0,NULL,'Free',334,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(136,'99313d83-4680-40fc-852d-547046d8d2fe',NULL,NULL,'192.168.2.137',1,0,NULL,1,0,NULL,'Free',335,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(137,'a1bf1407-fdd9-413d-a5b9-ea6dee0d2ca6',NULL,NULL,'192.168.2.138',1,0,NULL,1,0,NULL,'Free',336,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(138,'2faa1a5f-bce6-4e2b-907e-295c54c1f10c',NULL,NULL,'192.168.2.139',1,0,NULL,1,0,NULL,'Free',337,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(139,'62e4636d-52f2-4445-a9a8-a9e3a72ae243',NULL,NULL,'192.168.2.140',1,0,NULL,1,0,NULL,'Free',338,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(140,'93cb70be-1e65-4acd-a30d-978e7efd0f07',NULL,NULL,'192.168.2.141',1,0,NULL,1,0,NULL,'Free',339,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(141,'b5815b61-ee10-4760-ad28-6862b4dd0ab3',NULL,NULL,'192.168.2.142',1,0,NULL,1,0,NULL,'Free',340,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(142,'4b185777-0fb3-47f1-a9e5-a4cf9c2ba4e4',NULL,NULL,'192.168.2.143',1,0,NULL,1,0,NULL,'Free',341,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(143,'ddea94f4-1c02-4d9c-86b1-4968ba5536bd',NULL,NULL,'192.168.2.144',1,0,NULL,1,0,NULL,'Free',342,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(144,'0688d5d5-2b93-4eef-a770-760cc871a329',NULL,NULL,'192.168.2.145',1,0,NULL,1,0,NULL,'Free',343,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(145,'e2892123-df34-4a56-8d32-297deb0353d9',NULL,NULL,'192.168.2.146',1,0,NULL,1,0,NULL,'Free',344,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(146,'e078b5b8-3842-453c-85c6-6ff931015563',NULL,NULL,'192.168.2.147',1,0,NULL,1,0,NULL,'Free',345,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(147,'dac4620d-612c-4e85-b9ef-6deab79a7c9f',NULL,NULL,'192.168.2.148',1,0,NULL,1,0,NULL,'Free',346,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(148,'565e3132-ae40-4779-87a3-aba566cbadf5',NULL,NULL,'192.168.2.149',1,0,NULL,1,0,NULL,'Free',347,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(149,'a97a5191-b18e-435e-92c6-92210f6272f5',NULL,NULL,'192.168.2.150',1,0,NULL,1,0,NULL,'Free',348,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(150,'8f24ec25-0cd4-4a99-9468-8aae65aa0ead',NULL,NULL,'192.168.2.151',1,0,NULL,1,0,NULL,'Free',349,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(151,'3a726189-0d08-4494-97fd-541c15ff389f',NULL,NULL,'192.168.2.152',1,0,NULL,1,0,NULL,'Free',350,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(152,'f86e5b75-636d-4794-a362-681c0ab5f1e2',NULL,NULL,'192.168.2.153',1,0,NULL,1,0,NULL,'Free',351,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(153,'9f33201c-9fd7-49ed-9888-e9649595a496',NULL,NULL,'192.168.2.154',1,0,NULL,1,0,NULL,'Free',352,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(154,'70b605d9-cb96-4e97-beda-4d19d5009c66',NULL,NULL,'192.168.2.155',1,0,NULL,1,0,NULL,'Free',353,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(155,'940928a9-1965-4539-9390-8f8614b0b3c3',NULL,NULL,'192.168.2.156',1,0,NULL,1,0,NULL,'Free',354,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(156,'0b3d5d43-81b6-4334-b551-5798469a85c9',NULL,NULL,'192.168.2.157',1,0,NULL,1,0,NULL,'Free',355,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(157,'dacde562-e179-41ab-af1f-ed618b6c2134',NULL,NULL,'192.168.2.158',1,0,NULL,1,0,NULL,'Free',356,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(158,'03ef6c26-8b98-4764-830e-6291be22b203',NULL,NULL,'192.168.2.159',1,0,NULL,1,0,NULL,'Free',357,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(159,'ad6732f8-d163-4c8a-a53f-5abb66e586de',NULL,NULL,'192.168.2.160',1,0,NULL,1,0,NULL,'Free',358,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(160,'c9887dfc-a32a-41ee-bf83-a50611561644',NULL,NULL,'192.168.2.161',1,0,NULL,1,0,NULL,'Free',359,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(161,'844ff1b4-11a3-4473-959e-fa566e2ab801',NULL,NULL,'192.168.2.162',1,0,NULL,1,0,NULL,'Free',360,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(162,'47935a19-a824-4308-b587-1ecf9fa96711',NULL,NULL,'192.168.2.163',1,0,NULL,1,0,NULL,'Free',361,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(163,'094c996f-8ed3-4a10-85b6-96a122e387c1',NULL,NULL,'192.168.2.164',1,0,NULL,1,0,NULL,'Free',362,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(164,'e7f15ff2-7ce8-404a-b995-42382c516eac',NULL,NULL,'192.168.2.165',1,0,NULL,1,0,NULL,'Free',363,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(165,'cff4ada9-420c-472f-8cb3-b6f002cdd775',NULL,NULL,'192.168.2.166',1,0,NULL,1,0,NULL,'Free',364,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(166,'39d4bf06-0049-404f-9ecb-c9d4fa6c5643',NULL,NULL,'192.168.2.167',1,0,NULL,1,0,NULL,'Free',365,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(167,'545c0566-a866-44e4-a094-0fdcfa9a67f0',NULL,NULL,'192.168.2.168',1,0,NULL,1,0,NULL,'Free',366,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(168,'c727afc2-8f3f-4861-8451-909db13ebd04',NULL,NULL,'192.168.2.169',1,0,NULL,1,0,NULL,'Free',367,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(169,'24bc0522-3081-4de8-a947-074cdd7f6280',NULL,NULL,'192.168.2.170',1,0,NULL,1,0,NULL,'Free',368,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(170,'c72a77bd-15a1-416c-9e0c-6c89ed710fb5',NULL,NULL,'192.168.2.171',1,0,NULL,1,0,NULL,'Free',369,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(171,'96cd1c90-9ddf-48ee-a65c-adb02bb08411',NULL,NULL,'192.168.2.172',1,0,NULL,1,0,NULL,'Free',370,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(172,'64fad00c-6328-420d-ba8d-fcb4949daf93',NULL,NULL,'192.168.2.173',1,0,NULL,1,0,NULL,'Free',371,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(173,'19100a5c-acae-47cd-b06a-161b222acb58',NULL,NULL,'192.168.2.174',1,0,NULL,1,0,NULL,'Free',372,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(174,'4c18e834-5018-45ec-ab51-f160b7e713a6',NULL,NULL,'192.168.2.175',1,0,NULL,1,0,NULL,'Free',373,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(175,'2d058fdc-b73c-4f7a-8e0c-2a87f22deaea',NULL,NULL,'192.168.2.176',1,0,NULL,1,0,NULL,'Free',374,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(176,'ec5694d7-8367-4def-8162-ebee4fb10b09',NULL,NULL,'192.168.2.177',1,0,NULL,1,0,NULL,'Free',375,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(177,'552f704d-42a9-4669-83f4-8af9b60e1ff1',NULL,NULL,'192.168.2.178',1,0,NULL,1,0,NULL,'Free',376,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(178,'9ac30232-8870-4f4a-86db-4d9d9f910bfd',NULL,NULL,'192.168.2.179',1,0,NULL,1,0,NULL,'Free',377,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(179,'c96c3ce6-9c7e-4885-a96f-e4238c232814',NULL,NULL,'192.168.2.180',1,0,NULL,1,0,NULL,'Free',378,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(180,'e294f609-a4a9-43ca-9a47-59531eb844c9',NULL,NULL,'192.168.2.181',1,0,NULL,1,0,NULL,'Free',379,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(181,'05e8593f-0e96-4e2b-8f81-9b4e8d2ae3c0',NULL,NULL,'192.168.2.182',1,0,NULL,1,0,NULL,'Free',380,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(182,'f68f5ee7-d5af-477d-ad8a-3731b0cb30c6',NULL,NULL,'192.168.2.183',1,0,NULL,1,0,NULL,'Free',381,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(183,'e2fc82d4-f85c-4cc0-95ce-d1eed2cc6581',NULL,NULL,'192.168.2.184',1,0,NULL,1,0,NULL,'Free',382,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(184,'8f1076ce-df19-4e4c-b06c-652c79da8156',NULL,NULL,'192.168.2.185',1,0,NULL,1,0,NULL,'Free',383,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(185,'1a55c97a-2d9c-428f-9aa6-5e330be77922',NULL,NULL,'192.168.2.186',1,0,NULL,1,0,NULL,'Free',384,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(186,'26c6a9dd-ca7e-4caa-9c84-dff1cf342483',NULL,NULL,'192.168.2.187',1,0,NULL,1,0,NULL,'Free',385,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(187,'c692f78c-4135-4c39-80f7-24849b0c29c9',NULL,NULL,'192.168.2.188',1,0,NULL,1,0,NULL,'Free',386,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(188,'838fe231-9532-4edc-8359-d0616eadfb45',NULL,NULL,'192.168.2.189',1,0,NULL,1,0,NULL,'Free',387,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(189,'bdce4e27-5636-4ed0-a239-eecd0bf0c1ed',NULL,NULL,'192.168.2.190',1,0,NULL,1,0,NULL,'Free',388,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(190,'67fb55b4-b1d4-4973-a262-dee6061b56fc',NULL,NULL,'192.168.2.191',1,0,NULL,1,0,NULL,'Free',389,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(191,'cb1cef03-854e-484d-8928-685909503935',NULL,NULL,'192.168.2.192',1,0,NULL,1,0,NULL,'Free',390,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(192,'40a465a1-4fab-477b-815f-06fa726ef027',NULL,NULL,'192.168.2.193',1,0,NULL,1,0,NULL,'Free',391,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(193,'f6106622-d19e-4565-b330-ce7fe0520fb4',NULL,NULL,'192.168.2.194',1,0,NULL,1,0,NULL,'Free',392,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(194,'9128c38b-91f5-49bf-944f-06b212889c16',NULL,NULL,'192.168.2.195',1,0,NULL,1,0,NULL,'Free',393,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(195,'78cbff35-7690-445d-9527-a3087dd43e4f',NULL,NULL,'192.168.2.196',1,0,NULL,1,0,NULL,'Free',394,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(196,'14e8e6ac-c5e1-4e59-96d6-d25113b032fc',NULL,NULL,'192.168.2.197',1,0,NULL,1,0,NULL,'Free',395,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(197,'2a753239-f644-4e33-aa74-49a034682a91',NULL,NULL,'192.168.2.198',1,0,NULL,1,0,NULL,'Free',396,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(198,'4736bfc5-0ffa-477e-932a-3f2134097289',NULL,NULL,'192.168.2.199',1,0,NULL,1,0,NULL,'Free',397,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL),(199,'33777436-38dc-4264-be8c-a0f5d0864063',NULL,NULL,'192.168.2.200',1,0,NULL,1,0,NULL,'Free',398,200,NULL,200,0,NULL,NULL,0,1,NULL,NULL);
/*!40000 ALTER TABLE `user_ip_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_ip_address_details`
--

DROP TABLE IF EXISTS `user_ip_address_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_ip_address_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_ip_address_id` bigint(20) unsigned NOT NULL COMMENT 'User ip address id',
  `name` varchar(255) NOT NULL,
  `value` varchar(1024) NOT NULL,
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'True if the detail can be displayed to the end user',
  PRIMARY KEY (`id`),
  KEY `fk_user_ip_address_details__user_ip_address_id` (`user_ip_address_id`),
  CONSTRAINT `fk_user_ip_address_details__user_ip_address_id` FOREIGN KEY (`user_ip_address_id`) REFERENCES `user_ip_address` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_ip_address_details`
--

LOCK TABLES `user_ip_address_details` WRITE;
/*!40000 ALTER TABLE `user_ip_address_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_ip_address_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_ipv6_address`
--

DROP TABLE IF EXISTS `user_ipv6_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_ipv6_address` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(40) DEFAULT NULL,
  `account_id` bigint(20) unsigned DEFAULT NULL,
  `domain_id` bigint(20) unsigned DEFAULT NULL,
  `ip_address` char(50) NOT NULL,
  `data_center_id` bigint(20) unsigned NOT NULL COMMENT 'zone that it belongs to',
  `vlan_id` bigint(20) unsigned NOT NULL,
  `state` char(32) NOT NULL DEFAULT 'Free' COMMENT 'state of the ip address',
  `mac_address` varchar(40) NOT NULL COMMENT 'mac address of this ip',
  `source_network_id` bigint(20) unsigned NOT NULL COMMENT 'network id ip belongs to',
  `network_id` bigint(20) unsigned DEFAULT NULL COMMENT 'network this public ip address is associated with',
  `physical_network_id` bigint(20) unsigned NOT NULL COMMENT 'physical network id that this configuration is based on',
  `created` datetime DEFAULT NULL COMMENT 'Date this ip was allocated to someone',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `ip_address` (`ip_address`,`source_network_id`),
  UNIQUE KEY `uc_user_ipv6_address__uuid` (`uuid`),
  KEY `fk_user_ipv6_address__source_network_id` (`source_network_id`),
  KEY `fk_user_ipv6_address__network_id` (`network_id`),
  KEY `fk_user_ipv6_address__account_id` (`account_id`),
  KEY `fk_user_ipv6_address__vlan_id` (`vlan_id`),
  KEY `fk_user_ipv6_address__data_center_id` (`data_center_id`),
  KEY `fk_user_ipv6_address__physical_network_id` (`physical_network_id`),
  CONSTRAINT `fk_user_ipv6_address__source_network_id` FOREIGN KEY (`source_network_id`) REFERENCES `networks` (`id`),
  CONSTRAINT `fk_user_ipv6_address__network_id` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`),
  CONSTRAINT `fk_user_ipv6_address__account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `fk_user_ipv6_address__vlan_id` FOREIGN KEY (`vlan_id`) REFERENCES `vlan` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_user_ipv6_address__data_center_id` FOREIGN KEY (`data_center_id`) REFERENCES `data_center` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_user_ipv6_address__physical_network_id` FOREIGN KEY (`physical_network_id`) REFERENCES `physical_network` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_ipv6_address`
--

LOCK TABLES `user_ipv6_address` WRITE;
/*!40000 ALTER TABLE `user_ipv6_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_ipv6_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_statistics`
--

DROP TABLE IF EXISTS `user_statistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_statistics` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `data_center_id` bigint(20) unsigned NOT NULL,
  `account_id` bigint(20) unsigned NOT NULL,
  `public_ip_address` char(40) DEFAULT NULL,
  `device_id` bigint(20) unsigned NOT NULL,
  `device_type` varchar(32) NOT NULL,
  `network_id` bigint(20) unsigned DEFAULT NULL,
  `net_bytes_received` bigint(20) unsigned NOT NULL DEFAULT '0',
  `net_bytes_sent` bigint(20) unsigned NOT NULL DEFAULT '0',
  `current_bytes_received` bigint(20) unsigned NOT NULL DEFAULT '0',
  `current_bytes_sent` bigint(20) unsigned NOT NULL DEFAULT '0',
  `agg_bytes_received` bigint(20) unsigned NOT NULL DEFAULT '0',
  `agg_bytes_sent` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `account_id` (`account_id`,`data_center_id`,`public_ip_address`,`device_id`,`device_type`),
  KEY `i_user_statistics__account_id` (`account_id`),
  KEY `i_user_statistics__account_id_data_center_id` (`account_id`,`data_center_id`),
  CONSTRAINT `fk_user_statistics__account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_statistics`
--

LOCK TABLES `user_statistics` WRITE;
/*!40000 ALTER TABLE `user_statistics` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_statistics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `user_view`
--

DROP TABLE IF EXISTS `user_view`;
/*!50001 DROP VIEW IF EXISTS `user_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `user_view` (
  `id` tinyint NOT NULL,
  `uuid` tinyint NOT NULL,
  `username` tinyint NOT NULL,
  `password` tinyint NOT NULL,
  `firstname` tinyint NOT NULL,
  `lastname` tinyint NOT NULL,
  `email` tinyint NOT NULL,
  `state` tinyint NOT NULL,
  `api_key` tinyint NOT NULL,
  `secret_key` tinyint NOT NULL,
  `created` tinyint NOT NULL,
  `removed` tinyint NOT NULL,
  `timezone` tinyint NOT NULL,
  `registration_token` tinyint NOT NULL,
  `is_registered` tinyint NOT NULL,
  `incorrect_login_attempts` tinyint NOT NULL,
  `default` tinyint NOT NULL,
  `account_id` tinyint NOT NULL,
  `account_uuid` tinyint NOT NULL,
  `account_name` tinyint NOT NULL,
  `account_type` tinyint NOT NULL,
  `domain_id` tinyint NOT NULL,
  `domain_uuid` tinyint NOT NULL,
  `domain_name` tinyint NOT NULL,
  `domain_path` tinyint NOT NULL,
  `job_id` tinyint NOT NULL,
  `job_uuid` tinyint NOT NULL,
  `job_status` tinyint NOT NULL,
  `job_account_id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `user_vm`
--

DROP TABLE IF EXISTS `user_vm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_vm` (
  `id` bigint(20) unsigned NOT NULL,
  `iso_id` bigint(20) unsigned DEFAULT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `user_data` mediumtext,
  `update_parameters` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Defines if the parameters have been updated for the vm',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  CONSTRAINT `fk_user_vm__id` FOREIGN KEY (`id`) REFERENCES `vm_instance` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_vm`
--

LOCK TABLES `user_vm` WRITE;
/*!40000 ALTER TABLE `user_vm` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_vm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_vm_clone_setting`
--

DROP TABLE IF EXISTS `user_vm_clone_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_vm_clone_setting` (
  `vm_id` bigint(20) unsigned NOT NULL COMMENT 'guest VM id',
  `clone_type` varchar(10) NOT NULL COMMENT 'Full or Linked Clone (applicable to VMs on ESX)',
  PRIMARY KEY (`vm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_vm_clone_setting`
--

LOCK TABLES `user_vm_clone_setting` WRITE;
/*!40000 ALTER TABLE `user_vm_clone_setting` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_vm_clone_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_vm_details`
--

DROP TABLE IF EXISTS `user_vm_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_vm_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `vm_id` bigint(20) unsigned NOT NULL COMMENT 'vm id',
  `name` varchar(255) NOT NULL,
  `value` varchar(1024) NOT NULL,
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'True if the detail can be displayed to the end user',
  PRIMARY KEY (`id`),
  KEY `fk_user_vm_details__vm_id` (`vm_id`),
  CONSTRAINT `fk_user_vm_details__vm_id` FOREIGN KEY (`vm_id`) REFERENCES `vm_instance` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_vm_details`
--

LOCK TABLES `user_vm_details` WRITE;
/*!40000 ALTER TABLE `user_vm_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_vm_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `user_vm_view`
--

DROP TABLE IF EXISTS `user_vm_view`;
/*!50001 DROP VIEW IF EXISTS `user_vm_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `user_vm_view` (
  `id` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `display_name` tinyint NOT NULL,
  `user_data` tinyint NOT NULL,
  `account_id` tinyint NOT NULL,
  `account_uuid` tinyint NOT NULL,
  `account_name` tinyint NOT NULL,
  `account_type` tinyint NOT NULL,
  `domain_id` tinyint NOT NULL,
  `domain_uuid` tinyint NOT NULL,
  `domain_name` tinyint NOT NULL,
  `domain_path` tinyint NOT NULL,
  `project_id` tinyint NOT NULL,
  `project_uuid` tinyint NOT NULL,
  `project_name` tinyint NOT NULL,
  `instance_group_id` tinyint NOT NULL,
  `instance_group_uuid` tinyint NOT NULL,
  `instance_group_name` tinyint NOT NULL,
  `uuid` tinyint NOT NULL,
  `last_host_id` tinyint NOT NULL,
  `type` tinyint NOT NULL,
  `vnc_password` tinyint NOT NULL,
  `limit_cpu_use` tinyint NOT NULL,
  `created` tinyint NOT NULL,
  `state` tinyint NOT NULL,
  `removed` tinyint NOT NULL,
  `ha_enabled` tinyint NOT NULL,
  `hypervisor_type` tinyint NOT NULL,
  `instance_name` tinyint NOT NULL,
  `guest_os_id` tinyint NOT NULL,
  `display_vm` tinyint NOT NULL,
  `guest_os_uuid` tinyint NOT NULL,
  `pod_id` tinyint NOT NULL,
  `pod_uuid` tinyint NOT NULL,
  `private_ip_address` tinyint NOT NULL,
  `private_mac_address` tinyint NOT NULL,
  `vm_type` tinyint NOT NULL,
  `data_center_id` tinyint NOT NULL,
  `data_center_uuid` tinyint NOT NULL,
  `data_center_name` tinyint NOT NULL,
  `security_group_enabled` tinyint NOT NULL,
  `data_center_type` tinyint NOT NULL,
  `host_id` tinyint NOT NULL,
  `host_uuid` tinyint NOT NULL,
  `host_name` tinyint NOT NULL,
  `template_id` tinyint NOT NULL,
  `template_uuid` tinyint NOT NULL,
  `template_name` tinyint NOT NULL,
  `template_display_text` tinyint NOT NULL,
  `password_enabled` tinyint NOT NULL,
  `iso_id` tinyint NOT NULL,
  `iso_uuid` tinyint NOT NULL,
  `iso_name` tinyint NOT NULL,
  `iso_display_text` tinyint NOT NULL,
  `service_offering_id` tinyint NOT NULL,
  `service_offering_uuid` tinyint NOT NULL,
  `disk_offering_uuid` tinyint NOT NULL,
  `disk_offering_id` tinyint NOT NULL,
  `cpu` tinyint NOT NULL,
  `speed` tinyint NOT NULL,
  `ram_size` tinyint NOT NULL,
  `service_offering_name` tinyint NOT NULL,
  `disk_offering_name` tinyint NOT NULL,
  `pool_id` tinyint NOT NULL,
  `pool_uuid` tinyint NOT NULL,
  `pool_type` tinyint NOT NULL,
  `volume_id` tinyint NOT NULL,
  `volume_uuid` tinyint NOT NULL,
  `volume_device_id` tinyint NOT NULL,
  `volume_type` tinyint NOT NULL,
  `security_group_id` tinyint NOT NULL,
  `security_group_uuid` tinyint NOT NULL,
  `security_group_name` tinyint NOT NULL,
  `security_group_description` tinyint NOT NULL,
  `nic_id` tinyint NOT NULL,
  `nic_uuid` tinyint NOT NULL,
  `network_id` tinyint NOT NULL,
  `ip_address` tinyint NOT NULL,
  `ip6_address` tinyint NOT NULL,
  `ip6_gateway` tinyint NOT NULL,
  `ip6_cidr` tinyint NOT NULL,
  `is_default_nic` tinyint NOT NULL,
  `gateway` tinyint NOT NULL,
  `netmask` tinyint NOT NULL,
  `mac_address` tinyint NOT NULL,
  `broadcast_uri` tinyint NOT NULL,
  `isolation_uri` tinyint NOT NULL,
  `vpc_id` tinyint NOT NULL,
  `vpc_uuid` tinyint NOT NULL,
  `network_uuid` tinyint NOT NULL,
  `network_name` tinyint NOT NULL,
  `traffic_type` tinyint NOT NULL,
  `guest_type` tinyint NOT NULL,
  `public_ip_id` tinyint NOT NULL,
  `public_ip_uuid` tinyint NOT NULL,
  `public_ip_address` tinyint NOT NULL,
  `keypair_name` tinyint NOT NULL,
  `tag_id` tinyint NOT NULL,
  `tag_uuid` tinyint NOT NULL,
  `tag_key` tinyint NOT NULL,
  `tag_value` tinyint NOT NULL,
  `tag_domain_id` tinyint NOT NULL,
  `tag_account_id` tinyint NOT NULL,
  `tag_resource_id` tinyint NOT NULL,
  `tag_resource_uuid` tinyint NOT NULL,
  `tag_resource_type` tinyint NOT NULL,
  `tag_customer` tinyint NOT NULL,
  `job_id` tinyint NOT NULL,
  `job_uuid` tinyint NOT NULL,
  `job_status` tinyint NOT NULL,
  `job_account_id` tinyint NOT NULL,
  `affinity_group_id` tinyint NOT NULL,
  `affinity_group_uuid` tinyint NOT NULL,
  `affinity_group_name` tinyint NOT NULL,
  `affinity_group_description` tinyint NOT NULL,
  `dynamically_scalable` tinyint NOT NULL,
  `detail_name` tinyint NOT NULL,
  `detail_value` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `version`
--

DROP TABLE IF EXISTS `version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `version` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `version` char(40) NOT NULL COMMENT 'version',
  `updated` datetime NOT NULL COMMENT 'Date this version table was updated',
  `step` char(32) NOT NULL COMMENT 'Step in the upgrade to this version',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `version` (`version`),
  KEY `i_version__version` (`version`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `version`
--

LOCK TABLES `version` WRITE;
/*!40000 ALTER TABLE `version` DISABLE KEYS */;
INSERT INTO `version` VALUES (1,'4.0.0','2014-06-26 02:22:10','Complete'),(2,'4.1.0','2014-06-26 02:22:16','Complete'),(3,'4.2.0','2014-06-26 02:22:16','Complete'),(4,'4.2.1','2014-06-26 02:22:16','Complete'),(5,'4.3.0','2014-06-26 02:22:16','Complete'),(6,'4.4.0','2014-06-26 02:22:16','Complete');
/*!40000 ALTER TABLE `version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vgpu_types`
--

DROP TABLE IF EXISTS `vgpu_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vgpu_types` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `gpu_group_id` bigint(20) unsigned NOT NULL,
  `vgpu_type` varchar(40) NOT NULL COMMENT 'vgpu type supported by this gpu group',
  `video_ram` bigint(20) unsigned DEFAULT NULL COMMENT 'video RAM for this vgpu type',
  `max_heads` bigint(20) unsigned DEFAULT NULL COMMENT 'maximum displays per user',
  `max_resolution_x` bigint(20) unsigned DEFAULT NULL COMMENT 'maximum X resolution per display',
  `max_resolution_y` bigint(20) unsigned DEFAULT NULL COMMENT 'maximum Y resolution per display',
  `max_vgpu_per_pgpu` bigint(20) unsigned DEFAULT NULL COMMENT 'max number of vgpus per physical gpu (pgpu)',
  `remaining_capacity` bigint(20) unsigned DEFAULT NULL COMMENT 'remaining vgpu can be created with this vgpu_type on the given gpu group',
  `max_capacity` bigint(20) unsigned DEFAULT NULL COMMENT 'maximum vgpu can be created with this vgpu_type on the given gpu group',
  PRIMARY KEY (`id`),
  KEY `fk_vgpu_types__gpu_group_id` (`gpu_group_id`),
  CONSTRAINT `fk_vgpu_types__gpu_group_id` FOREIGN KEY (`gpu_group_id`) REFERENCES `host_gpu_groups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vgpu_types`
--

LOCK TABLES `vgpu_types` WRITE;
/*!40000 ALTER TABLE `vgpu_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `vgpu_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `virtual_router_providers`
--

DROP TABLE IF EXISTS `virtual_router_providers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `virtual_router_providers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `nsp_id` bigint(20) unsigned NOT NULL COMMENT 'Network Service Provider ID',
  `uuid` varchar(40) DEFAULT NULL,
  `type` varchar(255) NOT NULL COMMENT 'Virtual router, or ElbVM',
  `enabled` int(1) NOT NULL COMMENT 'Enabled or disabled',
  `removed` datetime DEFAULT NULL COMMENT 'date removed if not null',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_virtual_router_providers__uuid` (`uuid`),
  KEY `fk_virtual_router_providers__nsp_id` (`nsp_id`),
  CONSTRAINT `fk_virtual_router_providers__nsp_id` FOREIGN KEY (`nsp_id`) REFERENCES `physical_network_service_providers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `virtual_router_providers`
--

LOCK TABLES `virtual_router_providers` WRITE;
/*!40000 ALTER TABLE `virtual_router_providers` DISABLE KEYS */;
INSERT INTO `virtual_router_providers` VALUES (1,1,'f6b02ee8-c6dc-4025-937c-efe0702bf09e','VirtualRouter',1,NULL),(2,3,'c71f39d5-bc58-4f8c-b36d-233ef36ce717','VPCVirtualRouter',1,NULL),(3,4,'3459a2af-15c6-4534-8bca-aea13cde00b9','InternalLbVm',1,NULL);
/*!40000 ALTER TABLE `virtual_router_providers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `virtual_supervisor_module`
--

DROP TABLE IF EXISTS `virtual_supervisor_module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `virtual_supervisor_module` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uuid` varchar(40) DEFAULT NULL,
  `host_id` bigint(20) NOT NULL,
  `vsm_name` varchar(255) DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `ipaddr` varchar(80) NOT NULL,
  `management_vlan` int(32) DEFAULT NULL,
  `control_vlan` int(32) DEFAULT NULL,
  `packet_vlan` int(32) DEFAULT NULL,
  `storage_vlan` int(32) DEFAULT NULL,
  `vsm_domain_id` bigint(20) unsigned DEFAULT NULL,
  `config_mode` varchar(20) DEFAULT NULL,
  `config_state` varchar(20) DEFAULT NULL,
  `vsm_device_state` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `virtual_supervisor_module`
--

LOCK TABLES `virtual_supervisor_module` WRITE;
/*!40000 ALTER TABLE `virtual_supervisor_module` DISABLE KEYS */;
/*!40000 ALTER TABLE `virtual_supervisor_module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vlan`
--

DROP TABLE IF EXISTS `vlan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vlan` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(40) DEFAULT NULL,
  `vlan_id` varchar(255) DEFAULT NULL,
  `vlan_gateway` varchar(255) DEFAULT NULL,
  `vlan_netmask` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `vlan_type` varchar(255) DEFAULT NULL,
  `data_center_id` bigint(20) unsigned NOT NULL,
  `network_id` bigint(20) unsigned NOT NULL COMMENT 'id of corresponding network offering',
  `physical_network_id` bigint(20) unsigned NOT NULL COMMENT 'physical network id that this configuration is based on',
  `ip6_gateway` varchar(255) DEFAULT NULL,
  `ip6_cidr` varchar(255) DEFAULT NULL,
  `ip6_range` varchar(255) DEFAULT NULL,
  `removed` datetime DEFAULT NULL COMMENT 'date removed',
  `created` datetime DEFAULT NULL COMMENT 'date created',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `uc_vlan__uuid` (`uuid`),
  KEY `fk_vlan__data_center_id` (`data_center_id`),
  KEY `fk_vlan__physical_network_id` (`physical_network_id`),
  CONSTRAINT `fk_vlan__data_center_id` FOREIGN KEY (`data_center_id`) REFERENCES `data_center` (`id`),
  CONSTRAINT `fk_vlan__physical_network_id` FOREIGN KEY (`physical_network_id`) REFERENCES `physical_network` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vlan`
--

LOCK TABLES `vlan` WRITE;
/*!40000 ALTER TABLE `vlan` DISABLE KEYS */;
INSERT INTO `vlan` VALUES (1,'6da91a35-b828-475f-adaf-650fdf57d4f0','vlan://50','192.168.2.1','255.255.255.0','192.168.2.2-192.168.2.200','VirtualNetwork',1,200,200,NULL,NULL,NULL,NULL,'2014-06-26 02:27:27');
/*!40000 ALTER TABLE `vlan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vm_compute_tags`
--

DROP TABLE IF EXISTS `vm_compute_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vm_compute_tags` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `vm_id` bigint(20) unsigned NOT NULL COMMENT 'vm id',
  `compute_tag` varchar(255) NOT NULL COMMENT 'name of tag',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vm_compute_tags`
--

LOCK TABLES `vm_compute_tags` WRITE;
/*!40000 ALTER TABLE `vm_compute_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `vm_compute_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vm_disk_statistics`
--

DROP TABLE IF EXISTS `vm_disk_statistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vm_disk_statistics` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `data_center_id` bigint(20) unsigned NOT NULL,
  `account_id` bigint(20) unsigned NOT NULL,
  `vm_id` bigint(20) unsigned NOT NULL,
  `volume_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `net_io_read` bigint(20) unsigned NOT NULL DEFAULT '0',
  `net_io_write` bigint(20) unsigned NOT NULL DEFAULT '0',
  `current_io_read` bigint(20) unsigned NOT NULL DEFAULT '0',
  `current_io_write` bigint(20) unsigned NOT NULL DEFAULT '0',
  `agg_io_read` bigint(20) unsigned NOT NULL DEFAULT '0',
  `agg_io_write` bigint(20) unsigned NOT NULL DEFAULT '0',
  `net_bytes_read` bigint(20) unsigned NOT NULL DEFAULT '0',
  `net_bytes_write` bigint(20) unsigned NOT NULL DEFAULT '0',
  `current_bytes_read` bigint(20) unsigned NOT NULL DEFAULT '0',
  `current_bytes_write` bigint(20) unsigned NOT NULL DEFAULT '0',
  `agg_bytes_read` bigint(20) unsigned NOT NULL DEFAULT '0',
  `agg_bytes_write` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `account_id` (`account_id`,`data_center_id`,`vm_id`,`volume_id`),
  KEY `i_vm_disk_statistics__account_id` (`account_id`),
  KEY `i_vm_disk_statistics__account_id_data_center_id` (`account_id`,`data_center_id`),
  CONSTRAINT `fk_vm_disk_statistics__account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vm_disk_statistics`
--

LOCK TABLES `vm_disk_statistics` WRITE;
/*!40000 ALTER TABLE `vm_disk_statistics` DISABLE KEYS */;
/*!40000 ALTER TABLE `vm_disk_statistics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vm_instance`
--

DROP TABLE IF EXISTS `vm_instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vm_instance` (
  `id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `uuid` varchar(40) DEFAULT NULL,
  `instance_name` varchar(255) NOT NULL COMMENT 'name of the vm instance running on the hosts',
  `state` varchar(32) NOT NULL,
  `vm_template_id` bigint(20) unsigned DEFAULT NULL,
  `guest_os_id` bigint(20) unsigned NOT NULL,
  `private_mac_address` varchar(17) DEFAULT NULL,
  `private_ip_address` char(40) DEFAULT NULL,
  `pod_id` bigint(20) unsigned DEFAULT NULL,
  `data_center_id` bigint(20) unsigned NOT NULL COMMENT 'Data Center the instance belongs to',
  `host_id` bigint(20) unsigned DEFAULT NULL,
  `last_host_id` bigint(20) unsigned DEFAULT NULL COMMENT 'tentative host for first run or last host that it has been running on',
  `proxy_id` bigint(20) unsigned DEFAULT NULL COMMENT 'console proxy allocated in previous session',
  `proxy_assign_time` datetime DEFAULT NULL COMMENT 'time when console proxy was assigned',
  `vnc_password` varchar(255) NOT NULL COMMENT 'vnc password',
  `ha_enabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Should HA be enabled for this VM',
  `limit_cpu_use` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Limit the cpu usage to service offering',
  `update_count` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'date state was updated',
  `update_time` datetime DEFAULT NULL COMMENT 'date the destroy was requested',
  `created` datetime NOT NULL COMMENT 'date created',
  `removed` datetime DEFAULT NULL COMMENT 'date removed if not null',
  `type` varchar(32) NOT NULL COMMENT 'type of vm it is',
  `vm_type` varchar(32) NOT NULL COMMENT 'vm type',
  `account_id` bigint(20) unsigned NOT NULL COMMENT 'user id of owner',
  `domain_id` bigint(20) unsigned NOT NULL,
  `service_offering_id` bigint(20) unsigned NOT NULL COMMENT 'service offering id',
  `reservation_id` char(40) DEFAULT NULL COMMENT 'reservation id',
  `hypervisor_type` char(32) DEFAULT NULL COMMENT 'hypervisor type',
  `disk_offering_id` bigint(20) unsigned DEFAULT NULL,
  `owner` varchar(255) DEFAULT NULL,
  `host_name` varchar(255) DEFAULT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `desired_state` varchar(32) DEFAULT NULL,
  `dynamically_scalable` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'true if VM contains XS/VMWare tools inorder to support dynamic scaling of VM cpu/memory',
  `display_vm` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Should vm instance be displayed to the end user',
  `power_state` varchar(74) DEFAULT 'PowerUnknown',
  `power_state_update_time` datetime DEFAULT NULL,
  `power_state_update_count` int(11) DEFAULT '0',
  `power_host` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `uc_vm_instance_uuid` (`uuid`),
  KEY `i_vm_instance__removed` (`removed`),
  KEY `i_vm_instance__type` (`type`),
  KEY `i_vm_instance__pod_id` (`pod_id`),
  KEY `i_vm_instance__update_time` (`update_time`),
  KEY `i_vm_instance__update_count` (`update_count`),
  KEY `i_vm_instance__state` (`state`),
  KEY `i_vm_instance__data_center_id` (`data_center_id`),
  KEY `fk_vm_instance__host_id` (`host_id`),
  KEY `fk_vm_instance__last_host_id` (`last_host_id`),
  KEY `i_vm_instance__template_id` (`vm_template_id`),
  KEY `fk_vm_instance__account_id` (`account_id`),
  KEY `fk_vm_instance__service_offering_id` (`service_offering_id`),
  KEY `fk_vm_instance__power_host` (`power_host`),
  CONSTRAINT `fk_vm_instance__account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `fk_vm_instance__host_id` FOREIGN KEY (`host_id`) REFERENCES `host` (`id`),
  CONSTRAINT `fk_vm_instance__last_host_id` FOREIGN KEY (`last_host_id`) REFERENCES `host` (`id`),
  CONSTRAINT `fk_vm_instance__power_host` FOREIGN KEY (`power_host`) REFERENCES `host` (`id`),
  CONSTRAINT `fk_vm_instance__service_offering_id` FOREIGN KEY (`service_offering_id`) REFERENCES `service_offering` (`id`),
  CONSTRAINT `fk_vm_instance__template_id` FOREIGN KEY (`vm_template_id`) REFERENCES `vm_template` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vm_instance`
--

LOCK TABLES `vm_instance` WRITE;
/*!40000 ALTER TABLE `vm_instance` DISABLE KEYS */;
INSERT INTO `vm_instance` VALUES (1,'v-1-VM','284dd49a-5922-401c-b68d-b73f26095fc7','v-1-VM','Running',100,15,'06:be:e8:00:00:61','172.16.15.98',1,1,1,1,NULL,NULL,'e993700d73b68c72',0,0,3,'2014-06-26 02:28:00','2014-06-26 02:27:57',NULL,'ConsoleProxy','ConsoleProxy',1,1,9,'84d9c349-c24b-4df6-a59a-e5e0fa33c96b','Simulator',NULL,NULL,NULL,NULL,NULL,0,1,NULL,NULL,0,NULL),(2,'s-2-VM','250828fb-3829-427c-a2bc-5b8e68ced882','s-2-VM','Running',100,15,'06:6e:d4:00:00:23','172.16.15.36',1,1,3,3,NULL,NULL,'4e12675ddfa34ac8',0,0,3,'2014-06-26 02:28:00','2014-06-26 02:27:58',NULL,'SecondaryStorageVm','SecondaryStorageVm',1,1,10,'757c5413-7e8f-4a79-9e93-04be9c524687','Simulator',NULL,NULL,NULL,NULL,NULL,0,1,NULL,NULL,0,NULL);
/*!40000 ALTER TABLE `vm_instance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vm_network_map`
--

DROP TABLE IF EXISTS `vm_network_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vm_network_map` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `vm_id` bigint(20) unsigned NOT NULL COMMENT 'vm id',
  `network_id` bigint(20) unsigned NOT NULL COMMENT 'network id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vm_network_map`
--

LOCK TABLES `vm_network_map` WRITE;
/*!40000 ALTER TABLE `vm_network_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `vm_network_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vm_reservation`
--

DROP TABLE IF EXISTS `vm_reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vm_reservation` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uuid` varchar(40) NOT NULL COMMENT 'reservation id',
  `vm_id` bigint(20) unsigned NOT NULL COMMENT 'vm id',
  `data_center_id` bigint(20) unsigned NOT NULL COMMENT 'zone id',
  `pod_id` bigint(20) unsigned NOT NULL COMMENT 'pod id',
  `cluster_id` bigint(20) unsigned NOT NULL COMMENT 'cluster id',
  `host_id` bigint(20) unsigned NOT NULL COMMENT 'host id',
  `created` datetime DEFAULT NULL COMMENT 'date created',
  `removed` datetime DEFAULT NULL COMMENT 'date removed if not null',
  `deployment_planner` varchar(40) DEFAULT NULL COMMENT 'Preferred deployment planner for the vm',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_vm_reservation__uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vm_reservation`
--

LOCK TABLES `vm_reservation` WRITE;
/*!40000 ALTER TABLE `vm_reservation` DISABLE KEYS */;
/*!40000 ALTER TABLE `vm_reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vm_root_disk_tags`
--

DROP TABLE IF EXISTS `vm_root_disk_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vm_root_disk_tags` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `vm_id` bigint(20) unsigned NOT NULL COMMENT 'vm id',
  `root_disk_tag` varchar(255) NOT NULL COMMENT 'name of tag',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vm_root_disk_tags`
--

LOCK TABLES `vm_root_disk_tags` WRITE;
/*!40000 ALTER TABLE `vm_root_disk_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `vm_root_disk_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vm_snapshot_details`
--

DROP TABLE IF EXISTS `vm_snapshot_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vm_snapshot_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `vm_snapshot_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'True if the detail can be displayed to the end user',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vm_snapshot_details`
--

LOCK TABLES `vm_snapshot_details` WRITE;
/*!40000 ALTER TABLE `vm_snapshot_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `vm_snapshot_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vm_snapshots`
--

DROP TABLE IF EXISTS `vm_snapshots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vm_snapshots` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `uuid` varchar(40) NOT NULL,
  `name` varchar(255) NOT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `vm_id` bigint(20) unsigned NOT NULL,
  `account_id` bigint(20) unsigned NOT NULL,
  `domain_id` bigint(20) unsigned NOT NULL,
  `vm_snapshot_type` varchar(32) DEFAULT NULL,
  `state` varchar(32) NOT NULL,
  `parent` bigint(20) unsigned DEFAULT NULL,
  `current` int(1) unsigned DEFAULT NULL,
  `update_count` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated` datetime DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `removed` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_vm_snapshots_uuid` (`uuid`),
  KEY `vm_snapshots_name` (`name`),
  KEY `vm_snapshots_vm_id` (`vm_id`),
  KEY `vm_snapshots_account_id` (`account_id`),
  KEY `vm_snapshots_display_name` (`display_name`),
  KEY `vm_snapshots_removed` (`removed`),
  KEY `vm_snapshots_parent` (`parent`),
  KEY `fk_vm_snapshots_domain_id__domain_id` (`domain_id`),
  CONSTRAINT `fk_vm_snapshots_vm_id__vm_instance_id` FOREIGN KEY (`vm_id`) REFERENCES `vm_instance` (`id`),
  CONSTRAINT `fk_vm_snapshots_account_id__account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `fk_vm_snapshots_domain_id__domain_id` FOREIGN KEY (`domain_id`) REFERENCES `domain` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vm_snapshots`
--

LOCK TABLES `vm_snapshots` WRITE;
/*!40000 ALTER TABLE `vm_snapshots` DISABLE KEYS */;
/*!40000 ALTER TABLE `vm_snapshots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vm_template`
--

DROP TABLE IF EXISTS `vm_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vm_template` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `unique_name` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `uuid` varchar(40) DEFAULT NULL,
  `public` int(1) unsigned NOT NULL,
  `featured` int(1) unsigned NOT NULL,
  `type` varchar(32) DEFAULT NULL,
  `hvm` int(1) unsigned NOT NULL COMMENT 'requires HVM',
  `bits` int(6) unsigned NOT NULL COMMENT '32 bit or 64 bit',
  `url` varchar(255) DEFAULT NULL COMMENT 'the url where the template exists externally',
  `format` varchar(32) NOT NULL COMMENT 'format for the template',
  `created` datetime NOT NULL COMMENT 'Date created',
  `removed` datetime DEFAULT NULL COMMENT 'Date removed if not null',
  `account_id` bigint(20) unsigned NOT NULL COMMENT 'id of the account that created this template',
  `checksum` varchar(255) DEFAULT NULL COMMENT 'checksum for the template root disk',
  `display_text` varchar(4096) DEFAULT NULL COMMENT 'Description text set by the admin for display purpose only',
  `enable_password` int(1) unsigned NOT NULL DEFAULT '1' COMMENT 'true if this template supports password reset',
  `enable_sshkey` int(1) unsigned NOT NULL DEFAULT '0' COMMENT 'true if this template supports sshkey reset',
  `guest_os_id` bigint(20) unsigned NOT NULL COMMENT 'the OS of the template',
  `bootable` int(1) unsigned NOT NULL DEFAULT '1' COMMENT 'true if this template represents a bootable ISO',
  `prepopulate` int(1) unsigned NOT NULL DEFAULT '0' COMMENT 'prepopulate this template to primary storage',
  `cross_zones` int(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Make this template available in all zones',
  `extractable` int(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Is this template extractable',
  `hypervisor_type` varchar(32) DEFAULT NULL COMMENT 'hypervisor that the template belongs to',
  `source_template_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Id of the original template, if this template is created from snapshot',
  `template_tag` varchar(255) DEFAULT NULL COMMENT 'template tag',
  `sort_key` int(32) NOT NULL DEFAULT '0' COMMENT 'sort key used for customising sort method',
  `size` bigint(20) unsigned DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `update_count` bigint(20) unsigned DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `dynamically_scalable` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'true if template contains XS/VMWare tools inorder to support dynamic scaling of VM cpu/memory',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_vm_template__uuid` (`uuid`),
  KEY `i_vm_template__removed` (`removed`),
  KEY `i_vm_template__public` (`public`)
) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vm_template`
--

LOCK TABLES `vm_template` WRITE;
/*!40000 ALTER TABLE `vm_template` DISABLE KEYS */;
INSERT INTO `vm_template` VALUES (1,'routing-1','SystemVM Template (XenServer)','ae12bfc4-fcd8-11e3-9019-080027ce083d',0,0,'SYSTEM',0,64,'http://download.cloud.com/templates/4.3/systemvm64template-2014-01-14-master-xen.vhd.bz2','VHD','2014-06-26 02:22:11',NULL,1,'74b92f031cc5c2089ee89efb81344dcf','SystemVM Template (XenServer)',0,0,183,1,0,1,0,'XenServer',NULL,NULL,0,NULL,'Active',0,NULL,0),(2,'centos53-x86_64','CentOS 5.3(64-bit) no GUI (XenServer)','ae12cde8-fcd8-11e3-9019-080027ce083d',1,1,'BUILTIN',0,64,'http://download.cloud.com/templates/builtin/f59f18fb-ae94-4f97-afd2-f84755767aca.vhd.bz2','VHD','2014-06-26 02:22:11',NULL,1,'b63d854a9560c013142567bbae8d98cf','CentOS 5.3(64-bit) no GUI (XenServer)',0,0,12,1,0,1,1,'XenServer',NULL,NULL,0,NULL,'Inactive',0,NULL,0),(3,'routing-3','SystemVM Template (KVM)','ae12da0e-fcd8-11e3-9019-080027ce083d',0,0,'SYSTEM',0,64,'http://download.cloud.com/templates/4.3/systemvm64template-2014-01-14-master-kvm.qcow2.bz2','QCOW2','2014-06-26 02:22:11',NULL,1,'85a1bed07bf43cbf022451cb2ecae4ff','SystemVM Template (KVM)',0,0,15,1,0,1,0,'KVM',NULL,NULL,0,NULL,'Active',0,NULL,0),(4,'centos55-x86_64','CentOS 5.5(64-bit) no GUI (KVM)','ae12e698-fcd8-11e3-9019-080027ce083d',1,1,'BUILTIN',0,64,'http://download.cloud.com/releases/2.2.0/eec2209b-9875-3c8d-92be-c001bd8a0faf.qcow2.bz2','QCOW2','2014-06-26 02:22:11',NULL,1,'ed0e788280ff2912ea40f7f91ca7a249','CentOS 5.5(64-bit) no GUI (KVM)',0,0,112,1,0,1,1,'KVM',NULL,NULL,0,NULL,'Active',0,NULL,0),(5,'centos56-x86_64-xen','CentOS 5.6(64-bit) no GUI (XenServer)','ae12f2a0-fcd8-11e3-9019-080027ce083d',1,1,'BUILTIN',0,64,'http://download.cloud.com/templates/builtin/centos56-x86_64.vhd.bz2','VHD','2014-06-26 02:22:11',NULL,1,'905cec879afd9c9d22ecc8036131a180','CentOS 5.6(64-bit) no GUI (XenServer)',0,0,142,1,0,1,1,'XenServer',NULL,NULL,0,NULL,'Active',0,NULL,1),(6,'centos64-x64','CentOS 6.4(64-bit) GUI (Hyperv)','ae132702-fcd8-11e3-9019-080027ce083d',1,1,'BUILTIN',0,64,'http://download.cloud.com/releases/4.3/centos6_4_64bit.vhd.bz2','VHD','2014-06-26 02:22:11',NULL,1,'eef6b9940ea3ed01221d963d4a012d0a','CentOS 6.4 (64-bit) GUI (Hyperv)',0,0,182,1,0,1,1,'Hyperv',NULL,NULL,0,NULL,'Active',0,NULL,0),(7,'centos53-x64','CentOS 5.3(64-bit) no GUI (vSphere)','ae12fed0-fcd8-11e3-9019-080027ce083d',1,1,'BUILTIN',0,64,'http://download.cloud.com/releases/2.2.0/CentOS5.3-x86_64.ova','OVA','2014-06-26 02:22:11',NULL,1,'f6f881b7f2292948d8494db837fe0f47','CentOS 5.3(64-bit) no GUI (vSphere)',0,0,12,1,0,1,1,'VMware',NULL,NULL,0,NULL,'Active',0,NULL,0),(8,'routing-8','SystemVM Template (vSphere)','ae130ee8-fcd8-11e3-9019-080027ce083d',0,0,'SYSTEM',0,64,'http://download.cloud.com/templates/4.3/systemvm64template-2014-01-14-master-vmware.ova','OVA','2014-06-26 02:22:11',NULL,1,'ef593a061f3b7594ab0bfd9b0ed0a0d4','SystemVM Template (vSphere)',0,0,15,1,0,1,0,'VMware',NULL,NULL,0,NULL,'Active',0,NULL,1),(9,'routing-9','SystemVM Template (HyperV)','ae131bb8-fcd8-11e3-9019-080027ce083d',0,0,'SYSTEM',0,64,'http://download.cloud.com/templates/4.3/systemvm64template-2013-12-23-hyperv.vhd.bz2','VHD','2014-06-26 02:22:11',NULL,1,'5df45ee6ebe1b703a8805f4e1f4d0818','SystemVM Template (HyperV)',0,0,15,1,0,1,0,'Hyperv',NULL,NULL,0,NULL,'Active',0,NULL,0),(10,'routing-10','SystemVM Template (LXC)','af28d826-fcd8-11e3-9019-080027ce083d',0,0,'SYSTEM',0,64,'http://download.cloud.com/templates/4.3/systemvm64template-2014-01-14-master-kvm.qcow2.bz2','QCOW2','2014-06-26 02:22:13',NULL,1,'85a1bed07bf43cbf022451cb2ecae4ff','SystemVM Template (LXC)',0,0,15,1,0,1,0,'LXC',NULL,NULL,0,NULL,'Active',0,NULL,0),(100,'simulator-domR','SystemVM Template (simulator)','b602780a-fcd8-11e3-9019-080027ce083d',0,0,'SYSTEM',0,64,'http://nfs1.lab.vmops.com/templates/routing/debian/latest/systemvm.vhd.bz2','VHD','2014-06-26 02:22:24',NULL,1,'','SystemVM Template (simulator)',0,0,15,1,0,1,0,'Simulator',NULL,NULL,0,2147483648,'Active',NULL,NULL,0),(111,'simulator-Centos','CentOS 5.3(64-bit) no GUI (Simulator)','b6028674-fcd8-11e3-9019-080027ce083d',1,1,'BUILTIN',0,64,'http://nfs1.lab.vmops.com/templates/centos53-x86_64/latest/f59f18fb-ae94-4f97-afd2-f84755767aca.vhd.bz2','VHD','2014-06-26 02:22:24',NULL,1,'','CentOS 5.3(64-bit) no GUI (Simulator)',0,0,11,1,0,1,0,'Simulator',NULL,NULL,0,2147483648,'Active',NULL,NULL,0),(200,'xs-tools.iso','xs-tools.iso','06905c58-d3da-4f8a-9aa0-4f7ac96c60f7',1,1,'PERHOST',1,64,NULL,'ISO','2014-06-26 02:23:37',NULL,1,NULL,'xen-pv-drv-iso',0,0,1,0,0,0,1,'XenServer',NULL,NULL,0,NULL,'Active',0,NULL,0);
/*!40000 ALTER TABLE `vm_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vm_template_details`
--

DROP TABLE IF EXISTS `vm_template_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vm_template_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `template_id` bigint(20) unsigned NOT NULL COMMENT 'template id',
  `name` varchar(255) NOT NULL,
  `value` varchar(1024) NOT NULL,
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'True if the detail can be displayed to the end user',
  PRIMARY KEY (`id`),
  KEY `fk_vm_template_details__template_id` (`template_id`),
  CONSTRAINT `fk_vm_template_details__template_id` FOREIGN KEY (`template_id`) REFERENCES `vm_template` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vm_template_details`
--

LOCK TABLES `vm_template_details` WRITE;
/*!40000 ALTER TABLE `vm_template_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `vm_template_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vm_work_job`
--

DROP TABLE IF EXISTS `vm_work_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vm_work_job` (
  `id` bigint(20) unsigned NOT NULL,
  `step` char(32) NOT NULL COMMENT 'state',
  `vm_type` char(32) NOT NULL COMMENT 'type of vm',
  `vm_instance_id` bigint(20) unsigned NOT NULL COMMENT 'vm instance',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `fk_vm_work_job__instance_id` (`vm_instance_id`),
  KEY `i_vm_work_job__vm` (`vm_type`,`vm_instance_id`),
  KEY `i_vm_work_job__step` (`step`),
  CONSTRAINT `fk_vm_work_job__instance_id` FOREIGN KEY (`vm_instance_id`) REFERENCES `vm_instance` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vm_work_job`
--

LOCK TABLES `vm_work_job` WRITE;
/*!40000 ALTER TABLE `vm_work_job` DISABLE KEYS */;
INSERT INTO `vm_work_job` VALUES (14,'Starting','Instance',1),(15,'Starting','Instance',2);
/*!40000 ALTER TABLE `vm_work_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vmware_data_center`
--

DROP TABLE IF EXISTS `vmware_data_center`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vmware_data_center` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uuid` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL COMMENT 'Name of VMware datacenter',
  `guid` varchar(255) NOT NULL COMMENT 'id of VMware datacenter',
  `vcenter_host` varchar(255) NOT NULL COMMENT 'vCenter host containing this VMware datacenter',
  `username` varchar(255) NOT NULL COMMENT 'Name of vCenter host user',
  `password` varchar(255) NOT NULL COMMENT 'Password of vCenter host user',
  PRIMARY KEY (`id`),
  UNIQUE KEY `guid` (`guid`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vmware_data_center`
--

LOCK TABLES `vmware_data_center` WRITE;
/*!40000 ALTER TABLE `vmware_data_center` DISABLE KEYS */;
/*!40000 ALTER TABLE `vmware_data_center` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vmware_data_center_zone_map`
--

DROP TABLE IF EXISTS `vmware_data_center_zone_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vmware_data_center_zone_map` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `zone_id` bigint(20) unsigned NOT NULL COMMENT 'id of CloudStack zone',
  `vmware_data_center_id` bigint(20) unsigned NOT NULL COMMENT 'id of VMware datacenter',
  PRIMARY KEY (`id`),
  UNIQUE KEY `zone_id` (`zone_id`),
  UNIQUE KEY `vmware_data_center_id` (`vmware_data_center_id`),
  CONSTRAINT `fk_vmware_data_center_zone_map__vmware_data_center_id` FOREIGN KEY (`vmware_data_center_id`) REFERENCES `vmware_data_center` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vmware_data_center_zone_map`
--

LOCK TABLES `vmware_data_center_zone_map` WRITE;
/*!40000 ALTER TABLE `vmware_data_center_zone_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `vmware_data_center_zone_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `volume_details`
--

DROP TABLE IF EXISTS `volume_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volume_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `volume_id` bigint(20) unsigned NOT NULL COMMENT 'volume id',
  `name` varchar(255) NOT NULL,
  `value` varchar(1024) NOT NULL,
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'True if the detail can be displayed to the end user',
  PRIMARY KEY (`id`),
  KEY `fk_volume_details__volume_id` (`volume_id`),
  CONSTRAINT `fk_volume_details__volume_id` FOREIGN KEY (`volume_id`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `volume_details`
--

LOCK TABLES `volume_details` WRITE;
/*!40000 ALTER TABLE `volume_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `volume_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `volume_host_ref`
--

DROP TABLE IF EXISTS `volume_host_ref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volume_host_ref` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `host_id` bigint(20) unsigned NOT NULL,
  `volume_id` bigint(20) unsigned NOT NULL,
  `zone_id` bigint(20) unsigned NOT NULL,
  `created` datetime NOT NULL,
  `last_updated` datetime DEFAULT NULL,
  `job_id` varchar(255) DEFAULT NULL,
  `download_pct` int(10) unsigned DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `physical_size` bigint(20) unsigned DEFAULT '0',
  `download_state` varchar(255) DEFAULT NULL,
  `checksum` varchar(255) DEFAULT NULL COMMENT 'checksum for the data disk',
  `error_str` varchar(255) DEFAULT NULL,
  `local_path` varchar(255) DEFAULT NULL,
  `install_path` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `format` varchar(32) NOT NULL COMMENT 'format for the volume',
  `destroyed` tinyint(1) DEFAULT NULL COMMENT 'indicates whether the volume_host entry was destroyed by the user or not',
  PRIMARY KEY (`id`),
  KEY `i_volume_host_ref__host_id` (`host_id`),
  KEY `i_volume_host_ref__volume_id` (`volume_id`),
  CONSTRAINT `fk_volume_host_ref__host_id` FOREIGN KEY (`host_id`) REFERENCES `host` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_volume_host_ref__volume_id` FOREIGN KEY (`volume_id`) REFERENCES `volumes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `volume_host_ref`
--

LOCK TABLES `volume_host_ref` WRITE;
/*!40000 ALTER TABLE `volume_host_ref` DISABLE KEYS */;
/*!40000 ALTER TABLE `volume_host_ref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `volume_reservation`
--

DROP TABLE IF EXISTS `volume_reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volume_reservation` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `vm_reservation_id` bigint(20) unsigned NOT NULL COMMENT 'id of the vm reservation',
  `vm_id` bigint(20) unsigned NOT NULL COMMENT 'vm id',
  `volume_id` bigint(20) unsigned NOT NULL COMMENT 'volume id',
  `pool_id` bigint(20) unsigned NOT NULL COMMENT 'pool assigned to the volume',
  PRIMARY KEY (`id`),
  KEY `fk_vm_pool_reservation__vm_reservation_id` (`vm_reservation_id`),
  CONSTRAINT `fk_vm_pool_reservation__vm_reservation_id` FOREIGN KEY (`vm_reservation_id`) REFERENCES `vm_reservation` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `volume_reservation`
--

LOCK TABLES `volume_reservation` WRITE;
/*!40000 ALTER TABLE `volume_reservation` DISABLE KEYS */;
/*!40000 ALTER TABLE `volume_reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `volume_store_ref`
--

DROP TABLE IF EXISTS `volume_store_ref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volume_store_ref` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `store_id` bigint(20) unsigned NOT NULL,
  `volume_id` bigint(20) unsigned NOT NULL,
  `zone_id` bigint(20) unsigned NOT NULL,
  `created` datetime NOT NULL,
  `last_updated` datetime DEFAULT NULL,
  `job_id` varchar(255) DEFAULT NULL,
  `download_pct` int(10) unsigned DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `physical_size` bigint(20) unsigned DEFAULT '0',
  `download_state` varchar(255) DEFAULT NULL,
  `checksum` varchar(255) DEFAULT NULL COMMENT 'checksum for the data disk',
  `error_str` varchar(255) DEFAULT NULL,
  `local_path` varchar(255) DEFAULT NULL,
  `install_path` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `download_url` varchar(255) DEFAULT NULL,
  `state` varchar(255) NOT NULL,
  `destroyed` tinyint(1) DEFAULT NULL COMMENT 'indicates whether the volume_host entry was destroyed by the user or not',
  `update_count` bigint(20) unsigned DEFAULT NULL,
  `ref_cnt` bigint(20) unsigned DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `download_url_created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `i_volume_store_ref__store_id` (`store_id`),
  KEY `i_volume_store_ref__volume_id` (`volume_id`),
  CONSTRAINT `fk_volume_store_ref__store_id` FOREIGN KEY (`store_id`) REFERENCES `image_store` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_volume_store_ref__volume_id` FOREIGN KEY (`volume_id`) REFERENCES `volumes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `volume_store_ref`
--

LOCK TABLES `volume_store_ref` WRITE;
/*!40000 ALTER TABLE `volume_store_ref` DISABLE KEYS */;
/*!40000 ALTER TABLE `volume_store_ref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `volume_view`
--

DROP TABLE IF EXISTS `volume_view`;
/*!50001 DROP VIEW IF EXISTS `volume_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `volume_view` (
  `id` tinyint NOT NULL,
  `uuid` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `device_id` tinyint NOT NULL,
  `volume_type` tinyint NOT NULL,
  `size` tinyint NOT NULL,
  `min_iops` tinyint NOT NULL,
  `max_iops` tinyint NOT NULL,
  `created` tinyint NOT NULL,
  `state` tinyint NOT NULL,
  `attached` tinyint NOT NULL,
  `removed` tinyint NOT NULL,
  `pod_id` tinyint NOT NULL,
  `display_volume` tinyint NOT NULL,
  `format` tinyint NOT NULL,
  `path` tinyint NOT NULL,
  `chain_info` tinyint NOT NULL,
  `account_id` tinyint NOT NULL,
  `account_uuid` tinyint NOT NULL,
  `account_name` tinyint NOT NULL,
  `account_type` tinyint NOT NULL,
  `domain_id` tinyint NOT NULL,
  `domain_uuid` tinyint NOT NULL,
  `domain_name` tinyint NOT NULL,
  `domain_path` tinyint NOT NULL,
  `project_id` tinyint NOT NULL,
  `project_uuid` tinyint NOT NULL,
  `project_name` tinyint NOT NULL,
  `data_center_id` tinyint NOT NULL,
  `data_center_uuid` tinyint NOT NULL,
  `data_center_name` tinyint NOT NULL,
  `data_center_type` tinyint NOT NULL,
  `vm_id` tinyint NOT NULL,
  `vm_uuid` tinyint NOT NULL,
  `vm_name` tinyint NOT NULL,
  `vm_state` tinyint NOT NULL,
  `vm_type` tinyint NOT NULL,
  `vm_display_name` tinyint NOT NULL,
  `volume_store_size` tinyint NOT NULL,
  `download_pct` tinyint NOT NULL,
  `download_state` tinyint NOT NULL,
  `error_str` tinyint NOT NULL,
  `created_on_store` tinyint NOT NULL,
  `disk_offering_id` tinyint NOT NULL,
  `disk_offering_uuid` tinyint NOT NULL,
  `disk_offering_name` tinyint NOT NULL,
  `disk_offering_display_text` tinyint NOT NULL,
  `use_local_storage` tinyint NOT NULL,
  `system_use` tinyint NOT NULL,
  `bytes_read_rate` tinyint NOT NULL,
  `bytes_write_rate` tinyint NOT NULL,
  `iops_read_rate` tinyint NOT NULL,
  `iops_write_rate` tinyint NOT NULL,
  `cache_mode` tinyint NOT NULL,
  `pool_id` tinyint NOT NULL,
  `pool_uuid` tinyint NOT NULL,
  `pool_name` tinyint NOT NULL,
  `hypervisor_type` tinyint NOT NULL,
  `template_id` tinyint NOT NULL,
  `template_uuid` tinyint NOT NULL,
  `extractable` tinyint NOT NULL,
  `template_type` tinyint NOT NULL,
  `template_name` tinyint NOT NULL,
  `template_display_text` tinyint NOT NULL,
  `iso_id` tinyint NOT NULL,
  `iso_uuid` tinyint NOT NULL,
  `iso_name` tinyint NOT NULL,
  `iso_display_text` tinyint NOT NULL,
  `tag_id` tinyint NOT NULL,
  `tag_uuid` tinyint NOT NULL,
  `tag_key` tinyint NOT NULL,
  `tag_value` tinyint NOT NULL,
  `tag_domain_id` tinyint NOT NULL,
  `tag_account_id` tinyint NOT NULL,
  `tag_resource_id` tinyint NOT NULL,
  `tag_resource_uuid` tinyint NOT NULL,
  `tag_resource_type` tinyint NOT NULL,
  `tag_customer` tinyint NOT NULL,
  `job_id` tinyint NOT NULL,
  `job_uuid` tinyint NOT NULL,
  `job_status` tinyint NOT NULL,
  `job_account_id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `volumes`
--

DROP TABLE IF EXISTS `volumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volumes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `account_id` bigint(20) unsigned NOT NULL COMMENT 'owner.  foreign key to account table',
  `domain_id` bigint(20) unsigned NOT NULL COMMENT 'the domain that the owner belongs to',
  `pool_id` bigint(20) unsigned DEFAULT NULL COMMENT 'pool it belongs to. foreign key to storage_pool table',
  `last_pool_id` bigint(20) unsigned DEFAULT NULL COMMENT 'last pool it belongs to.',
  `instance_id` bigint(20) unsigned DEFAULT NULL COMMENT 'vm instance it belongs to. foreign key to vm_instance table',
  `device_id` bigint(20) unsigned DEFAULT NULL COMMENT 'which device inside vm instance it is ',
  `name` varchar(255) DEFAULT NULL COMMENT 'A user specified name for the volume',
  `uuid` varchar(40) DEFAULT NULL,
  `size` bigint(20) unsigned NOT NULL COMMENT 'total size',
  `folder` varchar(255) DEFAULT NULL COMMENT 'The folder where the volume is saved',
  `path` varchar(255) DEFAULT NULL COMMENT 'Path',
  `pod_id` bigint(20) unsigned DEFAULT NULL COMMENT 'pod this volume belongs to',
  `data_center_id` bigint(20) unsigned NOT NULL COMMENT 'data center this volume belongs to',
  `iscsi_name` varchar(255) DEFAULT NULL COMMENT 'iscsi target name',
  `host_ip` char(40) DEFAULT NULL COMMENT 'host ip address for convenience',
  `volume_type` varchar(64) NOT NULL COMMENT 'root, swap or data',
  `pool_type` varchar(64) DEFAULT NULL COMMENT 'type of the pool',
  `disk_offering_id` bigint(20) unsigned NOT NULL COMMENT 'can be null for system VMs',
  `template_id` bigint(20) unsigned DEFAULT NULL COMMENT 'fk to vm_template.id',
  `first_snapshot_backup_uuid` varchar(255) DEFAULT NULL COMMENT 'The first snapshot that was ever taken for this volume',
  `recreatable` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Is this volume recreatable?',
  `created` datetime DEFAULT NULL COMMENT 'Date Created',
  `attached` datetime DEFAULT NULL COMMENT 'Date Attached',
  `updated` datetime DEFAULT NULL COMMENT 'Date updated for attach/detach',
  `removed` datetime DEFAULT NULL COMMENT 'Date removed.  not null if removed',
  `state` varchar(32) DEFAULT NULL COMMENT 'State machine',
  `chain_info` text COMMENT 'save possible disk chain info in primary storage',
  `update_count` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'date state was updated',
  `disk_type` varchar(255) DEFAULT NULL,
  `vm_snapshot_chain_size` bigint(20) unsigned DEFAULT NULL,
  `iso_id` bigint(20) unsigned DEFAULT NULL,
  `display_volume` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Should volume be displayed to the end user',
  `format` varchar(255) DEFAULT NULL COMMENT 'volume format',
  `min_iops` bigint(20) unsigned DEFAULT NULL COMMENT 'Minimum IOPS',
  `max_iops` bigint(20) unsigned DEFAULT NULL COMMENT 'Maximum IOPS',
  `hv_ss_reserve` int(32) unsigned DEFAULT NULL COMMENT 'Hypervisor snapshot reserve space as a percent of a volume (for managed storage using Xen or VMware)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_volumes__uuid` (`uuid`),
  KEY `i_volumes__removed` (`removed`),
  KEY `i_volumes__pod_id` (`pod_id`),
  KEY `i_volumes__data_center_id` (`data_center_id`),
  KEY `i_volumes__account_id` (`account_id`),
  KEY `i_volumes__pool_id` (`pool_id`),
  KEY `i_volumes__last_pool_id` (`last_pool_id`),
  KEY `i_volumes__instance_id` (`instance_id`),
  KEY `i_volumes__state` (`state`),
  KEY `i_volumes__update_count` (`update_count`),
  CONSTRAINT `fk_volumes__instance_id` FOREIGN KEY (`instance_id`) REFERENCES `vm_instance` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_volumes__pool_id` FOREIGN KEY (`pool_id`) REFERENCES `storage_pool` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `volumes`
--

LOCK TABLES `volumes` WRITE;
/*!40000 ALTER TABLE `volumes` DISABLE KEYS */;
INSERT INTO `volumes` VALUES (1,1,1,2,NULL,1,0,'ROOT-1','2519dad0-db37-483c-afdc-4b94892c3177',100,NULL,'5ac162b1-c9d2-435f-8e4e-95d7be0a756c',NULL,1,NULL,NULL,'ROOT',NULL,9,100,NULL,1,'2014-06-26 02:27:57',NULL,'2014-06-26 02:28:00',NULL,'Ready',NULL,2,NULL,NULL,NULL,1,'RAW',NULL,NULL,NULL),(2,1,1,3,NULL,2,0,'ROOT-2','5d3f04c2-6208-479a-8f82-4d1ad1c77268',100,NULL,'d6d2bed4-3bb4-4ff3-961a-72c28622783d',NULL,1,NULL,NULL,'ROOT',NULL,10,100,NULL,1,'2014-06-26 02:27:58',NULL,'2014-06-26 02:28:00',NULL,'Ready',NULL,2,NULL,NULL,NULL,1,'RAW',NULL,NULL,NULL);
/*!40000 ALTER TABLE `volumes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vpc`
--

DROP TABLE IF EXISTS `vpc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vpc` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uuid` varchar(40) NOT NULL,
  `name` varchar(255) DEFAULT NULL COMMENT 'vpc name',
  `display_text` varchar(255) DEFAULT NULL COMMENT 'vpc display text',
  `cidr` varchar(18) DEFAULT NULL COMMENT 'vpc cidr',
  `vpc_offering_id` bigint(20) unsigned NOT NULL COMMENT 'vpc offering id that this vpc is created from',
  `zone_id` bigint(20) unsigned NOT NULL COMMENT 'the id of the zone this Vpc belongs to',
  `state` varchar(32) NOT NULL COMMENT 'state of the VP (can be Enabled and Disabled)',
  `domain_id` bigint(20) unsigned NOT NULL COMMENT 'domain the vpc belongs to',
  `account_id` bigint(20) unsigned NOT NULL COMMENT 'owner of this vpc',
  `network_domain` varchar(255) DEFAULT NULL COMMENT 'network domain',
  `removed` datetime DEFAULT NULL COMMENT 'date removed if not null',
  `created` datetime NOT NULL COMMENT 'date created',
  `restart_required` int(1) unsigned NOT NULL DEFAULT '0' COMMENT '1 if restart is required for the VPC',
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'True if the vpc can be displayed to the end user',
  `uses_distributed_router` tinyint(1) DEFAULT '0',
  `region_level_vpc` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `i_vpc__removed` (`removed`),
  KEY `fk_vpc__zone_id` (`zone_id`),
  KEY `fk_vpc__vpc_offering_id` (`vpc_offering_id`),
  KEY `fk_vpc__account_id` (`account_id`),
  KEY `fk_vpc__domain_id` (`domain_id`),
  CONSTRAINT `fk_vpc__account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_vpc__domain_id` FOREIGN KEY (`domain_id`) REFERENCES `domain` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_vpc__vpc_offering_id` FOREIGN KEY (`vpc_offering_id`) REFERENCES `vpc_offerings` (`id`),
  CONSTRAINT `fk_vpc__zone_id` FOREIGN KEY (`zone_id`) REFERENCES `data_center` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vpc`
--

LOCK TABLES `vpc` WRITE;
/*!40000 ALTER TABLE `vpc` DISABLE KEYS */;
/*!40000 ALTER TABLE `vpc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vpc_details`
--

DROP TABLE IF EXISTS `vpc_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vpc_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `vpc_id` bigint(20) unsigned NOT NULL COMMENT 'VPC id',
  `name` varchar(255) NOT NULL,
  `value` varchar(1024) NOT NULL,
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'True if the detail can be displayed to the end user',
  PRIMARY KEY (`id`),
  KEY `fk_vpc_details__vpc_id` (`vpc_id`),
  CONSTRAINT `fk_vpc_details__vpc_id` FOREIGN KEY (`vpc_id`) REFERENCES `vpc` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vpc_details`
--

LOCK TABLES `vpc_details` WRITE;
/*!40000 ALTER TABLE `vpc_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `vpc_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vpc_gateway_details`
--

DROP TABLE IF EXISTS `vpc_gateway_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vpc_gateway_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `vpc_gateway_id` bigint(20) unsigned NOT NULL COMMENT 'VPC gateway id',
  `name` varchar(255) NOT NULL,
  `value` varchar(1024) NOT NULL,
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'True if the detail can be displayed to the end user',
  PRIMARY KEY (`id`),
  KEY `fk_vpc_gateway_details__vpc_gateway_id` (`vpc_gateway_id`),
  CONSTRAINT `fk_vpc_gateway_details__vpc_gateway_id` FOREIGN KEY (`vpc_gateway_id`) REFERENCES `vpc_gateways` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vpc_gateway_details`
--

LOCK TABLES `vpc_gateway_details` WRITE;
/*!40000 ALTER TABLE `vpc_gateway_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `vpc_gateway_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vpc_gateways`
--

DROP TABLE IF EXISTS `vpc_gateways`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vpc_gateways` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uuid` varchar(40) DEFAULT NULL,
  `ip4_address` char(40) DEFAULT NULL COMMENT 'ip4 address of the gateway',
  `netmask` varchar(15) DEFAULT NULL COMMENT 'netmask of the gateway',
  `gateway` varchar(15) DEFAULT NULL COMMENT 'gateway',
  `vlan_tag` varchar(255) DEFAULT NULL,
  `type` varchar(32) DEFAULT NULL COMMENT 'type of gateway; can be Public/Private/Vpn',
  `network_id` bigint(20) unsigned NOT NULL COMMENT 'network id vpc gateway belongs to',
  `vpc_id` bigint(20) unsigned NOT NULL COMMENT 'id of the vpc the gateway belongs to',
  `zone_id` bigint(20) unsigned NOT NULL COMMENT 'id of the zone the gateway belongs to',
  `created` datetime DEFAULT NULL COMMENT 'date created',
  `account_id` bigint(20) unsigned NOT NULL COMMENT 'owner id',
  `domain_id` bigint(20) unsigned NOT NULL COMMENT 'domain id',
  `state` varchar(32) NOT NULL COMMENT 'what state the vpc gateway in',
  `removed` datetime DEFAULT NULL COMMENT 'date removed if not null',
  `source_nat` tinyint(1) DEFAULT '0',
  `network_acl_id` bigint(20) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `uc_vpc_gateways__uuid` (`uuid`),
  KEY `fk_vpc_gateways__network_id` (`network_id`),
  KEY `fk_vpc_gateways__vpc_id` (`vpc_id`),
  KEY `fk_vpc_gateways__zone_id` (`zone_id`),
  KEY `fk_vpc_gateways__account_id` (`account_id`),
  KEY `fk_vpc_gateways__domain_id` (`domain_id`),
  KEY `i_vpc_gateways__removed` (`removed`),
  CONSTRAINT `fk_vpc_gateways__account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_vpc_gateways__domain_id` FOREIGN KEY (`domain_id`) REFERENCES `domain` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_vpc_gateways__network_id` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`),
  CONSTRAINT `fk_vpc_gateways__vpc_id` FOREIGN KEY (`vpc_id`) REFERENCES `vpc` (`id`),
  CONSTRAINT `fk_vpc_gateways__zone_id` FOREIGN KEY (`zone_id`) REFERENCES `data_center` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vpc_gateways`
--

LOCK TABLES `vpc_gateways` WRITE;
/*!40000 ALTER TABLE `vpc_gateways` DISABLE KEYS */;
/*!40000 ALTER TABLE `vpc_gateways` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vpc_offering_service_map`
--

DROP TABLE IF EXISTS `vpc_offering_service_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vpc_offering_service_map` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `vpc_offering_id` bigint(20) unsigned NOT NULL COMMENT 'vpc_offering_id',
  `service` varchar(255) NOT NULL COMMENT 'service',
  `provider` varchar(255) DEFAULT NULL COMMENT 'service provider',
  `created` datetime DEFAULT NULL COMMENT 'date created',
  PRIMARY KEY (`id`),
  UNIQUE KEY `vpc_offering_id` (`vpc_offering_id`,`service`,`provider`),
  CONSTRAINT `fk_vpc_offering_service_map__vpc_offering_id` FOREIGN KEY (`vpc_offering_id`) REFERENCES `vpc_offerings` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vpc_offering_service_map`
--

LOCK TABLES `vpc_offering_service_map` WRITE;
/*!40000 ALTER TABLE `vpc_offering_service_map` DISABLE KEYS */;
INSERT INTO `vpc_offering_service_map` VALUES (1,1,'PortForwarding','VpcVirtualRouter','2014-06-26 02:23:28'),(2,1,'Dhcp','VpcVirtualRouter','2014-06-26 02:23:28'),(3,1,'Dns','VpcVirtualRouter','2014-06-26 02:23:28'),(4,1,'Lb','VpcVirtualRouter','2014-06-26 02:23:28'),(5,1,'Lb','InternalLbVm','2014-06-26 02:23:28'),(6,1,'StaticNat','VpcVirtualRouter','2014-06-26 02:23:28'),(7,1,'Vpn','VpcVirtualRouter','2014-06-26 02:23:28'),(8,1,'SourceNat','VpcVirtualRouter','2014-06-26 02:23:28'),(9,1,'Gateway','VpcVirtualRouter','2014-06-26 02:23:28'),(10,1,'UserData','VpcVirtualRouter','2014-06-26 02:23:28'),(11,1,'NetworkACL','VpcVirtualRouter','2014-06-26 02:23:28'),(12,2,'PortForwarding','VpcVirtualRouter','2014-06-26 02:23:28'),(13,2,'Dhcp','VpcVirtualRouter','2014-06-26 02:23:28'),(14,2,'Dns','VpcVirtualRouter','2014-06-26 02:23:28'),(15,2,'Lb','Netscaler','2014-06-26 02:23:28'),(16,2,'Lb','InternalLbVm','2014-06-26 02:23:28'),(17,2,'StaticNat','VpcVirtualRouter','2014-06-26 02:23:28'),(18,2,'Vpn','VpcVirtualRouter','2014-06-26 02:23:28'),(19,2,'SourceNat','VpcVirtualRouter','2014-06-26 02:23:28'),(20,2,'Gateway','VpcVirtualRouter','2014-06-26 02:23:28'),(21,2,'UserData','VpcVirtualRouter','2014-06-26 02:23:28'),(22,2,'NetworkACL','VpcVirtualRouter','2014-06-26 02:23:28');
/*!40000 ALTER TABLE `vpc_offering_service_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vpc_offerings`
--

DROP TABLE IF EXISTS `vpc_offerings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vpc_offerings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uuid` varchar(40) NOT NULL,
  `unique_name` varchar(64) DEFAULT NULL COMMENT 'unique name of the vpc offering',
  `name` varchar(255) DEFAULT NULL COMMENT 'vpc name',
  `display_text` varchar(255) DEFAULT NULL COMMENT 'display text',
  `state` char(32) DEFAULT NULL COMMENT 'state of the vpc offering that has Disabled value by default',
  `default` int(1) unsigned NOT NULL DEFAULT '0' COMMENT '1 if vpc offering is default',
  `removed` datetime DEFAULT NULL COMMENT 'date removed if not null',
  `created` datetime NOT NULL COMMENT 'date created',
  `service_offering_id` bigint(20) unsigned DEFAULT NULL COMMENT 'service offering id that virtual router is tied to',
  `supports_distributed_router` tinyint(1) DEFAULT '0',
  `supports_region_level_vpc` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_name` (`unique_name`),
  KEY `i_vpc__removed` (`removed`),
  KEY `fk_vpc_offerings__service_offering_id` (`service_offering_id`),
  CONSTRAINT `fk_vpc_offerings__service_offering_id` FOREIGN KEY (`service_offering_id`) REFERENCES `service_offering` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vpc_offerings`
--

LOCK TABLES `vpc_offerings` WRITE;
/*!40000 ALTER TABLE `vpc_offerings` DISABLE KEYS */;
INSERT INTO `vpc_offerings` VALUES (1,'3b6c44a8-5457-4a4b-8c61-b7bcd0aed45f','Default VPC offering','Default VPC offering','Default VPC offering','Enabled',1,NULL,'2014-06-26 02:23:28',NULL,0,0),(2,'a418ca03-17c2-4e55-99f3-1a4de5a966ab','Default VPC  offering with Netscaler','Default VPC  offering with Netscaler','Default VPC  offering with Netscaler','Enabled',0,NULL,'2014-06-26 02:23:28',NULL,0,0);
/*!40000 ALTER TABLE `vpc_offerings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vpc_service_map`
--

DROP TABLE IF EXISTS `vpc_service_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vpc_service_map` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `vpc_id` bigint(20) unsigned NOT NULL COMMENT 'vpc_id',
  `service` varchar(255) NOT NULL COMMENT 'service',
  `provider` varchar(255) DEFAULT NULL COMMENT 'service provider',
  `created` datetime DEFAULT NULL COMMENT 'date created',
  PRIMARY KEY (`id`),
  UNIQUE KEY `vpc_id` (`vpc_id`,`service`,`provider`),
  CONSTRAINT `fk_vpc_service_map__vpc_id` FOREIGN KEY (`vpc_id`) REFERENCES `vpc` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vpc_service_map`
--

LOCK TABLES `vpc_service_map` WRITE;
/*!40000 ALTER TABLE `vpc_service_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `vpc_service_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vpn_users`
--

DROP TABLE IF EXISTS `vpn_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vpn_users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(40) DEFAULT NULL,
  `owner_id` bigint(20) unsigned NOT NULL,
  `domain_id` bigint(20) unsigned NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `state` char(32) NOT NULL COMMENT 'What state is this vpn user in',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `i_vpn_users__account_id__username` (`owner_id`,`username`),
  UNIQUE KEY `uc_vpn_users__uuid` (`uuid`),
  KEY `fk_vpn_users__domain_id` (`domain_id`),
  KEY `i_vpn_users_username` (`username`),
  CONSTRAINT `fk_vpn_users__owner_id` FOREIGN KEY (`owner_id`) REFERENCES `account` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_vpn_users__domain_id` FOREIGN KEY (`domain_id`) REFERENCES `domain` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vpn_users`
--

LOCK TABLES `vpn_users` WRITE;
/*!40000 ALTER TABLE `vpn_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `vpn_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `account_netstats_view`
--

/*!50001 DROP TABLE IF EXISTS `account_netstats_view`*/;
/*!50001 DROP VIEW IF EXISTS `account_netstats_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `account_netstats_view` AS select `user_statistics`.`account_id` AS `account_id`,(sum(`user_statistics`.`net_bytes_received`) + sum(`user_statistics`.`current_bytes_received`)) AS `bytesReceived`,(sum(`user_statistics`.`net_bytes_sent`) + sum(`user_statistics`.`current_bytes_sent`)) AS `bytesSent` from `user_statistics` group by `user_statistics`.`account_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `account_view`
--

/*!50001 DROP TABLE IF EXISTS `account_view`*/;
/*!50001 DROP VIEW IF EXISTS `account_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `account_view` AS select `account`.`id` AS `id`,`account`.`uuid` AS `uuid`,`account`.`account_name` AS `account_name`,`account`.`type` AS `type`,`account`.`state` AS `state`,`account`.`removed` AS `removed`,`account`.`cleanup_needed` AS `cleanup_needed`,`account`.`network_domain` AS `network_domain`,`account`.`default` AS `default`,`domain`.`id` AS `domain_id`,`domain`.`uuid` AS `domain_uuid`,`domain`.`name` AS `domain_name`,`domain`.`path` AS `domain_path`,`data_center`.`id` AS `data_center_id`,`data_center`.`uuid` AS `data_center_uuid`,`data_center`.`name` AS `data_center_name`,`account_netstats_view`.`bytesReceived` AS `bytesReceived`,`account_netstats_view`.`bytesSent` AS `bytesSent`,`vmlimit`.`max` AS `vmLimit`,`vmcount`.`count` AS `vmTotal`,`runningvm`.`vmcount` AS `runningVms`,`stoppedvm`.`vmcount` AS `stoppedVms`,`iplimit`.`max` AS `ipLimit`,`ipcount`.`count` AS `ipTotal`,`free_ip_view`.`free_ip` AS `ipFree`,`volumelimit`.`max` AS `volumeLimit`,`volumecount`.`count` AS `volumeTotal`,`snapshotlimit`.`max` AS `snapshotLimit`,`snapshotcount`.`count` AS `snapshotTotal`,`templatelimit`.`max` AS `templateLimit`,`templatecount`.`count` AS `templateTotal`,`vpclimit`.`max` AS `vpcLimit`,`vpccount`.`count` AS `vpcTotal`,`projectlimit`.`max` AS `projectLimit`,`projectcount`.`count` AS `projectTotal`,`networklimit`.`max` AS `networkLimit`,`networkcount`.`count` AS `networkTotal`,`cpulimit`.`max` AS `cpuLimit`,`cpucount`.`count` AS `cpuTotal`,`memorylimit`.`max` AS `memoryLimit`,`memorycount`.`count` AS `memoryTotal`,`primary_storage_limit`.`max` AS `primaryStorageLimit`,`primary_storage_count`.`count` AS `primaryStorageTotal`,`secondary_storage_limit`.`max` AS `secondaryStorageLimit`,`secondary_storage_count`.`count` AS `secondaryStorageTotal`,`async_job`.`id` AS `job_id`,`async_job`.`uuid` AS `job_uuid`,`async_job`.`job_status` AS `job_status`,`async_job`.`account_id` AS `job_account_id` from (`free_ip_view` join ((((((((((((((((((((((((((((((`account` join `domain` on((`account`.`domain_id` = `domain`.`id`))) left join `data_center` on((`account`.`default_zone_id` = `data_center`.`id`))) left join `account_netstats_view` on((`account`.`id` = `account_netstats_view`.`account_id`))) left join `resource_limit` `vmlimit` on(((`account`.`id` = `vmlimit`.`account_id`) and (`vmlimit`.`type` = 'user_vm')))) left join `resource_count` `vmcount` on(((`account`.`id` = `vmcount`.`account_id`) and (`vmcount`.`type` = 'user_vm')))) left join `account_vmstats_view` `runningvm` on(((`account`.`id` = `runningvm`.`account_id`) and (`runningvm`.`state` = 'Running')))) left join `account_vmstats_view` `stoppedvm` on(((`account`.`id` = `stoppedvm`.`account_id`) and (`stoppedvm`.`state` = 'Stopped')))) left join `resource_limit` `iplimit` on(((`account`.`id` = `iplimit`.`account_id`) and (`iplimit`.`type` = 'public_ip')))) left join `resource_count` `ipcount` on(((`account`.`id` = `ipcount`.`account_id`) and (`ipcount`.`type` = 'public_ip')))) left join `resource_limit` `volumelimit` on(((`account`.`id` = `volumelimit`.`account_id`) and (`volumelimit`.`type` = 'volume')))) left join `resource_count` `volumecount` on(((`account`.`id` = `volumecount`.`account_id`) and (`volumecount`.`type` = 'volume')))) left join `resource_limit` `snapshotlimit` on(((`account`.`id` = `snapshotlimit`.`account_id`) and (`snapshotlimit`.`type` = 'snapshot')))) left join `resource_count` `snapshotcount` on(((`account`.`id` = `snapshotcount`.`account_id`) and (`snapshotcount`.`type` = 'snapshot')))) left join `resource_limit` `templatelimit` on(((`account`.`id` = `templatelimit`.`account_id`) and (`templatelimit`.`type` = 'template')))) left join `resource_count` `templatecount` on(((`account`.`id` = `templatecount`.`account_id`) and (`templatecount`.`type` = 'template')))) left join `resource_limit` `vpclimit` on(((`account`.`id` = `vpclimit`.`account_id`) and (`vpclimit`.`type` = 'vpc')))) left join `resource_count` `vpccount` on(((`account`.`id` = `vpccount`.`account_id`) and (`vpccount`.`type` = 'vpc')))) left join `resource_limit` `projectlimit` on(((`account`.`id` = `projectlimit`.`account_id`) and (`projectlimit`.`type` = 'project')))) left join `resource_count` `projectcount` on(((`account`.`id` = `projectcount`.`account_id`) and (`projectcount`.`type` = 'project')))) left join `resource_limit` `networklimit` on(((`account`.`id` = `networklimit`.`account_id`) and (`networklimit`.`type` = 'network')))) left join `resource_count` `networkcount` on(((`account`.`id` = `networkcount`.`account_id`) and (`networkcount`.`type` = 'network')))) left join `resource_limit` `cpulimit` on(((`account`.`id` = `cpulimit`.`account_id`) and (`cpulimit`.`type` = 'cpu')))) left join `resource_count` `cpucount` on(((`account`.`id` = `cpucount`.`account_id`) and (`cpucount`.`type` = 'cpu')))) left join `resource_limit` `memorylimit` on(((`account`.`id` = `memorylimit`.`account_id`) and (`memorylimit`.`type` = 'memory')))) left join `resource_count` `memorycount` on(((`account`.`id` = `memorycount`.`account_id`) and (`memorycount`.`type` = 'memory')))) left join `resource_limit` `primary_storage_limit` on(((`account`.`id` = `primary_storage_limit`.`account_id`) and (`primary_storage_limit`.`type` = 'primary_storage')))) left join `resource_count` `primary_storage_count` on(((`account`.`id` = `primary_storage_count`.`account_id`) and (`primary_storage_count`.`type` = 'primary_storage')))) left join `resource_limit` `secondary_storage_limit` on(((`account`.`id` = `secondary_storage_limit`.`account_id`) and (`secondary_storage_limit`.`type` = 'secondary_storage')))) left join `resource_count` `secondary_storage_count` on(((`account`.`id` = `secondary_storage_count`.`account_id`) and (`secondary_storage_count`.`type` = 'secondary_storage')))) left join `async_job` on(((`async_job`.`instance_id` = `account`.`id`) and (`async_job`.`instance_type` = 'Account') and (`async_job`.`job_status` = 0))))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `account_vmstats_view`
--

/*!50001 DROP TABLE IF EXISTS `account_vmstats_view`*/;
/*!50001 DROP VIEW IF EXISTS `account_vmstats_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `account_vmstats_view` AS select `vm_instance`.`account_id` AS `account_id`,`vm_instance`.`state` AS `state`,count(0) AS `vmcount` from `vm_instance` where (`vm_instance`.`vm_type` = 'User') group by `vm_instance`.`account_id`,`vm_instance`.`state` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `affinity_group_view`
--

/*!50001 DROP TABLE IF EXISTS `affinity_group_view`*/;
/*!50001 DROP VIEW IF EXISTS `affinity_group_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `affinity_group_view` AS select `affinity_group`.`id` AS `id`,`affinity_group`.`name` AS `name`,`affinity_group`.`type` AS `type`,`affinity_group`.`description` AS `description`,`affinity_group`.`uuid` AS `uuid`,`affinity_group`.`acl_type` AS `acl_type`,`account`.`id` AS `account_id`,`account`.`uuid` AS `account_uuid`,`account`.`account_name` AS `account_name`,`account`.`type` AS `account_type`,`domain`.`id` AS `domain_id`,`domain`.`uuid` AS `domain_uuid`,`domain`.`name` AS `domain_name`,`domain`.`path` AS `domain_path`,`vm_instance`.`id` AS `vm_id`,`vm_instance`.`uuid` AS `vm_uuid`,`vm_instance`.`name` AS `vm_name`,`vm_instance`.`state` AS `vm_state`,`user_vm`.`display_name` AS `vm_display_name` from (((((`affinity_group` join `account` on((`affinity_group`.`account_id` = `account`.`id`))) join `domain` on((`affinity_group`.`domain_id` = `domain`.`id`))) left join `affinity_group_vm_map` on((`affinity_group`.`id` = `affinity_group_vm_map`.`affinity_group_id`))) left join `vm_instance` on((`vm_instance`.`id` = `affinity_group_vm_map`.`instance_id`))) left join `user_vm` on((`user_vm`.`id` = `vm_instance`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `async_job_view`
--

/*!50001 DROP TABLE IF EXISTS `async_job_view`*/;
/*!50001 DROP VIEW IF EXISTS `async_job_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `async_job_view` AS select `account`.`id` AS `account_id`,`account`.`uuid` AS `account_uuid`,`account`.`account_name` AS `account_name`,`account`.`type` AS `account_type`,`domain`.`id` AS `domain_id`,`domain`.`uuid` AS `domain_uuid`,`domain`.`name` AS `domain_name`,`domain`.`path` AS `domain_path`,`user`.`id` AS `user_id`,`user`.`uuid` AS `user_uuid`,`async_job`.`id` AS `id`,`async_job`.`uuid` AS `uuid`,`async_job`.`job_cmd` AS `job_cmd`,`async_job`.`job_status` AS `job_status`,`async_job`.`job_process_status` AS `job_process_status`,`async_job`.`job_result_code` AS `job_result_code`,`async_job`.`job_result` AS `job_result`,`async_job`.`created` AS `created`,`async_job`.`removed` AS `removed`,`async_job`.`instance_type` AS `instance_type`,`async_job`.`instance_id` AS `instance_id`,(case when (`async_job`.`instance_type` = 'Volume') then `volumes`.`uuid` when ((`async_job`.`instance_type` = 'Template') or (`async_job`.`instance_type` = 'Iso')) then `vm_template`.`uuid` when ((`async_job`.`instance_type` = 'VirtualMachine') or (`async_job`.`instance_type` = 'ConsoleProxy') or (`async_job`.`instance_type` = 'SystemVm') or (`async_job`.`instance_type` = 'DomainRouter')) then `vm_instance`.`uuid` when (`async_job`.`instance_type` = 'Snapshot') then `snapshots`.`uuid` when (`async_job`.`instance_type` = 'Host') then `host`.`uuid` when (`async_job`.`instance_type` = 'StoragePool') then `storage_pool`.`uuid` when (`async_job`.`instance_type` = 'IpAddress') then `user_ip_address`.`uuid` when (`async_job`.`instance_type` = 'SecurityGroup') then `security_group`.`uuid` when (`async_job`.`instance_type` = 'PhysicalNetwork') then `physical_network`.`uuid` when (`async_job`.`instance_type` = 'TrafficType') then `physical_network_traffic_types`.`uuid` when (`async_job`.`instance_type` = 'PhysicalNetworkServiceProvider') then `physical_network_service_providers`.`uuid` when (`async_job`.`instance_type` = 'FirewallRule') then `firewall_rules`.`uuid` when (`async_job`.`instance_type` = 'Account') then `acct`.`uuid` when (`async_job`.`instance_type` = 'User') then `us`.`uuid` when (`async_job`.`instance_type` = 'StaticRoute') then `static_routes`.`uuid` when (`async_job`.`instance_type` = 'PrivateGateway') then `vpc_gateways`.`uuid` when (`async_job`.`instance_type` = 'Counter') then `counter`.`uuid` when (`async_job`.`instance_type` = 'Condition') then `conditions`.`uuid` when (`async_job`.`instance_type` = 'AutoScalePolicy') then `autoscale_policies`.`uuid` when (`async_job`.`instance_type` = 'AutoScaleVmProfile') then `autoscale_vmprofiles`.`uuid` when (`async_job`.`instance_type` = 'AutoScaleVmGroup') then `autoscale_vmgroups`.`uuid` else NULL end) AS `instance_uuid` from ((((((((((((((((((((((((`async_job` left join `account` on((`async_job`.`account_id` = `account`.`id`))) left join `domain` on((`domain`.`id` = `account`.`domain_id`))) left join `user` on((`async_job`.`user_id` = `user`.`id`))) left join `volumes` on((`async_job`.`instance_id` = `volumes`.`id`))) left join `vm_template` on((`async_job`.`instance_id` = `vm_template`.`id`))) left join `vm_instance` on((`async_job`.`instance_id` = `vm_instance`.`id`))) left join `snapshots` on((`async_job`.`instance_id` = `snapshots`.`id`))) left join `host` on((`async_job`.`instance_id` = `host`.`id`))) left join `storage_pool` on((`async_job`.`instance_id` = `storage_pool`.`id`))) left join `user_ip_address` on((`async_job`.`instance_id` = `user_ip_address`.`id`))) left join `security_group` on((`async_job`.`instance_id` = `security_group`.`id`))) left join `physical_network` on((`async_job`.`instance_id` = `physical_network`.`id`))) left join `physical_network_traffic_types` on((`async_job`.`instance_id` = `physical_network_traffic_types`.`id`))) left join `physical_network_service_providers` on((`async_job`.`instance_id` = `physical_network_service_providers`.`id`))) left join `firewall_rules` on((`async_job`.`instance_id` = `firewall_rules`.`id`))) left join `account` `acct` on((`async_job`.`instance_id` = `acct`.`id`))) left join `user` `us` on((`async_job`.`instance_id` = `us`.`id`))) left join `static_routes` on((`async_job`.`instance_id` = `static_routes`.`id`))) left join `vpc_gateways` on((`async_job`.`instance_id` = `vpc_gateways`.`id`))) left join `counter` on((`async_job`.`instance_id` = `counter`.`id`))) left join `conditions` on((`async_job`.`instance_id` = `conditions`.`id`))) left join `autoscale_policies` on((`async_job`.`instance_id` = `autoscale_policies`.`id`))) left join `autoscale_vmprofiles` on((`async_job`.`instance_id` = `autoscale_vmprofiles`.`id`))) left join `autoscale_vmgroups` on((`async_job`.`instance_id` = `autoscale_vmgroups`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `data_center_view`
--

/*!50001 DROP TABLE IF EXISTS `data_center_view`*/;
/*!50001 DROP VIEW IF EXISTS `data_center_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `data_center_view` AS select `data_center`.`id` AS `id`,`data_center`.`uuid` AS `uuid`,`data_center`.`name` AS `name`,`data_center`.`is_security_group_enabled` AS `is_security_group_enabled`,`data_center`.`is_local_storage_enabled` AS `is_local_storage_enabled`,`data_center`.`description` AS `description`,`data_center`.`dns1` AS `dns1`,`data_center`.`dns2` AS `dns2`,`data_center`.`ip6_dns1` AS `ip6_dns1`,`data_center`.`ip6_dns2` AS `ip6_dns2`,`data_center`.`internal_dns1` AS `internal_dns1`,`data_center`.`internal_dns2` AS `internal_dns2`,`data_center`.`guest_network_cidr` AS `guest_network_cidr`,`data_center`.`domain` AS `domain`,`data_center`.`networktype` AS `networktype`,`data_center`.`allocation_state` AS `allocation_state`,`data_center`.`zone_token` AS `zone_token`,`data_center`.`dhcp_provider` AS `dhcp_provider`,`data_center`.`removed` AS `removed`,`domain`.`id` AS `domain_id`,`domain`.`uuid` AS `domain_uuid`,`domain`.`name` AS `domain_name`,`domain`.`path` AS `domain_path`,`dedicated_resources`.`affinity_group_id` AS `affinity_group_id`,`dedicated_resources`.`account_id` AS `account_id`,`affinity_group`.`uuid` AS `affinity_group_uuid` from (((`data_center` left join `domain` on((`data_center`.`domain_id` = `domain`.`id`))) left join `dedicated_resources` on((`data_center`.`id` = `dedicated_resources`.`data_center_id`))) left join `affinity_group` on((`dedicated_resources`.`affinity_group_id` = `affinity_group`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `disk_offering_view`
--

/*!50001 DROP TABLE IF EXISTS `disk_offering_view`*/;
/*!50001 DROP VIEW IF EXISTS `disk_offering_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `disk_offering_view` AS select `disk_offering`.`id` AS `id`,`disk_offering`.`uuid` AS `uuid`,`disk_offering`.`name` AS `name`,`disk_offering`.`display_text` AS `display_text`,`disk_offering`.`disk_size` AS `disk_size`,`disk_offering`.`min_iops` AS `min_iops`,`disk_offering`.`max_iops` AS `max_iops`,`disk_offering`.`created` AS `created`,`disk_offering`.`tags` AS `tags`,`disk_offering`.`customized` AS `customized`,`disk_offering`.`customized_iops` AS `customized_iops`,`disk_offering`.`removed` AS `removed`,`disk_offering`.`use_local_storage` AS `use_local_storage`,`disk_offering`.`system_use` AS `system_use`,`disk_offering`.`hv_ss_reserve` AS `hv_ss_reserve`,`disk_offering`.`bytes_read_rate` AS `bytes_read_rate`,`disk_offering`.`bytes_write_rate` AS `bytes_write_rate`,`disk_offering`.`iops_read_rate` AS `iops_read_rate`,`disk_offering`.`iops_write_rate` AS `iops_write_rate`,`disk_offering`.`cache_mode` AS `cache_mode`,`disk_offering`.`sort_key` AS `sort_key`,`disk_offering`.`type` AS `type`,`disk_offering`.`display_offering` AS `display_offering`,`domain`.`id` AS `domain_id`,`domain`.`uuid` AS `domain_uuid`,`domain`.`name` AS `domain_name`,`domain`.`path` AS `domain_path` from (`disk_offering` left join `domain` on((`disk_offering`.`domain_id` = `domain`.`id`))) where (`disk_offering`.`state` = 'ACTIVE') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `domain_router_view`
--

/*!50001 DROP TABLE IF EXISTS `domain_router_view`*/;
/*!50001 DROP VIEW IF EXISTS `domain_router_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `domain_router_view` AS select `vm_instance`.`id` AS `id`,`vm_instance`.`name` AS `name`,`account`.`id` AS `account_id`,`account`.`uuid` AS `account_uuid`,`account`.`account_name` AS `account_name`,`account`.`type` AS `account_type`,`domain`.`id` AS `domain_id`,`domain`.`uuid` AS `domain_uuid`,`domain`.`name` AS `domain_name`,`domain`.`path` AS `domain_path`,`projects`.`id` AS `project_id`,`projects`.`uuid` AS `project_uuid`,`projects`.`name` AS `project_name`,`vm_instance`.`uuid` AS `uuid`,`vm_instance`.`created` AS `created`,`vm_instance`.`state` AS `state`,`vm_instance`.`removed` AS `removed`,`vm_instance`.`pod_id` AS `pod_id`,`vm_instance`.`instance_name` AS `instance_name`,`host_pod_ref`.`uuid` AS `pod_uuid`,`data_center`.`id` AS `data_center_id`,`data_center`.`uuid` AS `data_center_uuid`,`data_center`.`name` AS `data_center_name`,`data_center`.`networktype` AS `data_center_type`,`data_center`.`dns1` AS `dns1`,`data_center`.`dns2` AS `dns2`,`data_center`.`ip6_dns1` AS `ip6_dns1`,`data_center`.`ip6_dns2` AS `ip6_dns2`,`host`.`id` AS `host_id`,`host`.`uuid` AS `host_uuid`,`host`.`name` AS `host_name`,`host`.`cluster_id` AS `cluster_id`,`vm_template`.`id` AS `template_id`,`vm_template`.`uuid` AS `template_uuid`,`service_offering`.`id` AS `service_offering_id`,`disk_offering`.`uuid` AS `service_offering_uuid`,`disk_offering`.`name` AS `service_offering_name`,`nics`.`id` AS `nic_id`,`nics`.`uuid` AS `nic_uuid`,`nics`.`network_id` AS `network_id`,`nics`.`ip4_address` AS `ip_address`,`nics`.`ip6_address` AS `ip6_address`,`nics`.`ip6_gateway` AS `ip6_gateway`,`nics`.`ip6_cidr` AS `ip6_cidr`,`nics`.`default_nic` AS `is_default_nic`,`nics`.`gateway` AS `gateway`,`nics`.`netmask` AS `netmask`,`nics`.`mac_address` AS `mac_address`,`nics`.`broadcast_uri` AS `broadcast_uri`,`nics`.`isolation_uri` AS `isolation_uri`,`vpc`.`id` AS `vpc_id`,`vpc`.`uuid` AS `vpc_uuid`,`networks`.`uuid` AS `network_uuid`,`networks`.`name` AS `network_name`,`networks`.`network_domain` AS `network_domain`,`networks`.`traffic_type` AS `traffic_type`,`networks`.`guest_type` AS `guest_type`,`async_job`.`id` AS `job_id`,`async_job`.`uuid` AS `job_uuid`,`async_job`.`job_status` AS `job_status`,`async_job`.`account_id` AS `job_account_id`,`domain_router`.`template_version` AS `template_version`,`domain_router`.`scripts_version` AS `scripts_version`,`domain_router`.`is_redundant_router` AS `is_redundant_router`,`domain_router`.`redundant_state` AS `redundant_state`,`domain_router`.`stop_pending` AS `stop_pending`,`domain_router`.`role` AS `role` from ((((((((((((((`domain_router` join `vm_instance` on((`vm_instance`.`id` = `domain_router`.`id`))) join `account` on((`vm_instance`.`account_id` = `account`.`id`))) join `domain` on((`vm_instance`.`domain_id` = `domain`.`id`))) left join `host_pod_ref` on((`vm_instance`.`pod_id` = `host_pod_ref`.`id`))) left join `projects` on((`projects`.`project_account_id` = `account`.`id`))) left join `data_center` on((`vm_instance`.`data_center_id` = `data_center`.`id`))) left join `host` on((`vm_instance`.`host_id` = `host`.`id`))) left join `vm_template` on((`vm_instance`.`vm_template_id` = `vm_template`.`id`))) left join `service_offering` on((`vm_instance`.`service_offering_id` = `service_offering`.`id`))) left join `disk_offering` on((`vm_instance`.`service_offering_id` = `disk_offering`.`id`))) left join `nics` on(((`vm_instance`.`id` = `nics`.`instance_id`) and isnull(`nics`.`removed`)))) left join `networks` on((`nics`.`network_id` = `networks`.`id`))) left join `vpc` on(((`domain_router`.`vpc_id` = `vpc`.`id`) and isnull(`vpc`.`removed`)))) left join `async_job` on(((`async_job`.`instance_id` = `vm_instance`.`id`) and (`async_job`.`instance_type` = 'DomainRouter') and (`async_job`.`job_status` = 0)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `event_view`
--

/*!50001 DROP TABLE IF EXISTS `event_view`*/;
/*!50001 DROP VIEW IF EXISTS `event_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `event_view` AS select `event`.`id` AS `id`,`event`.`uuid` AS `uuid`,`event`.`type` AS `type`,`event`.`state` AS `state`,`event`.`description` AS `description`,`event`.`created` AS `created`,`event`.`level` AS `level`,`event`.`parameters` AS `parameters`,`event`.`start_id` AS `start_id`,`eve`.`uuid` AS `start_uuid`,`event`.`user_id` AS `user_id`,`event`.`archived` AS `archived`,`event`.`display` AS `display`,`user`.`username` AS `user_name`,`account`.`id` AS `account_id`,`account`.`uuid` AS `account_uuid`,`account`.`account_name` AS `account_name`,`account`.`type` AS `account_type`,`domain`.`id` AS `domain_id`,`domain`.`uuid` AS `domain_uuid`,`domain`.`name` AS `domain_name`,`domain`.`path` AS `domain_path`,`projects`.`id` AS `project_id`,`projects`.`uuid` AS `project_uuid`,`projects`.`name` AS `project_name` from (((((`event` join `account` on((`event`.`account_id` = `account`.`id`))) join `domain` on((`event`.`domain_id` = `domain`.`id`))) join `user` on((`event`.`user_id` = `user`.`id`))) left join `projects` on((`projects`.`project_account_id` = `event`.`account_id`))) left join `event` `eve` on((`event`.`start_id` = `eve`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `free_ip_view`
--

/*!50001 DROP TABLE IF EXISTS `free_ip_view`*/;
/*!50001 DROP VIEW IF EXISTS `free_ip_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `free_ip_view` AS select count(`user_ip_address`.`id`) AS `free_ip` from (`user_ip_address` join `vlan` on(((`vlan`.`id` = `user_ip_address`.`vlan_db_id`) and (`vlan`.`vlan_type` = 'VirtualNetwork')))) where (`user_ip_address`.`state` = 'Free') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `host_view`
--

/*!50001 DROP TABLE IF EXISTS `host_view`*/;
/*!50001 DROP VIEW IF EXISTS `host_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `host_view` AS select `host`.`id` AS `id`,`host`.`uuid` AS `uuid`,`host`.`name` AS `name`,`host`.`status` AS `status`,`host`.`disconnected` AS `disconnected`,`host`.`type` AS `type`,`host`.`private_ip_address` AS `private_ip_address`,`host`.`version` AS `version`,`host`.`hypervisor_type` AS `hypervisor_type`,`host`.`hypervisor_version` AS `hypervisor_version`,`host`.`capabilities` AS `capabilities`,`host`.`last_ping` AS `last_ping`,`host`.`created` AS `created`,`host`.`removed` AS `removed`,`host`.`resource_state` AS `resource_state`,`host`.`mgmt_server_id` AS `mgmt_server_id`,`host`.`cpu_sockets` AS `cpu_sockets`,`host`.`cpus` AS `cpus`,`host`.`speed` AS `speed`,`host`.`ram` AS `ram`,`cluster`.`id` AS `cluster_id`,`cluster`.`uuid` AS `cluster_uuid`,`cluster`.`name` AS `cluster_name`,`cluster`.`cluster_type` AS `cluster_type`,`data_center`.`id` AS `data_center_id`,`data_center`.`uuid` AS `data_center_uuid`,`data_center`.`name` AS `data_center_name`,`data_center`.`networktype` AS `data_center_type`,`host_pod_ref`.`id` AS `pod_id`,`host_pod_ref`.`uuid` AS `pod_uuid`,`host_pod_ref`.`name` AS `pod_name`,`host_tags`.`tag` AS `tag`,`guest_os_category`.`id` AS `guest_os_category_id`,`guest_os_category`.`uuid` AS `guest_os_category_uuid`,`guest_os_category`.`name` AS `guest_os_category_name`,`mem_caps`.`used_capacity` AS `memory_used_capacity`,`mem_caps`.`reserved_capacity` AS `memory_reserved_capacity`,`cpu_caps`.`used_capacity` AS `cpu_used_capacity`,`cpu_caps`.`reserved_capacity` AS `cpu_reserved_capacity`,`async_job`.`id` AS `job_id`,`async_job`.`uuid` AS `job_uuid`,`async_job`.`job_status` AS `job_status`,`async_job`.`account_id` AS `job_account_id` from (((((((((`host` left join `cluster` on((`host`.`cluster_id` = `cluster`.`id`))) left join `data_center` on((`host`.`data_center_id` = `data_center`.`id`))) left join `host_pod_ref` on((`host`.`pod_id` = `host_pod_ref`.`id`))) left join `host_details` on(((`host`.`id` = `host_details`.`host_id`) and (`host_details`.`name` = 'guest.os.category.id')))) left join `guest_os_category` on((`guest_os_category`.`id` = cast(`host_details`.`value` as unsigned)))) left join `host_tags` on((`host_tags`.`host_id` = `host`.`id`))) left join `op_host_capacity` `mem_caps` on(((`host`.`id` = `mem_caps`.`host_id`) and (`mem_caps`.`capacity_type` = 0)))) left join `op_host_capacity` `cpu_caps` on(((`host`.`id` = `cpu_caps`.`host_id`) and (`cpu_caps`.`capacity_type` = 1)))) left join `async_job` on(((`async_job`.`instance_id` = `host`.`id`) and (`async_job`.`instance_type` = 'Host') and (`async_job`.`job_status` = 0)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `image_store_view`
--

/*!50001 DROP TABLE IF EXISTS `image_store_view`*/;
/*!50001 DROP VIEW IF EXISTS `image_store_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `image_store_view` AS select `image_store`.`id` AS `id`,`image_store`.`uuid` AS `uuid`,`image_store`.`name` AS `name`,`image_store`.`image_provider_name` AS `image_provider_name`,`image_store`.`protocol` AS `protocol`,`image_store`.`url` AS `url`,`image_store`.`scope` AS `scope`,`image_store`.`role` AS `role`,`image_store`.`removed` AS `removed`,`data_center`.`id` AS `data_center_id`,`data_center`.`uuid` AS `data_center_uuid`,`data_center`.`name` AS `data_center_name`,`image_store_details`.`name` AS `detail_name`,`image_store_details`.`value` AS `detail_value` from ((`image_store` left join `data_center` on((`image_store`.`data_center_id` = `data_center`.`id`))) left join `image_store_details` on((`image_store_details`.`store_id` = `image_store`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `instance_group_view`
--

/*!50001 DROP TABLE IF EXISTS `instance_group_view`*/;
/*!50001 DROP VIEW IF EXISTS `instance_group_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `instance_group_view` AS select `instance_group`.`id` AS `id`,`instance_group`.`uuid` AS `uuid`,`instance_group`.`name` AS `name`,`instance_group`.`removed` AS `removed`,`instance_group`.`created` AS `created`,`account`.`id` AS `account_id`,`account`.`uuid` AS `account_uuid`,`account`.`account_name` AS `account_name`,`account`.`type` AS `account_type`,`domain`.`id` AS `domain_id`,`domain`.`uuid` AS `domain_uuid`,`domain`.`name` AS `domain_name`,`domain`.`path` AS `domain_path`,`projects`.`id` AS `project_id`,`projects`.`uuid` AS `project_uuid`,`projects`.`name` AS `project_name` from (((`instance_group` join `account` on((`instance_group`.`account_id` = `account`.`id`))) join `domain` on((`account`.`domain_id` = `domain`.`id`))) left join `projects` on((`projects`.`project_account_id` = `instance_group`.`account_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `project_account_view`
--

/*!50001 DROP TABLE IF EXISTS `project_account_view`*/;
/*!50001 DROP VIEW IF EXISTS `project_account_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `project_account_view` AS select `project_account`.`id` AS `id`,`account`.`id` AS `account_id`,`account`.`uuid` AS `account_uuid`,`account`.`account_name` AS `account_name`,`account`.`type` AS `account_type`,`project_account`.`account_role` AS `account_role`,`projects`.`id` AS `project_id`,`projects`.`uuid` AS `project_uuid`,`projects`.`name` AS `project_name`,`domain`.`id` AS `domain_id`,`domain`.`uuid` AS `domain_uuid`,`domain`.`name` AS `domain_name`,`domain`.`path` AS `domain_path` from (((`project_account` join `account` on((`project_account`.`account_id` = `account`.`id`))) join `domain` on((`account`.`domain_id` = `domain`.`id`))) join `projects` on((`projects`.`id` = `project_account`.`project_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `project_invitation_view`
--

/*!50001 DROP TABLE IF EXISTS `project_invitation_view`*/;
/*!50001 DROP VIEW IF EXISTS `project_invitation_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `project_invitation_view` AS select `project_invitations`.`id` AS `id`,`project_invitations`.`uuid` AS `uuid`,`project_invitations`.`email` AS `email`,`project_invitations`.`created` AS `created`,`project_invitations`.`state` AS `state`,`projects`.`id` AS `project_id`,`projects`.`uuid` AS `project_uuid`,`projects`.`name` AS `project_name`,`account`.`id` AS `account_id`,`account`.`uuid` AS `account_uuid`,`account`.`account_name` AS `account_name`,`account`.`type` AS `account_type`,`domain`.`id` AS `domain_id`,`domain`.`uuid` AS `domain_uuid`,`domain`.`name` AS `domain_name`,`domain`.`path` AS `domain_path` from (((`project_invitations` left join `account` on((`project_invitations`.`account_id` = `account`.`id`))) left join `domain` on((`project_invitations`.`domain_id` = `domain`.`id`))) left join `projects` on((`projects`.`id` = `project_invitations`.`project_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `project_view`
--

/*!50001 DROP TABLE IF EXISTS `project_view`*/;
/*!50001 DROP VIEW IF EXISTS `project_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `project_view` AS select `projects`.`id` AS `id`,`projects`.`uuid` AS `uuid`,`projects`.`name` AS `name`,`projects`.`display_text` AS `display_text`,`projects`.`state` AS `state`,`projects`.`removed` AS `removed`,`projects`.`created` AS `created`,`projects`.`project_account_id` AS `project_account_id`,`account`.`account_name` AS `owner`,`pacct`.`account_id` AS `account_id`,`domain`.`id` AS `domain_id`,`domain`.`uuid` AS `domain_uuid`,`domain`.`name` AS `domain_name`,`domain`.`path` AS `domain_path`,`resource_tags`.`id` AS `tag_id`,`resource_tags`.`uuid` AS `tag_uuid`,`resource_tags`.`key` AS `tag_key`,`resource_tags`.`value` AS `tag_value`,`resource_tags`.`domain_id` AS `tag_domain_id`,`resource_tags`.`account_id` AS `tag_account_id`,`resource_tags`.`resource_id` AS `tag_resource_id`,`resource_tags`.`resource_uuid` AS `tag_resource_uuid`,`resource_tags`.`resource_type` AS `tag_resource_type`,`resource_tags`.`customer` AS `tag_customer` from (((((`projects` join `domain` on((`projects`.`domain_id` = `domain`.`id`))) join `project_account` on(((`projects`.`id` = `project_account`.`project_id`) and (`project_account`.`account_role` = 'Admin')))) join `account` on((`account`.`id` = `project_account`.`account_id`))) left join `resource_tags` on(((`resource_tags`.`resource_id` = `projects`.`id`) and (`resource_tags`.`resource_type` = 'Project')))) left join `project_account` `pacct` on((`projects`.`id` = `pacct`.`project_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `resource_tag_view`
--

/*!50001 DROP TABLE IF EXISTS `resource_tag_view`*/;
/*!50001 DROP VIEW IF EXISTS `resource_tag_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `resource_tag_view` AS select `resource_tags`.`id` AS `id`,`resource_tags`.`uuid` AS `uuid`,`resource_tags`.`key` AS `key`,`resource_tags`.`value` AS `value`,`resource_tags`.`resource_id` AS `resource_id`,`resource_tags`.`resource_uuid` AS `resource_uuid`,`resource_tags`.`resource_type` AS `resource_type`,`resource_tags`.`customer` AS `customer`,`account`.`id` AS `account_id`,`account`.`uuid` AS `account_uuid`,`account`.`account_name` AS `account_name`,`account`.`type` AS `account_type`,`domain`.`id` AS `domain_id`,`domain`.`uuid` AS `domain_uuid`,`domain`.`name` AS `domain_name`,`domain`.`path` AS `domain_path`,`projects`.`id` AS `project_id`,`projects`.`uuid` AS `project_uuid`,`projects`.`name` AS `project_name` from (((`resource_tags` join `account` on((`resource_tags`.`account_id` = `account`.`id`))) join `domain` on((`resource_tags`.`domain_id` = `domain`.`id`))) left join `projects` on((`projects`.`project_account_id` = `resource_tags`.`account_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `security_group_view`
--

/*!50001 DROP TABLE IF EXISTS `security_group_view`*/;
/*!50001 DROP VIEW IF EXISTS `security_group_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `security_group_view` AS select `security_group`.`id` AS `id`,`security_group`.`name` AS `name`,`security_group`.`description` AS `description`,`security_group`.`uuid` AS `uuid`,`account`.`id` AS `account_id`,`account`.`uuid` AS `account_uuid`,`account`.`account_name` AS `account_name`,`account`.`type` AS `account_type`,`domain`.`id` AS `domain_id`,`domain`.`uuid` AS `domain_uuid`,`domain`.`name` AS `domain_name`,`domain`.`path` AS `domain_path`,`projects`.`id` AS `project_id`,`projects`.`uuid` AS `project_uuid`,`projects`.`name` AS `project_name`,`security_group_rule`.`id` AS `rule_id`,`security_group_rule`.`uuid` AS `rule_uuid`,`security_group_rule`.`type` AS `rule_type`,`security_group_rule`.`start_port` AS `rule_start_port`,`security_group_rule`.`end_port` AS `rule_end_port`,`security_group_rule`.`protocol` AS `rule_protocol`,`security_group_rule`.`allowed_network_id` AS `rule_allowed_network_id`,`security_group_rule`.`allowed_ip_cidr` AS `rule_allowed_ip_cidr`,`security_group_rule`.`create_status` AS `rule_create_status`,`resource_tags`.`id` AS `tag_id`,`resource_tags`.`uuid` AS `tag_uuid`,`resource_tags`.`key` AS `tag_key`,`resource_tags`.`value` AS `tag_value`,`resource_tags`.`domain_id` AS `tag_domain_id`,`resource_tags`.`account_id` AS `tag_account_id`,`resource_tags`.`resource_id` AS `tag_resource_id`,`resource_tags`.`resource_uuid` AS `tag_resource_uuid`,`resource_tags`.`resource_type` AS `tag_resource_type`,`resource_tags`.`customer` AS `tag_customer`,`async_job`.`id` AS `job_id`,`async_job`.`uuid` AS `job_uuid`,`async_job`.`job_status` AS `job_status`,`async_job`.`account_id` AS `job_account_id` from ((((((`security_group` left join `security_group_rule` on((`security_group`.`id` = `security_group_rule`.`security_group_id`))) join `account` on((`security_group`.`account_id` = `account`.`id`))) join `domain` on((`security_group`.`domain_id` = `domain`.`id`))) left join `projects` on((`projects`.`project_account_id` = `security_group`.`account_id`))) left join `resource_tags` on(((`resource_tags`.`resource_id` = `security_group`.`id`) and (`resource_tags`.`resource_type` = 'SecurityGroup')))) left join `async_job` on(((`async_job`.`instance_id` = `security_group`.`id`) and (`async_job`.`instance_type` = 'SecurityGroup') and (`async_job`.`job_status` = 0)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `service_offering_view`
--

/*!50001 DROP TABLE IF EXISTS `service_offering_view`*/;
/*!50001 DROP VIEW IF EXISTS `service_offering_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `service_offering_view` AS select `service_offering`.`id` AS `id`,`disk_offering`.`uuid` AS `uuid`,`disk_offering`.`name` AS `name`,`disk_offering`.`display_text` AS `display_text`,`disk_offering`.`created` AS `created`,`disk_offering`.`tags` AS `tags`,`disk_offering`.`removed` AS `removed`,`disk_offering`.`use_local_storage` AS `use_local_storage`,`disk_offering`.`system_use` AS `system_use`,`disk_offering`.`customized_iops` AS `customized_iops`,`disk_offering`.`min_iops` AS `min_iops`,`disk_offering`.`max_iops` AS `max_iops`,`disk_offering`.`hv_ss_reserve` AS `hv_ss_reserve`,`disk_offering`.`bytes_read_rate` AS `bytes_read_rate`,`disk_offering`.`bytes_write_rate` AS `bytes_write_rate`,`disk_offering`.`iops_read_rate` AS `iops_read_rate`,`disk_offering`.`iops_write_rate` AS `iops_write_rate`,`disk_offering`.`cache_mode` AS `cache_mode`,`service_offering`.`cpu` AS `cpu`,`service_offering`.`speed` AS `speed`,`service_offering`.`ram_size` AS `ram_size`,`service_offering`.`nw_rate` AS `nw_rate`,`service_offering`.`mc_rate` AS `mc_rate`,`service_offering`.`ha_enabled` AS `ha_enabled`,`service_offering`.`limit_cpu_use` AS `limit_cpu_use`,`service_offering`.`host_tag` AS `host_tag`,`service_offering`.`default_use` AS `default_use`,`service_offering`.`vm_type` AS `vm_type`,`service_offering`.`sort_key` AS `sort_key`,`service_offering`.`is_volatile` AS `is_volatile`,`service_offering`.`deployment_planner` AS `deployment_planner`,`domain`.`id` AS `domain_id`,`domain`.`uuid` AS `domain_uuid`,`domain`.`name` AS `domain_name`,`domain`.`path` AS `domain_path` from ((`service_offering` join `disk_offering` on((`service_offering`.`id` = `disk_offering`.`id`))) left join `domain` on((`disk_offering`.`domain_id` = `domain`.`id`))) where (`disk_offering`.`state` = 'Active') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `storage_pool_view`
--

/*!50001 DROP TABLE IF EXISTS `storage_pool_view`*/;
/*!50001 DROP VIEW IF EXISTS `storage_pool_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `storage_pool_view` AS select `storage_pool`.`id` AS `id`,`storage_pool`.`uuid` AS `uuid`,`storage_pool`.`name` AS `name`,`storage_pool`.`status` AS `status`,`storage_pool`.`path` AS `path`,`storage_pool`.`pool_type` AS `pool_type`,`storage_pool`.`host_address` AS `host_address`,`storage_pool`.`created` AS `created`,`storage_pool`.`removed` AS `removed`,`storage_pool`.`capacity_bytes` AS `capacity_bytes`,`storage_pool`.`capacity_iops` AS `capacity_iops`,`storage_pool`.`scope` AS `scope`,`storage_pool`.`hypervisor` AS `hypervisor`,`storage_pool`.`storage_provider_name` AS `storage_provider_name`,`cluster`.`id` AS `cluster_id`,`cluster`.`uuid` AS `cluster_uuid`,`cluster`.`name` AS `cluster_name`,`cluster`.`cluster_type` AS `cluster_type`,`data_center`.`id` AS `data_center_id`,`data_center`.`uuid` AS `data_center_uuid`,`data_center`.`name` AS `data_center_name`,`data_center`.`networktype` AS `data_center_type`,`host_pod_ref`.`id` AS `pod_id`,`host_pod_ref`.`uuid` AS `pod_uuid`,`host_pod_ref`.`name` AS `pod_name`,`storage_pool_details`.`name` AS `tag`,`op_host_capacity`.`used_capacity` AS `disk_used_capacity`,`op_host_capacity`.`reserved_capacity` AS `disk_reserved_capacity`,`async_job`.`id` AS `job_id`,`async_job`.`uuid` AS `job_uuid`,`async_job`.`job_status` AS `job_status`,`async_job`.`account_id` AS `job_account_id` from ((((((`storage_pool` left join `cluster` on((`storage_pool`.`cluster_id` = `cluster`.`id`))) left join `data_center` on((`storage_pool`.`data_center_id` = `data_center`.`id`))) left join `host_pod_ref` on((`storage_pool`.`pod_id` = `host_pod_ref`.`id`))) left join `storage_pool_details` on(((`storage_pool_details`.`pool_id` = `storage_pool`.`id`) and (`storage_pool_details`.`value` = 'true')))) left join `op_host_capacity` on(((`storage_pool`.`id` = `op_host_capacity`.`host_id`) and (`op_host_capacity`.`capacity_type` = 3)))) left join `async_job` on(((`async_job`.`instance_id` = `storage_pool`.`id`) and (`async_job`.`instance_type` = 'StoragePool') and (`async_job`.`job_status` = 0)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `template_view`
--

/*!50001 DROP TABLE IF EXISTS `template_view`*/;
/*!50001 DROP VIEW IF EXISTS `template_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `template_view` AS select `vm_template`.`id` AS `id`,`vm_template`.`uuid` AS `uuid`,`vm_template`.`unique_name` AS `unique_name`,`vm_template`.`name` AS `name`,`vm_template`.`public` AS `public`,`vm_template`.`featured` AS `featured`,`vm_template`.`type` AS `type`,`vm_template`.`hvm` AS `hvm`,`vm_template`.`bits` AS `bits`,`vm_template`.`url` AS `url`,`vm_template`.`format` AS `format`,`vm_template`.`created` AS `created`,`vm_template`.`checksum` AS `checksum`,`vm_template`.`display_text` AS `display_text`,`vm_template`.`enable_password` AS `enable_password`,`vm_template`.`dynamically_scalable` AS `dynamically_scalable`,`vm_template`.`state` AS `template_state`,`vm_template`.`guest_os_id` AS `guest_os_id`,`guest_os`.`uuid` AS `guest_os_uuid`,`guest_os`.`display_name` AS `guest_os_name`,`vm_template`.`bootable` AS `bootable`,`vm_template`.`prepopulate` AS `prepopulate`,`vm_template`.`cross_zones` AS `cross_zones`,`vm_template`.`hypervisor_type` AS `hypervisor_type`,`vm_template`.`extractable` AS `extractable`,`vm_template`.`template_tag` AS `template_tag`,`vm_template`.`sort_key` AS `sort_key`,`vm_template`.`removed` AS `removed`,`vm_template`.`enable_sshkey` AS `enable_sshkey`,`source_template`.`id` AS `source_template_id`,`source_template`.`uuid` AS `source_template_uuid`,`account`.`id` AS `account_id`,`account`.`uuid` AS `account_uuid`,`account`.`account_name` AS `account_name`,`account`.`type` AS `account_type`,`domain`.`id` AS `domain_id`,`domain`.`uuid` AS `domain_uuid`,`domain`.`name` AS `domain_name`,`domain`.`path` AS `domain_path`,`projects`.`id` AS `project_id`,`projects`.`uuid` AS `project_uuid`,`projects`.`name` AS `project_name`,`data_center`.`id` AS `data_center_id`,`data_center`.`uuid` AS `data_center_uuid`,`data_center`.`name` AS `data_center_name`,`launch_permission`.`account_id` AS `lp_account_id`,`template_store_ref`.`store_id` AS `store_id`,`image_store`.`scope` AS `store_scope`,`template_store_ref`.`state` AS `state`,`template_store_ref`.`download_state` AS `download_state`,`template_store_ref`.`download_pct` AS `download_pct`,`template_store_ref`.`error_str` AS `error_str`,`template_store_ref`.`size` AS `size`,`template_store_ref`.`destroyed` AS `destroyed`,`template_store_ref`.`created` AS `created_on_store`,`vm_template_details`.`name` AS `detail_name`,`vm_template_details`.`value` AS `detail_value`,`resource_tags`.`id` AS `tag_id`,`resource_tags`.`uuid` AS `tag_uuid`,`resource_tags`.`key` AS `tag_key`,`resource_tags`.`value` AS `tag_value`,`resource_tags`.`domain_id` AS `tag_domain_id`,`resource_tags`.`account_id` AS `tag_account_id`,`resource_tags`.`resource_id` AS `tag_resource_id`,`resource_tags`.`resource_uuid` AS `tag_resource_uuid`,`resource_tags`.`resource_type` AS `tag_resource_type`,`resource_tags`.`customer` AS `tag_customer`,concat(`vm_template`.`id`,'_',ifnull(`data_center`.`id`,0)) AS `temp_zone_pair` from ((((((((((((`vm_template` join `guest_os` on((`guest_os`.`id` = `vm_template`.`guest_os_id`))) join `account` on((`account`.`id` = `vm_template`.`account_id`))) join `domain` on((`domain`.`id` = `account`.`domain_id`))) left join `projects` on((`projects`.`project_account_id` = `account`.`id`))) left join `vm_template_details` on((`vm_template_details`.`template_id` = `vm_template`.`id`))) left join `vm_template` `source_template` on((`source_template`.`id` = `vm_template`.`source_template_id`))) left join `template_store_ref` on(((`template_store_ref`.`template_id` = `vm_template`.`id`) and (`template_store_ref`.`store_role` = 'Image') and (`template_store_ref`.`destroyed` = 0)))) left join `image_store` on((isnull(`image_store`.`removed`) and (`template_store_ref`.`store_id` is not null) and (`image_store`.`id` = `template_store_ref`.`store_id`)))) left join `template_zone_ref` on(((`template_zone_ref`.`template_id` = `vm_template`.`id`) and isnull(`template_store_ref`.`store_id`) and isnull(`template_zone_ref`.`removed`)))) left join `data_center` on(((`image_store`.`data_center_id` = `data_center`.`id`) or (`template_zone_ref`.`zone_id` = `data_center`.`id`)))) left join `launch_permission` on((`launch_permission`.`template_id` = `vm_template`.`id`))) left join `resource_tags` on(((`resource_tags`.`resource_id` = `vm_template`.`id`) and ((`resource_tags`.`resource_type` = 'Template') or (`resource_tags`.`resource_type` = 'ISO'))))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `user_view`
--

/*!50001 DROP TABLE IF EXISTS `user_view`*/;
/*!50001 DROP VIEW IF EXISTS `user_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `user_view` AS select `user`.`id` AS `id`,`user`.`uuid` AS `uuid`,`user`.`username` AS `username`,`user`.`password` AS `password`,`user`.`firstname` AS `firstname`,`user`.`lastname` AS `lastname`,`user`.`email` AS `email`,`user`.`state` AS `state`,`user`.`api_key` AS `api_key`,`user`.`secret_key` AS `secret_key`,`user`.`created` AS `created`,`user`.`removed` AS `removed`,`user`.`timezone` AS `timezone`,`user`.`registration_token` AS `registration_token`,`user`.`is_registered` AS `is_registered`,`user`.`incorrect_login_attempts` AS `incorrect_login_attempts`,`user`.`default` AS `default`,`account`.`id` AS `account_id`,`account`.`uuid` AS `account_uuid`,`account`.`account_name` AS `account_name`,`account`.`type` AS `account_type`,`domain`.`id` AS `domain_id`,`domain`.`uuid` AS `domain_uuid`,`domain`.`name` AS `domain_name`,`domain`.`path` AS `domain_path`,`async_job`.`id` AS `job_id`,`async_job`.`uuid` AS `job_uuid`,`async_job`.`job_status` AS `job_status`,`async_job`.`account_id` AS `job_account_id` from (((`user` join `account` on((`user`.`account_id` = `account`.`id`))) join `domain` on((`account`.`domain_id` = `domain`.`id`))) left join `async_job` on(((`async_job`.`instance_id` = `user`.`id`) and (`async_job`.`instance_type` = 'User') and (`async_job`.`job_status` = 0)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `user_vm_view`
--

/*!50001 DROP TABLE IF EXISTS `user_vm_view`*/;
/*!50001 DROP VIEW IF EXISTS `user_vm_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `user_vm_view` AS select `vm_instance`.`id` AS `id`,`vm_instance`.`name` AS `name`,`user_vm`.`display_name` AS `display_name`,`user_vm`.`user_data` AS `user_data`,`account`.`id` AS `account_id`,`account`.`uuid` AS `account_uuid`,`account`.`account_name` AS `account_name`,`account`.`type` AS `account_type`,`domain`.`id` AS `domain_id`,`domain`.`uuid` AS `domain_uuid`,`domain`.`name` AS `domain_name`,`domain`.`path` AS `domain_path`,`projects`.`id` AS `project_id`,`projects`.`uuid` AS `project_uuid`,`projects`.`name` AS `project_name`,`instance_group`.`id` AS `instance_group_id`,`instance_group`.`uuid` AS `instance_group_uuid`,`instance_group`.`name` AS `instance_group_name`,`vm_instance`.`uuid` AS `uuid`,`vm_instance`.`last_host_id` AS `last_host_id`,`vm_instance`.`vm_type` AS `type`,`vm_instance`.`vnc_password` AS `vnc_password`,`vm_instance`.`limit_cpu_use` AS `limit_cpu_use`,`vm_instance`.`created` AS `created`,`vm_instance`.`state` AS `state`,`vm_instance`.`removed` AS `removed`,`vm_instance`.`ha_enabled` AS `ha_enabled`,`vm_instance`.`hypervisor_type` AS `hypervisor_type`,`vm_instance`.`instance_name` AS `instance_name`,`vm_instance`.`guest_os_id` AS `guest_os_id`,`vm_instance`.`display_vm` AS `display_vm`,`guest_os`.`uuid` AS `guest_os_uuid`,`vm_instance`.`pod_id` AS `pod_id`,`host_pod_ref`.`uuid` AS `pod_uuid`,`vm_instance`.`private_ip_address` AS `private_ip_address`,`vm_instance`.`private_mac_address` AS `private_mac_address`,`vm_instance`.`vm_type` AS `vm_type`,`data_center`.`id` AS `data_center_id`,`data_center`.`uuid` AS `data_center_uuid`,`data_center`.`name` AS `data_center_name`,`data_center`.`is_security_group_enabled` AS `security_group_enabled`,`data_center`.`networktype` AS `data_center_type`,`host`.`id` AS `host_id`,`host`.`uuid` AS `host_uuid`,`host`.`name` AS `host_name`,`vm_template`.`id` AS `template_id`,`vm_template`.`uuid` AS `template_uuid`,`vm_template`.`name` AS `template_name`,`vm_template`.`display_text` AS `template_display_text`,`vm_template`.`enable_password` AS `password_enabled`,`iso`.`id` AS `iso_id`,`iso`.`uuid` AS `iso_uuid`,`iso`.`name` AS `iso_name`,`iso`.`display_text` AS `iso_display_text`,`service_offering`.`id` AS `service_offering_id`,`svc_disk_offering`.`uuid` AS `service_offering_uuid`,`disk_offering`.`uuid` AS `disk_offering_uuid`,`disk_offering`.`id` AS `disk_offering_id`,(case when isnull(`service_offering`.`cpu`) then `custom_cpu`.`value` else `service_offering`.`cpu` end) AS `cpu`,(case when isnull(`service_offering`.`speed`) then `custom_speed`.`value` else `service_offering`.`speed` end) AS `speed`,(case when isnull(`service_offering`.`ram_size`) then `custom_ram_size`.`value` else `service_offering`.`ram_size` end) AS `ram_size`,`svc_disk_offering`.`name` AS `service_offering_name`,`disk_offering`.`name` AS `disk_offering_name`,`storage_pool`.`id` AS `pool_id`,`storage_pool`.`uuid` AS `pool_uuid`,`storage_pool`.`pool_type` AS `pool_type`,`volumes`.`id` AS `volume_id`,`volumes`.`uuid` AS `volume_uuid`,`volumes`.`device_id` AS `volume_device_id`,`volumes`.`volume_type` AS `volume_type`,`security_group`.`id` AS `security_group_id`,`security_group`.`uuid` AS `security_group_uuid`,`security_group`.`name` AS `security_group_name`,`security_group`.`description` AS `security_group_description`,`nics`.`id` AS `nic_id`,`nics`.`uuid` AS `nic_uuid`,`nics`.`network_id` AS `network_id`,`nics`.`ip4_address` AS `ip_address`,`nics`.`ip6_address` AS `ip6_address`,`nics`.`ip6_gateway` AS `ip6_gateway`,`nics`.`ip6_cidr` AS `ip6_cidr`,`nics`.`default_nic` AS `is_default_nic`,`nics`.`gateway` AS `gateway`,`nics`.`netmask` AS `netmask`,`nics`.`mac_address` AS `mac_address`,`nics`.`broadcast_uri` AS `broadcast_uri`,`nics`.`isolation_uri` AS `isolation_uri`,`vpc`.`id` AS `vpc_id`,`vpc`.`uuid` AS `vpc_uuid`,`networks`.`uuid` AS `network_uuid`,`networks`.`name` AS `network_name`,`networks`.`traffic_type` AS `traffic_type`,`networks`.`guest_type` AS `guest_type`,`user_ip_address`.`id` AS `public_ip_id`,`user_ip_address`.`uuid` AS `public_ip_uuid`,`user_ip_address`.`public_ip_address` AS `public_ip_address`,`ssh_keypairs`.`keypair_name` AS `keypair_name`,`resource_tags`.`id` AS `tag_id`,`resource_tags`.`uuid` AS `tag_uuid`,`resource_tags`.`key` AS `tag_key`,`resource_tags`.`value` AS `tag_value`,`resource_tags`.`domain_id` AS `tag_domain_id`,`resource_tags`.`account_id` AS `tag_account_id`,`resource_tags`.`resource_id` AS `tag_resource_id`,`resource_tags`.`resource_uuid` AS `tag_resource_uuid`,`resource_tags`.`resource_type` AS `tag_resource_type`,`resource_tags`.`customer` AS `tag_customer`,`async_job`.`id` AS `job_id`,`async_job`.`uuid` AS `job_uuid`,`async_job`.`job_status` AS `job_status`,`async_job`.`account_id` AS `job_account_id`,`affinity_group`.`id` AS `affinity_group_id`,`affinity_group`.`uuid` AS `affinity_group_uuid`,`affinity_group`.`name` AS `affinity_group_name`,`affinity_group`.`description` AS `affinity_group_description`,`vm_instance`.`dynamically_scalable` AS `dynamically_scalable`,`all_details`.`name` AS `detail_name`,`all_details`.`value` AS `detail_value` from (((((((((((((((((((((((((((((((((`user_vm` join `vm_instance` on(((`vm_instance`.`id` = `user_vm`.`id`) and isnull(`vm_instance`.`removed`)))) join `account` on((`vm_instance`.`account_id` = `account`.`id`))) join `domain` on((`vm_instance`.`domain_id` = `domain`.`id`))) left join `guest_os` on((`vm_instance`.`guest_os_id` = `guest_os`.`id`))) left join `host_pod_ref` on((`vm_instance`.`pod_id` = `host_pod_ref`.`id`))) left join `projects` on((`projects`.`project_account_id` = `account`.`id`))) left join `instance_group_vm_map` on((`vm_instance`.`id` = `instance_group_vm_map`.`instance_id`))) left join `instance_group` on((`instance_group_vm_map`.`group_id` = `instance_group`.`id`))) left join `data_center` on((`vm_instance`.`data_center_id` = `data_center`.`id`))) left join `host` on((`vm_instance`.`host_id` = `host`.`id`))) left join `vm_template` on((`vm_instance`.`vm_template_id` = `vm_template`.`id`))) left join `vm_template` `iso` on((`iso`.`id` = `user_vm`.`iso_id`))) left join `service_offering` on((`vm_instance`.`service_offering_id` = `service_offering`.`id`))) left join `disk_offering` `svc_disk_offering` on((`vm_instance`.`service_offering_id` = `svc_disk_offering`.`id`))) left join `disk_offering` on((`vm_instance`.`disk_offering_id` = `disk_offering`.`id`))) left join `volumes` on((`vm_instance`.`id` = `volumes`.`instance_id`))) left join `storage_pool` on((`volumes`.`pool_id` = `storage_pool`.`id`))) left join `security_group_vm_map` on((`vm_instance`.`id` = `security_group_vm_map`.`instance_id`))) left join `security_group` on((`security_group_vm_map`.`security_group_id` = `security_group`.`id`))) left join `nics` on(((`vm_instance`.`id` = `nics`.`instance_id`) and isnull(`nics`.`removed`)))) left join `networks` on((`nics`.`network_id` = `networks`.`id`))) left join `vpc` on(((`networks`.`vpc_id` = `vpc`.`id`) and isnull(`vpc`.`removed`)))) left join `user_ip_address` on((`user_ip_address`.`vm_id` = `vm_instance`.`id`))) left join `user_vm_details` `ssh_details` on(((`ssh_details`.`vm_id` = `vm_instance`.`id`) and (`ssh_details`.`name` = 'SSH.PublicKey')))) left join `ssh_keypairs` on((`ssh_keypairs`.`public_key` = `ssh_details`.`value`))) left join `resource_tags` on(((`resource_tags`.`resource_id` = `vm_instance`.`id`) and (`resource_tags`.`resource_type` = 'UserVm')))) left join `async_job` on(((`async_job`.`instance_id` = `vm_instance`.`id`) and (`async_job`.`instance_type` = 'VirtualMachine') and (`async_job`.`job_status` = 0)))) left join `affinity_group_vm_map` on((`vm_instance`.`id` = `affinity_group_vm_map`.`instance_id`))) left join `affinity_group` on((`affinity_group_vm_map`.`affinity_group_id` = `affinity_group`.`id`))) left join `user_vm_details` `all_details` on((`all_details`.`vm_id` = `vm_instance`.`id`))) left join `user_vm_details` `custom_cpu` on(((`custom_cpu`.`vm_id` = `vm_instance`.`id`) and (`custom_cpu`.`name` = 'CpuNumber')))) left join `user_vm_details` `custom_speed` on(((`custom_speed`.`vm_id` = `vm_instance`.`id`) and (`custom_speed`.`name` = 'CpuSpeed')))) left join `user_vm_details` `custom_ram_size` on(((`custom_ram_size`.`vm_id` = `vm_instance`.`id`) and (`custom_ram_size`.`name` = 'memory')))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `volume_view`
--

/*!50001 DROP TABLE IF EXISTS `volume_view`*/;
/*!50001 DROP VIEW IF EXISTS `volume_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `volume_view` AS select `volumes`.`id` AS `id`,`volumes`.`uuid` AS `uuid`,`volumes`.`name` AS `name`,`volumes`.`device_id` AS `device_id`,`volumes`.`volume_type` AS `volume_type`,`volumes`.`size` AS `size`,`volumes`.`min_iops` AS `min_iops`,`volumes`.`max_iops` AS `max_iops`,`volumes`.`created` AS `created`,`volumes`.`state` AS `state`,`volumes`.`attached` AS `attached`,`volumes`.`removed` AS `removed`,`volumes`.`pod_id` AS `pod_id`,`volumes`.`display_volume` AS `display_volume`,`volumes`.`format` AS `format`,`volumes`.`path` AS `path`,`volumes`.`chain_info` AS `chain_info`,`account`.`id` AS `account_id`,`account`.`uuid` AS `account_uuid`,`account`.`account_name` AS `account_name`,`account`.`type` AS `account_type`,`domain`.`id` AS `domain_id`,`domain`.`uuid` AS `domain_uuid`,`domain`.`name` AS `domain_name`,`domain`.`path` AS `domain_path`,`projects`.`id` AS `project_id`,`projects`.`uuid` AS `project_uuid`,`projects`.`name` AS `project_name`,`data_center`.`id` AS `data_center_id`,`data_center`.`uuid` AS `data_center_uuid`,`data_center`.`name` AS `data_center_name`,`data_center`.`networktype` AS `data_center_type`,`vm_instance`.`id` AS `vm_id`,`vm_instance`.`uuid` AS `vm_uuid`,`vm_instance`.`name` AS `vm_name`,`vm_instance`.`state` AS `vm_state`,`vm_instance`.`vm_type` AS `vm_type`,`user_vm`.`display_name` AS `vm_display_name`,`volume_store_ref`.`size` AS `volume_store_size`,`volume_store_ref`.`download_pct` AS `download_pct`,`volume_store_ref`.`download_state` AS `download_state`,`volume_store_ref`.`error_str` AS `error_str`,`volume_store_ref`.`created` AS `created_on_store`,`disk_offering`.`id` AS `disk_offering_id`,`disk_offering`.`uuid` AS `disk_offering_uuid`,`disk_offering`.`name` AS `disk_offering_name`,`disk_offering`.`display_text` AS `disk_offering_display_text`,`disk_offering`.`use_local_storage` AS `use_local_storage`,`disk_offering`.`system_use` AS `system_use`,`disk_offering`.`bytes_read_rate` AS `bytes_read_rate`,`disk_offering`.`bytes_write_rate` AS `bytes_write_rate`,`disk_offering`.`iops_read_rate` AS `iops_read_rate`,`disk_offering`.`iops_write_rate` AS `iops_write_rate`,`disk_offering`.`cache_mode` AS `cache_mode`,`storage_pool`.`id` AS `pool_id`,`storage_pool`.`uuid` AS `pool_uuid`,`storage_pool`.`name` AS `pool_name`,`cluster`.`hypervisor_type` AS `hypervisor_type`,`vm_template`.`id` AS `template_id`,`vm_template`.`uuid` AS `template_uuid`,`vm_template`.`extractable` AS `extractable`,`vm_template`.`type` AS `template_type`,`vm_template`.`name` AS `template_name`,`vm_template`.`display_text` AS `template_display_text`,`iso`.`id` AS `iso_id`,`iso`.`uuid` AS `iso_uuid`,`iso`.`name` AS `iso_name`,`iso`.`display_text` AS `iso_display_text`,`resource_tags`.`id` AS `tag_id`,`resource_tags`.`uuid` AS `tag_uuid`,`resource_tags`.`key` AS `tag_key`,`resource_tags`.`value` AS `tag_value`,`resource_tags`.`domain_id` AS `tag_domain_id`,`resource_tags`.`account_id` AS `tag_account_id`,`resource_tags`.`resource_id` AS `tag_resource_id`,`resource_tags`.`resource_uuid` AS `tag_resource_uuid`,`resource_tags`.`resource_type` AS `tag_resource_type`,`resource_tags`.`customer` AS `tag_customer`,`async_job`.`id` AS `job_id`,`async_job`.`uuid` AS `job_uuid`,`async_job`.`job_status` AS `job_status`,`async_job`.`account_id` AS `job_account_id` from ((((((((((((((`volumes` join `account` on((`volumes`.`account_id` = `account`.`id`))) join `domain` on((`volumes`.`domain_id` = `domain`.`id`))) left join `projects` on((`projects`.`project_account_id` = `account`.`id`))) left join `data_center` on((`volumes`.`data_center_id` = `data_center`.`id`))) left join `vm_instance` on((`volumes`.`instance_id` = `vm_instance`.`id`))) left join `user_vm` on((`user_vm`.`id` = `vm_instance`.`id`))) left join `volume_store_ref` on((`volumes`.`id` = `volume_store_ref`.`volume_id`))) left join `disk_offering` on((`volumes`.`disk_offering_id` = `disk_offering`.`id`))) left join `storage_pool` on((`volumes`.`pool_id` = `storage_pool`.`id`))) left join `cluster` on((`storage_pool`.`cluster_id` = `cluster`.`id`))) left join `vm_template` on((`volumes`.`template_id` = `vm_template`.`id`))) left join `vm_template` `iso` on((`iso`.`id` = `volumes`.`iso_id`))) left join `resource_tags` on(((`resource_tags`.`resource_id` = `volumes`.`id`) and (`resource_tags`.`resource_type` = 'Volume')))) left join `async_job` on(((`async_job`.`instance_id` = `volumes`.`id`) and (`async_job`.`instance_type` = 'Volume') and (`async_job`.`job_status` = 0)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-06-26  3:28:28
