-- MariaDB dump 10.19  Distrib 10.5.13-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: bpms64kie
-- ------------------------------------------------------
-- Server version	10.5.13-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `bpms64kie`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `bpms64kie` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `bpms64kie`;

--
-- Table structure for table `Attachment`
--

DROP TABLE IF EXISTS `Attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Attachment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `accessType` int(11) DEFAULT NULL,
  `attachedAt` datetime DEFAULT NULL,
  `attachmentContentId` bigint(20) NOT NULL,
  `contentType` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `attachment_size` int(11) DEFAULT NULL,
  `attachedBy_id` varchar(255) DEFAULT NULL,
  `TaskData_Attachments_Id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_7ndpfa311i50bq7hy18q05va3` (`attachedBy_id`),
  KEY `FK_hqupx569krp0f0sgu9kh87513` (`TaskData_Attachments_Id`),
  KEY `IDX_Attachment_Id` (`attachedBy_id`),
  KEY `IDX_Attachment_DataId` (`TaskData_Attachments_Id`),
  CONSTRAINT `FK_7ndpfa311i50bq7hy18q05va3` FOREIGN KEY (`attachedBy_id`) REFERENCES `OrganizationalEntity` (`id`),
  CONSTRAINT `FK_hqupx569krp0f0sgu9kh87513` FOREIGN KEY (`TaskData_Attachments_Id`) REFERENCES `Task` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Attachment`
--

LOCK TABLES `Attachment` WRITE;
/*!40000 ALTER TABLE `Attachment` DISABLE KEYS */;
/*!40000 ALTER TABLE `Attachment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AuditTaskImpl`
--

DROP TABLE IF EXISTS `AuditTaskImpl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AuditTaskImpl` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `activationTime` datetime DEFAULT NULL,
  `actualOwner` varchar(255) DEFAULT NULL,
  `createdBy` varchar(255) DEFAULT NULL,
  `createdOn` datetime DEFAULT NULL,
  `deploymentId` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `dueDate` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `parentId` bigint(20) NOT NULL,
  `priority` int(11) NOT NULL,
  `processId` varchar(255) DEFAULT NULL,
  `processInstanceId` bigint(20) NOT NULL,
  `processSessionId` bigint(20) NOT NULL,
  `status` varchar(255) DEFAULT NULL,
  `taskId` bigint(20) DEFAULT NULL,
  `workItemId` bigint(20) DEFAULT NULL,
  `lastModificationDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AuditTaskImpl`
--

LOCK TABLES `AuditTaskImpl` WRITE;
/*!40000 ALTER TABLE `AuditTaskImpl` DISABLE KEYS */;
INSERT INTO `AuditTaskImpl` VALUES (1,'2022-05-09 14:29:37','','','2022-05-09 14:29:37','example:case03200412:1.0','',NULL,'do something',-1,0,'case03200412.timertest',4,10,'Ready',1,4,'2022-05-09 14:29:37'),(2,'2022-05-09 14:53:50','','','2022-05-09 14:53:50','example:case03200412:1.0','',NULL,'do something',-1,0,'case03200412.timertest',6,15,'Ready',2,5,NULL),(3,'2022-05-09 14:54:05','','','2022-05-09 14:54:05','example:case03200412:1.0','',NULL,'do something',-1,0,'case03200412.timertest',7,16,'Ready',3,6,NULL);
/*!40000 ALTER TABLE `AuditTaskImpl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BAMTaskSummary`
--

DROP TABLE IF EXISTS `BAMTaskSummary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BAMTaskSummary` (
  `pk` bigint(20) NOT NULL AUTO_INCREMENT,
  `createdDate` datetime DEFAULT NULL,
  `duration` bigint(20) DEFAULT NULL,
  `endDate` datetime DEFAULT NULL,
  `processInstanceId` bigint(20) NOT NULL,
  `startDate` datetime DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `taskId` bigint(20) NOT NULL,
  `taskName` varchar(255) DEFAULT NULL,
  `userId` varchar(255) DEFAULT NULL,
  `OPTLOCK` int(11) DEFAULT NULL,
  PRIMARY KEY (`pk`),
  KEY `IDX_BAMTaskSumm_createdDate` (`createdDate`),
  KEY `IDX_BAMTaskSumm_duration` (`duration`),
  KEY `IDX_BAMTaskSumm_endDate` (`endDate`),
  KEY `IDX_BAMTaskSumm_pInstId` (`processInstanceId`),
  KEY `IDX_BAMTaskSumm_startDate` (`startDate`),
  KEY `IDX_BAMTaskSumm_status` (`status`),
  KEY `IDX_BAMTaskSumm_taskId` (`taskId`),
  KEY `IDX_BAMTaskSumm_taskName` (`taskName`),
  KEY `IDX_BAMTaskSumm_userId` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BAMTaskSummary`
--

LOCK TABLES `BAMTaskSummary` WRITE;
/*!40000 ALTER TABLE `BAMTaskSummary` DISABLE KEYS */;
INSERT INTO `BAMTaskSummary` VALUES (1,'2022-05-09 14:29:37',NULL,NULL,4,NULL,'Ready',1,'do something','',0),(2,'2022-05-09 14:53:50',NULL,NULL,6,NULL,'Ready',2,'do something','',0),(3,'2022-05-09 14:54:05',NULL,NULL,7,NULL,'Ready',3,'do something','',0);
/*!40000 ALTER TABLE `BAMTaskSummary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BooleanExpression`
--

DROP TABLE IF EXISTS `BooleanExpression`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BooleanExpression` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `expression` longtext DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `Escalation_Constraints_Id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_394nf2qoc0k9ok6omgd6jtpso` (`Escalation_Constraints_Id`),
  KEY `IDX_BoolExpr_Id` (`Escalation_Constraints_Id`),
  CONSTRAINT `FK_394nf2qoc0k9ok6omgd6jtpso` FOREIGN KEY (`Escalation_Constraints_Id`) REFERENCES `Escalation` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BooleanExpression`
--

LOCK TABLES `BooleanExpression` WRITE;
/*!40000 ALTER TABLE `BooleanExpression` DISABLE KEYS */;
/*!40000 ALTER TABLE `BooleanExpression` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CaseFileDataLog`
--

DROP TABLE IF EXISTS `CaseFileDataLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CaseFileDataLog` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `caseDefId` varchar(255) DEFAULT NULL,
  `caseId` varchar(255) DEFAULT NULL,
  `itemName` varchar(255) DEFAULT NULL,
  `itemType` varchar(255) DEFAULT NULL,
  `itemValue` varchar(255) DEFAULT NULL,
  `lastModified` datetime DEFAULT NULL,
  `lastModifiedBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CaseFileDataLog`
--

LOCK TABLES `CaseFileDataLog` WRITE;
/*!40000 ALTER TABLE `CaseFileDataLog` DISABLE KEYS */;
/*!40000 ALTER TABLE `CaseFileDataLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CaseIdInfo`
--

DROP TABLE IF EXISTS `CaseIdInfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CaseIdInfo` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `caseIdPrefix` varchar(255) DEFAULT NULL,
  `currentValue` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_CaseIdInfo_1` (`caseIdPrefix`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CaseIdInfo`
--

LOCK TABLES `CaseIdInfo` WRITE;
/*!40000 ALTER TABLE `CaseIdInfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `CaseIdInfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CaseRoleAssignmentLog`
--

DROP TABLE IF EXISTS `CaseRoleAssignmentLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CaseRoleAssignmentLog` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `caseId` varchar(255) DEFAULT NULL,
  `entityId` varchar(255) DEFAULT NULL,
  `processInstanceId` bigint(20) NOT NULL,
  `roleName` varchar(255) DEFAULT NULL,
  `type` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CaseRoleAssignmentLog`
--

LOCK TABLES `CaseRoleAssignmentLog` WRITE;
/*!40000 ALTER TABLE `CaseRoleAssignmentLog` DISABLE KEYS */;
/*!40000 ALTER TABLE `CaseRoleAssignmentLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Content`
--

DROP TABLE IF EXISTS `Content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Content` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `content` longblob DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Content`
--

LOCK TABLES `Content` WRITE;
/*!40000 ALTER TABLE `Content` DISABLE KEYS */;
INSERT INTO `Content` VALUES (1,'¨Ì\0wÔ\n4\0J¶\0Horg.drools.core.marshalling.impl.SerializablePlaceholderResolverStrategy\ZX¨Ì\0sr\0java.util.ArrayListxÅ“ô«aù\0I\0sizexp\0\0\0w\0\0\0t\0truet\0do somethingt\0adminxR<\n\n	Skippable\0\Z\0\0\0\0\n\nNodeName\0\Z\0\0\0\n\nGroupId\0\Z\0\0\0'),(2,'¨Ì\0wÔ\n\0J¶\0Horg.drools.core.marshalling.impl.SerializablePlaceholderResolverStrategy\ZX¨Ì\0sr\0java.util.ArrayListxÅ“ô«aù\0I\0sizexp\0\0\0w\0\0\0t\0truet\0do somethingt\0adminxR<\n\n	Skippable\0\Z\0\0\0\0\n\nNodeName\0\Z\0\0\0\n\nGroupId\0\Z\0\0\0'),(3,'¨Ì\0wÔ\n\0J¶\0Horg.drools.core.marshalling.impl.SerializablePlaceholderResolverStrategy\ZX¨Ì\0sr\0java.util.ArrayListxÅ“ô«aù\0I\0sizexp\0\0\0w\0\0\0t\0truet\0do somethingt\0adminxR<\n\n	Skippable\0\Z\0\0\0\0\n\nNodeName\0\Z\0\0\0\n\nGroupId\0\Z\0\0\0');
/*!40000 ALTER TABLE `Content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ContextMappingInfo`
--

DROP TABLE IF EXISTS `ContextMappingInfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ContextMappingInfo` (
  `mappingId` bigint(20) NOT NULL AUTO_INCREMENT,
  `CONTEXT_ID` varchar(255) NOT NULL,
  `KSESSION_ID` bigint(20) NOT NULL,
  `OWNER_ID` varchar(255) DEFAULT NULL,
  `OPTLOCK` int(11) DEFAULT NULL,
  PRIMARY KEY (`mappingId`),
  KEY `IDX_CMI_Context` (`CONTEXT_ID`),
  KEY `IDX_CMI_KSession` (`KSESSION_ID`),
  KEY `IDX_CMI_Owner` (`OWNER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ContextMappingInfo`
--

LOCK TABLES `ContextMappingInfo` WRITE;
/*!40000 ALTER TABLE `ContextMappingInfo` DISABLE KEYS */;
INSERT INTO `ContextMappingInfo` VALUES (1,'1',3,'com.myspace:case02824294:1.0.0-SNAPSHOT',0),(2,'2',5,'com.myspace:case02824294:1.0.0-SNAPSHOT',0),(3,'3',6,'com.myspace:case02824294:1.0.0-SNAPSHOT',0),(4,'4',10,'example:case03200412:1.0',0),(5,'5',14,'example:case03200412:1.0',0),(6,'6',15,'example:case03200412:1.0',0),(7,'7',16,'example:case03200412:1.0',0),(8,'8',18,'example:case03200412:1.0',0);
/*!40000 ALTER TABLE `ContextMappingInfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CorrelationKeyInfo`
--

DROP TABLE IF EXISTS `CorrelationKeyInfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CorrelationKeyInfo` (
  `keyId` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `processInstanceId` bigint(20) NOT NULL,
  `OPTLOCK` int(11) DEFAULT NULL,
  PRIMARY KEY (`keyId`),
  UNIQUE KEY `IDX_CorrelationKeyInfo_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CorrelationKeyInfo`
--

LOCK TABLES `CorrelationKeyInfo` WRITE;
/*!40000 ALTER TABLE `CorrelationKeyInfo` DISABLE KEYS */;
INSERT INTO `CorrelationKeyInfo` VALUES (1,'4',4,0),(2,'8',8,0);
/*!40000 ALTER TABLE `CorrelationKeyInfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CorrelationPropertyInfo`
--

DROP TABLE IF EXISTS `CorrelationPropertyInfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CorrelationPropertyInfo` (
  `propertyId` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `OPTLOCK` int(11) DEFAULT NULL,
  `correlationKey_keyId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`propertyId`),
  KEY `FK_hrmx1m882cejwj9c04ixh50i4` (`correlationKey_keyId`),
  KEY `IDX_CorrPropInfo_Id` (`correlationKey_keyId`),
  CONSTRAINT `FK_hrmx1m882cejwj9c04ixh50i4` FOREIGN KEY (`correlationKey_keyId`) REFERENCES `CorrelationKeyInfo` (`keyId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CorrelationPropertyInfo`
--

LOCK TABLES `CorrelationPropertyInfo` WRITE;
/*!40000 ALTER TABLE `CorrelationPropertyInfo` DISABLE KEYS */;
INSERT INTO `CorrelationPropertyInfo` VALUES (1,NULL,'4',0,1),(2,NULL,'8',0,2);
/*!40000 ALTER TABLE `CorrelationPropertyInfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Deadline`
--

DROP TABLE IF EXISTS `Deadline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Deadline` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deadline_date` datetime DEFAULT NULL,
  `escalated` smallint(6) DEFAULT NULL,
  `Deadlines_StartDeadLine_Id` bigint(20) DEFAULT NULL,
  `Deadlines_EndDeadLine_Id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_68w742sge00vco2cq3jhbvmgx` (`Deadlines_StartDeadLine_Id`),
  KEY `FK_euoohoelbqvv94d8a8rcg8s5n` (`Deadlines_EndDeadLine_Id`),
  KEY `IDX_Deadline_StartId` (`Deadlines_StartDeadLine_Id`),
  KEY `IDX_Deadline_EndId` (`Deadlines_EndDeadLine_Id`),
  CONSTRAINT `FK_68w742sge00vco2cq3jhbvmgx` FOREIGN KEY (`Deadlines_StartDeadLine_Id`) REFERENCES `Task` (`id`),
  CONSTRAINT `FK_euoohoelbqvv94d8a8rcg8s5n` FOREIGN KEY (`Deadlines_EndDeadLine_Id`) REFERENCES `Task` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Deadline`
--

LOCK TABLES `Deadline` WRITE;
/*!40000 ALTER TABLE `Deadline` DISABLE KEYS */;
/*!40000 ALTER TABLE `Deadline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Delegation_delegates`
--

DROP TABLE IF EXISTS `Delegation_delegates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Delegation_delegates` (
  `task_id` bigint(20) NOT NULL,
  `entity_id` varchar(255) NOT NULL,
  KEY `FK_gn7ula51sk55wj1o1m57guqxb` (`entity_id`),
  KEY `FK_fajq6kossbsqwr3opkrctxei3` (`task_id`),
  KEY `IDX_Delegation_EntityId` (`entity_id`),
  KEY `IDX_Delegation_TaskId` (`task_id`),
  CONSTRAINT `FK_fajq6kossbsqwr3opkrctxei3` FOREIGN KEY (`task_id`) REFERENCES `Task` (`id`),
  CONSTRAINT `FK_gn7ula51sk55wj1o1m57guqxb` FOREIGN KEY (`entity_id`) REFERENCES `OrganizationalEntity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Delegation_delegates`
--

LOCK TABLES `Delegation_delegates` WRITE;
/*!40000 ALTER TABLE `Delegation_delegates` DISABLE KEYS */;
/*!40000 ALTER TABLE `Delegation_delegates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DeploymentStore`
--

DROP TABLE IF EXISTS `DeploymentStore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DeploymentStore` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `attributes` varchar(255) DEFAULT NULL,
  `DEPLOYMENT_ID` varchar(255) DEFAULT NULL,
  `deploymentUnit` longtext DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_85rgskt09thd8mkkfl3tb0y81` (`DEPLOYMENT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DeploymentStore`
--

LOCK TABLES `DeploymentStore` WRITE;
/*!40000 ALTER TABLE `DeploymentStore` DISABLE KEYS */;
INSERT INTO `DeploymentStore` VALUES (1,'sync=false','org.guvnor:guvnor-asset-mgmt-project:6.5.0.Final-redhat-25','<org.jbpm.kie.services.impl.KModuleDeploymentUnit>\n  <artifactId>guvnor-asset-mgmt-project</artifactId>\n  <groupId>org.guvnor</groupId>\n  <version>6.5.0.Final-redhat-25</version>\n  <strategy>SINGLETON</strategy>\n  <mergeMode>MERGE_COLLECTIONS</mergeMode>\n  <deploymentDescriptor class=\"org.jbpm.runtime.manager.impl.deploy.DeploymentDescriptorImpl\">\n    <persistenceUnit>org.jbpm.domain</persistenceUnit>\n    <auditPersistenceUnit>org.jbpm.domain</auditPersistenceUnit>\n    <auditMode>JPA</auditMode>\n    <persistenceMode>JPA</persistenceMode>\n    <runtimeStrategy>SINGLETON</runtimeStrategy>\n    <marshallingStrategies class=\"linked-hash-set\"/>\n    <eventListeners class=\"linked-hash-set\">\n      <org.kie.internal.runtime.conf.ObjectModel>\n        <resolver>mvel</resolver>\n        <identifier>new org.jbpm.process.instance.event.listeners.RuleAwareProcessEventLister()</identifier>\n        <parameters/>\n      </org.kie.internal.runtime.conf.ObjectModel>\n    </eventListeners>\n    <taskEventListeners class=\"linked-hash-set\"/>\n    <globals class=\"linked-hash-set\">\n      <org.kie.internal.runtime.conf.NamedObjectModel>\n        <resolver>mvel</resolver>\n        <identifier>org.slf4j.LoggerFactory.getLogger(&quot;AssetMgmt&quot;)</identifier>\n        <parameters/>\n        <name>logger</name>\n      </org.kie.internal.runtime.conf.NamedObjectModel>\n    </globals>\n    <workItemHandlers class=\"linked-hash-set\">\n      <org.kie.internal.runtime.conf.NamedObjectModel>\n        <resolver>mvel</resolver>\n        <identifier>new org.jbpm.process.workitem.bpmn2.ServiceTaskHandler(ksession, classLoader)</identifier>\n        <parameters/>\n        <name>Service Task</name>\n      </org.kie.internal.runtime.conf.NamedObjectModel>\n      <org.kie.internal.runtime.conf.NamedObjectModel>\n        <resolver>mvel</resolver>\n        <identifier>new org.jbpm.process.instance.impl.demo.SystemOutWorkItemHandler()</identifier>\n        <parameters/>\n        <name>Log</name>\n      </org.kie.internal.runtime.conf.NamedObjectModel>\n      <org.kie.internal.runtime.conf.NamedObjectModel>\n        <resolver>mvel</resolver>\n        <identifier>new org.jbpm.process.workitem.webservice.WebServiceWorkItemHandler(ksession, classLoader)</identifier>\n        <parameters/>\n        <name>WebService</name>\n      </org.kie.internal.runtime.conf.NamedObjectModel>\n      <org.kie.internal.runtime.conf.NamedObjectModel>\n        <resolver>mvel</resolver>\n        <identifier>new org.jbpm.process.workitem.rest.RESTWorkItemHandler(&quot;&quot;, &quot;&quot;)</identifier>\n        <parameters/>\n        <name>Rest</name>\n      </org.kie.internal.runtime.conf.NamedObjectModel>\n      <org.kie.internal.runtime.conf.NamedObjectModel>\n        <resolver>mvel</resolver>\n        <identifier>new org.guvnor.asset.management.backend.handlers.AssetMgmtStartWorkItemHandler()</identifier>\n        <parameters/>\n        <name>AssetMgmtStart</name>\n      </org.kie.internal.runtime.conf.NamedObjectModel>\n      <org.kie.internal.runtime.conf.NamedObjectModel>\n        <resolver>mvel</resolver>\n        <identifier>new org.guvnor.asset.management.backend.handlers.AssetMgmtEndWorkItemHandler()</identifier>\n        <parameters/>\n        <name>AssetMgmtEnd</name>\n      </org.kie.internal.runtime.conf.NamedObjectModel>\n    </workItemHandlers>\n    <environmentEntries class=\"linked-hash-set\"/>\n    <configuration class=\"linked-hash-set\"/>\n    <requiredRoles class=\"linked-hash-set\">\n      <string>view:kiemgmt</string>\n    </requiredRoles>\n    <classes/>\n    <limitSerializationClasses>true</limitSerializationClasses>\n    <mappedRoles>\n      <entry>\n        <string>all</string>\n        <linked-hash-set>\n          <string>kiemgmt</string>\n        </linked-hash-set>\n      </entry>\n      <entry>\n        <string>view</string>\n        <linked-hash-set>\n          <string>kiemgmt</string>\n        </linked-hash-set>\n      </entry>\n      <entry>\n        <string>execute</string>\n        <linked-hash-set/>\n      </entry>\n    </mappedRoles>\n  </deploymentDescriptor>\n  <deployed>false</deployed>\n  <strategyUnset>false</strategyUnset>\n  <active>true</active>\n  <attributes>\n    <entry>\n      <string>sync</string>\n      <string>false</string>\n    </entry>\n  </attributes>\n</org.jbpm.kie.services.impl.KModuleDeploymentUnit>',1,'2021-09-24 08:47:15'),(2,'sync=false','org.guvnor:guvnor-asset-mgmt-project:6.5.0.Final-redhat-16','<org.jbpm.kie.services.impl.KModuleDeploymentUnit>\n  <artifactId>guvnor-asset-mgmt-project</artifactId>\n  <groupId>org.guvnor</groupId>\n  <version>6.5.0.Final-redhat-16</version>\n  <strategy>SINGLETON</strategy>\n  <mergeMode>MERGE_COLLECTIONS</mergeMode>\n  <deploymentDescriptor class=\"org.jbpm.runtime.manager.impl.deploy.DeploymentDescriptorImpl\">\n    <persistenceUnit>org.jbpm.domain</persistenceUnit>\n    <auditPersistenceUnit>org.jbpm.domain</auditPersistenceUnit>\n    <auditMode>JPA</auditMode>\n    <persistenceMode>JPA</persistenceMode>\n    <runtimeStrategy>SINGLETON</runtimeStrategy>\n    <marshallingStrategies class=\"linked-hash-set\"/>\n    <eventListeners class=\"linked-hash-set\">\n      <org.kie.internal.runtime.conf.ObjectModel>\n        <resolver>mvel</resolver>\n        <identifier>new org.jbpm.process.instance.event.listeners.RuleAwareProcessEventLister()</identifier>\n        <parameters/>\n      </org.kie.internal.runtime.conf.ObjectModel>\n    </eventListeners>\n    <taskEventListeners class=\"linked-hash-set\"/>\n    <globals class=\"linked-hash-set\">\n      <org.kie.internal.runtime.conf.NamedObjectModel>\n        <resolver>mvel</resolver>\n        <identifier>org.slf4j.LoggerFactory.getLogger(&quot;AssetMgmt&quot;)</identifier>\n        <parameters/>\n        <name>logger</name>\n      </org.kie.internal.runtime.conf.NamedObjectModel>\n    </globals>\n    <workItemHandlers class=\"linked-hash-set\">\n      <org.kie.internal.runtime.conf.NamedObjectModel>\n        <resolver>mvel</resolver>\n        <identifier>new org.jbpm.process.workitem.bpmn2.ServiceTaskHandler(ksession, classLoader)</identifier>\n        <parameters/>\n        <name>Service Task</name>\n      </org.kie.internal.runtime.conf.NamedObjectModel>\n      <org.kie.internal.runtime.conf.NamedObjectModel>\n        <resolver>mvel</resolver>\n        <identifier>new org.jbpm.process.instance.impl.demo.SystemOutWorkItemHandler()</identifier>\n        <parameters/>\n        <name>Log</name>\n      </org.kie.internal.runtime.conf.NamedObjectModel>\n      <org.kie.internal.runtime.conf.NamedObjectModel>\n        <resolver>mvel</resolver>\n        <identifier>new org.jbpm.process.workitem.webservice.WebServiceWorkItemHandler(ksession, classLoader)</identifier>\n        <parameters/>\n        <name>WebService</name>\n      </org.kie.internal.runtime.conf.NamedObjectModel>\n      <org.kie.internal.runtime.conf.NamedObjectModel>\n        <resolver>mvel</resolver>\n        <identifier>new org.jbpm.process.workitem.rest.RESTWorkItemHandler(&quot;&quot;, &quot;&quot;)</identifier>\n        <parameters/>\n        <name>Rest</name>\n      </org.kie.internal.runtime.conf.NamedObjectModel>\n      <org.kie.internal.runtime.conf.NamedObjectModel>\n        <resolver>mvel</resolver>\n        <identifier>new org.guvnor.asset.management.backend.handlers.AssetMgmtStartWorkItemHandler()</identifier>\n        <parameters/>\n        <name>AssetMgmtStart</name>\n      </org.kie.internal.runtime.conf.NamedObjectModel>\n      <org.kie.internal.runtime.conf.NamedObjectModel>\n        <resolver>mvel</resolver>\n        <identifier>new org.guvnor.asset.management.backend.handlers.AssetMgmtEndWorkItemHandler()</identifier>\n        <parameters/>\n        <name>AssetMgmtEnd</name>\n      </org.kie.internal.runtime.conf.NamedObjectModel>\n    </workItemHandlers>\n    <environmentEntries class=\"linked-hash-set\"/>\n    <configuration class=\"linked-hash-set\"/>\n    <requiredRoles class=\"linked-hash-set\">\n      <string>view:kiemgmt</string>\n    </requiredRoles>\n    <classes/>\n    <limitSerializationClasses>true</limitSerializationClasses>\n    <mappedRoles>\n      <entry>\n        <string>all</string>\n        <linked-hash-set>\n          <string>kiemgmt</string>\n        </linked-hash-set>\n      </entry>\n      <entry>\n        <string>view</string>\n        <linked-hash-set>\n          <string>kiemgmt</string>\n        </linked-hash-set>\n      </entry>\n      <entry>\n        <string>execute</string>\n        <linked-hash-set/>\n      </entry>\n    </mappedRoles>\n  </deploymentDescriptor>\n  <deployed>false</deployed>\n  <strategyUnset>false</strategyUnset>\n  <active>true</active>\n  <attributes>\n    <entry>\n      <string>sync</string>\n      <string>false</string>\n    </entry>\n  </attributes>\n</org.jbpm.kie.services.impl.KModuleDeploymentUnit>',1,'2022-01-10 11:23:06');
/*!40000 ALTER TABLE `DeploymentStore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ErrorInfo`
--

DROP TABLE IF EXISTS `ErrorInfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ErrorInfo` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `message` varchar(255) DEFAULT NULL,
  `stacktrace` varchar(5000) DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `REQUEST_ID` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_cms0met37ggfw5p5gci3otaq0` (`REQUEST_ID`),
  KEY `IDX_ErrorInfo_Id` (`REQUEST_ID`),
  CONSTRAINT `FK_cms0met37ggfw5p5gci3otaq0` FOREIGN KEY (`REQUEST_ID`) REFERENCES `RequestInfo` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ErrorInfo`
--

LOCK TABLES `ErrorInfo` WRITE;
/*!40000 ALTER TABLE `ErrorInfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `ErrorInfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Escalation`
--

DROP TABLE IF EXISTS `Escalation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Escalation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `Deadline_Escalation_Id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ay2gd4fvl9yaapviyxudwuvfg` (`Deadline_Escalation_Id`),
  KEY `IDX_Escalation_Id` (`Deadline_Escalation_Id`),
  CONSTRAINT `FK_ay2gd4fvl9yaapviyxudwuvfg` FOREIGN KEY (`Deadline_Escalation_Id`) REFERENCES `Deadline` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Escalation`
--

LOCK TABLES `Escalation` WRITE;
/*!40000 ALTER TABLE `Escalation` DISABLE KEYS */;
/*!40000 ALTER TABLE `Escalation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EventTypes`
--

DROP TABLE IF EXISTS `EventTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EventTypes` (
  `InstanceId` bigint(20) NOT NULL,
  `element` varchar(255) DEFAULT NULL,
  KEY `FK_nrecj4617iwxlc65ij6m7lsl1` (`InstanceId`),
  KEY `IDX_EventTypes_Id` (`InstanceId`),
  KEY `IDX_EventTypes_element` (`element`),
  CONSTRAINT `FK_nrecj4617iwxlc65ij6m7lsl1` FOREIGN KEY (`InstanceId`) REFERENCES `ProcessInstanceInfo` (`InstanceId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EventTypes`
--

LOCK TABLES `EventTypes` WRITE;
/*!40000 ALTER TABLE `EventTypes` DISABLE KEYS */;
INSERT INTO `EventTypes` VALUES (1,'Message-investigation'),(1,'Message-completeInvestigation'),(2,'Message-investigation'),(2,'Message-completeInvestigation'),(3,'Message-investigation'),(3,'Message-completeInvestigation'),(4,'timer'),(4,'slaViolation:3'),(5,'proceed'),(6,'timer'),(7,'timer'),(8,'proceed');
/*!40000 ALTER TABLE `EventTypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ExecutionErrorInfo`
--

DROP TABLE IF EXISTS `ExecutionErrorInfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ExecutionErrorInfo` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ERROR_ACK` smallint(6) DEFAULT NULL,
  `ERROR_ACK_AT` datetime DEFAULT NULL,
  `ERROR_ACK_BY` varchar(255) DEFAULT NULL,
  `ACTIVITY_ID` bigint(20) DEFAULT NULL,
  `ACTIVITY_NAME` varchar(255) DEFAULT NULL,
  `DEPLOYMENT_ID` varchar(255) DEFAULT NULL,
  `ERROR_INFO` longtext DEFAULT NULL,
  `ERROR_DATE` datetime DEFAULT NULL,
  `ERROR_ID` varchar(255) DEFAULT NULL,
  `ERROR_MSG` varchar(255) DEFAULT NULL,
  `INIT_ACTIVITY_ID` bigint(20) DEFAULT NULL,
  `JOB_ID` bigint(20) DEFAULT NULL,
  `PROCESS_ID` varchar(255) DEFAULT NULL,
  `PROCESS_INST_ID` bigint(20) DEFAULT NULL,
  `ERROR_TYPE` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_ErrorInfo_pInstId` (`PROCESS_INST_ID`),
  KEY `IDX_ErrorInfo_errorAck` (`ERROR_ACK`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ExecutionErrorInfo`
--

LOCK TABLES `ExecutionErrorInfo` WRITE;
/*!40000 ALTER TABLE `ExecutionErrorInfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `ExecutionErrorInfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `I18NText`
--

DROP TABLE IF EXISTS `I18NText`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `I18NText` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `language` varchar(255) DEFAULT NULL,
  `shortText` varchar(255) DEFAULT NULL,
  `text` longtext DEFAULT NULL,
  `Task_Subjects_Id` bigint(20) DEFAULT NULL,
  `Task_Names_Id` bigint(20) DEFAULT NULL,
  `Task_Descriptions_Id` bigint(20) DEFAULT NULL,
  `Reassignment_Documentation_Id` bigint(20) DEFAULT NULL,
  `Notification_Subjects_Id` bigint(20) DEFAULT NULL,
  `Notification_Names_Id` bigint(20) DEFAULT NULL,
  `Notification_Documentation_Id` bigint(20) DEFAULT NULL,
  `Notification_Descriptions_Id` bigint(20) DEFAULT NULL,
  `Deadline_Documentation_Id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_k16jpgrh67ti9uedf6konsu1p` (`Task_Subjects_Id`),
  KEY `FK_fd9uk6hemv2dx1ojovo7ms3vp` (`Task_Names_Id`),
  KEY `FK_4eyfp69ucrron2hr7qx4np2fp` (`Task_Descriptions_Id`),
  KEY `FK_pqarjvvnwfjpeyb87yd7m0bfi` (`Reassignment_Documentation_Id`),
  KEY `FK_o84rkh69r47ti8uv4eyj7bmo2` (`Notification_Subjects_Id`),
  KEY `FK_g1trxri8w64enudw2t1qahhk5` (`Notification_Names_Id`),
  KEY `FK_qoce92c70adem3ccb3i7lec8x` (`Notification_Documentation_Id`),
  KEY `FK_bw8vmpekejxt1ei2ge26gdsry` (`Notification_Descriptions_Id`),
  KEY `FK_21qvifarxsvuxeaw5sxwh473w` (`Deadline_Documentation_Id`),
  KEY `IDX_I18NText_SubjId` (`Task_Subjects_Id`),
  KEY `IDX_I18NText_NameId` (`Task_Names_Id`),
  KEY `IDX_I18NText_DescrId` (`Task_Descriptions_Id`),
  KEY `IDX_I18NText_ReassignId` (`Reassignment_Documentation_Id`),
  KEY `IDX_I18NText_NotSubjId` (`Notification_Subjects_Id`),
  KEY `IDX_I18NText_NotNamId` (`Notification_Names_Id`),
  KEY `IDX_I18NText_NotDocId` (`Notification_Documentation_Id`),
  KEY `IDX_I18NText_NotDescrId` (`Notification_Descriptions_Id`),
  KEY `IDX_I18NText_DeadDocId` (`Deadline_Documentation_Id`),
  CONSTRAINT `FK_21qvifarxsvuxeaw5sxwh473w` FOREIGN KEY (`Deadline_Documentation_Id`) REFERENCES `Deadline` (`id`),
  CONSTRAINT `FK_4eyfp69ucrron2hr7qx4np2fp` FOREIGN KEY (`Task_Descriptions_Id`) REFERENCES `Task` (`id`),
  CONSTRAINT `FK_bw8vmpekejxt1ei2ge26gdsry` FOREIGN KEY (`Notification_Descriptions_Id`) REFERENCES `Notification` (`id`),
  CONSTRAINT `FK_fd9uk6hemv2dx1ojovo7ms3vp` FOREIGN KEY (`Task_Names_Id`) REFERENCES `Task` (`id`),
  CONSTRAINT `FK_g1trxri8w64enudw2t1qahhk5` FOREIGN KEY (`Notification_Names_Id`) REFERENCES `Notification` (`id`),
  CONSTRAINT `FK_k16jpgrh67ti9uedf6konsu1p` FOREIGN KEY (`Task_Subjects_Id`) REFERENCES `Task` (`id`),
  CONSTRAINT `FK_o84rkh69r47ti8uv4eyj7bmo2` FOREIGN KEY (`Notification_Subjects_Id`) REFERENCES `Notification` (`id`),
  CONSTRAINT `FK_pqarjvvnwfjpeyb87yd7m0bfi` FOREIGN KEY (`Reassignment_Documentation_Id`) REFERENCES `Reassignment` (`id`),
  CONSTRAINT `FK_qoce92c70adem3ccb3i7lec8x` FOREIGN KEY (`Notification_Documentation_Id`) REFERENCES `Notification` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `I18NText`
--

LOCK TABLES `I18NText` WRITE;
/*!40000 ALTER TABLE `I18NText` DISABLE KEYS */;
INSERT INTO `I18NText` VALUES (1,'en-UK','','',NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL),(2,'en-UK','do something','do something',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(3,'en-UK','','',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(4,'en-UK','','',NULL,NULL,2,NULL,NULL,NULL,NULL,NULL,NULL),(5,'en-UK','do something','do something',NULL,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6,'en-UK','','',2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(7,'en-UK','','',NULL,NULL,3,NULL,NULL,NULL,NULL,NULL,NULL),(8,'en-UK','do something','do something',NULL,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(9,'en-UK','','',3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `I18NText` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `JBOSS_EJB_TIMER`
--

DROP TABLE IF EXISTS `JBOSS_EJB_TIMER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `JBOSS_EJB_TIMER` (
  `ID` varchar(255) NOT NULL,
  `TIMED_OBJECT_ID` varchar(255) NOT NULL,
  `INITIAL_DATE` datetime DEFAULT NULL,
  `REPEAT_INTERVAL` bigint(20) DEFAULT NULL,
  `NEXT_DATE` datetime DEFAULT NULL,
  `PREVIOUS_RUN` datetime DEFAULT NULL,
  `PRIMARY_KEY` varchar(255) DEFAULT NULL,
  `INFO` text DEFAULT NULL,
  `TIMER_STATE` varchar(32) DEFAULT NULL,
  `SCHEDULE_EXPR_SECOND` varchar(100) DEFAULT NULL,
  `SCHEDULE_EXPR_MINUTE` varchar(100) DEFAULT NULL,
  `SCHEDULE_EXPR_HOUR` varchar(100) DEFAULT NULL,
  `SCHEDULE_EXPR_DAY_OF_WEEK` varchar(100) DEFAULT NULL,
  `SCHEDULE_EXPR_DAY_OF_MONTH` varchar(100) DEFAULT NULL,
  `SCHEDULE_EXPR_MONTH` varchar(100) DEFAULT NULL,
  `SCHEDULE_EXPR_YEAR` varchar(100) DEFAULT NULL,
  `SCHEDULE_EXPR_START_DATE` varchar(100) DEFAULT NULL,
  `SCHEDULE_EXPR_END_DATE` varchar(100) DEFAULT NULL,
  `SCHEDULE_EXPR_TIMEZONE` varchar(100) DEFAULT NULL,
  `AUTO_TIMER` tinyint(1) DEFAULT NULL,
  `TIMEOUT_METHOD_NAME` varchar(100) DEFAULT NULL,
  `TIMEOUT_METHOD_DECLARING_CLASS` varchar(255) DEFAULT NULL,
  `TIMEOUT_METHOD_DESCRIPTOR` varchar(255) DEFAULT NULL,
  `CALENDAR_TIMER` tinyint(1) DEFAULT NULL,
  `PARTITION_NAME` varchar(100) NOT NULL,
  `NODE_NAME` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `JBOSS_EJB_TIMER_IDENX` (`PARTITION_NAME`,`TIMED_OBJECT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `JBOSS_EJB_TIMER`
--

LOCK TABLES `JBOSS_EJB_TIMER` WRITE;
/*!40000 ALTER TABLE `JBOSS_EJB_TIMER` DISABLE KEYS */;
INSERT INTO `JBOSS_EJB_TIMER` VALUES ('5c5a7d10-bc48-4711-ad00-edfd10087835','kie-server.kie-server.EJBTimerScheduler','2022-10-10 12:00:00',0,'2022-10-10 12:00:00',NULL,NULL,'BAQJPidvcmcuamJwbS5zZXJ2aWNlcy5lamIudGltZXIuRWpiVGltZXJKb2Lt9eXr3Edh8T4ZZGVwbG95bWVudC5raWUtc2VydmVyLndhcj4EbWFpbgAAAAE+EHRpbWVySm9iSW5zdGFuY2UWABYECT40b3JnLmpicG0ucGVyc2lzdGVuY2UudGltZXIuR2xvYmFsSnBhVGltZXJKb2JJbnN0YW5jZbVJw8qjmKTCPhlkZXBsb3ltZW50LmtpZS1zZXJ2ZXIud2FyOfsAAAABPg50aW1lclNlcnZpY2VJZBYACT4ub3JnLmRyb29scy5wZXJzaXN0ZW5jZS5qcGEuSnBhVGltZXJKb2JJbnN0YW5jZe0GuYB3Ic0nPhlkZXBsb3ltZW50LmtpZS1zZXJ2ZXIud2FyOfgAAAAACT4xb3JnLmRyb29scy5jb3JlLnRpbWUuaW1wbC5EZWZhdWx0VGltZXJKb2JJbnN0YW5jZcJd5xbbhHEIPhlkZXBsb3ltZW50LmtpZS1zZXJ2ZXIud2FyOfYAAAAEPgNjdHgWAD4GaGFuZGxlFgA+A2pvYhYAPgd0cmlnZ2VyFgAWBAk+Km9yZy5kcm9vbHMuY29yZS50aW1lLlNlbGZSZW1vdmFsSm9iQ29udGV4dAiG4S2TIErEPhlkZXBsb3ltZW50LmtpZS1zZXJ2ZXIud2FyOe8AAAACPgpqb2JDb250ZXh0FgA+DnRpbWVySW5zdGFuY2VzFgAWBAk+Pm9yZy5qYnBtLnByb2Nlc3MuaW5zdGFuY2UudGltZXIuVGltZXJNYW5hZ2VyJFByb2Nlc3NKb2JDb250ZXh0Bp4W/wlK07s+GWRlcGxveW1lbnQua2llLXNlcnZlci53YXI56gAAAAY+CWpvYkhhbmRsZRYAPghuZXdUaW1lciAAPhFwcm9jZXNzSW5zdGFuY2VJZBYAPglzZXNzaW9uSWQWAD4FdGltZXIWADnyFgAWBAk+Lm9yZy5qYnBtLnNlcnZpY2VzLmVqYi50aW1lci5FamJHbG9iYWxKb2JIYW5kbGU7CraI4p3GGj4ZZGVwbG95bWVudC5raWUtc2VydmVyLndhcjniAAAAAj4MZGVwbG95bWVudElkFgA+BHV1aWQWAAk+Q29yZy5qYnBtLnByb2Nlc3MuY29yZS50aW1lci5pbXBsLkdsb2JhbFRpbWVyU2VydmljZSRHbG9iYWxKb2JIYW5kbGUAAAAAAAAB/j4ZZGVwbG95bWVudC5raWUtc2VydmVyLndhcjneAAAAAAk+Km9yZy5kcm9vbHMuY29yZS50aW1lLmltcGwuRGVmYXVsdEpvYkhhbmRsZQAAAAAAAAH+PhlkZXBsb3ltZW50LmtpZS1zZXJ2ZXIud2FyOdwAAAADPgZjYW5jZWwgAD4CaWQkADnbFgAWAAAAAAAAAAAAOec+J2V4YW1wbGU6Y2FzZTAzMjAwNDEyOjEuMC10aW1lclNlcnZpY2VJZD4GMTYtNy0xAEwAAAAAAAAAB0wAAAAAAAAAEAQJPi1vcmcuamJwbS5wcm9jZXNzLmluc3RhbmNlLnRpbWVyLlRpbWVySW5zdGFuY2V/I3NLOc1wOz4ZZGVwbG95bWVudC5raWUtc2VydmVyLndhcjnVAAAADD4JYWN0aXZhdGVkFgA+DmNyb25FeHByZXNzaW9uFgA+BWRlbGF5JAA59yQAOegWAD4NbGFzdFRyaWdnZXJlZBYAPgRuYW1lFgA+BnBlcmlvZCQAOeckAD4LcmVwZWF0TGltaXQjADnnJAA+B3RpbWVySWQkABYEOD4OamF2YS51dGlsLkRhdGVoaoEBS1l0GQEAAAAAFjIIAAABgKqZwgk1AQAAAAMYc/b3AAAAAAAAAAEBAT0AAAAAAAAAAAAAAAAAAAAHAAAAAAAAAAAAAAAQAAAAAAAAAAEECT4pb3JnLmRyb29scy5jb3JlLnRpbWUuaW1wbC5JbnRlcnZhbFRyaWdnZXLs8nl/xIAkyT4ZZGVwbG95bWVudC5raWUtc2VydmVyLndhcjnIAAAACz4NY2FsZW5kYXJOYW1lcxYAPgljYWxlbmRhcnMWAD4LY3JlYXRlZFRpbWUWADnyJAA+B2VuZFRpbWUWAD4MbGFzdEZpcmVUaW1lFgA+DG5leHRGaXJlVGltZRYAOfIkAD4LcmVwZWF0Q291bnQjADnyIwA+CXN0YXJ0VGltZRYAFkEUAQEAAAAAAAAAAAEBBDv+MggAAAGDww25ADUAAAAAAAAAAAAAAAH/////BDv+MggAAAGAqpnCCTUEOD4RamF2YS51dGlsLkhhc2hNYXAFB9rBwxZg0QEAAAACPgpsb2FkRmFjdG9yJgA+CXRocmVzaG9sZCMAFj9AAAAAAAAAMggAAAAQAAAAADU53gQJPiNvcmcuZHJvb2xzLmNvcmUudGltZS5TZWxmUmVtb3ZhbEpvYnsvjP+kdz8GPhlkZXBsb3ltZW50LmtpZS1zZXJ2ZXIud2FyObYAAAABOcIWABYECT43b3JnLmpicG0ucHJvY2Vzcy5pbnN0YW5jZS50aW1lci5UaW1lck1hbmFnZXIkUHJvY2Vzc0pvYlNVeXphPM5WPhlkZXBsb3ltZW50LmtpZS1zZXJ2ZXIud2FyObMAAAAAFjnyOdk=','CREATED',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,0,'ejb_timer_part',NULL),('665990a0-f9a8-413e-859d-aaef0600ca55','kie-server.kie-server.EJBTimerScheduler','2022-10-10 12:00:00',0,'2022-10-10 12:00:00',NULL,NULL,'BAQJPidvcmcuamJwbS5zZXJ2aWNlcy5lamIudGltZXIuRWpiVGltZXJKb2Lt9eXr3Edh8T4ZZGVwbG95bWVudC5raWUtc2VydmVyLndhcj4EbWFpbgAAAAE+EHRpbWVySm9iSW5zdGFuY2UWABYECT40b3JnLmpicG0ucGVyc2lzdGVuY2UudGltZXIuR2xvYmFsSnBhVGltZXJKb2JJbnN0YW5jZbVJw8qjmKTCPhlkZXBsb3ltZW50LmtpZS1zZXJ2ZXIud2FyOfsAAAABPg50aW1lclNlcnZpY2VJZBYACT4ub3JnLmRyb29scy5wZXJzaXN0ZW5jZS5qcGEuSnBhVGltZXJKb2JJbnN0YW5jZe0GuYB3Ic0nPhlkZXBsb3ltZW50LmtpZS1zZXJ2ZXIud2FyOfgAAAAACT4xb3JnLmRyb29scy5jb3JlLnRpbWUuaW1wbC5EZWZhdWx0VGltZXJKb2JJbnN0YW5jZcJd5xbbhHEIPhlkZXBsb3ltZW50LmtpZS1zZXJ2ZXIud2FyOfYAAAAEPgNjdHgWAD4GaGFuZGxlFgA+A2pvYhYAPgd0cmlnZ2VyFgAWBAk+Km9yZy5kcm9vbHMuY29yZS50aW1lLlNlbGZSZW1vdmFsSm9iQ29udGV4dAiG4S2TIErEPhlkZXBsb3ltZW50LmtpZS1zZXJ2ZXIud2FyOe8AAAACPgpqb2JDb250ZXh0FgA+DnRpbWVySW5zdGFuY2VzFgAWBAk+Pm9yZy5qYnBtLnByb2Nlc3MuaW5zdGFuY2UudGltZXIuVGltZXJNYW5hZ2VyJFByb2Nlc3NKb2JDb250ZXh0Bp4W/wlK07s+GWRlcGxveW1lbnQua2llLXNlcnZlci53YXI56gAAAAY+CWpvYkhhbmRsZRYAPghuZXdUaW1lciAAPhFwcm9jZXNzSW5zdGFuY2VJZBYAPglzZXNzaW9uSWQWAD4FdGltZXIWADnyFgAWBAk+Lm9yZy5qYnBtLnNlcnZpY2VzLmVqYi50aW1lci5FamJHbG9iYWxKb2JIYW5kbGU7CraI4p3GGj4ZZGVwbG95bWVudC5raWUtc2VydmVyLndhcjniAAAAAj4MZGVwbG95bWVudElkFgA+BHV1aWQWAAk+Q29yZy5qYnBtLnByb2Nlc3MuY29yZS50aW1lci5pbXBsLkdsb2JhbFRpbWVyU2VydmljZSRHbG9iYWxKb2JIYW5kbGUAAAAAAAAB/j4ZZGVwbG95bWVudC5raWUtc2VydmVyLndhcjneAAAAAAk+Km9yZy5kcm9vbHMuY29yZS50aW1lLmltcGwuRGVmYXVsdEpvYkhhbmRsZQAAAAAAAAH+PhlkZXBsb3ltZW50LmtpZS1zZXJ2ZXIud2FyOdwAAAADPgZjYW5jZWwgAD4CaWQkADnbFgAWAAAAAAAAAAAAOec+J2V4YW1wbGU6Y2FzZTAzMjAwNDEyOjEuMC10aW1lclNlcnZpY2VJZD4UMTAtNC1kbyBzb21ldGhpbmctLTEBTAAAAAAAAAAETAAAAAAAAAAKBAk+LW9yZy5qYnBtLnByb2Nlc3MuaW5zdGFuY2UudGltZXIuVGltZXJJbnN0YW5jZX8jc0s5zXA7PhlkZXBsb3ltZW50LmtpZS1zZXJ2ZXIud2FyOdUAAAAMPglhY3RpdmF0ZWQWAD4OY3JvbkV4cHJlc3Npb24WAD4FZGVsYXkkADn3JAA56BYAPg1sYXN0VHJpZ2dlcmVkFgA+BG5hbWUWAD4GcGVyaW9kJAA55yQAPgtyZXBlYXRMaW1pdCMAOeckAD4HdGltZXJJZCQAFgQ4Pg5qYXZhLnV0aWwuRGF0ZWhqgQFLWXQZAQAAAAAWMggAAAGAqoNbzTUBAAAAAxiKXTQAAAAAAAAAAQEBPg1kbyBzb21ldGhpbmctAAAAAAAAAAAAAAAAAAAABP////8AAAAAAAAACgAAAAAAAAABBAk+KW9yZy5kcm9vbHMuY29yZS50aW1lLmltcGwuSW50ZXJ2YWxUcmlnZ2Vy7PJ5f8SAJMk+GWRlcGxveW1lbnQua2llLXNlcnZlci53YXI5xwAAAAs+DWNhbGVuZGFyTmFtZXMWAD4JY2FsZW5kYXJzFgA+C2NyZWF0ZWRUaW1lFgA58SQAPgdlbmRUaW1lFgA+DGxhc3RGaXJlVGltZRYAPgxuZXh0RmlyZVRpbWUWADnxJAA+C3JlcGVhdENvdW50IwA58SMAPglzdGFydFRpbWUWABYBAQQ7/jIIAAABgKqDW841AAAAAxiKXTQBAQQ7/jIIAAABg8MNuQI1AAAAAAAAAAAAAAAB/////wQ7/jIIAAABgKqDW841BDg+EWphdmEudXRpbC5IYXNoTWFwBQfawcMWYNEBAAAAAj4KbG9hZEZhY3RvciYAPgl0aHJlc2hvbGQjABY/QAAAAAAAADIIAAAAEAAAAAA1Od0ECT4jb3JnLmRyb29scy5jb3JlLnRpbWUuU2VsZlJlbW92YWxKb2J7L4z/pHc/Bj4ZZGVwbG95bWVudC5raWUtc2VydmVyLndhcjm1AAAAATnBFgAWBAk+N29yZy5qYnBtLnByb2Nlc3MuaW5zdGFuY2UudGltZXIuVGltZXJNYW5hZ2VyJFByb2Nlc3NKb2JTVXl6YTzOVj4ZZGVwbG95bWVudC5raWUtc2VydmVyLndhcjmyAAAAABY58jnY','CREATED',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,0,'ejb_timer_part',NULL);
/*!40000 ALTER TABLE `JBOSS_EJB_TIMER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `NodeInstanceLog`
--

DROP TABLE IF EXISTS `NodeInstanceLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `NodeInstanceLog` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `connection` varchar(255) DEFAULT NULL,
  `log_date` datetime DEFAULT NULL,
  `externalId` varchar(255) DEFAULT NULL,
  `nodeId` varchar(255) DEFAULT NULL,
  `nodeInstanceId` varchar(255) DEFAULT NULL,
  `nodeName` varchar(255) DEFAULT NULL,
  `nodeType` varchar(255) DEFAULT NULL,
  `processId` varchar(255) DEFAULT NULL,
  `processInstanceId` bigint(20) NOT NULL,
  `type` int(11) NOT NULL,
  `workItemId` bigint(20) DEFAULT NULL,
  `referenceId` bigint(20) DEFAULT NULL,
  `nodeContainerId` varchar(255) DEFAULT NULL,
  `slaCompliance` int(11) DEFAULT NULL,
  `sla_due_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_NInstLog_pInstId` (`processInstanceId`),
  KEY `IDX_NInstLog_nodeType` (`nodeType`),
  KEY `IDX_NInstLog_pId` (`processId`),
  KEY `IDX_NInstLog_workItemId` (`workItemId`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `NodeInstanceLog`
--

LOCK TABLES `NodeInstanceLog` WRITE;
/*!40000 ALTER TABLE `NodeInstanceLog` DISABLE KEYS */;
INSERT INTO `NodeInstanceLog` VALUES (1,NULL,'2021-02-22 23:13:08','com.myspace:case02824294:1.0.0-SNAPSHOT','_435CD116-2577-42A8-9861-2E83FCF2F52C','0','','StartNode','LetterOfGuarantee.PerformCredit',1,0,NULL,NULL,NULL,NULL,NULL),(2,'_AD9B584E-43A0-48A9-B546-9037B18D0EB2','2021-02-22 23:13:08','com.myspace:case02824294:1.0.0-SNAPSHOT','_88211E7A-07FB-4325-A457-105692F2F928','1','Perform Application Validation (script)','ActionNode','LetterOfGuarantee.PerformCredit',1,0,NULL,NULL,NULL,NULL,NULL),(3,'_AA722EBF-685E-49F3-9A90-CB4A0FC7F828','2021-02-22 23:13:08','com.myspace:case02824294:1.0.0-SNAPSHOT','_5AD113E6-6E18-4D19-965D-4E0510BBF98B','2','Perform Application Underwriting (script) ','ActionNode','LetterOfGuarantee.PerformCredit',1,0,NULL,NULL,NULL,NULL,NULL),(4,'_0598D4B5-A047-4C8F-A283-721CD3DDB232','2021-02-22 23:13:08','com.myspace:case02824294:1.0.0-SNAPSHOT','_2EA6F062-EC9C-4676-B8BA-A53CC41D545A','3','send investigation branch','ActionNode','LetterOfGuarantee.PerformCredit',1,0,NULL,NULL,NULL,NULL,NULL),(5,'_4A0391FA-4EEB-4EAC-BE18-7C324EAFB577','2021-02-22 23:13:08','com.myspace:case02824294:1.0.0-SNAPSHOT','_60FA66E7-925A-46B6-BE14-0018C2C62140','7','Review Application (script)','ActionNode','LetterOfGuarantee.PerformCredit',1,0,NULL,NULL,NULL,NULL,NULL),(6,'_EBC74F02-02AB-46FF-A73C-08FCE533989D','2021-02-22 23:13:08','com.myspace:case02824294:1.0.0-SNAPSHOT','_C0CADA6E-5E3D-4208-908C-98DB2F6BCD59','8','completed investigation','EndNode','LetterOfGuarantee.PerformCredit',1,0,NULL,NULL,NULL,NULL,NULL),(7,NULL,'2021-02-22 23:13:08','com.myspace:case02824294:1.0.0-SNAPSHOT','_0E0536F0-41F6-478E-8433-2F8DE57BCA2C','4','Investigations','EventSubProcessNode','LetterOfGuarantee.PerformCredit',1,1,NULL,NULL,NULL,NULL,NULL),(8,NULL,'2021-02-22 23:13:08','com.myspace:case02824294:1.0.0-SNAPSHOT','_C0CADA6E-5E3D-4208-908C-98DB2F6BCD59','8','completed investigation','EndNode','LetterOfGuarantee.PerformCredit',1,1,NULL,NULL,NULL,NULL,NULL),(9,'_EBC74F02-02AB-46FF-A73C-08FCE533989D','2021-02-22 23:13:08','com.myspace:case02824294:1.0.0-SNAPSHOT','_60FA66E7-925A-46B6-BE14-0018C2C62140','7','Review Application (script)','ActionNode','LetterOfGuarantee.PerformCredit',1,1,NULL,NULL,NULL,NULL,NULL),(10,'_4A0391FA-4EEB-4EAC-BE18-7C324EAFB577','2021-02-22 23:13:08','com.myspace:case02824294:1.0.0-SNAPSHOT','_976508F1-2DBE-4E7C-952C-4B5FFE5AA41A','6','receive investigation','StartNode','LetterOfGuarantee.PerformCredit',1,1,NULL,NULL,NULL,NULL,NULL),(11,'_35762EFE-3F03-453E-93EE-FF250FDEA54E','2021-02-22 23:13:08','com.myspace:case02824294:1.0.0-SNAPSHOT','_F9A968F5-0A29-48DE-9C62-4F3FE604A933','8','completed','EventNode','LetterOfGuarantee.PerformCredit',1,0,NULL,NULL,NULL,NULL,NULL),(12,'_35762EFE-3F03-453E-93EE-FF250FDEA54E','2021-02-22 23:13:08','com.myspace:case02824294:1.0.0-SNAPSHOT','_2EA6F062-EC9C-4676-B8BA-A53CC41D545A','3','send investigation branch','ActionNode','LetterOfGuarantee.PerformCredit',1,1,NULL,NULL,NULL,NULL,NULL),(13,'_0598D4B5-A047-4C8F-A283-721CD3DDB232','2021-02-22 23:13:08','com.myspace:case02824294:1.0.0-SNAPSHOT','_5AD113E6-6E18-4D19-965D-4E0510BBF98B','2','Perform Application Underwriting (script) ','ActionNode','LetterOfGuarantee.PerformCredit',1,1,NULL,NULL,NULL,NULL,NULL),(14,'_AA722EBF-685E-49F3-9A90-CB4A0FC7F828','2021-02-22 23:13:08','com.myspace:case02824294:1.0.0-SNAPSHOT','_88211E7A-07FB-4325-A457-105692F2F928','1','Perform Application Validation (script)','ActionNode','LetterOfGuarantee.PerformCredit',1,1,NULL,NULL,NULL,NULL,NULL),(15,'_AD9B584E-43A0-48A9-B546-9037B18D0EB2','2021-02-22 23:13:08','com.myspace:case02824294:1.0.0-SNAPSHOT','_435CD116-2577-42A8-9861-2E83FCF2F52C','0','','StartNode','LetterOfGuarantee.PerformCredit',1,1,NULL,NULL,NULL,NULL,NULL),(16,NULL,'2021-02-24 12:47:33','com.myspace:case02824294:1.0.0-SNAPSHOT','_435CD116-2577-42A8-9861-2E83FCF2F52C','0','','StartNode','LetterOfGuarantee.PerformCredit',2,0,NULL,NULL,NULL,NULL,NULL),(17,'_AD9B584E-43A0-48A9-B546-9037B18D0EB2','2021-02-24 12:47:33','com.myspace:case02824294:1.0.0-SNAPSHOT','_88211E7A-07FB-4325-A457-105692F2F928','1','Perform Application Validation (script)','ActionNode','LetterOfGuarantee.PerformCredit',2,0,NULL,NULL,NULL,NULL,NULL),(18,'_AA722EBF-685E-49F3-9A90-CB4A0FC7F828','2021-02-24 12:47:33','com.myspace:case02824294:1.0.0-SNAPSHOT','_5AD113E6-6E18-4D19-965D-4E0510BBF98B','2','Perform Application Underwriting (script) ','ActionNode','LetterOfGuarantee.PerformCredit',2,0,NULL,NULL,NULL,NULL,NULL),(19,'_0598D4B5-A047-4C8F-A283-721CD3DDB232','2021-02-24 12:47:33','com.myspace:case02824294:1.0.0-SNAPSHOT','_2EA6F062-EC9C-4676-B8BA-A53CC41D545A','3','send investigation branch','ActionNode','LetterOfGuarantee.PerformCredit',2,0,NULL,NULL,NULL,NULL,NULL),(20,'_4A0391FA-4EEB-4EAC-BE18-7C324EAFB577','2021-02-24 12:47:33','com.myspace:case02824294:1.0.0-SNAPSHOT','_60FA66E7-925A-46B6-BE14-0018C2C62140','7','Review Application (script)','ActionNode','LetterOfGuarantee.PerformCredit',2,0,NULL,NULL,NULL,NULL,NULL),(21,'_EBC74F02-02AB-46FF-A73C-08FCE533989D','2021-02-24 12:47:33','com.myspace:case02824294:1.0.0-SNAPSHOT','_C0CADA6E-5E3D-4208-908C-98DB2F6BCD59','8','completed investigation','EndNode','LetterOfGuarantee.PerformCredit',2,0,NULL,NULL,NULL,NULL,NULL),(22,NULL,'2021-02-24 12:47:33','com.myspace:case02824294:1.0.0-SNAPSHOT','_0E0536F0-41F6-478E-8433-2F8DE57BCA2C','4','Investigations','EventSubProcessNode','LetterOfGuarantee.PerformCredit',2,1,NULL,NULL,NULL,NULL,NULL),(23,NULL,'2021-02-24 12:47:33','com.myspace:case02824294:1.0.0-SNAPSHOT','_C0CADA6E-5E3D-4208-908C-98DB2F6BCD59','8','completed investigation','EndNode','LetterOfGuarantee.PerformCredit',2,1,NULL,NULL,NULL,NULL,NULL),(24,'_EBC74F02-02AB-46FF-A73C-08FCE533989D','2021-02-24 12:47:33','com.myspace:case02824294:1.0.0-SNAPSHOT','_60FA66E7-925A-46B6-BE14-0018C2C62140','7','Review Application (script)','ActionNode','LetterOfGuarantee.PerformCredit',2,1,NULL,NULL,NULL,NULL,NULL),(25,'_4A0391FA-4EEB-4EAC-BE18-7C324EAFB577','2021-02-24 12:47:33','com.myspace:case02824294:1.0.0-SNAPSHOT','_976508F1-2DBE-4E7C-952C-4B5FFE5AA41A','6','receive investigation','StartNode','LetterOfGuarantee.PerformCredit',2,1,NULL,NULL,NULL,NULL,NULL),(26,'_35762EFE-3F03-453E-93EE-FF250FDEA54E','2021-02-24 12:47:33','com.myspace:case02824294:1.0.0-SNAPSHOT','_F9A968F5-0A29-48DE-9C62-4F3FE604A933','8','completed','EventNode','LetterOfGuarantee.PerformCredit',2,0,NULL,NULL,NULL,NULL,NULL),(27,'_35762EFE-3F03-453E-93EE-FF250FDEA54E','2021-02-24 12:47:33','com.myspace:case02824294:1.0.0-SNAPSHOT','_2EA6F062-EC9C-4676-B8BA-A53CC41D545A','3','send investigation branch','ActionNode','LetterOfGuarantee.PerformCredit',2,1,NULL,NULL,NULL,NULL,NULL),(28,'_0598D4B5-A047-4C8F-A283-721CD3DDB232','2021-02-24 12:47:33','com.myspace:case02824294:1.0.0-SNAPSHOT','_5AD113E6-6E18-4D19-965D-4E0510BBF98B','2','Perform Application Underwriting (script) ','ActionNode','LetterOfGuarantee.PerformCredit',2,1,NULL,NULL,NULL,NULL,NULL),(29,'_AA722EBF-685E-49F3-9A90-CB4A0FC7F828','2021-02-24 12:47:33','com.myspace:case02824294:1.0.0-SNAPSHOT','_88211E7A-07FB-4325-A457-105692F2F928','1','Perform Application Validation (script)','ActionNode','LetterOfGuarantee.PerformCredit',2,1,NULL,NULL,NULL,NULL,NULL),(30,'_AD9B584E-43A0-48A9-B546-9037B18D0EB2','2021-02-24 12:47:33','com.myspace:case02824294:1.0.0-SNAPSHOT','_435CD116-2577-42A8-9861-2E83FCF2F52C','0','','StartNode','LetterOfGuarantee.PerformCredit',2,1,NULL,NULL,NULL,NULL,NULL),(31,NULL,'2021-02-24 12:48:21','com.myspace:case02824294:1.0.0-SNAPSHOT','_435CD116-2577-42A8-9861-2E83FCF2F52C','0','','StartNode','LetterOfGuarantee.PerformCredit',3,0,NULL,NULL,NULL,NULL,NULL),(32,'_AD9B584E-43A0-48A9-B546-9037B18D0EB2','2021-02-24 12:48:21','com.myspace:case02824294:1.0.0-SNAPSHOT','_88211E7A-07FB-4325-A457-105692F2F928','1','Perform Application Validation (script)','ActionNode','LetterOfGuarantee.PerformCredit',3,0,NULL,NULL,NULL,NULL,NULL),(33,'_AA722EBF-685E-49F3-9A90-CB4A0FC7F828','2021-02-24 12:48:21','com.myspace:case02824294:1.0.0-SNAPSHOT','_5AD113E6-6E18-4D19-965D-4E0510BBF98B','2','Perform Application Underwriting (script) ','ActionNode','LetterOfGuarantee.PerformCredit',3,0,NULL,NULL,NULL,NULL,NULL),(34,'_0598D4B5-A047-4C8F-A283-721CD3DDB232','2021-02-24 12:48:21','com.myspace:case02824294:1.0.0-SNAPSHOT','_2EA6F062-EC9C-4676-B8BA-A53CC41D545A','3','send investigation branch','ActionNode','LetterOfGuarantee.PerformCredit',3,0,NULL,NULL,NULL,NULL,NULL),(35,'_4A0391FA-4EEB-4EAC-BE18-7C324EAFB577','2021-02-24 12:48:21','com.myspace:case02824294:1.0.0-SNAPSHOT','_60FA66E7-925A-46B6-BE14-0018C2C62140','7','Review Application (script)','ActionNode','LetterOfGuarantee.PerformCredit',3,0,NULL,NULL,NULL,NULL,NULL),(36,'_EBC74F02-02AB-46FF-A73C-08FCE533989D','2021-02-24 12:48:21','com.myspace:case02824294:1.0.0-SNAPSHOT','_C0CADA6E-5E3D-4208-908C-98DB2F6BCD59','8','completed investigation','EndNode','LetterOfGuarantee.PerformCredit',3,0,NULL,NULL,NULL,NULL,NULL),(37,NULL,'2021-02-24 12:48:21','com.myspace:case02824294:1.0.0-SNAPSHOT','_0E0536F0-41F6-478E-8433-2F8DE57BCA2C','4','Investigations','EventSubProcessNode','LetterOfGuarantee.PerformCredit',3,1,NULL,NULL,NULL,NULL,NULL),(38,NULL,'2021-02-24 12:48:21','com.myspace:case02824294:1.0.0-SNAPSHOT','_C0CADA6E-5E3D-4208-908C-98DB2F6BCD59','8','completed investigation','EndNode','LetterOfGuarantee.PerformCredit',3,1,NULL,NULL,NULL,NULL,NULL),(39,'_EBC74F02-02AB-46FF-A73C-08FCE533989D','2021-02-24 12:48:21','com.myspace:case02824294:1.0.0-SNAPSHOT','_60FA66E7-925A-46B6-BE14-0018C2C62140','7','Review Application (script)','ActionNode','LetterOfGuarantee.PerformCredit',3,1,NULL,NULL,NULL,NULL,NULL),(40,'_4A0391FA-4EEB-4EAC-BE18-7C324EAFB577','2021-02-24 12:48:21','com.myspace:case02824294:1.0.0-SNAPSHOT','_976508F1-2DBE-4E7C-952C-4B5FFE5AA41A','6','receive investigation','StartNode','LetterOfGuarantee.PerformCredit',3,1,NULL,NULL,NULL,NULL,NULL),(41,'_35762EFE-3F03-453E-93EE-FF250FDEA54E','2021-02-24 12:48:21','com.myspace:case02824294:1.0.0-SNAPSHOT','_F9A968F5-0A29-48DE-9C62-4F3FE604A933','8','completed','EventNode','LetterOfGuarantee.PerformCredit',3,0,NULL,NULL,NULL,NULL,NULL),(42,'_35762EFE-3F03-453E-93EE-FF250FDEA54E','2021-02-24 12:48:21','com.myspace:case02824294:1.0.0-SNAPSHOT','_2EA6F062-EC9C-4676-B8BA-A53CC41D545A','3','send investigation branch','ActionNode','LetterOfGuarantee.PerformCredit',3,1,NULL,NULL,NULL,NULL,NULL),(43,'_0598D4B5-A047-4C8F-A283-721CD3DDB232','2021-02-24 12:48:21','com.myspace:case02824294:1.0.0-SNAPSHOT','_5AD113E6-6E18-4D19-965D-4E0510BBF98B','2','Perform Application Underwriting (script) ','ActionNode','LetterOfGuarantee.PerformCredit',3,1,NULL,NULL,NULL,NULL,NULL),(44,'_AA722EBF-685E-49F3-9A90-CB4A0FC7F828','2021-02-24 12:48:21','com.myspace:case02824294:1.0.0-SNAPSHOT','_88211E7A-07FB-4325-A457-105692F2F928','1','Perform Application Validation (script)','ActionNode','LetterOfGuarantee.PerformCredit',3,1,NULL,NULL,NULL,NULL,NULL),(45,'_AD9B584E-43A0-48A9-B546-9037B18D0EB2','2021-02-24 12:48:21','com.myspace:case02824294:1.0.0-SNAPSHOT','_435CD116-2577-42A8-9861-2E83FCF2F52C','0','','StartNode','LetterOfGuarantee.PerformCredit',3,1,NULL,NULL,NULL,NULL,NULL),(46,NULL,'2022-05-09 14:26:14','example:case03200412:1.0','processStartEvent','0','','StartNode','case03200412.timertest',4,0,NULL,NULL,NULL,0,NULL),(47,'_1A880863-24AD-4BD1-868C-0EB1CB94FC33','2022-05-09 14:26:14','example:case03200412:1.0','processStartEvent','0','','StartNode','case03200412.timertest',4,1,NULL,NULL,NULL,0,NULL),(48,'processStartEvent','2022-05-09 14:26:14','example:case03200412:1.0','_1A880863-24AD-4BD1-868C-0EB1CB94FC33','1','log start','ActionNode','case03200412.timertest',4,0,NULL,NULL,NULL,0,NULL),(49,'_68C45378-301C-4B7E-9C87-DB9E8CD14718','2022-05-09 14:26:14','example:case03200412:1.0','_1A880863-24AD-4BD1-868C-0EB1CB94FC33','1','log start','ActionNode','case03200412.timertest',4,1,NULL,NULL,NULL,0,NULL),(50,'_1A880863-24AD-4BD1-868C-0EB1CB94FC33','2022-05-09 14:26:14','example:case03200412:1.0','_68C45378-301C-4B7E-9C87-DB9E8CD14718','2','','EventNode','case03200412.timertest',4,0,NULL,NULL,NULL,0,NULL),(51,'_A8A23F1B-532F-460C-B274-7D17BBDEB4D2','2022-05-09 14:29:37','example:case03200412:1.0','_68C45378-301C-4B7E-9C87-DB9E8CD14718','2','','EventNode','case03200412.timertest',4,1,NULL,NULL,NULL,0,NULL),(52,'_68C45378-301C-4B7E-9C87-DB9E8CD14718','2022-05-09 14:29:37','example:case03200412:1.0','_A8A23F1B-532F-460C-B274-7D17BBDEB4D2','3','do something','HumanTaskNode','case03200412.timertest',4,0,4,NULL,NULL,0,NULL),(53,NULL,'2022-05-09 14:53:02','example:case03200412:1.0','processStartEvent','0','','StartNode','case03200412.timertest',5,0,NULL,NULL,NULL,NULL,NULL),(54,'_73031C55-35FC-4BF3-BB65-FD854B1D5AF3','2022-05-09 14:53:02','example:case03200412:1.0','_1A880863-24AD-4BD1-868C-0EB1CB94FC33','1','log start','ActionNode','case03200412.timertest',5,0,NULL,NULL,NULL,NULL,NULL),(55,'_52B82AD3-2467-483B-BEC8-F79AD5E5F17E','2022-05-09 14:53:02','example:case03200412:1.0','_68C45378-301C-4B7E-9C87-DB9E8CD14718','2','','EventNode','case03200412.timertest',5,0,NULL,NULL,NULL,NULL,NULL),(56,'_52B82AD3-2467-483B-BEC8-F79AD5E5F17E','2022-05-09 14:53:02','example:case03200412:1.0','_1A880863-24AD-4BD1-868C-0EB1CB94FC33','1','log start','ActionNode','case03200412.timertest',5,1,NULL,NULL,NULL,NULL,NULL),(57,'_73031C55-35FC-4BF3-BB65-FD854B1D5AF3','2022-05-09 14:53:02','example:case03200412:1.0','processStartEvent','0','','StartNode','case03200412.timertest',5,1,NULL,NULL,NULL,NULL,NULL),(58,NULL,'2022-05-09 14:53:19','example:case03200412:1.0','processStartEvent','0','','StartNode','case03200412.timertest',6,0,NULL,NULL,NULL,NULL,NULL),(59,'_73031C55-35FC-4BF3-BB65-FD854B1D5AF3','2022-05-09 14:53:19','example:case03200412:1.0','_1A880863-24AD-4BD1-868C-0EB1CB94FC33','1','log start','ActionNode','case03200412.timertest',6,0,NULL,NULL,NULL,NULL,NULL),(60,'_52B82AD3-2467-483B-BEC8-F79AD5E5F17E','2022-05-09 14:53:19','example:case03200412:1.0','_68C45378-301C-4B7E-9C87-DB9E8CD14718','2','','EventNode','case03200412.timertest',6,0,NULL,NULL,NULL,NULL,NULL),(61,'_52B82AD3-2467-483B-BEC8-F79AD5E5F17E','2022-05-09 14:53:19','example:case03200412:1.0','_1A880863-24AD-4BD1-868C-0EB1CB94FC33','1','log start','ActionNode','case03200412.timertest',6,1,NULL,NULL,NULL,NULL,NULL),(62,'_73031C55-35FC-4BF3-BB65-FD854B1D5AF3','2022-05-09 14:53:19','example:case03200412:1.0','processStartEvent','0','','StartNode','case03200412.timertest',6,1,NULL,NULL,NULL,NULL,NULL),(63,NULL,'2022-05-09 14:53:26','example:case03200412:1.0','processStartEvent','0','','StartNode','case03200412.timertest',7,0,NULL,NULL,NULL,NULL,NULL),(64,'_73031C55-35FC-4BF3-BB65-FD854B1D5AF3','2022-05-09 14:53:26','example:case03200412:1.0','_1A880863-24AD-4BD1-868C-0EB1CB94FC33','1','log start','ActionNode','case03200412.timertest',7,0,NULL,NULL,NULL,NULL,NULL),(65,'_52B82AD3-2467-483B-BEC8-F79AD5E5F17E','2022-05-09 14:53:26','example:case03200412:1.0','_68C45378-301C-4B7E-9C87-DB9E8CD14718','2','','EventNode','case03200412.timertest',7,0,NULL,NULL,NULL,NULL,NULL),(66,'_52B82AD3-2467-483B-BEC8-F79AD5E5F17E','2022-05-09 14:53:26','example:case03200412:1.0','_1A880863-24AD-4BD1-868C-0EB1CB94FC33','1','log start','ActionNode','case03200412.timertest',7,1,NULL,NULL,NULL,NULL,NULL),(67,'_73031C55-35FC-4BF3-BB65-FD854B1D5AF3','2022-05-09 14:53:26','example:case03200412:1.0','processStartEvent','0','','StartNode','case03200412.timertest',7,1,NULL,NULL,NULL,NULL,NULL),(68,'_8935116E-9CC7-4694-83E5-F06D1BA6EB4A','2022-05-09 14:53:50','example:case03200412:1.0','_A8A23F1B-532F-460C-B274-7D17BBDEB4D2','3','do something','HumanTaskNode','case03200412.timertest',6,0,5,NULL,NULL,NULL,NULL),(69,'_8935116E-9CC7-4694-83E5-F06D1BA6EB4A','2022-05-09 14:53:50','example:case03200412:1.0','_68C45378-301C-4B7E-9C87-DB9E8CD14718','2','','EventNode','case03200412.timertest',6,1,NULL,NULL,NULL,NULL,NULL),(70,'_8935116E-9CC7-4694-83E5-F06D1BA6EB4A','2022-05-09 14:54:05','example:case03200412:1.0','_A8A23F1B-532F-460C-B274-7D17BBDEB4D2','3','do something','HumanTaskNode','case03200412.timertest',7,0,6,NULL,NULL,NULL,NULL),(71,'_8935116E-9CC7-4694-83E5-F06D1BA6EB4A','2022-05-09 14:54:05','example:case03200412:1.0','_68C45378-301C-4B7E-9C87-DB9E8CD14718','2','','EventNode','case03200412.timertest',7,1,NULL,NULL,NULL,NULL,NULL),(72,NULL,'2022-05-09 14:56:35','example:case03200412:1.0','processStartEvent','0','','StartNode','case03200412.timertest',8,0,NULL,NULL,NULL,0,NULL),(73,'_1A880863-24AD-4BD1-868C-0EB1CB94FC33','2022-05-09 14:56:35','example:case03200412:1.0','processStartEvent','0','','StartNode','case03200412.timertest',8,1,NULL,NULL,NULL,0,NULL),(74,'processStartEvent','2022-05-09 14:56:35','example:case03200412:1.0','_1A880863-24AD-4BD1-868C-0EB1CB94FC33','1','log start','ActionNode','case03200412.timertest',8,0,NULL,NULL,NULL,0,NULL),(75,'_68C45378-301C-4B7E-9C87-DB9E8CD14718','2022-05-09 14:56:35','example:case03200412:1.0','_1A880863-24AD-4BD1-868C-0EB1CB94FC33','1','log start','ActionNode','case03200412.timertest',8,1,NULL,NULL,NULL,0,NULL),(76,'_1A880863-24AD-4BD1-868C-0EB1CB94FC33','2022-05-09 14:56:35','example:case03200412:1.0','_68C45378-301C-4B7E-9C87-DB9E8CD14718','2','','EventNode','case03200412.timertest',8,0,NULL,NULL,NULL,0,NULL);
/*!40000 ALTER TABLE `NodeInstanceLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Notification`
--

DROP TABLE IF EXISTS `Notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Notification` (
  `DTYPE` varchar(31) NOT NULL,
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `priority` int(11) NOT NULL,
  `Escalation_Notifications_Id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_bdbeml3768go5im41cgfpyso9` (`Escalation_Notifications_Id`),
  KEY `IDX_Not_EscId` (`Escalation_Notifications_Id`),
  CONSTRAINT `FK_bdbeml3768go5im41cgfpyso9` FOREIGN KEY (`Escalation_Notifications_Id`) REFERENCES `Escalation` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Notification`
--

LOCK TABLES `Notification` WRITE;
/*!40000 ALTER TABLE `Notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `Notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Notification_BAs`
--

DROP TABLE IF EXISTS `Notification_BAs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Notification_BAs` (
  `task_id` bigint(20) NOT NULL,
  `entity_id` varchar(255) NOT NULL,
  KEY `FK_mfbsnbrhth4rjhqc2ud338s4i` (`entity_id`),
  KEY `FK_fc0uuy76t2bvxaxqysoo8xts7` (`task_id`),
  KEY `IDX_NotBAs_Entity` (`entity_id`),
  KEY `IDX_NotBAs_Task` (`task_id`),
  CONSTRAINT `FK_fc0uuy76t2bvxaxqysoo8xts7` FOREIGN KEY (`task_id`) REFERENCES `Notification` (`id`),
  CONSTRAINT `FK_mfbsnbrhth4rjhqc2ud338s4i` FOREIGN KEY (`entity_id`) REFERENCES `OrganizationalEntity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Notification_BAs`
--

LOCK TABLES `Notification_BAs` WRITE;
/*!40000 ALTER TABLE `Notification_BAs` DISABLE KEYS */;
/*!40000 ALTER TABLE `Notification_BAs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Notification_Recipients`
--

DROP TABLE IF EXISTS `Notification_Recipients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Notification_Recipients` (
  `task_id` bigint(20) NOT NULL,
  `entity_id` varchar(255) NOT NULL,
  KEY `FK_blf9jsrumtrthdaqnpwxt25eu` (`entity_id`),
  KEY `FK_3l244pj8sh78vtn9imaymrg47` (`task_id`),
  KEY `IDX_NotRec_Entity` (`entity_id`),
  KEY `IDX_NotRec_Task` (`task_id`),
  CONSTRAINT `FK_3l244pj8sh78vtn9imaymrg47` FOREIGN KEY (`task_id`) REFERENCES `Notification` (`id`),
  CONSTRAINT `FK_blf9jsrumtrthdaqnpwxt25eu` FOREIGN KEY (`entity_id`) REFERENCES `OrganizationalEntity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Notification_Recipients`
--

LOCK TABLES `Notification_Recipients` WRITE;
/*!40000 ALTER TABLE `Notification_Recipients` DISABLE KEYS */;
/*!40000 ALTER TABLE `Notification_Recipients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Notification_email_header`
--

DROP TABLE IF EXISTS `Notification_email_header`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Notification_email_header` (
  `Notification_id` bigint(20) NOT NULL,
  `emailHeaders_id` bigint(20) NOT NULL,
  `mapkey` varchar(255) NOT NULL,
  PRIMARY KEY (`Notification_id`,`mapkey`),
  UNIQUE KEY `UK_ptaka5kost68h7l3wflv7w6y8` (`emailHeaders_id`),
  KEY `FK_ptaka5kost68h7l3wflv7w6y8` (`emailHeaders_id`),
  KEY `FK_eth4nvxn21fk1vnju85vkjrai` (`Notification_id`),
  KEY `IDX_NotEmail_Header` (`emailHeaders_id`),
  KEY `IDX_NotEmail_Not` (`Notification_id`),
  CONSTRAINT `FK_eth4nvxn21fk1vnju85vkjrai` FOREIGN KEY (`Notification_id`) REFERENCES `Notification` (`id`),
  CONSTRAINT `FK_ptaka5kost68h7l3wflv7w6y8` FOREIGN KEY (`emailHeaders_id`) REFERENCES `email_header` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Notification_email_header`
--

LOCK TABLES `Notification_email_header` WRITE;
/*!40000 ALTER TABLE `Notification_email_header` DISABLE KEYS */;
/*!40000 ALTER TABLE `Notification_email_header` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OrganizationalEntity`
--

DROP TABLE IF EXISTS `OrganizationalEntity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OrganizationalEntity` (
  `DTYPE` varchar(31) NOT NULL,
  `id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OrganizationalEntity`
--

LOCK TABLES `OrganizationalEntity` WRITE;
/*!40000 ALTER TABLE `OrganizationalEntity` DISABLE KEYS */;
INSERT INTO `OrganizationalEntity` VALUES ('Group','admin'),('User','Administrator'),('Group','Administrators');
/*!40000 ALTER TABLE `OrganizationalEntity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PeopleAssignments_BAs`
--

DROP TABLE IF EXISTS `PeopleAssignments_BAs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PeopleAssignments_BAs` (
  `task_id` bigint(20) NOT NULL,
  `entity_id` varchar(255) NOT NULL,
  KEY `FK_t38xbkrq6cppifnxequhvjsl2` (`entity_id`),
  KEY `FK_omjg5qh7uv8e9bolbaq7hv6oh` (`task_id`),
  KEY `IDX_PAsBAs_Entity` (`entity_id`),
  KEY `IDX_PAsBAs_Task` (`task_id`),
  CONSTRAINT `FK_omjg5qh7uv8e9bolbaq7hv6oh` FOREIGN KEY (`task_id`) REFERENCES `Task` (`id`),
  CONSTRAINT `FK_t38xbkrq6cppifnxequhvjsl2` FOREIGN KEY (`entity_id`) REFERENCES `OrganizationalEntity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PeopleAssignments_BAs`
--

LOCK TABLES `PeopleAssignments_BAs` WRITE;
/*!40000 ALTER TABLE `PeopleAssignments_BAs` DISABLE KEYS */;
INSERT INTO `PeopleAssignments_BAs` VALUES (1,'Administrator'),(1,'Administrators'),(2,'Administrator'),(2,'Administrators'),(3,'Administrator'),(3,'Administrators');
/*!40000 ALTER TABLE `PeopleAssignments_BAs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PeopleAssignments_ExclOwners`
--

DROP TABLE IF EXISTS `PeopleAssignments_ExclOwners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PeopleAssignments_ExclOwners` (
  `task_id` bigint(20) NOT NULL,
  `entity_id` varchar(255) NOT NULL,
  KEY `FK_pth28a73rj6bxtlfc69kmqo0a` (`entity_id`),
  KEY `FK_b8owuxfrdng050ugpk0pdowa7` (`task_id`),
  KEY `IDX_PAsExcl_Entity` (`entity_id`),
  KEY `IDX_PAsExcl_Task` (`task_id`),
  CONSTRAINT `FK_b8owuxfrdng050ugpk0pdowa7` FOREIGN KEY (`task_id`) REFERENCES `Task` (`id`),
  CONSTRAINT `FK_pth28a73rj6bxtlfc69kmqo0a` FOREIGN KEY (`entity_id`) REFERENCES `OrganizationalEntity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PeopleAssignments_ExclOwners`
--

LOCK TABLES `PeopleAssignments_ExclOwners` WRITE;
/*!40000 ALTER TABLE `PeopleAssignments_ExclOwners` DISABLE KEYS */;
/*!40000 ALTER TABLE `PeopleAssignments_ExclOwners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PeopleAssignments_PotOwners`
--

DROP TABLE IF EXISTS `PeopleAssignments_PotOwners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PeopleAssignments_PotOwners` (
  `task_id` bigint(20) NOT NULL,
  `entity_id` varchar(255) NOT NULL,
  KEY `FK_tee3ftir7xs6eo3fdvi3xw026` (`entity_id`),
  KEY `FK_4dv2oji7pr35ru0w45trix02x` (`task_id`),
  KEY `IDX_PAsPot_Entity` (`entity_id`),
  KEY `IDX_PAsPot_Task` (`task_id`),
  KEY `IDX_PAsPot_TaskEntity` (`task_id`,`entity_id`),
  CONSTRAINT `FK_4dv2oji7pr35ru0w45trix02x` FOREIGN KEY (`task_id`) REFERENCES `Task` (`id`),
  CONSTRAINT `FK_tee3ftir7xs6eo3fdvi3xw026` FOREIGN KEY (`entity_id`) REFERENCES `OrganizationalEntity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PeopleAssignments_PotOwners`
--

LOCK TABLES `PeopleAssignments_PotOwners` WRITE;
/*!40000 ALTER TABLE `PeopleAssignments_PotOwners` DISABLE KEYS */;
INSERT INTO `PeopleAssignments_PotOwners` VALUES (2,'admin'),(3,'admin');
/*!40000 ALTER TABLE `PeopleAssignments_PotOwners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PeopleAssignments_Recipients`
--

DROP TABLE IF EXISTS `PeopleAssignments_Recipients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PeopleAssignments_Recipients` (
  `task_id` bigint(20) NOT NULL,
  `entity_id` varchar(255) NOT NULL,
  KEY `FK_4g7y3wx6gnokf6vycgpxs83d6` (`entity_id`),
  KEY `FK_enhk831fghf6akjilfn58okl4` (`task_id`),
  KEY `IDX_PAsRecip_Entity` (`entity_id`),
  KEY `IDX_PAsRecip_Task` (`task_id`),
  CONSTRAINT `FK_4g7y3wx6gnokf6vycgpxs83d6` FOREIGN KEY (`entity_id`) REFERENCES `OrganizationalEntity` (`id`),
  CONSTRAINT `FK_enhk831fghf6akjilfn58okl4` FOREIGN KEY (`task_id`) REFERENCES `Task` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PeopleAssignments_Recipients`
--

LOCK TABLES `PeopleAssignments_Recipients` WRITE;
/*!40000 ALTER TABLE `PeopleAssignments_Recipients` DISABLE KEYS */;
/*!40000 ALTER TABLE `PeopleAssignments_Recipients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PeopleAssignments_Stakeholders`
--

DROP TABLE IF EXISTS `PeopleAssignments_Stakeholders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PeopleAssignments_Stakeholders` (
  `task_id` bigint(20) NOT NULL,
  `entity_id` varchar(255) NOT NULL,
  KEY `FK_met63inaep6cq4ofb3nnxi4tm` (`entity_id`),
  KEY `FK_4bh3ay74x6ql9usunubttfdf1` (`task_id`),
  KEY `IDX_PAsStake_Entity` (`entity_id`),
  KEY `IDX_PAsStake_Task` (`task_id`),
  CONSTRAINT `FK_4bh3ay74x6ql9usunubttfdf1` FOREIGN KEY (`task_id`) REFERENCES `Task` (`id`),
  CONSTRAINT `FK_met63inaep6cq4ofb3nnxi4tm` FOREIGN KEY (`entity_id`) REFERENCES `OrganizationalEntity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PeopleAssignments_Stakeholders`
--

LOCK TABLES `PeopleAssignments_Stakeholders` WRITE;
/*!40000 ALTER TABLE `PeopleAssignments_Stakeholders` DISABLE KEYS */;
/*!40000 ALTER TABLE `PeopleAssignments_Stakeholders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProcessInstanceInfo`
--

DROP TABLE IF EXISTS `ProcessInstanceInfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProcessInstanceInfo` (
  `InstanceId` bigint(20) NOT NULL AUTO_INCREMENT,
  `lastModificationDate` datetime DEFAULT NULL,
  `lastReadDate` datetime DEFAULT NULL,
  `processId` varchar(255) DEFAULT NULL,
  `processInstanceByteArray` longblob DEFAULT NULL,
  `startDate` datetime DEFAULT NULL,
  `state` int(11) NOT NULL,
  `OPTLOCK` int(11) DEFAULT NULL,
  PRIMARY KEY (`InstanceId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProcessInstanceInfo`
--

LOCK TABLES `ProcessInstanceInfo` WRITE;
/*!40000 ALTER TABLE `ProcessInstanceInfo` DISABLE KEYS */;
INSERT INTO `ProcessInstanceInfo` VALUES (1,'2021-02-22 23:13:08','2021-02-22 23:13:08','LetterOfGuarantee.PerformCredit','¨Ì\0z\0\0\0\0RuleFlow\n\0Jÿ\0Horg.drools.core.marshalling.impl.SerializablePlaceholderResolverStrategy\Zâ¨Ì\0sr\0java.util.ArrayListxÅ“ô«aù\0I\0sizexp\0\0\0w\0\0\0sr\0java.lang.BooleanÕ rÄ’ú˙Ó\0Z\0valuexpsr\0#com.accenture.process.model.Message\0\0\0\0\0\0\0\0L\0messageDatat\0Ljava/lang/Object;L\0\nmessageReft\0Ljava/lang/String;L\0	targetPidt\0Ljava/lang/Long;xpq\0~\0t\0investigationCompletedsr\0java.lang.Long;ã‰êÃè#ﬂ\0J\0valuexr\0java.lang.NumberÜ¨ïî‡ã\0\0xp\0\0\0\0\0\0\0sq\0~\0q\0~\0t\0\rinvestigationq\0~\0xR∏\nRuleFlow\ZLetterOfGuarantee.PerformCredit (	:\n	\"(B\"\nisInvestigationRequested\0\Z\0\0\0\0B\'\nmessage_completeInvestigation\0\Z\0\0\0B\nmessage_investigation\0\Z\0\0\0`\0j%_435CD116-2577-42A8-9861-2E83FCF2F52Cj%_88211E7A-07FB-4325-A457-105692F2F928j%_5AD113E6-6E18-4D19-965D-4E0510BBF98Bj%_976508F1-2DBE-4E7C-952C-4B5FFE5AA41Aj%_60FA66E7-925A-46B6-BE14-0018C2C62140j%_0E0536F0-41F6-478E-8433-2F8DE57BCA2Cj%_2EA6F062-EC9C-4676-B8BA-A53CC41D545Ar)\n%_F9A968F5-0A29-48DE-9C62-4F3FE604A933z Letter of Guarantee - EvaluationÄäw(\'com.myspace:case02824294:1.0.0-SNAPSHOT','2021-02-22 23:13:08',1,2),(2,'2021-02-24 12:47:34','2021-02-24 12:47:33','LetterOfGuarantee.PerformCredit','¨Ì\0z\0\0\0\0RuleFlow\n\0Jÿ\0Horg.drools.core.marshalling.impl.SerializablePlaceholderResolverStrategy\Zâ¨Ì\0sr\0java.util.ArrayListxÅ“ô«aù\0I\0sizexp\0\0\0w\0\0\0sr\0java.lang.BooleanÕ rÄ’ú˙Ó\0Z\0valuexpsr\0#com.accenture.process.model.Message\0\0\0\0\0\0\0\0L\0messageDatat\0Ljava/lang/Object;L\0\nmessageReft\0Ljava/lang/String;L\0	targetPidt\0Ljava/lang/Long;xpq\0~\0t\0investigationCompletedsr\0java.lang.Long;ã‰êÃè#ﬂ\0J\0valuexr\0java.lang.NumberÜ¨ïî‡ã\0\0xp\0\0\0\0\0\0\0sq\0~\0q\0~\0t\0\rinvestigationq\0~\0xR∏\nRuleFlow\ZLetterOfGuarantee.PerformCredit (	:\n	\"(B\"\nisInvestigationRequested\0\Z\0\0\0\0B\'\nmessage_completeInvestigation\0\Z\0\0\0B\nmessage_investigation\0\Z\0\0\0`\0j%_435CD116-2577-42A8-9861-2E83FCF2F52Cj%_88211E7A-07FB-4325-A457-105692F2F928j%_5AD113E6-6E18-4D19-965D-4E0510BBF98Bj%_976508F1-2DBE-4E7C-952C-4B5FFE5AA41Aj%_60FA66E7-925A-46B6-BE14-0018C2C62140j%_0E0536F0-41F6-478E-8433-2F8DE57BCA2Cj%_2EA6F062-EC9C-4676-B8BA-A53CC41D545Ar)\n%_F9A968F5-0A29-48DE-9C62-4F3FE604A933z Letter of Guarantee - EvaluationÄäw(\'com.myspace:case02824294:1.0.0-SNAPSHOT','2021-02-24 12:47:33',1,2),(3,'2021-02-24 12:48:21','2021-02-24 12:48:21','LetterOfGuarantee.PerformCredit','¨Ì\0z\0\0\0\0RuleFlow\n\0Jÿ\0Horg.drools.core.marshalling.impl.SerializablePlaceholderResolverStrategy\Zâ¨Ì\0sr\0java.util.ArrayListxÅ“ô«aù\0I\0sizexp\0\0\0w\0\0\0sr\0java.lang.BooleanÕ rÄ’ú˙Ó\0Z\0valuexpsr\0#com.accenture.process.model.Message\0\0\0\0\0\0\0\0L\0messageDatat\0Ljava/lang/Object;L\0\nmessageReft\0Ljava/lang/String;L\0	targetPidt\0Ljava/lang/Long;xpq\0~\0t\0investigationCompletedsr\0java.lang.Long;ã‰êÃè#ﬂ\0J\0valuexr\0java.lang.NumberÜ¨ïî‡ã\0\0xp\0\0\0\0\0\0\0sq\0~\0q\0~\0t\0\rinvestigationq\0~\0xR∏\nRuleFlow\ZLetterOfGuarantee.PerformCredit (	:\n	\"(B\"\nisInvestigationRequested\0\Z\0\0\0\0B\'\nmessage_completeInvestigation\0\Z\0\0\0B\nmessage_investigation\0\Z\0\0\0`\0j%_435CD116-2577-42A8-9861-2E83FCF2F52Cj%_88211E7A-07FB-4325-A457-105692F2F928j%_5AD113E6-6E18-4D19-965D-4E0510BBF98Bj%_976508F1-2DBE-4E7C-952C-4B5FFE5AA41Aj%_60FA66E7-925A-46B6-BE14-0018C2C62140j%_0E0536F0-41F6-478E-8433-2F8DE57BCA2Cj%_2EA6F062-EC9C-4676-B8BA-A53CC41D545Ar)\n%_F9A968F5-0A29-48DE-9C62-4F3FE604A933z Letter of Guarantee - EvaluationÄäw(\'com.myspace:case02824294:1.0.0-SNAPSHOT','2021-02-24 12:48:21',1,2),(4,'2022-05-09 14:29:37','2022-05-09 14:29:37','case03200412.timertest','¨Ì\0z\0\0\0RuleFlow\n4\0Jµ\0Horg.drools.core.marshalling.impl.SerializablePlaceholderResolverStrategy\Zg¨Ì\0sr\0java.util.ArrayListxÅ“ô«aù\0I\0sizexp\0\0\0w\0\0\0t\0\nrhpamAdmint\02022-10-10T20:00:00.000+02:00xR–\nRuleFlow\Zcase03200412.timertest (:(\"\Zˇˇˇˇˇˇˇˇˇ(0ˇˇˇˇˇˇˇˇˇ@\0B\n	initiator\0\Z\0\0\0\0B\n\ntimerAlert\0\Z\0\0\0`ˇˇˇˇˇˇˇˇˇjprocessStartEventj%_1A880863-24AD-4BD1-868C-0EB1CB94FC33j%_68C45378-301C-4B7E-9C87-DB9E8CD14718r)\n%_A8A23F1B-532F-460C-B274-7D17BBDEB4D2z	timertestÄäexample:case03200412:1.0í4òˇˇˇˇˇˇˇˇˇ®\0','2022-05-09 14:26:14',1,4),(5,'2022-05-09 14:53:02','2022-05-09 14:53:02','case03200412.timertest','¨Ì\0z\0\0ö\0RuleFlow\n\0J®\0Horg.drools.core.marshalling.impl.SerializablePlaceholderResolverStrategy\ZZ¨Ì\0sr\0java.util.ArrayListxÅ“ô«aù\0I\0sizexp\0\0\0w\0\0\0t\02022-10-10T20:00:00.000+02:00xR⁄\nRuleFlow\Zcase03200412.timertest (:\n\"(B\n\ntimerAlert\0\Z\0\0\0\0`\0jprocessStartEventj%_1A880863-24AD-4BD1-868C-0EB1CB94FC33r)\n%_68C45378-301C-4B7E-9C87-DB9E8CD14718z	timertestÄäexample:case03200412:1.0','2022-05-09 14:53:02',1,2),(6,'2022-05-09 14:53:50','2022-05-09 14:53:50','case03200412.timertest','¨Ì\0z\0\0«\0RuleFlow\n\0J®\0Horg.drools.core.marshalling.impl.SerializablePlaceholderResolverStrategy\ZZ¨Ì\0sr\0java.util.ArrayListxÅ“ô«aù\0I\0sizexp\0\0\0w\0\0\0t\02022-10-10T20:00:00.000+02:00xRá\nRuleFlow\Zcase03200412.timertest (:\"\Z(B\n\ntimerAlert\0\Z\0\0\0\0`\0jprocessStartEventj%_1A880863-24AD-4BD1-868C-0EB1CB94FC33j%_68C45378-301C-4B7E-9C87-DB9E8CD14718r)\n%_A8A23F1B-532F-460C-B274-7D17BBDEB4D2z	timertestÄäexample:case03200412:1.0','2022-05-09 14:53:19',1,4),(7,'2022-05-09 14:54:05','2022-05-09 14:54:05','case03200412.timertest','¨Ì\0z\0\0«\0RuleFlow\n\0J®\0Horg.drools.core.marshalling.impl.SerializablePlaceholderResolverStrategy\ZZ¨Ì\0sr\0java.util.ArrayListxÅ“ô«aù\0I\0sizexp\0\0\0w\0\0\0t\02022-10-10T20:00:00.000+02:00xRá\nRuleFlow\Zcase03200412.timertest (:\"\Z(B\n\ntimerAlert\0\Z\0\0\0\0`\0jprocessStartEventj%_1A880863-24AD-4BD1-868C-0EB1CB94FC33j%_68C45378-301C-4B7E-9C87-DB9E8CD14718r)\n%_A8A23F1B-532F-460C-B274-7D17BBDEB4D2z	timertestÄäexample:case03200412:1.0','2022-05-09 14:53:26',1,4),(8,'2022-05-09 14:56:35','2022-05-09 14:56:34','case03200412.timertest','¨Ì\0z\0\0Â\0RuleFlow\n4\0Jµ\0Horg.drools.core.marshalling.impl.SerializablePlaceholderResolverStrategy\Zg¨Ì\0sr\0java.util.ArrayListxÅ“ô«aù\0I\0sizexp\0\0\0w\0\0\0t\0\nrhpamAdmint\02022-10-10T20:00:00.000+02:00xRò\nRuleFlow\Zcase03200412.timertest (:\"(0ˇˇˇˇˇˇˇˇˇ@\0B\n	initiator\0\Z\0\0\0\0B\n\ntimerAlert\0\Z\0\0\0`ˇˇˇˇˇˇˇˇˇjprocessStartEventj%_1A880863-24AD-4BD1-868C-0EB1CB94FC33r)\n%_68C45378-301C-4B7E-9C87-DB9E8CD14718z	timertestÄäexample:case03200412:1.0í8òˇˇˇˇˇˇˇˇˇ®\0','2022-05-09 14:56:34',1,2);
/*!40000 ALTER TABLE `ProcessInstanceInfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProcessInstanceLog`
--

DROP TABLE IF EXISTS `ProcessInstanceLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProcessInstanceLog` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `correlationKey` varchar(255) DEFAULT NULL,
  `duration` bigint(20) DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `externalId` varchar(255) DEFAULT NULL,
  `user_identity` varchar(255) DEFAULT NULL,
  `outcome` varchar(255) DEFAULT NULL,
  `parentProcessInstanceId` bigint(20) DEFAULT NULL,
  `processId` varchar(255) DEFAULT NULL,
  `processInstanceDescription` varchar(255) DEFAULT NULL,
  `processInstanceId` bigint(20) NOT NULL,
  `processName` varchar(255) DEFAULT NULL,
  `processVersion` varchar(255) DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `processType` int(11) DEFAULT NULL,
  `slaCompliance` int(11) DEFAULT NULL,
  `sla_due_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_PInstLog_duration` (`duration`),
  KEY `IDX_PInstLog_end_date` (`end_date`),
  KEY `IDX_PInstLog_extId` (`externalId`),
  KEY `IDX_PInstLog_user_identity` (`user_identity`),
  KEY `IDX_PInstLog_outcome` (`outcome`),
  KEY `IDX_PInstLog_parentPInstId` (`parentProcessInstanceId`),
  KEY `IDX_PInstLog_pId` (`processId`),
  KEY `IDX_PInstLog_pInsteDescr` (`processInstanceDescription`),
  KEY `IDX_PInstLog_pInstId` (`processInstanceId`),
  KEY `IDX_PInstLog_pName` (`processName`),
  KEY `IDX_PInstLog_pVersion` (`processVersion`),
  KEY `IDX_PInstLog_start_date` (`start_date`),
  KEY `IDX_PInstLog_status` (`status`),
  KEY `IDX_PInstLog_correlation` (`correlationKey`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProcessInstanceLog`
--

LOCK TABLES `ProcessInstanceLog` WRITE;
/*!40000 ALTER TABLE `ProcessInstanceLog` DISABLE KEYS */;
INSERT INTO `ProcessInstanceLog` VALUES (1,NULL,NULL,NULL,'com.myspace:case02824294:1.0.0-SNAPSHOT','kieserver',NULL,-1,'LetterOfGuarantee.PerformCredit','Letter of Guarantee - Evaluation',1,'Letter of Guarantee - Evaluation','1.0','2021-02-22 23:13:08',1,1,NULL,NULL),(2,NULL,NULL,NULL,'com.myspace:case02824294:1.0.0-SNAPSHOT','kieserver',NULL,-1,'LetterOfGuarantee.PerformCredit','Letter of Guarantee - Evaluation',2,'Letter of Guarantee - Evaluation','1.0','2021-02-24 12:47:33',1,1,NULL,NULL),(3,NULL,NULL,NULL,'com.myspace:case02824294:1.0.0-SNAPSHOT','kieserver',NULL,-1,'LetterOfGuarantee.PerformCredit','Letter of Guarantee - Evaluation',3,'Letter of Guarantee - Evaluation','1.0','2021-02-24 12:48:21',1,1,NULL,NULL),(4,'4',NULL,NULL,'example:case03200412:1.0','rhpamAdmin',NULL,-1,'case03200412.timertest','timertest',4,'timertest','1.0','2022-05-09 14:26:14',1,1,0,NULL),(5,NULL,NULL,NULL,'example:case03200412:1.0','admin',NULL,-1,'case03200412.timertest','timertest',5,'timertest','1.0','2022-05-09 14:53:02',1,NULL,NULL,NULL),(6,NULL,NULL,NULL,'example:case03200412:1.0','admin',NULL,-1,'case03200412.timertest','timertest',6,'timertest','1.0','2022-05-09 14:53:19',1,NULL,NULL,NULL),(7,NULL,NULL,NULL,'example:case03200412:1.0','admin',NULL,-1,'case03200412.timertest','timertest',7,'timertest','1.0','2022-05-09 14:53:26',1,NULL,NULL,NULL),(8,'8',NULL,NULL,'example:case03200412:1.0','rhpamAdmin',NULL,-1,'case03200412.timertest','timertest',8,'timertest','1.0','2022-05-09 14:56:35',1,1,0,NULL);
/*!40000 ALTER TABLE `ProcessInstanceLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_BLOB_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_BLOB_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_BLOB_TRIGGERS` (
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `BLOB_DATA` blob DEFAULT NULL,
  PRIMARY KEY (`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `QRTZ_BLOB_TRIGGERS_ibfk_1` FOREIGN KEY (`TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_BLOB_TRIGGERS`
--

LOCK TABLES `QRTZ_BLOB_TRIGGERS` WRITE;
/*!40000 ALTER TABLE `QRTZ_BLOB_TRIGGERS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_BLOB_TRIGGERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_CALENDARS`
--

DROP TABLE IF EXISTS `QRTZ_CALENDARS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_CALENDARS` (
  `CALENDAR_NAME` varchar(200) NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`CALENDAR_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_CALENDARS`
--

LOCK TABLES `QRTZ_CALENDARS` WRITE;
/*!40000 ALTER TABLE `QRTZ_CALENDARS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_CALENDARS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_CRON_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_CRON_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_CRON_TRIGGERS` (
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `CRON_EXPRESSION` varchar(200) NOT NULL,
  `TIME_ZONE_ID` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `QRTZ_CRON_TRIGGERS_ibfk_1` FOREIGN KEY (`TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_CRON_TRIGGERS`
--

LOCK TABLES `QRTZ_CRON_TRIGGERS` WRITE;
/*!40000 ALTER TABLE `QRTZ_CRON_TRIGGERS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_CRON_TRIGGERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_FIRED_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_FIRED_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_FIRED_TRIGGERS` (
  `ENTRY_ID` varchar(95) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `IS_VOLATILE` varchar(1) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `FIRED_TIME` bigint(13) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `STATE` varchar(16) NOT NULL,
  `JOB_NAME` varchar(200) DEFAULT NULL,
  `JOB_GROUP` varchar(200) DEFAULT NULL,
  `IS_STATEFUL` varchar(1) DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`ENTRY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_FIRED_TRIGGERS`
--

LOCK TABLES `QRTZ_FIRED_TRIGGERS` WRITE;
/*!40000 ALTER TABLE `QRTZ_FIRED_TRIGGERS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_FIRED_TRIGGERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_JOB_DETAILS`
--

DROP TABLE IF EXISTS `QRTZ_JOB_DETAILS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_JOB_DETAILS` (
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) NOT NULL,
  `IS_DURABLE` varchar(1) NOT NULL,
  `IS_VOLATILE` varchar(1) NOT NULL,
  `IS_STATEFUL` varchar(1) NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) NOT NULL,
  `JOB_DATA` blob DEFAULT NULL,
  PRIMARY KEY (`JOB_NAME`,`JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_JOB_DETAILS`
--

LOCK TABLES `QRTZ_JOB_DETAILS` WRITE;
/*!40000 ALTER TABLE `QRTZ_JOB_DETAILS` DISABLE KEYS */;
INSERT INTO `QRTZ_JOB_DETAILS` VALUES ('15-6-1','jbpm',NULL,'org.jbpm.process.core.timer.impl.QuartzSchedulerService$QuartzJob','0','0','0','1','¨Ì\0sr\0org.quartz.JobDataMapü∞ÉËø©∞À\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMapÇË√˚≈](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMapÊ.≠(v\nŒ\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap⁄¡√`—\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0timerJobInstancesr\04org.jbpm.persistence.timer.GlobalJpaTimerJobInstanceµI√ £ò§¬\0L\0timerServiceIdt\0Ljava/lang/String;xr\0.org.drools.persistence.jpa.JpaTimerJobInstanceÌπÄw!Õ\'\0\0xr\01org.drools.core.time.impl.DefaultTimerJobInstance¬]Á€Ñq\0L\0ctxt\0!Lorg/drools/core/time/JobContext;L\0handlet\0 Lorg/drools/core/time/JobHandle;L\0jobt\0\ZLorg/drools/core/time/Job;L\0triggert\0Lorg/drools/core/time/Trigger;xpsr\0*org.drools.core.time.SelfRemovalJobContextÜ·-ì Jƒ\0L\0\njobContextq\0~\0L\0timerInstancesq\0~\0xpsr\0>org.jbpm.process.instance.timer.TimerManager$ProcessJobContextûˇ	J”ª\0Z\0newTimerL\0	jobHandleq\0~\0\rL\0processInstanceIdt\0Ljava/lang/Long;L\0	sessionIdq\0~\0L\0timert\0/Lorg/jbpm/process/instance/timer/TimerInstance;L\0triggerq\0~\0xpsr\0Morg.jbpm.process.core.timer.impl.QuartzSchedulerService$GlobalQuartzJobHandle\0\0\0\0\0\0˛\0L\0jobGroupq\0~\0	L\0jobNameq\0~\0	xr\0Corg.jbpm.process.core.timer.impl.GlobalTimerService$GlobalJobHandle\0\0\0\0\0\0˛\0\0xr\0*org.drools.core.time.impl.DefaultJobHandle\0\0\0\0\0\0˛\0J\0idL\0cancelt\0+Ljava/util/concurrent/atomic/AtomicBoolean;L\0timerJobInstancet\0,Lorg/drools/core/time/impl/TimerJobInstance;xp\0\0\0\0\0\0\0\0sr\0)java.util.concurrent.atomic.AtomicBoolean@ò∑\nO?¸3\0I\0valuexp\0\0\0\0q\0~\0t\0jbpmt\015-6-1sr\0java.lang.Long;ã‰êÃè#ﬂ\0J\0valuexr\0java.lang.NumberÜ¨ïî‡ã\0\0xp\0\0\0\0\0\0\0sq\0~\0!\0\0\0\0\0\0\0sr\0-org.jbpm.process.instance.timer.TimerInstance#sK9Õp;\0J\0delayJ\0idJ\0periodJ\0processInstanceIdI\0repeatLimitJ\0	sessionIdJ\0timerIdL\0	activatedt\0Ljava/util/Date;L\0cronExpressionq\0~\0	L\0	jobHandleq\0~\0\rL\0\rlastTriggeredq\0~\0&xp\0\0\0t.Ô\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ˇˇˇˇ\0\0\0\0\0\0\0\0\0\0\0\0\0\0sr\0java.util.DatehjÅKYt\0\0xpw\0\0Ä™ôäxpppsr\0)org.drools.core.time.impl.IntervalTriggerÏÚyƒÄ$…\0J\0delayJ\0periodI\0repeatCountI\0repeatLimit[\0\rcalendarNamest\0[Ljava/lang/String;L\0	calendarst\0Lorg/kie/api/runtime/Calendars;L\0createdTimeq\0~\0&L\0endTimeq\0~\0&L\0lastFireTimeq\0~\0&L\0nextFireTimeq\0~\0&L\0	startTimeq\0~\0&xp\0\0\0t.Ô\0\0\0\0\0\0\0\0\0\0\0ˇˇˇˇppsq\0~\0(w\0\0Ä™ôäxppsq\0~\0(w\0\0É√\rπxsq\0~\0(w\0\0Ä™ôäxsq\0~\0?@\0\0\0\0\0\0w\0\0\0\0\0\0\0xq\0~\0sr\0#org.drools.core.time.SelfRemovalJob{/åˇ§w?\0L\0jobq\0~\0xpsr\07org.jbpm.process.instance.timer.TimerManager$ProcessJobSUyza<ŒV\0\0xpq\0~\0-t\0\'example:case03200412:1.0-timerServiceIdx\0'),('16-7-1','jbpm',NULL,'org.jbpm.process.core.timer.impl.QuartzSchedulerService$QuartzJob','0','0','0','1','¨Ì\0sr\0org.quartz.JobDataMapü∞ÉËø©∞À\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMapÇË√˚≈](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMapÊ.≠(v\nŒ\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap⁄¡√`—\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0timerJobInstancesr\04org.jbpm.persistence.timer.GlobalJpaTimerJobInstanceµI√ £ò§¬\0L\0timerServiceIdt\0Ljava/lang/String;xr\0.org.drools.persistence.jpa.JpaTimerJobInstanceÌπÄw!Õ\'\0\0xr\01org.drools.core.time.impl.DefaultTimerJobInstance¬]Á€Ñq\0L\0ctxt\0!Lorg/drools/core/time/JobContext;L\0handlet\0 Lorg/drools/core/time/JobHandle;L\0jobt\0\ZLorg/drools/core/time/Job;L\0triggert\0Lorg/drools/core/time/Trigger;xpsr\0*org.drools.core.time.SelfRemovalJobContextÜ·-ì Jƒ\0L\0\njobContextq\0~\0L\0timerInstancesq\0~\0xpsr\0>org.jbpm.process.instance.timer.TimerManager$ProcessJobContextûˇ	J”ª\0Z\0newTimerL\0	jobHandleq\0~\0\rL\0processInstanceIdt\0Ljava/lang/Long;L\0	sessionIdq\0~\0L\0timert\0/Lorg/jbpm/process/instance/timer/TimerInstance;L\0triggerq\0~\0xpsr\0Morg.jbpm.process.core.timer.impl.QuartzSchedulerService$GlobalQuartzJobHandle\0\0\0\0\0\0˛\0L\0jobGroupq\0~\0	L\0jobNameq\0~\0	xr\0Corg.jbpm.process.core.timer.impl.GlobalTimerService$GlobalJobHandle\0\0\0\0\0\0˛\0\0xr\0*org.drools.core.time.impl.DefaultJobHandle\0\0\0\0\0\0˛\0J\0idL\0cancelt\0+Ljava/util/concurrent/atomic/AtomicBoolean;L\0timerJobInstancet\0,Lorg/drools/core/time/impl/TimerJobInstance;xp\0\0\0\0\0\0\0sr\0)java.util.concurrent.atomic.AtomicBoolean@ò∑\nO?¸3\0I\0valuexp\0\0\0\0q\0~\0t\0jbpmt\016-7-1sr\0java.lang.Long;ã‰êÃè#ﬂ\0J\0valuexr\0java.lang.NumberÜ¨ïî‡ã\0\0xp\0\0\0\0\0\0\0sq\0~\0!\0\0\0\0\0\0\0sr\0-org.jbpm.process.instance.timer.TimerInstance#sK9Õp;\0J\0delayJ\0idJ\0periodJ\0processInstanceIdI\0repeatLimitJ\0	sessionIdJ\0timerIdL\0	activatedt\0Ljava/util/Date;L\0cronExpressionq\0~\0	L\0	jobHandleq\0~\0\rL\0\rlastTriggeredq\0~\0&xp\0\0\0sˆ˜\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ˇˇˇˇ\0\0\0\0\0\0\0\0\0\0\0\0\0\0sr\0java.util.DatehjÅKYt\0\0xpw\0\0Ä™ô¬	xpppsr\0)org.drools.core.time.impl.IntervalTriggerÏÚyƒÄ$…\0J\0delayJ\0periodI\0repeatCountI\0repeatLimit[\0\rcalendarNamest\0[Ljava/lang/String;L\0	calendarst\0Lorg/kie/api/runtime/Calendars;L\0createdTimeq\0~\0&L\0endTimeq\0~\0&L\0lastFireTimeq\0~\0&L\0nextFireTimeq\0~\0&L\0	startTimeq\0~\0&xp\0\0\0sˆ˜\0\0\0\0\0\0\0\0\0\0\0ˇˇˇˇppsq\0~\0(w\0\0Ä™ô¬	xppsq\0~\0(w\0\0É√\rπ\0xsq\0~\0(w\0\0Ä™ô¬	xsq\0~\0?@\0\0\0\0\0\0w\0\0\0\0\0\0\0xq\0~\0sr\0#org.drools.core.time.SelfRemovalJob{/åˇ§w?\0L\0jobq\0~\0xpsr\07org.jbpm.process.instance.timer.TimerManager$ProcessJobSUyza<ŒV\0\0xpq\0~\0-t\0\'example:case03200412:1.0-timerServiceIdx\0'),('4-2-1','jbpm',NULL,'org.jbpm.process.core.timer.impl.QuartzSchedulerService$QuartzJob','0','0','0','1','¨Ì\0sr\0org.quartz.JobDataMapü∞ÉËø©∞À\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMapÇË√˚≈](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMapÊ.≠(v\nŒ\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap⁄¡√`—\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0timerJobInstancesr\04org.jbpm.persistence.timer.GlobalJpaTimerJobInstanceµI√ £ò§¬\0L\0timerServiceIdt\0Ljava/lang/String;xr\0.org.drools.persistence.jpa.JpaTimerJobInstanceÌπÄw!Õ\'\0\0xr\01org.drools.core.time.impl.DefaultTimerJobInstance¬]Á€Ñq\0L\0ctxt\0!Lorg/drools/core/time/JobContext;L\0handlet\0 Lorg/drools/core/time/JobHandle;L\0jobt\0\ZLorg/drools/core/time/Job;L\0triggert\0Lorg/drools/core/time/Trigger;xpsr\0*org.drools.core.time.SelfRemovalJobContextÜ·-ì Jƒ\0L\0\njobContextq\0~\0L\0timerInstancesq\0~\0xpsr\0>org.jbpm.process.instance.timer.TimerManager$ProcessJobContextûˇ	J”ª\0Z\0newTimerL\0	jobHandleq\0~\0\rL\0processInstanceIdt\0Ljava/lang/Long;L\0	sessionIdq\0~\0L\0timert\0/Lorg/jbpm/process/instance/timer/TimerInstance;L\0triggerq\0~\0xpsr\0Morg.jbpm.process.core.timer.impl.QuartzSchedulerService$GlobalQuartzJobHandle\0\0\0\0\0\0˛\0L\0jobGroupq\0~\0	L\0jobNameq\0~\0	xr\0Corg.jbpm.process.core.timer.impl.GlobalTimerService$GlobalJobHandle\0\0\0\0\0\0˛\0\0xr\0*org.drools.core.time.impl.DefaultJobHandle\0\0\0\0\0\0˛\0J\0idL\0cancelt\0+Ljava/util/concurrent/atomic/AtomicBoolean;L\0timerJobInstancet\0,Lorg/drools/core/time/impl/TimerJobInstance;xp\0\0\0\0\0\0\0sr\0)java.util.concurrent.atomic.AtomicBoolean@ò∑\nO?¸3\0I\0valuexp\0\0\0\0q\0~\0t\0jbpmt\04-2-1sr\0java.lang.Long;ã‰êÃè#ﬂ\0J\0valuexr\0java.lang.NumberÜ¨ïî‡ã\0\0xp\0\0\0\0\0\0\0sq\0~\0!\0\0\0\0\0\0\0sr\0-org.jbpm.process.instance.timer.TimerInstance#sK9Õp;\0J\0delayJ\0idJ\0periodJ\0processInstanceIdI\0repeatLimitJ\0	sessionIdJ\0timerIdL\0	activatedt\0Ljava/util/Date;L\0cronExpressionq\0~\0	L\0	jobHandleq\0~\0\rL\0\rlastTriggeredq\0~\0&xp\0\0\0\0ﬂ&ú\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ˇˇˇˇ\0\0\0\0\0\0\0\0\0\0\0\0\0\0sr\0java.util.DatehjÅKYt\0\0xpw\0\0Ä™Añdxpppsr\0)org.drools.core.time.impl.IntervalTriggerÏÚyƒÄ$…\0J\0delayJ\0periodI\0repeatCountI\0repeatLimit[\0\rcalendarNamest\0[Ljava/lang/String;L\0	calendarst\0Lorg/kie/api/runtime/Calendars;L\0createdTimeq\0~\0&L\0endTimeq\0~\0&L\0lastFireTimeq\0~\0&L\0nextFireTimeq\0~\0&L\0	startTimeq\0~\0&xp\0\0\0\0ﬂ&ú\0\0\0\0\0\0\0\0\0\0\0ˇˇˇˇppsq\0~\0(w\0\0Ä™Añdxppsq\0~\0(w\0\0ÄØ Ω\0xsq\0~\0(w\0\0Ä™Añdxsq\0~\0?@\0\0\0\0\0\0w\0\0\0\0\0\0\0xq\0~\0sr\0#org.drools.core.time.SelfRemovalJob{/åˇ§w?\0L\0jobq\0~\0xpsr\07org.jbpm.process.instance.timer.TimerManager$ProcessJobSUyza<ŒV\0\0xpq\0~\0-t\0\'example:case03200412:1.0-timerServiceIdx\0'),('6-4-1','jbpm',NULL,'org.jbpm.process.core.timer.impl.QuartzSchedulerService$QuartzJob','0','0','0','1','¨Ì\0sr\0org.quartz.JobDataMapü∞ÉËø©∞À\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMapÇË√˚≈](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMapÊ.≠(v\nŒ\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap⁄¡√`—\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0timerJobInstancesr\04org.jbpm.persistence.timer.GlobalJpaTimerJobInstanceµI√ £ò§¬\0L\0timerServiceIdt\0Ljava/lang/String;xr\0.org.drools.persistence.jpa.JpaTimerJobInstanceÌπÄw!Õ\'\0\0xr\01org.drools.core.time.impl.DefaultTimerJobInstance¬]Á€Ñq\0L\0ctxt\0!Lorg/drools/core/time/JobContext;L\0handlet\0 Lorg/drools/core/time/JobHandle;L\0jobt\0\ZLorg/drools/core/time/Job;L\0triggert\0Lorg/drools/core/time/Trigger;xpsr\0*org.drools.core.time.SelfRemovalJobContextÜ·-ì Jƒ\0L\0\njobContextq\0~\0L\0timerInstancesq\0~\0xpsr\0>org.jbpm.process.instance.timer.TimerManager$ProcessJobContextûˇ	J”ª\0Z\0newTimerL\0	jobHandleq\0~\0\rL\0processInstanceIdt\0Ljava/lang/Long;L\0	sessionIdq\0~\0L\0timert\0/Lorg/jbpm/process/instance/timer/TimerInstance;L\0triggerq\0~\0xpsr\0Morg.jbpm.process.core.timer.impl.QuartzSchedulerService$GlobalQuartzJobHandle\0\0\0\0\0\0˛\0L\0jobGroupq\0~\0	L\0jobNameq\0~\0	xr\0Corg.jbpm.process.core.timer.impl.GlobalTimerService$GlobalJobHandle\0\0\0\0\0\0˛\0\0xr\0*org.drools.core.time.impl.DefaultJobHandle\0\0\0\0\0\0˛\0J\0idL\0cancelt\0+Ljava/util/concurrent/atomic/AtomicBoolean;L\0timerJobInstancet\0,Lorg/drools/core/time/impl/TimerJobInstance;xp\0\0\0\0\0\0\0sr\0)java.util.concurrent.atomic.AtomicBoolean@ò∑\nO?¸3\0I\0valuexp\0\0\0\0q\0~\0t\0jbpmt\06-4-1sr\0java.lang.Long;ã‰êÃè#ﬂ\0J\0valuexr\0java.lang.NumberÜ¨ïî‡ã\0\0xp\0\0\0\0\0\0\0sq\0~\0!\0\0\0\0\0\0\0sr\0-org.jbpm.process.instance.timer.TimerInstance#sK9Õp;\0J\0delayJ\0idJ\0periodJ\0processInstanceIdI\0repeatLimitJ\0	sessionIdJ\0timerIdL\0	activatedt\0Ljava/util/Date;L\0cronExpressionq\0~\0	L\0	jobHandleq\0~\0\rL\0\rlastTriggeredq\0~\0&xp\0\0\0\035üW\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ˇˇˇˇ\0\0\0\0\0\0\0\0\0\0\0\0\0\0sr\0java.util.DatehjÅKYt\0\0xpw\0\0Ä™DY©xpppsr\0)org.drools.core.time.impl.IntervalTriggerÏÚyƒÄ$…\0J\0delayJ\0periodI\0repeatCountI\0repeatLimit[\0\rcalendarNamest\0[Ljava/lang/String;L\0	calendarst\0Lorg/kie/api/runtime/Calendars;L\0createdTimeq\0~\0&L\0endTimeq\0~\0&L\0lastFireTimeq\0~\0&L\0nextFireTimeq\0~\0&L\0	startTimeq\0~\0&xp\0\0\0\035üW\0\0\0\0\0\0\0\0\0\0\0ˇˇˇˇppsq\0~\0(w\0\0Ä™DY©xppsq\0~\0(w\0\0Ä›y˘\0xsq\0~\0(w\0\0Ä™DY©xsq\0~\0?@\0\0\0\0\0\0w\0\0\0\0\0\0\0xq\0~\0sr\0#org.drools.core.time.SelfRemovalJob{/åˇ§w?\0L\0jobq\0~\0xpsr\07org.jbpm.process.instance.timer.TimerManager$ProcessJobSUyza<ŒV\0\0xpq\0~\0-t\0\'example:case03200412:1.0-timerServiceIdx\0'),('8-6-1','jbpm',NULL,'org.jbpm.process.core.timer.impl.QuartzSchedulerService$QuartzJob','0','0','0','1','¨Ì\0sr\0org.quartz.JobDataMapü∞ÉËø©∞À\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMapÇË√˚≈](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMapÊ.≠(v\nŒ\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap⁄¡√`—\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0timerJobInstancesr\04org.jbpm.persistence.timer.GlobalJpaTimerJobInstanceµI√ £ò§¬\0L\0timerServiceIdt\0Ljava/lang/String;xr\0.org.drools.persistence.jpa.JpaTimerJobInstanceÌπÄw!Õ\'\0\0xr\01org.drools.core.time.impl.DefaultTimerJobInstance¬]Á€Ñq\0L\0ctxt\0!Lorg/drools/core/time/JobContext;L\0handlet\0 Lorg/drools/core/time/JobHandle;L\0jobt\0\ZLorg/drools/core/time/Job;L\0triggert\0Lorg/drools/core/time/Trigger;xpsr\0*org.drools.core.time.SelfRemovalJobContextÜ·-ì Jƒ\0L\0\njobContextq\0~\0L\0timerInstancesq\0~\0xpsr\0>org.jbpm.process.instance.timer.TimerManager$ProcessJobContextûˇ	J”ª\0Z\0newTimerL\0	jobHandleq\0~\0\rL\0processInstanceIdt\0Ljava/lang/Long;L\0	sessionIdq\0~\0L\0timert\0/Lorg/jbpm/process/instance/timer/TimerInstance;L\0triggerq\0~\0xpsr\0Morg.jbpm.process.core.timer.impl.QuartzSchedulerService$GlobalQuartzJobHandle\0\0\0\0\0\0˛\0L\0jobGroupq\0~\0	L\0jobNameq\0~\0	xr\0Corg.jbpm.process.core.timer.impl.GlobalTimerService$GlobalJobHandle\0\0\0\0\0\0˛\0\0xr\0*org.drools.core.time.impl.DefaultJobHandle\0\0\0\0\0\0˛\0J\0idL\0cancelt\0+Ljava/util/concurrent/atomic/AtomicBoolean;L\0timerJobInstancet\0,Lorg/drools/core/time/impl/TimerJobInstance;xp\0\0\0\0\0\0\0sr\0)java.util.concurrent.atomic.AtomicBoolean@ò∑\nO?¸3\0I\0valuexp\0\0\0\0q\0~\0t\0jbpmt\08-6-1sr\0java.lang.Long;ã‰êÃè#ﬂ\0J\0valuexr\0java.lang.NumberÜ¨ïî‡ã\0\0xp\0\0\0\0\0\0\0sq\0~\0!\0\0\0\0\0\0\0sr\0-org.jbpm.process.instance.timer.TimerInstance#sK9Õp;\0J\0delayJ\0idJ\0periodJ\0processInstanceIdI\0repeatLimitJ\0	sessionIdJ\0timerIdL\0	activatedt\0Ljava/util/Date;L\0cronExpressionq\0~\0	L\0	jobHandleq\0~\0\rL\0\rlastTriggeredq\0~\0&xp\0\0\0yÅ4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ˇˇˇˇ\0\0\0\0\0\0\0\0\0\0\0\0\0\0sr\0java.util.DatehjÅKYt\0\0xpw\0\0Ä™IÃxpppsr\0)org.drools.core.time.impl.IntervalTriggerÏÚyƒÄ$…\0J\0delayJ\0periodI\0repeatCountI\0repeatLimit[\0\rcalendarNamest\0[Ljava/lang/String;L\0	calendarst\0Lorg/kie/api/runtime/Calendars;L\0createdTimeq\0~\0&L\0endTimeq\0~\0&L\0lastFireTimeq\0~\0&L\0nextFireTimeq\0~\0&L\0	startTimeq\0~\0&xp\0\0\0yÅ4\0\0\0\0\0\0\0\0\0\0\0ˇˇˇˇppsq\0~\0(w\0\0Ä™IÃxppsq\0~\0(w\0\0É#hï\0xsq\0~\0(w\0\0Ä™IÃxsq\0~\0?@\0\0\0\0\0\0w\0\0\0\0\0\0\0xq\0~\0sr\0#org.drools.core.time.SelfRemovalJob{/åˇ§w?\0L\0jobq\0~\0xpsr\07org.jbpm.process.instance.timer.TimerManager$ProcessJobSUyza<ŒV\0\0xpq\0~\0-t\0\'example:case03200412:1.0-timerServiceIdx\0');
/*!40000 ALTER TABLE `QRTZ_JOB_DETAILS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_JOB_LISTENERS`
--

DROP TABLE IF EXISTS `QRTZ_JOB_LISTENERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_JOB_LISTENERS` (
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `JOB_LISTENER` varchar(200) NOT NULL,
  PRIMARY KEY (`JOB_NAME`,`JOB_GROUP`,`JOB_LISTENER`),
  CONSTRAINT `QRTZ_JOB_LISTENERS_ibfk_1` FOREIGN KEY (`JOB_NAME`, `JOB_GROUP`) REFERENCES `QRTZ_JOB_DETAILS` (`JOB_NAME`, `JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_JOB_LISTENERS`
--

LOCK TABLES `QRTZ_JOB_LISTENERS` WRITE;
/*!40000 ALTER TABLE `QRTZ_JOB_LISTENERS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_JOB_LISTENERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_LOCKS`
--

DROP TABLE IF EXISTS `QRTZ_LOCKS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_LOCKS` (
  `LOCK_NAME` varchar(40) NOT NULL,
  PRIMARY KEY (`LOCK_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_LOCKS`
--

LOCK TABLES `QRTZ_LOCKS` WRITE;
/*!40000 ALTER TABLE `QRTZ_LOCKS` DISABLE KEYS */;
INSERT INTO `QRTZ_LOCKS` VALUES ('CALENDAR_ACCESS'),('JOB_ACCESS'),('MISFIRE_ACCESS'),('STATE_ACCESS'),('TRIGGER_ACCESS');
/*!40000 ALTER TABLE `QRTZ_LOCKS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_PAUSED_TRIGGER_GRPS`
--

DROP TABLE IF EXISTS `QRTZ_PAUSED_TRIGGER_GRPS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_PAUSED_TRIGGER_GRPS` (
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  PRIMARY KEY (`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_PAUSED_TRIGGER_GRPS`
--

LOCK TABLES `QRTZ_PAUSED_TRIGGER_GRPS` WRITE;
/*!40000 ALTER TABLE `QRTZ_PAUSED_TRIGGER_GRPS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_PAUSED_TRIGGER_GRPS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_SCHEDULER_STATE`
--

DROP TABLE IF EXISTS `QRTZ_SCHEDULER_STATE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_SCHEDULER_STATE` (
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL,
  PRIMARY KEY (`INSTANCE_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_SCHEDULER_STATE`
--

LOCK TABLES `QRTZ_SCHEDULER_STATE` WRITE;
/*!40000 ALTER TABLE `QRTZ_SCHEDULER_STATE` DISABLE KEYS */;
INSERT INTO `QRTZ_SCHEDULER_STATE` VALUES ('mweiler1652129364449',1652129646499,40000),('mweiler1652129376172',1652129658216,40000);
/*!40000 ALTER TABLE `QRTZ_SCHEDULER_STATE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_SIMPLE_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_SIMPLE_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_SIMPLE_TRIGGERS` (
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `REPEAT_COUNT` bigint(7) NOT NULL,
  `REPEAT_INTERVAL` bigint(12) NOT NULL,
  `TIMES_TRIGGERED` bigint(10) NOT NULL,
  PRIMARY KEY (`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `QRTZ_SIMPLE_TRIGGERS_ibfk_1` FOREIGN KEY (`TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_SIMPLE_TRIGGERS`
--

LOCK TABLES `QRTZ_SIMPLE_TRIGGERS` WRITE;
/*!40000 ALTER TABLE `QRTZ_SIMPLE_TRIGGERS` DISABLE KEYS */;
INSERT INTO `QRTZ_SIMPLE_TRIGGERS` VALUES ('15-6-1_trigger','jbpm',0,0,0),('16-7-1_trigger','jbpm',0,0,0),('4-2-1_trigger','jbpm',0,0,0),('6-4-1_trigger','jbpm',0,0,0),('8-6-1_trigger','jbpm',0,0,0);
/*!40000 ALTER TABLE `QRTZ_SIMPLE_TRIGGERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_TRIGGERS` (
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `IS_VOLATILE` varchar(1) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) NOT NULL,
  `TRIGGER_TYPE` varchar(8) NOT NULL,
  `START_TIME` bigint(13) NOT NULL,
  `END_TIME` bigint(13) DEFAULT NULL,
  `CALENDAR_NAME` varchar(200) DEFAULT NULL,
  `MISFIRE_INSTR` smallint(2) DEFAULT NULL,
  `JOB_DATA` blob DEFAULT NULL,
  PRIMARY KEY (`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `JOB_NAME` (`JOB_NAME`,`JOB_GROUP`),
  CONSTRAINT `QRTZ_TRIGGERS_ibfk_1` FOREIGN KEY (`JOB_NAME`, `JOB_GROUP`) REFERENCES `QRTZ_JOB_DETAILS` (`JOB_NAME`, `JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_TRIGGERS`
--

LOCK TABLES `QRTZ_TRIGGERS` WRITE;
/*!40000 ALTER TABLE `QRTZ_TRIGGERS` DISABLE KEYS */;
INSERT INTO `QRTZ_TRIGGERS` VALUES ('15-6-1_trigger','jbpm','15-6-1','jbpm','0',NULL,1665424800001,-1,5,'WAITING','SIMPLE',1665424800001,0,NULL,0,''),('16-7-1_trigger','jbpm','16-7-1','jbpm','0',NULL,1665424800000,-1,5,'WAITING','SIMPLE',1665424800000,0,NULL,0,''),('4-2-1_trigger','jbpm','4-2-1','jbpm','0',NULL,1652205600000,-1,5,'WAITING','SIMPLE',1652205600000,0,NULL,0,''),('6-4-1_trigger','jbpm','6-4-1','jbpm','0',NULL,1652983200000,-1,5,'WAITING','SIMPLE',1652983200000,0,NULL,0,''),('8-6-1_trigger','jbpm','8-6-1','jbpm','0',NULL,1662746400000,-1,5,'WAITING','SIMPLE',1662746400000,0,NULL,0,'');
/*!40000 ALTER TABLE `QRTZ_TRIGGERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_TRIGGER_LISTENERS`
--

DROP TABLE IF EXISTS `QRTZ_TRIGGER_LISTENERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_TRIGGER_LISTENERS` (
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `TRIGGER_LISTENER` varchar(200) NOT NULL,
  PRIMARY KEY (`TRIGGER_NAME`,`TRIGGER_GROUP`,`TRIGGER_LISTENER`),
  CONSTRAINT `QRTZ_TRIGGER_LISTENERS_ibfk_1` FOREIGN KEY (`TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_TRIGGER_LISTENERS`
--

LOCK TABLES `QRTZ_TRIGGER_LISTENERS` WRITE;
/*!40000 ALTER TABLE `QRTZ_TRIGGER_LISTENERS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_TRIGGER_LISTENERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QueryDefinitionStore`
--

DROP TABLE IF EXISTS `QueryDefinitionStore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QueryDefinitionStore` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `qExpression` longtext DEFAULT NULL,
  `qName` varchar(255) DEFAULT NULL,
  `qSource` varchar(255) DEFAULT NULL,
  `qTarget` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_4ry5gt77jvq0orfttsoghta2j` (`qName`),
  UNIQUE KEY `UK_1dmy087nhbykucpgjipcnyluv` (`qName`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QueryDefinitionStore`
--

LOCK TABLES `QueryDefinitionStore` WRITE;
/*!40000 ALTER TABLE `QueryDefinitionStore` DISABLE KEYS */;
INSERT INTO `QueryDefinitionStore` VALUES (2,'select t.activationTime, t.actualOwner, t.createdBy, t.createdOn, t.deploymentId, t.description, t.dueDate, t.name, t.parentId, t.priority, t.processId, t.processInstanceId, t.processSessionId, t.status, t.taskId, t.workItemId, oe.id from AuditTaskImpl t, PeopleAssignments_PotOwners po, OrganizationalEntity oe where t.taskId = po.task_id and po.entity_id = oe.id','jbpmHumanTasksWithUser','java:jboss/datasources/mysqlpamDS','CUSTOM'),(3,'select t.activationTime, t.actualOwner, t.createdBy, t.createdOn, t.deploymentId, t.description, t.dueDate, t.name, t.parentId, t.priority, t.processId, t.processInstanceId, t.processSessionId, t.status, t.taskId, t.workItemId, oe.id from AuditTaskImpl t, PeopleAssignments_BAs bas, OrganizationalEntity oe where t.taskId = bas.task_id and bas.entity_id = oe.id','jbpmHumanTasksWithAdmin','java:jboss/datasources/mysqlpamDS','CUSTOM'),(4,'select tvi.taskId, (select ati.name from AuditTaskImpl ati where ati.taskId = tvi.taskId) as \"TASKNAME\", tvi.name, tvi.value from TaskVariableImpl tvi','jbpmHumanTasksWithVariables','java:jboss/datasources/mysqlpamDS','CUSTOM'),(5,'select p.processName, p.externalId, t.* from ProcessInstanceLog p inner join BAMTaskSummary t on (t.processInstanceId = p.processInstanceId) inner join (select min(pk) as pk from BAMTaskSummary group by taskId) d on t.pk = d.pk','tasksMonitoring','java:jboss/datasources/mysqlpamDS','CUSTOM');
/*!40000 ALTER TABLE `QueryDefinitionStore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reassignment`
--

DROP TABLE IF EXISTS `Reassignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Reassignment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Escalation_Reassignments_Id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_pnpeue9hs6kx2ep0sp16b6kfd` (`Escalation_Reassignments_Id`),
  KEY `IDX_Reassign_Esc` (`Escalation_Reassignments_Id`),
  CONSTRAINT `FK_pnpeue9hs6kx2ep0sp16b6kfd` FOREIGN KEY (`Escalation_Reassignments_Id`) REFERENCES `Escalation` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reassignment`
--

LOCK TABLES `Reassignment` WRITE;
/*!40000 ALTER TABLE `Reassignment` DISABLE KEYS */;
/*!40000 ALTER TABLE `Reassignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reassignment_potentialOwners`
--

DROP TABLE IF EXISTS `Reassignment_potentialOwners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Reassignment_potentialOwners` (
  `task_id` bigint(20) NOT NULL,
  `entity_id` varchar(255) NOT NULL,
  KEY `FK_8frl6la7tgparlnukhp8xmody` (`entity_id`),
  KEY `FK_qbega5ncu6b9yigwlw55aeijn` (`task_id`),
  KEY `IDX_ReassignPO_Entity` (`entity_id`),
  KEY `IDX_ReassignPO_Task` (`task_id`),
  CONSTRAINT `FK_8frl6la7tgparlnukhp8xmody` FOREIGN KEY (`entity_id`) REFERENCES `OrganizationalEntity` (`id`),
  CONSTRAINT `FK_qbega5ncu6b9yigwlw55aeijn` FOREIGN KEY (`task_id`) REFERENCES `Reassignment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reassignment_potentialOwners`
--

LOCK TABLES `Reassignment_potentialOwners` WRITE;
/*!40000 ALTER TABLE `Reassignment_potentialOwners` DISABLE KEYS */;
/*!40000 ALTER TABLE `Reassignment_potentialOwners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RequestInfo`
--

DROP TABLE IF EXISTS `RequestInfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RequestInfo` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `commandName` varchar(255) DEFAULT NULL,
  `deploymentId` varchar(255) DEFAULT NULL,
  `executions` int(11) NOT NULL,
  `businessKey` varchar(255) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `owner` varchar(255) DEFAULT NULL,
  `priority` int(11) NOT NULL,
  `requestData` longblob DEFAULT NULL,
  `responseData` longblob DEFAULT NULL,
  `retries` int(11) NOT NULL,
  `status` varchar(255) DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `processInstanceId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_RequestInfo_status` (`status`),
  KEY `IDX_RequestInfo_timestamp` (`timestamp`),
  KEY `IDX_RequestInfo_owner` (`owner`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RequestInfo`
--

LOCK TABLES `RequestInfo` WRITE;
/*!40000 ALTER TABLE `RequestInfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `RequestInfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SessionInfo`
--

DROP TABLE IF EXISTS `SessionInfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SessionInfo` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `lastModificationDate` datetime DEFAULT NULL,
  `rulesByteArray` longblob DEFAULT NULL,
  `startDate` datetime DEFAULT NULL,
  `OPTLOCK` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SessionInfo`
--

LOCK TABLES `SessionInfo` WRITE;
/*!40000 ALTER TABLE `SessionInfo` DISABLE KEYS */;
INSERT INTO `SessionInfo` VALUES (1,'2021-09-24 08:47:15','¨Ì\0w|\n\0Rr\0\0\Zh\0 \02\0\0B#\Z\nMAIN\0 \0(ˇˇˇˇˇˇˇˇˇ@\0\"\nMAINR5\nDEFAULT\"*\n&org.drools.core.reteoo.InitialFactImpl\0\"h\0','2021-02-22 23:12:55',4),(3,'2021-02-22 23:13:08','¨Ì\0w|\n\0Rr\0\0\Zh\0 \02\0\0B#\Z\nMAIN\0 \0(ˇˇˇˇˇˇˇˇˇ@\0\"\nMAINR5\nDEFAULT\"*\n&org.drools.core.reteoo.InitialFactImpl\0\"h\0','2021-02-22 23:13:07',2),(5,'2021-02-24 12:47:33','¨Ì\0w|\n\0Rr\0\0\Zh\0 \02\0\0B#\Z\nMAIN\0 \0(ˇˇˇˇˇˇˇˇˇ@\0\"\nMAINR5\nDEFAULT\"*\n&org.drools.core.reteoo.InitialFactImpl\0\"h\0','2021-02-24 12:47:33',2),(6,'2021-02-24 12:48:21','¨Ì\0w|\n\0Rr\0\0\Zh\0 \02\0\0B#\Z\nMAIN\0 \0(ˇˇˇˇˇˇˇˇˇ@\0\"\nMAINR5\nDEFAULT\"*\n&org.drools.core.reteoo.InitialFactImpl\0\"h\0','2021-02-24 12:48:21',2),(8,'2022-01-10 11:23:06','¨Ì\0w|\n\0Rr\0\0\Zh\0 \02\0\0B#\Z\nMAIN\0 \0(ˇˇˇˇˇˇˇˇˇ@\0\"\nMAINR5\nDEFAULT\"*\n&org.drools.core.reteoo.InitialFactImpl\0\"h\0','2022-01-10 11:23:05',2),(10,'2022-05-09 14:29:37','¨Ì\0w∞\n4\0R•\0\0\Z<\0 \02\0\0B#\Z\nMAIN\0 \0(ˇˇˇˇˇˇˇˇˇ@\0\"\nMAINR	\nDEFAULT\"h*]\n[¢V\n1¥∫©ƒ1 \0(0Õ∑ç‘ä0H\nPˇˇˇˇˇˇˇˇˇZ\rdo something-!\ZŒ∑ç‘ä0ˇˇˇˇˇˇˇˇˇ 0ÇÚ∂òº08\0','2022-05-09 14:26:14',4),(11,NULL,'¨Ì\0w|\n\0Rr\0\0\Zh\0 \02\0\0B#\Z\nMAIN\0 \0(ˇˇˇˇˇˇˇˇˇ@\0\"\nMAINR5\nDEFAULT\"*\n&org.drools.core.reteoo.InitialFactImpl\0\"h\0','2022-05-09 14:39:50',1),(14,'2022-05-09 14:53:02','¨Ì\0w|\n\0Rr\0\0\Zh\0 \02\0\0B#\Z\nMAIN\0 \0(ˇˇˇˇˇˇˇˇˇ@\0\"\nMAINR5\nDEFAULT\"*\n&org.drools.core.reteoo.InitialFactImpl\0\"h\0','2022-05-09 14:53:02',2),(15,'2022-05-09 14:53:50','¨Ì\0w¬\n\0R∑\0\0\Zh\0 \02\0\0B#\Z\nMAIN\0 \0(ˇˇˇˇˇˇˇˇˇ@\0\"\nMAINR5\nDEFAULT\"*\n&org.drools.core.reteoo.InitialFactImpl\0\"h*C\nA¢<\nÔ›–√1 \0(0ëîÊ‘ä0H!\ZíîÊ‘ä0ˇˇˇˇˇˇˇˇˇ 0ÅÚ∂òº08\0','2022-05-09 14:53:19',4),(16,'2022-05-09 14:54:05','¨Ì\0wö\n4\0Rè\0\0\Z<\0 \02\0\0B#\Z\nMAIN\0 \0(ˇˇˇˇˇˇˇˇˇ@\0\"\nMAINR	\nDEFAULT\"h*G\nE¢@\n˜Ìœ√1 \0(0âÑÁ‘ä0HP\0Z\0!\ZâÑÁ‘ä0ˇˇˇˇˇˇˇˇˇ 0ÄÚ∂òº08\0','2022-05-09 14:53:26',5),(18,'2022-05-09 14:56:35','¨Ì\0wP\n4\0RF\0\0\Z<\0 \02\0\0B#\Z\nMAIN\0 \0(ˇˇˇˇˇˇˇˇˇ@\0\"\nMAINR	\nDEFAULT\"h\0','2022-05-09 14:56:34',2);
/*!40000 ALTER TABLE `SessionInfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Task`
--

DROP TABLE IF EXISTS `Task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Task` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `archived` smallint(6) DEFAULT NULL,
  `allowedToDelegate` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `formName` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `priority` int(11) NOT NULL,
  `subTaskStrategy` varchar(255) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `activationTime` datetime DEFAULT NULL,
  `createdOn` datetime DEFAULT NULL,
  `deploymentId` varchar(255) DEFAULT NULL,
  `documentAccessType` int(11) DEFAULT NULL,
  `documentContentId` bigint(20) NOT NULL,
  `documentType` varchar(255) DEFAULT NULL,
  `expirationTime` datetime DEFAULT NULL,
  `faultAccessType` int(11) DEFAULT NULL,
  `faultContentId` bigint(20) NOT NULL,
  `faultName` varchar(255) DEFAULT NULL,
  `faultType` varchar(255) DEFAULT NULL,
  `outputAccessType` int(11) DEFAULT NULL,
  `outputContentId` bigint(20) NOT NULL,
  `outputType` varchar(255) DEFAULT NULL,
  `parentId` bigint(20) NOT NULL,
  `previousStatus` int(11) DEFAULT NULL,
  `processId` varchar(255) DEFAULT NULL,
  `processInstanceId` bigint(20) NOT NULL,
  `processSessionId` bigint(20) NOT NULL,
  `skipable` tinyint(1) NOT NULL,
  `status` varchar(255) DEFAULT NULL,
  `workItemId` bigint(20) NOT NULL,
  `taskType` varchar(255) DEFAULT NULL,
  `OPTLOCK` int(11) DEFAULT NULL,
  `taskInitiator_id` varchar(255) DEFAULT NULL,
  `actualOwner_id` varchar(255) DEFAULT NULL,
  `createdBy_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_dpk0f9ucm14c78bsxthh7h8yh` (`taskInitiator_id`),
  KEY `FK_nh9nnt47f3l61qjlyedqt05rf` (`actualOwner_id`),
  KEY `FK_k02og0u71obf1uxgcdjx9rcjc` (`createdBy_id`),
  KEY `IDX_Task_Initiator` (`taskInitiator_id`),
  KEY `IDX_Task_ActualOwner` (`actualOwner_id`),
  KEY `IDX_Task_CreatedBy` (`createdBy_id`),
  KEY `IDX_Task_processInstanceId` (`processInstanceId`),
  KEY `IDX_Task_processId` (`processId`),
  KEY `IDX_Task_status` (`status`),
  KEY `IDX_Task_archived` (`archived`),
  KEY `IDX_Task_workItemId` (`workItemId`),
  CONSTRAINT `FK_dpk0f9ucm14c78bsxthh7h8yh` FOREIGN KEY (`taskInitiator_id`) REFERENCES `OrganizationalEntity` (`id`),
  CONSTRAINT `FK_k02og0u71obf1uxgcdjx9rcjc` FOREIGN KEY (`createdBy_id`) REFERENCES `OrganizationalEntity` (`id`),
  CONSTRAINT `FK_nh9nnt47f3l61qjlyedqt05rf` FOREIGN KEY (`actualOwner_id`) REFERENCES `OrganizationalEntity` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Task`
--

LOCK TABLES `Task` WRITE;
/*!40000 ALTER TABLE `Task` DISABLE KEYS */;
INSERT INTO `Task` VALUES (1,0,NULL,'',NULL,'do something',0,'NoAction','','2022-05-09 14:29:37','2022-05-09 14:29:37','example:case03200412:1.0',0,1,'java.util.HashMap',NULL,NULL,-1,NULL,NULL,NULL,-1,NULL,-1,0,'case03200412.timertest',4,10,1,'Ready',4,NULL,1,NULL,NULL,NULL),(2,0,NULL,'',NULL,'do something',0,'NoAction','','2022-05-09 14:53:50','2022-05-09 14:53:50','example:case03200412:1.0',0,2,'java.util.HashMap',NULL,NULL,-1,NULL,NULL,NULL,-1,NULL,-1,0,'case03200412.timertest',6,15,1,'Ready',5,NULL,1,NULL,NULL,NULL),(3,0,NULL,'',NULL,'do something',0,'NoAction','','2022-05-09 14:54:05','2022-05-09 14:54:05','example:case03200412:1.0',0,3,'java.util.HashMap',NULL,NULL,-1,NULL,NULL,NULL,-1,NULL,-1,0,'case03200412.timertest',7,16,1,'Ready',6,NULL,1,NULL,NULL,NULL);
/*!40000 ALTER TABLE `Task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TaskDef`
--

DROP TABLE IF EXISTS `TaskDef`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TaskDef` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `priority` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TaskDef`
--

LOCK TABLES `TaskDef` WRITE;
/*!40000 ALTER TABLE `TaskDef` DISABLE KEYS */;
/*!40000 ALTER TABLE `TaskDef` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TaskEvent`
--

DROP TABLE IF EXISTS `TaskEvent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TaskEvent` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `logTime` datetime DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `processInstanceId` bigint(20) DEFAULT NULL,
  `taskId` bigint(20) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `userId` varchar(255) DEFAULT NULL,
  `OPTLOCK` int(11) DEFAULT NULL,
  `workItemId` bigint(20) DEFAULT NULL,
  `correlationKey` varchar(255) DEFAULT NULL,
  `processType` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_TaskEvent_taskId` (`taskId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TaskEvent`
--

LOCK TABLES `TaskEvent` WRITE;
/*!40000 ALTER TABLE `TaskEvent` DISABLE KEYS */;
INSERT INTO `TaskEvent` VALUES (1,'2022-05-09 14:29:37',NULL,4,1,'ADDED','case03200412.timertest',0,4,NULL,NULL),(2,'2022-05-09 14:29:37',NULL,4,1,'ACTIVATED','rhpamAdmin',0,4,NULL,NULL),(3,'2022-05-09 14:53:50',NULL,6,2,'ADDED','case03200412.timertest',0,5,NULL,NULL),(4,'2022-05-09 14:54:05',NULL,7,3,'ADDED','case03200412.timertest',0,6,NULL,NULL);
/*!40000 ALTER TABLE `TaskEvent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TaskVariableImpl`
--

DROP TABLE IF EXISTS `TaskVariableImpl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TaskVariableImpl` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `modificationDate` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `processId` varchar(255) DEFAULT NULL,
  `processInstanceId` bigint(20) DEFAULT NULL,
  `taskId` bigint(20) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `value` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TaskVariableImpl`
--

LOCK TABLES `TaskVariableImpl` WRITE;
/*!40000 ALTER TABLE `TaskVariableImpl` DISABLE KEYS */;
INSERT INTO `TaskVariableImpl` VALUES (1,'2022-05-09 14:53:50','Skippable','case03200412.timertest',6,2,0,'true'),(2,'2022-05-09 14:53:50','GroupId','case03200412.timertest',6,2,0,'admin'),(3,'2022-05-09 14:54:05','Skippable','case03200412.timertest',7,3,0,'true'),(4,'2022-05-09 14:54:05','GroupId','case03200412.timertest',7,3,0,'admin');
/*!40000 ALTER TABLE `TaskVariableImpl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `VariableInstanceLog`
--

DROP TABLE IF EXISTS `VariableInstanceLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `VariableInstanceLog` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `log_date` datetime DEFAULT NULL,
  `externalId` varchar(255) DEFAULT NULL,
  `oldValue` varchar(255) DEFAULT NULL,
  `processId` varchar(255) DEFAULT NULL,
  `processInstanceId` bigint(20) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `variableId` varchar(255) DEFAULT NULL,
  `variableInstanceId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_VInstLog_pInstId` (`processInstanceId`),
  KEY `IDX_VInstLog_varId` (`variableId`),
  KEY `IDX_VInstLog_pId` (`processId`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VariableInstanceLog`
--

LOCK TABLES `VariableInstanceLog` WRITE;
/*!40000 ALTER TABLE `VariableInstanceLog` DISABLE KEYS */;
INSERT INTO `VariableInstanceLog` VALUES (1,'2021-02-22 23:13:08','com.myspace:case02824294:1.0.0-SNAPSHOT','','LetterOfGuarantee.PerformCredit',1,'Message reference to investigation with data true at process instance 1','message_investigation','message_investigation'),(2,'2021-02-22 23:13:08','com.myspace:case02824294:1.0.0-SNAPSHOT','','LetterOfGuarantee.PerformCredit',1,'true','isInvestigationRequested','isInvestigationRequested'),(3,'2021-02-22 23:13:08','com.myspace:case02824294:1.0.0-SNAPSHOT','','LetterOfGuarantee.PerformCredit',1,'Message reference to investigationCompleted with data true at process instance 1','message_completeInvestigation','message_completeInvestigation'),(4,'2021-02-24 12:47:33','com.myspace:case02824294:1.0.0-SNAPSHOT','','LetterOfGuarantee.PerformCredit',2,'Message reference to investigation with data true at process instance 2','message_investigation','message_investigation'),(5,'2021-02-24 12:47:33','com.myspace:case02824294:1.0.0-SNAPSHOT','','LetterOfGuarantee.PerformCredit',2,'true','isInvestigationRequested','isInvestigationRequested'),(6,'2021-02-24 12:47:33','com.myspace:case02824294:1.0.0-SNAPSHOT','','LetterOfGuarantee.PerformCredit',2,'Message reference to investigationCompleted with data true at process instance 2','message_completeInvestigation','message_completeInvestigation'),(7,'2021-02-24 12:48:21','com.myspace:case02824294:1.0.0-SNAPSHOT','','LetterOfGuarantee.PerformCredit',3,'Message reference to investigation with data true at process instance 3','message_investigation','message_investigation'),(8,'2021-02-24 12:48:21','com.myspace:case02824294:1.0.0-SNAPSHOT','','LetterOfGuarantee.PerformCredit',3,'true','isInvestigationRequested','isInvestigationRequested'),(9,'2021-02-24 12:48:21','com.myspace:case02824294:1.0.0-SNAPSHOT','','LetterOfGuarantee.PerformCredit',3,'Message reference to investigationCompleted with data true at process instance 3','message_completeInvestigation','message_completeInvestigation'),(10,'2022-05-09 14:26:14','example:case03200412:1.0','','case03200412.timertest',4,'2022-10-10T20:00:00.000+02:00','timerAlert','timerAlert'),(11,'2022-05-09 14:26:14','example:case03200412:1.0','','case03200412.timertest',4,'rhpamAdmin','initiator','initiator'),(12,'2022-05-09 14:53:02','example:case03200412:1.0','','case03200412.timertest',5,'2022-10-10T20:00:00.000+02:00','timerAlert','timerAlert'),(13,'2022-05-09 14:53:19','example:case03200412:1.0','','case03200412.timertest',6,'2022-10-10T20:00:00.000+02:00','timerAlert','timerAlert'),(14,'2022-05-09 14:53:26','example:case03200412:1.0','','case03200412.timertest',7,'2022-10-10T20:00:00.000+02:00','timerAlert','timerAlert'),(15,'2022-05-09 14:56:35','example:case03200412:1.0','','case03200412.timertest',8,'2022-10-10T20:00:00.000+02:00','timerAlert','timerAlert'),(16,'2022-05-09 14:56:35','example:case03200412:1.0','','case03200412.timertest',8,'rhpamAdmin','initiator','initiator');
/*!40000 ALTER TABLE `VariableInstanceLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WorkItemInfo`
--

DROP TABLE IF EXISTS `WorkItemInfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `WorkItemInfo` (
  `workItemId` bigint(20) NOT NULL AUTO_INCREMENT,
  `creationDate` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `processInstanceId` bigint(20) NOT NULL,
  `state` bigint(20) NOT NULL,
  `OPTLOCK` int(11) DEFAULT NULL,
  `workItemByteArray` longblob DEFAULT NULL,
  PRIMARY KEY (`workItemId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WorkItemInfo`
--

LOCK TABLES `WorkItemInfo` WRITE;
/*!40000 ALTER TABLE `WorkItemInfo` DISABLE KEYS */;
INSERT INTO `WorkItemInfo` VALUES (1,'2021-02-22 23:13:08','Send Task',1,0,1,'¨Ì\0z\0\02\n\0JΩ\0Horg.drools.core.marshalling.impl.SerializablePlaceholderResolverStrategy\ZÓ¨Ì\0sr\0java.util.ArrayListxÅ“ô«aù\0I\0sizexp\0\0\0w\0\0\0sr\0#com.accenture.process.model.Message\0\0\0\0\0\0\0\0L\0messageDatat\0Ljava/lang/Object;L\0\nmessageReft\0Ljava/lang/String;L\0	targetPidt\0Ljava/lang/Long;xpsr\0java.lang.BooleanÕ rÄ’ú˙Ó\0Z\0valuexpt\0\rinvestigationsr\0java.lang.Long;ã‰êÃè#ﬂ\0J\0valuexr\0java.lang.NumberÜ¨ïî‡ã\0\0xp\0\0\0\0\0\0\0t\0java.lang.ObjectxRh\Z	Send Task \0*\nMessage\0\Z\0\0\0\0*\nMessageType\0\Z\0\0\02\'com.myspace:case02824294:1.0.0-SNAPSHOT8@'),(2,'2021-02-24 12:47:33','Send Task',2,0,1,'¨Ì\0z\0\02\n\0JΩ\0Horg.drools.core.marshalling.impl.SerializablePlaceholderResolverStrategy\ZÓ¨Ì\0sr\0java.util.ArrayListxÅ“ô«aù\0I\0sizexp\0\0\0w\0\0\0sr\0#com.accenture.process.model.Message\0\0\0\0\0\0\0\0L\0messageDatat\0Ljava/lang/Object;L\0\nmessageReft\0Ljava/lang/String;L\0	targetPidt\0Ljava/lang/Long;xpsr\0java.lang.BooleanÕ rÄ’ú˙Ó\0Z\0valuexpt\0\rinvestigationsr\0java.lang.Long;ã‰êÃè#ﬂ\0J\0valuexr\0java.lang.NumberÜ¨ïî‡ã\0\0xp\0\0\0\0\0\0\0t\0java.lang.ObjectxRh\Z	Send Task \0*\nMessage\0\Z\0\0\0\0*\nMessageType\0\Z\0\0\02\'com.myspace:case02824294:1.0.0-SNAPSHOT8@'),(3,'2021-02-24 12:48:21','Send Task',3,0,1,'¨Ì\0z\0\02\n\0JΩ\0Horg.drools.core.marshalling.impl.SerializablePlaceholderResolverStrategy\ZÓ¨Ì\0sr\0java.util.ArrayListxÅ“ô«aù\0I\0sizexp\0\0\0w\0\0\0sr\0#com.accenture.process.model.Message\0\0\0\0\0\0\0\0L\0messageDatat\0Ljava/lang/Object;L\0\nmessageReft\0Ljava/lang/String;L\0	targetPidt\0Ljava/lang/Long;xpsr\0java.lang.BooleanÕ rÄ’ú˙Ó\0Z\0valuexpt\0\rinvestigationsr\0java.lang.Long;ã‰êÃè#ﬂ\0J\0valuexr\0java.lang.NumberÜ¨ïî‡ã\0\0xp\0\0\0\0\0\0\0t\0java.lang.ObjectxRh\Z	Send Task \0*\nMessage\0\Z\0\0\0\0*\nMessageType\0\Z\0\0\02\'com.myspace:case02824294:1.0.0-SNAPSHOT8@'),(4,'2022-05-09 14:29:37','Human Task',4,0,1,'¨Ì\0z\0\0\n4\0J¶\0Horg.drools.core.marshalling.impl.SerializablePlaceholderResolverStrategy\ZX¨Ì\0sr\0java.util.ArrayListxÅ“ô«aù\0I\0sizexp\0\0\0w\0\0\0t\0truet\0do somethingt\0adminxRl\Z\nHuman Task \0*\n	Skippable\0\Z\0\0\0\0*\nNodeName\0\Z\0\0\0*\nGroupId\0\Z\0\0\02example:case03200412:1.08@'),(5,'2022-05-09 14:53:50','Human Task',6,0,1,'¨Ì\0z\0\0\n\0J¶\0Horg.drools.core.marshalling.impl.SerializablePlaceholderResolverStrategy\ZX¨Ì\0sr\0java.util.ArrayListxÅ“ô«aù\0I\0sizexp\0\0\0w\0\0\0t\0truet\0do somethingt\0adminxRl\Z\nHuman Task \0*\n	Skippable\0\Z\0\0\0\0*\nNodeName\0\Z\0\0\0*\nGroupId\0\Z\0\0\02example:case03200412:1.08@'),(6,'2022-05-09 14:54:05','Human Task',7,0,1,'¨Ì\0z\0\0\n\0J¶\0Horg.drools.core.marshalling.impl.SerializablePlaceholderResolverStrategy\ZX¨Ì\0sr\0java.util.ArrayListxÅ“ô«aù\0I\0sizexp\0\0\0w\0\0\0t\0truet\0do somethingt\0adminxRl\Z\nHuman Task \0*\n	Skippable\0\Z\0\0\0\0*\nNodeName\0\Z\0\0\0*\nGroupId\0\Z\0\0\02example:case03200412:1.08@');
/*!40000 ALTER TABLE `WorkItemInfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_header`
--

DROP TABLE IF EXISTS `email_header`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_header` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `body` longtext DEFAULT NULL,
  `fromAddress` varchar(255) DEFAULT NULL,
  `language` varchar(255) DEFAULT NULL,
  `replyToAddress` varchar(255) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_header`
--

LOCK TABLES `email_header` WRITE;
/*!40000 ALTER TABLE `email_header` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_header` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_comment`
--

DROP TABLE IF EXISTS `task_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_comment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `addedAt` datetime DEFAULT NULL,
  `text` longtext DEFAULT NULL,
  `addedBy_id` varchar(255) DEFAULT NULL,
  `TaskData_Comments_Id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_aax378yjnsmw9kb9vsu994jjv` (`addedBy_id`),
  KEY `FK_1ws9jdmhtey6mxu7jb0r0ufvs` (`TaskData_Comments_Id`),
  KEY `IDX_TaskComments_CreatedBy` (`addedBy_id`),
  KEY `IDX_TaskComments_Id` (`TaskData_Comments_Id`),
  CONSTRAINT `FK_1ws9jdmhtey6mxu7jb0r0ufvs` FOREIGN KEY (`TaskData_Comments_Id`) REFERENCES `Task` (`id`),
  CONSTRAINT `FK_aax378yjnsmw9kb9vsu994jjv` FOREIGN KEY (`addedBy_id`) REFERENCES `OrganizationalEntity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_comment`
--

LOCK TABLES `task_comment` WRITE;
/*!40000 ALTER TABLE `task_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_comment` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-09 14:59:02
