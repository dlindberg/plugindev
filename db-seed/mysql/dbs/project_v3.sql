-- MariaDB dump 10.19  Distrib 10.5.13-MariaDB, for Linux (x86_64)
--
-- Host: mysql    Database: project_v3
-- ------------------------------------------------------
-- Server version	8.0.28

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
-- Table structure for table `announcements`
--

DROP TABLE IF EXISTS `announcements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `announcements` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `pluginId` int DEFAULT NULL,
  `heading` varchar(255) NOT NULL,
  `body` text NOT NULL,
  `unread` tinyint(1) NOT NULL DEFAULT '1',
  `dateRead` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_mzjhnbsfwyllhhgralzvjotzutssnierfuqk` (`userId`,`unread`,`dateRead`,`dateCreated`),
  KEY `idx_yvhcunvigjaggnleqctosvjntbokpfrlljmj` (`dateRead`),
  KEY `fk_xtjmwmofpvpicmgpondjwvtecxtoayhtoxbb` (`pluginId`),
  CONSTRAINT `fk_pghtvbxjkhuvdaaxapisuljhykgartytjkzt` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_xtjmwmofpvpicmgpondjwvtecxtoayhtoxbb` FOREIGN KEY (`pluginId`) REFERENCES `plugins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assetindexdata`
--

DROP TABLE IF EXISTS `assetindexdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assetindexdata` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(36) NOT NULL DEFAULT '',
  `volumeId` int NOT NULL,
  `uri` text,
  `size` bigint unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `recordId` int DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT '0',
  `completed` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assetindexdata_sessionId_volumeId_idx` (`sessionId`,`volumeId`),
  KEY `assetindexdata_volumeId_idx` (`volumeId`),
  CONSTRAINT `assetindexdata_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assets`
--

DROP TABLE IF EXISTS `assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assets` (
  `id` int NOT NULL,
  `volumeId` int DEFAULT NULL,
  `folderId` int NOT NULL,
  `uploaderId` int DEFAULT NULL,
  `filename` varchar(255) NOT NULL,
  `kind` varchar(50) NOT NULL DEFAULT 'unknown',
  `width` int unsigned DEFAULT NULL,
  `height` int unsigned DEFAULT NULL,
  `size` bigint unsigned DEFAULT NULL,
  `focalPoint` varchar(13) DEFAULT NULL,
  `deletedWithVolume` tinyint(1) DEFAULT NULL,
  `keptFile` tinyint(1) DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assets_filename_folderId_idx` (`filename`,`folderId`),
  KEY `assets_folderId_idx` (`folderId`),
  KEY `assets_volumeId_idx` (`volumeId`),
  KEY `assets_uploaderId_fk` (`uploaderId`),
  CONSTRAINT `assets_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_uploaderId_fk` FOREIGN KEY (`uploaderId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `assets_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assettransformindex`
--

DROP TABLE IF EXISTS `assettransformindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assettransformindex` (
  `id` int NOT NULL AUTO_INCREMENT,
  `assetId` int NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `volumeId` int DEFAULT NULL,
  `fileExists` tinyint(1) NOT NULL DEFAULT '0',
  `inProgress` tinyint(1) NOT NULL DEFAULT '0',
  `error` tinyint(1) NOT NULL DEFAULT '0',
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assettransformindex_volumeId_assetId_location_idx` (`volumeId`,`assetId`,`location`),
  KEY `idx_zvgdxgvlfihwzlrbyvgjpzncehycesophdno` (`assetId`,`format`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assettransforms`
--

DROP TABLE IF EXISTS `assettransforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assettransforms` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `mode` enum('stretch','fit','crop') NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') NOT NULL DEFAULT 'center-center',
  `width` int unsigned DEFAULT NULL,
  `height` int unsigned DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `quality` int DEFAULT NULL,
  `interlace` enum('none','line','plane','partition') NOT NULL DEFAULT 'none',
  `dimensionChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assettransforms_name_idx` (`name`),
  KEY `assettransforms_handle_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calendar_calendar_sites`
--

DROP TABLE IF EXISTS `calendar_calendar_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calendar_calendar_sites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `calendarId` int DEFAULT NULL,
  `siteId` int DEFAULT NULL,
  `enabledByDefault` tinyint(1) DEFAULT '1',
  `hasUrls` tinyint(1) DEFAULT '0',
  `uriFormat` varchar(255) DEFAULT NULL,
  `template` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `calendar_calendar_sites_calendarId_siteId_unq_idx` (`calendarId`,`siteId`),
  KEY `calendar_calendar_sites_siteId_fk` (`siteId`),
  CONSTRAINT `calendar_calendar_sites_calendarId_fk` FOREIGN KEY (`calendarId`) REFERENCES `calendar_calendars` (`id`) ON DELETE CASCADE,
  CONSTRAINT `calendar_calendar_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calendar_calendars`
--

DROP TABLE IF EXISTS `calendar_calendars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calendar_calendars` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `handle` varchar(100) NOT NULL,
  `description` text,
  `color` varchar(10) NOT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `titleFormat` varchar(255) DEFAULT NULL,
  `titleLabel` varchar(255) DEFAULT 'Title',
  `hasTitleField` tinyint(1) NOT NULL DEFAULT '1',
  `descriptionFieldHandle` varchar(255) DEFAULT NULL,
  `locationFieldHandle` varchar(255) DEFAULT NULL,
  `icsHash` varchar(255) DEFAULT NULL,
  `icsTimezone` varchar(255) DEFAULT NULL,
  `allowRepeatingEvents` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `handle` (`handle`),
  UNIQUE KEY `calendar_calendars_name_unq_idx` (`name`),
  UNIQUE KEY `calendar_calendars_handle_unq_idx` (`handle`),
  UNIQUE KEY `calendar_calendars_icsHash_unq_idx` (`icsHash`),
  KEY `calendar_calendars_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `calendar_calendars_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calendar_events`
--

DROP TABLE IF EXISTS `calendar_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calendar_events` (
  `internalId` int NOT NULL AUTO_INCREMENT,
  `id` int NOT NULL,
  `calendarId` int DEFAULT NULL,
  `authorId` int DEFAULT NULL,
  `startDate` datetime NOT NULL,
  `endDate` datetime NOT NULL,
  `allDay` tinyint(1) DEFAULT NULL,
  `rrule` varchar(255) DEFAULT NULL,
  `freq` varchar(255) DEFAULT NULL,
  `interval` int DEFAULT NULL,
  `count` int DEFAULT NULL,
  `until` datetime DEFAULT NULL,
  `byMonth` varchar(255) DEFAULT NULL,
  `byYearDay` varchar(255) DEFAULT NULL,
  `byMonthDay` varchar(255) DEFAULT NULL,
  `byDay` varchar(255) DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`internalId`),
  UNIQUE KEY `calendar_events_id_unq_idx` (`id`),
  KEY `calendar_events_postDate_idx` (`postDate`),
  KEY `calendar_events_calendarId_idx` (`calendarId`),
  KEY `calendar_events_authorId_idx` (`authorId`),
  KEY `calendar_events_startDate_idx` (`startDate`),
  KEY `calendar_events_endDate_idx` (`endDate`),
  KEY `calendar_events_startDate_endDate_idx` (`startDate`,`endDate`),
  KEY `calendar_events_until_idx` (`until`),
  CONSTRAINT `calendar_events_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `calendar_events_calendarId_fk` FOREIGN KEY (`calendarId`) REFERENCES `calendar_calendars` (`id`) ON DELETE CASCADE,
  CONSTRAINT `calendar_events_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calendar_exceptions`
--

DROP TABLE IF EXISTS `calendar_exceptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calendar_exceptions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `eventId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `calendar_exceptions_exceptions_eventId_date_idx` (`eventId`,`date`),
  CONSTRAINT `calendar_exceptions_eventId_fk` FOREIGN KEY (`eventId`) REFERENCES `calendar_events` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calendar_select_dates`
--

DROP TABLE IF EXISTS `calendar_select_dates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calendar_select_dates` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `eventId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `calendar_select_dates_select_dates_eventId_date_idx` (`eventId`,`date`),
  CONSTRAINT `calendar_select_dates_eventId_fk` FOREIGN KEY (`eventId`) REFERENCES `calendar_events` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int NOT NULL,
  `groupId` int NOT NULL,
  `parentId` int DEFAULT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categories_groupId_idx` (`groupId`),
  KEY `categories_parentId_fk` (`parentId`),
  CONSTRAINT `categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categorygroups`
--

DROP TABLE IF EXISTS `categorygroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorygroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `structureId` int NOT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `defaultPlacement` enum('beginning','end') NOT NULL DEFAULT 'end',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categorygroups_name_idx` (`name`),
  KEY `categorygroups_handle_idx` (`handle`),
  KEY `categorygroups_structureId_idx` (`structureId`),
  KEY `categorygroups_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `categorygroups_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categorygroups_sites`
--

DROP TABLE IF EXISTS `categorygroups_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorygroups_sites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `groupId` int NOT NULL,
  `siteId` int NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `categorygroups_sites_groupId_siteId_unq_idx` (`groupId`,`siteId`),
  KEY `categorygroups_sites_siteId_idx` (`siteId`),
  CONSTRAINT `categorygroups_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categorygroups_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `changedattributes`
--

DROP TABLE IF EXISTS `changedattributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `changedattributes` (
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `attribute` varchar(255) NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `propagated` tinyint(1) NOT NULL,
  `userId` int DEFAULT NULL,
  PRIMARY KEY (`elementId`,`siteId`,`attribute`),
  KEY `changedattributes_elementId_siteId_dateUpdated_idx` (`elementId`,`siteId`,`dateUpdated`),
  KEY `changedattributes_siteId_fk` (`siteId`),
  KEY `changedattributes_userId_fk` (`userId`),
  CONSTRAINT `changedattributes_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedattributes_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedattributes_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `changedfields`
--

DROP TABLE IF EXISTS `changedfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `changedfields` (
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `fieldId` int NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `propagated` tinyint(1) NOT NULL,
  `userId` int DEFAULT NULL,
  PRIMARY KEY (`elementId`,`siteId`,`fieldId`),
  KEY `changedfields_elementId_siteId_dateUpdated_idx` (`elementId`,`siteId`,`dateUpdated`),
  KEY `changedfields_siteId_fk` (`siteId`),
  KEY `changedfields_fieldId_fk` (`fieldId`),
  KEY `changedfields_userId_fk` (`userId`),
  CONSTRAINT `changedfields_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedfields_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedfields_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_addresses`
--

DROP TABLE IF EXISTS `commerce_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_addresses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `countryId` int DEFAULT NULL,
  `stateId` int DEFAULT NULL,
  `isStoreLocation` tinyint(1) NOT NULL DEFAULT '0',
  `attention` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `firstName` varchar(255) DEFAULT NULL,
  `lastName` varchar(255) DEFAULT NULL,
  `fullName` varchar(255) DEFAULT NULL,
  `address1` varchar(255) DEFAULT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `address3` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `zipCode` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `alternativePhone` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `notes` text,
  `businessName` varchar(255) DEFAULT NULL,
  `businessTaxId` varchar(255) DEFAULT NULL,
  `businessId` varchar(255) DEFAULT NULL,
  `stateName` varchar(255) DEFAULT NULL,
  `custom1` varchar(255) DEFAULT NULL,
  `custom2` varchar(255) DEFAULT NULL,
  `custom3` varchar(255) DEFAULT NULL,
  `custom4` varchar(255) DEFAULT NULL,
  `isEstimated` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_zxfoehiquyxmwkufojvjnqchfvpcjqlhlyeu` (`countryId`),
  KEY `idx_eagtkaqhevmoarakgjyklewcansvaqyqqbaq` (`stateId`),
  KEY `idx_gahwavjjauuqhocxphifsmoacmhniffclcml` (`isStoreLocation`),
  CONSTRAINT `fk_jdvhpfuxvffgxsmrukvebsdjrdspwxdxxnju` FOREIGN KEY (`stateId`) REFERENCES `commerce_states` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_tamffxenafmshudkmwtpkfvbbvcywmffirwf` FOREIGN KEY (`countryId`) REFERENCES `commerce_countries` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_countries`
--

DROP TABLE IF EXISTS `commerce_countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_countries` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `iso` varchar(2) NOT NULL,
  `isStateRequired` tinyint(1) DEFAULT NULL,
  `sortOrder` int DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_ybrywppncxxpysixukmwyjqjsahcxniakaby` (`name`),
  UNIQUE KEY `idx_nsagonuonzvxjyvemtrobtjathsuqggvbszq` (`iso`)
) ENGINE=InnoDB AUTO_INCREMENT=250 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_customer_discountuses`
--

DROP TABLE IF EXISTS `commerce_customer_discountuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_customer_discountuses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `discountId` int NOT NULL,
  `customerId` int NOT NULL,
  `uses` int unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_xxirsmofnddeknbjcmqixgoowrfgsobkuhdx` (`customerId`,`discountId`),
  KEY `idx_sfknqzhusiosljbqnoxcpwifaqoexcziufyx` (`discountId`),
  CONSTRAINT `fk_brdlncpgontqmksmaaegzcjpjuyymlxfhvzj` FOREIGN KEY (`discountId`) REFERENCES `commerce_discounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_kdbiqhykeoomfdywbfwrxtxuroyzaftwvcuj` FOREIGN KEY (`customerId`) REFERENCES `commerce_customers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_customers`
--

DROP TABLE IF EXISTS `commerce_customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_customers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int DEFAULT NULL,
  `primaryBillingAddressId` int DEFAULT NULL,
  `primaryShippingAddressId` int DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_vwvtcdjntxgjjrqpoixlurmokbtuxarcqrza` (`userId`),
  KEY `idx_hccbezfubxoenngzawanxokiepizmxbsgiep` (`primaryBillingAddressId`),
  KEY `idx_dlittghypfpshwosvoifuhnmgucragzwbgfw` (`primaryShippingAddressId`),
  CONSTRAINT `fk_mwxoxwocervrxeworbvswsdlccrtzabdnvzx` FOREIGN KEY (`primaryShippingAddressId`) REFERENCES `commerce_addresses` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_vkcvhtrpelvkjnlccebhustppgmkypvplqrw` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_yttiikuygnazdaputnyiiiehmimkbotxbylc` FOREIGN KEY (`primaryBillingAddressId`) REFERENCES `commerce_addresses` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_customers_addresses`
--

DROP TABLE IF EXISTS `commerce_customers_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_customers_addresses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customerId` int NOT NULL,
  `addressId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_zwfnkwvzdnqwrwgbvjjowgfsbvqmdkgnhtgg` (`customerId`,`addressId`),
  KEY `fk_tejwvlsohsgkvkxexnlnxgbiwtkomcqkcvdz` (`addressId`),
  CONSTRAINT `fk_frrfjdlsixorwfmsmhkahffwvhldpzrazvcp` FOREIGN KEY (`customerId`) REFERENCES `commerce_customers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_tejwvlsohsgkvkxexnlnxgbiwtkomcqkcvdz` FOREIGN KEY (`addressId`) REFERENCES `commerce_addresses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_discount_categories`
--

DROP TABLE IF EXISTS `commerce_discount_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_discount_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `discountId` int NOT NULL,
  `categoryId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_eylupwtawvdrzibkdxbkdagvdztfczkejaew` (`discountId`,`categoryId`),
  KEY `idx_gygdmmdpfwndczwvbvyflmbgcogemvakrsyv` (`categoryId`),
  CONSTRAINT `fk_wosplisoipqxqleaocabwbapqzqbzffjwsxw` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_xjjuzxnwxoyfyqgrcsnhidnhqivwhitfokfe` FOREIGN KEY (`discountId`) REFERENCES `commerce_discounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_discount_purchasables`
--

DROP TABLE IF EXISTS `commerce_discount_purchasables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_discount_purchasables` (
  `id` int NOT NULL AUTO_INCREMENT,
  `discountId` int NOT NULL,
  `purchasableId` int NOT NULL,
  `purchasableType` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_xrsqwzetheumyvpqmucinwyuyorlapeymiyw` (`discountId`,`purchasableId`),
  KEY `idx_estzamjtfpaakdrzyjnvfwrlhxcziikjnppj` (`purchasableId`),
  CONSTRAINT `fk_bgojgrqznhqfshqrdhvmikobueftbynqlikg` FOREIGN KEY (`purchasableId`) REFERENCES `commerce_purchasables` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_cbhlleaakybhcqlprgcosseevzczvpaxxcdd` FOREIGN KEY (`discountId`) REFERENCES `commerce_discounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_discount_usergroups`
--

DROP TABLE IF EXISTS `commerce_discount_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_discount_usergroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `discountId` int NOT NULL,
  `userGroupId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_reronkkckwajrjubmngilwepzqoxgcwokoyi` (`discountId`,`userGroupId`),
  KEY `idx_linivkrabazpwrdbevdyrhfhkzojjbylnhin` (`userGroupId`),
  CONSTRAINT `fk_ejvkihzpdybadnizidfpianvwyvjrtalpgcr` FOREIGN KEY (`discountId`) REFERENCES `commerce_discounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_wajmjhzvosnvwfmfbsxnlcxfwjkfpyoimhhl` FOREIGN KEY (`userGroupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_discounts`
--

DROP TABLE IF EXISTS `commerce_discounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_discounts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  `code` varchar(255) DEFAULT NULL,
  `perUserLimit` int unsigned NOT NULL DEFAULT '0',
  `perEmailLimit` int unsigned NOT NULL DEFAULT '0',
  `totalDiscountUses` int unsigned NOT NULL DEFAULT '0',
  `totalDiscountUseLimit` int unsigned NOT NULL DEFAULT '0',
  `dateFrom` datetime DEFAULT NULL,
  `dateTo` datetime DEFAULT NULL,
  `purchaseTotal` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `purchaseQty` int NOT NULL DEFAULT '0',
  `maxPurchaseQty` int NOT NULL DEFAULT '0',
  `baseDiscount` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `baseDiscountType` enum('value','percentTotal','percentTotalDiscounted','percentItems','percentItemsDiscounted') NOT NULL DEFAULT 'value',
  `perItemDiscount` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `percentDiscount` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `percentageOffSubject` enum('original','discounted') NOT NULL,
  `excludeOnSale` tinyint(1) DEFAULT NULL,
  `hasFreeShippingForMatchingItems` tinyint(1) DEFAULT NULL,
  `hasFreeShippingForOrder` tinyint(1) DEFAULT NULL,
  `allPurchasables` tinyint(1) DEFAULT NULL,
  `allCategories` tinyint(1) DEFAULT NULL,
  `appliedTo` enum('matchingLineItems','allLineItems') NOT NULL DEFAULT 'matchingLineItems',
  `categoryRelationshipType` enum('element','sourceElement','targetElement') NOT NULL DEFAULT 'element',
  `orderConditionFormula` text,
  `enabled` tinyint(1) DEFAULT NULL,
  `stopProcessing` tinyint(1) DEFAULT NULL,
  `ignoreSales` tinyint(1) NOT NULL DEFAULT '0',
  `sortOrder` int DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `userGroupsCondition` varchar(255) DEFAULT 'userGroupsAnyOrNone',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_jbsniuyholpgdylbqsiyqjjtnizcevaphtbd` (`code`),
  KEY `idx_ftzktmjhnhcmeycezwqlsmwbusxvlxkraqxc` (`dateFrom`),
  KEY `idx_exvobdyficshxlqheekaegpvzixxvxdntbnm` (`dateTo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_donations`
--

DROP TABLE IF EXISTS `commerce_donations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_donations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sku` varchar(255) NOT NULL,
  `availableForPurchase` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_daisrdihbgoaspxrfrtcdvffrxqpohbzleun` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_email_discountuses`
--

DROP TABLE IF EXISTS `commerce_email_discountuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_email_discountuses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `discountId` int NOT NULL,
  `email` varchar(255) NOT NULL,
  `uses` int unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_ktrwfkokyxclurjufwbfnubhrpnlmrtuqznn` (`email`,`discountId`),
  KEY `idx_lbudoeoylejnmrxavzjmadadalhyxlczyuck` (`discountId`),
  CONSTRAINT `fk_uhcwjasjqokongfrhyyvhtsrjkybyvilhtuo` FOREIGN KEY (`discountId`) REFERENCES `commerce_discounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_emails`
--

DROP TABLE IF EXISTS `commerce_emails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_emails` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `recipientType` enum('customer','custom') DEFAULT 'custom',
  `to` varchar(255) DEFAULT NULL,
  `bcc` varchar(255) DEFAULT NULL,
  `cc` varchar(255) DEFAULT NULL,
  `replyTo` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `templatePath` varchar(255) NOT NULL,
  `plainTextTemplatePath` varchar(255) DEFAULT NULL,
  `pdfId` int DEFAULT NULL,
  `language` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_kgckjmgnqlkdunlpqddxmoqncunxhnmbjcxy` (`pdfId`),
  CONSTRAINT `fk_kgckjmgnqlkdunlpqddxmoqncunxhnmbjcxy` FOREIGN KEY (`pdfId`) REFERENCES `commerce_pdfs` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_gateways`
--

DROP TABLE IF EXISTS `commerce_gateways`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_gateways` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `settings` text,
  `paymentType` enum('authorize','purchase') NOT NULL DEFAULT 'purchase',
  `isFrontendEnabled` tinyint(1) DEFAULT NULL,
  `isArchived` tinyint(1) DEFAULT NULL,
  `dateArchived` datetime DEFAULT NULL,
  `sortOrder` int DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_megligqmclimrarxoriuidbdkwjxyqisfrrt` (`handle`),
  KEY `idx_wcczewnmhqbjkrsoelckdolswzqbskjbvqdh` (`isArchived`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_lineitems`
--

DROP TABLE IF EXISTS `commerce_lineitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_lineitems` (
  `id` int NOT NULL AUTO_INCREMENT,
  `orderId` int NOT NULL,
  `purchasableId` int DEFAULT NULL,
  `taxCategoryId` int NOT NULL,
  `shippingCategoryId` int NOT NULL,
  `description` text,
  `options` text,
  `optionsSignature` varchar(255) NOT NULL,
  `price` decimal(14,4) unsigned NOT NULL,
  `saleAmount` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `salePrice` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `sku` varchar(255) DEFAULT NULL,
  `weight` decimal(14,4) unsigned NOT NULL DEFAULT '0.0000',
  `height` decimal(14,4) unsigned NOT NULL DEFAULT '0.0000',
  `length` decimal(14,4) unsigned NOT NULL DEFAULT '0.0000',
  `width` decimal(14,4) unsigned NOT NULL DEFAULT '0.0000',
  `subtotal` decimal(14,4) unsigned NOT NULL DEFAULT '0.0000',
  `total` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `qty` int unsigned NOT NULL,
  `note` text,
  `privateNote` text,
  `snapshot` longtext,
  `lineItemStatusId` int DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_wnppqbckcfzburzrffptfpljdasujnmcbpaa` (`orderId`,`purchasableId`,`optionsSignature`),
  KEY `idx_lefzvtqzccizhogfzbpnsmdurbrdwgcydwbr` (`purchasableId`),
  KEY `idx_vizhutcwrtvdnzusvtselphfvaxgxoetjkkx` (`taxCategoryId`),
  KEY `idx_pvclkbxteoauzezlqzkasonjgrwrlgofzylh` (`shippingCategoryId`),
  CONSTRAINT `fk_abwhabsuftnqghugxuzxgtoyvyqiegqpwmvz` FOREIGN KEY (`purchasableId`) REFERENCES `elements` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_qqywxgcswjldqpokesuahggktwdwskehmcgx` FOREIGN KEY (`orderId`) REFERENCES `commerce_orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_rwgnppghopbxddhkehlnysrszcyguuqtslta` FOREIGN KEY (`taxCategoryId`) REFERENCES `commerce_taxcategories` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_xsqkodzrwpdylcionmzbsqdvctcemfwyjrff` FOREIGN KEY (`shippingCategoryId`) REFERENCES `commerce_shippingcategories` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_lineitemstatuses`
--

DROP TABLE IF EXISTS `commerce_lineitemstatuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_lineitemstatuses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `color` enum('green','orange','red','blue','yellow','pink','purple','turquoise','light','grey','black') NOT NULL DEFAULT 'green',
  `isArchived` tinyint(1) NOT NULL DEFAULT '0',
  `dateArchived` datetime DEFAULT NULL,
  `sortOrder` int DEFAULT NULL,
  `default` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_orderadjustments`
--

DROP TABLE IF EXISTS `commerce_orderadjustments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_orderadjustments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `orderId` int NOT NULL,
  `lineItemId` int DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `amount` decimal(14,4) NOT NULL,
  `included` tinyint(1) DEFAULT NULL,
  `isEstimated` tinyint(1) NOT NULL DEFAULT '0',
  `sourceSnapshot` longtext,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_tlbumtmqavbygzmwufixhohenuojavqkdkqx` (`orderId`),
  CONSTRAINT `fk_ablanritntojmgmtryzqlnyksqonefkbibdq` FOREIGN KEY (`orderId`) REFERENCES `commerce_orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_orderhistories`
--

DROP TABLE IF EXISTS `commerce_orderhistories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_orderhistories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `orderId` int NOT NULL,
  `customerId` int NOT NULL,
  `prevStatusId` int DEFAULT NULL,
  `newStatusId` int DEFAULT NULL,
  `message` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_awthiznswemttpitgvzocmiclrxegaueunya` (`orderId`),
  KEY `idx_gmkvxygudpkpcrhdtgwsfsheazdssbnughqp` (`prevStatusId`),
  KEY `idx_uvxefcariyejibtejymrauzzvglqoaaiahhn` (`newStatusId`),
  KEY `idx_xwiduocdfuloqpyhyvancswowyyhagipxfyy` (`customerId`),
  CONSTRAINT `fk_ggbdblhvkpibrfhoywthqonohyjjbwatdxss` FOREIGN KEY (`orderId`) REFERENCES `commerce_orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_qxrevybfjeheiaqzwobaxgkerzjpkijbwflr` FOREIGN KEY (`newStatusId`) REFERENCES `commerce_orderstatuses` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_uyyjrcaabftezxmmasurhustktgjeobevnzw` FOREIGN KEY (`customerId`) REFERENCES `commerce_customers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_xzgnzqfaojshmvkqctdxgulrriaopdeyzzve` FOREIGN KEY (`prevStatusId`) REFERENCES `commerce_orderstatuses` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_ordernotices`
--

DROP TABLE IF EXISTS `commerce_ordernotices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_ordernotices` (
  `id` int NOT NULL AUTO_INCREMENT,
  `orderId` int NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `attribute` varchar(255) DEFAULT NULL,
  `message` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_pqpuvzwllkfdjxxzgbnxvxuychootpvmfwhb` (`orderId`),
  CONSTRAINT `fk_gztobjmdlrurtilettoqtslqtykdrvjnbhqa` FOREIGN KEY (`orderId`) REFERENCES `commerce_orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_orders`
--

DROP TABLE IF EXISTS `commerce_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_orders` (
  `id` int NOT NULL,
  `billingAddressId` int DEFAULT NULL,
  `shippingAddressId` int DEFAULT NULL,
  `estimatedBillingAddressId` int DEFAULT NULL,
  `estimatedShippingAddressId` int DEFAULT NULL,
  `gatewayId` int DEFAULT NULL,
  `paymentSourceId` int DEFAULT NULL,
  `customerId` int DEFAULT NULL,
  `orderStatusId` int DEFAULT NULL,
  `number` varchar(32) DEFAULT NULL,
  `reference` varchar(255) DEFAULT NULL,
  `couponCode` varchar(255) DEFAULT NULL,
  `itemTotal` decimal(14,4) DEFAULT '0.0000',
  `itemSubtotal` decimal(14,4) DEFAULT '0.0000',
  `total` decimal(14,4) DEFAULT '0.0000',
  `totalPrice` decimal(14,4) DEFAULT '0.0000',
  `totalPaid` decimal(14,4) DEFAULT '0.0000',
  `totalDiscount` decimal(14,4) DEFAULT '0.0000',
  `totalTax` decimal(14,4) DEFAULT '0.0000',
  `totalTaxIncluded` decimal(14,4) DEFAULT '0.0000',
  `totalShippingCost` decimal(14,4) DEFAULT '0.0000',
  `paidStatus` enum('paid','partial','unpaid','overPaid') DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `isCompleted` tinyint(1) DEFAULT NULL,
  `dateOrdered` datetime DEFAULT NULL,
  `datePaid` datetime DEFAULT NULL,
  `dateAuthorized` datetime DEFAULT NULL,
  `currency` varchar(255) DEFAULT NULL,
  `paymentCurrency` varchar(255) DEFAULT NULL,
  `lastIp` varchar(255) DEFAULT NULL,
  `orderLanguage` varchar(12) NOT NULL,
  `origin` enum('web','cp','remote') NOT NULL DEFAULT 'web',
  `message` text,
  `registerUserOnOrderComplete` tinyint(1) DEFAULT NULL,
  `recalculationMode` enum('all','none','adjustmentsOnly') NOT NULL DEFAULT 'all',
  `returnUrl` text,
  `cancelUrl` text,
  `shippingMethodHandle` varchar(255) DEFAULT NULL,
  `shippingMethodName` varchar(255) DEFAULT NULL,
  `orderSiteId` int DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_fyxngxsdywwknwvdcpnkjdgxlnngayotaaui` (`number`),
  KEY `idx_nqiodkrqkbrbtqwngnerfmfhapyhoecuvjne` (`reference`),
  KEY `idx_dujvmdeaorpjqhmtglhjmewuelnklsmxptur` (`billingAddressId`),
  KEY `idx_hghwlrujlefqjosuagvnzobgabjfyvlhdvws` (`shippingAddressId`),
  KEY `idx_ngbebsnuuscsoltftccspxguwpklweevtqum` (`gatewayId`),
  KEY `idx_kxqczjstrzmqbizbxhuusiotrlukdrbqayxf` (`customerId`),
  KEY `idx_uqlbfdvufcfxdwpispflxugwnfysrndmodqs` (`orderStatusId`),
  KEY `idx_nonposlykoyfwdogvbozwdkeghbtsmzxdbjq` (`email`),
  KEY `fk_umqghwfnfoealqdjijrczwnwzslhwyjqexoj` (`paymentSourceId`),
  KEY `fk_ggmtjoofoyvoguydodidtibjtgpmuicmpfqg` (`estimatedShippingAddressId`),
  KEY `fk_vplfhqdvyvtluczpbhvnineigefbxzmuxmne` (`estimatedBillingAddressId`),
  CONSTRAINT `fk_ehehlyjbzpyhusvfcpvrubltjyycskztwvno` FOREIGN KEY (`shippingAddressId`) REFERENCES `commerce_addresses` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_ggmtjoofoyvoguydodidtibjtgpmuicmpfqg` FOREIGN KEY (`estimatedShippingAddressId`) REFERENCES `commerce_addresses` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_pilgjvglzbpsxdscxlvdizmhaumhmqwzmpbg` FOREIGN KEY (`gatewayId`) REFERENCES `commerce_gateways` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_umqghwfnfoealqdjijrczwnwzslhwyjqexoj` FOREIGN KEY (`paymentSourceId`) REFERENCES `commerce_paymentsources` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_vazxartvawbxylrheavhhoouykrcsuoukile` FOREIGN KEY (`customerId`) REFERENCES `commerce_customers` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_vplfhqdvyvtluczpbhvnineigefbxzmuxmne` FOREIGN KEY (`estimatedBillingAddressId`) REFERENCES `commerce_addresses` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_xotxivpfgvmcczdlcbgdiyadbhusywhmtore` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_yysbamgeylnfokgebwrsbybzxvunesqhmxqe` FOREIGN KEY (`billingAddressId`) REFERENCES `commerce_addresses` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_zhgcpxxvdlgwyfgbnnxwqvwkshljtyrrfrkt` FOREIGN KEY (`orderStatusId`) REFERENCES `commerce_orderstatuses` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_orderstatus_emails`
--

DROP TABLE IF EXISTS `commerce_orderstatus_emails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_orderstatus_emails` (
  `id` int NOT NULL AUTO_INCREMENT,
  `orderStatusId` int NOT NULL,
  `emailId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_inaoffklvicniozpqbxjbmznriaoxzmhsdwh` (`orderStatusId`),
  KEY `idx_gjooglyvpukyghscmskyumdwesvrcmsnirio` (`emailId`),
  CONSTRAINT `fk_ihndkfgbbwiiesamjtjloekbwevjdeejyeud` FOREIGN KEY (`emailId`) REFERENCES `commerce_emails` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_xfkjvinastolpicpdovaoqzxszpfklzdlzvk` FOREIGN KEY (`orderStatusId`) REFERENCES `commerce_orderstatuses` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_orderstatuses`
--

DROP TABLE IF EXISTS `commerce_orderstatuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_orderstatuses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `color` enum('green','orange','red','blue','yellow','pink','purple','turquoise','light','grey','black') NOT NULL DEFAULT 'green',
  `description` varchar(255) DEFAULT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `sortOrder` int DEFAULT NULL,
  `default` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_paymentcurrencies`
--

DROP TABLE IF EXISTS `commerce_paymentcurrencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_paymentcurrencies` (
  `id` int NOT NULL AUTO_INCREMENT,
  `iso` varchar(3) NOT NULL,
  `primary` tinyint(1) NOT NULL DEFAULT '0',
  `rate` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_jdspahyxsgwlwmuwetmznqyiuqwgdqzgijbf` (`iso`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_paymentsources`
--

DROP TABLE IF EXISTS `commerce_paymentsources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_paymentsources` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `gatewayId` int NOT NULL,
  `token` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `response` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_frjafpwqgtuqzrivavfcalydcjqepjphxsah` (`gatewayId`),
  KEY `fk_ohtmvviupaublsokgbxslihcemtmblklobdf` (`userId`),
  CONSTRAINT `fk_frjafpwqgtuqzrivavfcalydcjqepjphxsah` FOREIGN KEY (`gatewayId`) REFERENCES `commerce_gateways` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ohtmvviupaublsokgbxslihcemtmblklobdf` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_pdfs`
--

DROP TABLE IF EXISTS `commerce_pdfs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_pdfs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `templatePath` varchar(255) NOT NULL,
  `fileNameFormat` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `isDefault` tinyint(1) DEFAULT NULL,
  `sortOrder` int DEFAULT NULL,
  `language` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_yrhrhwhahitbcoerykznhpowqxdeaxwelfpb` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_plans`
--

DROP TABLE IF EXISTS `commerce_plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_plans` (
  `id` int NOT NULL AUTO_INCREMENT,
  `gatewayId` int DEFAULT NULL,
  `planInformationId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `reference` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `planData` text,
  `isArchived` tinyint(1) NOT NULL,
  `dateArchived` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `sortOrder` int DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_joiignzwookhezhlmywuudrprymwhaliilrv` (`handle`),
  KEY `idx_lashgihgbybpkgjaetwaajrgbcrehodfzebr` (`gatewayId`),
  KEY `idx_luubpwjkgrqcajdufjaagscjgsrnadoolmqr` (`reference`),
  KEY `fk_tastxaibhkkmqyblgkkpxmrrygopgdqhtmhd` (`planInformationId`),
  CONSTRAINT `fk_caoqvfmgilttgplykyzdecntiuviptqooxtj` FOREIGN KEY (`gatewayId`) REFERENCES `commerce_gateways` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_tastxaibhkkmqyblgkkpxmrrygopgdqhtmhd` FOREIGN KEY (`planInformationId`) REFERENCES `elements` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_products`
--

DROP TABLE IF EXISTS `commerce_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_products` (
  `id` int NOT NULL,
  `typeId` int DEFAULT NULL,
  `taxCategoryId` int NOT NULL,
  `shippingCategoryId` int NOT NULL,
  `defaultVariantId` int DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `promotable` tinyint(1) DEFAULT NULL,
  `availableForPurchase` tinyint(1) DEFAULT NULL,
  `freeShipping` tinyint(1) DEFAULT NULL,
  `defaultSku` varchar(255) DEFAULT NULL,
  `defaultPrice` decimal(14,4) DEFAULT NULL,
  `defaultHeight` decimal(14,4) DEFAULT NULL,
  `defaultLength` decimal(14,4) DEFAULT NULL,
  `defaultWidth` decimal(14,4) DEFAULT NULL,
  `defaultWeight` decimal(14,4) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_efqzwbsyisbalptwkpqnhuyxuhajmmwwcljw` (`typeId`),
  KEY `idx_dwreydcwtdvqugyzvmmoaxrvjyvkqegayeyx` (`postDate`),
  KEY `idx_crznvcbboqbflqnhnfdfnfzgyesifbfquofr` (`expiryDate`),
  KEY `idx_qdbkslwafydyogfdsaxcwgtuaczoxcolosqb` (`taxCategoryId`),
  KEY `idx_twzitorbcrhvjxmmcvqokseakibavdlldxdw` (`shippingCategoryId`),
  CONSTRAINT `fk_kyoxqsjdmjrjklhldwpwzgpxjpzupotaqemt` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_rynejyextuzboazpqmvozifkbhggxmehhedi` FOREIGN KEY (`typeId`) REFERENCES `commerce_producttypes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_wtbkvtwgtmypzawurvahouxffmxsxtcnmdqw` FOREIGN KEY (`shippingCategoryId`) REFERENCES `commerce_shippingcategories` (`id`),
  CONSTRAINT `fk_zzmstyupfmoigvdotgaqxyatvtmanjuosenw` FOREIGN KEY (`taxCategoryId`) REFERENCES `commerce_taxcategories` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_producttypes`
--

DROP TABLE IF EXISTS `commerce_producttypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_producttypes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int DEFAULT NULL,
  `variantFieldLayoutId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasDimensions` tinyint(1) DEFAULT NULL,
  `hasVariants` tinyint(1) DEFAULT NULL,
  `hasVariantTitleField` tinyint(1) DEFAULT NULL,
  `titleFormat` varchar(255) NOT NULL,
  `hasProductTitleField` tinyint(1) DEFAULT NULL,
  `productTitleFormat` varchar(255) DEFAULT NULL,
  `skuFormat` varchar(255) DEFAULT NULL,
  `descriptionFormat` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_fknpxwupppymtiyjdbwqbpmojvkvaiephuvb` (`handle`),
  KEY `idx_bctrmmsitfnohqmugwpxgdljyktvvjbgqvfp` (`fieldLayoutId`),
  KEY `idx_fnikqkynncwzfdsdkuctepljjknotypboeiz` (`variantFieldLayoutId`),
  CONSTRAINT `fk_vzcqokoleuncaotclpzfctoysdftldrcrbyu` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_wywzwacrmymncyrlpufxuwalambwjvqklqih` FOREIGN KEY (`variantFieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_producttypes_shippingcategories`
--

DROP TABLE IF EXISTS `commerce_producttypes_shippingcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_producttypes_shippingcategories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `productTypeId` int NOT NULL,
  `shippingCategoryId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_qajdlpaxyvrkkktxhbbltadosxdutcefgjob` (`productTypeId`,`shippingCategoryId`),
  KEY `idx_bvzsfpsdvmjjfsgiuseizxccdmvsjusxddjj` (`shippingCategoryId`),
  CONSTRAINT `fk_pxpwinntdxrlmrhtojszdmchzidihewkiftf` FOREIGN KEY (`shippingCategoryId`) REFERENCES `commerce_shippingcategories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_sydcpyocgzvjfjaairlfjglpdjyxygjnweyq` FOREIGN KEY (`productTypeId`) REFERENCES `commerce_producttypes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_producttypes_sites`
--

DROP TABLE IF EXISTS `commerce_producttypes_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_producttypes_sites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `productTypeId` int NOT NULL,
  `siteId` int NOT NULL,
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `hasUrls` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_lznoblxnjulqyaugidblglejjxhuugdlduje` (`productTypeId`,`siteId`),
  KEY `idx_pgrcvxjdjlaknswsjympsqygqhkaolsaxaha` (`siteId`),
  CONSTRAINT `fk_qmydqsyumojrxdwskqhgxexcfytgoauisucr` FOREIGN KEY (`productTypeId`) REFERENCES `commerce_producttypes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_sjqhhzjgeduvqoxsuxuyyrugbofhskfcfmgo` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_producttypes_taxcategories`
--

DROP TABLE IF EXISTS `commerce_producttypes_taxcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_producttypes_taxcategories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `productTypeId` int NOT NULL,
  `taxCategoryId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_qlauytbrberbqmnalorqpyqhkmwoqrxeiotq` (`productTypeId`,`taxCategoryId`),
  KEY `idx_tertuwfwmynyovbbsvxfjuzkcckjrodtemox` (`taxCategoryId`),
  CONSTRAINT `fk_eayssftqbpjokogeujysgreyswoipiylpmmm` FOREIGN KEY (`productTypeId`) REFERENCES `commerce_producttypes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ubphhebkcngzcehioljcwmhzckqewxtcifev` FOREIGN KEY (`taxCategoryId`) REFERENCES `commerce_taxcategories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_purchasables`
--

DROP TABLE IF EXISTS `commerce_purchasables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_purchasables` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sku` varchar(255) NOT NULL,
  `price` decimal(14,4) NOT NULL,
  `description` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_gjxmldthruunmqfeiacnwffgbumxhwfqctpi` (`sku`),
  CONSTRAINT `fk_rxwgrgxyjdiqzsxzmljnrswjzpubrgnmkakw` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_sale_categories`
--

DROP TABLE IF EXISTS `commerce_sale_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_sale_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `saleId` int NOT NULL,
  `categoryId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_lfluqeblntpskbceamszimurasssmamtcjlu` (`saleId`,`categoryId`),
  KEY `idx_wvolzyqznmryvqgefjukgysvotvaukxnzeja` (`categoryId`),
  CONSTRAINT `fk_qqoawwwleempqqzvqhcvskuuxlbpegtivbiq` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ydklihqwycwsotvjusiqhkyhhxtzffiebddt` FOREIGN KEY (`saleId`) REFERENCES `commerce_sales` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_sale_purchasables`
--

DROP TABLE IF EXISTS `commerce_sale_purchasables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_sale_purchasables` (
  `id` int NOT NULL AUTO_INCREMENT,
  `saleId` int NOT NULL,
  `purchasableId` int NOT NULL,
  `purchasableType` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_uwazmoksgouesrrxkwvzcwqocfciwavrzkmm` (`saleId`,`purchasableId`),
  KEY `idx_icwurvfbnqksfbsxacwnpdwonwhbjldvgmds` (`purchasableId`),
  CONSTRAINT `fk_keyyisdrsbkimkhuxpzcxdztqtpxxkyixcgv` FOREIGN KEY (`purchasableId`) REFERENCES `commerce_purchasables` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_nilsytoitbsrgzgwsrlwbprxsviagrgwsqwq` FOREIGN KEY (`saleId`) REFERENCES `commerce_sales` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_sale_usergroups`
--

DROP TABLE IF EXISTS `commerce_sale_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_sale_usergroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `saleId` int NOT NULL,
  `userGroupId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_hwtmgvjnzgtiezchjxpetttixfbskleolbeg` (`saleId`,`userGroupId`),
  KEY `idx_fjgfphltecsiitpxgfllplhmdyrczjshsivk` (`userGroupId`),
  CONSTRAINT `fk_ltjmahxpqpbsrocbsddtvdgpvnaxmvhbakcw` FOREIGN KEY (`userGroupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_nqkxszzerlvmdimntxydnqhjrwjfheakslug` FOREIGN KEY (`saleId`) REFERENCES `commerce_sales` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_sales`
--

DROP TABLE IF EXISTS `commerce_sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_sales` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  `dateFrom` datetime DEFAULT NULL,
  `dateTo` datetime DEFAULT NULL,
  `apply` enum('toPercent','toFlat','byPercent','byFlat') NOT NULL,
  `applyAmount` decimal(14,4) NOT NULL,
  `allGroups` tinyint(1) DEFAULT NULL,
  `allPurchasables` tinyint(1) DEFAULT NULL,
  `allCategories` tinyint(1) DEFAULT NULL,
  `categoryRelationshipType` enum('element','sourceElement','targetElement') NOT NULL DEFAULT 'element',
  `enabled` tinyint(1) DEFAULT NULL,
  `ignorePrevious` tinyint(1) DEFAULT NULL,
  `stopProcessing` tinyint(1) DEFAULT NULL,
  `sortOrder` int DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_shippingcategories`
--

DROP TABLE IF EXISTS `commerce_shippingcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_shippingcategories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `default` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_lmkvadfvtdzcvbpyoygmwpxfafeoiqpusmgg` (`handle`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_shippingmethods`
--

DROP TABLE IF EXISTS `commerce_shippingmethods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_shippingmethods` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `isLite` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_otgnsgkpbyneaizefuotjfqzwgoydnceanbw` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_shippingrule_categories`
--

DROP TABLE IF EXISTS `commerce_shippingrule_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_shippingrule_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `shippingRuleId` int DEFAULT NULL,
  `shippingCategoryId` int DEFAULT NULL,
  `condition` enum('allow','disallow','require') NOT NULL,
  `perItemRate` decimal(14,4) DEFAULT NULL,
  `weightRate` decimal(14,4) DEFAULT NULL,
  `percentageRate` decimal(14,4) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_smsovutsxoxexqymfmgzckxllgsmoqwewzsx` (`shippingRuleId`),
  KEY `idx_orgjbetplwwqzrzixvbuwrskyhrfhzkslavc` (`shippingCategoryId`),
  CONSTRAINT `fk_uqaachnnhzdnhbcmuqnmtkcpjqztgwvdhkxh` FOREIGN KEY (`shippingCategoryId`) REFERENCES `commerce_shippingcategories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_wpgsmsxpsbozbfyxznyicjdiykgjqcxtkfux` FOREIGN KEY (`shippingRuleId`) REFERENCES `commerce_shippingrules` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_shippingrules`
--

DROP TABLE IF EXISTS `commerce_shippingrules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_shippingrules` (
  `id` int NOT NULL AUTO_INCREMENT,
  `shippingZoneId` int DEFAULT NULL,
  `methodId` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `priority` int NOT NULL DEFAULT '0',
  `enabled` tinyint(1) DEFAULT NULL,
  `minQty` int NOT NULL DEFAULT '0',
  `maxQty` int NOT NULL DEFAULT '0',
  `minTotal` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `maxTotal` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `minWeight` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `maxWeight` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `baseRate` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `perItemRate` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `weightRate` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `percentageRate` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `minRate` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `maxRate` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `isLite` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `minMaxTotalType` enum('salePrice','salePriceWithDiscounts') NOT NULL DEFAULT 'salePrice',
  `orderConditionFormula` text,
  PRIMARY KEY (`id`),
  KEY `idx_jgwseiffigauicvygmvfyptxwyhcuicwrota` (`name`),
  KEY `idx_jjgddwuisnftfdswdnsapboeoahviquyvrqd` (`methodId`),
  KEY `idx_wovaxuedertujruzdqjmaiyrbuaxfpgkyekb` (`shippingZoneId`),
  CONSTRAINT `fk_lmiiwnkcqwnftpuzdrtxzxwpmyifavyxokri` FOREIGN KEY (`shippingZoneId`) REFERENCES `commerce_shippingzones` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_xvtbobdicprvdssouyiydrvwypzvlcgbztcg` FOREIGN KEY (`methodId`) REFERENCES `commerce_shippingmethods` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_shippingzone_countries`
--

DROP TABLE IF EXISTS `commerce_shippingzone_countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_shippingzone_countries` (
  `id` int NOT NULL AUTO_INCREMENT,
  `shippingZoneId` int NOT NULL,
  `countryId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_pxsxkxmmxtzlhjxgzeckgmfmmbfmodhuzlmt` (`shippingZoneId`,`countryId`),
  KEY `idx_ppsevngzlitopbyynzpulvojoalbvoyqwtpt` (`shippingZoneId`),
  KEY `idx_adklcygkdascotjmcqajlihtkqaacxxwxvlj` (`countryId`),
  CONSTRAINT `fk_lawtxsktswlwxywfunkdpbjjoxmfwlmlxbbd` FOREIGN KEY (`countryId`) REFERENCES `commerce_countries` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_zllbsutipmtmudpwryyaoztfwdkocimmldks` FOREIGN KEY (`shippingZoneId`) REFERENCES `commerce_shippingzones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_shippingzone_states`
--

DROP TABLE IF EXISTS `commerce_shippingzone_states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_shippingzone_states` (
  `id` int NOT NULL AUTO_INCREMENT,
  `shippingZoneId` int NOT NULL,
  `stateId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_szkysdpolcxcmfuqizwrfycerwxrbwqxcdzz` (`shippingZoneId`,`stateId`),
  KEY `idx_idcghbppxgpwajxwhboexicjbwuqlldnmvus` (`shippingZoneId`),
  KEY `idx_abjiagckhevhdnevjetcvuttanycvehpfhos` (`stateId`),
  CONSTRAINT `fk_japievcyqjokbsbbshcojrumqvcgebuomsil` FOREIGN KEY (`stateId`) REFERENCES `commerce_states` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_xtgukmzrpmrssafynvjpucxcomuulvgypvwd` FOREIGN KEY (`shippingZoneId`) REFERENCES `commerce_shippingzones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_shippingzones`
--

DROP TABLE IF EXISTS `commerce_shippingzones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_shippingzones` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `isCountryBased` tinyint(1) DEFAULT NULL,
  `zipCodeConditionFormula` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_cfruxunialxlylzhivnxrqdbfkofqklhrzgr` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_states`
--

DROP TABLE IF EXISTS `commerce_states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_states` (
  `id` int NOT NULL AUTO_INCREMENT,
  `countryId` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `abbreviation` varchar(255) DEFAULT NULL,
  `sortOrder` int DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_fzdhnyogjgzlblbtxaoevvsscrvkfsxioudk` (`countryId`,`name`),
  UNIQUE KEY `idx_ckluocgiyiklbheioivayuzhrodnubrjfwpr` (`countryId`,`abbreviation`),
  KEY `idx_rrdjylwibyyztcijgowyjfulzupoxcrmefnj` (`countryId`),
  CONSTRAINT `fk_ecvremsvnwohuitbzoevfxqvpujgqwrtbgqf` FOREIGN KEY (`countryId`) REFERENCES `commerce_countries` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_subscriptions`
--

DROP TABLE IF EXISTS `commerce_subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_subscriptions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `planId` int DEFAULT NULL,
  `gatewayId` int DEFAULT NULL,
  `orderId` int DEFAULT NULL,
  `reference` varchar(255) NOT NULL,
  `subscriptionData` text,
  `trialDays` int NOT NULL,
  `nextPaymentDate` datetime DEFAULT NULL,
  `hasStarted` tinyint(1) NOT NULL DEFAULT '1',
  `isSuspended` tinyint(1) NOT NULL DEFAULT '0',
  `dateSuspended` datetime DEFAULT NULL,
  `isCanceled` tinyint(1) NOT NULL,
  `dateCanceled` datetime DEFAULT NULL,
  `isExpired` tinyint(1) NOT NULL,
  `dateExpired` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_upmnylporcxshbywloirnzjedmncgoneweyx` (`reference`),
  KEY `idx_jhdvruzdynuzpownnlfwnjwtwucmxzjwezqm` (`userId`),
  KEY `idx_sxcvdukwqfzcbbaiewwinbikdzpzxjoruitz` (`planId`),
  KEY `idx_sgdcyclhwvnirzpaoewdcyphggntdvgugucg` (`gatewayId`),
  KEY `idx_qezdospijabumxgkytewzdtiaazuwpuzyphh` (`nextPaymentDate`),
  KEY `idx_mzxsadbtgkfkypyorgnhgxndqkmjqmucjntb` (`dateCreated`),
  KEY `idx_fbyravwdqxddhmchlmmenzkdzcyhplwplxhl` (`dateExpired`),
  KEY `fk_inyhvhdbnihajgrbbudwbyhhaqmvsqlwnulk` (`orderId`),
  CONSTRAINT `fk_dzgssfjpysqiicdavtxipjrwzutiuwfroveq` FOREIGN KEY (`gatewayId`) REFERENCES `commerce_gateways` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `fk_inyhvhdbnihajgrbbudwbyhhaqmvsqlwnulk` FOREIGN KEY (`orderId`) REFERENCES `commerce_orders` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_rlekktyccloeiwubwztltyefcokiruzxhtce` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `fk_vojbvjukyqbuipsduyrdgwzsjoruitucvgpu` FOREIGN KEY (`planId`) REFERENCES `commerce_plans` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `fk_wbzfwzhjrhbbxyrmpnfivvtydvnhurkoyrws` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_taxcategories`
--

DROP TABLE IF EXISTS `commerce_taxcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_taxcategories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `default` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_upsbvgyhdpjkdjmawmeophbucczwdiezybdb` (`handle`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_taxrates`
--

DROP TABLE IF EXISTS `commerce_taxrates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_taxrates` (
  `id` int NOT NULL AUTO_INCREMENT,
  `taxZoneId` int DEFAULT NULL,
  `isEverywhere` tinyint(1) DEFAULT NULL,
  `taxCategoryId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `rate` decimal(14,10) NOT NULL,
  `include` tinyint(1) DEFAULT NULL,
  `removeIncluded` tinyint(1) DEFAULT NULL,
  `removeVatIncluded` tinyint(1) DEFAULT NULL,
  `isVat` tinyint(1) DEFAULT NULL,
  `taxable` enum('price','shipping','price_shipping','order_total_shipping','order_total_price') NOT NULL,
  `isLite` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_pgrsawsjcukqvpcjcwcimtouxbuqdszmftus` (`taxZoneId`),
  KEY `idx_zxyclfygoyuevcesimalzbnvakerstnwqtxz` (`taxCategoryId`),
  CONSTRAINT `fk_kcwyfaujgbetxzqdtyfnmqfebwxipckobfpr` FOREIGN KEY (`taxZoneId`) REFERENCES `commerce_taxzones` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_yqphuemmfwvbuulkdxlewayioooqqjktudnx` FOREIGN KEY (`taxCategoryId`) REFERENCES `commerce_taxcategories` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_taxzone_countries`
--

DROP TABLE IF EXISTS `commerce_taxzone_countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_taxzone_countries` (
  `id` int NOT NULL AUTO_INCREMENT,
  `taxZoneId` int NOT NULL,
  `countryId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_wlstulxcrapnsboglpumcphrrltnsiqudghb` (`taxZoneId`,`countryId`),
  KEY `idx_myinjnkidzrxhaawwueavwvtbskzaxiitqlm` (`taxZoneId`),
  KEY `idx_gtagmxaghnfzifmylhqqcjqhfoqypittrvko` (`countryId`),
  CONSTRAINT `fk_aqrinuwdrxlnzadyejppwqwxixgfjhavifcv` FOREIGN KEY (`taxZoneId`) REFERENCES `commerce_taxzones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_jqsugefhoblezzsopdygumjzqmnlktsxxwqb` FOREIGN KEY (`countryId`) REFERENCES `commerce_countries` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_taxzone_states`
--

DROP TABLE IF EXISTS `commerce_taxzone_states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_taxzone_states` (
  `id` int NOT NULL AUTO_INCREMENT,
  `taxZoneId` int NOT NULL,
  `stateId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_hyiqhqwmxlrtlqrmdrgrhtuswzvbffeamwnd` (`taxZoneId`,`stateId`),
  KEY `idx_elzhhwzogyvmywtruldujagbbrfmowsrdlct` (`taxZoneId`),
  KEY `idx_pjzfpzrpmmpaquoqhtefejkrfolvdyttbwjk` (`stateId`),
  CONSTRAINT `fk_qxzzewpekublsagnsrkobvuuyapzwwoidmme` FOREIGN KEY (`taxZoneId`) REFERENCES `commerce_taxzones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_wbidpmpfxvcitafphqcpbmrxlecmeotrblfa` FOREIGN KEY (`stateId`) REFERENCES `commerce_states` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_taxzones`
--

DROP TABLE IF EXISTS `commerce_taxzones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_taxzones` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `isCountryBased` tinyint(1) DEFAULT NULL,
  `zipCodeConditionFormula` text,
  `default` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_qtfbthuowjzjcembrhkncxwrmvvipwowdmve` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_transactions`
--

DROP TABLE IF EXISTS `commerce_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_transactions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `orderId` int NOT NULL,
  `parentId` int DEFAULT NULL,
  `gatewayId` int DEFAULT NULL,
  `userId` int DEFAULT NULL,
  `hash` varchar(32) DEFAULT NULL,
  `type` enum('authorize','capture','purchase','refund') NOT NULL,
  `amount` decimal(14,4) DEFAULT NULL,
  `paymentAmount` decimal(14,4) DEFAULT NULL,
  `currency` varchar(255) DEFAULT NULL,
  `paymentCurrency` varchar(255) DEFAULT NULL,
  `paymentRate` decimal(14,4) DEFAULT NULL,
  `status` enum('pending','redirect','success','failed','processing') NOT NULL,
  `reference` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `message` text,
  `note` mediumtext,
  `response` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_ccoomkqvypppavsfwddjdhcfxhviylbzekxa` (`parentId`),
  KEY `idx_cfswmlcjvrmifzddqrvogndaufaulcefxvcw` (`gatewayId`),
  KEY `idx_zteuvperywwwemehokcnfwdpupwnhrgmsqjm` (`orderId`),
  KEY `idx_mptecayhgovdftsyoiqgixkzafbmtenbcwqj` (`userId`),
  CONSTRAINT `fk_ehohbepmkkactjslekwvmkqxqcfwukahlqiy` FOREIGN KEY (`parentId`) REFERENCES `commerce_transactions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_fndwzzwzarpaweaadbynpuwpmznqelggipxt` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_kbuaxixabcbiwzcbvetwlognbufqlkpliumr` FOREIGN KEY (`orderId`) REFERENCES `commerce_orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_okjmcvjevvvftwljvbnnsheqzlflpuggzjqs` FOREIGN KEY (`gatewayId`) REFERENCES `commerce_gateways` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_variants`
--

DROP TABLE IF EXISTS `commerce_variants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_variants` (
  `id` int NOT NULL,
  `productId` int DEFAULT NULL,
  `sku` varchar(255) NOT NULL,
  `isDefault` tinyint(1) DEFAULT NULL,
  `price` decimal(14,4) NOT NULL,
  `sortOrder` int DEFAULT NULL,
  `width` decimal(14,4) DEFAULT NULL,
  `height` decimal(14,4) DEFAULT NULL,
  `length` decimal(14,4) DEFAULT NULL,
  `weight` decimal(14,4) DEFAULT NULL,
  `stock` int NOT NULL DEFAULT '0',
  `hasUnlimitedStock` tinyint(1) DEFAULT NULL,
  `minQty` int DEFAULT NULL,
  `maxQty` int DEFAULT NULL,
  `deletedWithProduct` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_juvkxgthupbzamorpowgfrdwnjzvhkxsptka` (`sku`),
  KEY `idx_uygkztockcncqvychhgqplijsobbawrokbth` (`productId`),
  CONSTRAINT `fk_ipjnbnzzhbyoqrbknyekgchcxbhqjovcqzkm` FOREIGN KEY (`productId`) REFERENCES `commerce_products` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_sqlojqxgisdmbbptpfwjxsxfdbutbjpazhbm` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `content`
--

DROP TABLE IF EXISTS `content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `content` (
  `id` int NOT NULL AUTO_INCREMENT,
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_optimizedImages` text,
  `field_seo` text,
  `field_richText` text,
  `field_plainText` text,
  `field_someImages_hjezvijy` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `content_siteId_idx` (`siteId`),
  KEY `content_title_idx` (`title`),
  CONSTRAINT `content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craftidtokens`
--

DROP TABLE IF EXISTS `craftidtokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craftidtokens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `accessToken` text NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craftidtokens_userId_fk` (`userId`),
  CONSTRAINT `craftidtokens_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `deprecationerrors`
--

DROP TABLE IF EXISTS `deprecationerrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deprecationerrors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `fingerprint` varchar(255) NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` smallint unsigned DEFAULT NULL,
  `message` text,
  `traces` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `deprecationerrors_key_fingerprint_unq_idx` (`key`,`fingerprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `digitalproducts_licenses`
--

DROP TABLE IF EXISTS `digitalproducts_licenses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `digitalproducts_licenses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `productId` int NOT NULL,
  `orderId` int DEFAULT NULL,
  `licenseKey` varchar(255) NOT NULL,
  `ownerName` varchar(255) DEFAULT NULL,
  `ownerEmail` varchar(255) NOT NULL,
  `userId` int DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_foxzwawssncmsmojyktpbngcjjftxtjmdafw` (`licenseKey`),
  KEY `idx_enxaavvvfopvdtoxkseuoydcsexitoyxlzba` (`orderId`),
  KEY `idx_ecfwfywzewspkiziqhqlixovlcmwdqwuclrm` (`productId`),
  KEY `fk_dkvrstjotygfxexnrikyovmbxvkmqsxxxbjm` (`userId`),
  CONSTRAINT `fk_dkvrstjotygfxexnrikyovmbxvkmqsxxxbjm` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_gntugoisayajsncyjmalhehjfjetvucqvpeg` FOREIGN KEY (`productId`) REFERENCES `digitalproducts_products` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `fk_gswsootlhwddzwralhapqnfvfdinyokwkteg` FOREIGN KEY (`orderId`) REFERENCES `commerce_orders` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_knebqolmabpwqygddhnjzkkbqqmalursomno` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `digitalproducts_products`
--

DROP TABLE IF EXISTS `digitalproducts_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `digitalproducts_products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `typeId` int NOT NULL,
  `taxCategoryId` int NOT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `promotable` tinyint(1) NOT NULL,
  `sku` varchar(255) NOT NULL,
  `price` decimal(14,4) unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_nlajvprvpdszjfmlygjqmuqezvcxlgsvyrfs` (`sku`),
  KEY `idx_tujqhewwtadmzcakyupgyuvbrhlagxbrgxhe` (`typeId`),
  KEY `idx_eupdqcwbrgeposwfdqmqzumktgizrgzscglf` (`taxCategoryId`),
  CONSTRAINT `fk_dujmzsuntfbnwxvufzdegiacurddcwfnklww` FOREIGN KEY (`typeId`) REFERENCES `digitalproducts_producttypes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_hdbkvkgbequkqsoefpxvosbklfkdfbqnovzx` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_hidaqzzzceylfggkxnnlxvnwzzudrixhbwqt` FOREIGN KEY (`taxCategoryId`) REFERENCES `commerce_taxcategories` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `digitalproducts_producttypes`
--

DROP TABLE IF EXISTS `digitalproducts_producttypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `digitalproducts_producttypes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `skuFormat` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_lhisjwdmmjuszfmhpcagwwuuucpobxtnctha` (`handle`),
  KEY `idx_hddgduwsinglyelbhbvcadrwrkbceiqaxixy` (`fieldLayoutId`),
  CONSTRAINT `fk_yicxryedchyqbvzskdugzetsmvducwwfomew` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `digitalproducts_producttypes_sites`
--

DROP TABLE IF EXISTS `digitalproducts_producttypes_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `digitalproducts_producttypes_sites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `productTypeId` int NOT NULL,
  `siteId` int NOT NULL,
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `hasUrls` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_dbozbrmmsyusnvjqcfpczqacbedahhdknbbk` (`productTypeId`,`siteId`),
  KEY `idx_xirepegqovsbrakwqcsyashoteiettiajiox` (`siteId`),
  CONSTRAINT `fk_alistupjnfapoetfveiihbopkuognzmlopwl` FOREIGN KEY (`productTypeId`) REFERENCES `digitalproducts_producttypes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_fsoozqubabskdtyfsmfdaedzscsphnirngak` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `drafts`
--

DROP TABLE IF EXISTS `drafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drafts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sourceId` int DEFAULT NULL,
  `creatorId` int DEFAULT NULL,
  `provisional` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `notes` text,
  `trackChanges` tinyint(1) NOT NULL DEFAULT '0',
  `dateLastMerged` datetime DEFAULT NULL,
  `saved` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `drafts_creatorId_fk` (`creatorId`),
  KEY `drafts_sourceId_fk` (`sourceId`),
  KEY `idx_tnitxhbukaspzkfjftipesmpqcpuatbycdqb` (`saved`),
  KEY `idx_naemymngrcwmhwqstopnhsqltshzgtxqallj` (`creatorId`,`provisional`),
  CONSTRAINT `drafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `drafts_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `elementindexsettings`
--

DROP TABLE IF EXISTS `elementindexsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elementindexsettings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `elements`
--

DROP TABLE IF EXISTS `elements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elements` (
  `id` int NOT NULL AUTO_INCREMENT,
  `canonicalId` int DEFAULT NULL,
  `draftId` int DEFAULT NULL,
  `revisionId` int DEFAULT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateLastMerged` datetime DEFAULT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `elements_dateDeleted_idx` (`dateDeleted`),
  KEY `elements_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `elements_type_idx` (`type`),
  KEY `elements_enabled_idx` (`enabled`),
  KEY `elements_archived_dateCreated_idx` (`archived`,`dateCreated`),
  KEY `elements_draftId_fk` (`draftId`),
  KEY `elements_revisionId_fk` (`revisionId`),
  KEY `fk_kxrxmydyrnhlgywqhpafnppyywxyrdqznpkl` (`canonicalId`),
  KEY `idx_uhnuneuolihdolaacmtjwcscyzzyonjmzder` (`archived`,`dateDeleted`,`draftId`,`revisionId`,`canonicalId`),
  KEY `idx_knfykllrhszxatqcydzabiwjihjqhrtzxagm` (`archived`,`dateDeleted`,`draftId`,`revisionId`,`canonicalId`,`enabled`),
  CONSTRAINT `elements_draftId_fk` FOREIGN KEY (`draftId`) REFERENCES `drafts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `elements_revisionId_fk` FOREIGN KEY (`revisionId`) REFERENCES `revisions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_kxrxmydyrnhlgywqhpafnppyywxyrdqznpkl` FOREIGN KEY (`canonicalId`) REFERENCES `elements` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `elements_sites`
--

DROP TABLE IF EXISTS `elements_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elements_sites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elements_sites_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `elements_sites_siteId_idx` (`siteId`),
  KEY `elements_sites_slug_siteId_idx` (`slug`,`siteId`),
  KEY `elements_sites_enabled_idx` (`enabled`),
  KEY `elements_sites_uri_siteId_idx` (`uri`,`siteId`),
  CONSTRAINT `elements_sites_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `elements_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entries`
--

DROP TABLE IF EXISTS `entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entries` (
  `id` int NOT NULL,
  `sectionId` int NOT NULL,
  `parentId` int DEFAULT NULL,
  `typeId` int NOT NULL,
  `authorId` int DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `deletedWithEntryType` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entries_postDate_idx` (`postDate`),
  KEY `entries_expiryDate_idx` (`expiryDate`),
  KEY `entries_authorId_idx` (`authorId`),
  KEY `entries_sectionId_idx` (`sectionId`),
  KEY `entries_typeId_idx` (`typeId`),
  KEY `entries_parentId_fk` (`parentId`),
  CONSTRAINT `entries_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `entries` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `entrytypes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_cbcwxattwywnhxvahzlaekvvhrnmreluzgxw` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entrytypes`
--

DROP TABLE IF EXISTS `entrytypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entrytypes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sectionId` int NOT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT '1',
  `titleTranslationMethod` varchar(255) NOT NULL DEFAULT 'site',
  `titleTranslationKeyFormat` text,
  `titleFormat` varchar(255) DEFAULT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entrytypes_name_sectionId_idx` (`name`,`sectionId`),
  KEY `entrytypes_handle_sectionId_idx` (`handle`,`sectionId`),
  KEY `entrytypes_sectionId_idx` (`sectionId`),
  KEY `entrytypes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `entrytypes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldgroups`
--

DROP TABLE IF EXISTS `fieldgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldgroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldgroups_name_idx` (`name`),
  KEY `idx_xkjrkcadnxgnxscxrnprbfrqhdsjkfbgbtnb` (`dateDeleted`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldlayoutfields`
--

DROP TABLE IF EXISTS `fieldlayoutfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayoutfields` (
  `id` int NOT NULL AUTO_INCREMENT,
  `layoutId` int NOT NULL,
  `tabId` int NOT NULL,
  `fieldId` int NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldlayoutfields_layoutId_fieldId_unq_idx` (`layoutId`,`fieldId`),
  KEY `fieldlayoutfields_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayoutfields_tabId_idx` (`tabId`),
  KEY `fieldlayoutfields_fieldId_idx` (`fieldId`),
  CONSTRAINT `fieldlayoutfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_tabId_fk` FOREIGN KEY (`tabId`) REFERENCES `fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldlayouts`
--

DROP TABLE IF EXISTS `fieldlayouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayouts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouts_dateDeleted_idx` (`dateDeleted`),
  KEY `fieldlayouts_type_idx` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldlayouttabs`
--

DROP TABLE IF EXISTS `fieldlayouttabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayouttabs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `layoutId` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `elements` text,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouttabs_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayouttabs_layoutId_idx` (`layoutId`),
  CONSTRAINT `fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fields`
--

DROP TABLE IF EXISTS `fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fields` (
  `id` int NOT NULL AUTO_INCREMENT,
  `groupId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `context` varchar(255) NOT NULL DEFAULT 'global',
  `columnSuffix` char(8) DEFAULT NULL,
  `instructions` text,
  `searchable` tinyint(1) NOT NULL DEFAULT '1',
  `translationMethod` varchar(255) NOT NULL DEFAULT 'none',
  `translationKeyFormat` text,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fields_groupId_idx` (`groupId`),
  KEY `fields_context_idx` (`context`),
  KEY `fields_handle_context_idx` (`handle`,`context`),
  CONSTRAINT `fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `globalsets`
--

DROP TABLE IF EXISTS `globalsets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `globalsets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `globalsets_name_idx` (`name`),
  KEY `globalsets_handle_idx` (`handle`),
  KEY `globalsets_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `idx_cjuamshrygmaoodggotwdcgmgqmwdpqvejfz` (`sortOrder`),
  CONSTRAINT `globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gqlschemas`
--

DROP TABLE IF EXISTS `gqlschemas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gqlschemas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `scope` text,
  `isPublic` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gqltokens`
--

DROP TABLE IF EXISTS `gqltokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gqltokens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `accessToken` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `expiryDate` datetime DEFAULT NULL,
  `lastUsed` datetime DEFAULT NULL,
  `schemaId` int DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `gqltokens_accessToken_unq_idx` (`accessToken`),
  UNIQUE KEY `gqltokens_name_unq_idx` (`name`),
  KEY `gqltokens_schemaId_fk` (`schemaId`),
  CONSTRAINT `gqltokens_schemaId_fk` FOREIGN KEY (`schemaId`) REFERENCES `gqlschemas` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `info`
--

DROP TABLE IF EXISTS `info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `maintenance` tinyint(1) NOT NULL DEFAULT '0',
  `configVersion` char(12) NOT NULL DEFAULT '000000000000',
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixblocks`
--

DROP TABLE IF EXISTS `matrixblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixblocks` (
  `id` int NOT NULL,
  `ownerId` int NOT NULL,
  `fieldId` int NOT NULL,
  `typeId` int NOT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `deletedWithOwner` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `matrixblocks_ownerId_idx` (`ownerId`),
  KEY `matrixblocks_fieldId_idx` (`fieldId`),
  KEY `matrixblocks_typeId_idx` (`typeId`),
  KEY `matrixblocks_sortOrder_idx` (`sortOrder`),
  CONSTRAINT `matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixblocktypes`
--

DROP TABLE IF EXISTS `matrixblocktypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixblocktypes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fieldId` int NOT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `matrixblocktypes_fieldId_idx` (`fieldId`),
  KEY `matrixblocktypes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `matrixblocktypes_name_fieldId_idx` (`name`,`fieldId`),
  KEY `matrixblocktypes_handle_fieldId_idx` (`handle`,`fieldId`),
  CONSTRAINT `matrixblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `track` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `migrations_track_name_unq_idx` (`track`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=392 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugins`
--

DROP TABLE IF EXISTS `plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugins` (
  `id` int NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `schemaVersion` varchar(255) NOT NULL,
  `licenseKeyStatus` enum('valid','trial','invalid','mismatched','astray','unknown') NOT NULL DEFAULT 'unknown',
  `licensedEdition` varchar(255) DEFAULT NULL,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `plugins_handle_unq_idx` (`handle`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projectconfig`
--

DROP TABLE IF EXISTS `projectconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projectconfig` (
  `path` varchar(255) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `queue`
--

DROP TABLE IF EXISTS `queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queue` (
  `id` int NOT NULL AUTO_INCREMENT,
  `channel` varchar(255) NOT NULL DEFAULT 'queue',
  `job` longblob NOT NULL,
  `description` text,
  `timePushed` int NOT NULL,
  `ttr` int NOT NULL,
  `delay` int NOT NULL DEFAULT '0',
  `priority` int unsigned NOT NULL DEFAULT '1024',
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int DEFAULT NULL,
  `progress` smallint NOT NULL DEFAULT '0',
  `progressLabel` varchar(255) DEFAULT NULL,
  `attempt` int DEFAULT NULL,
  `fail` tinyint(1) DEFAULT '0',
  `dateFailed` datetime DEFAULT NULL,
  `error` text,
  PRIMARY KEY (`id`),
  KEY `queue_channel_fail_timeUpdated_timePushed_idx` (`channel`,`fail`,`timeUpdated`,`timePushed`),
  KEY `queue_channel_fail_timeUpdated_delay_idx` (`channel`,`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `relations`
--

DROP TABLE IF EXISTS `relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fieldId` int NOT NULL,
  `sourceId` int NOT NULL,
  `sourceSiteId` int DEFAULT NULL,
  `targetId` int NOT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `relations_fieldId_sourceId_sourceSiteId_targetId_unq_idx` (`fieldId`,`sourceId`,`sourceSiteId`,`targetId`),
  KEY `relations_sourceId_idx` (`sourceId`),
  KEY `relations_targetId_idx` (`targetId`),
  KEY `relations_sourceSiteId_idx` (`sourceSiteId`),
  CONSTRAINT `relations_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `relations_targetId_fk` FOREIGN KEY (`targetId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resourcepaths`
--

DROP TABLE IF EXISTS `resourcepaths`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resourcepaths` (
  `hash` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `retour_redirects`
--

DROP TABLE IF EXISTS `retour_redirects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `retour_redirects` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `siteId` int DEFAULT NULL,
  `associatedElementId` int NOT NULL,
  `enabled` tinyint(1) DEFAULT '1',
  `redirectSrcUrl` varchar(255) DEFAULT '',
  `redirectSrcUrlParsed` varchar(255) DEFAULT '',
  `redirectSrcMatch` varchar(32) DEFAULT 'pathonly',
  `redirectMatchType` varchar(32) DEFAULT 'exactmatch',
  `redirectDestUrl` varchar(255) DEFAULT '',
  `redirectHttpCode` int DEFAULT '301',
  `hitCount` int DEFAULT '1',
  `hitLastTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `retour_redirects_redirectSrcUrlParsed_idx` (`redirectSrcUrlParsed`),
  KEY `retour_redirects_redirectSrcUrl_idx` (`redirectSrcUrl`),
  KEY `retour_redirects_siteId_idx` (`siteId`),
  KEY `retour_redirects_associatedElementId_fk` (`associatedElementId`),
  CONSTRAINT `retour_redirects_associatedElementId_fk` FOREIGN KEY (`associatedElementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `retour_static_redirects`
--

DROP TABLE IF EXISTS `retour_static_redirects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `retour_static_redirects` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `siteId` int DEFAULT NULL,
  `associatedElementId` int NOT NULL,
  `enabled` tinyint(1) DEFAULT '1',
  `redirectSrcUrl` varchar(255) DEFAULT '',
  `redirectSrcUrlParsed` varchar(255) DEFAULT '',
  `redirectSrcMatch` varchar(32) DEFAULT 'pathonly',
  `redirectMatchType` varchar(32) DEFAULT 'exactmatch',
  `redirectDestUrl` varchar(255) DEFAULT '',
  `redirectHttpCode` int DEFAULT '301',
  `hitCount` int DEFAULT '1',
  `hitLastTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `retour_static_redirects_redirectSrcUrlParsed_idx` (`redirectSrcUrlParsed`),
  KEY `retour_static_redirects_redirectSrcUrl_idx` (`redirectSrcUrl`),
  KEY `retour_static_redirects_siteId_idx` (`siteId`),
  CONSTRAINT `retour_static_redirects_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `retour_stats`
--

DROP TABLE IF EXISTS `retour_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `retour_stats` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `siteId` int DEFAULT NULL,
  `redirectSrcUrl` varchar(255) DEFAULT '',
  `referrerUrl` varchar(2000) DEFAULT '',
  `remoteIp` varchar(45) DEFAULT '',
  `userAgent` varchar(255) DEFAULT '',
  `exceptionMessage` varchar(255) DEFAULT '',
  `exceptionFilePath` varchar(255) DEFAULT '',
  `exceptionFileLine` int DEFAULT '0',
  `hitCount` int DEFAULT '1',
  `hitLastTime` datetime DEFAULT NULL,
  `handledByRetour` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `retour_stats_redirectSrcUrl_idx` (`redirectSrcUrl`),
  KEY `retour_stats_siteId_idx` (`siteId`),
  CONSTRAINT `retour_stats_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `revisions`
--

DROP TABLE IF EXISTS `revisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `revisions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sourceId` int NOT NULL,
  `creatorId` int DEFAULT NULL,
  `num` int NOT NULL,
  `notes` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `revisions_sourceId_num_unq_idx` (`sourceId`,`num`),
  KEY `revisions_creatorId_fk` (`creatorId`),
  CONSTRAINT `revisions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `revisions_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `searchindex`
--

DROP TABLE IF EXISTS `searchindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `searchindex` (
  `elementId` int NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int NOT NULL,
  `siteId` int NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `searchindex_keywords_idx` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections` (
  `id` int NOT NULL AUTO_INCREMENT,
  `structureId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('single','channel','structure') NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint(1) NOT NULL DEFAULT '0',
  `propagationMethod` varchar(255) NOT NULL DEFAULT 'all',
  `defaultPlacement` enum('beginning','end') NOT NULL DEFAULT 'end',
  `previewTargets` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sections_handle_idx` (`handle`),
  KEY `sections_name_idx` (`name`),
  KEY `sections_structureId_idx` (`structureId`),
  KEY `sections_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sections_sites`
--

DROP TABLE IF EXISTS `sections_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections_sites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sectionId` int NOT NULL,
  `siteId` int NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sections_sites_sectionId_siteId_unq_idx` (`sectionId`,`siteId`),
  KEY `sections_sites_siteId_idx` (`siteId`),
  CONSTRAINT `sections_sites_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sections_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `seomatic_metabundles`
--

DROP TABLE IF EXISTS `seomatic_metabundles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seomatic_metabundles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `bundleVersion` varchar(255) NOT NULL DEFAULT '',
  `sourceBundleType` varchar(255) NOT NULL DEFAULT '',
  `sourceId` int DEFAULT NULL,
  `sourceName` varchar(255) NOT NULL DEFAULT '',
  `sourceHandle` varchar(255) NOT NULL DEFAULT '',
  `sourceType` varchar(64) NOT NULL DEFAULT '',
  `typeId` int DEFAULT NULL,
  `sourceTemplate` varchar(500) DEFAULT '',
  `sourceSiteId` int DEFAULT NULL,
  `sourceAltSiteSettings` text,
  `sourceDateUpdated` datetime NOT NULL,
  `metaGlobalVars` text,
  `metaSiteVars` text,
  `metaSitemapVars` text,
  `metaContainers` text,
  `redirectsContainer` text,
  `frontendTemplatesContainer` text,
  `metaBundleSettings` text,
  PRIMARY KEY (`id`),
  KEY `seomatic_metabundles_sourceBundleType_idx` (`sourceBundleType`),
  KEY `seomatic_metabundles_sourceId_idx` (`sourceId`),
  KEY `seomatic_metabundles_sourceSiteId_idx` (`sourceSiteId`),
  KEY `seomatic_metabundles_sourceHandle_idx` (`sourceHandle`),
  CONSTRAINT `seomatic_metabundles_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sequences`
--

DROP TABLE IF EXISTS `sequences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sequences` (
  `name` varchar(255) NOT NULL,
  `next` int unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `token` char(100) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sessions_uid_idx` (`uid`),
  KEY `sessions_token_idx` (`token`),
  KEY `sessions_dateUpdated_idx` (`dateUpdated`),
  KEY `sessions_userId_idx` (`userId`),
  CONSTRAINT `sessions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=194 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shunnedmessages`
--

DROP TABLE IF EXISTS `shunnedmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shunnedmessages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `message` varchar(255) NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `shunnedmessages_userId_message_unq_idx` (`userId`,`message`),
  CONSTRAINT `shunnedmessages_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sitegroups`
--

DROP TABLE IF EXISTS `sitegroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sitegroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sitegroups_name_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sites`
--

DROP TABLE IF EXISTS `sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `groupId` int NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '0',
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sites_dateDeleted_idx` (`dateDeleted`),
  KEY `sites_handle_idx` (`handle`),
  KEY `sites_sortOrder_idx` (`sortOrder`),
  KEY `sites_groupId_fk` (`groupId`),
  CONSTRAINT `sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `structureelements`
--

DROP TABLE IF EXISTS `structureelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `structureelements` (
  `id` int NOT NULL AUTO_INCREMENT,
  `structureId` int NOT NULL,
  `elementId` int DEFAULT NULL,
  `root` int unsigned DEFAULT NULL,
  `lft` int unsigned NOT NULL,
  `rgt` int unsigned NOT NULL,
  `level` smallint unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `structureelements_structureId_elementId_unq_idx` (`structureId`,`elementId`),
  KEY `structureelements_root_idx` (`root`),
  KEY `structureelements_lft_idx` (`lft`),
  KEY `structureelements_rgt_idx` (`rgt`),
  KEY `structureelements_level_idx` (`level`),
  KEY `structureelements_elementId_idx` (`elementId`),
  CONSTRAINT `structureelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `structureelements_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `structures`
--

DROP TABLE IF EXISTS `structures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `structures` (
  `id` int NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `structures_dateDeleted_idx` (`dateDeleted`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `systemmessages`
--

DROP TABLE IF EXISTS `systemmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `systemmessages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `language` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `systemmessages_key_language_unq_idx` (`key`,`language`),
  KEY `systemmessages_language_idx` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `taggroups`
--

DROP TABLE IF EXISTS `taggroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taggroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `taggroups_name_idx` (`name`),
  KEY `taggroups_handle_idx` (`handle`),
  KEY `taggroups_dateDeleted_idx` (`dateDeleted`),
  KEY `taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `id` int NOT NULL,
  `groupId` int NOT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `tags_groupId_idx` (`groupId`),
  CONSTRAINT `tags_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tags_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `templatecacheelements`
--

DROP TABLE IF EXISTS `templatecacheelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templatecacheelements` (
  `cacheId` int NOT NULL,
  `elementId` int NOT NULL,
  KEY `templatecacheelements_cacheId_idx` (`cacheId`),
  KEY `templatecacheelements_elementId_idx` (`elementId`),
  CONSTRAINT `templatecacheelements_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `templatecacheelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `templatecachequeries`
--

DROP TABLE IF EXISTS `templatecachequeries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templatecachequeries` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cacheId` int NOT NULL,
  `type` varchar(255) NOT NULL,
  `query` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecachequeries_cacheId_idx` (`cacheId`),
  KEY `templatecachequeries_type_idx` (`type`),
  CONSTRAINT `templatecachequeries_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `templatecaches`
--

DROP TABLE IF EXISTS `templatecaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templatecaches` (
  `id` int NOT NULL AUTO_INCREMENT,
  `siteId` int NOT NULL,
  `cacheKey` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_path_idx` (`cacheKey`,`siteId`,`expiryDate`,`path`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_idx` (`cacheKey`,`siteId`,`expiryDate`),
  KEY `templatecaches_siteId_idx` (`siteId`),
  CONSTRAINT `templatecaches_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tokens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `token` char(32) NOT NULL,
  `route` text,
  `usageLimit` tinyint unsigned DEFAULT NULL,
  `usageCount` tinyint unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tokens_token_unq_idx` (`token`),
  KEY `tokens_expiryDate_idx` (`expiryDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usergroups`
--

DROP TABLE IF EXISTS `usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usergroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `description` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `usergroups_handle_idx` (`handle`),
  KEY `usergroups_name_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usergroups_users`
--

DROP TABLE IF EXISTS `usergroups_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usergroups_users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `groupId` int NOT NULL,
  `userId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_users_groupId_userId_unq_idx` (`groupId`,`userId`),
  KEY `usergroups_users_userId_idx` (`userId`),
  CONSTRAINT `usergroups_users_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `usergroups_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpermissions`
--

DROP TABLE IF EXISTS `userpermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpermissions_usergroups`
--

DROP TABLE IF EXISTS `userpermissions_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions_usergroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `permissionId` int NOT NULL,
  `groupId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_usergroups_permissionId_groupId_unq_idx` (`permissionId`,`groupId`),
  KEY `userpermissions_usergroups_groupId_idx` (`groupId`),
  CONSTRAINT `userpermissions_usergroups_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_usergroups_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpermissions_users`
--

DROP TABLE IF EXISTS `userpermissions_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions_users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `permissionId` int NOT NULL,
  `userId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_users_permissionId_userId_unq_idx` (`permissionId`,`userId`),
  KEY `userpermissions_users_userId_idx` (`userId`),
  CONSTRAINT `userpermissions_users_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpreferences`
--

DROP TABLE IF EXISTS `userpreferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpreferences` (
  `userId` int NOT NULL AUTO_INCREMENT,
  `preferences` text,
  PRIMARY KEY (`userId`),
  CONSTRAINT `userpreferences_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int NOT NULL,
  `username` varchar(100) NOT NULL,
  `photoId` int DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `suspended` tinyint(1) NOT NULL DEFAULT '0',
  `pending` tinyint(1) NOT NULL DEFAULT '0',
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `hasDashboard` tinyint(1) NOT NULL DEFAULT '0',
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT '0',
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `users_uid_idx` (`uid`),
  KEY `users_verificationCode_idx` (`verificationCode`),
  KEY `users_email_idx` (`email`),
  KEY `users_username_idx` (`username`),
  KEY `users_photoId_fk` (`photoId`),
  CONSTRAINT `users_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `users_photoId_fk` FOREIGN KEY (`photoId`) REFERENCES `assets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `volumefolders`
--

DROP TABLE IF EXISTS `volumefolders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volumefolders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parentId` int DEFAULT NULL,
  `volumeId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `volumefolders_name_parentId_volumeId_unq_idx` (`name`,`parentId`,`volumeId`),
  KEY `volumefolders_parentId_idx` (`parentId`),
  KEY `volumefolders_volumeId_idx` (`volumeId`),
  CONSTRAINT `volumefolders_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `volumefolders_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `volumes`
--

DROP TABLE IF EXISTS `volumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volumes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `url` varchar(255) DEFAULT NULL,
  `titleTranslationMethod` varchar(255) NOT NULL DEFAULT 'site',
  `titleTranslationKeyFormat` text,
  `settings` text,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `volumes_name_idx` (`name`),
  KEY `volumes_handle_idx` (`handle`),
  KEY `volumes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `volumes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `volumes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `webperf_data_samples`
--

DROP TABLE IF EXISTS `webperf_data_samples`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webperf_data_samples` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `requestId` bigint DEFAULT NULL,
  `siteId` int DEFAULT NULL,
  `title` varchar(120) DEFAULT NULL,
  `url` varchar(255) NOT NULL DEFAULT '',
  `queryString` varchar(255) DEFAULT '',
  `dns` int DEFAULT NULL,
  `connect` int DEFAULT NULL,
  `firstByte` int DEFAULT NULL,
  `firstPaint` int DEFAULT NULL,
  `firstContentfulPaint` int DEFAULT NULL,
  `domInteractive` int DEFAULT NULL,
  `pageLoad` int DEFAULT NULL,
  `countryCode` varchar(2) DEFAULT NULL,
  `device` varchar(50) DEFAULT NULL,
  `browser` varchar(50) DEFAULT NULL,
  `os` varchar(50) DEFAULT NULL,
  `mobile` tinyint(1) DEFAULT NULL,
  `craftTotalMs` int DEFAULT NULL,
  `craftDbMs` int DEFAULT NULL,
  `craftDbCnt` int DEFAULT NULL,
  `craftTwigMs` int DEFAULT NULL,
  `craftTwigCnt` int DEFAULT NULL,
  `craftOtherMs` int DEFAULT NULL,
  `craftOtherCnt` int DEFAULT NULL,
  `craftTotalMemory` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `webperf_data_samples_url_idx` (`url`),
  KEY `webperf_data_samples_dateCreated_idx` (`dateCreated`),
  KEY `webperf_data_samples_requestId_idx` (`requestId`),
  KEY `webperf_data_samples_siteId_fk` (`siteId`),
  CONSTRAINT `webperf_data_samples_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `webperf_error_samples`
--

DROP TABLE IF EXISTS `webperf_error_samples`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webperf_error_samples` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `requestId` bigint DEFAULT NULL,
  `siteId` int DEFAULT NULL,
  `title` varchar(120) DEFAULT NULL,
  `url` varchar(255) NOT NULL DEFAULT '',
  `queryString` varchar(255) DEFAULT '',
  `type` varchar(16) DEFAULT '',
  `pageErrors` text,
  PRIMARY KEY (`id`),
  KEY `webperf_error_samples_url_idx` (`url`),
  KEY `webperf_error_samples_dateCreated_idx` (`dateCreated`),
  KEY `webperf_error_samples_requestId_idx` (`requestId`),
  KEY `webperf_error_samples_siteId_fk` (`siteId`),
  CONSTRAINT `webperf_error_samples_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `widgets`
--

DROP TABLE IF EXISTS `widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `widgets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `colspan` tinyint DEFAULT NULL,
  `settings` text,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `widgets_userId_idx` (`userId`),
  CONSTRAINT `widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'project_v3'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-03-17 16:35:05
-- MariaDB dump 10.19  Distrib 10.5.13-MariaDB, for Linux (x86_64)
--
-- Host: mysql    Database: project_v3
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `announcements`
--

LOCK TABLES `announcements` WRITE;
/*!40000 ALTER TABLE `announcements` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `announcements` VALUES (1,1,NULL,'Editor Slideouts','Double-click entries and other editable elements to try the new editor slideout interface.',1,NULL,'2022-01-31 03:39:46'),(2,1,NULL,'Streamlined Entry Publishing Flow','The entry publishing workflow is now [simpler and more intuitive](https://craftcms.com/knowledge-base/editing-entries).',1,NULL,'2022-01-31 03:39:46'),(3,1,5,'SEO Settings fields','The [SEO Settings](https://nystudio107.com/docs/seomatic/fields.html) fields now feature **Override** lightswitches next to each setting, letting you explicitly override SEO settings on a per-entry basis.',1,NULL,'2022-01-31 03:39:47');
/*!40000 ALTER TABLE `announcements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `assets`
--

LOCK TABLES `assets` WRITE;
/*!40000 ALTER TABLE `assets` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `assets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `assettransforms`
--

LOCK TABLES `assettransforms` WRITE;
/*!40000 ALTER TABLE `assettransforms` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `assettransforms` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `calendar_calendar_sites`
--

LOCK TABLES `calendar_calendar_sites` WRITE;
/*!40000 ALTER TABLE `calendar_calendar_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `calendar_calendar_sites` VALUES (1,1,2,1,NULL,NULL,NULL,'2022-03-17 16:27:47','2022-03-17 16:27:47','815c4fd2-6502-4d25-8605-4d74668e8b0d'),(2,1,1,1,NULL,NULL,NULL,'2022-03-17 16:27:47','2022-03-17 16:27:47','aae92448-744c-47d9-9847-843c19e64d1b');
/*!40000 ALTER TABLE `calendar_calendar_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `calendar_calendars`
--

LOCK TABLES `calendar_calendars` WRITE;
/*!40000 ALTER TABLE `calendar_calendars` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `calendar_calendars` VALUES (1,'Default','default','The default calendar','#9E31C4',NULL,NULL,'Title',1,NULL,NULL,NULL,'floating',1,'2022-03-17 16:27:47','2022-03-17 16:27:47','550b07f1-ec7b-4dfa-8dd6-373f9f2b6598');
/*!40000 ALTER TABLE `calendar_calendars` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `calendar_events`
--

LOCK TABLES `calendar_events` WRITE;
/*!40000 ALTER TABLE `calendar_events` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `calendar_events` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `calendar_exceptions`
--

LOCK TABLES `calendar_exceptions` WRITE;
/*!40000 ALTER TABLE `calendar_exceptions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `calendar_exceptions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `calendar_select_dates`
--

LOCK TABLES `calendar_select_dates` WRITE;
/*!40000 ALTER TABLE `calendar_select_dates` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `calendar_select_dates` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `categories` VALUES (21,1,NULL,1,'2021-04-01 02:35:35','2021-04-01 02:35:35','8f284601-2fca-4172-9fc8-8603e272a1a2'),(22,1,NULL,1,'2021-04-01 02:35:44','2021-04-01 02:35:44','32a4a4fd-756a-4d76-a146-02d6e9da5ea0');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categorygroups`
--

LOCK TABLES `categorygroups` WRITE;
/*!40000 ALTER TABLE `categorygroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `categorygroups` VALUES (1,1,9,'Category','category','end','2021-04-01 02:35:21','2021-04-01 02:35:21','2022-01-31 03:40:28','1cc0f175-5212-4568-94a6-9598fce64b6c'),(2,2,10,'Category','category','end','2022-01-31 03:40:28','2022-01-31 03:40:28',NULL,'b8fd3909-9af1-42c4-8c5e-2716a2a1957e');
/*!40000 ALTER TABLE `categorygroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categorygroups_sites`
--

LOCK TABLES `categorygroups_sites` WRITE;
/*!40000 ALTER TABLE `categorygroups_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `categorygroups_sites` VALUES (1,1,1,1,'category/{slug}',NULL,'2021-04-01 02:35:21','2021-04-01 02:35:21','3282a3d5-150f-4c6e-a411-83853f570db1'),(2,1,2,1,'category/{slug}',NULL,'2021-04-01 02:35:21','2021-04-01 02:35:21','686ceccf-7a6a-4c74-9a45-e1fd333a203d'),(3,2,1,1,'category/{slug}',NULL,'2022-01-31 03:40:28','2022-01-31 03:40:28','e6bb5bba-22a5-49ca-b436-a21c0edf9553'),(4,2,2,1,'category/{slug}',NULL,'2022-01-31 03:40:28','2022-01-31 03:40:28','23d17b38-930c-46a5-89b6-4f5ff40eb1f3');
/*!40000 ALTER TABLE `categorygroups_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `changedattributes`
--

LOCK TABLES `changedattributes` WRITE;
/*!40000 ALTER TABLE `changedattributes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `changedattributes` VALUES (1,1,'firstName','2021-03-15 14:57:00',0,1),(1,1,'lastName','2021-03-15 14:57:00',0,1),(1,1,'lastPasswordChangeDate','2021-03-15 14:57:00',0,1),(1,1,'password','2021-03-15 14:57:00',0,1),(2,1,'fieldLayoutId','2021-03-03 22:29:11',0,1);
/*!40000 ALTER TABLE `changedattributes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `changedfields`
--

LOCK TABLES `changedfields` WRITE;
/*!40000 ALTER TABLE `changedfields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `changedfields` VALUES (2,1,5,'2021-03-15 15:11:47',0,NULL),(2,2,5,'2021-03-15 15:11:47',1,NULL),(17,1,6,'2021-03-15 16:17:37',0,1),(17,2,6,'2021-03-15 16:17:37',1,1);
/*!40000 ALTER TABLE `changedfields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_addresses`
--

LOCK TABLES `commerce_addresses` WRITE;
/*!40000 ALTER TABLE `commerce_addresses` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_addresses` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_countries`
--

LOCK TABLES `commerce_countries` WRITE;
/*!40000 ALTER TABLE `commerce_countries` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `commerce_countries` VALUES (1,'Afghanistan','AF',NULL,1,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','c5fd08eb-ca96-4fdf-8e39-a37b62adb9f6'),(2,'Aland Islands','AX',NULL,2,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','5036835c-e416-4c62-9901-c11b45305294'),(3,'Albania','AL',NULL,3,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','1a13624c-ff9c-4f5a-9c06-eba356c36b37'),(4,'Algeria','DZ',NULL,4,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','40d27081-fce0-429a-aca3-e26f6912bb94'),(5,'American Samoa','AS',NULL,5,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','7ce0a273-f6fe-402d-a3a1-cdeccd705a32'),(6,'Andorra','AD',NULL,6,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','dc1488fd-b237-469f-a106-5f68c67f02a1'),(7,'Angola','AO',NULL,7,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','d3e508fc-0cf3-4895-bc8e-9f92c2064768'),(8,'Anguilla','AI',NULL,8,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','bb99e91a-4379-4671-b252-215e2e563d0b'),(9,'Antarctica','AQ',NULL,9,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','1ec49c4f-1e2f-412f-a002-72bc9222ee30'),(10,'Antigua and Barbuda','AG',NULL,10,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','2a7dd00f-324f-47f5-9fbf-61d79efac220'),(11,'Argentina','AR',NULL,11,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','c11194e9-9927-46e8-a2b0-1b86c5e4c2e3'),(12,'Armenia','AM',NULL,12,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','57447769-634f-4fde-b66c-ee6b93f009db'),(13,'Aruba','AW',NULL,13,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','33786f9b-fee0-432a-81bb-05545e5b7f67'),(14,'Australia','AU',NULL,14,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','908a082e-e764-4e16-8f85-4120f3430530'),(15,'Austria','AT',NULL,15,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','948b8b03-8c68-4f52-a5c9-4f6d5de12602'),(16,'Azerbaijan','AZ',NULL,16,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','82ec47e2-1be2-409b-9a1d-427e5522708f'),(17,'Bahamas','BS',NULL,17,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','7c0b660e-cce4-4579-af10-b369e8a924af'),(18,'Bahrain','BH',NULL,18,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','42260cc2-b190-4077-a8d3-3ff3bdae3c63'),(19,'Bangladesh','BD',NULL,19,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','e8c2eee6-0efd-4fc0-8dba-869a9cd7464b'),(20,'Barbados','BB',NULL,20,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','0ce28aa8-99a0-4245-8c6c-973f6b3f14d6'),(21,'Belarus','BY',NULL,21,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','87df4ffa-982f-469f-8a23-13dee4bfc1d9'),(22,'Belgium','BE',NULL,22,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','dec626dd-5113-4a98-b6d4-48f7dd3a61fd'),(23,'Belize','BZ',NULL,23,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','cbc94ce0-53b3-4dd9-a359-742d6ec5848b'),(24,'Benin','BJ',NULL,24,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','1df608fd-d8fe-4603-b38b-ef5664a57466'),(25,'Bermuda','BM',NULL,25,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','2c0bfb59-cd28-46c1-9282-589e4c1ebbe4'),(26,'Bhutan','BT',NULL,26,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','bb810458-e2fe-4682-add8-abdb40daaca2'),(27,'Bolivia','BO',NULL,27,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','d051544e-d29c-4bb8-ac2f-9244c74c2fc0'),(28,'Bonaire, Sint Eustatius and Saba','BQ',NULL,28,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','6a4c773d-51a4-4cb0-967a-e11b707ed4f6'),(29,'Bosnia and Herzegovina','BA',NULL,29,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','a7497a78-3b0f-4c27-9a22-34bfa58f53b8'),(30,'Botswana','BW',NULL,30,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','fddc2069-673c-432a-9294-73d1c677afb9'),(31,'Bouvet Island','BV',NULL,31,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','e7a9d9d0-d3a3-4735-ad53-9190ae936683'),(32,'Brazil','BR',NULL,32,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','231ea02e-109e-47c1-8a63-3c2c8710f07e'),(33,'British Indian Ocean Territory','IO',NULL,33,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','7134544f-4794-4e99-833f-39322ae05d80'),(34,'Brunei Darussalam','BN',NULL,34,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','b74f55ad-40dd-4f14-b58e-65a8983d8e01'),(35,'Bulgaria','BG',NULL,35,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','14bbc024-7a0d-4517-877b-60e16a8ca28a'),(36,'Burkina Faso','BF',NULL,36,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','7501808c-37d8-4188-9a30-59c2297c88cc'),(37,'Burma (Myanmar)','MM',NULL,37,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','f965dcce-c257-4214-a0a5-8e53de08fdbb'),(38,'Burundi','BI',NULL,38,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','53664a0f-c0a5-4d2d-a445-d605c352e691'),(39,'Cambodia','KH',NULL,39,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','4db35af3-01f3-4414-82a3-9cf77a324bb2'),(40,'Cameroon','CM',NULL,40,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','2294d94b-3a5d-4406-a463-bd81de8e0430'),(41,'Canada','CA',NULL,41,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','848f0065-44ea-487a-9dc6-31bf86e77a68'),(42,'Cape Verde','CV',NULL,42,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','55fceb19-cf84-4d8f-b828-13c0c5bd6714'),(43,'Cayman Islands','KY',NULL,43,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','756025ec-0da2-4970-81ad-12a305679fd4'),(44,'Central African Republic','CF',NULL,44,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','16f701e8-ef15-46ba-9ffd-7de4f5e66e62'),(45,'Chad','TD',NULL,45,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','fe8e5d0e-2597-4538-9c2d-9d145ba7d455'),(46,'Chile','CL',NULL,46,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','5bc94133-4a3e-49c5-a127-d2590a52b697'),(47,'China','CN',NULL,47,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','1b5286b6-7511-44b6-96b7-671c4dc1bd5a'),(48,'Christmas Island','CX',NULL,48,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','308e5b9c-df09-4342-8356-1628460b8502'),(49,'Cocos (Keeling) Islands','CC',NULL,49,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','15716a88-0846-4020-8847-da360c49b655'),(50,'Colombia','CO',NULL,50,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','42546c9c-36d5-4e45-aebe-907df06e0757'),(51,'Comoros','KM',NULL,51,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','66a0b63f-64b7-4c5d-a66d-bb38492dd1c7'),(52,'Congo','CG',NULL,52,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','0380c8a4-fad2-438d-9a6d-ee1f12b9afc8'),(53,'Cook Islands','CK',NULL,53,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','df63f053-1436-4efa-b169-7531a4c16e8c'),(54,'Costa Rica','CR',NULL,54,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','a923140a-7b37-480b-82ae-5f9569ec7a9a'),(55,'Croatia (Hrvatska)','HR',NULL,55,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','1f842e5a-20e7-4a86-86cc-7a914f32cad2'),(56,'Cuba','CU',NULL,56,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','9473dc01-d1eb-4914-b3b0-d52b29075f16'),(57,'Curacao','CW',NULL,57,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','22c896ba-1359-4097-b072-7bacaeef9e7a'),(58,'Cyprus','CY',NULL,58,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','fc906783-cba1-4d41-8b3a-329081baa9bc'),(59,'Czech Republic','CZ',NULL,59,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','294f1626-7442-49d2-b463-8ed839beee8e'),(60,'Democratic Republic of Congo','CD',NULL,60,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','5d3a188a-0b8e-4dec-8889-b396e5cb63f8'),(61,'Denmark','DK',NULL,61,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','cd97330a-7ec6-4338-91e4-5c127ce8a1bb'),(62,'Djibouti','DJ',NULL,62,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','09061d37-7cd6-4981-8b7c-3f923edd8cb6'),(63,'Dominica','DM',NULL,63,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','010922ed-78c6-4a02-a4fc-441b8cd3c67e'),(64,'Dominican Republic','DO',NULL,64,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','75f61b47-6244-4c87-a945-068c58ff5769'),(65,'Ecuador','EC',NULL,65,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','add7d228-defa-40f1-b6e4-e05d2d7cf4ea'),(66,'Egypt','EG',NULL,66,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','53c92731-69fc-432b-8d32-30be85ab9d6d'),(67,'El Salvador','SV',NULL,67,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','3f8082f3-70f3-4805-a150-8ccef3e84c24'),(68,'Equatorial Guinea','GQ',NULL,68,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','7eef07c9-2985-4d58-88c0-ab214323a41b'),(69,'Eritrea','ER',NULL,69,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','1ddbd016-5e4c-491f-8543-3ede6518839d'),(70,'Estonia','EE',NULL,70,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','9db10f16-b9ee-47a9-be4b-e30755f9cba8'),(71,'Ethiopia','ET',NULL,71,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','7a208dab-e2e8-4f5d-8129-ddbfdffbac15'),(72,'Falkland Islands (Malvinas)','FK',NULL,72,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','95afb88d-7c04-46f8-9a21-91449e78185f'),(73,'Faroe Islands','FO',NULL,73,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','3946d67d-5593-418e-9bb8-801110db8d60'),(74,'Fiji','FJ',NULL,74,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','cb70e8b0-139f-4c01-b90a-a1cb81d12860'),(75,'Finland','FI',NULL,75,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','206fe0c0-19b1-4dc9-834f-d6b3083c6909'),(76,'France','FR',NULL,76,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','55763648-6772-4671-b337-4137aca0bf23'),(77,'French Guiana','GF',NULL,77,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','b03a77e5-4250-4f1d-8b05-a5c39aeaa2cb'),(78,'French Polynesia','PF',NULL,78,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','ff98e741-dc2f-4eae-9ad3-e4138e495f01'),(79,'French Southern Territories','TF',NULL,79,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','f4532139-473e-4ec8-bb70-52ae4f69b119'),(80,'Gabon','GA',NULL,80,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','e854de32-adb4-4043-93e6-709456356b42'),(81,'Gambia','GM',NULL,81,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','cbe8e395-b09b-4d41-b468-225c9125fcbc'),(82,'Georgia','GE',NULL,82,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','25c16180-5af8-4ebd-b278-1098cb0e6514'),(83,'Germany','DE',NULL,83,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','4f4a5a07-70a0-4918-bb2e-c16e37985cd1'),(84,'Ghana','GH',NULL,84,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','e01efb44-080d-4123-afd3-6fabe3a8176e'),(85,'Gibraltar','GI',NULL,85,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','e00f560f-85a1-4be9-adb1-43512124441e'),(86,'Greece','GR',NULL,86,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','d719cef9-8616-44e1-8085-7b18a00bb760'),(87,'Greenland','GL',NULL,87,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','449d87ed-12ac-4df8-98b7-0e8e81a748f6'),(88,'Grenada','GD',NULL,88,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','f8f48a90-de09-4777-b13c-47d403aeb607'),(89,'Guadeloupe','GP',NULL,89,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','a1d59ca7-ace4-48ef-ac55-806d41324c1a'),(90,'Guam','GU',NULL,90,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','fe23287f-67ad-4cbf-8896-36f136b774ae'),(91,'Guatemala','GT',NULL,91,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','88a36d61-1bf3-4b57-8ef5-ec7a826b8b78'),(92,'Guernsey','GG',NULL,92,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','b1bc0d11-9c8b-4a21-a722-d45d3979ae3d'),(93,'Guinea','GN',NULL,93,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','7eb7be9d-a3cf-48d1-8daa-42a61b89d23d'),(94,'Guinea-Bissau','GW',NULL,94,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','d840e87d-9ecf-4f3a-a6f9-2563edb84a88'),(95,'Guyana','GY',NULL,95,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','109f02a4-11ad-477a-a9a3-6501bfad7cb5'),(96,'Haiti','HT',NULL,96,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','956ba1e3-5ac1-41ac-af79-d607d70fcc46'),(97,'Heard and McDonald Islands','HM',NULL,97,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','dd2c0ecd-8adc-4c53-970a-e27beee5fecb'),(98,'Honduras','HN',NULL,98,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','f1c2737e-d9da-4e17-9d7a-a9caba848ef8'),(99,'Hong Kong','HK',NULL,99,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','a9791833-1aeb-47fa-a326-89e7b260aea5'),(100,'Hungary','HU',NULL,100,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','23dcce91-e425-43dc-83b7-ec231138c8be'),(101,'Iceland','IS',NULL,101,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','9c4326d5-4e71-4063-9d07-9d7f4e48620a'),(102,'India','IN',NULL,102,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','60157349-f966-4b0f-a9c0-38a4aef7cd3d'),(103,'Indonesia','ID',NULL,103,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','941162d5-e86f-4688-9255-427c9b8fb02b'),(104,'Iran','IR',NULL,104,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','0b1d4b7f-061b-4344-ae34-fbc193dea6fa'),(105,'Iraq','IQ',NULL,105,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','003d48d1-c489-4427-8125-11521f4eb33f'),(106,'Ireland','IE',NULL,106,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','4ce0d7a0-be23-4667-923b-7e6bf0768f9b'),(107,'Isle Of Man','IM',NULL,107,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','bfdee9d5-f143-4ae8-9362-841593ee249b'),(108,'Israel','IL',NULL,108,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','a7932cc9-b908-4d2a-8d84-9826fb2b2f1d'),(109,'Italy','IT',NULL,109,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','09db0350-fb12-42c5-8492-61fe25fd3c38'),(110,'Ivory Coast','CI',NULL,110,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','33dc207f-a7cd-4d07-9efa-713352d176ae'),(111,'Jamaica','JM',NULL,111,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','65837d33-341c-421d-9d52-9e805314217c'),(112,'Japan','JP',NULL,112,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','d12b2e96-3bf3-43c2-92b0-2dbc9b1ccb3e'),(113,'Jersey','JE',NULL,113,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','c33a7b01-21ad-43be-bc9f-eba84773a147'),(114,'Jordan','JO',NULL,114,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','094fecfb-bf50-4d2c-a865-6c6a29395e58'),(115,'Kazakhstan','KZ',NULL,115,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','0e306933-6ebb-4393-bb66-45e489c33a06'),(116,'Kenya','KE',NULL,116,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','345c86b4-bd29-440b-8774-6c1d457bc92a'),(117,'Kiribati','KI',NULL,117,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','770c9daa-7112-4a1a-a4a7-2aa5ee039930'),(118,'Korea (North)','KP',NULL,118,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','72e5fe8a-163a-4e78-8ed0-d910b1255588'),(119,'Korea (South)','KR',NULL,119,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','e52464fb-afe3-4721-a108-458dbee0cbf2'),(120,'Kuwait','KW',NULL,120,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','c9f0acba-62e4-471e-a5f9-b8da0ba77a8d'),(121,'Kyrgyzstan','KG',NULL,121,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','4d4a68db-c558-437a-abdb-ad7ee2e3531d'),(122,'Laos','LA',NULL,122,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','11551dd8-d2e5-4c04-af11-55336905a4da'),(123,'Latvia','LV',NULL,123,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','2c859659-6368-464c-aca3-5e1eb684ab8f'),(124,'Lebanon','LB',NULL,124,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','13aa73a1-10d1-4693-8d08-dd795a8bbd11'),(125,'Lesotho','LS',NULL,125,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','772c4fe9-cbf8-4533-b0bf-5e3f91cc5a00'),(126,'Liberia','LR',NULL,126,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','977f4548-e791-43bc-b0c3-b45afeede7c0'),(127,'Libya','LY',NULL,127,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','6d566594-3f82-448b-a415-041b18ecc18f'),(128,'Liechtenstein','LI',NULL,128,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','3be20882-4fd5-403b-acca-b6b4fc8c58cf'),(129,'Lithuania','LT',NULL,129,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','b7f2c695-bc94-4f00-874f-dd4b7a1783b4'),(130,'Luxembourg','LU',NULL,130,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','4feeba3c-3320-44c6-b4dc-5bcb4ec6149d'),(131,'Macau','MO',NULL,131,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','7d7a59f1-3b0e-4907-b662-61112305aac2'),(132,'Macedonia','MK',NULL,132,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','38a81c62-00eb-4faa-b634-c1485eeacf68'),(133,'Madagascar','MG',NULL,133,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','177c2e0d-46c8-4f15-bfe1-ca4a02874b17'),(134,'Malawi','MW',NULL,134,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','0e799fbd-ce16-4adb-bb36-de46bf59273f'),(135,'Malaysia','MY',NULL,135,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','55c44bad-b97b-4e3a-ac73-75f37f8058bb'),(136,'Maldives','MV',NULL,136,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','dc539a25-e9db-48b3-8ad8-df4d9d0e3865'),(137,'Mali','ML',NULL,137,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','c895b53f-d5d8-4c76-b150-f2a722fbbde8'),(138,'Malta','MT',NULL,138,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','bb6fd26d-f55c-446a-8aea-519629d590f3'),(139,'Marshall Islands','MH',NULL,139,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','673b4252-9f6d-43d7-9b82-32ba11944806'),(140,'Martinique','MQ',NULL,140,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','bcc129b2-c0ce-432f-88c5-f37afa409777'),(141,'Mauritania','MR',NULL,141,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','55266a2b-35e2-4d81-8029-a9b0fe38a03c'),(142,'Mauritius','MU',NULL,142,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','b8d45955-b87d-459d-aed2-5faa57f929da'),(143,'Mayotte','YT',NULL,143,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','5d4d56c4-9876-4f3d-8b52-f394f450aa52'),(144,'Mexico','MX',NULL,144,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','0e40a671-0dbc-4754-a728-31708d2b46ee'),(145,'Micronesia','FM',NULL,145,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','1162b8e6-1a79-41c9-bf2a-97c69760237a'),(146,'Moldova','MD',NULL,146,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','6e2fef3b-7177-4609-980b-56946f97f5bc'),(147,'Monaco','MC',NULL,147,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','2d4801a0-f35a-4b9a-8437-7930e568a114'),(148,'Mongolia','MN',NULL,148,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','c1e69876-11c6-4946-8f06-9db57815e472'),(149,'Montenegro','ME',NULL,149,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','d4b0a95c-5967-4d42-b6a3-015145aa7a78'),(150,'Montserrat','MS',NULL,150,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','e3514510-8006-4e91-9c2a-773cba586056'),(151,'Morocco','MA',NULL,151,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','c149c29a-4a6a-4ad5-82c6-157fb9cb3546'),(152,'Mozambique','MZ',NULL,152,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','6b5c4209-9320-43e2-89bc-ed0ebb7f3047'),(153,'Namibia','NA',NULL,153,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','469c341b-eae4-48a9-a276-ba2b0807d6b5'),(154,'Nauru','NR',NULL,154,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','c4211adb-0a9e-4437-9f54-04d91a7ccf50'),(155,'Nepal','NP',NULL,155,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','3a752d2c-eeb9-423f-8858-035c7f03a7f8'),(156,'Netherlands','NL',NULL,156,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','60b71219-8438-4194-b183-7237de9311c0'),(157,'New Caledonia','NC',NULL,157,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','ecb946d2-6bf5-4890-abb8-ca7c227edf52'),(158,'New Zealand','NZ',NULL,158,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','cc076cfd-e0aa-4d03-afdf-5735c0d8ba54'),(159,'Nicaragua','NI',NULL,159,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','ec502598-416b-465f-8877-5c8d789e0359'),(160,'Niger','NE',NULL,160,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','a5b99b62-7d3c-4c10-8a8b-22d8be3969f6'),(161,'Nigeria','NG',NULL,161,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','96423fb1-58e2-47c2-afa5-a1277ef1ada0'),(162,'Niue','NU',NULL,162,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','d9c6e1ef-2947-4bb1-b6b0-70b266c32b65'),(163,'Norfolk Island','NF',NULL,163,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','459364ce-d2b8-49c4-aef5-6435722e8bb8'),(164,'Northern Mariana Islands','MP',NULL,164,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','425754be-a2b3-4054-9ab6-053aeb8309e7'),(165,'Norway','NO',NULL,165,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','a75df2b1-f1e3-4f23-93cb-d39677993896'),(166,'Oman','OM',NULL,166,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','0a784417-0083-4bd2-93bf-9cf2362b3cef'),(167,'Pakistan','PK',NULL,167,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','7917436c-31aa-4fa1-afe2-46e4545767a1'),(168,'Palau','PW',NULL,168,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','a3e4007c-85d2-4092-a716-5837345af937'),(169,'Palestinian Territory, Occupied','PS',NULL,169,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','2c8a19ad-a779-4498-b5c4-c45cb71aab9b'),(170,'Panama','PA',NULL,170,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','35e3d8b7-f492-49fc-bbbc-7e53785ade7a'),(171,'Papua New Guinea','PG',NULL,171,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','c994c830-d762-461f-b36a-8ffb6235433b'),(172,'Paraguay','PY',NULL,172,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','8fe73717-2e38-4862-a3cf-0cbb4eba224e'),(173,'Peru','PE',NULL,173,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','a239b711-60e2-4ed1-a88f-df0e4ef98630'),(174,'Philippines','PH',NULL,174,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','bc91cbd9-e809-4756-b740-5a65ecabab39'),(175,'Pitcairn','PN',NULL,175,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','b0c77d5e-79ac-49bd-94d2-c04b519e4fa0'),(176,'Poland','PL',NULL,176,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','88203589-2baa-407a-a107-63274184f06a'),(177,'Portugal','PT',NULL,177,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','f6c575a9-1cf0-4484-b3f2-fc62d7342742'),(178,'Puerto Rico','PR',NULL,178,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','139bfcba-332c-4f69-9ec5-c5c04345c835'),(179,'Qatar','QA',NULL,179,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','cff4401a-c504-4363-8d8e-88ccecd6fbdd'),(180,'Republic of Serbia','RS',NULL,180,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','afe6205e-fb37-4098-8bd7-7155811a7966'),(181,'Reunion','RE',NULL,181,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','d71d5e00-defd-42b9-865f-24c9acdb2ef3'),(182,'Romania','RO',NULL,182,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','fb8e8fcf-d8c4-4f0b-8a44-446fd91a675b'),(183,'Russia','RU',NULL,183,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','1220820e-d0fe-4fb5-9141-1a018affc4dd'),(184,'Rwanda','RW',NULL,184,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','b1e3511b-1a7f-40b1-b711-5b2a4b4a6547'),(185,'S. Georgia and S. Sandwich Isls.','GS',NULL,185,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','496ee422-339e-426c-abc2-6e85de97633e'),(186,'Saint Barthelemy','BL',NULL,186,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','2721a1e4-eabb-415e-8073-b2b9856eb522'),(187,'Saint Kitts and Nevis','KN',NULL,187,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','80defbf1-5b6d-48c1-b14a-24c29218f4e3'),(188,'Saint Lucia','LC',NULL,188,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','522ace05-ce87-45c5-b602-9af20930806a'),(189,'Saint Martin (French part)','MF',NULL,189,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','6f574557-5eee-49c6-b087-9a7b6397e71c'),(190,'Saint Vincent and the Grenadines','VC',NULL,190,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','c86001c6-ac21-4a07-9db3-fe4bf9b9bbbb'),(191,'Samoa','WS',NULL,191,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','861a8745-942a-4785-9823-76a44c5b6490'),(192,'San Marino','SM',NULL,192,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','26de2af5-57aa-4064-9f30-c1cb64918355'),(193,'Sao Tome and Principe','ST',NULL,193,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','e381526d-47cf-45bb-b0d7-f7552eaa84a3'),(194,'Saudi Arabia','SA',NULL,194,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','8ed908d6-91f2-4a11-afa4-c69a94e55bc7'),(195,'Senegal','SN',NULL,195,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','7d36e1ea-b843-4baf-a605-76e87df89187'),(196,'Seychelles','SC',NULL,196,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','4e570929-deec-45b9-aea2-237b8f733a35'),(197,'Sierra Leone','SL',NULL,197,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','eb97c9cf-1330-4252-bad6-b7e6d1884b3c'),(198,'Singapore','SG',NULL,198,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','372cc664-072d-4de6-8023-3a936fc51bff'),(199,'Sint Maarten (Dutch part)','SX',NULL,199,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','af79e73a-a163-4532-9808-20e8f4cfdf8d'),(200,'Slovak Republic','SK',NULL,200,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','f7f3fe9e-6f85-4446-8096-b05346ae4bb5'),(201,'Slovenia','SI',NULL,201,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','9e933d1d-0e6f-466b-82ca-ef767fa90657'),(202,'Solomon Islands','SB',NULL,202,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','88695dcf-5d6b-45f7-abbd-017278d8db3c'),(203,'Somalia','SO',NULL,203,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','96cfe9d6-1100-4048-aafc-03908f70b608'),(204,'South Africa','ZA',NULL,204,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','84ab3571-856c-47c2-9f80-68943674effc'),(205,'South Sudan','SS',NULL,205,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','38f22e0e-3935-4432-8c7d-bffeb98722ef'),(206,'Spain','ES',NULL,206,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','1ffcd191-3434-4de9-b2df-c3c3b1b7a3d2'),(207,'Sri Lanka','LK',NULL,207,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','203b4ce1-2357-4b52-b320-9d502a5b9f08'),(208,'St. Helena','SH',NULL,208,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','3bd23065-401d-4789-b441-4920c36ae993'),(209,'St. Pierre and Miquelon','PM',NULL,209,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','5bc0a4c2-f1a2-43cb-a841-f3b77ec8b443'),(210,'Sudan','SD',NULL,210,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','98134a18-1095-4261-8533-838be40cca86'),(211,'Suriname','SR',NULL,211,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','7a112541-a9a5-491c-8db8-ccfdce1d6afc'),(212,'Svalbard and Jan Mayen Islands','SJ',NULL,212,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','dc3786b7-f565-47cb-b67c-438f101c8c56'),(213,'Swaziland','SZ',NULL,213,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','59cfbba8-6741-4907-a505-4feea38f642e'),(214,'Sweden','SE',NULL,214,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','1c895efd-1e78-4c3d-996e-0f5985cea4c2'),(215,'Switzerland','CH',NULL,215,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','254fa763-c210-4e7b-a8da-ab996eeb0f37'),(216,'Syria','SY',NULL,216,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','a969058f-d5a4-4c19-89e3-713e92308365'),(217,'Taiwan','TW',NULL,217,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','2eb7bf49-020d-4856-9a75-cd72983250b4'),(218,'Tajikistan','TJ',NULL,218,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','36acf98b-c0a6-49a7-840f-0f15e335d86c'),(219,'Tanzania','TZ',NULL,219,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','ef033ba1-3b2a-45fa-ac5a-68dd3f7de37c'),(220,'Thailand','TH',NULL,220,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','92ba86d0-fced-433d-b7fd-1da439dd4fca'),(221,'Timor-Leste','TL',NULL,221,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','9c6458ec-c994-4aa8-b094-959e643a60ee'),(222,'Togo','TG',NULL,222,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','641bbd37-3992-43d4-88ce-2c3f271fff63'),(223,'Tokelau','TK',NULL,223,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','fe958d90-ce6e-4124-9c2f-a6c9017a0588'),(224,'Tonga','TO',NULL,224,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','42ab1d75-47b0-498a-bffa-5e6a4bc922e2'),(225,'Trinidad and Tobago','TT',NULL,225,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','e01f0ced-cbbc-4c35-adf6-432a81be44bf'),(226,'Tunisia','TN',NULL,226,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','4e71a07e-7327-458b-aae2-2418135acdc5'),(227,'Turkey','TR',NULL,227,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','22e2359a-0732-4dfb-9728-5db1ef3235f7'),(228,'Turkmenistan','TM',NULL,228,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','ca895a28-2d38-4833-8679-a2d4c86ea029'),(229,'Turks and Caicos Islands','TC',NULL,229,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','bf6c8292-4b79-4a08-952e-ea0fa6ee41cc'),(230,'Tuvalu','TV',NULL,230,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','5ca4a4b0-0457-49f5-8f5d-309afc51136e'),(231,'Uganda','UG',NULL,231,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','638fbcf0-dfac-42b6-8b7b-35387f757912'),(232,'Ukraine','UA',NULL,232,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','ad9cc0c0-688f-4808-833a-8d1f3d9d6540'),(233,'United Arab Emirates','AE',NULL,233,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','2393773f-ddcd-4f18-bebc-485acc2a0116'),(234,'United Kingdom','GB',NULL,234,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','1dde270b-3397-4a44-be13-d2fcca392bf8'),(235,'United States Minor Outlying Islands','UM',NULL,235,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','fec0cc17-6267-4887-ba4d-da7d48cf8597'),(236,'United States','US',NULL,236,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','7ac1434f-12f5-46d6-b871-995bb3a13494'),(237,'Uruguay','UY',NULL,237,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','135fb786-a7c9-43c1-aa0a-42494133135c'),(238,'Uzbekistan','UZ',NULL,238,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','b6d8a8f6-ccaa-4953-bd69-9cdf3a8a1abf'),(239,'Vanuatu','VU',NULL,239,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','712dc568-9f14-4bc8-9b0b-03acd4430d19'),(240,'Vatican City State (Holy See)','VA',NULL,240,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','4962e3f0-2a85-4722-b970-3463d71bd79c'),(241,'Venezuela','VE',NULL,241,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','b5d65b94-3969-4719-9ad6-ca3897b021fa'),(242,'Viet Nam','VN',NULL,242,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','0f0af80a-20f7-4cf7-9347-40524441cee9'),(243,'Virgin Islands (British)','VG',NULL,243,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','2dbda479-251d-4b05-af22-c524281a3afd'),(244,'Virgin Islands (U.S.)','VI',NULL,244,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','21ef73b2-56f3-4a37-9da0-6ae9d970853a'),(245,'Wallis and Futuna Islands','WF',NULL,245,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','424d5c9d-37d7-4af4-89f6-dead4daab748'),(246,'Western Sahara','EH',NULL,246,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','2d2aa8e2-f9a8-45ca-a73b-55473a1bf8c1'),(247,'Yemen','YE',NULL,247,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','f2851dc9-8858-4480-9207-71157d539049'),(248,'Zambia','ZM',NULL,248,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','14dcad96-edde-4ed7-a40d-ffc6cc2d1f2d'),(249,'Zimbabwe','ZW',NULL,249,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','ebcfcd67-02e8-4d3d-95b3-1a2de96feea8');
/*!40000 ALTER TABLE `commerce_countries` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_customer_discountuses`
--

LOCK TABLES `commerce_customer_discountuses` WRITE;
/*!40000 ALTER TABLE `commerce_customer_discountuses` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_customer_discountuses` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_customers`
--

LOCK TABLES `commerce_customers` WRITE;
/*!40000 ALTER TABLE `commerce_customers` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `commerce_customers` VALUES (1,1,NULL,NULL,'2021-04-01 00:17:22','2021-04-01 00:17:22','987f185c-acfa-43fb-8d41-0ba52dd41e49');
/*!40000 ALTER TABLE `commerce_customers` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_customers_addresses`
--

LOCK TABLES `commerce_customers_addresses` WRITE;
/*!40000 ALTER TABLE `commerce_customers_addresses` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_customers_addresses` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_discount_categories`
--

LOCK TABLES `commerce_discount_categories` WRITE;
/*!40000 ALTER TABLE `commerce_discount_categories` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_discount_categories` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_discount_purchasables`
--

LOCK TABLES `commerce_discount_purchasables` WRITE;
/*!40000 ALTER TABLE `commerce_discount_purchasables` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_discount_purchasables` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_discount_usergroups`
--

LOCK TABLES `commerce_discount_usergroups` WRITE;
/*!40000 ALTER TABLE `commerce_discount_usergroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_discount_usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_discounts`
--

LOCK TABLES `commerce_discounts` WRITE;
/*!40000 ALTER TABLE `commerce_discounts` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_discounts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_donations`
--

LOCK TABLES `commerce_donations` WRITE;
/*!40000 ALTER TABLE `commerce_donations` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `commerce_donations` VALUES (3,'DONATION-CC3',0,'2021-03-15 15:24:15','2021-03-15 15:24:15','6c437040-2f23-43ab-8e7d-83bfc53a021a');
/*!40000 ALTER TABLE `commerce_donations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_email_discountuses`
--

LOCK TABLES `commerce_email_discountuses` WRITE;
/*!40000 ALTER TABLE `commerce_email_discountuses` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_email_discountuses` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_emails`
--

LOCK TABLES `commerce_emails` WRITE;
/*!40000 ALTER TABLE `commerce_emails` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_emails` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_gateways`
--

LOCK TABLES `commerce_gateways` WRITE;
/*!40000 ALTER TABLE `commerce_gateways` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `commerce_gateways` VALUES (1,'craft\\commerce\\gateways\\Dummy','Dummy','dummy',NULL,'purchase',1,0,NULL,99,'2021-03-15 15:24:16','2021-03-15 15:24:16','6a117ef0-054c-4147-acb6-6fe57d48c4ae');
/*!40000 ALTER TABLE `commerce_gateways` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_lineitems`
--

LOCK TABLES `commerce_lineitems` WRITE;
/*!40000 ALTER TABLE `commerce_lineitems` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_lineitems` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_lineitemstatuses`
--

LOCK TABLES `commerce_lineitemstatuses` WRITE;
/*!40000 ALTER TABLE `commerce_lineitemstatuses` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_lineitemstatuses` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_orderadjustments`
--

LOCK TABLES `commerce_orderadjustments` WRITE;
/*!40000 ALTER TABLE `commerce_orderadjustments` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_orderadjustments` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_orderhistories`
--

LOCK TABLES `commerce_orderhistories` WRITE;
/*!40000 ALTER TABLE `commerce_orderhistories` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_orderhistories` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_ordernotices`
--

LOCK TABLES `commerce_ordernotices` WRITE;
/*!40000 ALTER TABLE `commerce_ordernotices` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_ordernotices` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_orders`
--

LOCK TABLES `commerce_orders` WRITE;
/*!40000 ALTER TABLE `commerce_orders` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_orders` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_orderstatus_emails`
--

LOCK TABLES `commerce_orderstatus_emails` WRITE;
/*!40000 ALTER TABLE `commerce_orderstatus_emails` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_orderstatus_emails` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_orderstatuses`
--

LOCK TABLES `commerce_orderstatuses` WRITE;
/*!40000 ALTER TABLE `commerce_orderstatuses` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `commerce_orderstatuses` VALUES (1,'New','new','green',NULL,NULL,99,1,'2021-03-15 15:24:16','2021-03-15 15:24:16','f923795f-139e-4b59-b27c-eaa0be4f847c');
/*!40000 ALTER TABLE `commerce_orderstatuses` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_paymentcurrencies`
--

LOCK TABLES `commerce_paymentcurrencies` WRITE;
/*!40000 ALTER TABLE `commerce_paymentcurrencies` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `commerce_paymentcurrencies` VALUES (1,'USD',1,1.0000,'2021-03-15 15:24:15','2021-03-15 15:24:15','11f95717-e061-4219-adea-b05ec031be5f');
/*!40000 ALTER TABLE `commerce_paymentcurrencies` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_paymentsources`
--

LOCK TABLES `commerce_paymentsources` WRITE;
/*!40000 ALTER TABLE `commerce_paymentsources` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_paymentsources` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_pdfs`
--

LOCK TABLES `commerce_pdfs` WRITE;
/*!40000 ALTER TABLE `commerce_pdfs` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_pdfs` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_plans`
--

LOCK TABLES `commerce_plans` WRITE;
/*!40000 ALTER TABLE `commerce_plans` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_plans` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_products`
--

LOCK TABLES `commerce_products` WRITE;
/*!40000 ALTER TABLE `commerce_products` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `commerce_products` VALUES (4,1,1,1,5,'2021-03-15 15:24:16',NULL,1,1,0,'ANT-001',20.0000,0.0000,0.0000,0.0000,0.0000,'2021-03-15 15:24:16','2021-03-15 15:24:21','00179010-57ba-4a8a-a9d6-620c1b3a6cac'),(6,1,1,1,7,'2021-03-15 15:24:16',NULL,1,1,0,'PSB-001',30.0000,0.0000,0.0000,0.0000,0.0000,'2021-03-15 15:24:16','2021-03-15 15:24:21','8e3e5961-d7eb-4b55-915d-a2f6246a8ade'),(8,1,1,1,9,'2021-03-15 15:24:16',NULL,1,1,0,'RRE-001',40.0000,0.0000,0.0000,0.0000,0.0000,'2021-03-15 15:24:16','2021-03-15 15:24:21','f1a2a46a-b542-4ddb-9838-020192cb1b3d'),(10,1,1,1,11,'2021-03-15 15:24:16',NULL,1,1,0,'TFA-001',50.0000,0.0000,0.0000,0.0000,0.0000,'2021-03-15 15:24:16','2021-03-15 15:24:21','b4a9d0a6-ba45-43ca-a3a2-bb10bcf8f4d5'),(12,1,1,1,13,'2021-03-15 15:24:16',NULL,1,1,0,'LKH-001',60.0000,0.0000,0.0000,0.0000,0.0000,'2021-03-15 15:24:16','2021-03-15 15:24:21','a3cd6bbf-6239-4eda-9469-0f8182aa93fa'),(14,1,1,1,15,'2021-03-15 15:24:16',NULL,1,1,0,'FDB-001',70.0000,0.0000,0.0000,0.0000,0.0000,'2021-03-15 15:24:16','2021-03-15 15:24:21','7b255844-afcd-41c1-97a9-5a907491dfeb');
/*!40000 ALTER TABLE `commerce_products` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_producttypes`
--

LOCK TABLES `commerce_producttypes` WRITE;
/*!40000 ALTER TABLE `commerce_producttypes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `commerce_producttypes` VALUES (1,3,NULL,'Clothing','clothing',1,0,1,'{product.title}',1,'','','','2021-03-15 15:24:16','2021-03-15 15:24:16','407fe253-2ada-4a88-b1a4-fb6c2004cd9b');
/*!40000 ALTER TABLE `commerce_producttypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_producttypes_shippingcategories`
--

LOCK TABLES `commerce_producttypes_shippingcategories` WRITE;
/*!40000 ALTER TABLE `commerce_producttypes_shippingcategories` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_producttypes_shippingcategories` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_producttypes_sites`
--

LOCK TABLES `commerce_producttypes_sites` WRITE;
/*!40000 ALTER TABLE `commerce_producttypes_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `commerce_producttypes_sites` VALUES (1,1,1,'shop/products/{slug}','shop/products/_product',1,'2021-03-15 15:24:16','2021-03-15 15:24:16','48930b4a-86f5-4a07-a19f-7950f77a9a97'),(2,1,2,'shop/products/{slug}','shop/products/_product',1,'2021-03-15 15:24:16','2021-03-15 15:24:16','799fbb49-ceae-47ae-81a9-516b724418b7');
/*!40000 ALTER TABLE `commerce_producttypes_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_producttypes_taxcategories`
--

LOCK TABLES `commerce_producttypes_taxcategories` WRITE;
/*!40000 ALTER TABLE `commerce_producttypes_taxcategories` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_producttypes_taxcategories` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_purchasables`
--

LOCK TABLES `commerce_purchasables` WRITE;
/*!40000 ALTER TABLE `commerce_purchasables` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `commerce_purchasables` VALUES (3,'DONATION-CC3',0.0000,'Donation','2021-03-15 15:24:15','2021-03-15 15:24:15','1a0ab098-f27a-49aa-a337-dfdae887ca7d'),(5,'ANT-001',20.0000,'A New Toga','2021-03-15 15:24:16','2021-03-15 15:24:21','73264057-2687-4bba-8398-f114d12d9b90'),(7,'PSB-001',30.0000,'Parka With Stripes On Back','2021-03-15 15:24:16','2021-03-15 15:24:21','e57d56e9-0636-41a0-9ab2-17a81fcf5bbb'),(9,'RRE-001',40.0000,'Romper For A Red Eye','2021-03-15 15:24:16','2021-03-15 15:24:21','36c0fd4f-9802-4acd-b105-a3227904e4ed'),(11,'TFA-001',50.0000,'The Fleece Awakens','2021-03-15 15:24:16','2021-03-15 15:24:21','d8b920b2-c4ed-4b8a-86f6-0025e833efe1'),(13,'LKH-001',60.0000,'The Last Knee-High','2021-03-15 15:24:16','2021-03-15 15:24:21','a6671fad-f0da-4f4d-956e-2bcfee0eb38a'),(15,'FDB-001',70.0000,'Full-Size Dry Boxer','2021-03-15 15:24:16','2021-03-15 15:24:21','d1c8b184-8d42-4d13-b74c-e9c09f3ed763');
/*!40000 ALTER TABLE `commerce_purchasables` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_sale_categories`
--

LOCK TABLES `commerce_sale_categories` WRITE;
/*!40000 ALTER TABLE `commerce_sale_categories` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_sale_categories` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_sale_purchasables`
--

LOCK TABLES `commerce_sale_purchasables` WRITE;
/*!40000 ALTER TABLE `commerce_sale_purchasables` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_sale_purchasables` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_sale_usergroups`
--

LOCK TABLES `commerce_sale_usergroups` WRITE;
/*!40000 ALTER TABLE `commerce_sale_usergroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_sale_usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_sales`
--

LOCK TABLES `commerce_sales` WRITE;
/*!40000 ALTER TABLE `commerce_sales` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_sales` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_shippingcategories`
--

LOCK TABLES `commerce_shippingcategories` WRITE;
/*!40000 ALTER TABLE `commerce_shippingcategories` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `commerce_shippingcategories` VALUES (1,'General','general',NULL,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','be10562c-0b2f-4a6a-a7f5-58fb319bec36');
/*!40000 ALTER TABLE `commerce_shippingcategories` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_shippingmethods`
--

LOCK TABLES `commerce_shippingmethods` WRITE;
/*!40000 ALTER TABLE `commerce_shippingmethods` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `commerce_shippingmethods` VALUES (1,'Free Shipping','freeShipping',1,NULL,'2021-03-15 15:24:15','2021-03-15 15:24:15','6653ddfe-01e0-43d2-b243-19c23010c8bd');
/*!40000 ALTER TABLE `commerce_shippingmethods` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_shippingrule_categories`
--

LOCK TABLES `commerce_shippingrule_categories` WRITE;
/*!40000 ALTER TABLE `commerce_shippingrule_categories` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_shippingrule_categories` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_shippingrules`
--

LOCK TABLES `commerce_shippingrules` WRITE;
/*!40000 ALTER TABLE `commerce_shippingrules` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `commerce_shippingrules` VALUES (1,NULL,1,'Free Everywhere','All Countries, free shipping.',0,1,0,0,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'2021-03-15 15:24:15','2021-03-15 15:24:15','44d05ef5-eb54-4292-b582-3d474bd45191','salePrice',NULL);
/*!40000 ALTER TABLE `commerce_shippingrules` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_shippingzone_countries`
--

LOCK TABLES `commerce_shippingzone_countries` WRITE;
/*!40000 ALTER TABLE `commerce_shippingzone_countries` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_shippingzone_countries` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_shippingzone_states`
--

LOCK TABLES `commerce_shippingzone_states` WRITE;
/*!40000 ALTER TABLE `commerce_shippingzone_states` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_shippingzone_states` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_shippingzones`
--

LOCK TABLES `commerce_shippingzones` WRITE;
/*!40000 ALTER TABLE `commerce_shippingzones` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_shippingzones` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_states`
--

LOCK TABLES `commerce_states` WRITE;
/*!40000 ALTER TABLE `commerce_states` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `commerce_states` VALUES (1,14,'Australian Capital Territory','ACT',1,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','43fb849f-3b98-4b8e-bef0-f31b466e58d4'),(2,14,'New South Wales','NSW',2,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','dcd5ebb4-0163-4bd5-bc80-d474a6d4d852'),(3,14,'Northern Territory','NT',3,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','5f01255e-0a6e-4c09-b617-b3ccc0d49d95'),(4,14,'Queensland','QLD',4,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','43369461-d0d6-40e4-be0e-73184ad83ccb'),(5,14,'South Australia','SA',5,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','f53d1e3c-0267-4b8e-b323-e81e9e5d4379'),(6,14,'Tasmania','TAS',6,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','31b3ec15-4ff2-4db0-850f-e17651f560f7'),(7,14,'Victoria','VIC',7,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','550c579f-9ca5-4d5c-84d0-1c3b3a970b30'),(8,14,'Western Australia','WA',8,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','784d98ac-539d-4e5b-9314-077e6983cf48'),(9,41,'Alberta','AB',1,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','76ff57a8-ab59-4427-9608-14ba03bd6f69'),(10,41,'British Columbia','BC',2,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','eb4750ff-800a-4507-b6cd-f87149565d38'),(11,41,'Manitoba','MB',3,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','e963d460-5508-457a-84bb-fbef5a85cc30'),(12,41,'New Brunswick','NB',4,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','bda188d2-1a84-41d1-8ec1-82b36ab65883'),(13,41,'Newfoundland and Labrador','NL',5,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','26264746-07de-4786-9c31-d7c16345e280'),(14,41,'Northwest Territories','NT',6,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','de3fbc57-7625-4006-a1f3-c7b33cae9b56'),(15,41,'Nova Scotia','NS',7,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','6ba235fe-5ebf-4f7c-96e1-9f4b1bde1d09'),(16,41,'Nunavut','NU',8,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','f49521d2-6557-404a-ba79-496ffbf6ed02'),(17,41,'Ontario','ON',9,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','1de02a8f-b841-47c4-b9bf-51af060374b1'),(18,41,'Prince Edward Island','PE',10,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','8050ebb4-83e4-41f3-8265-6f606fa143f6'),(19,41,'Quebec','QC',11,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','44794474-6670-44e6-809a-be6755de1f3b'),(20,41,'Saskatchewan','SK',12,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','26c28206-28be-4403-9b75-93481d1bf552'),(21,41,'Yukon','YT',13,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','fae7001c-314e-4b6f-a409-8d027f2bf417'),(22,236,'Alabama','AL',1,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','4ef34472-fdc6-4553-a0fa-8e392bb8f25d'),(23,236,'Alaska','AK',2,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','23727347-465c-40ed-b04a-f085ba562ff8'),(24,236,'Arizona','AZ',3,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','e8c250e3-2734-46e0-af56-9f028530cc9e'),(25,236,'Arkansas','AR',4,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','83da0737-79e6-4725-bf53-f614efd9fdbb'),(26,236,'California','CA',5,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','bf22ba0c-c81e-4418-879d-5b5b93645c6a'),(27,236,'Colorado','CO',6,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','74a3a801-5174-4c1b-af0c-cf0574cbf753'),(28,236,'Connecticut','CT',7,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','33f0a9de-0ad9-40b2-98ab-98e58ce622ab'),(29,236,'Delaware','DE',8,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','91156b65-f21d-4934-9131-0f27b46e9b61'),(30,236,'District of Columbia','DC',9,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','b331376b-fde4-40b1-9647-aabe3a3b4140'),(31,236,'Florida','FL',10,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','dc1b07d7-bc54-4861-8936-c97190481f6f'),(32,236,'Georgia','GA',11,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','464fc09b-7dcc-45a1-b421-c3a064c9303a'),(33,236,'Hawaii','HI',12,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','fe281885-0e5f-4734-af41-2778baeaae23'),(34,236,'Idaho','ID',13,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','33219f6a-b322-454d-8066-4872954f047e'),(35,236,'Illinois','IL',14,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','85de4322-4635-4328-99d5-4a111990edd8'),(36,236,'Indiana','IN',15,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','a325bb9e-374b-4c59-99c6-631d2dfc9477'),(37,236,'Iowa','IA',16,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','14b33ed4-c9a0-4581-babf-1c74997961d5'),(38,236,'Kansas','KS',17,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','913b893a-1d84-4989-bdd4-bf3205b0d6b0'),(39,236,'Kentucky','KY',18,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','755c0a5c-1834-41e7-9864-65792e4f3560'),(40,236,'Louisiana','LA',19,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','b2334e14-64c5-4413-b2cf-71dbca809222'),(41,236,'Maine','ME',20,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','977e85cb-6cf9-4953-b62e-51708e9f0512'),(42,236,'Maryland','MD',21,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','f3da3768-ce15-439e-b0df-530b164a6044'),(43,236,'Massachusetts','MA',22,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','47521db9-8aa7-45c2-a825-8e6bb6737276'),(44,236,'Michigan','MI',23,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','a695d383-a2d8-4eb1-be16-ed28189b496f'),(45,236,'Minnesota','MN',24,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','6a937388-ca1f-4dcb-8dd4-5ae7b1509db1'),(46,236,'Mississippi','MS',25,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','0892e4b9-3db4-4cb6-930f-29b55833616f'),(47,236,'Missouri','MO',26,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','5cf93175-480e-4a99-b3cf-6085393fade8'),(48,236,'Montana','MT',27,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','b0e4d214-c179-4ebb-b1fe-eb5fce8b09c1'),(49,236,'Nebraska','NE',28,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','905d1f47-3efa-4509-97b2-0787e9be9a67'),(50,236,'Nevada','NV',29,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','238ccd6a-9e0b-4203-a0ed-8356d22146bf'),(51,236,'New Hampshire','NH',30,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','bd7bac65-94cd-4b46-b763-568ceccac517'),(52,236,'New Jersey','NJ',31,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','54d93feb-ba3d-4a35-a5b1-00c4bbe791c1'),(53,236,'New Mexico','NM',32,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','1f4e6b8f-76a6-46c0-9f7f-18bb78795b21'),(54,236,'New York','NY',33,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','5b83a87f-9b8a-4208-b985-ea8bb5625f22'),(55,236,'North Carolina','NC',34,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','fd54e66d-df04-4fae-bde5-2dc7281f1ab8'),(56,236,'North Dakota','ND',35,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','94a88110-9ed8-4c60-8e69-915f55392fbe'),(57,236,'Ohio','OH',36,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','f66e5bfc-bc7a-4ff1-a879-25b385dc33b3'),(58,236,'Oklahoma','OK',37,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','0c15f968-f84e-4f0b-93b3-0342691c3814'),(59,236,'Oregon','OR',38,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','47454337-8307-4d94-bfb6-634131ccdb88'),(60,236,'Pennsylvania','PA',39,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','0817d46d-0e49-4fbd-bf35-6db9fa377842'),(61,236,'Rhode Island','RI',40,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','0debcca0-5cd1-405f-a618-2307a60c83e3'),(62,236,'South Carolina','SC',41,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','45b8ec5c-7c27-49b8-bbec-5e24bea58350'),(63,236,'South Dakota','SD',42,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','7b1a8197-44ef-4416-8911-56573d9eba4f'),(64,236,'Tennessee','TN',43,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','a036b7dd-5558-45be-bf35-6e798dc679b6'),(65,236,'Texas','TX',44,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','63b90cce-868f-4d98-b677-5053d4f76b1e'),(66,236,'Utah','UT',45,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','1a98a1be-b6a1-4a34-bc19-c0b0dc31106d'),(67,236,'Vermont','VT',46,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','277e8bb4-84b3-47b0-869f-02b279c6620f'),(68,236,'Virginia','VA',47,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','a9ccd87f-2b22-42c6-84d5-2aba5396cfd9'),(69,236,'Washington','WA',48,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','02b620e8-bdc4-4791-aacd-ae0b17463f60'),(70,236,'West Virginia','WV',49,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','cf2fe7b7-b490-46da-b575-49175f38b80a'),(71,236,'Wisconsin','WI',50,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','56f7135a-595a-456d-a0ba-ae4dc8881eb2'),(72,236,'Wyoming','WY',51,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','16989935-0609-46f7-9b3e-ddbea4930c6f');
/*!40000 ALTER TABLE `commerce_states` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_subscriptions`
--

LOCK TABLES `commerce_subscriptions` WRITE;
/*!40000 ALTER TABLE `commerce_subscriptions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_subscriptions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_taxcategories`
--

LOCK TABLES `commerce_taxcategories` WRITE;
/*!40000 ALTER TABLE `commerce_taxcategories` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `commerce_taxcategories` VALUES (1,'General','general',NULL,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','c0e9ddb3-5718-4a8a-a869-1d8605eefd99');
/*!40000 ALTER TABLE `commerce_taxcategories` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_taxrates`
--

LOCK TABLES `commerce_taxrates` WRITE;
/*!40000 ALTER TABLE `commerce_taxrates` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_taxrates` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_taxzone_countries`
--

LOCK TABLES `commerce_taxzone_countries` WRITE;
/*!40000 ALTER TABLE `commerce_taxzone_countries` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_taxzone_countries` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_taxzone_states`
--

LOCK TABLES `commerce_taxzone_states` WRITE;
/*!40000 ALTER TABLE `commerce_taxzone_states` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_taxzone_states` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_taxzones`
--

LOCK TABLES `commerce_taxzones` WRITE;
/*!40000 ALTER TABLE `commerce_taxzones` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_taxzones` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_transactions`
--

LOCK TABLES `commerce_transactions` WRITE;
/*!40000 ALTER TABLE `commerce_transactions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_transactions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_variants`
--

LOCK TABLES `commerce_variants` WRITE;
/*!40000 ALTER TABLE `commerce_variants` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `commerce_variants` VALUES (5,4,'ANT-001',1,20.0000,1,NULL,NULL,NULL,NULL,0,1,NULL,NULL,NULL,'2021-03-15 15:24:16','2021-03-15 15:24:21','18e5ccd9-fb98-46c0-8ab9-d8e7fbff1d52'),(7,6,'PSB-001',1,30.0000,1,NULL,NULL,NULL,NULL,0,1,NULL,NULL,NULL,'2021-03-15 15:24:16','2021-03-15 15:24:21','6e623583-dfdc-4078-a34e-55e84eab0763'),(9,8,'RRE-001',1,40.0000,1,NULL,NULL,NULL,NULL,0,1,NULL,NULL,NULL,'2021-03-15 15:24:16','2021-03-15 15:24:21','b2ce7de5-0220-41e6-8fc5-76e3b3158a0c'),(11,10,'TFA-001',1,50.0000,1,NULL,NULL,NULL,NULL,0,1,NULL,NULL,NULL,'2021-03-15 15:24:16','2021-03-15 15:24:21','bee72da1-5f64-4bfd-a227-19eb47e5dccf'),(13,12,'LKH-001',1,60.0000,1,NULL,NULL,NULL,NULL,0,1,NULL,NULL,NULL,'2021-03-15 15:24:16','2021-03-15 15:24:21','1f3ac8da-e7d7-4911-b93b-619735fb2f94'),(15,14,'FDB-001',1,70.0000,1,NULL,NULL,NULL,NULL,0,1,NULL,NULL,NULL,'2021-03-15 15:24:16','2021-03-15 15:24:21','4d9ba583-588e-435e-8cec-8a461d3125c8');
/*!40000 ALTER TABLE `commerce_variants` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `content`
--

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `content` VALUES (1,1,1,NULL,'2020-03-27 13:22:43','2021-03-15 14:56:59','b77b0362-fbf0-45dd-a5d7-e1b0c971eb48',NULL,NULL,NULL,NULL,NULL),(2,2,1,'Homepage','2020-03-27 13:38:49','2021-03-15 15:40:42','7fa40164-962a-4e1b-804a-245447006340',NULL,'{\"bundleVersion\":\"1.0.22\",\"sourceBundleType\":\"field\",\"sourceId\":null,\"sourceName\":null,\"sourceHandle\":null,\"sourceType\":\"field\",\"typeId\":null,\"sourceTemplate\":\"\",\"sourceSiteId\":null,\"sourceAltSiteSettings\":[],\"sourceDateUpdated\":\"2021-03-15T11:11:46-04:00\",\"metaGlobalVars\":{\"language\":null,\"mainEntityOfPage\":\"\",\"seoTitle\":\"\",\"siteNamePosition\":\"\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"\",\"robots\":\"\",\"ogType\":\"\",\"ogTitle\":\"\",\"ogSiteNamePosition\":\"\",\"ogDescription\":\"\",\"ogImage\":\"\",\"ogImageWidth\":\"\",\"ogImageHeight\":\"\",\"ogImageDescription\":\"\",\"twitterCard\":\"\",\"twitterCreator\":\"\",\"twitterTitle\":\"\",\"twitterSiteNamePosition\":\"\",\"twitterDescription\":\"\",\"twitterImage\":\"\",\"twitterImageWidth\":\"\",\"twitterImageHeight\":\"\",\"twitterImageDescription\":\"\"},\"metaSiteVars\":{\"siteName\":\"Project\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]},\"metaSitemapVars\":{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[],\"sitemapVideoFieldMap\":[]},\"metaContainers\":{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}},\"redirectsContainer\":[],\"frontendTemplatesContainer\":{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null,\"clearCache\":false},\"metaBundleSettings\":{\"siteType\":\"\",\"siteSubType\":\"\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromCustom\",\"seoTitleField\":\"\",\"siteNamePositionSource\":\"sameAsGlobal\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"sameAsGlobal\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"sameAsGlobal\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}}',NULL,NULL,NULL),(3,2,2,'Homepage','2021-03-15 15:04:42','2021-03-15 15:40:42','2d1fee00-e16c-4f3d-b8e3-c2fb5ee84a6a',NULL,'{\"bundleVersion\":\"1.0.22\",\"sourceBundleType\":\"field\",\"sourceId\":null,\"sourceName\":null,\"sourceHandle\":null,\"sourceType\":\"field\",\"typeId\":null,\"sourceTemplate\":\"\",\"sourceSiteId\":null,\"sourceAltSiteSettings\":[],\"sourceDateUpdated\":\"2021-03-15T11:11:46-04:00\",\"metaGlobalVars\":{\"language\":null,\"mainEntityOfPage\":\"\",\"seoTitle\":\"\",\"siteNamePosition\":\"\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"\",\"robots\":\"\",\"ogType\":\"\",\"ogTitle\":\"\",\"ogSiteNamePosition\":\"\",\"ogDescription\":\"\",\"ogImage\":\"\",\"ogImageWidth\":\"\",\"ogImageHeight\":\"\",\"ogImageDescription\":\"\",\"twitterCard\":\"\",\"twitterCreator\":\"\",\"twitterTitle\":\"\",\"twitterSiteNamePosition\":\"\",\"twitterDescription\":\"\",\"twitterImage\":\"\",\"twitterImageWidth\":\"\",\"twitterImageHeight\":\"\",\"twitterImageDescription\":\"\"},\"metaSiteVars\":{\"siteName\":\"Project\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]},\"metaSitemapVars\":{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[],\"sitemapVideoFieldMap\":[]},\"metaContainers\":{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}},\"redirectsContainer\":[],\"frontendTemplatesContainer\":{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null,\"clearCache\":false},\"metaBundleSettings\":{\"siteType\":\"\",\"siteSubType\":\"\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromCustom\",\"seoTitleField\":\"\",\"siteNamePositionSource\":\"sameAsGlobal\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"sameAsGlobal\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"sameAsGlobal\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}}',NULL,NULL,NULL),(4,4,1,'A New Toga','2021-03-15 15:24:16','2021-03-15 15:24:21','7df96e57-107a-4aa7-b768-7ba4f0340abb',NULL,NULL,NULL,NULL,NULL),(5,5,1,'A New Toga','2021-03-15 15:24:16','2021-03-15 15:24:21','b88e9a21-00e4-4a30-a5f5-4f32b9b684dc',NULL,NULL,NULL,NULL,NULL),(6,4,2,'A New Toga','2021-03-15 15:24:16','2021-03-15 15:24:21','db321258-d8f1-4c17-a139-a55aa26d05ea',NULL,NULL,NULL,NULL,NULL),(7,5,2,'A New Toga','2021-03-15 15:24:16','2021-03-15 15:24:21','dcbbeef9-5119-4ece-80a7-9fa312319e3c',NULL,NULL,NULL,NULL,NULL),(8,6,1,'Parka With Stripes On Back','2021-03-15 15:24:16','2021-03-15 15:24:21','4ebb64c1-2a76-4e25-8fe0-94521ea9b2d1',NULL,NULL,NULL,NULL,NULL),(9,7,1,'Parka With Stripes On Back','2021-03-15 15:24:16','2021-03-15 15:24:21','08b2eead-094d-4b85-97bc-af3dd3ab9a02',NULL,NULL,NULL,NULL,NULL),(10,6,2,'Parka With Stripes On Back','2021-03-15 15:24:16','2021-03-15 15:24:21','1d10b92a-a77a-4dfc-a95c-9ec85107504b',NULL,NULL,NULL,NULL,NULL),(11,7,2,'Parka With Stripes On Back','2021-03-15 15:24:16','2021-03-15 15:24:21','fd093eb5-9737-496c-84d1-2903c92b525f',NULL,NULL,NULL,NULL,NULL),(12,8,1,'Romper For A Red Eye','2021-03-15 15:24:16','2021-03-15 15:24:21','8586816f-3b72-405e-9cca-0af3f1e58e68',NULL,NULL,NULL,NULL,NULL),(13,9,1,'Romper For A Red Eye','2021-03-15 15:24:16','2021-03-15 15:24:21','2479a095-c556-4592-bc32-eeca2e23b63a',NULL,NULL,NULL,NULL,NULL),(14,8,2,'Romper For A Red Eye','2021-03-15 15:24:16','2021-03-15 15:24:21','70478e88-c5f5-48ac-b8ac-b2fd5636e27b',NULL,NULL,NULL,NULL,NULL),(15,9,2,'Romper For A Red Eye','2021-03-15 15:24:16','2021-03-15 15:24:21','0e8423ea-2f65-4b99-b13f-eb4004cb4f84',NULL,NULL,NULL,NULL,NULL),(16,10,1,'The Fleece Awakens','2021-03-15 15:24:16','2021-03-15 15:24:21','d3f8934c-4ac9-4063-9c0d-c87c209a769b',NULL,NULL,NULL,NULL,NULL),(17,11,1,'The Fleece Awakens','2021-03-15 15:24:16','2021-03-15 15:24:21','81b3af94-1fdc-4c80-8c46-caf8f1cc0bf4',NULL,NULL,NULL,NULL,NULL),(18,10,2,'The Fleece Awakens','2021-03-15 15:24:16','2021-03-15 15:24:21','ffdfd8e6-7f8a-4f45-afe1-73dc278339b0',NULL,NULL,NULL,NULL,NULL),(19,11,2,'The Fleece Awakens','2021-03-15 15:24:16','2021-03-15 15:24:21','7310b4a7-1ec3-4c9d-8584-31907c052a5c',NULL,NULL,NULL,NULL,NULL),(20,12,1,'The Last Knee-High','2021-03-15 15:24:16','2021-03-15 15:24:21','7eb5caa9-e343-4398-813f-c5b77c42da0c',NULL,NULL,NULL,NULL,NULL),(21,13,1,'The Last Knee-High','2021-03-15 15:24:16','2021-03-15 15:24:21','7ae9c9d1-96d2-43f7-9b06-ffc8e111a11a',NULL,NULL,NULL,NULL,NULL),(22,12,2,'The Last Knee-High','2021-03-15 15:24:16','2021-03-15 15:24:21','d7682d0e-daaa-452f-a583-a155c05e6de7',NULL,NULL,NULL,NULL,NULL),(23,13,2,'The Last Knee-High','2021-03-15 15:24:16','2021-03-15 15:24:21','abb292ed-d47f-438b-ade1-e821a4d67716',NULL,NULL,NULL,NULL,NULL),(24,14,1,'Full-Size Dry Boxer','2021-03-15 15:24:16','2021-03-15 15:24:21','b1f90db4-8818-4622-9d82-75600be1049a',NULL,NULL,NULL,NULL,NULL),(25,15,1,'Full-Size Dry Boxer','2021-03-15 15:24:16','2021-03-15 15:24:21','50f3d387-437b-492d-ab02-b291ce8a999d',NULL,NULL,NULL,NULL,NULL),(26,14,2,'Full-Size Dry Boxer','2021-03-15 15:24:16','2021-03-15 15:24:21','c607b7c2-8e56-43f1-a4f2-2adff9317505',NULL,NULL,NULL,NULL,NULL),(27,15,2,'Full-Size Dry Boxer','2021-03-15 15:24:16','2021-03-15 15:24:21','cba55962-d1ef-4151-9e97-a92ab7b7a5f7',NULL,NULL,NULL,NULL,NULL),(30,17,1,'My first blog','2021-03-15 15:41:19','2021-03-15 16:17:36','e4c2f79d-0f9f-4e3b-8bdb-aca6526878b6',NULL,'{\"bundleVersion\":\"1.0.22\",\"sourceBundleType\":\"field\",\"sourceId\":null,\"sourceName\":null,\"sourceHandle\":null,\"sourceType\":\"field\",\"typeId\":null,\"sourceTemplate\":\"\",\"sourceSiteId\":null,\"sourceAltSiteSettings\":[],\"sourceDateUpdated\":\"2021-03-15T11:40:51-04:00\",\"metaGlobalVars\":{\"language\":null,\"mainEntityOfPage\":\"\",\"seoTitle\":\"\",\"siteNamePosition\":\"\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"\",\"robots\":\"\",\"ogType\":\"\",\"ogTitle\":\"\",\"ogSiteNamePosition\":\"\",\"ogDescription\":\"\",\"ogImage\":\"\",\"ogImageWidth\":\"\",\"ogImageHeight\":\"\",\"ogImageDescription\":\"\",\"twitterCard\":\"\",\"twitterCreator\":\"\",\"twitterTitle\":\"\",\"twitterSiteNamePosition\":\"\",\"twitterDescription\":\"\",\"twitterImage\":\"\",\"twitterImageWidth\":\"\",\"twitterImageHeight\":\"\",\"twitterImageDescription\":\"\"},\"metaSiteVars\":{\"siteName\":\"Project\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]},\"metaSitemapVars\":{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[],\"sitemapVideoFieldMap\":[]},\"metaContainers\":{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}},\"redirectsContainer\":[],\"frontendTemplatesContainer\":{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null,\"clearCache\":false},\"metaBundleSettings\":{\"siteType\":\"\",\"siteSubType\":\"\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromCustom\",\"seoTitleField\":\"\",\"siteNamePositionSource\":\"sameAsGlobal\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"sameAsGlobal\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"sameAsGlobal\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}}','<p>Some Rich Text</p>','Some plain text',NULL),(31,17,2,'My first blog','2021-03-15 15:41:19','2021-03-15 16:17:37','a8ffc233-ab15-4c0c-977b-4b436fc31066',NULL,'{\"bundleVersion\":\"1.0.22\",\"sourceBundleType\":\"field\",\"sourceId\":null,\"sourceName\":null,\"sourceHandle\":null,\"sourceType\":\"field\",\"typeId\":null,\"sourceTemplate\":\"\",\"sourceSiteId\":null,\"sourceAltSiteSettings\":[],\"sourceDateUpdated\":\"2021-03-15T11:40:51-04:00\",\"metaGlobalVars\":{\"language\":null,\"mainEntityOfPage\":\"\",\"seoTitle\":\"\",\"siteNamePosition\":\"\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"\",\"robots\":\"\",\"ogType\":\"\",\"ogTitle\":\"\",\"ogSiteNamePosition\":\"\",\"ogDescription\":\"\",\"ogImage\":\"\",\"ogImageWidth\":\"\",\"ogImageHeight\":\"\",\"ogImageDescription\":\"\",\"twitterCard\":\"\",\"twitterCreator\":\"\",\"twitterTitle\":\"\",\"twitterSiteNamePosition\":\"\",\"twitterDescription\":\"\",\"twitterImage\":\"\",\"twitterImageWidth\":\"\",\"twitterImageHeight\":\"\",\"twitterImageDescription\":\"\"},\"metaSiteVars\":{\"siteName\":\"Project\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]},\"metaSitemapVars\":{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[],\"sitemapVideoFieldMap\":[]},\"metaContainers\":{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}},\"redirectsContainer\":[],\"frontendTemplatesContainer\":{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null,\"clearCache\":false},\"metaBundleSettings\":{\"siteType\":\"\",\"siteSubType\":\"\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromCustom\",\"seoTitleField\":\"\",\"siteNamePositionSource\":\"sameAsGlobal\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"sameAsGlobal\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"sameAsGlobal\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}}','<p>Some Rich Text</p>','Some plain text',NULL),(32,18,1,'My first blog','2021-03-15 15:41:19','2021-03-15 15:41:19','e84e777f-98c7-4cf7-b7cb-80a77833b218',NULL,'{\"bundleVersion\":\"1.0.22\",\"sourceBundleType\":\"field\",\"sourceId\":null,\"sourceName\":null,\"sourceHandle\":null,\"sourceType\":\"field\",\"typeId\":null,\"sourceTemplate\":\"\",\"sourceSiteId\":null,\"sourceAltSiteSettings\":[],\"sourceDateUpdated\":\"2021-03-15T11:40:51-04:00\",\"metaGlobalVars\":{\"language\":null,\"mainEntityOfPage\":\"\",\"seoTitle\":\"\",\"siteNamePosition\":\"\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"\",\"robots\":\"\",\"ogType\":\"\",\"ogTitle\":\"\",\"ogSiteNamePosition\":\"\",\"ogDescription\":\"\",\"ogImage\":\"\",\"ogImageWidth\":\"\",\"ogImageHeight\":\"\",\"ogImageDescription\":\"\",\"twitterCard\":\"\",\"twitterCreator\":\"\",\"twitterTitle\":\"\",\"twitterSiteNamePosition\":\"\",\"twitterDescription\":\"\",\"twitterImage\":\"\",\"twitterImageWidth\":\"\",\"twitterImageHeight\":\"\",\"twitterImageDescription\":\"\"},\"metaSiteVars\":{\"siteName\":\"Project\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]},\"metaSitemapVars\":{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[],\"sitemapVideoFieldMap\":[]},\"metaContainers\":{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}},\"redirectsContainer\":[],\"frontendTemplatesContainer\":{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null,\"clearCache\":false},\"metaBundleSettings\":{\"siteType\":\"\",\"siteSubType\":\"\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromCustom\",\"seoTitleField\":\"\",\"siteNamePositionSource\":\"sameAsGlobal\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"sameAsGlobal\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"sameAsGlobal\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}}','<p>Some Rich Text!</p>','Some plain text',NULL),(33,18,2,'My first blog','2021-03-15 15:41:19','2021-03-15 15:41:19','8a3aaead-866b-416d-a8f4-12db80ad4f1e',NULL,'{\"bundleVersion\":\"1.0.22\",\"sourceBundleType\":\"field\",\"sourceId\":null,\"sourceName\":null,\"sourceHandle\":null,\"sourceType\":\"field\",\"typeId\":null,\"sourceTemplate\":\"\",\"sourceSiteId\":null,\"sourceAltSiteSettings\":[],\"sourceDateUpdated\":\"2021-03-15T11:40:51-04:00\",\"metaGlobalVars\":{\"language\":null,\"mainEntityOfPage\":\"\",\"seoTitle\":\"\",\"siteNamePosition\":\"\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"\",\"robots\":\"\",\"ogType\":\"\",\"ogTitle\":\"\",\"ogSiteNamePosition\":\"\",\"ogDescription\":\"\",\"ogImage\":\"\",\"ogImageWidth\":\"\",\"ogImageHeight\":\"\",\"ogImageDescription\":\"\",\"twitterCard\":\"\",\"twitterCreator\":\"\",\"twitterTitle\":\"\",\"twitterSiteNamePosition\":\"\",\"twitterDescription\":\"\",\"twitterImage\":\"\",\"twitterImageWidth\":\"\",\"twitterImageHeight\":\"\",\"twitterImageDescription\":\"\"},\"metaSiteVars\":{\"siteName\":\"Project\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]},\"metaSitemapVars\":{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[],\"sitemapVideoFieldMap\":[]},\"metaContainers\":{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}},\"redirectsContainer\":[],\"frontendTemplatesContainer\":{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null,\"clearCache\":false},\"metaBundleSettings\":{\"siteType\":\"\",\"siteSubType\":\"\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromCustom\",\"seoTitleField\":\"\",\"siteNamePositionSource\":\"sameAsGlobal\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"sameAsGlobal\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"sameAsGlobal\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}}','<p>Some Rich Text!</p>','Some plain text',NULL),(34,19,1,NULL,'2021-03-15 15:55:30','2022-01-31 03:40:29','855856c1-048c-485c-aff8-d182d305d5c0',NULL,NULL,'<p>Some global rich text</p>','Some global plain text',NULL),(35,19,2,NULL,'2021-03-15 15:55:30','2022-01-31 03:40:29','e237f398-3087-4d0c-a281-0ec3ab25d3f6',NULL,NULL,'<p>Some global rich text</p>','Some global plain text',NULL),(36,20,1,'My first blog','2021-03-15 16:17:37','2021-03-15 16:17:37','5506cc52-6de9-405e-92ae-ff23a3ed6f86',NULL,'{\"bundleVersion\":\"1.0.22\",\"sourceBundleType\":\"field\",\"sourceId\":null,\"sourceName\":null,\"sourceHandle\":null,\"sourceType\":\"field\",\"typeId\":null,\"sourceTemplate\":\"\",\"sourceSiteId\":null,\"sourceAltSiteSettings\":[],\"sourceDateUpdated\":\"2021-03-15T11:40:51-04:00\",\"metaGlobalVars\":{\"language\":null,\"mainEntityOfPage\":\"\",\"seoTitle\":\"\",\"siteNamePosition\":\"\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"\",\"robots\":\"\",\"ogType\":\"\",\"ogTitle\":\"\",\"ogSiteNamePosition\":\"\",\"ogDescription\":\"\",\"ogImage\":\"\",\"ogImageWidth\":\"\",\"ogImageHeight\":\"\",\"ogImageDescription\":\"\",\"twitterCard\":\"\",\"twitterCreator\":\"\",\"twitterTitle\":\"\",\"twitterSiteNamePosition\":\"\",\"twitterDescription\":\"\",\"twitterImage\":\"\",\"twitterImageWidth\":\"\",\"twitterImageHeight\":\"\",\"twitterImageDescription\":\"\"},\"metaSiteVars\":{\"siteName\":\"Project\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]},\"metaSitemapVars\":{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[],\"sitemapVideoFieldMap\":[]},\"metaContainers\":{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}},\"redirectsContainer\":[],\"frontendTemplatesContainer\":{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null,\"clearCache\":false},\"metaBundleSettings\":{\"siteType\":\"\",\"siteSubType\":\"\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromCustom\",\"seoTitleField\":\"\",\"siteNamePositionSource\":\"sameAsGlobal\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"sameAsGlobal\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"sameAsGlobal\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}}','<p>Some Rich Text</p>','Some plain text',NULL),(37,20,2,'My first blog','2021-03-15 16:17:37','2021-03-15 16:17:37','6b7f8578-24eb-4928-8738-97805a747c17',NULL,'{\"bundleVersion\":\"1.0.22\",\"sourceBundleType\":\"field\",\"sourceId\":null,\"sourceName\":null,\"sourceHandle\":null,\"sourceType\":\"field\",\"typeId\":null,\"sourceTemplate\":\"\",\"sourceSiteId\":null,\"sourceAltSiteSettings\":[],\"sourceDateUpdated\":\"2021-03-15T11:40:51-04:00\",\"metaGlobalVars\":{\"language\":null,\"mainEntityOfPage\":\"\",\"seoTitle\":\"\",\"siteNamePosition\":\"\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"\",\"robots\":\"\",\"ogType\":\"\",\"ogTitle\":\"\",\"ogSiteNamePosition\":\"\",\"ogDescription\":\"\",\"ogImage\":\"\",\"ogImageWidth\":\"\",\"ogImageHeight\":\"\",\"ogImageDescription\":\"\",\"twitterCard\":\"\",\"twitterCreator\":\"\",\"twitterTitle\":\"\",\"twitterSiteNamePosition\":\"\",\"twitterDescription\":\"\",\"twitterImage\":\"\",\"twitterImageWidth\":\"\",\"twitterImageHeight\":\"\",\"twitterImageDescription\":\"\"},\"metaSiteVars\":{\"siteName\":\"Project\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]},\"metaSitemapVars\":{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[],\"sitemapVideoFieldMap\":[]},\"metaContainers\":{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}},\"redirectsContainer\":[],\"frontendTemplatesContainer\":{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null,\"clearCache\":false},\"metaBundleSettings\":{\"siteType\":\"\",\"siteSubType\":\"\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromCustom\",\"seoTitleField\":\"\",\"siteNamePositionSource\":\"sameAsGlobal\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"sameAsGlobal\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"sameAsGlobal\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}}','<p>Some Rich Text</p>','Some plain text',NULL),(38,21,1,'Puppies','2021-04-01 02:35:35','2021-04-01 02:35:35','dfb9075a-6ba9-4904-81dd-79b4adda4fd0',NULL,NULL,NULL,NULL,NULL),(39,21,2,'Puppies','2021-04-01 02:35:35','2021-04-01 02:35:35','62dbcf58-01eb-441b-9c99-ecab0559dbbb',NULL,NULL,NULL,NULL,NULL),(40,22,1,'Kitties','2021-04-01 02:35:44','2021-04-01 02:35:44','1f5f6c95-0339-484d-adc8-741217ccd0ca',NULL,NULL,NULL,NULL,NULL),(41,22,2,'Kitties','2021-04-01 02:35:44','2021-04-01 02:35:44','1666d380-3f6f-485b-9d7b-2f688e67a050',NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craftidtokens`
--

LOCK TABLES `craftidtokens` WRITE;
/*!40000 ALTER TABLE `craftidtokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craftidtokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `deprecationerrors`
--

LOCK TABLES `deprecationerrors` WRITE;
/*!40000 ALTER TABLE `deprecationerrors` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `deprecationerrors` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `digitalproducts_licenses`
--

LOCK TABLES `digitalproducts_licenses` WRITE;
/*!40000 ALTER TABLE `digitalproducts_licenses` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `digitalproducts_licenses` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `digitalproducts_products`
--

LOCK TABLES `digitalproducts_products` WRITE;
/*!40000 ALTER TABLE `digitalproducts_products` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `digitalproducts_products` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `digitalproducts_producttypes`
--

LOCK TABLES `digitalproducts_producttypes` WRITE;
/*!40000 ALTER TABLE `digitalproducts_producttypes` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `digitalproducts_producttypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `digitalproducts_producttypes_sites`
--

LOCK TABLES `digitalproducts_producttypes_sites` WRITE;
/*!40000 ALTER TABLE `digitalproducts_producttypes_sites` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `digitalproducts_producttypes_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `drafts`
--

LOCK TABLES `drafts` WRITE;
/*!40000 ALTER TABLE `drafts` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `drafts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elementindexsettings`
--

LOCK TABLES `elementindexsettings` WRITE;
/*!40000 ALTER TABLE `elementindexsettings` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `elementindexsettings` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elements`
--

LOCK TABLES `elements` WRITE;
/*!40000 ALTER TABLE `elements` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `elements` VALUES (1,NULL,NULL,NULL,NULL,'craft\\elements\\User',1,0,'2020-03-27 13:22:43','2021-03-15 14:56:59',NULL,NULL,'9c39b369-6229-4753-83e1-afd4da7acf29'),(2,NULL,NULL,NULL,1,'craft\\elements\\Entry',1,0,'2020-03-27 13:38:49','2021-03-15 15:40:42',NULL,NULL,'7526d70b-8b45-4af6-b5b8-c56c6a44e34c'),(3,NULL,NULL,NULL,NULL,'craft\\commerce\\elements\\Donation',1,0,'2021-03-15 15:24:15','2021-03-15 15:24:15',NULL,NULL,'526a5ea3-767b-4df7-8712-580157c88145'),(4,NULL,NULL,NULL,3,'craft\\commerce\\elements\\Product',1,0,'2021-03-15 15:24:16','2021-03-15 15:24:16',NULL,NULL,'7081584e-e3df-4024-9257-7f8e8ec95a28'),(5,NULL,NULL,NULL,NULL,'craft\\commerce\\elements\\Variant',1,0,'2021-03-15 15:24:16','2021-03-15 15:24:21',NULL,NULL,'45269718-1004-4930-859b-07c56d970e17'),(6,NULL,NULL,NULL,3,'craft\\commerce\\elements\\Product',1,0,'2021-03-15 15:24:16','2021-03-15 15:24:16',NULL,NULL,'61078ac7-642e-4108-a552-fb0d0e45881d'),(7,NULL,NULL,NULL,NULL,'craft\\commerce\\elements\\Variant',1,0,'2021-03-15 15:24:16','2021-03-15 15:24:21',NULL,NULL,'642ecb15-e397-4658-b878-22c399183f63'),(8,NULL,NULL,NULL,3,'craft\\commerce\\elements\\Product',1,0,'2021-03-15 15:24:16','2021-03-15 15:24:16',NULL,NULL,'c6b705ef-f5e8-4a57-9e37-efac1cf06d20'),(9,NULL,NULL,NULL,NULL,'craft\\commerce\\elements\\Variant',1,0,'2021-03-15 15:24:16','2021-03-15 15:24:21',NULL,NULL,'a71ddf46-2c55-41c0-92de-fc0ddf3080fa'),(10,NULL,NULL,NULL,3,'craft\\commerce\\elements\\Product',1,0,'2021-03-15 15:24:16','2021-03-15 15:24:16',NULL,NULL,'6406a158-0467-4e91-8504-afa784805abe'),(11,NULL,NULL,NULL,NULL,'craft\\commerce\\elements\\Variant',1,0,'2021-03-15 15:24:16','2021-03-15 15:24:21',NULL,NULL,'4131ac3a-b08d-4811-9909-ad9aaec47e99'),(12,NULL,NULL,NULL,3,'craft\\commerce\\elements\\Product',1,0,'2021-03-15 15:24:16','2021-03-15 15:24:16',NULL,NULL,'d909722a-a9ac-400a-83ae-c43cd44e7064'),(13,NULL,NULL,NULL,NULL,'craft\\commerce\\elements\\Variant',1,0,'2021-03-15 15:24:16','2021-03-15 15:24:21',NULL,NULL,'8f5e64bc-8282-42a9-a462-e13aff72917d'),(14,NULL,NULL,NULL,3,'craft\\commerce\\elements\\Product',1,0,'2021-03-15 15:24:16','2021-03-15 15:24:16',NULL,NULL,'cc3c2113-f0bd-47d2-bad9-5a7c585228a9'),(15,NULL,NULL,NULL,NULL,'craft\\commerce\\elements\\Variant',1,0,'2021-03-15 15:24:16','2021-03-15 15:24:21',NULL,NULL,'e17cdcbf-cf0b-4ff5-9943-f04e7b8d821a'),(17,NULL,NULL,NULL,5,'craft\\elements\\Entry',1,0,'2021-03-15 15:41:19','2021-03-15 16:17:36',NULL,NULL,'251c74e8-9611-447e-a7a0-7c3e48dd315c'),(18,17,NULL,1,5,'craft\\elements\\Entry',1,0,'2021-03-15 15:41:19','2021-03-15 15:41:19',NULL,NULL,'903b23f3-a446-4282-89bb-c18c3a2b8bec'),(19,NULL,NULL,NULL,6,'craft\\elements\\GlobalSet',1,0,'2021-03-15 15:55:30','2022-01-31 03:40:29',NULL,NULL,'aa7c6968-88ec-4d2a-af47-d3c40b582a68'),(20,17,NULL,2,5,'craft\\elements\\Entry',1,0,'2021-03-15 16:17:36','2021-03-15 16:17:36',NULL,NULL,'9e157ef9-368f-49aa-bff9-901e83da4e14'),(21,NULL,NULL,NULL,9,'craft\\elements\\Category',1,0,'2021-04-01 02:35:35','2021-04-01 02:35:35',NULL,'2022-01-31 03:40:28','0b5e2d02-58de-4965-b9c6-280dfecedd34'),(22,NULL,NULL,NULL,9,'craft\\elements\\Category',1,0,'2021-04-01 02:35:44','2021-04-01 02:35:44',NULL,'2022-01-31 03:40:28','8deb5a7a-2202-4eac-8415-2ef70a523974');
/*!40000 ALTER TABLE `elements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elements_sites`
--

LOCK TABLES `elements_sites` WRITE;
/*!40000 ALTER TABLE `elements_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `elements_sites` VALUES (1,1,1,NULL,NULL,1,'2020-03-27 13:22:43','2020-03-27 13:22:43','b03adee1-4d8e-41c3-bcab-890c732ef44d'),(2,2,1,'homepage','__home__',1,'2020-03-27 13:38:49','2020-03-27 13:38:49','40928c54-598c-421b-9a79-3605cfbbcc8b'),(3,2,2,'homepage','__home__',1,'2021-03-15 15:04:42','2021-03-15 15:04:42','ad754d68-f573-4b4d-9b50-dab3ab22348c'),(4,3,1,NULL,NULL,1,'2021-03-15 15:24:15','2021-03-15 15:24:15','a61f7646-3787-4cc3-9daf-3475f78d6c3e'),(5,4,1,'ant-001','shop/products/ant-001',1,'2021-03-15 15:24:16','2021-03-15 15:24:20','6b386ce1-85e7-4598-8d63-754c9a8cd5b3'),(6,5,1,'ant-001',NULL,1,'2021-03-15 15:24:16','2021-03-15 15:24:16','8d337ed7-4895-4a25-a34d-93188989c8d2'),(7,4,2,'ant-001','shop/products/ant-001',1,'2021-03-15 15:24:16','2021-03-15 15:24:20','686befc9-91a8-450a-a6f6-694cd0f3360a'),(8,5,2,'ant-001',NULL,1,'2021-03-15 15:24:16','2021-03-15 15:24:16','5cb47b5e-d6e2-4014-b8de-ec121c0e94a3'),(9,6,1,'psb-001','shop/products/psb-001',1,'2021-03-15 15:24:16','2021-03-15 15:24:20','8f4800bd-b82f-45fc-b0c5-7e5cf3fbdd96'),(10,7,1,'psb-001',NULL,1,'2021-03-15 15:24:16','2021-03-15 15:24:16','9aa280fc-64a1-4ca2-8b7e-d0967fcb59b9'),(11,6,2,'psb-001','shop/products/psb-001',1,'2021-03-15 15:24:16','2021-03-15 15:24:20','e1f53b4e-b9ac-46d1-bd70-32a0f3949930'),(12,7,2,'psb-001',NULL,1,'2021-03-15 15:24:16','2021-03-15 15:24:16','e7fa30a7-09ab-40dc-8f2e-a6dab095794c'),(13,8,1,'rre-001','shop/products/rre-001',1,'2021-03-15 15:24:16','2021-03-15 15:24:20','7b9e5f9b-02db-4766-92dd-f194343d03de'),(14,9,1,'rre-001',NULL,1,'2021-03-15 15:24:16','2021-03-15 15:24:16','1f53e93c-1959-4d16-8965-0edaaa21d59b'),(15,8,2,'rre-001','shop/products/rre-001',1,'2021-03-15 15:24:16','2021-03-15 15:24:20','b6b41b1f-7271-4634-b846-6eb6beabe9ed'),(16,9,2,'rre-001',NULL,1,'2021-03-15 15:24:16','2021-03-15 15:24:16','dacad1bf-d166-4d23-a24f-4d9e164d8a0d'),(17,10,1,'tfa-001','shop/products/tfa-001',1,'2021-03-15 15:24:16','2021-03-15 15:24:20','8157cac0-7325-4e85-883d-f9fc771e7279'),(18,11,1,'tfa-001',NULL,1,'2021-03-15 15:24:16','2021-03-15 15:24:16','e2335aeb-76a3-4b6e-b319-41b93374a1c0'),(19,10,2,'tfa-001','shop/products/tfa-001',1,'2021-03-15 15:24:16','2021-03-15 15:24:20','e0f3240c-3359-4bfc-9dd8-268be0cbb622'),(20,11,2,'tfa-001',NULL,1,'2021-03-15 15:24:16','2021-03-15 15:24:16','9a01543b-dd90-4ca3-ae77-10ad166b1b4a'),(21,12,1,'lkh-001','shop/products/lkh-001',1,'2021-03-15 15:24:16','2021-03-15 15:24:20','2313ce7f-f021-4dc8-b703-e5f2659bee07'),(22,13,1,'lkh-001',NULL,1,'2021-03-15 15:24:16','2021-03-15 15:24:16','66168322-cd47-456d-b311-9d82e98e19c3'),(23,12,2,'lkh-001','shop/products/lkh-001',1,'2021-03-15 15:24:16','2021-03-15 15:24:20','7983a1e7-57c8-4a28-bce4-58415204e59d'),(24,13,2,'lkh-001',NULL,1,'2021-03-15 15:24:16','2021-03-15 15:24:16','1236004d-2c97-45f1-8d91-58913df68155'),(25,14,1,'fdb-001','shop/products/fdb-001',1,'2021-03-15 15:24:16','2021-03-15 15:24:20','c76617ea-9d23-43e7-8a4f-beee6c1c287a'),(26,15,1,'fdb-001',NULL,1,'2021-03-15 15:24:16','2021-03-15 15:24:16','93ca9c74-7665-42e6-ade5-4fbea4a22207'),(27,14,2,'fdb-001','shop/products/fdb-001',1,'2021-03-15 15:24:16','2021-03-15 15:24:20','bf3dedc6-8751-41c9-b950-908d0ff3dd78'),(28,15,2,'fdb-001',NULL,1,'2021-03-15 15:24:16','2021-03-15 15:24:16','7bc767c8-49af-4dd6-8810-6f964d1d0a97'),(31,17,1,'my-first-blog','blog/my-first-blog',1,'2021-03-15 15:41:19','2021-03-15 15:41:19','63a271a3-7312-4bec-b3e8-e7b86621e999'),(32,17,2,'my-first-blog','blog/my-first-blog',1,'2021-03-15 15:41:19','2021-03-15 15:41:19','5102c9da-9a13-4193-81e7-947fb09b7881'),(33,18,1,'my-first-blog','blog/my-first-blog',1,'2021-03-15 15:41:19','2021-03-15 15:41:19','4ee22583-ddef-491d-951e-9e8b12a7f98b'),(34,18,2,'my-first-blog','blog/my-first-blog',1,'2021-03-15 15:41:19','2021-03-15 15:41:19','85cd3c31-091d-4dab-addc-310ce17e129c'),(35,19,1,NULL,NULL,1,'2021-03-15 15:55:30','2021-03-15 15:55:30','cb7c4fe6-7ae8-4d1b-813c-932c555613a0'),(36,19,2,NULL,NULL,1,'2021-03-15 15:55:30','2021-03-15 15:55:30','0cbf45ed-ffae-4d47-93c6-8b5dfd332f57'),(37,20,1,'my-first-blog','blog/my-first-blog',1,'2021-03-15 16:17:37','2021-03-15 16:17:37','c73e9643-9ff4-4a8e-9955-e409b588e21b'),(38,20,2,'my-first-blog','blog/my-first-blog',1,'2021-03-15 16:17:37','2021-03-15 16:17:37','96bdf772-209b-4465-9ab0-4a132e5b1655'),(39,21,1,'puppies','category/puppies',1,'2021-04-01 02:35:35','2021-04-01 02:35:46','51530c40-112f-484f-addd-8abf4dfa39d6'),(40,21,2,'puppies','category/puppies',1,'2021-04-01 02:35:35','2021-04-01 02:35:46','5c01578e-7c8c-41de-8a01-58f5b38e7195'),(41,22,1,'kitties','category/kitties',1,'2021-04-01 02:35:44','2021-04-01 02:35:48','2373a4d8-4ee0-4e70-9cc3-6d3b6dd054c3'),(42,22,2,'kitties','category/kitties',1,'2021-04-01 02:35:44','2021-04-01 02:35:48','41ed619d-71c4-48fe-b548-b3d3d8373620');
/*!40000 ALTER TABLE `elements_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entries`
--

LOCK TABLES `entries` WRITE;
/*!40000 ALTER TABLE `entries` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `entries` VALUES (2,5,NULL,2,NULL,'2020-03-27 13:38:00',NULL,NULL,'2020-03-27 13:38:49','2020-03-27 13:38:49','478eec4c-16e8-46f1-8ad5-4d4d00f7ece1'),(17,6,NULL,3,1,'2021-03-15 15:40:00',NULL,NULL,'2021-03-15 15:41:19','2021-03-15 15:41:19','dbc93ca5-a2b1-4abc-bf44-6458f314f186'),(18,6,NULL,3,1,'2021-03-15 15:40:00',NULL,NULL,'2021-03-15 15:41:19','2021-03-15 15:41:19','08ea7070-095b-49a5-b170-edf35eb3b9b0'),(20,6,NULL,3,1,'2021-03-15 15:40:00',NULL,NULL,'2021-03-15 16:17:37','2021-03-15 16:17:37','1e2703e8-7642-434d-a9b6-3dd6baad0ed7');
/*!40000 ALTER TABLE `entries` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entrytypes`
--

LOCK TABLES `entrytypes` WRITE;
/*!40000 ALTER TABLE `entrytypes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `entrytypes` VALUES (1,4,NULL,'Errors','errors',1,'',NULL,NULL,1,'2020-03-27 13:38:49','2020-10-16 15:16:16','2021-03-15 15:09:11','faceb3ed-6771-453c-9c2a-aa330847f6db'),(2,5,1,'Homepage','homepage',0,'none',NULL,'{section.name|raw}',1,'2020-03-27 13:38:49','2021-03-15 15:40:41',NULL,'fb3a8f31-d1cc-4c13-903b-a501f7e51f54'),(3,6,5,'Blog','blog',1,'site',NULL,NULL,1,'2021-03-15 15:39:25','2021-03-15 15:39:25',NULL,'c4536798-743d-4bf0-9669-192827bfb26c'),(4,6,8,'Review','review',1,'site',NULL,NULL,2,'2021-04-01 02:34:33','2021-04-01 02:34:33','2022-01-31 03:40:28','f631db8b-3a6f-47c4-9001-54fa8733f2c9'),(5,6,11,'Review','review',1,'site',NULL,NULL,2,'2022-01-31 03:40:28','2022-01-31 03:40:28',NULL,'626b0987-e067-4dd2-9918-1d209373265a');
/*!40000 ALTER TABLE `entrytypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldgroups`
--

LOCK TABLES `fieldgroups` WRITE;
/*!40000 ALTER TABLE `fieldgroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldgroups` VALUES (1,'Common','2020-03-27 13:22:43','2020-03-27 13:22:43',NULL,'94b4d5ac-d7ea-4241-a6cb-92b39f482f99'),(2,'Errors','2020-03-27 13:30:08','2020-03-27 13:30:08','2021-03-15 15:13:19','d08a0d16-0e00-49e6-9cd4-465fa2d65d7d');
/*!40000 ALTER TABLE `fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayoutfields`
--

LOCK TABLES `fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `fieldlayoutfields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldlayoutfields` VALUES (5,1,5,7,0,1,'2021-03-15 15:40:41','2021-03-15 15:40:41','5ad24cfd-cd33-43e5-bc34-3a55e7065fb7'),(6,1,5,6,0,2,'2021-03-15 15:40:41','2021-03-15 15:40:41','b51f0845-d0f4-4e30-829a-b331b243a0db'),(7,1,5,5,0,3,'2021-03-15 15:40:41','2021-03-15 15:40:41','ba3eee15-07ad-4f97-88f3-921529ad9345'),(11,8,8,7,0,1,'2021-04-01 02:34:33','2021-04-01 02:34:33','e885c6ca-529d-4f94-b132-20d4fe01364b'),(12,8,8,6,0,2,'2021-04-01 02:34:33','2021-04-01 02:34:33','cb13a5ac-ed09-4955-8ca1-874160c145ce'),(13,8,8,5,0,3,'2021-04-01 02:34:33','2021-04-01 02:34:33','cdb8edd0-c830-4cc1-b9b3-5107c092584f'),(14,5,10,7,0,1,'2022-01-31 03:40:28','2022-01-31 03:40:28','1ea523dd-283f-449a-a3ac-e63db4785544'),(15,5,10,6,0,2,'2022-01-31 03:40:28','2022-01-31 03:40:28','19ae9a7b-9adc-47bc-aaa5-13f8447e95b6'),(17,5,10,5,0,4,'2022-01-31 03:40:28','2022-01-31 03:40:28','bd243e99-2dea-499d-9c6a-d0cb72b62dd2'),(21,7,13,4,0,1,'2022-01-31 03:40:28','2022-01-31 03:40:28','6fc78e9e-17f5-4426-a32f-718079b11ab1'),(22,7,13,9,0,2,'2022-01-31 03:40:28','2022-01-31 03:40:28','cc55a474-4a6e-4561-8b9d-7dc78a3c229c'),(23,11,15,7,0,1,'2022-01-31 03:40:29','2022-01-31 03:40:29','af5e848d-c483-460e-97b1-b34e16f68832'),(24,11,15,6,0,2,'2022-01-31 03:40:29','2022-01-31 03:40:29','3092cf91-ebbe-4b70-abc8-d9cda65aeaf7'),(25,11,15,5,0,3,'2022-01-31 03:40:29','2022-01-31 03:40:29','16f81b05-303b-4096-b7bf-bc4d4ba860e0'),(26,6,16,7,0,0,'2022-01-31 03:40:29','2022-01-31 03:40:29','dc41030c-d435-44ef-b4dc-fef71b9117c0'),(27,6,16,6,0,1,'2022-01-31 03:40:29','2022-01-31 03:40:29','ce23591d-c106-4b35-b224-8360303a6976');
/*!40000 ALTER TABLE `fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayouts`
--

LOCK TABLES `fieldlayouts` WRITE;
/*!40000 ALTER TABLE `fieldlayouts` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldlayouts` VALUES (1,'craft\\elements\\Entry','2021-03-03 22:29:11','2021-03-03 22:29:11',NULL,'3079b909-ff31-4f40-98a0-10c57767ab1f'),(2,'craft\\commerce\\elements\\Order','2021-03-15 15:24:15','2021-03-15 15:24:15',NULL,'030fdf45-9155-498b-8850-e2358400347b'),(3,'craft\\commerce\\elements\\Product','2021-03-15 15:24:16','2021-03-15 15:24:16',NULL,'08766548-0b7c-493b-bdce-20f096719426'),(4,'craft\\commerce\\elements\\Variant','2021-03-15 15:24:16','2021-03-15 15:24:16',NULL,'80c2837d-4f73-465a-bc55-085b035da781'),(5,'craft\\elements\\Entry','2021-03-15 15:39:25','2021-03-15 15:39:25',NULL,'44918e94-126a-4108-98da-1f66e19d2b2d'),(6,'craft\\elements\\GlobalSet','2021-03-15 15:55:30','2021-03-15 15:55:30',NULL,'e1ad1c2a-97c8-4b64-9d59-41e897a98298'),(7,'craft\\elements\\Asset','2021-03-15 16:13:40','2021-03-15 16:13:40',NULL,'e73b4186-2fad-4c0f-8eae-bbb884932c58'),(8,'craft\\elements\\Entry','2021-04-01 02:34:33','2021-04-01 02:34:33','2022-01-31 03:40:28','e66084b1-4fac-4681-b142-cd25eab4c076'),(9,'craft\\elements\\Category','2021-04-01 02:35:21','2021-04-01 02:35:21','2022-01-31 03:40:28','461e3853-0a60-4277-8682-5f5b7993c5e1'),(10,'craft\\elements\\Category','2022-01-31 03:40:28','2022-01-31 03:40:28',NULL,'4e420bac-c389-4bea-9708-e3e7c19f3cc1'),(11,'craft\\elements\\Entry','2022-01-31 03:40:28','2022-01-31 03:40:28',NULL,'446fae8b-775a-4b1b-a6dc-ef009aede404');
/*!40000 ALTER TABLE `fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayouttabs`
--

LOCK TABLES `fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `fieldlayouttabs` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldlayouttabs` VALUES (2,3,'Content','[{\"type\":\"craft\\\\commerce\\\\fieldlayoutelements\\\\ProductTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100}]',1,'2021-03-15 15:24:16','2021-03-15 15:24:16','1cc0a6e3-5b8f-46fc-9f03-904e8ebe4d0e'),(5,1,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\EntryTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"21903cb2-5b82-49ea-9766-e120d0951ea3\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"abcda4a4-b1db-4677-b5d6-69588443704f\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"4a0cb371-14a6-415d-84db-fc0512410ec8\"}]',1,'2021-03-15 15:40:41','2021-03-15 15:40:41','602a1b6a-3cbc-46cf-9b2f-3139e7237e35'),(8,8,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\EntryTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"21903cb2-5b82-49ea-9766-e120d0951ea3\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"abcda4a4-b1db-4677-b5d6-69588443704f\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"4a0cb371-14a6-415d-84db-fc0512410ec8\"}]',1,'2021-04-01 02:34:33','2021-04-01 02:34:33','25a0770e-d1aa-4fbe-9d40-8253aebcfd83'),(9,9,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\TitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100}]',1,'2021-04-01 02:35:21','2021-04-01 02:35:21','13b26387-d6dc-4355-9bdd-963a2889fd1b'),(10,5,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\EntryTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"21903cb2-5b82-49ea-9766-e120d0951ea3\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"abcda4a4-b1db-4677-b5d6-69588443704f\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"0242b54b-89fc-4bc4-b2ba-308cca715ba7\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"4a0cb371-14a6-415d-84db-fc0512410ec8\"}]',1,'2022-01-31 03:40:28','2022-01-31 03:40:28','a9a02354-ebff-499e-b0eb-4a64081ebc21'),(13,7,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\AssetTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"3ac44e69-f6b1-48f7-a9a6-f4cf14261b16\"}]',1,'2022-01-31 03:40:28','2022-01-31 03:40:28','df409993-2677-4707-b253-ef4348c9ac87'),(14,10,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\TitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100}]',1,'2022-01-31 03:40:29','2022-01-31 03:40:29','0351b547-f097-4f7e-8510-37eddda82e95'),(15,11,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\EntryTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"21903cb2-5b82-49ea-9766-e120d0951ea3\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"abcda4a4-b1db-4677-b5d6-69588443704f\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"4a0cb371-14a6-415d-84db-fc0512410ec8\"}]',1,'2022-01-31 03:40:29','2022-01-31 03:40:29','65861b73-9a91-477e-8fda-3f79d63b3795'),(16,6,'Default','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"21903cb2-5b82-49ea-9766-e120d0951ea3\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"abcda4a4-b1db-4677-b5d6-69588443704f\"}]',1,'2022-01-31 03:40:29','2022-01-31 03:40:29','728a3ab8-d1fb-44be-9b08-d8631fa8791a');
/*!40000 ALTER TABLE `fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fields`
--

LOCK TABLES `fields` WRITE;
/*!40000 ALTER TABLE `fields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fields` VALUES (4,1,'Optimized Images','optimizedImages','global',NULL,'',0,'none',NULL,'nystudio107\\imageoptimize\\fields\\OptimizedImages','{\"displayDominantColorPalette\":\"1\",\"displayLazyLoadPlaceholderImages\":\"1\",\"displayOptimizedImageVariants\":\"1\",\"variants\":[{\"width\":\"1200\",\"useAspectRatio\":\"1\",\"aspectRatioX\":\"16\",\"aspectRatioY\":\"9\",\"retinaSizes\":[\"1\"],\"quality\":\"82\",\"format\":\"jpg\"},{\"width\":\"992\",\"useAspectRatio\":\"1\",\"aspectRatioX\":\"16\",\"aspectRatioY\":\"9\",\"retinaSizes\":[\"1\"],\"quality\":\"82\",\"format\":\"jpg\"},{\"width\":\"768\",\"useAspectRatio\":\"1\",\"aspectRatioX\":\"4\",\"aspectRatioY\":\"3\",\"retinaSizes\":[\"1\"],\"quality\":\"60\",\"format\":\"jpg\"},{\"width\":\"576\",\"useAspectRatio\":\"1\",\"aspectRatioX\":\"4\",\"aspectRatioY\":\"3\",\"retinaSizes\":[\"1\"],\"quality\":\"60\",\"format\":\"jpg\"}]}','2021-03-02 00:00:09','2021-03-02 00:00:09','3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5'),(5,1,'SEO','seo','global',NULL,'',0,'none',NULL,'nystudio107\\seomatic\\fields\\SeoSettings','{\"elementDisplayPreviewType\":\"google\",\"facebookTabEnabled\":\"\",\"generalEnabledFields\":[\"seoPreview\",\"mainEntityOfPage\",\"seoTitle\",\"siteNamePosition\",\"seoDescription\",\"seoKeywords\",\"seoImage\",\"seoImageTransform\",\"seoImageTransformMode\",\"seoImageDescription\",\"robots\",\"canonicalUrl\"],\"generalTabEnabled\":\"1\",\"sitemapEnabledFields\":[\"sitemapUrls\",\"sitemapAssets\",\"sitemapFiles\",\"sitemapAltLinks\",\"sitemapChangeFreq\",\"sitemapPriority\",\"sitemapLimit\"],\"sitemapTabEnabled\":\"\",\"twitterTabEnabled\":\"\"}','2021-03-03 22:28:54','2022-01-31 03:40:28','4a0cb371-14a6-415d-84db-fc0512410ec8'),(6,1,'Rich Text','richText','global',NULL,'',0,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"cleanupHtml\":true,\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"redactorConfig\":\"Simple.json\",\"removeEmptyTags\":\"1\",\"removeInlineStyles\":\"1\",\"removeNbsp\":\"1\",\"showHtmlButtonForNonAdmins\":\"\",\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"enlarged\"}','2021-03-15 15:39:54','2021-03-15 15:39:54','abcda4a4-b1db-4677-b5d6-69588443704f'),(7,1,'Plain Text','plainText','global',NULL,'',0,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":null,\"uiMode\":\"normal\"}','2021-03-15 15:40:05','2021-03-15 15:40:05','21903cb2-5b82-49ea-9766-e120d0951ea3'),(9,1,'Some Images','someImages','global','hjezvijy','',0,'none',NULL,'nystudio107\\imageoptimize\\fields\\OptimizedImages','{\"displayDominantColorPalette\":\"1\",\"displayLazyLoadPlaceholderImages\":\"1\",\"displayOptimizedImageVariants\":\"1\",\"variants\":[{\"width\":\"1200\",\"useAspectRatio\":\"1\",\"aspectRatioX\":\"16\",\"aspectRatioY\":\"9\",\"retinaSizes\":[\"1\"],\"quality\":\"82\",\"format\":\"jpg\"},{\"width\":\"992\",\"useAspectRatio\":\"1\",\"aspectRatioX\":\"16\",\"aspectRatioY\":\"9\",\"retinaSizes\":[\"1\"],\"quality\":\"82\",\"format\":\"jpg\"},{\"width\":\"768\",\"useAspectRatio\":\"1\",\"aspectRatioX\":\"4\",\"aspectRatioY\":\"3\",\"retinaSizes\":[\"1\"],\"quality\":\"60\",\"format\":\"jpg\"},{\"width\":\"576\",\"useAspectRatio\":\"1\",\"aspectRatioX\":\"4\",\"aspectRatioY\":\"3\",\"retinaSizes\":[\"1\"],\"quality\":\"60\",\"format\":\"jpg\"}]}','2022-01-31 03:40:28','2022-01-31 03:40:28','3ac44e69-f6b1-48f7-a9a6-f4cf14261b16');
/*!40000 ALTER TABLE `fields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `globalsets`
--

LOCK TABLES `globalsets` WRITE;
/*!40000 ALTER TABLE `globalsets` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `globalsets` VALUES (19,'Globals','globals',6,2,'2021-03-15 15:55:30','2022-01-31 03:40:29','aa7c6968-88ec-4d2a-af47-d3c40b582a68');
/*!40000 ALTER TABLE `globalsets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `gqlschemas`
--

LOCK TABLES `gqlschemas` WRITE;
/*!40000 ALTER TABLE `gqlschemas` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `gqlschemas` VALUES (1,'Public Schema','[]',1,'2021-02-28 19:56:45','2021-02-28 19:56:45','6005c2f9-5d85-4442-b712-22e070096ac8');
/*!40000 ALTER TABLE `gqlschemas` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `gqltokens`
--

LOCK TABLES `gqltokens` WRITE;
/*!40000 ALTER TABLE `gqltokens` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `gqltokens` VALUES (1,'Public Token','__PUBLIC__',0,NULL,NULL,1,'2020-10-16 15:16:16','2021-02-28 19:56:45','1b9fd892-85aa-46c0-9bed-c7c82bf46416');
/*!40000 ALTER TABLE `gqltokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `info`
--

LOCK TABLES `info` WRITE;
/*!40000 ALTER TABLE `info` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `info` VALUES (1,'3.7.37','3.7.33',0,'eahjoqlgzafx','2@ojtirpvakp','2020-03-27 13:22:43','2022-03-17 16:30:31','85f4c669-6b2b-4771-976e-a4bcdd2bd77b');
/*!40000 ALTER TABLE `info` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixblocks`
--

LOCK TABLES `matrixblocks` WRITE;
/*!40000 ALTER TABLE `matrixblocks` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `matrixblocks` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixblocktypes`
--

LOCK TABLES `matrixblocktypes` WRITE;
/*!40000 ALTER TABLE `matrixblocktypes` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `matrixblocktypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `migrations` VALUES (1,'craft','Install','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','255a7bd9-4a6a-445c-bac0-ec5c80eff1ca'),(2,'craft','m150403_183908_migrations_table_changes','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','81cb0aab-bfa1-482f-a797-8ebd6913b240'),(3,'craft','m150403_184247_plugins_table_changes','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','5aea1857-8cf1-419c-9c08-fc68d91fe5f4'),(4,'craft','m150403_184533_field_version','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','0f589dd7-da06-4d0f-bf2a-93eaaddcd2ad'),(5,'craft','m150403_184729_type_columns','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','8b25192b-bb45-40ed-bd4a-32f4ddac5aa9'),(6,'craft','m150403_185142_volumes','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','66017e13-b70d-49ac-a668-097db57528f9'),(7,'craft','m150428_231346_userpreferences','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','39fd1888-30b1-42a5-93ce-f7d34cfb1310'),(8,'craft','m150519_150900_fieldversion_conversion','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','86bcf854-22b0-4a70-96bc-2044611c597b'),(9,'craft','m150617_213829_update_email_settings','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','a0c8e602-0468-49fe-8c16-fdffa82b4643'),(10,'craft','m150721_124739_templatecachequeries','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','6f320738-c1e5-46a2-bc27-91c7c1926dd2'),(11,'craft','m150724_140822_adjust_quality_settings','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','1af6d726-306c-4bf5-8cfd-eb434ab616d1'),(12,'craft','m150815_133521_last_login_attempt_ip','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','2d4ec2a2-98c1-4c8a-ab2b-020217a6cf70'),(13,'craft','m151002_095935_volume_cache_settings','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','eff78c75-bac8-4447-9a3c-3ce5702ffa10'),(14,'craft','m151005_142750_volume_s3_storage_settings','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','b701ae4c-63b1-48cc-8267-59085e643f81'),(15,'craft','m151016_133600_delete_asset_thumbnails','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','af500463-3e1a-46c3-b7c9-6bd5d7a4db71'),(16,'craft','m151209_000000_move_logo','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','e9fdda5e-9b99-4d7b-b09d-5cfa95b48c7b'),(17,'craft','m151211_000000_rename_fileId_to_assetId','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','75df1e70-a409-4c90-b7d8-ee19ed7b401c'),(18,'craft','m151215_000000_rename_asset_permissions','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','14e72674-0ccb-42b0-98de-9b70dbe6dd2c'),(19,'craft','m160707_000001_rename_richtext_assetsource_setting','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','7123c498-b5b5-41fb-9fa3-f7bb31c4d248'),(20,'craft','m160708_185142_volume_hasUrls_setting','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','148932ce-bafe-414d-8020-4bd04635da04'),(21,'craft','m160714_000000_increase_max_asset_filesize','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','0e377531-0a70-462f-bab2-f3ab80986ccf'),(22,'craft','m160727_194637_column_cleanup','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','cb7e9397-4728-43b5-b974-ccbd9e08797f'),(23,'craft','m160804_110002_userphotos_to_assets','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','72a8bc4b-2064-45fe-b857-349cd7241a5b'),(24,'craft','m160807_144858_sites','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','30b17f8b-3acd-4b10-8394-1ad35cee1139'),(25,'craft','m160829_000000_pending_user_content_cleanup','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','5ef2a4c5-1e2f-4337-b249-c667627886df'),(26,'craft','m160830_000000_asset_index_uri_increase','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','b009b29a-1e7f-48e9-9d8f-2a50466b16b8'),(27,'craft','m160912_230520_require_entry_type_id','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','057f602e-2110-4b74-a9b6-794e1972f92f'),(28,'craft','m160913_134730_require_matrix_block_type_id','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','c67eaec1-a102-40c3-a7d5-f4a3400fbf7e'),(29,'craft','m160920_174553_matrixblocks_owner_site_id_nullable','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','be379f74-f2cd-4400-8884-4dc0b2bd2114'),(30,'craft','m160920_231045_usergroup_handle_title_unique','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','8373c373-51d7-4c3c-b3da-65af03c1cab3'),(31,'craft','m160925_113941_route_uri_parts','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','cff3b8d3-60ae-490c-89ad-2b8317a8ce11'),(32,'craft','m161006_205918_schemaVersion_not_null','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','d4e67e40-90c6-490b-98bb-ed4586b1d764'),(33,'craft','m161007_130653_update_email_settings','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','b789a9b3-8114-4d63-9bd8-9c2112323dba'),(34,'craft','m161013_175052_newParentId','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','15b96b1d-f810-4f22-a3cd-0ac21cd3bf65'),(35,'craft','m161021_102916_fix_recent_entries_widgets','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','603a7ae6-a3a3-4836-a363-dea7c9d4ea8e'),(36,'craft','m161021_182140_rename_get_help_widget','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','6f5a896c-06e1-454d-8eb8-1b716d3eb64f'),(37,'craft','m161025_000000_fix_char_columns','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','232f4ee5-f823-4421-9fab-9460a1bf2a7c'),(38,'craft','m161029_124145_email_message_languages','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','d9721ac1-3111-4005-9ddf-d75ba11c4b83'),(39,'craft','m161108_000000_new_version_format','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','faf44e8e-d227-4152-9778-2294550479a5'),(40,'craft','m161109_000000_index_shuffle','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','0e4dcb9b-2b4c-4403-991b-58a44f5e0c0e'),(41,'craft','m161122_185500_no_craft_app','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','4330d3bc-67bb-44e2-bc71-7689150cdc14'),(42,'craft','m161125_150752_clear_urlmanager_cache','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','273b17f6-fd34-47a9-b66e-0e15c6c8b5e3'),(43,'craft','m161220_000000_volumes_hasurl_notnull','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','e5304c92-fc2a-479e-8aab-0e5bc9851d47'),(44,'craft','m170114_161144_udates_permission','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','ee9efd39-5f71-4fee-bd70-b7b2da3641c4'),(45,'craft','m170120_000000_schema_cleanup','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','5047cbb6-5a6f-4868-8e05-655046bad66c'),(46,'craft','m170126_000000_assets_focal_point','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','1ebab523-177b-43bc-a707-e2a172ab5ccc'),(47,'craft','m170206_142126_system_name','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','56bae875-93b7-446a-8cb5-3fe91fd0fc92'),(48,'craft','m170217_044740_category_branch_limits','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','fa730cd1-4608-476f-a041-1a192406e634'),(49,'craft','m170217_120224_asset_indexing_columns','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','c706d06a-9fa7-4502-afe6-90b23a651a72'),(50,'craft','m170223_224012_plain_text_settings','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','459a346a-43c6-4f0f-aaa0-c863cb13a73b'),(51,'craft','m170227_120814_focal_point_percentage','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','e24f0c44-46bc-4bc5-a6bc-5044981382b5'),(52,'craft','m170228_171113_system_messages','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','071c531e-e2bb-48ec-9efd-fcab056d6a26'),(53,'craft','m170303_140500_asset_field_source_settings','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','7b6dcde0-b522-44a6-916e-438f05d9d586'),(54,'craft','m170306_150500_asset_temporary_uploads','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','ffc146b0-577b-4e6e-9c53-73c19007bc58'),(55,'craft','m170523_190652_element_field_layout_ids','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','101e4d6c-ac3b-40c8-8f0f-7b0411fc5191'),(56,'craft','m170612_000000_route_index_shuffle','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','51522a51-bd55-47e3-97de-daadb68f43f7'),(57,'craft','m170621_195237_format_plugin_handles','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','a32776a8-5419-42e4-a2e8-f7a0a52d8307'),(58,'craft','m170630_161027_deprecation_line_nullable','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','428a77ea-a40f-4c28-8d85-9af37bd53d23'),(59,'craft','m170630_161028_deprecation_changes','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','0257f4e3-0265-4f2f-9a1b-3088ae972348'),(60,'craft','m170703_181539_plugins_table_tweaks','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','954fa697-9999-4583-b39b-b5ff9d62d4f6'),(61,'craft','m170704_134916_sites_tables','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','2f968f14-db59-4421-978a-87fa06690e07'),(62,'craft','m170706_183216_rename_sequences','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','5e6c9484-b078-4c80-b28a-e90bc53db103'),(63,'craft','m170707_094758_delete_compiled_traits','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','2c0bbe6e-73bf-4dd1-94a7-c29b8764f89b'),(64,'craft','m170731_190138_drop_asset_packagist','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','241e0eff-622d-4a45-b5da-8ae74c7ee587'),(65,'craft','m170810_201318_create_queue_table','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','5697abc2-9558-4bcf-b141-f7370b59bd31'),(66,'craft','m170903_192801_longblob_for_queue_jobs','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','dab06800-69cd-4c56-a7f4-f7b692512cd1'),(67,'craft','m170914_204621_asset_cache_shuffle','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','15267267-1409-4375-86e5-629713cd31fb'),(68,'craft','m171011_214115_site_groups','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','4752ee77-3835-469c-a871-f814b09e30e8'),(69,'craft','m171012_151440_primary_site','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','8f593dbc-14e0-48d3-99a9-05d381f8d2ec'),(70,'craft','m171013_142500_transform_interlace','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','4da5a8e2-3a1b-46b6-b23c-89234119bc88'),(71,'craft','m171016_092553_drop_position_select','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','3c2970ed-345f-4d3b-ac7e-cffdfa2942f0'),(72,'craft','m171016_221244_less_strict_translation_method','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','afa9a878-dbee-4064-9777-0bd8ddbd0720'),(73,'craft','m171107_000000_assign_group_permissions','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','0ff13617-ceac-405e-8458-0baeb2f269cd'),(74,'craft','m171117_000001_templatecache_index_tune','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','77d0e773-5c44-4048-b5f4-934772d85fbe'),(75,'craft','m171126_105927_disabled_plugins','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','8690b346-0b5c-4a8e-9ff2-8804a5d136c5'),(76,'craft','m171130_214407_craftidtokens_table','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','5f38b70d-2fec-4fbd-9bf9-cfb37c621fba'),(77,'craft','m171202_004225_update_email_settings','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','07fe7680-763c-4f8b-bbb2-ace8bfe411eb'),(78,'craft','m171204_000001_templatecache_index_tune_deux','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','a6c74f57-4c1c-44fb-8421-d7bd70312d32'),(79,'craft','m171205_130908_remove_craftidtokens_refreshtoken_column','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','d6026314-995a-4815-9b18-ce2aa676655f'),(80,'craft','m171218_143135_longtext_query_column','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','8f747f8e-c5b3-4fea-b886-83e18d38df8f'),(81,'craft','m171231_055546_environment_variables_to_aliases','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','074ae9a8-f9ea-429c-845a-ebabaa1e0264'),(82,'craft','m180113_153740_drop_users_archived_column','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','94d3dcb0-87d6-473d-b0f2-47f3e4a52314'),(83,'craft','m180122_213433_propagate_entries_setting','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','54968ca4-e5a5-4d24-8c74-fe558c83c29f'),(84,'craft','m180124_230459_fix_propagate_entries_values','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','eb0b9ea6-3870-4f0c-95a6-be9dcf9cdcb2'),(85,'craft','m180128_235202_set_tag_slugs','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','3f0a065b-7ca2-4a1c-8305-418e15bc0053'),(86,'craft','m180202_185551_fix_focal_points','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','152a8537-f013-4cf8-811c-6e5841c3efff'),(87,'craft','m180217_172123_tiny_ints','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','c3e99dd8-f2be-470e-a5ba-ecef98230ef4'),(88,'craft','m180321_233505_small_ints','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','64a53868-a156-4b99-994a-6201dae965c1'),(89,'craft','m180328_115523_new_license_key_statuses','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','6f94253a-9490-4514-810f-e612432eba56'),(90,'craft','m180404_182320_edition_changes','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','095c2e7e-e262-4d27-9f4e-a6889211e77e'),(91,'craft','m180411_102218_fix_db_routes','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','731742bc-8e59-405e-b1e6-c111d243e2a2'),(92,'craft','m180416_205628_resourcepaths_table','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','6e06ec91-db04-44db-a85d-1f370aeb2df5'),(93,'craft','m180418_205713_widget_cleanup','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','31f47605-5041-4181-a9a3-7881d11d31c1'),(94,'craft','m180425_203349_searchable_fields','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','dc4704d5-dcc9-422c-8a87-132be84fce1a'),(95,'craft','m180516_153000_uids_in_field_settings','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','3b4774d6-4654-4463-b2f1-97f726b62362'),(96,'craft','m180517_173000_user_photo_volume_to_uid','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','48aaf568-9b71-4dbb-b398-23ea179761ab'),(97,'craft','m180518_173000_permissions_to_uid','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','8c132a81-a3d6-495b-8266-cb3304906c7e'),(98,'craft','m180520_173000_matrix_context_to_uids','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','7cb3202e-0875-489a-a5b3-2d8a69450b2c'),(99,'craft','m180521_172900_project_config_table','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','8ddfe078-e983-44b3-8b73-6b8c3e7f8ba8'),(100,'craft','m180521_173000_initial_yml_and_snapshot','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','e44637ee-d8f3-420a-84bc-59e94f33096a'),(101,'craft','m180731_162030_soft_delete_sites','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','64b3c4ed-b2f0-4e9a-a79a-af12fc83dd7d'),(102,'craft','m180810_214427_soft_delete_field_layouts','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','76cbbfc5-0745-4ed2-8fd4-9bd227c0c0b4'),(103,'craft','m180810_214439_soft_delete_elements','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','a03e5d4d-5c49-42c4-a71a-69db678a8224'),(104,'craft','m180824_193422_case_sensitivity_fixes','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','c675d233-cde2-4c93-b3ca-9b37bb434053'),(105,'craft','m180901_151639_fix_matrixcontent_tables','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','3ef9239e-4fdb-4613-8e7c-15a3f4125de8'),(106,'craft','m180904_112109_permission_changes','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','5f3c9a1a-11d2-478c-b049-ad6334598763'),(107,'craft','m180910_142030_soft_delete_sitegroups','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','066fac48-7b3e-47f9-b85f-6b717b7925f4'),(108,'craft','m181011_160000_soft_delete_asset_support','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','a4c72873-ccef-484e-8e2d-930ad5215921'),(109,'craft','m181016_183648_set_default_user_settings','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','028d4e4c-c46f-45cf-9d78-7a1753c2b098'),(110,'craft','m181017_225222_system_config_settings','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','230b6760-a134-400b-8428-fbd7ae846bce'),(111,'craft','m181018_222343_drop_userpermissions_from_config','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','e7c9b7ec-aa66-49bd-a7eb-3915aeabb975'),(112,'craft','m181029_130000_add_transforms_routes_to_config','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','599bc463-b22f-487c-8a42-aca50d00e71e'),(113,'craft','m181112_203955_sequences_table','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','882f7e42-1fd5-4400-bf17-f4c1cdc33033'),(114,'craft','m181121_001712_cleanup_field_configs','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','78c5b189-03f7-4708-a650-b38f69d029e7'),(115,'craft','m181128_193942_fix_project_config','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','9dc406f3-6c6f-4059-b44d-59d16b0eb2b1'),(116,'craft','m181130_143040_fix_schema_version','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','55663d4f-27ff-411e-956c-e14655ecac0b'),(117,'craft','m181211_143040_fix_entry_type_uids','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','b1d4d9a4-6316-413a-945e-2feac788829b'),(118,'craft','m181213_102500_config_map_aliases','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','89bf7bbb-44a6-443c-8206-af3ff2989eba'),(119,'craft','m181217_153000_fix_structure_uids','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','846a472a-95f5-4f1f-a4f7-ca5184f269aa'),(120,'craft','m190104_152725_store_licensed_plugin_editions','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','5c209aff-00dd-42d9-8a42-b6564d100cc0'),(121,'craft','m190108_110000_cleanup_project_config','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','d327fadd-76d7-4503-be11-81da8a912af6'),(122,'craft','m190108_113000_asset_field_setting_change','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','695f277a-ab68-4a83-82f2-e936295adb3d'),(123,'craft','m190109_172845_fix_colspan','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','43910cd4-5e83-4b6d-855a-8f7b88b6247f'),(124,'craft','m190110_150000_prune_nonexisting_sites','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','4cd71f29-f98a-4899-a2b4-238a61c4db65'),(125,'craft','m190110_214819_soft_delete_volumes','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','8335956a-2c49-4a40-8b0e-e68b208e1c30'),(126,'craft','m190112_124737_fix_user_settings','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','4698b045-e5ee-4a56-bff7-c1fff754a9f1'),(127,'craft','m190112_131225_fix_field_layouts','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','902d60e1-8e2c-4f4a-9055-8f83c85f6e6d'),(128,'craft','m190112_201010_more_soft_deletes','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','7f9961ac-e762-4ef5-9a7a-fa1817d26bf4'),(129,'craft','m190114_143000_more_asset_field_setting_changes','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','e8cf4c8b-8f82-472d-b39d-f896cfc6d226'),(130,'craft','m190121_120000_rich_text_config_setting','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','0dec2485-9aab-4d9d-8d46-6756b44eeb93'),(131,'craft','m190125_191628_fix_email_transport_password','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','1cc76fe6-e762-4c91-beec-702c1b984b44'),(132,'craft','m190128_181422_cleanup_volume_folders','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','692967b5-27b0-432e-a903-069ba83f074c'),(133,'craft','m190205_140000_fix_asset_soft_delete_index','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','8ab58617-1897-42ae-94ae-0db48629922b'),(134,'craft','m190208_140000_reset_project_config_mapping','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','d9b0e8dd-3d94-416f-89f5-45df90281cf2'),(135,'craft','m190218_143000_element_index_settings_uid','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','76cc86f7-0364-4afe-90a6-6316792c9bdd'),(136,'craft','m190312_152740_element_revisions','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','bb233c1e-c672-4022-834d-955b2f2b2c5b'),(137,'craft','m190327_235137_propagation_method','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','be267a4a-fe8d-49a7-8d8f-db65a9a40281'),(138,'craft','m190401_223843_drop_old_indexes','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','8a3991de-610a-4423-bab3-0d7af54a2bd9'),(139,'craft','m190416_014525_drop_unique_global_indexes','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','17772379-ba34-4e84-b8e1-0515ad2af06e'),(140,'craft','m190417_085010_add_image_editor_permissions','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','3701bce4-d093-4d7a-adf6-fbb44d3c3696'),(141,'craft','m190502_122019_store_default_user_group_uid','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','241e3fa0-c65d-44ba-93c5-7017f358b17d'),(142,'craft','m190504_150349_preview_targets','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','0bc04b28-b115-4ee9-b48d-13e4f61f6553'),(143,'craft','m190516_184711_job_progress_label','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','fd29213c-6dca-4b79-9a1a-6153444036ef'),(144,'craft','m190523_190303_optional_revision_creators','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','6ffbf76b-3eda-4c76-a528-e8e4b5a03d16'),(145,'craft','m190529_204501_fix_duplicate_uids','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','af69fe27-56cc-4d3d-9acf-9a0b395274d0'),(146,'craft','m190605_223807_unsaved_drafts','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','674c3d9e-8a8d-4789-9cf2-304de25ce61d'),(147,'craft','m190607_230042_entry_revision_error_tables','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','c2e80144-eafe-4417-8e5d-68ab36613f48'),(148,'craft','m190608_033429_drop_elements_uid_idx','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','b46a28ab-4748-49d0-baf4-2259b7aaeda8'),(149,'craft','m190617_164400_add_gqlschemas_table','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','e4256312-0939-4eaa-af6e-46e7e333887b'),(150,'craft','m190624_234204_matrix_propagation_method','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','e2fdceea-2402-4dfc-b8ad-91a5bb6081ea'),(151,'craft','m190711_153020_drop_snapshots','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','eabbd986-c254-43b4-9293-617dec6ced0f'),(152,'craft','m190712_195914_no_draft_revisions','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','b9fa515f-0b21-4e90-8b24-55ce3b20fbdf'),(153,'craft','m190723_140314_fix_preview_targets_column','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','617fa9ec-59ff-48a6-9f37-0d058a8cf10f'),(154,'craft','m190820_003519_flush_compiled_templates','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','d6355a46-1036-4f2c-849c-31c1c744d5cf'),(155,'craft','m190823_020339_optional_draft_creators','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','8f291ec6-25df-48b1-b0fd-832c222067cc'),(156,'craft','m190913_152146_update_preview_targets','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','708fc9d8-e029-4b1b-9a8e-47e74fb3da23'),(157,'craft','m191107_122000_add_gql_project_config_support','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','378c63e4-b06d-4aaf-8432-2264aeb67810'),(158,'craft','m191204_085100_pack_savable_component_settings','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','6a175408-6d11-408d-b252-0604dd85b192'),(159,'craft','m191206_001148_change_tracking','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','a0e210b7-bd80-4b35-8559-9cdc1da25b54'),(160,'craft','m191216_191635_asset_upload_tracking','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','89b3dda9-0fa6-4741-8987-3aa30bfde7ee'),(161,'craft','m191222_002848_peer_asset_permissions','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','03c80884-65ce-47b0-98cc-a7a7049a8d82'),(162,'craft','m200127_172522_queue_channels','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','3fba8b65-7b25-4114-b773-430aaffc50b5'),(163,'craft','m200211_175048_truncate_element_query_cache','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','79e5d574-6170-42b0-920f-e63fae0baa9d'),(164,'craft','m200213_172522_new_elements_index','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','b8f132e5-cf07-4758-b90b-f0b691227577'),(165,'craft','m200228_195211_long_deprecation_messages','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','63b1b93f-c645-4d76-9eee-9f5cda47dbd1'),(166,'plugin:retour','Install','2020-03-27 13:29:52','2020-03-27 13:29:52','2020-03-27 13:29:52','0e0c610b-8c55-4e2d-8c60-5ccc28eac2d4'),(167,'plugin:retour','m181013_122446_add_remote_ip','2020-03-27 13:29:52','2020-03-27 13:29:52','2020-03-27 13:29:52','a1e1f1dd-0473-45a7-87ba-d7814e945eec'),(168,'plugin:retour','m181013_171315_truncate_match_type','2020-03-27 13:29:52','2020-03-27 13:29:52','2020-03-27 13:29:52','c1ec196c-0415-4a04-b526-3bf4e7617433'),(169,'plugin:retour','m181013_202455_add_redirect_src_match','2020-03-27 13:29:52','2020-03-27 13:29:52','2020-03-27 13:29:52','3e04542f-7efa-4c18-badf-fedb51ec9e66'),(170,'plugin:retour','m181018_123901_add_stats_info','2020-03-27 13:29:52','2020-03-27 13:29:52','2020-03-27 13:29:52','715c7006-7fbf-4d03-b3ed-e40317ec46e6'),(171,'plugin:retour','m181018_135656_add_redirect_status','2020-03-27 13:29:52','2020-03-27 13:29:52','2020-03-27 13:29:52','a76b22b4-73e5-4bc3-9f56-d53b83b24596'),(172,'plugin:retour','m181213_233502_add_site_id','2020-03-27 13:29:52','2020-03-27 13:29:52','2020-03-27 13:29:52','3156cf35-5002-454c-8c32-c3db5ea5bc0e'),(173,'plugin:retour','m181216_043222_rebuild_indexes','2020-03-27 13:29:52','2020-03-27 13:29:52','2020-03-27 13:29:52','1a713770-252d-4574-b143-e1f83be14dba'),(174,'plugin:retour','m190416_212500_widget_type_update','2020-03-27 13:29:52','2020-03-27 13:29:52','2020-03-27 13:29:52','e18c6d37-3358-42bd-acad-cd6083ee28e8'),(175,'plugin:retour','m200109_144310_add_redirectSrcUrl_index','2020-03-27 13:29:52','2020-03-27 13:29:52','2020-03-27 13:29:52','b2f8161f-b603-49b3-8508-083f6e30ad35'),(176,'plugin:seomatic','Install','2020-03-27 13:29:52','2020-03-27 13:29:52','2020-03-27 13:29:52','a5c88b79-d692-4f09-8186-8f11687f95ac'),(177,'plugin:seomatic','m180314_002755_field_type','2020-03-27 13:29:52','2020-03-27 13:29:52','2020-03-27 13:29:52','e8fd3d69-80fe-4b77-bd6e-881bd95395ef'),(178,'plugin:seomatic','m180314_002756_base_install','2020-03-27 13:29:52','2020-03-27 13:29:52','2020-03-27 13:29:52','13faed23-cc8a-430f-b785-9a9919007553'),(179,'plugin:seomatic','m180502_202319_remove_field_metabundles','2020-03-27 13:29:52','2020-03-27 13:29:52','2020-03-27 13:29:52','6a20cccd-6655-453b-899d-e9681d2a1c5c'),(180,'plugin:seomatic','m180711_024947_commerce_products','2020-03-27 13:29:52','2020-03-27 13:29:52','2020-03-27 13:29:52','2cf8cde9-e8f4-4997-9014-4a154a3f5361'),(181,'plugin:seomatic','m190401_220828_longer_handles','2020-03-27 13:29:52','2020-03-27 13:29:52','2020-03-27 13:29:52','a52c8755-967a-41cf-abb1-7a63c06754f6'),(182,'plugin:seomatic','m190518_030221_calendar_events','2020-03-27 13:29:52','2020-03-27 13:29:52','2020-03-27 13:29:52','ab6d63b2-fe21-4fb3-bbe2-4ebd3a6ffef9'),(185,'craft','m200306_054652_disabled_sites','2020-10-16 15:16:14','2020-10-16 15:16:14','2020-10-16 15:16:14','abc2f9d4-4653-4583-82f4-7e483a13f888'),(186,'craft','m200522_191453_clear_template_caches','2020-10-16 15:16:14','2020-10-16 15:16:14','2020-10-16 15:16:14','b3cf261a-7c72-494f-b0d3-f90f37dd8697'),(187,'craft','m200606_231117_migration_tracks','2020-10-16 15:16:14','2020-10-16 15:16:14','2020-10-16 15:16:14','bc34bce4-9616-413c-8c68-5e9b60eb7210'),(188,'craft','m200619_215137_title_translation_method','2020-10-16 15:16:14','2020-10-16 15:16:14','2020-10-16 15:16:14','d7391893-a7b0-481b-bac7-bb8124f56aa2'),(189,'craft','m200620_005028_user_group_descriptions','2020-10-16 15:16:14','2020-10-16 15:16:14','2020-10-16 15:16:14','abd003bc-e99d-4929-8d42-fdb5adfa8c90'),(190,'craft','m200620_230205_field_layout_changes','2020-10-16 15:16:14','2020-10-16 15:16:14','2020-10-16 15:16:14','43b71a32-5238-4c70-90a2-6531b2042268'),(191,'craft','m200625_131100_move_entrytypes_to_top_project_config','2020-10-16 15:16:14','2020-10-16 15:16:14','2020-10-16 15:16:14','2b86d78a-0825-4c90-acf7-629463148de8'),(192,'craft','m200629_112700_remove_project_config_legacy_files','2020-10-16 15:16:14','2020-10-16 15:16:14','2020-10-16 15:16:14','35da89d2-87af-4f31-98d4-d028e5f44f03'),(193,'craft','m200630_183000_drop_configmap','2020-10-16 15:16:14','2020-10-16 15:16:14','2020-10-16 15:16:14','6e888e11-fff0-4cf6-83ed-ac62cce76ef0'),(194,'craft','m200715_113400_transform_index_error_flag','2020-10-16 15:16:14','2020-10-16 15:16:14','2020-10-16 15:16:14','b7bae372-1ba0-4109-ade5-b1f9af4a63a6'),(195,'craft','m200716_110900_replace_file_asset_permissions','2020-10-16 15:16:14','2020-10-16 15:16:14','2020-10-16 15:16:14','3a1671c1-3334-478b-92d3-35dce55d87ae'),(196,'craft','m200716_153800_public_token_settings_in_project_config','2020-10-16 15:16:14','2020-10-16 15:16:14','2020-10-16 15:16:14','9fcbf070-3ff5-40a0-910b-ed0c0e5ad88d'),(197,'craft','m200720_175543_drop_unique_constraints','2020-10-16 15:16:15','2020-10-16 15:16:15','2020-10-16 15:16:15','deaeab5a-092d-4e0f-95fb-18ef08d6489e'),(198,'craft','m200825_051217_project_config_version','2020-10-16 15:16:15','2020-10-16 15:16:15','2020-10-16 15:16:15','6e096de1-fcd8-4f96-92b3-37db41a29a25'),(199,'plugin:seomatic','m200419_203444_add_type_id','2020-10-16 15:16:15','2020-10-16 15:16:15','2020-10-16 15:16:15','25f0ab31-c74b-40da-b18b-e82f19c3855c'),(202,'plugin:webperf','Install','2020-11-18 21:24:48','2020-11-18 21:24:48','2020-11-18 21:24:48','798d71aa-fb25-4b75-9293-964b80035f2a'),(203,'plugin:webperf','m190625_151715_add_indexes','2020-11-18 21:24:48','2020-11-18 21:24:48','2020-11-18 21:24:48','49b8b2be-5c9e-4821-9851-60c597186b3e'),(204,'craft','m201116_190500_asset_title_translation_method','2021-02-28 04:53:01','2021-02-28 04:53:01','2021-02-28 04:53:01','94da610f-2014-4abf-adcb-175d1b85f4bb'),(205,'craft','m201124_003555_plugin_trials','2021-02-28 04:53:01','2021-02-28 04:53:01','2021-02-28 04:53:01','2f1fd1a7-9419-4809-b2d7-ea1c23107884'),(206,'craft','m210209_135503_soft_delete_field_groups','2021-02-28 04:53:01','2021-02-28 04:53:01','2021-02-28 04:53:01','a4136522-77e7-4bec-96d9-08066118c154'),(207,'craft','m210212_223539_delete_invalid_drafts','2021-02-28 04:53:01','2021-02-28 04:53:01','2021-02-28 04:53:01','e4608336-f165-4108-89c7-67d5d70cf2d2'),(208,'craft','m210214_202731_track_saved_drafts','2021-02-28 04:53:01','2021-02-28 04:53:01','2021-02-28 04:53:01','9b5948e1-7f7f-458f-8276-fefeee254ff2'),(209,'plugin:redactor','m180430_204710_remove_old_plugins','2021-03-03 03:34:37','2021-03-03 03:34:37','2021-03-03 03:34:37','b0472ab6-c3d8-4f76-b74e-e8f5dad83e08'),(210,'plugin:redactor','Install','2021-03-03 03:34:37','2021-03-03 03:34:37','2021-03-03 03:34:37','51e288ad-c556-4464-afc9-3c8e0e435f05'),(211,'plugin:redactor','m190225_003922_split_cleanup_html_settings','2021-03-03 03:34:37','2021-03-03 03:34:37','2021-03-03 03:34:37','e4a9d217-2a04-4f07-9d3a-6e7956b7cdd2'),(212,'craft','m210223_150900_add_new_element_gql_schema_components','2021-03-15 15:23:29','2021-03-15 15:23:29','2021-03-15 15:23:29','aef28876-0de8-4eca-bd90-392d818d7740'),(213,'craft','m210224_162000_add_projectconfignames_table','2021-03-15 15:23:29','2021-03-15 15:23:29','2021-03-15 15:23:29','0eb6eb5a-2c3d-4321-901a-7fd2629fcc56'),(214,'plugin:commerce','Install','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','f26be053-2fd4-42f1-99b2-b140b9825be9'),(215,'plugin:commerce','m160531_154500_craft3_upgrade','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','87692049-d66e-4ca6-9268-84896969a473'),(216,'plugin:commerce','m170616_154500_productTypeSites_upgrade','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','33202f25-8ecd-422a-8546-efef9a5ca2a0'),(217,'plugin:commerce','m170705_154500_i18n_to_sites','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','fda264ab-9f5e-406a-93fe-1ebbe742a265'),(218,'plugin:commerce','m170705_155000_order_shippingmethod_to_shippingmethodhandle','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','48512d60-624e-4348-bda5-acc24e4d12ef'),(219,'plugin:commerce','m170718_150000_paymentmethod_class_to_type','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','fce9cd50-bf20-40a2-905a-f766a4378e53'),(220,'plugin:commerce','m170725_130000_paymentmethods_are_now_gateways','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','269b27ae-b5bd-47d1-ba36-253b1561cfe6'),(221,'plugin:commerce','m170810_130000_sendCartInfo_per_gateway','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','b1ddb294-a438-4036-93db-08d86007fb83'),(222,'plugin:commerce','m170828_130000_transaction_gatewayProcessing_flag','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','b986c5c9-c60d-45fa-be24-9fd8f3d5aa38'),(223,'plugin:commerce','m170830_130000_order_refactor','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','94ebefe6-eba7-4616-9273-6cfd2d08de95'),(224,'plugin:commerce','m170831_130000_paymentCurreny_primary_not_null','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','187822c8-2e95-4889-83ed-f9bc5834a6b4'),(225,'plugin:commerce','m170904_130000_processing_transactions','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','f2a76bd6-a17e-42cb-95b8-cdac6cc37548'),(226,'plugin:commerce','m171010_170000_stock_location','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','381e7782-b1d8-4b24-baf7-8cb8b547b5bf'),(227,'plugin:commerce','m171202_180000_promotions_for_all_purchasables','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','47912c19-f6a3-42d2-8365-de9225ad6dfc'),(228,'plugin:commerce','m171204_213000_payment_sources','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','065fc0fd-6e79-408a-8b5d-7594090c6cee'),(229,'plugin:commerce','m171207_160000_order_can_store_payment_sources','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','62b788df-78a1-4d96-bc28-bcc98ee5bce1'),(230,'plugin:commerce','m171221_120000_subscriptions','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','0538afbf-c4d5-4e36-9a1d-8a82f8c9ef9a'),(231,'plugin:commerce','m171221_120500_missing_indexes','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','0a951f26-0cf7-4a7a-b885-d35eb056ae15'),(232,'plugin:commerce','m180205_150646_create_state_abbreviation_index','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','f14e42ec-bfa7-4071-a66a-af5e9a4de07b'),(233,'plugin:commerce','m180209_115000_plan_description','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','a55e44d8-78e2-4e1f-be54-bac7f8e6965b'),(234,'plugin:commerce','m180216_130000_rename_store_location','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','23a2f3d9-f752-4b80-abc1-bb4038c73013'),(235,'plugin:commerce','m180217_130000_sale_migration','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','5d350d40-ab77-4230-bd63-77ec745702bf'),(236,'plugin:commerce','m180218_130000_sale_order','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','afbcaa97-6cfc-4d86-81d4-ac7cb9cef704'),(237,'plugin:commerce','m180219_130000_sale_can_stop_processing','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','6a432cf2-59a4-4b48-a89c-a09f7315f759'),(238,'plugin:commerce','m180220_130000_sale_can_ignore_previous','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','3b94e29e-df65-486e-b0d9-f9dbab1bd591'),(239,'plugin:commerce','m180221_130000_sale_fixSort','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','2f63a5f0-3b98-4eb5-bc5b-7809c77a722f'),(240,'plugin:commerce','m180222_130000_lineitemsubtotal','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','2210298f-b28f-4351-b59a-ccc10ee3ef9f'),(241,'plugin:commerce','m180306_130000_renamed','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','9f88a129-5c45-4ac5-87db-382264c20f3a'),(242,'plugin:commerce','m180307_130000_order_paid_status','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','0f81731d-0b11-428c-b623-d8564f179f62'),(243,'plugin:commerce','m180308_130000_update_order_paid_status','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','0b828e9d-0fc7-485c-a208-a38c83f163c3'),(244,'plugin:commerce','m180308_130001_has_and_is','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','de0f127c-e76d-4c35-b563-64d2c816b98a'),(245,'plugin:commerce','m180312_130001_countryBased','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','380f3663-e5e4-4195-b17d-2611aab4891a'),(246,'plugin:commerce','m180319_130001_fieldSettings','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','ff73d648-4e41-4bd5-ae5d-1f83685d3a00'),(247,'plugin:commerce','m180326_130001_cascadeDeleteVariants','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','9365eaa9-7641-4800-a15d-386ca4eb2788'),(248,'plugin:commerce','m180329_161901_gateway_send_cart_info','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','89bd512c-a5d5-4da9-a547-452fc58bc862'),(249,'plugin:commerce','m180401_150701_primary_addresses','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','c7ed8d24-bfdd-4283-a5d1-bc84f45d789a'),(250,'plugin:commerce','m180401_161901_first_last_name_optional','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','f1b1c791-e524-4798-92ec-13ed45904c50'),(251,'plugin:commerce','m180402_161901_increase_size_of_snapshot','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','c447bc1b-57e4-4d74-8b52-ac3a723e09d5'),(252,'plugin:commerce','m180402_161902_email_discount_usage','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','bb4cca07-ae34-44cb-87e4-054345d44461'),(253,'plugin:commerce','m180402_161903_primary_customer_addresses_relations','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','d391b76c-a6a1-4167-9517-ea4611b9c017'),(254,'plugin:commerce','m180402_161904_order_addresses_relations','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','c5274ba4-4294-4834-b7f4-f5aa4494955e'),(255,'plugin:commerce','m180417_161904_fix_purchasables','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','407cd2ab-1074-4998-b277-071e1edf47a2'),(256,'plugin:commerce','m180421_161904_transaction_note','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','d9a0faab-506f-4e81-870f-e61b5cc81c95'),(257,'plugin:commerce','m180525_161904_available_for_purchase','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','26928449-a809-4306-b253-a40219332414'),(258,'plugin:commerce','m180601_161904_fix_orderLanguage','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','5a04fabd-1241-407f-923a-7509e8517852'),(259,'plugin:commerce','m180620_161904_fix_primaryAddressCascade','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','979c6011-14b0-468e-bfcd-0c1b1050394c'),(260,'plugin:commerce','m180718_161906_add_orderPdfAttachment','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','4f93d976-0387-4536-af90-a21b2e64501a'),(261,'plugin:commerce','m180818_161906_fix_discountPurchasableType','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','a340450b-dc9d-404c-a095-5095c9f4a581'),(262,'plugin:commerce','m180818_161907_fix_orderPaidWithAddresses','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','58da852d-8516-4b18-bde1-1b313ec122ba'),(263,'plugin:commerce','m180918_161907_fix_uniqueEmailDiscountsUses','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','706e2765-14f2-404a-a86c-666b30f812ea'),(264,'plugin:commerce','m180918_161908_fix_messageLengthOnOrder','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','92c0e30f-98d4-4fc3-aaba-4000a5221070'),(265,'plugin:commerce','m181024_100600_gateway_project_config_support','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','d1741fdf-d7d0-4196-bd86-c41241770b0e'),(266,'plugin:commerce','m181113_161908_addReferenceToOrder','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','094ce2cc-26a7-4b92-9fbd-ab3c6e7a5c43'),(267,'plugin:commerce','m181119_100600_lite_shipping_and_tax','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','7ceec82e-bd27-4ab2-a2d5-09c879869802'),(268,'plugin:commerce','m181203_130000_order_status_archivable','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','48d4eb5d-3b7c-41ce-aa26-38bc41383868'),(269,'plugin:commerce','m181203_162000_gateway_unique_index_drop','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','5648383b-d285-4788-b13b-a7eb6b01c923'),(270,'plugin:commerce','m181206_120000_remaining_project_config_support','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','12727cd3-9281-4ec4-91ff-5a5833a5beab'),(271,'plugin:commerce','m181221_120000_sort_order_for_plans','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','b96bacbe-2d76-4a80-9087-8dcfbff52f6f'),(272,'plugin:commerce','m190109_223402_set_edition','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','6fcf5c06-10b5-4fb0-9159-194d233f3c6f'),(273,'plugin:commerce','m190111_161909_lineItemTotalCanBeNegative','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','f5c17949-326b-4a05-9131-62715f49bbac'),(274,'plugin:commerce','m190117_161909_replace_product_ref_tags','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','5c619bf5-0020-4529-93e7-6d78123c363d'),(275,'plugin:commerce','m190126_000856_restore_variants_with_products','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','05b37412-6c17-4a0a-aba9-eaa9b5d09360'),(276,'plugin:commerce','m190129_000857_insert_cached_data','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','44f797b3-ac4c-4294-a82d-54a2088a7657'),(277,'plugin:commerce','m190131_000858_add_donation_purchasable','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','0e55840a-9f26-4f03-b380-5815f2cea2a2'),(278,'plugin:commerce','m190213_000858_discount_free_shipping_changes','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','9afcd71e-f00b-4a15-8054-1c861dbbd855'),(279,'plugin:commerce','m190222_161405_permissions_to_uid','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','65f272d9-6323-4997-91ca-5d58102b0832'),(280,'plugin:commerce','m190301_161406_unique_sku_constraint_in_app','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','58553162-ff8b-4104-bffa-1e7257147c73'),(281,'plugin:commerce','m190311_161910_order_total','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','79293f46-dd19-4136-915f-69f1fb513a22'),(282,'plugin:commerce','m190322_161911_register_on_checkout','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','dc097964-0bd0-4e54-9a65-a72576bb1cd9'),(283,'plugin:commerce','m190523_150000_fix_lineItems_dateCreated','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','ec46e8bf-519d-49d4-baf4-63490773988f'),(284,'plugin:commerce','m190523_161912_line_item_statuses','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','1669602f-cb79-47f5-8b03-f905df2894e9'),(285,'plugin:commerce','m190527_161913_order_recalc_mode','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','082aae35-43d6-430d-afee-6a6a3b158cb7'),(286,'plugin:commerce','m190527_161914_admin_note_on_lineitem','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','100b83e4-4ad6-413a-bc79-9280b682ad16'),(287,'plugin:commerce','m190528_161915_description_on_purchasable','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','ba24795c-143f-4208-b794-0ef28343a0f7'),(288,'plugin:commerce','m190622_161916_origin_on_order','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','9bbe0b08-8e8b-4e66-ad01-6d1ea31793cb'),(289,'plugin:commerce','m190725_141100_subscription_suspension_fields','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','1ae88730-3996-43b7-87f0-e07d2f1c2319'),(290,'plugin:commerce','m190821_150226_discount_purchaseTotal_update','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','c5538566-4d80-412e-9ba7-b551de93b217'),(291,'plugin:commerce','m190823_071838_taxCategoryId_allow_null','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','1fcb4563-a2e6-49ac-a5e9-46ef1dc3bda0'),(292,'plugin:commerce','m190923_131716_update_overpaid_status','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','69f5240b-7c55-4b26-b220-e376f6092611'),(293,'plugin:commerce','m190923_132226_update_paidStatuses','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','0bbbd93d-077a-4f5d-bfc2-fba4b8b59714'),(294,'plugin:commerce','m190924_184909_taxCategory_allow_null_postgres','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','61a3e366-88dd-4df2-b46e-939fc63435bd'),(295,'plugin:commerce','m191004_184910_orderPaidDate','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','9c764a06-da15-4fd1-9e95-da0f12fccd33'),(296,'plugin:commerce','m191007_184911_orderStatus_from_archived_to_deleted','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','c3b0ffa2-681c-4faf-9273-85318a8fe337'),(297,'plugin:commerce','m191008_153947_add_relationship_type_to_discounts','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','c2366278-a69c-4291-9a5f-cc1718e67ae4'),(298,'plugin:commerce','m191008_155732_add_relationship_type_to_sales','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','ed2d96a6-c093-4c72-a609-4f4908371493'),(299,'plugin:commerce','m191009_002748_add_ignoreSales_to_discounts','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','c1a6d170-0f7b-4f95-a9c5-081f35ef19da'),(300,'plugin:commerce','m191009_184912_zipCode_match_added_to_shipping_and_tax_address_zones','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','73a51a91-f577-4717-82e8-9ce58481c3d6'),(301,'plugin:commerce','m191015_194704_add_description_to_orderStatus','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','224fe532-30bd-444e-b265-cdac0e59b835'),(302,'plugin:commerce','m191015_201444_add_code_to_taxRates','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','9b54cfd8-1b11-41b6-8061-cbb9161e629e'),(303,'plugin:commerce','m191016_231143_add_sortOrder_to_countries','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','503e427b-7f21-40ff-99c6-1511442a3d6f'),(304,'plugin:commerce','m191017_183550_add_extra_address_fields','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','25521e42-a5c6-46fe-b669-0fc30b4cd321'),(305,'plugin:commerce','m191018_183551_cc_replyTo_emails','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','b40e268c-f864-42e1-a586-a2ff9979fb16'),(306,'plugin:commerce','m191021_184436_add_estimated_fields_to_order','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','aa3058e1-7e31-46f7-9edc-11662020682c'),(307,'plugin:commerce','m191021_190018_add_estimated_flag_to_addresses','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','82034769-2f10-4a50-a7d3-25c919bc1f2f'),(308,'plugin:commerce','m191022_162628_add_estimated_toadjustments','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','669a30a2-0131-44dd-86f5-dbd25a4bd515'),(309,'plugin:commerce','m191113_111954_add_plain_text_template_path','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','b4c5320b-108e-4298-8255-68a1ed05eae1'),(310,'plugin:commerce','m191114_115600_remove_customer_info_field','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','0cf36149-20b0-4555-b880-0632d4c5329d'),(311,'plugin:commerce','m191114_133817_add_base_discount_type_attribute','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','0bc557fc-2401-4615-91fe-59add2712a52'),(312,'plugin:commerce','m191115_103105_add_totalDiscountUses_column','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','98918e0f-6038-47f1-a2f6-87e355e71c43'),(313,'plugin:commerce','m191115_103501_update_totalDiscountUses_with_current_uses','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','71c4501d-b397-4c1e-ab74-906d4cabf6d1'),(314,'plugin:commerce','m191115_105329_add_totalDiscountUseLimit','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','06d9076e-c218-408a-9568-af714ebfe19b'),(315,'plugin:commerce','m191125_150308_add_enabled_countries','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','524b891f-63b2-4c02-9c57-3b3992ca4bdb'),(316,'plugin:commerce','m191125_150315_add_enabled_states','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','9df41cd3-75fd-4f43-9b85-c81c5f78420c'),(317,'plugin:commerce','m191202_220748_updated_zipCodeConditional_column_type','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','e73e22a7-915a-401e-9386-958287e349c9'),(318,'plugin:commerce','m191203_163242_add_titleLabel_to_product_type','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','d662bfc0-b76f-47f7-bfc8-5ef27e8c6dd0'),(319,'plugin:commerce','m200101_114320_remove_orphan_customers','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','74622095-cef0-44b2-bc3a-84f430bdabb2'),(320,'plugin:commerce','m200102_141910_add_variantTitleLabel_attribute','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','cdc79e8d-252e-4866-942c-deb1853d3b24'),(321,'plugin:commerce','m200102_185704_update_totalDiscountUseLimit_with_current_totalUseLimit','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','08b0d690-201f-4d0f-9be9-ccc62688d25f'),(322,'plugin:commerce','m200102_185839_remove_totalUses_and_totalUseLimit','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','1f955dfa-1689-4779-ba41-de53a49c7323'),(323,'plugin:commerce','m200108_114623_consolidate_customer_records','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','468f81cc-ba31-49ed-b523-d0b6e89a476a'),(324,'plugin:commerce','m200112_220749_cache_totalDiscount_totalTax_totalShipping','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','eb47fe4a-ea46-4085-ab70-fe5307a076a0'),(325,'plugin:commerce','m200127_235254_replace_old_revenue_widget','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','906a32ab-11e3-4148-ab3a-7d1a53859cd0'),(326,'plugin:commerce','m200129_161705_create_missing_customer_records_for_users','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','d05f41e9-6fb8-4fd6-acef-8c58f33e45e7'),(327,'plugin:commerce','m200206_161706_date_authorized','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','47813381-95b3-4936-8503-879c3ad1dc70'),(328,'plugin:commerce','m200207_161707_sku_description_on_lineitem','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','7f964fdd-05bd-4481-921b-c47823ccb4ff'),(329,'plugin:commerce','m200218_231144_add_sortOrder_to_states','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','309008b6-562d-41eb-a592-92933ae05056'),(330,'plugin:commerce','m200218_231199_add_appliesTo_to_discounts','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','205d65e7-1ac2-4526-a6f8-d37962a076a7'),(331,'plugin:commerce','m200320_161708_add_index_order_email','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','d17e6eeb-1b67-41b0-85d7-b6fc3900797e'),(332,'plugin:commerce','m200402_172412_add_order_condition_formula','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','ca2918cd-014c-470d-bddb-46bdcd938aba'),(333,'plugin:commerce','m200602_172413_fix_orders_without_customerId','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','3b59df4f-c1bd-459c-b81d-eb8d0f76dac2'),(334,'plugin:commerce','m200617_172414_fix_country_state_sort_orders','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','18727517-eeda-40bb-bc1a-7f3556bd9db5'),(335,'plugin:commerce','m200722_172699_product_title_format','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','58e36c45-bf8f-44a8-a85e-0f74d9f56430'),(336,'plugin:commerce','m200723_072632_add_shippingMethodName_to_order','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','40ca8ba3-d92a-4fea-b133-11321f0bd7c6'),(337,'plugin:commerce','m200730_233644_field_layout_changes','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','a285344b-f983-4a5c-8b5b-e50b55804aac'),(338,'plugin:commerce','m200801_233755_pdfs','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','9bd05a92-7f43-4f9f-9870-aff9bd44a258'),(339,'plugin:commerce','m200804_185727_fix_productTitleFormat','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','29561ea2-9db0-4ac0-ac5c-79a0f4118fe0'),(340,'plugin:commerce','m200901_094328_add_lineItem_description_column_type','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','3682554f-cf15-466d-be97-7ffc9ad223d2'),(341,'plugin:commerce','m200902_071515_add_itemSubtotal_order_column','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','ff851a5c-fed8-4a5f-948d-32466d42a625'),(342,'plugin:commerce','m200907_132553_fix_donation_siteIds','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','dcf13b67-4911-4537-bbd3-68309e76fe63'),(343,'plugin:commerce','m200910_134928_fix_productType_title_format_columns','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','9c03b2c6-9478-4d57-80b6-05213e4e040b'),(344,'plugin:commerce','m201005_169999_add_orderSiteId','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','eb72f3f3-b7d8-4117-872f-ca5f5b9cf4ab'),(345,'plugin:commerce','m201013_064230_add_subscription_id_fk','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','beee0471-e4b9-40fe-a797-d408e919c084'),(346,'plugin:commerce','m201102_064231_fix_deletedWithProduct_bool','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','89ea0ea6-981c-482e-87bb-1193a73e0772'),(347,'plugin:commerce','m201120_093135_add_locale_setting_to_email_and_pdf','2021-03-15 15:24:16','2021-03-15 15:24:16','2021-03-15 15:24:16','79bb5914-9d51-4463-bba4-200191d399d2'),(348,'craft','m210326_132000_invalidate_projectconfig_cache','2021-04-01 00:06:58','2021-04-01 00:06:58','2021-04-01 00:06:58','27d82ddb-2a06-4353-ab3c-21f1e89ee847'),(349,'plugin:commerce','m210302_050822_change_adjust_type_to_lowercase','2021-04-01 00:06:58','2021-04-01 00:06:58','2021-04-01 00:06:58','c398363e-f42a-4782-9a43-d8b2b7931045'),(350,'plugin:commerce','m210317_050824_taxIncluded_update','2021-04-01 00:06:58','2021-04-01 00:06:58','2021-04-01 00:06:58','260cbb22-f711-4920-9e31-8c379ccf946d'),(351,'plugin:commerce','m210317_093136_includedTax_fix','2021-04-01 00:06:58','2021-04-01 00:06:58','2021-04-01 00:06:58','2250df4f-8928-4e68-802b-5f33c15a195c'),(352,'craft','m210302_212318_canonical_elements','2022-01-31 03:39:34','2022-01-31 03:39:34','2022-01-31 03:39:34','840369ab-1d11-4d8c-8c05-08df54df46cb'),(353,'craft','m210329_214847_field_column_suffixes','2022-01-31 03:39:34','2022-01-31 03:39:34','2022-01-31 03:39:34','039d6288-68d4-4290-8b60-95c5cc2e1d17'),(354,'craft','m210331_220322_null_author','2022-01-31 03:39:34','2022-01-31 03:39:34','2022-01-31 03:39:34','b8898fdd-44ec-4d9e-9a83-8eeecf2d8fd6'),(355,'craft','m210405_231315_provisional_drafts','2022-01-31 03:39:34','2022-01-31 03:39:34','2022-01-31 03:39:34','fc1e8415-1fb2-46d2-83d7-d4048720e5f9'),(356,'craft','m210602_111300_project_config_names_in_config','2022-01-31 03:39:34','2022-01-31 03:39:34','2022-01-31 03:39:34','dcd2ca74-1f87-4111-ab3c-80e2090a0a67'),(357,'craft','m210611_233510_default_placement_settings','2022-01-31 03:39:34','2022-01-31 03:39:34','2022-01-31 03:39:34','5e42a2c4-cab6-4147-a99c-77d896dcc200'),(358,'craft','m210613_145522_sortable_global_sets','2022-01-31 03:39:35','2022-01-31 03:39:35','2022-01-31 03:39:35','38439777-cc4f-4c21-84ff-07a0eced32c9'),(359,'craft','m210613_184103_announcements','2022-01-31 03:39:35','2022-01-31 03:39:35','2022-01-31 03:39:35','d4d95618-88ac-4049-ac61-dd18c82c390a'),(360,'craft','m210829_000000_element_index_tweak','2022-01-31 03:39:35','2022-01-31 03:39:35','2022-01-31 03:39:35','14cbfa2a-bb97-4484-8b89-b59e6ecd9caa'),(361,'plugin:commerce','m201111_064232_order_notices','2022-01-31 03:39:35','2022-01-31 03:39:35','2022-01-31 03:39:35','475880a8-6495-497c-9c3a-e5cf3936ce2c'),(362,'plugin:commerce','m201218_103541_add_user_condition_column_in_promotions','2022-01-31 03:39:35','2022-01-31 03:39:35','2022-01-31 03:39:35','76fdf40e-88de-4703-b0ae-001fd25f25f9'),(363,'plugin:commerce','m210113_093199_add_minMaxTotalType_to_shipping_rules','2022-01-31 03:39:35','2022-01-31 03:39:35','2022-01-31 03:39:35','1bbaed5d-1e2a-497e-a69f-d9a4662b8d6d'),(364,'plugin:commerce','m210114_093299_add_orderConditionFormula_to_shipping_rules','2022-01-31 03:39:35','2022-01-31 03:39:35','2022-01-31 03:39:35','8061e290-90d2-4ca6-80ec-a5a3d85c0c02'),(365,'plugin:commerce','m210317_093137_add_type_to_notices','2022-01-31 03:39:35','2022-01-31 03:39:35','2022-01-31 03:39:35','d4fb2376-506b-483e-ba3e-6db260cd14c2'),(366,'plugin:commerce','m210608_093199_add_remove_included_to_taxrates','2022-01-31 03:39:35','2022-01-31 03:39:35','2022-01-31 03:39:35','16d257c5-75d0-475e-b6be-ddceb8f9b313'),(367,'plugin:commerce','m210611_093299_add_remove_vat_included_to_taxrates','2022-01-31 03:39:35','2022-01-31 03:39:35','2022-01-31 03:39:35','74bdfcc3-9ced-42c6-a749-099d515fde6d'),(368,'plugin:commerce','m210616_152013_change_return_cancel_url_column_type','2022-01-31 03:39:35','2022-01-31 03:39:35','2022-01-31 03:39:35','05fde82a-af6a-4bda-8858-a658e700d52b'),(369,'plugin:commerce','m210703_060852_store_location_index','2022-01-31 03:39:36','2022-01-31 03:39:36','2022-01-31 03:39:36','f60ebdf3-87ab-4e17-9060-d3d79b4d82a6'),(370,'plugin:commerce','m210901_222634_drop_column','2022-01-31 03:39:36','2022-01-31 03:39:36','2022-01-31 03:39:36','97c74d0a-edc9-4a2b-806f-6214e61e4939'),(371,'plugin:retour','m210603_221000_add_gql_schema_components','2022-01-31 03:39:36','2022-01-31 03:39:36','2022-01-31 03:39:36','e8d7cab8-2c0f-4fd1-9852-88375a209930'),(372,'plugin:seomatic','m210603_213100_add_gql_schema_components','2022-01-31 03:39:36','2022-01-31 03:39:36','2022-01-31 03:39:36','f36316fa-3250-469f-90b4-068c39556b6e'),(373,'plugin:seomatic','m210817_230853_announcement_v3_4','2022-01-31 03:39:36','2022-01-31 03:39:36','2022-01-31 03:39:36','49cdffbb-24b5-412e-928d-0a074fdf8ae5'),(374,'craft','m220209_095604_add_indexes','2022-03-04 18:42:28','2022-03-04 18:42:28','2022-03-04 18:42:28','6886155d-82b8-4afa-997d-95d3e0cd511a'),(375,'craft','m220214_000000_truncate_sessions','2022-03-04 18:42:28','2022-03-04 18:42:28','2022-03-04 18:42:28','d0979f44-38d9-4a7f-bf49-eaaec63b2ee7'),(376,'plugin:calendar','Install','2022-03-17 16:27:47','2022-03-17 16:27:47','2022-03-17 16:27:47','d3480e15-f08e-4d91-b1a9-15e77339a090'),(377,'plugin:calendar','m180316_130028_Craft3Upgrade','2022-03-17 16:27:47','2022-03-17 16:27:47','2022-03-17 16:27:47','3d375e0b-1053-4aef-a187-35f8a6d0a9d8'),(378,'plugin:calendar','m180601_113607_MigrateCalendarEventFieldtype','2022-03-17 16:27:47','2022-03-17 16:27:47','2022-03-17 16:27:47','4361d561-ddc4-41fb-b6de-08cd710794f4'),(379,'plugin:calendar','m180619_120655_MigrateCalendarElementsAndLayouts','2022-03-17 16:27:47','2022-03-17 16:27:47','2022-03-17 16:27:47','4977339e-79bf-4438-a17e-a89e8cb7f162'),(380,'plugin:calendar','m180628_091905_MigrateSelectDates','2022-03-17 16:27:47','2022-03-17 16:27:47','2022-03-17 16:27:47','40039581-50e3-4770-9032-e98280fd6c71'),(381,'plugin:calendar','m180921_124711_AddIcsTimezoneToCalendar','2022-03-17 16:27:47','2022-03-17 16:27:47','2022-03-17 16:27:47','a2de2a5f-b5d0-4e75-aa63-2f31d5062093'),(382,'plugin:calendar','m190925_094628_AddAllowRepeatingEventsToCalendar','2022-03-17 16:27:47','2022-03-17 16:27:47','2022-03-17 16:27:47','c7279ad3-b7f0-4dd5-955b-c66c3880b916'),(383,'plugin:calendar','m191022_124711_AddMultiSitesFix','2022-03-17 16:27:47','2022-03-17 16:27:47','2022-03-17 16:27:47','920cbc15-ab96-48e8-9584-30dd6a8eb47b'),(384,'plugin:calendar','m200608_083342_AddPostDateToEvents','2022-03-17 16:27:47','2022-03-17 16:27:47','2022-03-17 16:27:47','2ce06d73-a4a6-4587-bf8d-fc3c27a86b3c'),(385,'plugin:calendar','m210506_063418_AddProjectConfigSupport','2022-03-17 16:27:47','2022-03-17 16:27:47','2022-03-17 16:27:47','d5355230-b9d0-455d-96dd-284d56fef86a'),(386,'plugin:calendar','m210929_131016_PermissionsMigrationForProjectConfig','2022-03-17 16:27:47','2022-03-17 16:27:47','2022-03-17 16:27:47','c7786104-bdec-4f76-89f6-48c951cffae3'),(387,'plugin:calendar','m211001_063936_AddPrimaryKeyForEventsTable','2022-03-17 16:27:47','2022-03-17 16:27:47','2022-03-17 16:27:47','b2abc864-0046-44b0-8c0c-a20304e162ad'),(388,'plugin:digital-products','Install','2022-03-17 16:28:00','2022-03-17 16:28:00','2022-03-17 16:28:00','a7c062b9-b10a-4cfb-ad18-c1970dad4984'),(389,'plugin:digital-products','m171129_154500_craft3_upgrade','2022-03-17 16:28:00','2022-03-17 16:28:00','2022-03-17 16:28:00','71768224-ccd4-4403-99bc-1c28aff7951f'),(390,'plugin:digital-products','m181025_111000_product_types_project_config_support','2022-03-17 16:28:00','2022-03-17 16:28:00','2022-03-17 16:28:00','9cd64f82-96b0-4476-94b8-459bad1244c0'),(391,'plugin:digital-products','m190425_152400_fix_product_edit_permissions','2022-03-17 16:28:00','2022-03-17 16:28:00','2022-03-17 16:28:00','e1e94331-d170-4869-9ea3-7cd67ea2b23a');
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `plugins`
--

LOCK TABLES `plugins` WRITE;
/*!40000 ALTER TABLE `plugins` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `plugins` VALUES (1,'minify','1.2.11','1.0.0','unknown',NULL,'2020-03-27 13:29:52','2020-03-27 13:29:52','2022-03-17 16:29:11','e3c115e9-20f8-4e22-844e-30e17ef57531'),(2,'fastcgi-cache-bust','1.0.10','1.0.0','unknown',NULL,'2020-03-27 13:29:52','2020-03-27 13:29:52','2022-03-17 16:29:11','181a837f-d581-4b8f-a41f-c42ac5024864'),(3,'image-optimize','1.6.43','1.0.0','trial',NULL,'2020-03-27 13:29:52','2020-03-27 13:29:52','2022-03-17 16:29:11','828d7b83-f12e-417e-83f6-92fbbb05c82f'),(4,'retour','3.1.70','3.0.10','trial',NULL,'2020-03-27 13:29:52','2020-03-27 13:29:52','2022-03-17 16:29:11','d72e01fb-71aa-4d22-a59b-e3d941f64908'),(5,'seomatic','3.4.28','3.0.11','trial',NULL,'2020-03-27 13:29:52','2020-03-27 13:29:52','2022-03-17 16:29:11','1f2b10de-d456-42a8-816e-278d5516bcdd'),(7,'typogrify','1.1.19','1.0.0','unknown',NULL,'2020-03-27 13:30:07','2020-03-27 13:30:07','2022-03-17 16:29:11','77df8ab1-431b-47c6-9652-3b7f85c6ce9f'),(9,'twigpack','1.2.15','1.0.0','unknown',NULL,'2020-10-16 15:31:32','2020-10-16 15:31:32','2022-03-17 16:29:11','08169dff-2660-4224-bd82-b9a0a82101f2'),(11,'templatecomments','1.1.2','1.0.0','unknown',NULL,'2020-11-18 21:24:48','2020-11-18 21:24:48','2022-03-17 16:29:11','a144af0d-92ee-4913-97be-0e42d90b5aaa'),(12,'webperf','1.0.27','1.0.1','trial',NULL,'2020-11-18 21:24:48','2020-11-18 21:24:48','2022-03-17 16:29:11','f7222098-e07d-4101-b8d3-ef05b8e67f4d'),(13,'instant-analytics','1.1.15','1.0.0','trial',NULL,'2021-03-03 01:18:23','2021-03-03 01:18:23','2022-03-17 16:29:11','df13a92a-4d28-48f7-a0a2-da7d343e79d8'),(15,'redactor','2.10.5','2.3.0','unknown',NULL,'2021-03-03 03:34:37','2021-03-03 03:34:37','2022-03-17 16:29:11','74c9084c-7baf-438b-8786-eb738e4d5670'),(16,'rich-variables','1.0.31','1.0.0','trial',NULL,'2021-03-03 03:35:04','2021-03-03 03:35:04','2022-03-17 16:29:11','d4213a31-b058-48df-bc28-fd6960afe7e9'),(17,'transcoder','1.2.21','1.0.0','trial',NULL,'2021-03-03 03:37:37','2021-03-03 03:37:37','2022-03-17 16:29:11','9960f34f-2a1d-416c-839a-063df166583e'),(18,'commerce','3.4.12','3.4.12','trial',NULL,'2021-03-15 15:24:09','2021-03-15 15:24:09','2022-03-17 16:29:11','11fc64db-82ac-455f-88bc-f8ee055b7d8a'),(19,'cookies','1.1.15','1.0.0','unknown',NULL,'2022-01-31 03:39:37','2022-01-31 03:39:37','2022-03-17 16:29:11','d16bded3-8fd3-44b8-9735-db7238307ed7'),(20,'disqus','1.1.3','1.0.0','unknown',NULL,'2022-01-31 03:40:26','2022-01-31 03:40:26','2022-03-17 16:29:11','5090a31f-c7c1-4f99-ab1e-844de8ebdb97'),(21,'vite','1.0.23','1.0.0','unknown',NULL,'2022-01-31 03:40:27','2022-01-31 03:40:27','2022-03-17 16:29:11','10435868-04fa-45e7-b09f-8594522774d3'),(22,'calendar','3.3.9','3.3.2','trial',NULL,'2022-03-17 16:27:46','2022-03-17 16:27:46','2022-03-17 16:29:11','554dd5ce-dec4-4917-ad1e-0aaabf44a3bc'),(23,'connect','1.0.0','1.0.0','unknown',NULL,'2022-03-17 16:27:55','2022-03-17 16:27:55','2022-03-17 16:29:11','4c36edce-7591-4136-abf2-46465c3d303d'),(24,'digital-products','2.4.3.2','2.1.0','unknown',NULL,'2022-03-17 16:28:00','2022-03-17 16:28:00','2022-03-17 16:29:11','c377a6f3-96e1-47ec-a2a2-c32364816db4'),(25,'eager-beaver','1.0.4','1.0.0','unknown',NULL,'2022-03-17 16:28:08','2022-03-17 16:28:08','2022-03-17 16:29:11','5e1ca99a-7fa3-4f4b-bf31-782b3e7809ef'),(26,'empty-coalesce','1.0.6','1.0.0','unknown',NULL,'2022-03-17 16:28:14','2022-03-17 16:28:14','2022-03-17 16:29:11','5c5fb082-360e-45fe-9ddc-1cda46f472b0'),(27,'path-tools','1.0.7','1.0.0','unknown',NULL,'2022-03-17 16:28:20','2022-03-17 16:28:20','2022-03-17 16:29:11','c256fef9-33b9-43ed-a6b7-7764bdfcc41b'),(28,'recipe','1.4.0','1.0.0','unknown',NULL,'2022-03-17 16:28:26','2022-03-17 16:28:26','2022-03-17 16:29:11','28b8a9f7-1e54-4c19-80b2-247ba485a021'),(29,'route-map','1.1.7','1.0.0','unknown',NULL,'2022-03-17 16:28:35','2022-03-17 16:28:35','2022-03-17 16:29:11','c17ea763-039f-42b9-9d01-c02ac7c77e7e'),(30,'similar','1.1.5','1.0.0','unknown',NULL,'2022-03-17 16:28:40','2022-03-17 16:28:40','2022-03-17 16:29:11','2f9a0c2c-7bdc-4ee9-8bd6-465fc0e60805'),(31,'twig-profiler','1.0.1','1.0.0','unknown',NULL,'2022-03-17 16:28:45','2022-03-17 16:28:45','2022-03-17 16:29:11','83552ae3-fe64-4b1e-b674-9937bb26a9da'),(32,'units','1.0.4','1.0.0','unknown',NULL,'2022-03-17 16:28:51','2022-03-17 16:28:51','2022-03-17 16:29:11','ba7bef65-8016-4e2a-a6cb-cb0b7fc6896a'),(33,'vanillaforums','3.0.1','1.0.0','unknown',NULL,'2022-03-17 16:28:57','2022-03-17 16:28:57','2022-03-17 16:29:11','dd641df9-c020-4a51-8543-5b09837280de'),(34,'youtubeliveembed','1.0.2','1.0.0','unknown',NULL,'2022-03-17 16:29:02','2022-03-17 16:29:02','2022-03-17 16:29:11','d5e36193-3c38-4b0c-9865-3fddbd76232c'),(35,'icalendar','1.1.2','1.0.0','unknown',NULL,'2022-03-17 16:29:08','2022-03-17 16:29:08','2022-03-17 16:29:11','4278f051-891e-435f-acae-87ec245a0ea0');
/*!40000 ALTER TABLE `plugins` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `projectconfig`
--

LOCK TABLES `projectconfig` WRITE;
/*!40000 ALTER TABLE `projectconfig` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `projectconfig` VALUES ('categoryGroups.b8fd3909-9af1-42c4-8c5e-2716a2a1957e.defaultPlacement','\"end\"'),('categoryGroups.b8fd3909-9af1-42c4-8c5e-2716a2a1957e.fieldLayouts.4e420bac-c389-4bea-9708-e3e7c19f3cc1.tabs.0.elements.0.autocapitalize','true'),('categoryGroups.b8fd3909-9af1-42c4-8c5e-2716a2a1957e.fieldLayouts.4e420bac-c389-4bea-9708-e3e7c19f3cc1.tabs.0.elements.0.autocomplete','false'),('categoryGroups.b8fd3909-9af1-42c4-8c5e-2716a2a1957e.fieldLayouts.4e420bac-c389-4bea-9708-e3e7c19f3cc1.tabs.0.elements.0.autocorrect','true'),('categoryGroups.b8fd3909-9af1-42c4-8c5e-2716a2a1957e.fieldLayouts.4e420bac-c389-4bea-9708-e3e7c19f3cc1.tabs.0.elements.0.class','null'),('categoryGroups.b8fd3909-9af1-42c4-8c5e-2716a2a1957e.fieldLayouts.4e420bac-c389-4bea-9708-e3e7c19f3cc1.tabs.0.elements.0.disabled','false'),('categoryGroups.b8fd3909-9af1-42c4-8c5e-2716a2a1957e.fieldLayouts.4e420bac-c389-4bea-9708-e3e7c19f3cc1.tabs.0.elements.0.id','null'),('categoryGroups.b8fd3909-9af1-42c4-8c5e-2716a2a1957e.fieldLayouts.4e420bac-c389-4bea-9708-e3e7c19f3cc1.tabs.0.elements.0.instructions','null'),('categoryGroups.b8fd3909-9af1-42c4-8c5e-2716a2a1957e.fieldLayouts.4e420bac-c389-4bea-9708-e3e7c19f3cc1.tabs.0.elements.0.label','null'),('categoryGroups.b8fd3909-9af1-42c4-8c5e-2716a2a1957e.fieldLayouts.4e420bac-c389-4bea-9708-e3e7c19f3cc1.tabs.0.elements.0.max','null'),('categoryGroups.b8fd3909-9af1-42c4-8c5e-2716a2a1957e.fieldLayouts.4e420bac-c389-4bea-9708-e3e7c19f3cc1.tabs.0.elements.0.min','null'),('categoryGroups.b8fd3909-9af1-42c4-8c5e-2716a2a1957e.fieldLayouts.4e420bac-c389-4bea-9708-e3e7c19f3cc1.tabs.0.elements.0.name','null'),('categoryGroups.b8fd3909-9af1-42c4-8c5e-2716a2a1957e.fieldLayouts.4e420bac-c389-4bea-9708-e3e7c19f3cc1.tabs.0.elements.0.orientation','null'),('categoryGroups.b8fd3909-9af1-42c4-8c5e-2716a2a1957e.fieldLayouts.4e420bac-c389-4bea-9708-e3e7c19f3cc1.tabs.0.elements.0.placeholder','null'),('categoryGroups.b8fd3909-9af1-42c4-8c5e-2716a2a1957e.fieldLayouts.4e420bac-c389-4bea-9708-e3e7c19f3cc1.tabs.0.elements.0.readonly','false'),('categoryGroups.b8fd3909-9af1-42c4-8c5e-2716a2a1957e.fieldLayouts.4e420bac-c389-4bea-9708-e3e7c19f3cc1.tabs.0.elements.0.requirable','false'),('categoryGroups.b8fd3909-9af1-42c4-8c5e-2716a2a1957e.fieldLayouts.4e420bac-c389-4bea-9708-e3e7c19f3cc1.tabs.0.elements.0.size','null'),('categoryGroups.b8fd3909-9af1-42c4-8c5e-2716a2a1957e.fieldLayouts.4e420bac-c389-4bea-9708-e3e7c19f3cc1.tabs.0.elements.0.step','null'),('categoryGroups.b8fd3909-9af1-42c4-8c5e-2716a2a1957e.fieldLayouts.4e420bac-c389-4bea-9708-e3e7c19f3cc1.tabs.0.elements.0.tip','null'),('categoryGroups.b8fd3909-9af1-42c4-8c5e-2716a2a1957e.fieldLayouts.4e420bac-c389-4bea-9708-e3e7c19f3cc1.tabs.0.elements.0.title','null'),('categoryGroups.b8fd3909-9af1-42c4-8c5e-2716a2a1957e.fieldLayouts.4e420bac-c389-4bea-9708-e3e7c19f3cc1.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\TitleField\"'),('categoryGroups.b8fd3909-9af1-42c4-8c5e-2716a2a1957e.fieldLayouts.4e420bac-c389-4bea-9708-e3e7c19f3cc1.tabs.0.elements.0.warning','null'),('categoryGroups.b8fd3909-9af1-42c4-8c5e-2716a2a1957e.fieldLayouts.4e420bac-c389-4bea-9708-e3e7c19f3cc1.tabs.0.elements.0.width','100'),('categoryGroups.b8fd3909-9af1-42c4-8c5e-2716a2a1957e.fieldLayouts.4e420bac-c389-4bea-9708-e3e7c19f3cc1.tabs.0.name','\"Content\"'),('categoryGroups.b8fd3909-9af1-42c4-8c5e-2716a2a1957e.fieldLayouts.4e420bac-c389-4bea-9708-e3e7c19f3cc1.tabs.0.sortOrder','1'),('categoryGroups.b8fd3909-9af1-42c4-8c5e-2716a2a1957e.handle','\"category\"'),('categoryGroups.b8fd3909-9af1-42c4-8c5e-2716a2a1957e.name','\"Category\"'),('categoryGroups.b8fd3909-9af1-42c4-8c5e-2716a2a1957e.siteSettings.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.hasUrls','true'),('categoryGroups.b8fd3909-9af1-42c4-8c5e-2716a2a1957e.siteSettings.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.template','null'),('categoryGroups.b8fd3909-9af1-42c4-8c5e-2716a2a1957e.siteSettings.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.uriFormat','\"category/{slug}\"'),('categoryGroups.b8fd3909-9af1-42c4-8c5e-2716a2a1957e.siteSettings.ec473f07-152f-423b-90df-ac425e6068a1.hasUrls','true'),('categoryGroups.b8fd3909-9af1-42c4-8c5e-2716a2a1957e.siteSettings.ec473f07-152f-423b-90df-ac425e6068a1.template','null'),('categoryGroups.b8fd3909-9af1-42c4-8c5e-2716a2a1957e.siteSettings.ec473f07-152f-423b-90df-ac425e6068a1.uriFormat','\"category/{slug}\"'),('categoryGroups.b8fd3909-9af1-42c4-8c5e-2716a2a1957e.structure.maxLevels','null'),('categoryGroups.b8fd3909-9af1-42c4-8c5e-2716a2a1957e.structure.uid','\"7955d443-a120-44f2-bdbe-c741d59fadf4\"'),('commerce.gateways.6a117ef0-054c-4147-acb6-6fe57d48c4ae.handle','\"dummy\"'),('commerce.gateways.6a117ef0-054c-4147-acb6-6fe57d48c4ae.isFrontendEnabled','true'),('commerce.gateways.6a117ef0-054c-4147-acb6-6fe57d48c4ae.name','\"Dummy\"'),('commerce.gateways.6a117ef0-054c-4147-acb6-6fe57d48c4ae.paymentType','\"purchase\"'),('commerce.gateways.6a117ef0-054c-4147-acb6-6fe57d48c4ae.settings','null'),('commerce.gateways.6a117ef0-054c-4147-acb6-6fe57d48c4ae.sortOrder','99'),('commerce.gateways.6a117ef0-054c-4147-acb6-6fe57d48c4ae.type','\"craft\\\\commerce\\\\gateways\\\\Dummy\"'),('commerce.orderStatuses.f923795f-139e-4b59-b27c-eaa0be4f847c.color','\"green\"'),('commerce.orderStatuses.f923795f-139e-4b59-b27c-eaa0be4f847c.default','true'),('commerce.orderStatuses.f923795f-139e-4b59-b27c-eaa0be4f847c.description','null'),('commerce.orderStatuses.f923795f-139e-4b59-b27c-eaa0be4f847c.handle','\"new\"'),('commerce.orderStatuses.f923795f-139e-4b59-b27c-eaa0be4f847c.name','\"New\"'),('commerce.orderStatuses.f923795f-139e-4b59-b27c-eaa0be4f847c.sortOrder','99'),('commerce.productTypes.407fe253-2ada-4a88-b1a4-fb6c2004cd9b.descriptionFormat','\"\"'),('commerce.productTypes.407fe253-2ada-4a88-b1a4-fb6c2004cd9b.handle','\"clothing\"'),('commerce.productTypes.407fe253-2ada-4a88-b1a4-fb6c2004cd9b.hasDimensions','true'),('commerce.productTypes.407fe253-2ada-4a88-b1a4-fb6c2004cd9b.hasProductTitleField','true'),('commerce.productTypes.407fe253-2ada-4a88-b1a4-fb6c2004cd9b.hasVariants','false'),('commerce.productTypes.407fe253-2ada-4a88-b1a4-fb6c2004cd9b.hasVariantTitleField','true'),('commerce.productTypes.407fe253-2ada-4a88-b1a4-fb6c2004cd9b.name','\"Clothing\"'),('commerce.productTypes.407fe253-2ada-4a88-b1a4-fb6c2004cd9b.productFieldLayouts.08766548-0b7c-493b-bdce-20f096719426.tabs.0.elements.0.instructions','null'),('commerce.productTypes.407fe253-2ada-4a88-b1a4-fb6c2004cd9b.productFieldLayouts.08766548-0b7c-493b-bdce-20f096719426.tabs.0.elements.0.label','null'),('commerce.productTypes.407fe253-2ada-4a88-b1a4-fb6c2004cd9b.productFieldLayouts.08766548-0b7c-493b-bdce-20f096719426.tabs.0.elements.0.required','false'),('commerce.productTypes.407fe253-2ada-4a88-b1a4-fb6c2004cd9b.productFieldLayouts.08766548-0b7c-493b-bdce-20f096719426.tabs.0.elements.0.tip','null'),('commerce.productTypes.407fe253-2ada-4a88-b1a4-fb6c2004cd9b.productFieldLayouts.08766548-0b7c-493b-bdce-20f096719426.tabs.0.elements.0.type','\"craft\\\\commerce\\\\fieldlayoutelements\\\\VariantsField\"'),('commerce.productTypes.407fe253-2ada-4a88-b1a4-fb6c2004cd9b.productFieldLayouts.08766548-0b7c-493b-bdce-20f096719426.tabs.0.elements.0.warning','null'),('commerce.productTypes.407fe253-2ada-4a88-b1a4-fb6c2004cd9b.productFieldLayouts.08766548-0b7c-493b-bdce-20f096719426.tabs.0.elements.1.autocapitalize','true'),('commerce.productTypes.407fe253-2ada-4a88-b1a4-fb6c2004cd9b.productFieldLayouts.08766548-0b7c-493b-bdce-20f096719426.tabs.0.elements.1.autocomplete','false'),('commerce.productTypes.407fe253-2ada-4a88-b1a4-fb6c2004cd9b.productFieldLayouts.08766548-0b7c-493b-bdce-20f096719426.tabs.0.elements.1.autocorrect','true'),('commerce.productTypes.407fe253-2ada-4a88-b1a4-fb6c2004cd9b.productFieldLayouts.08766548-0b7c-493b-bdce-20f096719426.tabs.0.elements.1.class','null'),('commerce.productTypes.407fe253-2ada-4a88-b1a4-fb6c2004cd9b.productFieldLayouts.08766548-0b7c-493b-bdce-20f096719426.tabs.0.elements.1.disabled','false'),('commerce.productTypes.407fe253-2ada-4a88-b1a4-fb6c2004cd9b.productFieldLayouts.08766548-0b7c-493b-bdce-20f096719426.tabs.0.elements.1.id','null'),('commerce.productTypes.407fe253-2ada-4a88-b1a4-fb6c2004cd9b.productFieldLayouts.08766548-0b7c-493b-bdce-20f096719426.tabs.0.elements.1.instructions','null'),('commerce.productTypes.407fe253-2ada-4a88-b1a4-fb6c2004cd9b.productFieldLayouts.08766548-0b7c-493b-bdce-20f096719426.tabs.0.elements.1.label','null'),('commerce.productTypes.407fe253-2ada-4a88-b1a4-fb6c2004cd9b.productFieldLayouts.08766548-0b7c-493b-bdce-20f096719426.tabs.0.elements.1.max','null'),('commerce.productTypes.407fe253-2ada-4a88-b1a4-fb6c2004cd9b.productFieldLayouts.08766548-0b7c-493b-bdce-20f096719426.tabs.0.elements.1.min','null'),('commerce.productTypes.407fe253-2ada-4a88-b1a4-fb6c2004cd9b.productFieldLayouts.08766548-0b7c-493b-bdce-20f096719426.tabs.0.elements.1.name','null'),('commerce.productTypes.407fe253-2ada-4a88-b1a4-fb6c2004cd9b.productFieldLayouts.08766548-0b7c-493b-bdce-20f096719426.tabs.0.elements.1.orientation','null'),('commerce.productTypes.407fe253-2ada-4a88-b1a4-fb6c2004cd9b.productFieldLayouts.08766548-0b7c-493b-bdce-20f096719426.tabs.0.elements.1.placeholder','null'),('commerce.productTypes.407fe253-2ada-4a88-b1a4-fb6c2004cd9b.productFieldLayouts.08766548-0b7c-493b-bdce-20f096719426.tabs.0.elements.1.readonly','false'),('commerce.productTypes.407fe253-2ada-4a88-b1a4-fb6c2004cd9b.productFieldLayouts.08766548-0b7c-493b-bdce-20f096719426.tabs.0.elements.1.requirable','false'),('commerce.productTypes.407fe253-2ada-4a88-b1a4-fb6c2004cd9b.productFieldLayouts.08766548-0b7c-493b-bdce-20f096719426.tabs.0.elements.1.size','null'),('commerce.productTypes.407fe253-2ada-4a88-b1a4-fb6c2004cd9b.productFieldLayouts.08766548-0b7c-493b-bdce-20f096719426.tabs.0.elements.1.step','null'),('commerce.productTypes.407fe253-2ada-4a88-b1a4-fb6c2004cd9b.productFieldLayouts.08766548-0b7c-493b-bdce-20f096719426.tabs.0.elements.1.tip','null'),('commerce.productTypes.407fe253-2ada-4a88-b1a4-fb6c2004cd9b.productFieldLayouts.08766548-0b7c-493b-bdce-20f096719426.tabs.0.elements.1.title','null'),('commerce.productTypes.407fe253-2ada-4a88-b1a4-fb6c2004cd9b.productFieldLayouts.08766548-0b7c-493b-bdce-20f096719426.tabs.0.elements.1.type','\"craft\\\\commerce\\\\fieldlayoutelements\\\\ProductTitleField\"'),('commerce.productTypes.407fe253-2ada-4a88-b1a4-fb6c2004cd9b.productFieldLayouts.08766548-0b7c-493b-bdce-20f096719426.tabs.0.elements.1.warning','null'),('commerce.productTypes.407fe253-2ada-4a88-b1a4-fb6c2004cd9b.productFieldLayouts.08766548-0b7c-493b-bdce-20f096719426.tabs.0.elements.1.width','100'),('commerce.productTypes.407fe253-2ada-4a88-b1a4-fb6c2004cd9b.productFieldLayouts.08766548-0b7c-493b-bdce-20f096719426.tabs.0.name','\"Content\"'),('commerce.productTypes.407fe253-2ada-4a88-b1a4-fb6c2004cd9b.productFieldLayouts.08766548-0b7c-493b-bdce-20f096719426.tabs.0.sortOrder','1'),('commerce.productTypes.407fe253-2ada-4a88-b1a4-fb6c2004cd9b.productTitleFormat','\"\"'),('commerce.productTypes.407fe253-2ada-4a88-b1a4-fb6c2004cd9b.siteSettings.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.hasUrls','true'),('commerce.productTypes.407fe253-2ada-4a88-b1a4-fb6c2004cd9b.siteSettings.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.template','\"shop/products/_product\"'),('commerce.productTypes.407fe253-2ada-4a88-b1a4-fb6c2004cd9b.siteSettings.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.uriFormat','\"shop/products/{slug}\"'),('commerce.productTypes.407fe253-2ada-4a88-b1a4-fb6c2004cd9b.siteSettings.ec473f07-152f-423b-90df-ac425e6068a1.hasUrls','true'),('commerce.productTypes.407fe253-2ada-4a88-b1a4-fb6c2004cd9b.siteSettings.ec473f07-152f-423b-90df-ac425e6068a1.template','\"shop/products/_product\"'),('commerce.productTypes.407fe253-2ada-4a88-b1a4-fb6c2004cd9b.siteSettings.ec473f07-152f-423b-90df-ac425e6068a1.uriFormat','\"shop/products/{slug}\"'),('commerce.productTypes.407fe253-2ada-4a88-b1a4-fb6c2004cd9b.skuFormat','\"\"'),('commerce.productTypes.407fe253-2ada-4a88-b1a4-fb6c2004cd9b.titleFormat','\"{product.title}\"'),('dateModified','1647534631'),('email.fromEmail','\"andrew@nystudio107.com\"'),('email.fromName','\"Craft\"'),('email.transportType','\"craft\\\\mail\\\\transportadapters\\\\Sendmail\"'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.elements.0.autocapitalize','true'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.elements.0.autocomplete','false'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.elements.0.autocorrect','true'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.elements.0.class','null'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.elements.0.disabled','false'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.elements.0.id','null'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.elements.0.instructions','null'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.elements.0.label','null'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.elements.0.max','null'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.elements.0.min','null'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.elements.0.name','null'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.elements.0.orientation','null'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.elements.0.placeholder','null'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.elements.0.readonly','false'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.elements.0.requirable','false'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.elements.0.size','null'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.elements.0.step','null'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.elements.0.tip','null'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.elements.0.title','null'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\EntryTitleField\"'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.elements.0.warning','null'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.elements.0.width','100'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.elements.1.fieldUid','\"21903cb2-5b82-49ea-9766-e120d0951ea3\"'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.elements.1.instructions','null'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.elements.1.label','null'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.elements.1.required','false'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.elements.1.tip','null'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.elements.1.warning','null'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.elements.1.width','100'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.elements.2.fieldUid','\"abcda4a4-b1db-4677-b5d6-69588443704f\"'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.elements.2.instructions','null'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.elements.2.label','null'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.elements.2.required','false'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.elements.2.tip','null'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.elements.2.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.elements.2.warning','null'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.elements.2.width','100'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.elements.3.fieldUid','\"4a0cb371-14a6-415d-84db-fc0512410ec8\"'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.elements.3.instructions','null'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.elements.3.label','null'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.elements.3.required','false'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.elements.3.tip','null'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.elements.3.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.elements.3.warning','null'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.elements.3.width','100'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.name','\"Content\"'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.fieldLayouts.446fae8b-775a-4b1b-a6dc-ef009aede404.tabs.0.sortOrder','1'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.handle','\"review\"'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.hasTitleField','true'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.name','\"Review\"'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.section','\"de308a7d-1794-448f-9176-29e2eace7ecf\"'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.sortOrder','2'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.titleFormat','null'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.titleTranslationKeyFormat','null'),('entryTypes.626b0987-e067-4dd2-9918-1d209373265a.titleTranslationMethod','\"site\"'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.elements.0.autocapitalize','true'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.elements.0.autocomplete','false'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.elements.0.autocorrect','true'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.elements.0.class','null'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.elements.0.disabled','false'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.elements.0.id','null'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.elements.0.instructions','null'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.elements.0.label','null'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.elements.0.max','null'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.elements.0.min','null'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.elements.0.name','null'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.elements.0.orientation','null'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.elements.0.placeholder','null'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.elements.0.readonly','false'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.elements.0.requirable','false'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.elements.0.size','null'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.elements.0.step','null'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.elements.0.tip','null'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.elements.0.title','null'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\EntryTitleField\"'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.elements.0.warning','null'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.elements.0.width','100'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.elements.1.fieldUid','\"21903cb2-5b82-49ea-9766-e120d0951ea3\"'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.elements.1.instructions','null'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.elements.1.label','null'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.elements.1.required','false'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.elements.1.tip','null'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.elements.1.warning','null'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.elements.1.width','100'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.elements.2.fieldUid','\"abcda4a4-b1db-4677-b5d6-69588443704f\"'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.elements.2.instructions','null'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.elements.2.label','null'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.elements.2.required','false'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.elements.2.tip','null'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.elements.2.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.elements.2.warning','null'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.elements.2.width','100'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.elements.3.fieldUid','\"4a0cb371-14a6-415d-84db-fc0512410ec8\"'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.elements.3.instructions','null'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.elements.3.label','null'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.elements.3.required','false'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.elements.3.tip','null'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.elements.3.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.elements.3.warning','null'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.elements.3.width','100'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.name','\"Content\"'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.fieldLayouts.44918e94-126a-4108-98da-1f66e19d2b2d.tabs.0.sortOrder','1'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.handle','\"blog\"'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.hasTitleField','true'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.name','\"Blog\"'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.section','\"de308a7d-1794-448f-9176-29e2eace7ecf\"'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.sortOrder','1'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.titleFormat','null'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.titleTranslationKeyFormat','null'),('entryTypes.c4536798-743d-4bf0-9669-192827bfb26c.titleTranslationMethod','\"site\"'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.elements.0.autocapitalize','true'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.elements.0.autocomplete','false'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.elements.0.autocorrect','true'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.elements.0.class','null'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.elements.0.disabled','false'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.elements.0.id','null'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.elements.0.instructions','null'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.elements.0.label','null'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.elements.0.max','null'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.elements.0.min','null'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.elements.0.name','null'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.elements.0.orientation','null'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.elements.0.placeholder','null'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.elements.0.readonly','false'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.elements.0.requirable','false'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.elements.0.size','null'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.elements.0.step','null'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.elements.0.tip','null'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.elements.0.title','null'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\EntryTitleField\"'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.elements.0.warning','null'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.elements.0.width','100'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.elements.1.fieldUid','\"21903cb2-5b82-49ea-9766-e120d0951ea3\"'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.elements.1.instructions','null'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.elements.1.label','null'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.elements.1.required','false'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.elements.1.tip','null'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.elements.1.warning','null'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.elements.1.width','100'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.elements.2.fieldUid','\"abcda4a4-b1db-4677-b5d6-69588443704f\"'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.elements.2.instructions','null'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.elements.2.label','null'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.elements.2.required','false'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.elements.2.tip','null'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.elements.2.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.elements.2.warning','null'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.elements.2.width','100'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.elements.3.fieldUid','\"4a0cb371-14a6-415d-84db-fc0512410ec8\"'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.elements.3.instructions','null'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.elements.3.label','null'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.elements.3.required','false'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.elements.3.tip','null'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.elements.3.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.elements.3.warning','null'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.elements.3.width','100'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.name','\"Content\"'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.fieldLayouts.3079b909-ff31-4f40-98a0-10c57767ab1f.tabs.0.sortOrder','1'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.handle','\"homepage\"'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.hasTitleField','false'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.name','\"Homepage\"'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.section','\"54e60257-f31a-44aa-960e-bbd364197e28\"'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.sortOrder','1'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.titleFormat','\"{section.name|raw}\"'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.titleTranslationKeyFormat','null'),('entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.titleTranslationMethod','\"none\"'),('fieldGroups.94b4d5ac-d7ea-4241-a6cb-92b39f482f99.name','\"Common\"'),('fields.21903cb2-5b82-49ea-9766-e120d0951ea3.columnSuffix','null'),('fields.21903cb2-5b82-49ea-9766-e120d0951ea3.contentColumnType','\"text\"'),('fields.21903cb2-5b82-49ea-9766-e120d0951ea3.fieldGroup','\"94b4d5ac-d7ea-4241-a6cb-92b39f482f99\"'),('fields.21903cb2-5b82-49ea-9766-e120d0951ea3.handle','\"plainText\"'),('fields.21903cb2-5b82-49ea-9766-e120d0951ea3.instructions','\"\"'),('fields.21903cb2-5b82-49ea-9766-e120d0951ea3.name','\"Plain Text\"'),('fields.21903cb2-5b82-49ea-9766-e120d0951ea3.searchable','false'),('fields.21903cb2-5b82-49ea-9766-e120d0951ea3.settings.byteLimit','null'),('fields.21903cb2-5b82-49ea-9766-e120d0951ea3.settings.charLimit','null'),('fields.21903cb2-5b82-49ea-9766-e120d0951ea3.settings.code','\"\"'),('fields.21903cb2-5b82-49ea-9766-e120d0951ea3.settings.columnType','null'),('fields.21903cb2-5b82-49ea-9766-e120d0951ea3.settings.initialRows','\"4\"'),('fields.21903cb2-5b82-49ea-9766-e120d0951ea3.settings.multiline','\"\"'),('fields.21903cb2-5b82-49ea-9766-e120d0951ea3.settings.placeholder','null'),('fields.21903cb2-5b82-49ea-9766-e120d0951ea3.settings.uiMode','\"normal\"'),('fields.21903cb2-5b82-49ea-9766-e120d0951ea3.translationKeyFormat','null'),('fields.21903cb2-5b82-49ea-9766-e120d0951ea3.translationMethod','\"none\"'),('fields.21903cb2-5b82-49ea-9766-e120d0951ea3.type','\"craft\\\\fields\\\\PlainText\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.columnSuffix','\"hjezvijy\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.contentColumnType','\"text\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.fieldGroup','\"94b4d5ac-d7ea-4241-a6cb-92b39f482f99\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.handle','\"someImages\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.instructions','\"\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.name','\"Some Images\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.searchable','false'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.displayDominantColorPalette','\"1\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.displayLazyLoadPlaceholderImages','\"1\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.displayOptimizedImageVariants','\"1\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.0.__assoc__.0.0','\"width\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.0.__assoc__.0.1','\"1200\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.0.__assoc__.1.0','\"useAspectRatio\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.0.__assoc__.1.1','\"1\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.0.__assoc__.2.0','\"aspectRatioX\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.0.__assoc__.2.1','\"16\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.0.__assoc__.3.0','\"aspectRatioY\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.0.__assoc__.3.1','\"9\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.0.__assoc__.4.0','\"retinaSizes\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.0.__assoc__.4.1.0','\"1\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.0.__assoc__.5.0','\"quality\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.0.__assoc__.5.1','\"82\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.0.__assoc__.6.0','\"format\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.0.__assoc__.6.1','\"jpg\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.1.__assoc__.0.0','\"width\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.1.__assoc__.0.1','\"992\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.1.__assoc__.1.0','\"useAspectRatio\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.1.__assoc__.1.1','\"1\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.1.__assoc__.2.0','\"aspectRatioX\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.1.__assoc__.2.1','\"16\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.1.__assoc__.3.0','\"aspectRatioY\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.1.__assoc__.3.1','\"9\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.1.__assoc__.4.0','\"retinaSizes\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.1.__assoc__.4.1.0','\"1\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.1.__assoc__.5.0','\"quality\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.1.__assoc__.5.1','\"82\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.1.__assoc__.6.0','\"format\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.1.__assoc__.6.1','\"jpg\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.2.__assoc__.0.0','\"width\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.2.__assoc__.0.1','\"768\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.2.__assoc__.1.0','\"useAspectRatio\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.2.__assoc__.1.1','\"1\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.2.__assoc__.2.0','\"aspectRatioX\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.2.__assoc__.2.1','\"4\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.2.__assoc__.3.0','\"aspectRatioY\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.2.__assoc__.3.1','\"3\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.2.__assoc__.4.0','\"retinaSizes\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.2.__assoc__.4.1.0','\"1\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.2.__assoc__.5.0','\"quality\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.2.__assoc__.5.1','\"60\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.2.__assoc__.6.0','\"format\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.2.__assoc__.6.1','\"jpg\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.3.__assoc__.0.0','\"width\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.3.__assoc__.0.1','\"576\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.3.__assoc__.1.0','\"useAspectRatio\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.3.__assoc__.1.1','\"1\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.3.__assoc__.2.0','\"aspectRatioX\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.3.__assoc__.2.1','\"4\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.3.__assoc__.3.0','\"aspectRatioY\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.3.__assoc__.3.1','\"3\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.3.__assoc__.4.0','\"retinaSizes\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.3.__assoc__.4.1.0','\"1\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.3.__assoc__.5.0','\"quality\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.3.__assoc__.5.1','\"60\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.3.__assoc__.6.0','\"format\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.settings.variants.3.__assoc__.6.1','\"jpg\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.translationKeyFormat','null'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.translationMethod','\"none\"'),('fields.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16.type','\"nystudio107\\\\imageoptimize\\\\fields\\\\OptimizedImages\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.columnSuffix','null'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.contentColumnType','\"text\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.fieldGroup','\"94b4d5ac-d7ea-4241-a6cb-92b39f482f99\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.handle','\"optimizedImages\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.instructions','\"\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.name','\"Optimized Images\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.searchable','false'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.displayDominantColorPalette','\"1\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.displayLazyLoadPlaceholderImages','\"1\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.displayOptimizedImageVariants','\"1\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.0.__assoc__.0.0','\"width\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.0.__assoc__.0.1','\"1200\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.0.__assoc__.1.0','\"useAspectRatio\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.0.__assoc__.1.1','\"1\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.0.__assoc__.2.0','\"aspectRatioX\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.0.__assoc__.2.1','\"16\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.0.__assoc__.3.0','\"aspectRatioY\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.0.__assoc__.3.1','\"9\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.0.__assoc__.4.0','\"retinaSizes\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.0.__assoc__.4.1.0','\"1\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.0.__assoc__.5.0','\"quality\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.0.__assoc__.5.1','\"82\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.0.__assoc__.6.0','\"format\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.0.__assoc__.6.1','\"jpg\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.1.__assoc__.0.0','\"width\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.1.__assoc__.0.1','\"992\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.1.__assoc__.1.0','\"useAspectRatio\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.1.__assoc__.1.1','\"1\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.1.__assoc__.2.0','\"aspectRatioX\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.1.__assoc__.2.1','\"16\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.1.__assoc__.3.0','\"aspectRatioY\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.1.__assoc__.3.1','\"9\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.1.__assoc__.4.0','\"retinaSizes\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.1.__assoc__.4.1.0','\"1\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.1.__assoc__.5.0','\"quality\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.1.__assoc__.5.1','\"82\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.1.__assoc__.6.0','\"format\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.1.__assoc__.6.1','\"jpg\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.2.__assoc__.0.0','\"width\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.2.__assoc__.0.1','\"768\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.2.__assoc__.1.0','\"useAspectRatio\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.2.__assoc__.1.1','\"1\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.2.__assoc__.2.0','\"aspectRatioX\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.2.__assoc__.2.1','\"4\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.2.__assoc__.3.0','\"aspectRatioY\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.2.__assoc__.3.1','\"3\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.2.__assoc__.4.0','\"retinaSizes\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.2.__assoc__.4.1.0','\"1\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.2.__assoc__.5.0','\"quality\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.2.__assoc__.5.1','\"60\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.2.__assoc__.6.0','\"format\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.2.__assoc__.6.1','\"jpg\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.3.__assoc__.0.0','\"width\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.3.__assoc__.0.1','\"576\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.3.__assoc__.1.0','\"useAspectRatio\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.3.__assoc__.1.1','\"1\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.3.__assoc__.2.0','\"aspectRatioX\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.3.__assoc__.2.1','\"4\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.3.__assoc__.3.0','\"aspectRatioY\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.3.__assoc__.3.1','\"3\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.3.__assoc__.4.0','\"retinaSizes\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.3.__assoc__.4.1.0','\"1\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.3.__assoc__.5.0','\"quality\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.3.__assoc__.5.1','\"60\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.3.__assoc__.6.0','\"format\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.settings.variants.3.__assoc__.6.1','\"jpg\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.translationKeyFormat','null'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.translationMethod','\"none\"'),('fields.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5.type','\"nystudio107\\\\imageoptimize\\\\fields\\\\OptimizedImages\"'),('fields.4a0cb371-14a6-415d-84db-fc0512410ec8.columnSuffix','null'),('fields.4a0cb371-14a6-415d-84db-fc0512410ec8.contentColumnType','\"text\"'),('fields.4a0cb371-14a6-415d-84db-fc0512410ec8.fieldGroup','\"94b4d5ac-d7ea-4241-a6cb-92b39f482f99\"'),('fields.4a0cb371-14a6-415d-84db-fc0512410ec8.handle','\"seo\"'),('fields.4a0cb371-14a6-415d-84db-fc0512410ec8.instructions','\"\"'),('fields.4a0cb371-14a6-415d-84db-fc0512410ec8.name','\"SEO\"'),('fields.4a0cb371-14a6-415d-84db-fc0512410ec8.searchable','false'),('fields.4a0cb371-14a6-415d-84db-fc0512410ec8.settings.elementDisplayPreviewType','\"google\"'),('fields.4a0cb371-14a6-415d-84db-fc0512410ec8.settings.facebookTabEnabled','\"\"'),('fields.4a0cb371-14a6-415d-84db-fc0512410ec8.settings.generalEnabledFields.0','\"seoPreview\"'),('fields.4a0cb371-14a6-415d-84db-fc0512410ec8.settings.generalEnabledFields.1','\"mainEntityOfPage\"'),('fields.4a0cb371-14a6-415d-84db-fc0512410ec8.settings.generalEnabledFields.10','\"robots\"'),('fields.4a0cb371-14a6-415d-84db-fc0512410ec8.settings.generalEnabledFields.11','\"canonicalUrl\"'),('fields.4a0cb371-14a6-415d-84db-fc0512410ec8.settings.generalEnabledFields.2','\"seoTitle\"'),('fields.4a0cb371-14a6-415d-84db-fc0512410ec8.settings.generalEnabledFields.3','\"siteNamePosition\"'),('fields.4a0cb371-14a6-415d-84db-fc0512410ec8.settings.generalEnabledFields.4','\"seoDescription\"'),('fields.4a0cb371-14a6-415d-84db-fc0512410ec8.settings.generalEnabledFields.5','\"seoKeywords\"'),('fields.4a0cb371-14a6-415d-84db-fc0512410ec8.settings.generalEnabledFields.6','\"seoImage\"'),('fields.4a0cb371-14a6-415d-84db-fc0512410ec8.settings.generalEnabledFields.7','\"seoImageTransform\"'),('fields.4a0cb371-14a6-415d-84db-fc0512410ec8.settings.generalEnabledFields.8','\"seoImageTransformMode\"'),('fields.4a0cb371-14a6-415d-84db-fc0512410ec8.settings.generalEnabledFields.9','\"seoImageDescription\"'),('fields.4a0cb371-14a6-415d-84db-fc0512410ec8.settings.generalTabEnabled','\"1\"'),('fields.4a0cb371-14a6-415d-84db-fc0512410ec8.settings.sitemapEnabledFields.0','\"sitemapUrls\"'),('fields.4a0cb371-14a6-415d-84db-fc0512410ec8.settings.sitemapEnabledFields.1','\"sitemapAssets\"'),('fields.4a0cb371-14a6-415d-84db-fc0512410ec8.settings.sitemapEnabledFields.2','\"sitemapFiles\"'),('fields.4a0cb371-14a6-415d-84db-fc0512410ec8.settings.sitemapEnabledFields.3','\"sitemapAltLinks\"'),('fields.4a0cb371-14a6-415d-84db-fc0512410ec8.settings.sitemapEnabledFields.4','\"sitemapChangeFreq\"'),('fields.4a0cb371-14a6-415d-84db-fc0512410ec8.settings.sitemapEnabledFields.5','\"sitemapPriority\"'),('fields.4a0cb371-14a6-415d-84db-fc0512410ec8.settings.sitemapEnabledFields.6','\"sitemapLimit\"'),('fields.4a0cb371-14a6-415d-84db-fc0512410ec8.settings.sitemapTabEnabled','\"\"'),('fields.4a0cb371-14a6-415d-84db-fc0512410ec8.settings.twitterTabEnabled','\"\"'),('fields.4a0cb371-14a6-415d-84db-fc0512410ec8.translationKeyFormat','null'),('fields.4a0cb371-14a6-415d-84db-fc0512410ec8.translationMethod','\"none\"'),('fields.4a0cb371-14a6-415d-84db-fc0512410ec8.type','\"nystudio107\\\\seomatic\\\\fields\\\\SeoSettings\"'),('fields.abcda4a4-b1db-4677-b5d6-69588443704f.columnSuffix','null'),('fields.abcda4a4-b1db-4677-b5d6-69588443704f.contentColumnType','\"text\"'),('fields.abcda4a4-b1db-4677-b5d6-69588443704f.fieldGroup','\"94b4d5ac-d7ea-4241-a6cb-92b39f482f99\"'),('fields.abcda4a4-b1db-4677-b5d6-69588443704f.handle','\"richText\"'),('fields.abcda4a4-b1db-4677-b5d6-69588443704f.instructions','\"\"'),('fields.abcda4a4-b1db-4677-b5d6-69588443704f.name','\"Rich Text\"'),('fields.abcda4a4-b1db-4677-b5d6-69588443704f.searchable','false'),('fields.abcda4a4-b1db-4677-b5d6-69588443704f.settings.availableTransforms','\"*\"'),('fields.abcda4a4-b1db-4677-b5d6-69588443704f.settings.availableVolumes','\"*\"'),('fields.abcda4a4-b1db-4677-b5d6-69588443704f.settings.columnType','\"text\"'),('fields.abcda4a4-b1db-4677-b5d6-69588443704f.settings.configSelectionMode','\"choose\"'),('fields.abcda4a4-b1db-4677-b5d6-69588443704f.settings.defaultTransform','\"\"'),('fields.abcda4a4-b1db-4677-b5d6-69588443704f.settings.manualConfig','\"\"'),('fields.abcda4a4-b1db-4677-b5d6-69588443704f.settings.purifierConfig','\"\"'),('fields.abcda4a4-b1db-4677-b5d6-69588443704f.settings.purifyHtml','\"1\"'),('fields.abcda4a4-b1db-4677-b5d6-69588443704f.settings.redactorConfig','\"Simple.json\"'),('fields.abcda4a4-b1db-4677-b5d6-69588443704f.settings.removeEmptyTags','\"1\"'),('fields.abcda4a4-b1db-4677-b5d6-69588443704f.settings.removeInlineStyles','\"1\"'),('fields.abcda4a4-b1db-4677-b5d6-69588443704f.settings.removeNbsp','\"1\"'),('fields.abcda4a4-b1db-4677-b5d6-69588443704f.settings.showHtmlButtonForNonAdmins','\"\"'),('fields.abcda4a4-b1db-4677-b5d6-69588443704f.settings.showUnpermittedFiles','false'),('fields.abcda4a4-b1db-4677-b5d6-69588443704f.settings.showUnpermittedVolumes','false'),('fields.abcda4a4-b1db-4677-b5d6-69588443704f.settings.uiMode','\"enlarged\"'),('fields.abcda4a4-b1db-4677-b5d6-69588443704f.translationKeyFormat','null'),('fields.abcda4a4-b1db-4677-b5d6-69588443704f.translationMethod','\"none\"'),('fields.abcda4a4-b1db-4677-b5d6-69588443704f.type','\"craft\\\\redactor\\\\Field\"'),('formie.statuses.110568c4-6978-4a9d-ae96-44c45c0739c1.color','\"green\"'),('formie.statuses.110568c4-6978-4a9d-ae96-44c45c0739c1.description','null'),('formie.statuses.110568c4-6978-4a9d-ae96-44c45c0739c1.handle','\"new\"'),('formie.statuses.110568c4-6978-4a9d-ae96-44c45c0739c1.isDefault','true'),('formie.statuses.110568c4-6978-4a9d-ae96-44c45c0739c1.name','\"New\"'),('formie.statuses.110568c4-6978-4a9d-ae96-44c45c0739c1.sortOrder','1'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.availability','\"always\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.availabilityFrom','null'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.availabilitySubmissions','null'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.availabilityTo','null'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.dataRetention','\"forever\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.dataRetentionValue','null'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.fileUploadsAction','\"retain\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.notifications.0.attachFiles','true'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.notifications.0.content','\"[{\\\"type\\\":\\\"paragraph\\\",\\\"content\\\":[{\\\"type\\\":\\\"text\\\",\\\"text\\\":\\\"A user submission has been made on the \\\\\\\"\\\"},{\\\"type\\\":\\\"variableTag\\\",\\\"attrs\\\":{\\\"label\\\":\\\"Form Name\\\",\\\"value\\\":\\\"{formName}\\\"}},{\\\"type\\\":\\\"text\\\",\\\"text\\\":\\\"\\\\\\\" form on \\\"},{\\\"type\\\":\\\"variableTag\\\",\\\"attrs\\\":{\\\"label\\\":\\\"Site Name\\\",\\\"value\\\":\\\"{siteName}\\\"}},{\\\"type\\\":\\\"text\\\",\\\"text\\\":\\\" at \\\"},{\\\"type\\\":\\\"variableTag\\\",\\\"attrs\\\":{\\\"label\\\":\\\"Timestamp (yyyy-mm-dd hh:mm:ss)\\\",\\\"value\\\":\\\"{timestamp}\\\"}}]},{\\\"type\\\":\\\"paragraph\\\",\\\"content\\\":[{\\\"type\\\":\\\"text\\\",\\\"text\\\":\\\"Their submission details are:\\\"}]},{\\\"type\\\":\\\"paragraph\\\",\\\"content\\\":[{\\\"type\\\":\\\"variableTag\\\",\\\"attrs\\\":{\\\"label\\\":\\\"All Form Fields\\\",\\\"value\\\":\\\"{allFields}\\\"}}]}]\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.notifications.0.enabled','true'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.notifications.0.from','\"{field.emailAddress}\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.notifications.0.id','\"new981-8077\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.notifications.0.name','\"Admin Notification\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.notifications.0.replyTo','\"{field.emailAddress}\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.notifications.0.subject','\"A new submission was made on \\\"{formName}\\\"\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.notifications.0.templateId','\"\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.notifications.0.to','\"{systemEmail}\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.notifications.1.attachFiles','true'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.notifications.1.content','\"[{\\\"type\\\":\\\"paragraph\\\",\\\"content\\\":[{\\\"type\\\":\\\"text\\\",\\\"text\\\":\\\"Thanks again for contacting us. Our team will get back to you as soon as we can.\\\"}]},{\\\"type\\\":\\\"paragraph\\\",\\\"content\\\":[{\\\"type\\\":\\\"text\\\",\\\"text\\\":\\\"As a reminder, you submitted the following details at \\\"},{\\\"type\\\":\\\"variableTag\\\",\\\"attrs\\\":{\\\"label\\\":\\\"Timestamp (yyyy-mm-dd hh:mm:ss)\\\",\\\"value\\\":\\\"{timestamp}\\\"}}]},{\\\"type\\\":\\\"paragraph\\\",\\\"content\\\":[{\\\"type\\\":\\\"variableTag\\\",\\\"attrs\\\":{\\\"label\\\":\\\"All Form Fields\\\",\\\"value\\\":\\\"{allFields}\\\"}}]}]\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.notifications.1.enabled','true'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.notifications.1.id','\"new7052-5168\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.notifications.1.name','\"User Notification\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.notifications.1.subject','\"Thanks for contacting us!\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.notifications.1.templateId','\"\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.notifications.1.to','\"{field.emailAddress}\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.id','\"new1272610411\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.label','\"Page 1\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.0.fields.0.brandNewField','false'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.0.fields.0.columnWidth','12'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.0.fields.0.handle','\"yourName\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.0.fields.0.hasLabel','true'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.0.fields.0.id','\"new7715-7348\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.0.fields.0.label','\"Your Name\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.0.fields.0.settings.firstNameCollapsed','false'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.0.fields.0.settings.firstNameDefaultValue','\"\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.0.fields.0.settings.firstNameEnabled','true'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.0.fields.0.settings.firstNameLabel','\"First Name\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.0.fields.0.settings.firstNamePlaceholder','\"e.g. Peter\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.0.fields.0.settings.firstNameRequired','true'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.0.fields.0.settings.handle','\"yourName\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.0.fields.0.settings.instructions','\"Please enter your full name.\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.0.fields.0.settings.instructionsPosition','\"\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.0.fields.0.settings.label','\"Your Name\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.0.fields.0.settings.labelPosition','\"verbb\\\\formie\\\\positions\\\\Hidden\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.0.fields.0.settings.lastNameCollapsed','false'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.0.fields.0.settings.lastNameDefaultValue','\"\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.0.fields.0.settings.lastNameEnabled','true'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.0.fields.0.settings.lastNameLabel','\"Last Name\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.0.fields.0.settings.lastNamePlaceholder','\"e.g. Sherman\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.0.fields.0.settings.lastNameRequired','true'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.0.fields.0.settings.limitType','\"characters\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.0.fields.0.settings.middleNameCollapsed','true'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.0.fields.0.settings.middleNameDefaultValue','\"\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.0.fields.0.settings.middleNameEnabled','false'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.0.fields.0.settings.middleNameLabel','\"Middle Name\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.0.fields.0.settings.placeholder','\"Your name\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.0.fields.0.settings.prefixCollapsed','true'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.0.fields.0.settings.prefixDefaultValue','\"\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.0.fields.0.settings.prefixEnabled','false'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.0.fields.0.settings.prefixLabel','\"Prefix\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.0.fields.0.settings.subfieldLabelPosition','\"\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.0.fields.0.settings.useMultipleFields','true'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.0.fields.0.type','\"verbb\\\\formie\\\\fields\\\\formfields\\\\Name\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.0.id','\"new8990-9934\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.1.fields.0.brandNewField','false'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.1.fields.0.columnWidth','12'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.1.fields.0.handle','\"emailAddress\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.1.fields.0.hasLabel','true'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.1.fields.0.id','\"new6482-9528\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.1.fields.0.label','\"Email Address\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.1.fields.0.settings.handle','\"emailAddress\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.1.fields.0.settings.instructions','\"Please enter your email so we can get in touch.\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.1.fields.0.settings.instructionsPosition','\"\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.1.fields.0.settings.label','\"Email Address\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.1.fields.0.settings.labelPosition','\"\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.1.fields.0.settings.limitType','\"characters\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.1.fields.0.settings.placeholder','\"e.g. psherman@wallaby.com\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.1.fields.0.settings.required','true'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.1.fields.0.type','\"verbb\\\\formie\\\\fields\\\\formfields\\\\Email\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.1.id','\"new9524-8509\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.2.fields.0.brandNewField','false'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.2.fields.0.columnWidth','12'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.2.fields.0.handle','\"message\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.2.fields.0.hasLabel','true'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.2.fields.0.id','\"new982-7322\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.2.fields.0.label','\"Message\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.2.fields.0.settings.handle','\"message\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.2.fields.0.settings.instructions','\"Please enter your comments.\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.2.fields.0.settings.instructionsPosition','\"\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.2.fields.0.settings.label','\"Message\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.2.fields.0.settings.labelPosition','\"\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.2.fields.0.settings.limitType','\"characters\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.2.fields.0.settings.placeholder','\"e.g. The reason for my enquiry is...\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.2.fields.0.settings.required','true'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.2.fields.0.type','\"verbb\\\\formie\\\\fields\\\\formfields\\\\MultiLineText\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.rows.2.id','\"new2177-9685\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.settings.backButtonLabel','\"Back\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.settings.buttonsPosition','\"left\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.settings.label','\"Page 1\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.settings.showBackButton','false'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.settings.submitButtonLabel','\"Contact us\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.pages.0.sortOrder','0'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.requireUser','false'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.settings.availabilityMessage','null'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.settings.availabilityMessageDate','null'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.settings.availabilityMessageSubmissions','null'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.settings.collectIp','\"\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.settings.collectUser','null'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.settings.dataRetention','null'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.settings.dataRetentionValue','null'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.settings.defaultEmailTemplateId','\"\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.settings.defaultInstructionsPosition','\"verbb\\\\formie\\\\positions\\\\AboveInput\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.settings.defaultLabelPosition','\"verbb\\\\formie\\\\positions\\\\AboveInput\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.settings.displayCurrentPageTitle','\"\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.settings.displayFormTitle','\"\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.settings.displayPageProgress','\"\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.settings.displayPageTabs','\"\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.settings.errorMessage.0.content.0.text','\"Couldn’t save submission due to errors.\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.settings.errorMessage.0.content.0.type','\"text\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.settings.errorMessage.0.type','\"paragraph\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.settings.errorMessagePosition','\"top-form\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.settings.fileUploadsAction','null'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.settings.loadingIndicator','\"spinner\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.settings.loadingIndicatorText','\"\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.settings.progressPosition','\"end\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.settings.redirectUrl','null'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.settings.storeData','null'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.settings.submissionTitleFormat','\"{timestamp}\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.settings.submitAction','\"message\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.settings.submitActionFormHide','\"\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.settings.submitActionMessage.0.content.0.text','\"Thank you for contacting us! Our team will get in touch shortly to follow up on your message.\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.settings.submitActionMessage.0.content.0.type','\"text\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.settings.submitActionMessage.0.type','\"paragraph\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.settings.submitActionMessagePosition','\"top-form\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.settings.submitActionMessageTimeout','\"\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.settings.submitActionTab','null'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.settings.submitActionUrl','\"\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.settings.submitMethod','\"ajax\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.settings.userDeletedAction','null'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.settings.validationOnFocus','\"1\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.settings.validationOnSubmit','\"1\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.data.userDeletedAction','\"retain\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.defaultStatusId','null'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.handle','\"contactForm\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.name','\"Contact Form\"'),('formie.stencils.a0587a0b-d71c-4085-9c28-f0165af2b925.templateId','null'),('globalSets.aa7c6968-88ec-4d2a-af47-d3c40b582a68.fieldLayouts.e1ad1c2a-97c8-4b64-9d59-41e897a98298.tabs.0.elements.0.fieldUid','\"21903cb2-5b82-49ea-9766-e120d0951ea3\"'),('globalSets.aa7c6968-88ec-4d2a-af47-d3c40b582a68.fieldLayouts.e1ad1c2a-97c8-4b64-9d59-41e897a98298.tabs.0.elements.0.instructions','null'),('globalSets.aa7c6968-88ec-4d2a-af47-d3c40b582a68.fieldLayouts.e1ad1c2a-97c8-4b64-9d59-41e897a98298.tabs.0.elements.0.label','null'),('globalSets.aa7c6968-88ec-4d2a-af47-d3c40b582a68.fieldLayouts.e1ad1c2a-97c8-4b64-9d59-41e897a98298.tabs.0.elements.0.required','false'),('globalSets.aa7c6968-88ec-4d2a-af47-d3c40b582a68.fieldLayouts.e1ad1c2a-97c8-4b64-9d59-41e897a98298.tabs.0.elements.0.tip','null'),('globalSets.aa7c6968-88ec-4d2a-af47-d3c40b582a68.fieldLayouts.e1ad1c2a-97c8-4b64-9d59-41e897a98298.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('globalSets.aa7c6968-88ec-4d2a-af47-d3c40b582a68.fieldLayouts.e1ad1c2a-97c8-4b64-9d59-41e897a98298.tabs.0.elements.0.warning','null'),('globalSets.aa7c6968-88ec-4d2a-af47-d3c40b582a68.fieldLayouts.e1ad1c2a-97c8-4b64-9d59-41e897a98298.tabs.0.elements.0.width','100'),('globalSets.aa7c6968-88ec-4d2a-af47-d3c40b582a68.fieldLayouts.e1ad1c2a-97c8-4b64-9d59-41e897a98298.tabs.0.elements.1.fieldUid','\"abcda4a4-b1db-4677-b5d6-69588443704f\"'),('globalSets.aa7c6968-88ec-4d2a-af47-d3c40b582a68.fieldLayouts.e1ad1c2a-97c8-4b64-9d59-41e897a98298.tabs.0.elements.1.instructions','null'),('globalSets.aa7c6968-88ec-4d2a-af47-d3c40b582a68.fieldLayouts.e1ad1c2a-97c8-4b64-9d59-41e897a98298.tabs.0.elements.1.label','null'),('globalSets.aa7c6968-88ec-4d2a-af47-d3c40b582a68.fieldLayouts.e1ad1c2a-97c8-4b64-9d59-41e897a98298.tabs.0.elements.1.required','false'),('globalSets.aa7c6968-88ec-4d2a-af47-d3c40b582a68.fieldLayouts.e1ad1c2a-97c8-4b64-9d59-41e897a98298.tabs.0.elements.1.tip','null'),('globalSets.aa7c6968-88ec-4d2a-af47-d3c40b582a68.fieldLayouts.e1ad1c2a-97c8-4b64-9d59-41e897a98298.tabs.0.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('globalSets.aa7c6968-88ec-4d2a-af47-d3c40b582a68.fieldLayouts.e1ad1c2a-97c8-4b64-9d59-41e897a98298.tabs.0.elements.1.warning','null'),('globalSets.aa7c6968-88ec-4d2a-af47-d3c40b582a68.fieldLayouts.e1ad1c2a-97c8-4b64-9d59-41e897a98298.tabs.0.elements.1.width','100'),('globalSets.aa7c6968-88ec-4d2a-af47-d3c40b582a68.fieldLayouts.e1ad1c2a-97c8-4b64-9d59-41e897a98298.tabs.0.name','\"Default\"'),('globalSets.aa7c6968-88ec-4d2a-af47-d3c40b582a68.fieldLayouts.e1ad1c2a-97c8-4b64-9d59-41e897a98298.tabs.0.sortOrder','1'),('globalSets.aa7c6968-88ec-4d2a-af47-d3c40b582a68.handle','\"globals\"'),('globalSets.aa7c6968-88ec-4d2a-af47-d3c40b582a68.name','\"Globals\"'),('globalSets.aa7c6968-88ec-4d2a-af47-d3c40b582a68.sortOrder','2'),('graphql.publicToken.enabled','false'),('graphql.publicToken.expiryDate','null'),('graphql.schemas.6005c2f9-5d85-4442-b712-22e070096ac8.isPublic','true'),('graphql.schemas.6005c2f9-5d85-4442-b712-22e070096ac8.name','\"Public Schema\"'),('meta.__names__.110568c4-6978-4a9d-ae96-44c45c0739c1','\"New\"'),('meta.__names__.21903cb2-5b82-49ea-9766-e120d0951ea3','\"Plain Text\"'),('meta.__names__.3ac44e69-f6b1-48f7-a9a6-f4cf14261b16','\"Some Images\"'),('meta.__names__.3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5','\"Optimized Images\"'),('meta.__names__.407fe253-2ada-4a88-b1a4-fb6c2004cd9b','\"Clothing\"'),('meta.__names__.4a0cb371-14a6-415d-84db-fc0512410ec8','\"SEO\"'),('meta.__names__.54e60257-f31a-44aa-960e-bbd364197e28','\"Homepage\"'),('meta.__names__.550b07f1-ec7b-4dfa-8dd6-373f9f2b6598','\"Default\"'),('meta.__names__.5c642d7e-b16b-4836-9575-668d75d242e5','\"Site\"'),('meta.__names__.5da841b1-ca0d-46ff-8bb1-04d6c889ac54','\"English\"'),('meta.__names__.6005c2f9-5d85-4442-b712-22e070096ac8','\"Public Schema\"'),('meta.__names__.626b0987-e067-4dd2-9918-1d209373265a','\"Review\"'),('meta.__names__.6a117ef0-054c-4147-acb6-6fe57d48c4ae','\"Dummy\"'),('meta.__names__.94b4d5ac-d7ea-4241-a6cb-92b39f482f99','\"Common\"'),('meta.__names__.a0587a0b-d71c-4085-9c28-f0165af2b925','\"Contact Form\"'),('meta.__names__.aa7c6968-88ec-4d2a-af47-d3c40b582a68','\"Globals\"'),('meta.__names__.abcda4a4-b1db-4677-b5d6-69588443704f','\"Rich Text\"'),('meta.__names__.b8fd3909-9af1-42c4-8c5e-2716a2a1957e','\"Category\"'),('meta.__names__.c4536798-743d-4bf0-9669-192827bfb26c','\"Blog\"'),('meta.__names__.de308a7d-1794-448f-9176-29e2eace7ecf','\"Blog\"'),('meta.__names__.ec473f07-152f-423b-90df-ac425e6068a1','\"Spanish\"'),('meta.__names__.f89601e9-4ba9-4a48-9e99-350aa9914912','\"plugindev\"'),('meta.__names__.f923795f-139e-4b59-b27c-eaa0be4f847c','\"New\"'),('meta.__names__.fb3a8f31-d1cc-4c13-903b-a501f7e51f54','\"Homepage\"'),('plugins.calendar.edition','\"lite\"'),('plugins.calendar.enabled','true'),('plugins.calendar.licenseKey','\"EUPZ9IW6YJVW049EJSQW6K4V\"'),('plugins.calendar.schemaVersion','\"3.3.2\"'),('plugins.commerce.edition','\"lite\"'),('plugins.commerce.enabled','true'),('plugins.commerce.licenseKey','\"J2NBXBI5X4R7LD6QH69N51OY\"'),('plugins.commerce.schemaVersion','\"3.4.12\"'),('plugins.connect.edition','\"standard\"'),('plugins.connect.enabled','true'),('plugins.connect.schemaVersion','\"1.0.0\"'),('plugins.cookies.edition','\"standard\"'),('plugins.cookies.enabled','true'),('plugins.cookies.schemaVersion','\"1.0.0\"'),('plugins.digital-products.edition','\"standard\"'),('plugins.digital-products.enabled','true'),('plugins.digital-products.schemaVersion','\"2.1.0\"'),('plugins.disqus.edition','\"standard\"'),('plugins.disqus.enabled','true'),('plugins.disqus.schemaVersion','\"1.0.0\"'),('plugins.eager-beaver.edition','\"standard\"'),('plugins.eager-beaver.enabled','true'),('plugins.eager-beaver.schemaVersion','\"1.0.0\"'),('plugins.empty-coalesce.edition','\"standard\"'),('plugins.empty-coalesce.enabled','true'),('plugins.empty-coalesce.schemaVersion','\"1.0.0\"'),('plugins.fastcgi-cache-bust.edition','\"standard\"'),('plugins.fastcgi-cache-bust.enabled','true'),('plugins.fastcgi-cache-bust.schemaVersion','\"1.0.0\"'),('plugins.icalendar.edition','\"standard\"'),('plugins.icalendar.enabled','true'),('plugins.icalendar.schemaVersion','\"1.0.0\"'),('plugins.image-optimize.edition','\"standard\"'),('plugins.image-optimize.enabled','true'),('plugins.image-optimize.licenseKey','\"HYZ5UZV03GNJM5VK9QNV9SEX\"'),('plugins.image-optimize.schemaVersion','\"1.0.0\"'),('plugins.image-optimize.settings.allowUpScaledImageVariants','false'),('plugins.image-optimize.settings.assetVolumeSubFolders','true'),('plugins.image-optimize.settings.autoSharpenScaledImages','true'),('plugins.image-optimize.settings.createColorPalette','true'),('plugins.image-optimize.settings.createPlaceholderSilhouettes','true'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.0.0','\"nystudio107\\\\imageoptimizeimgix\\\\imagetransforms\\\\ImgixImageTransform\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.0.1.__assoc__.0.0','\"domain\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.0.1.__assoc__.0.1','\"\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.0.1.__assoc__.1.0','\"apiKey\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.0.1.__assoc__.1.1','\"\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.0.1.__assoc__.2.0','\"securityToken\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.0.1.__assoc__.2.1','\"\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.0.1.__assoc__.3.0','\"unsharpMask\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.0.1.__assoc__.3.1','\"20\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.1.0','\"nystudio107\\\\imageoptimizesharp\\\\imagetransforms\\\\SharpImageTransform\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.1.1.__assoc__.0.0','\"baseUrl\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.1.1.__assoc__.0.1','\"\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.2.0','\"nystudio107\\\\imageoptimizethumbor\\\\imagetransforms\\\\ThumborImageTransform\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.2.1.__assoc__.0.0','\"baseUrl\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.2.1.__assoc__.0.1','\"\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.2.1.__assoc__.1.0','\"securityKey\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.2.1.__assoc__.1.1','\"\"'),('plugins.image-optimize.settings.lowerQualityRetinaImageVariants','true'),('plugins.image-optimize.settings.sharpenScaledImagePercentage','50'),('plugins.image-optimize.settings.transformClass','\"nystudio107\\\\imageoptimize\\\\imagetransforms\\\\CraftImageTransform\"'),('plugins.instant-analytics.edition','\"standard\"'),('plugins.instant-analytics.enabled','true'),('plugins.instant-analytics.licenseKey','\"M7PU5DVTK7247SS1V3DVBVL3\"'),('plugins.instant-analytics.schemaVersion','\"1.0.0\"'),('plugins.minify.edition','\"standard\"'),('plugins.minify.enabled','true'),('plugins.minify.schemaVersion','\"1.0.0\"'),('plugins.path-tools.edition','\"standard\"'),('plugins.path-tools.enabled','true'),('plugins.path-tools.schemaVersion','\"1.0.0\"'),('plugins.recipe.edition','\"standard\"'),('plugins.recipe.enabled','true'),('plugins.recipe.schemaVersion','\"1.0.0\"'),('plugins.redactor.edition','\"standard\"'),('plugins.redactor.enabled','true'),('plugins.redactor.schemaVersion','\"2.3.0\"'),('plugins.retour.edition','\"standard\"'),('plugins.retour.enabled','true'),('plugins.retour.licenseKey','\"4LL2ODYFR0QG87WCCW3XYYFQ\"'),('plugins.retour.schemaVersion','\"3.0.10\"'),('plugins.retour.settings.additionalHeaders','\"\"'),('plugins.retour.settings.alwaysStripQueryString','false'),('plugins.retour.settings.automaticallyTrimStatistics','\"1\"'),('plugins.retour.settings.createUriChangeRedirects','true'),('plugins.retour.settings.dynamicRedirectDisplayLimit','100'),('plugins.retour.settings.enableApiEndpoint','\"\"'),('plugins.retour.settings.excludePatterns','\"\"'),('plugins.retour.settings.pluginName','\"Retour\"'),('plugins.retour.settings.preserveQueryString','false'),('plugins.retour.settings.recordRemoteIp','true'),('plugins.retour.settings.refreshIntervalSecs','5'),('plugins.retour.settings.staticRedirectDisplayLimit','100'),('plugins.retour.settings.statisticsRateLimitMs','\"3600000\"'),('plugins.retour.settings.statsDisplayLimit','1000'),('plugins.retour.settings.statsStoredLimit','1000'),('plugins.retour.settings.stripQueryStringFromStats','false'),('plugins.retour.settings.uriChangeRedirectSrcMatch','\"pathonly\"'),('plugins.rich-variables.edition','\"standard\"'),('plugins.rich-variables.enabled','true'),('plugins.rich-variables.licenseKey','\"XCDGZ4TWFI5W87892QH9WX6T\"'),('plugins.rich-variables.schemaVersion','\"1.0.0\"'),('plugins.route-map.edition','\"standard\"'),('plugins.route-map.enabled','true'),('plugins.route-map.schemaVersion','\"1.0.0\"'),('plugins.seomatic.edition','\"standard\"'),('plugins.seomatic.enabled','true'),('plugins.seomatic.licenseKey','\"ZTMAKHNCRNLVSBCTDHIJUPQW\"'),('plugins.seomatic.schemaVersion','\"3.0.11\"'),('plugins.similar.edition','\"standard\"'),('plugins.similar.enabled','true'),('plugins.similar.schemaVersion','\"1.0.0\"'),('plugins.templatecomments.edition','\"standard\"'),('plugins.templatecomments.enabled','true'),('plugins.templatecomments.schemaVersion','\"1.0.0\"'),('plugins.transcoder.edition','\"standard\"'),('plugins.transcoder.enabled','true'),('plugins.transcoder.licenseKey','\"MCJR0325X9EMZYDAHCDXHP8R\"'),('plugins.transcoder.schemaVersion','\"1.0.0\"'),('plugins.twig-profiler.edition','\"standard\"'),('plugins.twig-profiler.enabled','true'),('plugins.twig-profiler.schemaVersion','\"1.0.0\"'),('plugins.twigpack.edition','\"standard\"'),('plugins.twigpack.enabled','true'),('plugins.twigpack.schemaVersion','\"1.0.0\"'),('plugins.typogrify.edition','\"standard\"'),('plugins.typogrify.enabled','true'),('plugins.typogrify.schemaVersion','\"1.0.0\"'),('plugins.units.edition','\"standard\"'),('plugins.units.enabled','true'),('plugins.units.schemaVersion','\"1.0.0\"'),('plugins.vanillaforums.edition','\"standard\"'),('plugins.vanillaforums.enabled','true'),('plugins.vanillaforums.schemaVersion','\"1.0.0\"'),('plugins.vite.edition','\"standard\"'),('plugins.vite.enabled','true'),('plugins.vite.schemaVersion','\"1.0.0\"'),('plugins.webperf.edition','\"standard\"'),('plugins.webperf.enabled','true'),('plugins.webperf.licenseKey','\"SP5V7EIW3GYBJR4R20D30Q0I\"'),('plugins.webperf.schemaVersion','\"1.0.1\"'),('plugins.youtubeliveembed.edition','\"standard\"'),('plugins.youtubeliveembed.enabled','true'),('plugins.youtubeliveembed.schemaVersion','\"1.0.0\"'),('sections.54e60257-f31a-44aa-960e-bbd364197e28.defaultPlacement','\"end\"'),('sections.54e60257-f31a-44aa-960e-bbd364197e28.enableVersioning','false'),('sections.54e60257-f31a-44aa-960e-bbd364197e28.handle','\"homepage\"'),('sections.54e60257-f31a-44aa-960e-bbd364197e28.name','\"Homepage\"'),('sections.54e60257-f31a-44aa-960e-bbd364197e28.previewTargets.0.__assoc__.0.0','\"label\"'),('sections.54e60257-f31a-44aa-960e-bbd364197e28.previewTargets.0.__assoc__.0.1','\"Entry\"'),('sections.54e60257-f31a-44aa-960e-bbd364197e28.previewTargets.0.__assoc__.1.0','\"urlFormat\"'),('sections.54e60257-f31a-44aa-960e-bbd364197e28.previewTargets.0.__assoc__.1.1','\"/\"'),('sections.54e60257-f31a-44aa-960e-bbd364197e28.previewTargets.0.__assoc__.2.0','\"refresh\"'),('sections.54e60257-f31a-44aa-960e-bbd364197e28.previewTargets.0.__assoc__.2.1','\"1\"'),('sections.54e60257-f31a-44aa-960e-bbd364197e28.propagationMethod','\"all\"'),('sections.54e60257-f31a-44aa-960e-bbd364197e28.siteSettings.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.enabledByDefault','true'),('sections.54e60257-f31a-44aa-960e-bbd364197e28.siteSettings.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.hasUrls','true'),('sections.54e60257-f31a-44aa-960e-bbd364197e28.siteSettings.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.template','\"index\"'),('sections.54e60257-f31a-44aa-960e-bbd364197e28.siteSettings.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.uriFormat','\"__home__\"'),('sections.54e60257-f31a-44aa-960e-bbd364197e28.siteSettings.ec473f07-152f-423b-90df-ac425e6068a1.enabledByDefault','true'),('sections.54e60257-f31a-44aa-960e-bbd364197e28.siteSettings.ec473f07-152f-423b-90df-ac425e6068a1.hasUrls','true'),('sections.54e60257-f31a-44aa-960e-bbd364197e28.siteSettings.ec473f07-152f-423b-90df-ac425e6068a1.template','\"index\"'),('sections.54e60257-f31a-44aa-960e-bbd364197e28.siteSettings.ec473f07-152f-423b-90df-ac425e6068a1.uriFormat','\"__home__\"'),('sections.54e60257-f31a-44aa-960e-bbd364197e28.type','\"single\"'),('sections.de308a7d-1794-448f-9176-29e2eace7ecf.defaultPlacement','\"end\"'),('sections.de308a7d-1794-448f-9176-29e2eace7ecf.enableVersioning','true'),('sections.de308a7d-1794-448f-9176-29e2eace7ecf.handle','\"blog\"'),('sections.de308a7d-1794-448f-9176-29e2eace7ecf.name','\"Blog\"'),('sections.de308a7d-1794-448f-9176-29e2eace7ecf.previewTargets.0.__assoc__.0.0','\"label\"'),('sections.de308a7d-1794-448f-9176-29e2eace7ecf.previewTargets.0.__assoc__.0.1','\"Primary entry page\"'),('sections.de308a7d-1794-448f-9176-29e2eace7ecf.previewTargets.0.__assoc__.1.0','\"urlFormat\"'),('sections.de308a7d-1794-448f-9176-29e2eace7ecf.previewTargets.0.__assoc__.1.1','\"{url}\"'),('sections.de308a7d-1794-448f-9176-29e2eace7ecf.previewTargets.0.__assoc__.2.0','\"refresh\"'),('sections.de308a7d-1794-448f-9176-29e2eace7ecf.previewTargets.0.__assoc__.2.1','\"1\"'),('sections.de308a7d-1794-448f-9176-29e2eace7ecf.propagationMethod','\"all\"'),('sections.de308a7d-1794-448f-9176-29e2eace7ecf.siteSettings.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.enabledByDefault','true'),('sections.de308a7d-1794-448f-9176-29e2eace7ecf.siteSettings.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.hasUrls','true'),('sections.de308a7d-1794-448f-9176-29e2eace7ecf.siteSettings.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.template','\"blog/_entry\"'),('sections.de308a7d-1794-448f-9176-29e2eace7ecf.siteSettings.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.uriFormat','\"blog/{slug}\"'),('sections.de308a7d-1794-448f-9176-29e2eace7ecf.siteSettings.ec473f07-152f-423b-90df-ac425e6068a1.enabledByDefault','true'),('sections.de308a7d-1794-448f-9176-29e2eace7ecf.siteSettings.ec473f07-152f-423b-90df-ac425e6068a1.hasUrls','true'),('sections.de308a7d-1794-448f-9176-29e2eace7ecf.siteSettings.ec473f07-152f-423b-90df-ac425e6068a1.template','\"blog/_entry\"'),('sections.de308a7d-1794-448f-9176-29e2eace7ecf.siteSettings.ec473f07-152f-423b-90df-ac425e6068a1.uriFormat','\"blog/{slug}\"'),('sections.de308a7d-1794-448f-9176-29e2eace7ecf.type','\"channel\"'),('siteGroups.f89601e9-4ba9-4a48-9e99-350aa9914912.name','\"plugindev\"'),('sites.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.baseUrl','\"@web/\"'),('sites.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.enabled','true'),('sites.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.handle','\"default\"'),('sites.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.hasUrls','true'),('sites.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.language','\"en-US\"'),('sites.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.name','\"English\"'),('sites.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.primary','true'),('sites.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.siteGroup','\"f89601e9-4ba9-4a48-9e99-350aa9914912\"'),('sites.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.sortOrder','1'),('sites.ec473f07-152f-423b-90df-ac425e6068a1.baseUrl','\"@web/es\"'),('sites.ec473f07-152f-423b-90df-ac425e6068a1.enabled','true'),('sites.ec473f07-152f-423b-90df-ac425e6068a1.handle','\"spanish\"'),('sites.ec473f07-152f-423b-90df-ac425e6068a1.hasUrls','true'),('sites.ec473f07-152f-423b-90df-ac425e6068a1.language','\"es\"'),('sites.ec473f07-152f-423b-90df-ac425e6068a1.name','\"Spanish\"'),('sites.ec473f07-152f-423b-90df-ac425e6068a1.primary','false'),('sites.ec473f07-152f-423b-90df-ac425e6068a1.siteGroup','\"f89601e9-4ba9-4a48-9e99-350aa9914912\"'),('sites.ec473f07-152f-423b-90df-ac425e6068a1.sortOrder','2'),('solspace.calendar.calendars.550b07f1-ec7b-4dfa-8dd6-373f9f2b6598.allowRepeatingEvents','true'),('solspace.calendar.calendars.550b07f1-ec7b-4dfa-8dd6-373f9f2b6598.color','\"#9E31C4\"'),('solspace.calendar.calendars.550b07f1-ec7b-4dfa-8dd6-373f9f2b6598.description','\"The default calendar\"'),('solspace.calendar.calendars.550b07f1-ec7b-4dfa-8dd6-373f9f2b6598.descriptionFieldHandle','null'),('solspace.calendar.calendars.550b07f1-ec7b-4dfa-8dd6-373f9f2b6598.fieldLayout','null'),('solspace.calendar.calendars.550b07f1-ec7b-4dfa-8dd6-373f9f2b6598.handle','\"default\"'),('solspace.calendar.calendars.550b07f1-ec7b-4dfa-8dd6-373f9f2b6598.hasTitleField','true'),('solspace.calendar.calendars.550b07f1-ec7b-4dfa-8dd6-373f9f2b6598.icsHash','null'),('solspace.calendar.calendars.550b07f1-ec7b-4dfa-8dd6-373f9f2b6598.icsTimezone','\"floating\"'),('solspace.calendar.calendars.550b07f1-ec7b-4dfa-8dd6-373f9f2b6598.locationFieldHandle','null'),('solspace.calendar.calendars.550b07f1-ec7b-4dfa-8dd6-373f9f2b6598.name','\"Default\"'),('solspace.calendar.calendars.550b07f1-ec7b-4dfa-8dd6-373f9f2b6598.siteSettings.815c4fd2-6502-4d25-8605-4d74668e8b0d.enabledByDefault','true'),('solspace.calendar.calendars.550b07f1-ec7b-4dfa-8dd6-373f9f2b6598.siteSettings.815c4fd2-6502-4d25-8605-4d74668e8b0d.hasUrls','false'),('solspace.calendar.calendars.550b07f1-ec7b-4dfa-8dd6-373f9f2b6598.siteSettings.815c4fd2-6502-4d25-8605-4d74668e8b0d.siteId','\"ec473f07-152f-423b-90df-ac425e6068a1\"'),('solspace.calendar.calendars.550b07f1-ec7b-4dfa-8dd6-373f9f2b6598.siteSettings.815c4fd2-6502-4d25-8605-4d74668e8b0d.template','null'),('solspace.calendar.calendars.550b07f1-ec7b-4dfa-8dd6-373f9f2b6598.siteSettings.815c4fd2-6502-4d25-8605-4d74668e8b0d.uriFormat','null'),('solspace.calendar.calendars.550b07f1-ec7b-4dfa-8dd6-373f9f2b6598.siteSettings.aae92448-744c-47d9-9847-843c19e64d1b.enabledByDefault','true'),('solspace.calendar.calendars.550b07f1-ec7b-4dfa-8dd6-373f9f2b6598.siteSettings.aae92448-744c-47d9-9847-843c19e64d1b.hasUrls','false'),('solspace.calendar.calendars.550b07f1-ec7b-4dfa-8dd6-373f9f2b6598.siteSettings.aae92448-744c-47d9-9847-843c19e64d1b.siteId','\"5da841b1-ca0d-46ff-8bb1-04d6c889ac54\"'),('solspace.calendar.calendars.550b07f1-ec7b-4dfa-8dd6-373f9f2b6598.siteSettings.aae92448-744c-47d9-9847-843c19e64d1b.template','null'),('solspace.calendar.calendars.550b07f1-ec7b-4dfa-8dd6-373f9f2b6598.siteSettings.aae92448-744c-47d9-9847-843c19e64d1b.uriFormat','null'),('solspace.calendar.calendars.550b07f1-ec7b-4dfa-8dd6-373f9f2b6598.titleFormat','null'),('solspace.calendar.calendars.550b07f1-ec7b-4dfa-8dd6-373f9f2b6598.titleLabel','\"Title\"'),('system.edition','\"pro\"'),('system.live','true'),('system.name','\"plugindev\"'),('system.retryDuration','60'),('system.schemaVersion','\"3.7.33\"'),('system.timeZone','\"America/New_York\"'),('users.allowPublicRegistration','false'),('users.defaultGroup','null'),('users.photoSubpath','\"\"'),('users.photoVolumeUid','null'),('users.requireEmailVerification','true'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.fieldLayouts.e73b4186-2fad-4c0f-8eae-bbb884932c58.tabs.0.elements.0.autocapitalize','true'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.fieldLayouts.e73b4186-2fad-4c0f-8eae-bbb884932c58.tabs.0.elements.0.autocomplete','false'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.fieldLayouts.e73b4186-2fad-4c0f-8eae-bbb884932c58.tabs.0.elements.0.autocorrect','true'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.fieldLayouts.e73b4186-2fad-4c0f-8eae-bbb884932c58.tabs.0.elements.0.class','null'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.fieldLayouts.e73b4186-2fad-4c0f-8eae-bbb884932c58.tabs.0.elements.0.disabled','false'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.fieldLayouts.e73b4186-2fad-4c0f-8eae-bbb884932c58.tabs.0.elements.0.id','null'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.fieldLayouts.e73b4186-2fad-4c0f-8eae-bbb884932c58.tabs.0.elements.0.instructions','null'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.fieldLayouts.e73b4186-2fad-4c0f-8eae-bbb884932c58.tabs.0.elements.0.label','null'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.fieldLayouts.e73b4186-2fad-4c0f-8eae-bbb884932c58.tabs.0.elements.0.max','null'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.fieldLayouts.e73b4186-2fad-4c0f-8eae-bbb884932c58.tabs.0.elements.0.min','null'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.fieldLayouts.e73b4186-2fad-4c0f-8eae-bbb884932c58.tabs.0.elements.0.name','null'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.fieldLayouts.e73b4186-2fad-4c0f-8eae-bbb884932c58.tabs.0.elements.0.orientation','null'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.fieldLayouts.e73b4186-2fad-4c0f-8eae-bbb884932c58.tabs.0.elements.0.placeholder','null'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.fieldLayouts.e73b4186-2fad-4c0f-8eae-bbb884932c58.tabs.0.elements.0.readonly','false'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.fieldLayouts.e73b4186-2fad-4c0f-8eae-bbb884932c58.tabs.0.elements.0.requirable','false'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.fieldLayouts.e73b4186-2fad-4c0f-8eae-bbb884932c58.tabs.0.elements.0.size','null'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.fieldLayouts.e73b4186-2fad-4c0f-8eae-bbb884932c58.tabs.0.elements.0.step','null'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.fieldLayouts.e73b4186-2fad-4c0f-8eae-bbb884932c58.tabs.0.elements.0.tip','null'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.fieldLayouts.e73b4186-2fad-4c0f-8eae-bbb884932c58.tabs.0.elements.0.title','null'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.fieldLayouts.e73b4186-2fad-4c0f-8eae-bbb884932c58.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\AssetTitleField\"'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.fieldLayouts.e73b4186-2fad-4c0f-8eae-bbb884932c58.tabs.0.elements.0.warning','null'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.fieldLayouts.e73b4186-2fad-4c0f-8eae-bbb884932c58.tabs.0.elements.0.width','100'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.fieldLayouts.e73b4186-2fad-4c0f-8eae-bbb884932c58.tabs.0.elements.1.fieldUid','\"3fccd13a-e7e7-4d00-8505-0ba4cf0b9be5\"'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.fieldLayouts.e73b4186-2fad-4c0f-8eae-bbb884932c58.tabs.0.elements.1.instructions','null'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.fieldLayouts.e73b4186-2fad-4c0f-8eae-bbb884932c58.tabs.0.elements.1.label','null'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.fieldLayouts.e73b4186-2fad-4c0f-8eae-bbb884932c58.tabs.0.elements.1.required','false'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.fieldLayouts.e73b4186-2fad-4c0f-8eae-bbb884932c58.tabs.0.elements.1.tip','null'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.fieldLayouts.e73b4186-2fad-4c0f-8eae-bbb884932c58.tabs.0.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.fieldLayouts.e73b4186-2fad-4c0f-8eae-bbb884932c58.tabs.0.elements.1.warning','null'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.fieldLayouts.e73b4186-2fad-4c0f-8eae-bbb884932c58.tabs.0.elements.1.width','100'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.fieldLayouts.e73b4186-2fad-4c0f-8eae-bbb884932c58.tabs.0.elements.2.fieldUid','\"3ac44e69-f6b1-48f7-a9a6-f4cf14261b16\"'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.fieldLayouts.e73b4186-2fad-4c0f-8eae-bbb884932c58.tabs.0.elements.2.instructions','null'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.fieldLayouts.e73b4186-2fad-4c0f-8eae-bbb884932c58.tabs.0.elements.2.label','null'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.fieldLayouts.e73b4186-2fad-4c0f-8eae-bbb884932c58.tabs.0.elements.2.required','false'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.fieldLayouts.e73b4186-2fad-4c0f-8eae-bbb884932c58.tabs.0.elements.2.tip','null'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.fieldLayouts.e73b4186-2fad-4c0f-8eae-bbb884932c58.tabs.0.elements.2.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.fieldLayouts.e73b4186-2fad-4c0f-8eae-bbb884932c58.tabs.0.elements.2.warning','null'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.fieldLayouts.e73b4186-2fad-4c0f-8eae-bbb884932c58.tabs.0.elements.2.width','100'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.fieldLayouts.e73b4186-2fad-4c0f-8eae-bbb884932c58.tabs.0.name','\"Content\"'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.fieldLayouts.e73b4186-2fad-4c0f-8eae-bbb884932c58.tabs.0.sortOrder','1'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.handle','\"site\"'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.hasUrls','true'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.name','\"Site\"'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.settings.path','\"@webroot/assets/site\"'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.sortOrder','0'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.titleTranslationKeyFormat','null'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.titleTranslationMethod','\"site\"'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.type','\"craft\\\\volumes\\\\Local\"'),('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.url','\"@assetsUrl/assets/site\"');
/*!40000 ALTER TABLE `projectconfig` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `queue`
--

LOCK TABLES `queue` WRITE;
/*!40000 ALTER TABLE `queue` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `queue` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `relations`
--

LOCK TABLES `relations` WRITE;
/*!40000 ALTER TABLE `relations` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `relations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `retour_redirects`
--

LOCK TABLES `retour_redirects` WRITE;
/*!40000 ALTER TABLE `retour_redirects` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `retour_redirects` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `retour_static_redirects`
--

LOCK TABLES `retour_static_redirects` WRITE;
/*!40000 ALTER TABLE `retour_static_redirects` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `retour_static_redirects` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `retour_stats`
--

LOCK TABLES `retour_stats` WRITE;
/*!40000 ALTER TABLE `retour_stats` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `retour_stats` VALUES (1,'2020-03-27 13:32:33','2022-03-16 17:16:19','d51a6505-12b4-479c-8521-90eec927b370',1,'/favicon.ico','http://localhost:8003/','172.23.0.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36','Template not found: favicon.ico','/var/www/project/cms_v3/vendor/craftcms/cms/src/controllers/TemplatesController.php',94,12,'2022-03-16 17:16:19',0),(2,'2020-10-16 15:31:42','2020-10-16 15:31:42','32f201b5-aa6a-47cb-9167-8f4455303414',1,'/webperf/metrics/beacon','http://localhost:8000/','172.26.0.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36','Template not found: webperf/metrics/beacon','/var/www/project/cms/vendor/craftcms/cms/src/controllers/TemplatesController.php',92,1,'2020-10-16 15:31:42',0);
/*!40000 ALTER TABLE `retour_stats` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `revisions`
--

LOCK TABLES `revisions` WRITE;
/*!40000 ALTER TABLE `revisions` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `revisions` VALUES (1,17,1,1,''),(2,17,1,2,'');
/*!40000 ALTER TABLE `revisions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `searchindex`
--

LOCK TABLES `searchindex` WRITE;
/*!40000 ALTER TABLE `searchindex` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `searchindex` VALUES (1,'username',0,1,' admin '),(1,'firstname',0,1,''),(1,'lastname',0,1,''),(1,'fullname',0,1,''),(1,'email',0,1,' andrew nystudio107 com '),(1,'slug',0,1,''),(2,'slug',0,1,' homepage '),(2,'title',0,1,' homepage '),(2,'slug',0,2,' homepage '),(2,'title',0,2,' homepage '),(3,'slug',0,1,''),(17,'title',0,2,' my first blog '),(17,'slug',0,2,' my first blog '),(17,'slug',0,1,' my first blog '),(17,'title',0,1,' my first blog '),(19,'slug',0,2,''),(19,'slug',0,1,''),(21,'title',0,2,' puppies '),(21,'slug',0,2,' puppies '),(21,'slug',0,1,' puppies '),(21,'title',0,1,' puppies '),(22,'title',0,2,' kitties '),(22,'slug',0,2,' kitties '),(22,'slug',0,1,' kitties '),(22,'title',0,1,' kitties ');
/*!40000 ALTER TABLE `searchindex` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sections` VALUES (4,NULL,'Errors','errors','channel',0,'all','end',NULL,'2020-03-27 13:38:49','2020-03-27 13:38:49','2021-03-15 15:09:11','a72bfe0c-3389-4f9f-8ec1-ab318ec10b29'),(5,NULL,'Homepage','homepage','single',0,'all','end','[{\"label\":\"Entry\",\"urlFormat\":\"/\",\"refresh\":\"1\"}]','2020-03-27 13:38:49','2021-03-15 15:04:41',NULL,'54e60257-f31a-44aa-960e-bbd364197e28'),(6,NULL,'Blog','blog','channel',1,'all','end','[{\"label\":\"Primary entry page\",\"urlFormat\":\"{url}\",\"refresh\":\"1\"}]','2021-03-15 15:39:25','2021-03-15 15:39:25',NULL,'de308a7d-1794-448f-9176-29e2eace7ecf');
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sections_sites`
--

LOCK TABLES `sections_sites` WRITE;
/*!40000 ALTER TABLE `sections_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sections_sites` VALUES (1,4,1,0,NULL,NULL,1,'2020-03-27 13:38:49','2020-03-27 13:38:49','c343dc66-853c-45b7-bde8-93a71c6d7d5a'),(2,5,1,1,'__home__','index',1,'2020-03-27 13:38:49','2020-03-27 13:38:49','94d75213-7345-4ed4-9251-15f5d2f8a915'),(3,5,2,1,'__home__','index',1,'2021-03-15 15:04:41','2021-03-15 15:04:50','32282537-65b3-4b3d-911c-c34090f0d571'),(4,6,1,1,'blog/{slug}','blog/_entry',1,'2021-03-15 15:39:25','2021-03-15 15:39:25','f134ef0e-b422-449e-971f-5465a6c43bf5'),(5,6,2,1,'blog/{slug}','blog/_entry',1,'2021-03-15 15:39:25','2021-03-15 15:39:25','641ed1e3-0154-4912-bb57-a2d3a179842d');
/*!40000 ALTER TABLE `sections_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `seomatic_metabundles`
--

LOCK TABLES `seomatic_metabundles` WRITE;
/*!40000 ALTER TABLE `seomatic_metabundles` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `seomatic_metabundles` VALUES (1,'2020-03-27 13:29:52','2022-03-16 17:31:00','54bcfb25-90fc-40ce-8a49-7ff73bee5bd6','1.0.59','__GLOBAL_BUNDLE__',1,'__GLOBAL_BUNDLE__','__GLOBAL_BUNDLE__','__GLOBAL_BUNDLE__',NULL,'',1,'[]','2022-03-16 17:31:00','{\"language\":null,\"mainEntityOfPage\":\"WebSite\",\"seoTitle\":\"\",\"siteNamePosition\":\"before\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{seomatic.helper.safeCanonicalUrl()}\",\"robots\":\"all\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"none\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"ogImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"none\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"twitterImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"inherited\":[],\"overrides\":[]}','{\"siteName\":\"Project\",\"identity\":{\"siteType\":\"Organization\",\"siteSubType\":\"LocalBusiness\",\"siteSpecificType\":\"\",\"computedType\":\"Organization\",\"genericName\":\"\",\"genericAlternateName\":\"\",\"genericDescription\":\"\",\"genericUrl\":\"\",\"genericImage\":\"\",\"genericImageWidth\":\"\",\"genericImageHeight\":\"\",\"genericImageIds\":[],\"genericTelephone\":\"\",\"genericEmail\":\"\",\"genericStreetAddress\":\"\",\"genericAddressLocality\":\"\",\"genericAddressRegion\":\"\",\"genericPostalCode\":\"\",\"genericAddressCountry\":\"\",\"genericGeoLatitude\":\"\",\"genericGeoLongitude\":\"\",\"personGender\":\"\",\"personBirthPlace\":\"\",\"organizationDuns\":\"\",\"organizationFounder\":\"\",\"organizationFoundingDate\":\"\",\"organizationFoundingLocation\":\"\",\"organizationContactPoints\":[],\"corporationTickerSymbol\":\"\",\"localBusinessPriceRange\":\"\",\"localBusinessOpeningHours\":[],\"restaurantServesCuisine\":\"\",\"restaurantMenuUrl\":\"\",\"restaurantReservationsUrl\":\"\"},\"creator\":{\"siteType\":\"Organization\",\"siteSubType\":\"\",\"siteSpecificType\":\"\",\"computedType\":\"Organization\",\"genericName\":\"nystudio107\",\"genericAlternateName\":\"nys\",\"genericDescription\":\"We do technology-based consulting, branding, design, and development. Making the web better one site at a time, with a focus on performance, usability & SEO\",\"genericUrl\":\"https://nystudio107.com/\",\"genericImage\":\"https://nystudio107-ems2qegf7x6qiqq.netdna-ssl.com/img/site/nys_logo_seo.png\",\"genericImageWidth\":\"1042\",\"genericImageHeight\":\"1042\",\"genericImageIds\":[],\"genericTelephone\":\"\",\"genericEmail\":\"info@nystudio107.com\",\"genericStreetAddress\":\"\",\"genericAddressLocality\":\"Webster\",\"genericAddressRegion\":\"NY\",\"genericPostalCode\":\"14580\",\"genericAddressCountry\":\"US\",\"genericGeoLatitude\":\"43.2365384\",\"genericGeoLongitude\":\"-77.49211620000001\",\"personGender\":\"\",\"personBirthPlace\":\"\",\"organizationDuns\":\"\",\"organizationFounder\":\"Andrew Welch, Polly Welch\",\"organizationFoundingDate\":\"2013-05-02\",\"organizationFoundingLocation\":\"Webster, NY\",\"organizationContactPoints\":[],\"corporationTickerSymbol\":\"\",\"localBusinessPriceRange\":\"\",\"localBusinessOpeningHours\":[],\"restaurantServesCuisine\":\"\",\"restaurantMenuUrl\":\"\",\"restaurantReservationsUrl\":\"\"},\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"facebookSiteVerification\":\"\",\"sameAsLinks\":{\"twitter\":{\"siteName\":\"Twitter\",\"handle\":\"twitter\",\"url\":\"\"},\"facebook\":{\"siteName\":\"Facebook\",\"handle\":\"facebook\",\"url\":\"\"},\"wikipedia\":{\"siteName\":\"Wikipedia\",\"handle\":\"wikipedia\",\"url\":\"\"},\"linkedin\":{\"siteName\":\"LinkedIn\",\"handle\":\"linkedin\",\"url\":\"\"},\"googleplus\":{\"siteName\":\"Google+\",\"handle\":\"googleplus\",\"url\":\"\"},\"youtube\":{\"siteName\":\"YouTube\",\"handle\":\"youtube\",\"url\":\"\"},\"instagram\":{\"siteName\":\"Instagram\",\"handle\":\"instagram\",\"url\":\"\"},\"pinterest\":{\"siteName\":\"Pinterest\",\"handle\":\"pinterest\",\"url\":\"\"},\"github\":{\"siteName\":\"GitHub\",\"handle\":\"github\",\"url\":\"\"},\"vimeo\":{\"siteName\":\"Vimeo\",\"handle\":\"vimeo\",\"url\":\"\"}},\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}],\"inherited\":[],\"overrides\":[]}','{\"MetaTagContainergeneral\":{\"data\":{\"generator\":{\"charset\":\"\",\"content\":\"SEOmatic\",\"httpEquiv\":\"\",\"name\":\"generator\",\"property\":null,\"include\":true,\"key\":\"generator\",\"environment\":null,\"dependencies\":{\"config\":[\"generatorEnabled\"]},\"tagAttrs\":[]},\"keywords\":{\"charset\":\"\",\"content\":\"{seomatic.meta.seoKeywords}\",\"httpEquiv\":\"\",\"name\":\"keywords\",\"property\":null,\"include\":true,\"key\":\"keywords\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"description\":{\"charset\":\"\",\"content\":\"{seomatic.meta.seoDescription}\",\"httpEquiv\":\"\",\"name\":\"description\",\"property\":null,\"include\":true,\"key\":\"description\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"referrer\":{\"charset\":\"\",\"content\":\"{seomatic.site.referrer}\",\"httpEquiv\":\"\",\"name\":\"referrer\",\"property\":null,\"include\":true,\"key\":\"referrer\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"robots\":{\"charset\":\"\",\"content\":\"{seomatic.meta.robots}\",\"httpEquiv\":\"\",\"name\":\"robots\",\"property\":null,\"include\":true,\"key\":\"robots\",\"environment\":{\"live\":{\"content\":\"{seomatic.meta.robots}\"},\"staging\":{\"content\":\"none\"},\"local\":{\"content\":\"none\"}},\"dependencies\":null,\"tagAttrs\":[]}},\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":{\"fb:profile_id\":{\"charset\":\"\",\"content\":\"{seomatic.site.facebookProfileId}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"fb:profile_id\",\"include\":true,\"key\":\"fb:profile_id\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"fb:app_id\":{\"charset\":\"\",\"content\":\"{seomatic.site.facebookAppId}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"fb:app_id\",\"include\":true,\"key\":\"fb:app_id\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:locale\":{\"charset\":\"\",\"content\":\"{{ craft.app.language |replace({\\\"-\\\": \\\"_\\\"}) }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:locale\",\"include\":true,\"key\":\"og:locale\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:locale:alternate\":{\"charset\":\"\",\"content\":\"\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:locale:alternate\",\"include\":true,\"key\":\"og:locale:alternate\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:site_name\":{\"charset\":\"\",\"content\":\"{seomatic.site.siteName}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:site_name\",\"include\":true,\"key\":\"og:site_name\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:type\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogType}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:type\",\"include\":true,\"key\":\"og:type\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:url\":{\"charset\":\"\",\"content\":\"{seomatic.meta.canonicalUrl}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:url\",\"include\":true,\"key\":\"og:url\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:title\":{\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.ogSiteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"charset\":\"\",\"content\":\"{seomatic.meta.ogTitle}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:title\",\"include\":true,\"key\":\"og:title\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:description\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogDescription}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:description\",\"include\":true,\"key\":\"og:description\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:image\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImage}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image\",\"include\":true,\"key\":\"og:image\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:image:width\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImageWidth}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:width\",\"include\":true,\"key\":\"og:image:width\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]},\"tagAttrs\":[]},\"og:image:height\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImageHeight}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:height\",\"include\":true,\"key\":\"og:image:height\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]},\"tagAttrs\":[]},\"og:image:alt\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImageDescription}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:alt\",\"include\":true,\"key\":\"og:image:alt\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]},\"tagAttrs\":[]},\"og:see_also\":{\"charset\":\"\",\"content\":\"\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:see_also\",\"include\":true,\"key\":\"og:see_also\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"facebook-site-verification\":{\"charset\":\"\",\"content\":\"{seomatic.site.facebookSiteVerification}\",\"httpEquiv\":\"\",\"name\":\"facebook-domain-verification\",\"property\":null,\"include\":true,\"key\":\"facebook-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"facebookSiteVerification\"]},\"tagAttrs\":[]}},\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":{\"twitter:card\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterCard}\",\"httpEquiv\":\"\",\"name\":\"twitter:card\",\"property\":null,\"include\":true,\"key\":\"twitter:card\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"twitter:site\":{\"charset\":\"\",\"content\":\"@{seomatic.site.twitterHandle}\",\"httpEquiv\":\"\",\"name\":\"twitter:site\",\"property\":null,\"include\":true,\"key\":\"twitter:site\",\"environment\":null,\"dependencies\":{\"site\":[\"twitterHandle\"]},\"tagAttrs\":[]},\"twitter:creator\":{\"charset\":\"\",\"content\":\"@{seomatic.meta.twitterCreator}\",\"httpEquiv\":\"\",\"name\":\"twitter:creator\",\"property\":null,\"include\":true,\"key\":\"twitter:creator\",\"environment\":null,\"dependencies\":{\"meta\":[\"twitterCreator\"]},\"tagAttrs\":[]},\"twitter:title\":{\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.twitterSiteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"charset\":\"\",\"content\":\"{seomatic.meta.twitterTitle}\",\"httpEquiv\":\"\",\"name\":\"twitter:title\",\"property\":null,\"include\":true,\"key\":\"twitter:title\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"twitter:description\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterDescription}\",\"httpEquiv\":\"\",\"name\":\"twitter:description\",\"property\":null,\"include\":true,\"key\":\"twitter:description\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"twitter:image\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImage}\",\"httpEquiv\":\"\",\"name\":\"twitter:image\",\"property\":null,\"include\":true,\"key\":\"twitter:image\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"twitter:image:width\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImageWidth}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:width\",\"property\":null,\"include\":true,\"key\":\"twitter:image:width\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]},\"tagAttrs\":[]},\"twitter:image:height\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImageHeight}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:height\",\"property\":null,\"include\":true,\"key\":\"twitter:image:height\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]},\"tagAttrs\":[]},\"twitter:image:alt\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImageDescription}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:alt\",\"property\":null,\"include\":true,\"key\":\"twitter:image:alt\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]},\"tagAttrs\":[]}},\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":{\"site\":[\"twitterHandle\"]},\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":{\"google-site-verification\":{\"charset\":\"\",\"content\":\"{seomatic.site.googleSiteVerification}\",\"httpEquiv\":\"\",\"name\":\"google-site-verification\",\"property\":null,\"include\":true,\"key\":\"google-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"googleSiteVerification\"]},\"tagAttrs\":[]},\"bing-site-verification\":{\"charset\":\"\",\"content\":\"{seomatic.site.bingSiteVerification}\",\"httpEquiv\":\"\",\"name\":\"msvalidate.01\",\"property\":null,\"include\":true,\"key\":\"bing-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"bingSiteVerification\"]},\"tagAttrs\":[]},\"pinterest-site-verification\":{\"charset\":\"\",\"content\":\"{seomatic.site.pinterestSiteVerification}\",\"httpEquiv\":\"\",\"name\":\"p:domain_verify\",\"property\":null,\"include\":true,\"key\":\"pinterest-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"pinterestSiteVerification\"]},\"tagAttrs\":[]}},\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":{\"canonical\":{\"crossorigin\":\"\",\"href\":\"{seomatic.meta.canonicalUrl}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"canonical\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"canonical\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"home\":{\"crossorigin\":\"\",\"href\":\"{{ seomatic.helper.siteUrl(\\\"/\\\") }}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"home\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"home\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"author\":{\"crossorigin\":\"\",\"href\":\"{{ seomatic.helper.siteUrl(\\\"/humans.txt\\\") }}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"author\",\"sizes\":\"\",\"type\":\"text/plain\",\"include\":true,\"key\":\"author\",\"environment\":null,\"dependencies\":{\"frontend_template\":[\"humans\"]},\"tagAttrs\":[]},\"publisher\":{\"crossorigin\":\"\",\"href\":\"{seomatic.site.googlePublisherLink}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"publisher\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"publisher\",\"environment\":null,\"dependencies\":{\"site\":[\"googlePublisherLink\"]},\"tagAttrs\":[]}},\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":{\"gtag\":{\"name\":\"Google gtag.js\",\"description\":\"The global site tag (gtag.js) is a JavaScript tagging framework and API that allows you to send event data to AdWords, DoubleClick, and Google Analytics. Instead of having to manage multiple tags for different products, you can use gtag.js and more easily benefit from the latest tracking features and integrations as they become available. [Learn More](https://developers.google.com/gtagjs/)\",\"templatePath\":\"_frontend/scripts/gtagHead.twig\",\"templateString\":\"{% set gtagProperty = googleAnalyticsId.value ?? googleAdWordsId.value ?? dcFloodlightId.value ?? null %}\\n{% if gtagProperty %}\\nwindow.dataLayer = window.dataLayer || [{% if dataLayer is defined and dataLayer %}{{ dataLayer |json_encode() |raw }}{% endif %}];\\nfunction gtag(){dataLayer.push(arguments)};\\ngtag(\'js\', new Date());\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if googleAnalyticsId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'anonymize_ip\': #{ipAnonymization.value ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'link_attribution\': #{enhancedLinkAttribution.value ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'allow_display_features\': #{displayFeatures.value ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ googleAnalyticsId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% if googleAdWordsId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ googleAdWordsId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% if dcFloodlightId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ dcFloodlightId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/gtagBody.twig\",\"bodyTemplateString\":\"{% set gtagProperty = googleAnalyticsId.value ?? googleAdWordsId.value ?? dcFloodlightId.value ?? null %}\\n{% if gtagProperty %}\\n<script async src=\\\"{{ gtagScriptUrl.value }}?id={{ gtagProperty }}\\\"></script>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"googleAnalyticsId\":{\"title\":\"Google Analytics Tracking ID\",\"instructions\":\"Only enter the ID, e.g.: `UA-XXXXXX-XX`, not the entire script code. [Learn More](https://support.google.com/analytics/answer/1032385?hl=e)\",\"type\":\"string\",\"value\":\"\"},\"googleAdWordsId\":{\"title\":\"AdWords Conversion ID\",\"instructions\":\"Only enter the ID, e.g.: `AW-XXXXXXXX`, not the entire script code. [Learn More](https://developers.google.com/adwords-remarketing-tag/)\",\"type\":\"string\",\"value\":\"\"},\"dcFloodlightId\":{\"title\":\"DoubleClick Floodlight ID\",\"instructions\":\"Only enter the ID, e.g.: `DC-XXXXXXXX`, not the entire script code. [Learn More](https://support.google.com/dcm/partner/answer/7568534)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send PageView\",\"instructions\":\"Controls whether the `gtag.js` script automatically sends a PageView to Google Analytics, AdWords, and DoubleClick Floodlight when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"ipAnonymization\":{\"title\":\"Google Analytics IP Anonymization\",\"instructions\":\"In some cases, you might need to anonymize the IP addresses of hits sent to Google Analytics. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/ip-anonymization)\",\"type\":\"bool\",\"value\":false},\"displayFeatures\":{\"title\":\"Google Analytics Display Features\",\"instructions\":\"The display features plugin for gtag.js can be used to enable Advertising Features in Google Analytics, such as Remarketing, Demographics and Interest Reporting, and more. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/display-features)\",\"type\":\"bool\",\"value\":false},\"enhancedLinkAttribution\":{\"title\":\"Google Analytics Enhanced Link Attribution\",\"instructions\":\"Enhanced link attribution improves click track reporting by automatically differentiating between multiple link clicks that have the same URL on a given page. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/enhanced-link-attribution)\",\"type\":\"bool\",\"value\":false},\"gtagScriptUrl\":{\"title\":\"Google gtag.js Script URL\",\"instructions\":\"The URL to the Google gtag.js tracking script. Normally this should not be changed, unless you locally cache it. The JavaScript `dataLayer` will automatically be set to the `dataLayer` Twig template variable.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/gtag/js\"}},\"dataLayer\":[],\"include\":false,\"key\":\"gtag\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"googleTagManager\":{\"name\":\"Google Tag Manager\",\"description\":\"Google Tag Manager is a tag management system that allows you to quickly and easily update tags and code snippets on your website. Once the Tag Manager snippet has been added to your website or mobile app, you can configure tags via a web-based user interface without having to alter and deploy additional code. [Learn More](https://support.google.com/tagmanager/answer/6102821?hl=en)\",\"templatePath\":\"_frontend/scripts/googleTagManagerHead.twig\",\"templateString\":\"{% if googleTagManagerId.value is defined and googleTagManagerId.value and not seomatic.helper.isPreview %}\\n{{ dataLayerVariableName.value }} = [{% if dataLayer is defined and dataLayer %}{{ dataLayer |json_encode() |raw }}{% endif %}];\\n(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({\'gtm.start\':\\nnew Date().getTime(),event:\'gtm.js\'});var f=d.getElementsByTagName(s)[0],\\nj=d.createElement(s),dl=l!=\'dataLayer\'?\'&l=\'+l:\'\';j.async=true;j.src=\\n\'{{ googleTagManagerUrl.value }}?id=\'+i+dl;f.parentNode.insertBefore(j,f);\\n})(window,document,\'script\',\'{{ dataLayerVariableName.value }}\',\'{{ googleTagManagerId.value }}\');\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/googleTagManagerBody.twig\",\"bodyTemplateString\":\"{% if googleTagManagerId.value is defined and googleTagManagerId.value and not seomatic.helper.isPreview %}\\n<noscript><iframe src=\\\"{{ googleTagManagerNoScriptUrl.value }}?id={{ googleTagManagerId.value }}\\\"\\nheight=\\\"0\\\" width=\\\"0\\\" style=\\\"display:none;visibility:hidden\\\"></iframe></noscript>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"googleTagManagerId\":{\"title\":\"Google Tag Manager ID\",\"instructions\":\"Only enter the ID, e.g.: `GTM-XXXXXX`, not the entire script code. [Learn More](https://developers.google.com/tag-manager/quickstart)\",\"type\":\"string\",\"value\":\"\"},\"dataLayerVariableName\":{\"title\":\"DataLayer Variable Name\",\"instructions\":\"The name to use for the JavaScript DataLayer variable. The value of this variable will be set to the `dataLayer` Twig template variable.\",\"type\":\"string\",\"value\":\"dataLayer\"},\"googleTagManagerUrl\":{\"title\":\"Google Tag Manager Script URL\",\"instructions\":\"The URL to the Google Tag Manager script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/gtm.js\"},\"googleTagManagerNoScriptUrl\":{\"title\":\"Google Tag Manager Script &lt;noscript&gt; URL\",\"instructions\":\"The URL to the Google Tag Manager `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/ns.html\"}},\"dataLayer\":[],\"include\":false,\"key\":\"googleTagManager\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"facebookPixel\":{\"name\":\"Facebook Pixel\",\"description\":\"The Facebook pixel is an analytics tool that helps you measure the effectiveness of your advertising. You can use the Facebook pixel to understand the actions people are taking on your website and reach audiences you care about. [Learn More](https://www.facebook.com/business/help/651294705016616)\",\"templatePath\":\"_frontend/scripts/facebookPixelHead.twig\",\"templateString\":\"{% if facebookPixelId.value is defined and facebookPixelId.value %}\\n!function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?\\nn.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;\\nn.push=n;n.loaded=!0;n.version=\'2.0\';n.queue=[];t=b.createElement(e);t.async=!0;\\nt.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,\\ndocument,\'script\',\'{{ facebookPixelUrl.value }}\');\\nfbq(\'init\', \'{{ facebookPixelId.value }}\');\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if pageView %}\\nfbq(\'track\', \'PageView\');\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/facebookPixelBody.twig\",\"bodyTemplateString\":\"{% if facebookPixelId.value is defined and facebookPixelId.value %}\\n<noscript><img height=\\\"1\\\" width=\\\"1\\\" style=\\\"display:none\\\"\\nsrc=\\\"{{ facebookPixelNoScriptUrl.value }}?id={{ facebookPixelId.value }}&ev=PageView&noscript=1\\\" /></noscript>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"facebookPixelId\":{\"title\":\"Facebook Pixel ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://developers.facebook.com/docs/facebook-pixel/api-reference)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Facebook Pixel PageView\",\"instructions\":\"Controls whether the Facebook Pixel script automatically sends a PageView to Facebook Analytics when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"facebookPixelUrl\":{\"title\":\"Facebook Pixel Script URL\",\"instructions\":\"The URL to the Facebook Pixel script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://connect.facebook.net/en_US/fbevents.js\"},\"facebookPixelNoScriptUrl\":{\"title\":\"Facebook Pixel Script &lt;noscript&gt; URL\",\"instructions\":\"The URL to the Facebook Pixel `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.facebook.com/tr\"}},\"dataLayer\":[],\"include\":false,\"key\":\"facebookPixel\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"linkedInInsight\":{\"name\":\"LinkedIn Insight\",\"description\":\"The LinkedIn Insight Tag is a lightweight JavaScript tag that powers conversion tracking, retargeting, and web analytics for LinkedIn ad campaigns.\",\"templatePath\":\"_frontend/scripts/linkedInInsightHead.twig\",\"templateString\":\"{% if dataPartnerId.value is defined and dataPartnerId.value %}\\n_linkedin_data_partner_id = \\\"{{ dataPartnerId.value }}\\\";\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/linkedInInsightBody.twig\",\"bodyTemplateString\":\"{% if dataPartnerId.value is defined and dataPartnerId.value %}\\n<script type=\\\"text/javascript\\\">\\n(function(){var s = document.getElementsByTagName(\\\"script\\\")[0];\\n    var b = document.createElement(\\\"script\\\");\\n    b.type = \\\"text/javascript\\\";b.async = true;\\n    b.src = \\\"{{ linkedInInsightUrl.value }}\\\";\\n    s.parentNode.insertBefore(b, s);})();\\n</script>\\n<noscript>\\n<img height=\\\"1\\\" width=\\\"1\\\" style=\\\"display:none;\\\" alt=\\\"\\\" src=\\\"{{ linkedInInsightNoScriptUrl.value }}?pid={{ dataPartnerId.value }}&fmt=gif\\\" />\\n</noscript>\\n{% endif %}\\n\",\"bodyPosition\":3,\"vars\":{\"dataPartnerId\":{\"title\":\"LinkedIn Data Partner ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://www.linkedin.com/help/lms/answer/65513/adding-the-linkedin-insight-tag-to-your-website?lang=en)\",\"type\":\"string\",\"value\":\"\"},\"linkedInInsightUrl\":{\"title\":\"LinkedIn Insight Script URL\",\"instructions\":\"The URL to the LinkedIn Insight script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://snap.licdn.com/li.lms-analytics/insight.min.js\"},\"linkedInInsightNoScriptUrl\":{\"title\":\"LinkedIn Insight &lt;noscript&gt; URL\",\"instructions\":\"The URL to the LinkedIn Insight `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://dc.ads.linkedin.com/collect/\"}},\"dataLayer\":[],\"include\":false,\"key\":\"linkedInInsight\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"hubSpot\":{\"name\":\"HubSpot\",\"description\":\"If you\'re not hosting your entire website on HubSpot, or have pages on your website that are not hosted on HubSpot, you\'ll need to install the HubSpot tracking code on your non-HubSpot pages in order to capture those analytics.\",\"templatePath\":null,\"templateString\":null,\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/hubSpotBody.twig\",\"bodyTemplateString\":\"{% if hubSpotId.value is defined and hubSpotId.value %}\\n<script type=\\\"text/javascript\\\" id=\\\"hs-script-loader\\\" async defer src=\\\"{{ hubSpotUrl.value }}{{ hubSpotId.value }}.js\\\"></script>\\n{% endif %}\\n\",\"bodyPosition\":3,\"vars\":{\"hubSpotId\":{\"title\":\"HubSpot ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://knowledge.hubspot.com/articles/kcs_article/reports/install-the-hubspot-tracking-code)\",\"type\":\"string\",\"value\":\"\"},\"hubSpotUrl\":{\"title\":\"HubSpot Script URL\",\"instructions\":\"The URL to the HubSpot script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"//js.hs-scripts.com/\"}},\"dataLayer\":[],\"include\":false,\"key\":\"hubSpot\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"pinterestTag\":{\"name\":\"Pinterest Tag\",\"description\":\"The Pinterest tag allows you to track actions people take on your website after viewing your Promoted Pin. You can use this information to measure return on ad spend (RoAS) and create audiences to target on your Promoted Pins. [Learn More](https://help.pinterest.com/en/business/article/track-conversions-with-pinterest-tag)\",\"templatePath\":\"_frontend/scripts/pinterestTagHead.twig\",\"templateString\":\"{% if pinterestTagId.value is defined and pinterestTagId.value %}\\n!function(e){if(!window.pintrk){window.pintrk=function(){window.pintrk.queue.push(\\nArray.prototype.slice.call(arguments))};var\\nn=window.pintrk;n.queue=[],n.version=\\\"3.0\\\";var\\nt=document.createElement(\\\"script\\\");t.async=!0,t.src=e;var\\nr=document.getElementsByTagName(\\\"script\\\")[0];r.parentNode.insertBefore(t,r)}}(\\\"{{ pinterestTagUrl.value }}\\\");\\npintrk(\'load\', \'{{ pinterestTagId.value }}\');\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if pageView %}\\npintrk(\'page\');\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/pinterestTagBody.twig\",\"bodyTemplateString\":\"{% if pinterestTagId.value is defined and pinterestTagId.value %}\\n<noscript><img height=\\\"1\\\" width=\\\"1\\\" style=\\\"display:none;\\\" alt=\\\"\\\" src=\\\"{{ pinterestTagNoScriptUrl.value }}?tid={{ pinterestTagId.value }}&noscript=1\\\" /></noscript>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"pinterestTagId\":{\"title\":\"Pinterest Tag ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://developers.pinterest.com/docs/ad-tools/conversion-tag/)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Pinterest Tag PageView\",\"instructions\":\"Controls whether the Pinterest Tag script automatically sends a PageView to when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"pinterestTagUrl\":{\"title\":\"Pinterest Tag Script URL\",\"instructions\":\"The URL to the Pinterest Tag script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://s.pinimg.com/ct/core.js\"},\"pinterestTagNoScriptUrl\":{\"title\":\"Pinterest Tag Script &lt;noscript&gt; URL\",\"instructions\":\"The URL to the Pinterest Tag `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://ct.pinterest.com/v3/\"}},\"dataLayer\":[],\"include\":false,\"key\":\"pinterestTag\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"fathom\":{\"name\":\"Fathom\",\"description\":\"Fathom is a simple, light-weight, privacy-first alternative to Google Analytics. So, stop scrolling through pages of reports and collecting gobs of personal data about your visitors, both of which you probably don’t need. [Learn More](https://usefathom.com/)\",\"templatePath\":\"_frontend/scripts/fathomAnalytics.twig\",\"templateString\":\"{% if siteId.value is defined and siteId.value %}\\n(function() {\\nvar tag = document.createElement(\'script\');\\ntag.src = \\\"{{ scriptUrl.value }}\\\";\\ntag.defer = true;\\ntag.setAttribute(\\\"data-site\\\", \\\"{{ siteId.value | raw }}\\\");\\n{% if honorDnt.value %}\\ntag.setAttribute(\\\"data-honor-dnt\\\", \\\"true\\\");\\n{% endif %}\\n{% if disableAutoTracking.value %}\\ntag.setAttribute(\\\"data-auto\\\", \\\"false\\\");\\n{% endif %}\\n{% if ignoreCanonicals.value %}\\ntag.setAttribute(\\\"data-canonical\\\", \\\"false\\\");\\n{% endif %}\\n{% if excludedDomains.value | length %}\\ntag.setAttribute(\\\"data-excluded-domains\\\", \\\"{{ excludedDomains.value | raw }}\\\");\\n{% endif %}\\n{% if includedDomains.value | length %}\\ntag.setAttribute(\\\"data-included-domains\\\", \\\"{{ includedDomains.value | raw }}\\\");\\n{% endif %}\\nvar firstScriptTag = document.getElementsByTagName(\'script\')[0];\\nfirstScriptTag.parentNode.insertBefore(tag, firstScriptTag);\\n})();\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":null,\"bodyTemplateString\":null,\"bodyPosition\":2,\"vars\":{\"siteId\":{\"title\":\"Site ID\",\"instructions\":\"Only enter the Site ID, not the entire script code. [Learn More](https://usefathom.com/support/tracking)\",\"type\":\"string\",\"value\":\"\"},\"honorDnt\":{\"title\":\"Honoring Do Not Track (DNT)\",\"instructions\":\"By default we track every visitor to your website, regardless of them having DNT turned on or not. [Learn More](https://usefathom.com/support/tracking-advanced)\",\"type\":\"bool\",\"value\":false},\"disableAutoTracking\":{\"title\":\"Disable automatic tracking\",\"instructions\":\"By default, we track a page view every time a visitor to your website loads a page with our script on it. [Learn More](https://usefathom.com/support/tracking-advanced)\",\"type\":\"bool\",\"value\":false},\"ignoreCanonicals\":{\"title\":\"Ignore canonicals\",\"instructions\":\"If there’s a canonical URL in place, then by default we use it instead of the current URL. [Learn More](https://usefathom.com/support/tracking-advanced)\",\"type\":\"bool\",\"value\":false},\"excludedDomains\":{\"title\":\"Excluded Domains\",\"instructions\":\"You exclude one or several domains, so our tracker will track things on every domain, except the ones excluded. [Learn More](https://usefathom.com/support/tracking-advanced)\",\"type\":\"string\",\"value\":\"\"},\"includedDomains\":{\"title\":\"Included Domains\",\"instructions\":\"If you want to go in the opposite direction and only track stats on a specific domain. [Learn More](https://usefathom.com/support/tracking-advanced)\",\"type\":\"string\",\"value\":\"\"},\"scriptUrl\":{\"title\":\"Fathom Script URL\",\"instructions\":\"The URL to the Fathom tracking script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://cdn.usefathom.com/script.js\"}},\"dataLayer\":[],\"include\":false,\"key\":\"fathom\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"matomo\":{\"name\":\"Matomo\",\"description\":\"Matomo is a Google Analytics alternative that protects your data and your customers\' privacy [Learn More](https://matomo.org/)\",\"templatePath\":\"_frontend/scripts/matomoAnalytics.twig\",\"templateString\":\"{% if siteId.value is defined and siteId.value and scriptUrl.value is defined and scriptUrl.value | length %}\\nvar _paq = window._paq = window._paq || [];\\n{% if sendPageView.value %}\\n_paq.push([\'trackPageView\']);\\n{% endif %}\\n{% if sendPageView.value %}\\n_paq.push([\'enableLinkTracking\']);\\n{% endif %}\\n(function() {\\nvar u=\\\"{{ scriptUrl.value }}\\\";\\n_paq.push([\'setTrackerUrl\', u+\'matomo.php\']);\\n_paq.push([\'setSiteId\', {{ siteId.value }}]);\\nvar d=document, g=d.createElement(\'script\'), s=d.getElementsByTagName(\'script\')[0];\\ng.type=\'text/javascript\'; g.async=true; g.src=u+\'matomo.js\'; s.parentNode.insertBefore(g,s);\\n})();\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":null,\"bodyTemplateString\":null,\"bodyPosition\":2,\"vars\":{\"siteId\":{\"title\":\"Site ID\",\"instructions\":\"Only enter the Site ID, not the entire script code. [Learn More](https://developer.matomo.org/guides/tracking-javascript-guide)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Matomo PageView\",\"instructions\":\"Controls whether the Matomo script automatically sends a PageView when your pages are loaded. [Learn More](https://developer.matomo.org/api-reference/tracking-javascript)\",\"type\":\"bool\",\"value\":true},\"enableLinkTracking\":{\"title\":\"Enable Link Tracking\",\"instructions\":\"Install link tracking on all applicable link elements. [Learn More](https://developer.matomo.org/api-reference/tracking-javascript)\",\"type\":\"bool\",\"value\":true},\"scriptUrl\":{\"title\":\"Matomo Script URL\",\"instructions\":\"The URL to the Matomo tracking script. This will vary depending on whether you are using Matomo Cloud or Matomo On-Premise. [Learn More](https://developer.matomo.org/guides/tracking-javascript-guide)\",\"type\":\"string\",\"value\":\"\"}},\"dataLayer\":[],\"include\":false,\"key\":\"matomo\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"plausible\":{\"name\":\"Plausible\",\"description\":\"Plausible is a lightweight and open-source website analytics tool. No cookies and fully compliant with GDPR, CCPA and PECR. [Learn More](https://plausible.io/)\",\"templatePath\":\"_frontend/scripts/plausibleAnalytics.twig\",\"templateString\":\"{% if siteDomain.value is defined and siteDomain.value %}\\n(function() {\\nvar tag = document.createElement(\'script\');\\ntag.src = \\\"{{ scriptUrl.value }}\\\";\\ntag.defer = true;\\ntag.setAttribute(\\\"data-domain\\\", \\\"{{ siteDomain.value | raw }}\\\");\\nvar firstScriptTag = document.getElementsByTagName(\'script\')[0];\\nfirstScriptTag.parentNode.insertBefore(tag, firstScriptTag);\\n})();\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":null,\"bodyTemplateString\":null,\"bodyPosition\":2,\"vars\":{\"siteDomain\":{\"title\":\"Site Domain\",\"instructions\":\"Only enter the site domain, not the entire script code. [Learn More](https://plausible.io/docs/plausible-script)\",\"type\":\"string\",\"value\":\"\"},\"scriptUrl\":{\"title\":\"Plausible Script URL\",\"instructions\":\"The URL to the Plausible tracking script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://plausible.io/js/plausible.js\"}},\"dataLayer\":[],\"include\":false,\"key\":\"plausible\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"googleAnalytics\":{\"name\":\"Google Analytics\",\"description\":\"Google Analytics gives you the digital analytics tools you need to analyze data from all touchpoints in one place, for a deeper understanding of the customer experience. You can then share the insights that matter with your whole organization. [Learn More](https://www.google.com/analytics/analytics/)\",\"templatePath\":\"_frontend/scripts/googleAnalytics.twig\",\"templateString\":\"{% if trackingId.value is defined and trackingId.value %}\\n(function(i,s,o,g,r,a,m){i[\'GoogleAnalyticsObject\']=r;i[r]=i[r]||function(){\\n(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),\\nm=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)\\n})(window,document,\'script\',\'{{ analyticsUrl.value }}\',\'ga\');\\nga(\'create\', \'{{ trackingId.value |raw }}\', \'auto\'{% if linker.value %}, {allowLinker: true}{% endif %});\\n{% if ipAnonymization.value %}\\nga(\'set\', \'anonymizeIp\', true);\\n{% endif %}\\n{% if displayFeatures.value %}\\nga(\'require\', \'displayfeatures\');\\n{% endif %}\\n{% if ecommerce.value %}\\nga(\'require\', \'ecommerce\');\\n{% endif %}\\n{% if enhancedEcommerce.value %}\\nga(\'require\', \'ec\');\\n{% endif %}\\n{% if enhancedLinkAttribution.value %}\\nga(\'require\', \'linkid\');\\n{% endif %}\\n{% if enhancedLinkAttribution.value %}\\nga(\'require\', \'linker\');\\n{% endif %}\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if pageView %}\\nga(\'send\', \'pageview\');\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":null,\"bodyTemplateString\":null,\"bodyPosition\":2,\"vars\":{\"trackingId\":{\"title\":\"Google Analytics Tracking ID\",\"instructions\":\"Only enter the ID, e.g.: `UA-XXXXXX-XX`, not the entire script code. [Learn More](https://support.google.com/analytics/answer/1032385?hl=e)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Google Analytics PageView\",\"instructions\":\"Controls whether the Google Analytics script automatically sends a PageView to Google Analytics when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"ipAnonymization\":{\"title\":\"Google Analytics IP Anonymization\",\"instructions\":\"When a customer of Analytics requests IP address anonymization, Analytics anonymizes the address as soon as technically feasible at the earliest possible stage of the collection network.\",\"type\":\"bool\",\"value\":false},\"displayFeatures\":{\"title\":\"Display Features\",\"instructions\":\"The display features plugin for analytics.js can be used to enable Advertising Features in Google Analytics, such as Remarketing, Demographics and Interest Reporting, and more. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/display-features)\",\"type\":\"bool\",\"value\":false},\"ecommerce\":{\"title\":\"Ecommerce\",\"instructions\":\"Ecommerce tracking allows you to measure the number of transactions and revenue that your website generates. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/ecommerce)\",\"type\":\"bool\",\"value\":false},\"enhancedEcommerce\":{\"title\":\"Enhanced Ecommerce\",\"instructions\":\"The enhanced ecommerce plug-in for analytics.js enables the measurement of user interactions with products on ecommerce websites across the user\'s shopping experience, including: product impressions, product clicks, viewing product details, adding a product to a shopping cart, initiating the checkout process, transactions, and refunds. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/enhanced-ecommerce)\",\"type\":\"bool\",\"value\":false},\"enhancedLinkAttribution\":{\"title\":\"Enhanced Link Attribution\",\"instructions\":\"Enhanced Link Attribution improves the accuracy of your In-Page Analytics report by automatically differentiating between multiple links to the same URL on a single page by using link element IDs. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/enhanced-link-attribution)\",\"type\":\"bool\",\"value\":false},\"linker\":{\"title\":\"Linker\",\"instructions\":\"The linker plugin simplifies the process of implementing cross-domain tracking as described in the Cross-domain Tracking guide for analytics.js. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/linker)\",\"type\":\"bool\",\"value\":false},\"analyticsUrl\":{\"title\":\"Google Analytics Script URL\",\"instructions\":\"The URL to the Google Analytics tracking script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.google-analytics.com/analytics.js\"}},\"dataLayer\":[],\"include\":false,\"key\":\"googleAnalytics\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null}},\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"issn\":null,\"about\":null,\"abstract\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"acquireLicensePage\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"conditionsOfAccess\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#identity\"},\"copyrightYear\":null,\"correction\":null,\"creativeWorkStatus\":null,\"creator\":{\"id\":\"{parseEnv(seomatic.site.creator.genericUrl)}#creator\"},\"dateCreated\":null,\"dateModified\":null,\"datePublished\":null,\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"encodingFormat\":null,\"exampleOfWork\":null,\"expires\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":null,\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"maintainer\":null,\"material\":null,\"materialExtent\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":null,\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sdDatePublished\":null,\"sdLicense\":null,\"sdPublisher\":null,\"sourceOrganization\":null,\"spatial\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporal\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"usageInfo\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":{\"type\":\"EntryPoint\",\"urlTemplate\":\"{seomatic.site.siteLinksSearchTarget}\"},\"query-input\":\"{seomatic.helper.siteLinksQueryInput()}\"},\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"graph\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"identity\":{\"actionableFeedbackPolicy\":null,\"address\":{\"type\":\"PostalAddress\",\"streetAddress\":\"{seomatic.site.identity.genericStreetAddress}\",\"addressLocality\":\"{seomatic.site.identity.genericAddressLocality}\",\"addressRegion\":\"{seomatic.site.identity.genericAddressRegion}\",\"postalCode\":\"{seomatic.site.identity.genericPostalCode}\",\"addressCountry\":\"{seomatic.site.identity.genericAddressCountry}\"},\"aggregateRating\":null,\"alumni\":null,\"areaServed\":null,\"award\":null,\"brand\":null,\"contactPoint\":null,\"correctionsPolicy\":null,\"department\":null,\"dissolutionDate\":null,\"diversityPolicy\":null,\"diversityStaffingReport\":null,\"duns\":\"{seomatic.site.identity.organizationDuns}\",\"email\":\"{seomatic.site.identity.genericEmail}\",\"employee\":null,\"ethicsPolicy\":null,\"event\":null,\"faxNumber\":null,\"founder\":\"{seomatic.site.identity.organizationFounder}\",\"foundingDate\":\"{seomatic.site.identity.organizationFoundingDate}\",\"foundingLocation\":\"{seomatic.site.identity.organizationFoundingLocation}\",\"funder\":null,\"globalLocationNumber\":null,\"hasCredential\":null,\"hasMerchantReturnPolicy\":null,\"hasOfferCatalog\":null,\"hasPOS\":null,\"interactionStatistic\":null,\"isicV4\":null,\"knowsAbout\":null,\"knowsLanguage\":null,\"legalName\":null,\"leiCode\":null,\"location\":null,\"logo\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.helper.socialTransform(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\")}\",\"width\":\"{seomatic.helper.socialTransformWidth(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\")}\",\"height\":\"{seomatic.helper.socialTransformHeight(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\")}\"},\"makesOffer\":null,\"member\":null,\"memberOf\":null,\"naics\":null,\"numberOfEmployees\":null,\"ownershipFundingInfo\":null,\"owns\":null,\"parentOrganization\":null,\"publishingPrinciples\":null,\"review\":null,\"seeks\":null,\"slogan\":null,\"sponsor\":null,\"subOrganization\":null,\"taxID\":null,\"telephone\":\"{seomatic.site.identity.genericTelephone}\",\"unnamedSourcesPolicy\":null,\"vatID\":null,\"additionalType\":null,\"alternateName\":\"{seomatic.site.identity.genericAlternateName}\",\"description\":\"{seomatic.site.identity.genericDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.site.identity.genericImage}\",\"width\":\"{seomatic.site.identity.genericImageWidth}\",\"height\":\"{seomatic.site.identity.genericImageHeight}\"},\"mainEntityOfPage\":null,\"name\":\"{seomatic.site.identity.genericName}\",\"potentialAction\":null,\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.site.identity.genericUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.site.identity.computedType}\",\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#identity\",\"graph\":null,\"include\":true,\"key\":\"identity\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"creator\":{\"actionableFeedbackPolicy\":null,\"address\":{\"type\":\"PostalAddress\",\"streetAddress\":\"{seomatic.site.creator.genericStreetAddress}\",\"addressLocality\":\"{seomatic.site.creator.genericAddressLocality}\",\"addressRegion\":\"{seomatic.site.creator.genericAddressRegion}\",\"postalCode\":\"{seomatic.site.creator.genericPostalCode}\",\"addressCountry\":\"{seomatic.site.creator.genericAddressCountry}\"},\"aggregateRating\":null,\"alumni\":null,\"areaServed\":null,\"award\":null,\"brand\":null,\"contactPoint\":null,\"correctionsPolicy\":null,\"department\":null,\"dissolutionDate\":null,\"diversityPolicy\":null,\"diversityStaffingReport\":null,\"duns\":\"{seomatic.site.creator.organizationDuns}\",\"email\":\"{seomatic.site.creator.genericEmail}\",\"employee\":null,\"ethicsPolicy\":null,\"event\":null,\"faxNumber\":null,\"founder\":\"{seomatic.site.creator.organizationFounder}\",\"foundingDate\":\"{seomatic.site.creator.organizationFoundingDate}\",\"foundingLocation\":\"{seomatic.site.creator.organizationFoundingLocation}\",\"funder\":null,\"globalLocationNumber\":null,\"hasCredential\":null,\"hasMerchantReturnPolicy\":null,\"hasOfferCatalog\":null,\"hasPOS\":null,\"interactionStatistic\":null,\"isicV4\":null,\"knowsAbout\":null,\"knowsLanguage\":null,\"legalName\":null,\"leiCode\":null,\"location\":null,\"logo\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.helper.socialTransform(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\")}\",\"width\":\"{seomatic.helper.socialTransformWidth(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\")}\",\"height\":\"{seomatic.helper.socialTransformHeight(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\")}\"},\"makesOffer\":null,\"member\":null,\"memberOf\":null,\"naics\":null,\"numberOfEmployees\":null,\"ownershipFundingInfo\":null,\"owns\":null,\"parentOrganization\":null,\"publishingPrinciples\":null,\"review\":null,\"seeks\":null,\"slogan\":null,\"sponsor\":null,\"subOrganization\":null,\"taxID\":null,\"telephone\":\"{seomatic.site.creator.genericTelephone}\",\"unnamedSourcesPolicy\":null,\"vatID\":null,\"additionalType\":null,\"alternateName\":\"{seomatic.site.creator.genericAlternateName}\",\"description\":\"{seomatic.site.creator.genericDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.site.creator.genericImage}\",\"width\":\"{seomatic.site.creator.genericImageWidth}\",\"height\":\"{seomatic.site.creator.genericImageHeight}\"},\"mainEntityOfPage\":null,\"name\":\"{seomatic.site.creator.genericName}\",\"potentialAction\":null,\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.site.creator.genericUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.site.creator.computedType}\",\"id\":\"{parseEnv(seomatic.site.creator.genericUrl)}#creator\",\"graph\":null,\"include\":true,\"key\":\"creator\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}}','[]','{\"data\":{\"humans\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"/* TEAM */\\n\\nCreator: {{ seomatic.site.creator.genericName ?? \\\"n/a\\\" }}\\nURL: {{ seomatic.site.creator.genericUrl ?? \\\"n/a\\\" }}\\nDescription: {{ seomatic.site.creator.genericDescription ?? \\\"n/a\\\" }}\\n\\n/* THANKS */\\n\\nCraft CMS - https://craftcms.com\\nPixel & Tonic - https://pixelandtonic.com\\n\\n/* SITE */\\n\\nStandards: HTML5, CSS3\\nComponents: Craft CMS 3, Yii2, PHP, JavaScript, SEOmatic\\n\",\"siteId\":null,\"include\":true,\"handle\":\"humans\",\"path\":\"humans.txt\",\"template\":\"_frontend/pages/humans.twig\",\"controller\":\"frontend-template\",\"action\":\"humans\"},\"robots\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"# robots.txt for {{ siteUrl }}\\n\\nSitemap: {{ seomatic.helper.sitemapIndexForSiteId() }}\\n{% switch seomatic.config.environment %}\\n\\n{% case \\\"live\\\" %}\\n\\n# live - don\'t allow web crawlers to index cpresources/ or vendor/\\n\\nUser-agent: *\\nDisallow: /cpresources/\\nDisallow: /vendor/\\nDisallow: /.env\\nDisallow: /cache/\\n\\n{% case \\\"staging\\\" %}\\n\\n# staging - disallow all\\n\\nUser-agent: *\\nDisallow: /\\n\\n{% case \\\"local\\\" %}\\n\\n# local - disallow all\\n\\nUser-agent: *\\nDisallow: /\\n\\n{% default %}\\n\\n# default - don\'t allow web crawlers to index cpresources/ or vendor/\\n\\nUser-agent: *\\nDisallow: /cpresources/\\nDisallow: /vendor/\\nDisallow: /.env\\nDisallow: /cache/\\n\\n{% endswitch %}\\n\",\"siteId\":null,\"include\":true,\"handle\":\"robots\",\"path\":\"robots.txt\",\"template\":\"_frontend/pages/robots.twig\",\"controller\":\"frontend-template\",\"action\":\"robots\"},\"ads\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"# ads.txt file for {{ siteUrl }}\\n# More info: https://support.google.com/admanager/answer/7441288?hl=en\\n{{ siteUrl }},123,DIRECT\\n\",\"siteId\":null,\"include\":true,\"handle\":\"ads\",\"path\":\"ads.txt\",\"template\":\"_frontend/pages/ads.twig\",\"controller\":\"frontend-template\",\"action\":\"ads\"},\"security\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"# security.txt file for {{ siteUrl }} - more info: https://securitytxt.org/\\r\\n# (required) Contact email address for security issues\\r\\nContact: {% set adminUser = craft.app.getUsers().userById(1) %}{{ adminUser.email ?? \'user@example.com\' }}\\r\\n\\r\\n{{ dump(seomatic.site.twitterHandle) }}\\r\\n\\r\\n# (required) Expiration date for the security information herein\\r\\nExpiration: {{ date(\'1year\')|atom }}\\r\\n\\r\\n# (optional) OpenPGP key:\\r\\nEncryption: {{ siteUrl }}pgp-key.txt\\r\\n\\r\\n# (optional) Security policy page:\\r\\nPolicy: {{ siteUrl }}security-policy\\r\\n\\r\\n# (optional) Security acknowledgements page:\\r\\nAcknowledgements: {{ siteUrl }}hall-of-fame\\r\\n\",\"siteId\":null,\"include\":\"1\",\"handle\":\"security\",\"path\":\"security.txt\",\"template\":\"_frontend/pages/security.twig\",\"controller\":\"frontend-template\",\"action\":\"security\"}},\"name\":\"Frontend Templates\",\"description\":\"Templates that are rendered on the frontend\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":\"SeomaticEditableTemplate\",\"include\":true,\"dependencies\":null,\"clearCache\":false}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebSite\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromCustom\",\"seoTitleField\":\"\",\"siteNamePositionSource\":\"fromCustom\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"fromCustom\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"fromCustom\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}'),(2,'2020-03-27 13:38:49','2022-01-31 03:40:29','5e1950fb-88fb-41ee-8b5f-051ba6490e0c','1.0.29','section',5,'Homepage','homepage','single',NULL,'index',1,'{\"1\":{\"id\":2,\"sectionId\":5,\"siteId\":1,\"enabledByDefault\":true,\"hasUrls\":true,\"uriFormat\":\"__home__\",\"template\":\"index\",\"language\":\"en-us\"}}','2021-03-15 15:40:42','{\"language\":null,\"mainEntityOfPage\":\"WebPage\",\"seoTitle\":\"{entry.title}\",\"siteNamePosition\":\"\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{entry.url}\",\"robots\":\"\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"ogImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary_large_image\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"twitterImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"inherited\":[],\"overrides\":[]}','{\"siteName\":\"Friends of Webster Trails\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"facebookSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}],\"inherited\":[],\"overrides\":[]}','{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"breadcrumb\":null,\"lastReviewed\":null,\"mainContentOfPage\":null,\"primaryImageOfPage\":null,\"relatedLink\":null,\"reviewedBy\":null,\"significantLink\":null,\"speakable\":null,\"specialty\":null,\"about\":null,\"abstract\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"acquireLicensePage\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"conditionsOfAccess\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#identity\"},\"copyrightYear\":\"{entry.postDate | date(\\\"Y\\\")}\",\"correction\":null,\"creativeWorkStatus\":null,\"creator\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#creator\"},\"dateCreated\":false,\"dateModified\":\"{entry.dateUpdated |atom}\",\"datePublished\":\"{entry.postDate |atom}\",\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"encodingFormat\":null,\"exampleOfWork\":null,\"expires\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":\"{seomatic.meta.seoTitle}\",\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"maintainer\":null,\"material\":null,\"materialExtent\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#creator\"},\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sdDatePublished\":null,\"sdLicense\":null,\"sdPublisher\":null,\"sourceOrganization\":null,\"spatial\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporal\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"usageInfo\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.helper.siteLinksQueryInput()}\"},\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"graph\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}}','[]','{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null,\"clearCache\":false}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebPage\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromField\",\"seoTitleField\":\"title\",\"siteNamePositionSource\":\"sameAsGlobal\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"sameAsGlobal\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"sameAsGlobal\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}'),(3,'2021-03-15 15:04:42','2022-01-31 03:40:29','3bebe8ad-f57a-4cc3-8849-3701daca07a1','1.0.29','section',5,'Homepage','homepage','single',NULL,'',2,'{\"1\":{\"id\":2,\"sectionId\":5,\"siteId\":1,\"enabledByDefault\":true,\"hasUrls\":true,\"uriFormat\":\"__home__\",\"template\":\"index\",\"language\":\"en-us\"},\"2\":{\"id\":3,\"sectionId\":5,\"siteId\":2,\"enabledByDefault\":true,\"hasUrls\":true,\"uriFormat\":\"__home__\",\"template\":null,\"language\":\"es\"}}','2021-03-15 15:40:42','{\"language\":null,\"mainEntityOfPage\":\"WebPage\",\"seoTitle\":\"{entry.title}\",\"siteNamePosition\":\"\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{entry.url}\",\"robots\":\"\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"ogImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary_large_image\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"twitterImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"inherited\":[],\"overrides\":[]}','{\"siteName\":\"Project\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"facebookSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}],\"inherited\":[],\"overrides\":[]}','{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"breadcrumb\":null,\"lastReviewed\":null,\"mainContentOfPage\":null,\"primaryImageOfPage\":null,\"relatedLink\":null,\"reviewedBy\":null,\"significantLink\":null,\"speakable\":null,\"specialty\":null,\"about\":null,\"abstract\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"acquireLicensePage\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"conditionsOfAccess\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#identity\"},\"copyrightYear\":\"{entry.postDate | date(\\\"Y\\\")}\",\"correction\":null,\"creativeWorkStatus\":null,\"creator\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#creator\"},\"dateCreated\":false,\"dateModified\":\"{entry.dateUpdated |atom}\",\"datePublished\":\"{entry.postDate |atom}\",\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"encodingFormat\":null,\"exampleOfWork\":null,\"expires\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":\"{seomatic.meta.seoTitle}\",\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"maintainer\":null,\"material\":null,\"materialExtent\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#creator\"},\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sdDatePublished\":null,\"sdLicense\":null,\"sdPublisher\":null,\"sourceOrganization\":null,\"spatial\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporal\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"usageInfo\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.helper.siteLinksQueryInput()}\"},\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"graph\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}}','[]','{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null,\"clearCache\":false}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebPage\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromField\",\"seoTitleField\":\"title\",\"siteNamePositionSource\":\"sameAsGlobal\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"sameAsGlobal\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"sameAsGlobal\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}'),(4,'2021-03-15 15:24:20','2021-03-15 15:24:20','ab4e123a-e7d5-4716-a325-7bfa6f7c553d','1.0.33','product',1,'Clothing','clothing','product',NULL,'shop/products/_product',2,'{\"1\":{\"id\":\"1\",\"productTypeId\":\"1\",\"siteId\":\"1\",\"hasUrls\":\"1\",\"uriFormat\":\"shop/products/{slug}\",\"template\":\"shop/products/_product\",\"uriFormatIsRequired\":true,\"language\":\"en-us\"},\"2\":{\"id\":\"2\",\"productTypeId\":\"1\",\"siteId\":\"2\",\"hasUrls\":\"1\",\"uriFormat\":\"shop/products/{slug}\",\"template\":\"shop/products/_product\",\"uriFormatIsRequired\":true,\"language\":\"es\"}}','2021-03-15 15:24:16','{\"language\":null,\"mainEntityOfPage\":\"Product\",\"seoTitle\":\"{product.title}\",\"siteNamePosition\":\"\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{product.url}\",\"robots\":\"all\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"ogImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary_large_image\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"twitterImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\"}','{\"siteName\":\"Project\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}','{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"additionalProperty\":null,\"aggregateRating\":null,\"audience\":null,\"award\":null,\"brand\":null,\"category\":null,\"color\":null,\"depth\":null,\"gtin\":null,\"gtin12\":null,\"gtin13\":null,\"gtin14\":null,\"gtin8\":null,\"hasMerchantReturnPolicy\":null,\"height\":null,\"isAccessoryOrSparePartFor\":null,\"isConsumableFor\":null,\"isRelatedTo\":null,\"isSimilarTo\":null,\"itemCondition\":null,\"logo\":null,\"manufacturer\":null,\"material\":null,\"model\":null,\"mpn\":null,\"nsn\":null,\"offers\":{\"type\":\"Offer\",\"url\":\"{seomatic.meta.canonicalUrl}\",\"price\":\"{product.getDefaultVariant().getPrice()|number_format(2, \\\".\\\", \\\"\\\")}\",\"priceCurrency\":\"{{craft.commerce.paymentCurrencies.primaryPaymentCurrencyIso()}}\",\"offeredBy\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#identity\"},\"seller\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#identity\"},\"availability\":\"http://schema.org/{% if object.product.hasUnlimitedStock or object.product.totalStock > 0 %}InStock{% else %}OutOfStock{% endif %}\"},\"productID\":null,\"productionDate\":null,\"purchaseDate\":null,\"releaseDate\":null,\"review\":null,\"sku\":\"{product.getDefaultVariant().getSku()}\",\"slogan\":null,\"weight\":null,\"width\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.helper.siteLinksQueryInput()}\"},\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"graph\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null,\"nonce\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}}','[]','{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null,\"clearCache\":false}','{\"siteType\":\"Product\",\"siteSubType\":\"\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromField\",\"seoTitleField\":\"title\",\"siteNamePositionSource\":\"sameAsGlobal\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"sameAsGlobal\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"sameAsGlobal\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}'),(5,'2021-03-15 15:24:20','2021-03-15 15:24:20','2ffcb07b-9e3f-4a82-8ba8-b5e909291818','1.0.33','product',1,'Clothing','clothing','product',NULL,'shop/products/_product',1,'{\"1\":{\"id\":\"1\",\"productTypeId\":\"1\",\"siteId\":\"1\",\"hasUrls\":\"1\",\"uriFormat\":\"shop/products/{slug}\",\"template\":\"shop/products/_product\",\"uriFormatIsRequired\":true,\"language\":\"en-us\"},\"2\":{\"id\":\"2\",\"productTypeId\":\"1\",\"siteId\":\"2\",\"hasUrls\":\"1\",\"uriFormat\":\"shop/products/{slug}\",\"template\":\"shop/products/_product\",\"uriFormatIsRequired\":true,\"language\":\"es\"}}','2021-03-15 15:24:16','{\"language\":null,\"mainEntityOfPage\":\"Product\",\"seoTitle\":\"{product.title}\",\"siteNamePosition\":\"\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{product.url}\",\"robots\":\"all\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"ogImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary_large_image\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"twitterImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\"}','{\"siteName\":\"Project\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}','{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"additionalProperty\":null,\"aggregateRating\":null,\"audience\":null,\"award\":null,\"brand\":null,\"category\":null,\"color\":null,\"depth\":null,\"gtin\":null,\"gtin12\":null,\"gtin13\":null,\"gtin14\":null,\"gtin8\":null,\"hasMerchantReturnPolicy\":null,\"height\":null,\"isAccessoryOrSparePartFor\":null,\"isConsumableFor\":null,\"isRelatedTo\":null,\"isSimilarTo\":null,\"itemCondition\":null,\"logo\":null,\"manufacturer\":null,\"material\":null,\"model\":null,\"mpn\":null,\"nsn\":null,\"offers\":{\"type\":\"Offer\",\"url\":\"{seomatic.meta.canonicalUrl}\",\"price\":\"{product.getDefaultVariant().getPrice()|number_format(2, \\\".\\\", \\\"\\\")}\",\"priceCurrency\":\"{{craft.commerce.paymentCurrencies.primaryPaymentCurrencyIso()}}\",\"offeredBy\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#identity\"},\"seller\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#identity\"},\"availability\":\"http://schema.org/{% if object.product.hasUnlimitedStock or object.product.totalStock > 0 %}InStock{% else %}OutOfStock{% endif %}\"},\"productID\":null,\"productionDate\":null,\"purchaseDate\":null,\"releaseDate\":null,\"review\":null,\"sku\":\"{product.getDefaultVariant().getSku()}\",\"slogan\":null,\"weight\":null,\"width\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.helper.siteLinksQueryInput()}\"},\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"graph\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null,\"nonce\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}}','[]','{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null,\"clearCache\":false}','{\"siteType\":\"Product\",\"siteSubType\":\"\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromField\",\"seoTitleField\":\"title\",\"siteNamePositionSource\":\"sameAsGlobal\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"sameAsGlobal\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"sameAsGlobal\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}'),(6,'2021-03-15 15:39:25','2022-01-31 03:40:29','55e209e4-06d9-4b7d-9d4f-b8c5464ca10a','1.0.29','section',6,'Blog','blog','channel',NULL,'blog/_entry',1,'{\"1\":{\"id\":4,\"sectionId\":6,\"siteId\":1,\"enabledByDefault\":true,\"hasUrls\":true,\"uriFormat\":\"blog/{slug}\",\"template\":\"blog/_entry\",\"language\":\"en-us\"},\"2\":{\"id\":5,\"sectionId\":6,\"siteId\":2,\"enabledByDefault\":true,\"hasUrls\":true,\"uriFormat\":\"blog/{slug}\",\"template\":\"blog/_entry\",\"language\":\"es\"}}','2021-03-15 16:17:36','{\"language\":null,\"mainEntityOfPage\":\"WebPage\",\"seoTitle\":\"{entry.title}\",\"siteNamePosition\":\"\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{entry.url}\",\"robots\":\"\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"ogImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary_large_image\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"twitterImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"inherited\":[],\"overrides\":[]}','{\"siteName\":\"Project\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"facebookSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}],\"inherited\":[],\"overrides\":[]}','{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"breadcrumb\":null,\"lastReviewed\":null,\"mainContentOfPage\":null,\"primaryImageOfPage\":null,\"relatedLink\":null,\"reviewedBy\":null,\"significantLink\":null,\"speakable\":null,\"specialty\":null,\"about\":null,\"abstract\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"acquireLicensePage\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"conditionsOfAccess\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#identity\"},\"copyrightYear\":\"{entry.postDate | date(\\\"Y\\\")}\",\"correction\":null,\"creativeWorkStatus\":null,\"creator\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#creator\"},\"dateCreated\":false,\"dateModified\":\"{entry.dateUpdated |atom}\",\"datePublished\":\"{entry.postDate |atom}\",\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"encodingFormat\":null,\"exampleOfWork\":null,\"expires\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":\"{seomatic.meta.seoTitle}\",\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"maintainer\":null,\"material\":null,\"materialExtent\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#creator\"},\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sdDatePublished\":null,\"sdLicense\":null,\"sdPublisher\":null,\"sourceOrganization\":null,\"spatial\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporal\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"usageInfo\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.helper.siteLinksQueryInput()}\"},\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"graph\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}}','[]','{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null,\"clearCache\":false}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebPage\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromField\",\"seoTitleField\":\"title\",\"siteNamePositionSource\":\"sameAsGlobal\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"sameAsGlobal\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"sameAsGlobal\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}'),(7,'2021-03-15 15:39:25','2022-01-31 03:40:29','00513103-9fae-41ce-a47d-707c58b06b0f','1.0.29','section',6,'Blog','blog','channel',NULL,'blog/_entry',2,'{\"1\":{\"id\":4,\"sectionId\":6,\"siteId\":1,\"enabledByDefault\":true,\"hasUrls\":true,\"uriFormat\":\"blog/{slug}\",\"template\":\"blog/_entry\",\"language\":\"en-us\"},\"2\":{\"id\":5,\"sectionId\":6,\"siteId\":2,\"enabledByDefault\":true,\"hasUrls\":true,\"uriFormat\":\"blog/{slug}\",\"template\":\"blog/_entry\",\"language\":\"es\"}}','2021-03-15 16:17:36','{\"language\":null,\"mainEntityOfPage\":\"WebPage\",\"seoTitle\":\"{entry.title}\",\"siteNamePosition\":\"\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{entry.url}\",\"robots\":\"\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"ogImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary_large_image\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"twitterImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"inherited\":[],\"overrides\":[]}','{\"siteName\":\"Project\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"facebookSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}],\"inherited\":[],\"overrides\":[]}','{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"breadcrumb\":null,\"lastReviewed\":null,\"mainContentOfPage\":null,\"primaryImageOfPage\":null,\"relatedLink\":null,\"reviewedBy\":null,\"significantLink\":null,\"speakable\":null,\"specialty\":null,\"about\":null,\"abstract\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"acquireLicensePage\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"conditionsOfAccess\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#identity\"},\"copyrightYear\":\"{entry.postDate | date(\\\"Y\\\")}\",\"correction\":null,\"creativeWorkStatus\":null,\"creator\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#creator\"},\"dateCreated\":false,\"dateModified\":\"{entry.dateUpdated |atom}\",\"datePublished\":\"{entry.postDate |atom}\",\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"encodingFormat\":null,\"exampleOfWork\":null,\"expires\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":\"{seomatic.meta.seoTitle}\",\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"maintainer\":null,\"material\":null,\"materialExtent\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#creator\"},\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sdDatePublished\":null,\"sdLicense\":null,\"sdPublisher\":null,\"sourceOrganization\":null,\"spatial\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporal\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"usageInfo\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.helper.siteLinksQueryInput()}\"},\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"graph\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}}','[]','{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null,\"clearCache\":false}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebPage\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromField\",\"seoTitleField\":\"title\",\"siteNamePositionSource\":\"sameAsGlobal\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"sameAsGlobal\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"sameAsGlobal\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}'),(8,'2021-03-15 15:50:58','2021-03-15 15:50:58','24580179-74c1-467c-93bf-aaec35939a7c','1.0.49','__GLOBAL_BUNDLE__',1,'__GLOBAL_BUNDLE__','__GLOBAL_BUNDLE__','__GLOBAL_BUNDLE__',NULL,'',2,'[]','2021-03-15 15:50:58','{\"language\":null,\"mainEntityOfPage\":\"WebSite\",\"seoTitle\":\"\",\"siteNamePosition\":\"before\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{seomatic.helper.safeCanonicalUrl()}\",\"robots\":\"all\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"none\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"ogImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"none\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"twitterImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\"}','{\"siteName\":\"Project\",\"identity\":{\"siteType\":\"Organization\",\"siteSubType\":\"LocalBusiness\",\"siteSpecificType\":\"\",\"computedType\":\"Organization\",\"genericName\":\"\",\"genericAlternateName\":\"\",\"genericDescription\":\"\",\"genericUrl\":\"\",\"genericImage\":\"\",\"genericImageWidth\":\"\",\"genericImageHeight\":\"\",\"genericImageIds\":[],\"genericTelephone\":\"\",\"genericEmail\":\"\",\"genericStreetAddress\":\"\",\"genericAddressLocality\":\"\",\"genericAddressRegion\":\"\",\"genericPostalCode\":\"\",\"genericAddressCountry\":\"\",\"genericGeoLatitude\":\"\",\"genericGeoLongitude\":\"\",\"personGender\":\"\",\"personBirthPlace\":\"\",\"organizationDuns\":\"\",\"organizationFounder\":\"\",\"organizationFoundingDate\":\"\",\"organizationFoundingLocation\":\"\",\"organizationContactPoints\":[],\"corporationTickerSymbol\":\"\",\"localBusinessPriceRange\":\"\",\"localBusinessOpeningHours\":[],\"restaurantServesCuisine\":\"\",\"restaurantMenuUrl\":\"\",\"restaurantReservationsUrl\":\"\"},\"creator\":{\"siteType\":\"Organization\",\"siteSubType\":\"\",\"siteSpecificType\":\"\",\"computedType\":\"Organization\",\"genericName\":\"nystudio107\",\"genericAlternateName\":\"nys\",\"genericDescription\":\"We do technology-based consulting, branding, design, and development. Making the web better one site at a time, with a focus on performance, usability & SEO\",\"genericUrl\":\"https://nystudio107.com/\",\"genericImage\":\"https://nystudio107-ems2qegf7x6qiqq.netdna-ssl.com/img/site/nys_logo_seo.png\",\"genericImageWidth\":\"1042\",\"genericImageHeight\":\"1042\",\"genericImageIds\":[],\"genericTelephone\":\"\",\"genericEmail\":\"info@nystudio107.com\",\"genericStreetAddress\":\"\",\"genericAddressLocality\":\"Webster\",\"genericAddressRegion\":\"NY\",\"genericPostalCode\":\"14580\",\"genericAddressCountry\":\"US\",\"genericGeoLatitude\":\"43.2365384\",\"genericGeoLongitude\":\"-77.49211620000001\",\"personGender\":\"\",\"personBirthPlace\":\"\",\"organizationDuns\":\"\",\"organizationFounder\":\"Andrew Welch, Polly Welch\",\"organizationFoundingDate\":\"2013-05-02\",\"organizationFoundingLocation\":\"Webster, NY\",\"organizationContactPoints\":[],\"corporationTickerSymbol\":\"\",\"localBusinessPriceRange\":\"\",\"localBusinessOpeningHours\":[],\"restaurantServesCuisine\":\"\",\"restaurantMenuUrl\":\"\",\"restaurantReservationsUrl\":\"\"},\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"sameAsLinks\":{\"twitter\":{\"siteName\":\"Twitter\",\"handle\":\"twitter\",\"url\":\"\"},\"facebook\":{\"siteName\":\"Facebook\",\"handle\":\"facebook\",\"url\":\"\"},\"wikipedia\":{\"siteName\":\"Wikipedia\",\"handle\":\"wikipedia\",\"url\":\"\"},\"linkedin\":{\"siteName\":\"LinkedIn\",\"handle\":\"linkedin\",\"url\":\"\"},\"googleplus\":{\"siteName\":\"Google+\",\"handle\":\"googleplus\",\"url\":\"\"},\"youtube\":{\"siteName\":\"YouTube\",\"handle\":\"youtube\",\"url\":\"\"},\"instagram\":{\"siteName\":\"Instagram\",\"handle\":\"instagram\",\"url\":\"\"},\"pinterest\":{\"siteName\":\"Pinterest\",\"handle\":\"pinterest\",\"url\":\"\"},\"github\":{\"siteName\":\"GitHub\",\"handle\":\"github\",\"url\":\"\"},\"vimeo\":{\"siteName\":\"Vimeo\",\"handle\":\"vimeo\",\"url\":\"\"}},\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}','{\"MetaTagContainergeneral\":{\"data\":{\"generator\":{\"charset\":\"\",\"content\":\"SEOmatic\",\"httpEquiv\":\"\",\"name\":\"generator\",\"property\":null,\"include\":true,\"key\":\"generator\",\"environment\":null,\"dependencies\":{\"config\":[\"generatorEnabled\"]}},\"keywords\":{\"charset\":\"\",\"content\":\"{seomatic.meta.seoKeywords}\",\"httpEquiv\":\"\",\"name\":\"keywords\",\"property\":null,\"include\":true,\"key\":\"keywords\",\"environment\":null,\"dependencies\":null},\"description\":{\"charset\":\"\",\"content\":\"{seomatic.meta.seoDescription}\",\"httpEquiv\":\"\",\"name\":\"description\",\"property\":null,\"include\":true,\"key\":\"description\",\"environment\":null,\"dependencies\":null},\"referrer\":{\"charset\":\"\",\"content\":\"{seomatic.site.referrer}\",\"httpEquiv\":\"\",\"name\":\"referrer\",\"property\":null,\"include\":true,\"key\":\"referrer\",\"environment\":null,\"dependencies\":null},\"robots\":{\"charset\":\"\",\"content\":\"{seomatic.meta.robots}\",\"httpEquiv\":\"\",\"name\":\"robots\",\"property\":null,\"include\":true,\"key\":\"robots\",\"environment\":{\"live\":{\"content\":\"{seomatic.meta.robots}\"},\"staging\":{\"content\":\"none\"},\"local\":{\"content\":\"none\"}},\"dependencies\":null}},\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":{\"fb:profile_id\":{\"charset\":\"\",\"content\":\"{seomatic.site.facebookProfileId}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"fb:profile_id\",\"include\":true,\"key\":\"fb:profile_id\",\"environment\":null,\"dependencies\":null},\"fb:app_id\":{\"charset\":\"\",\"content\":\"{seomatic.site.facebookAppId}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"fb:app_id\",\"include\":true,\"key\":\"fb:app_id\",\"environment\":null,\"dependencies\":null},\"og:locale\":{\"charset\":\"\",\"content\":\"{{ craft.app.language |replace({\\\"-\\\": \\\"_\\\"}) }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:locale\",\"include\":true,\"key\":\"og:locale\",\"environment\":null,\"dependencies\":null},\"og:locale:alternate\":{\"charset\":\"\",\"content\":\"\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:locale:alternate\",\"include\":true,\"key\":\"og:locale:alternate\",\"environment\":null,\"dependencies\":null},\"og:site_name\":{\"charset\":\"\",\"content\":\"{seomatic.site.siteName}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:site_name\",\"include\":true,\"key\":\"og:site_name\",\"environment\":null,\"dependencies\":null},\"og:type\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogType}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:type\",\"include\":true,\"key\":\"og:type\",\"environment\":null,\"dependencies\":null},\"og:url\":{\"charset\":\"\",\"content\":\"{seomatic.meta.canonicalUrl}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:url\",\"include\":true,\"key\":\"og:url\",\"environment\":null,\"dependencies\":null},\"og:title\":{\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.ogSiteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"charset\":\"\",\"content\":\"{seomatic.meta.ogTitle}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:title\",\"include\":true,\"key\":\"og:title\",\"environment\":null,\"dependencies\":null},\"og:description\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogDescription}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:description\",\"include\":true,\"key\":\"og:description\",\"environment\":null,\"dependencies\":null},\"og:image\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImage}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image\",\"include\":true,\"key\":\"og:image\",\"environment\":null,\"dependencies\":null},\"og:image:width\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImageWidth}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:width\",\"include\":true,\"key\":\"og:image:width\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]}},\"og:image:height\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImageHeight}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:height\",\"include\":true,\"key\":\"og:image:height\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]}},\"og:image:alt\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImageDescription}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:alt\",\"include\":true,\"key\":\"og:image:alt\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]}},\"og:see_also\":{\"charset\":\"\",\"content\":\"\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:see_also\",\"include\":true,\"key\":\"og:see_also\",\"environment\":null,\"dependencies\":null}},\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":{\"twitter:card\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterCard}\",\"httpEquiv\":\"\",\"name\":\"twitter:card\",\"property\":null,\"include\":true,\"key\":\"twitter:card\",\"environment\":null,\"dependencies\":null},\"twitter:site\":{\"charset\":\"\",\"content\":\"@{seomatic.site.twitterHandle}\",\"httpEquiv\":\"\",\"name\":\"twitter:site\",\"property\":null,\"include\":true,\"key\":\"twitter:site\",\"environment\":null,\"dependencies\":{\"site\":[\"twitterHandle\"]}},\"twitter:creator\":{\"charset\":\"\",\"content\":\"@{seomatic.meta.twitterCreator}\",\"httpEquiv\":\"\",\"name\":\"twitter:creator\",\"property\":null,\"include\":true,\"key\":\"twitter:creator\",\"environment\":null,\"dependencies\":{\"meta\":[\"twitterCreator\"]}},\"twitter:title\":{\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.twitterSiteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"charset\":\"\",\"content\":\"{seomatic.meta.twitterTitle}\",\"httpEquiv\":\"\",\"name\":\"twitter:title\",\"property\":null,\"include\":true,\"key\":\"twitter:title\",\"environment\":null,\"dependencies\":null},\"twitter:description\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterDescription}\",\"httpEquiv\":\"\",\"name\":\"twitter:description\",\"property\":null,\"include\":true,\"key\":\"twitter:description\",\"environment\":null,\"dependencies\":null},\"twitter:image\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImage}\",\"httpEquiv\":\"\",\"name\":\"twitter:image\",\"property\":null,\"include\":true,\"key\":\"twitter:image\",\"environment\":null,\"dependencies\":null},\"twitter:image:width\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImageWidth}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:width\",\"property\":null,\"include\":true,\"key\":\"twitter:image:width\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]}},\"twitter:image:height\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImageHeight}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:height\",\"property\":null,\"include\":true,\"key\":\"twitter:image:height\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]}},\"twitter:image:alt\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImageDescription}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:alt\",\"property\":null,\"include\":true,\"key\":\"twitter:image:alt\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]}}},\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":{\"site\":[\"twitterHandle\"]},\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":{\"google-site-verification\":{\"charset\":\"\",\"content\":\"{seomatic.site.googleSiteVerification}\",\"httpEquiv\":\"\",\"name\":\"google-site-verification\",\"property\":null,\"include\":true,\"key\":\"google-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"googleSiteVerification\"]}},\"bing-site-verification\":{\"charset\":\"\",\"content\":\"{seomatic.site.bingSiteVerification}\",\"httpEquiv\":\"\",\"name\":\"msvalidate.01\",\"property\":null,\"include\":true,\"key\":\"bing-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"bingSiteVerification\"]}},\"pinterest-site-verification\":{\"charset\":\"\",\"content\":\"{seomatic.site.pinterestSiteVerification}\",\"httpEquiv\":\"\",\"name\":\"p:domain_verify\",\"property\":null,\"include\":true,\"key\":\"pinterest-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"pinterestSiteVerification\"]}}},\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":{\"canonical\":{\"crossorigin\":\"\",\"href\":\"{seomatic.meta.canonicalUrl}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"canonical\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"canonical\",\"environment\":null,\"dependencies\":null},\"home\":{\"crossorigin\":\"\",\"href\":\"{{ seomatic.helper.siteUrl(\\\"/\\\") }}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"home\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"home\",\"environment\":null,\"dependencies\":null},\"author\":{\"crossorigin\":\"\",\"href\":\"{{ seomatic.helper.siteUrl(\\\"/humans.txt\\\") }}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"author\",\"sizes\":\"\",\"type\":\"text/plain\",\"include\":true,\"key\":\"author\",\"environment\":null,\"dependencies\":{\"frontend_template\":[\"humans\"]}},\"publisher\":{\"crossorigin\":\"\",\"href\":\"{seomatic.site.googlePublisherLink}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"publisher\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"publisher\",\"environment\":null,\"dependencies\":{\"site\":[\"googlePublisherLink\"]}}},\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":{\"googleAnalytics\":{\"name\":\"Google Analytics\",\"description\":\"Google Analytics gives you the digital analytics tools you need to analyze data from all touchpoints in one place, for a deeper understanding of the customer experience. You can then share the insights that matter with your whole organization. [Learn More](https://www.google.com/analytics/analytics/)\",\"templatePath\":\"_frontend/scripts/googleAnalytics.twig\",\"templateString\":\"{% if trackingId.value is defined and trackingId.value %}\\n(function(i,s,o,g,r,a,m){i[\'GoogleAnalyticsObject\']=r;i[r]=i[r]||function(){\\n(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),\\nm=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)\\n})(window,document,\'script\',\'{{ analyticsUrl.value }}\',\'ga\');\\nga(\'create\', \'{{ trackingId.value |raw }}\', \'auto\'{% if linker.value %}, {allowLinker: true}{% endif %});\\n{% if ipAnonymization.value %}\\nga(\'set\', \'anonymizeIp\', true);\\n{% endif %}\\n{% if displayFeatures.value %}\\nga(\'require\', \'displayfeatures\');\\n{% endif %}\\n{% if ecommerce.value %}\\nga(\'require\', \'ecommerce\');\\n{% endif %}\\n{% if enhancedEcommerce.value %}\\nga(\'require\', \'ec\');\\n{% endif %}\\n{% if enhancedLinkAttribution.value %}\\nga(\'require\', \'linkid\');\\n{% endif %}\\n{% if enhancedLinkAttribution.value %}\\nga(\'require\', \'linker\');\\n{% endif %}\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if pageView %}\\nga(\'send\', \'pageview\');\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":null,\"bodyTemplateString\":null,\"bodyPosition\":2,\"vars\":{\"trackingId\":{\"title\":\"Google Analytics Tracking ID\",\"instructions\":\"Only enter the ID, e.g.: `UA-XXXXXX-XX`, not the entire script code. [Learn More](https://support.google.com/analytics/answer/1032385?hl=e)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Google Analytics PageView\",\"instructions\":\"Controls whether the Google Analytics script automatically sends a PageView to Google Analytics when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"ipAnonymization\":{\"title\":\"Google Analytics IP Anonymization\",\"instructions\":\"When a customer of Analytics requests IP address anonymization, Analytics anonymizes the address as soon as technically feasible at the earliest possible stage of the collection network.\",\"type\":\"bool\",\"value\":false},\"displayFeatures\":{\"title\":\"Display Features\",\"instructions\":\"The display features plugin for analytics.js can be used to enable Advertising Features in Google Analytics, such as Remarketing, Demographics and Interest Reporting, and more. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/display-features)\",\"type\":\"bool\",\"value\":false},\"ecommerce\":{\"title\":\"Ecommerce\",\"instructions\":\"Ecommerce tracking allows you to measure the number of transactions and revenue that your website generates. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/ecommerce)\",\"type\":\"bool\",\"value\":false},\"enhancedEcommerce\":{\"title\":\"Enhanced Ecommerce\",\"instructions\":\"The enhanced ecommerce plug-in for analytics.js enables the measurement of user interactions with products on ecommerce websites across the user\'s shopping experience, including: product impressions, product clicks, viewing product details, adding a product to a shopping cart, initiating the checkout process, transactions, and refunds. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/enhanced-ecommerce)\",\"type\":\"bool\",\"value\":false},\"enhancedLinkAttribution\":{\"title\":\"Enhanced Link Attribution\",\"instructions\":\"Enhanced Link Attribution improves the accuracy of your In-Page Analytics report by automatically differentiating between multiple links to the same URL on a single page by using link element IDs. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/enhanced-link-attribution)\",\"type\":\"bool\",\"value\":false},\"linker\":{\"title\":\"Linker\",\"instructions\":\"The linker plugin simplifies the process of implementing cross-domain tracking as described in the Cross-domain Tracking guide for analytics.js. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/linker)\",\"type\":\"bool\",\"value\":false},\"analyticsUrl\":{\"title\":\"Google Analytics Script URL\",\"instructions\":\"The URL to the Google Analytics tracking script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.google-analytics.com/analytics.js\"}},\"dataLayer\":[],\"include\":false,\"key\":\"googleAnalytics\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"nonce\":null},\"gtag\":{\"name\":\"Google gtag.js\",\"description\":\"The global site tag (gtag.js) is a JavaScript tagging framework and API that allows you to send event data to AdWords, DoubleClick, and Google Analytics. Instead of having to manage multiple tags for different products, you can use gtag.js and more easily benefit from the latest tracking features and integrations as they become available. [Learn More](https://developers.google.com/gtagjs/)\",\"templatePath\":\"_frontend/scripts/gtagHead.twig\",\"templateString\":\"{% set gtagProperty = googleAnalyticsId.value ?? googleAdWordsId.value ?? dcFloodlightId.value ?? null %}\\n{% if gtagProperty %}\\nwindow.dataLayer = window.dataLayer || [{% if dataLayer is defined and dataLayer %}{{ dataLayer |json_encode() |raw }}{% endif %}];\\nfunction gtag(){dataLayer.push(arguments)};\\ngtag(\'js\', new Date());\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if googleAnalyticsId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'anonymize_ip\': #{ipAnonymization.value ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'link_attribution\': #{enhancedLinkAttribution.value ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'allow_display_features\': #{displayFeatures.value ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ googleAnalyticsId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% if googleAdWordsId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ googleAdWordsId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% if dcFloodlightId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ dcFloodlightId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/gtagBody.twig\",\"bodyTemplateString\":\"{% set gtagProperty = googleAnalyticsId.value ?? googleAdWordsId.value ?? dcFloodlightId.value ?? null %}\\n{% if gtagProperty %}\\n<script async src=\\\"{{ gtagScriptUrl.value }}?id={{ gtagProperty }}\\\"></script>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"googleAnalyticsId\":{\"title\":\"Google Analytics Tracking ID\",\"instructions\":\"Only enter the ID, e.g.: `UA-XXXXXX-XX`, not the entire script code. [Learn More](https://support.google.com/analytics/answer/1032385?hl=e)\",\"type\":\"string\",\"value\":\"\"},\"googleAdWordsId\":{\"title\":\"AdWords Conversion ID\",\"instructions\":\"Only enter the ID, e.g.: `AW-XXXXXXXX`, not the entire script code. [Learn More](https://developers.google.com/adwords-remarketing-tag/)\",\"type\":\"string\",\"value\":\"\"},\"dcFloodlightId\":{\"title\":\"DoubleClick Floodlight ID\",\"instructions\":\"Only enter the ID, e.g.: `DC-XXXXXXXX`, not the entire script code. [Learn More](https://support.google.com/dcm/partner/answer/7568534)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send PageView\",\"instructions\":\"Controls whether the `gtag.js` script automatically sends a PageView to Google Analytics, AdWords, and DoubleClick Floodlight when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"ipAnonymization\":{\"title\":\"Google Analytics IP Anonymization\",\"instructions\":\"In some cases, you might need to anonymize the IP addresses of hits sent to Google Analytics. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/ip-anonymization)\",\"type\":\"bool\",\"value\":false},\"displayFeatures\":{\"title\":\"Google Analytics Display Features\",\"instructions\":\"The display features plugin for gtag.js can be used to enable Advertising Features in Google Analytics, such as Remarketing, Demographics and Interest Reporting, and more. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/display-features)\",\"type\":\"bool\",\"value\":false},\"enhancedLinkAttribution\":{\"title\":\"Google Analytics Enhanced Link Attribution\",\"instructions\":\"Enhanced link attribution improves click track reporting by automatically differentiating between multiple link clicks that have the same URL on a given page. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/enhanced-link-attribution)\",\"type\":\"bool\",\"value\":false},\"gtagScriptUrl\":{\"title\":\"Google gtag.js Script URL\",\"instructions\":\"The URL to the Google gtag.js tracking script. Normally this should not be changed, unless you locally cache it. The JavaScript `dataLayer` will automatically be set to the `dataLayer` Twig template variable.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/gtag/js\"}},\"dataLayer\":[],\"include\":false,\"key\":\"gtag\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"nonce\":null},\"googleTagManager\":{\"name\":\"Google Tag Manager\",\"description\":\"Google Tag Manager is a tag management system that allows you to quickly and easily update tags and code snippets on your website. Once the Tag Manager snippet has been added to your website or mobile app, you can configure tags via a web-based user interface without having to alter and deploy additional code. [Learn More](https://support.google.com/tagmanager/answer/6102821?hl=en)\",\"templatePath\":\"_frontend/scripts/googleTagManagerHead.twig\",\"templateString\":\"{% if googleTagManagerId.value is defined and googleTagManagerId.value and not seomatic.helper.isPreview %}\\n{{ dataLayerVariableName.value }} = [{% if dataLayer is defined and dataLayer %}{{ dataLayer |json_encode() |raw }}{% endif %}];\\n(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({\'gtm.start\':\\nnew Date().getTime(),event:\'gtm.js\'});var f=d.getElementsByTagName(s)[0],\\nj=d.createElement(s),dl=l!=\'dataLayer\'?\'&l=\'+l:\'\';j.async=true;j.src=\\n\'{{ googleTagManagerUrl.value }}?id=\'+i+dl;f.parentNode.insertBefore(j,f);\\n})(window,document,\'script\',\'{{ dataLayerVariableName.value }}\',\'{{ googleTagManagerId.value }}\');\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/googleTagManagerBody.twig\",\"bodyTemplateString\":\"{% if googleTagManagerId.value is defined and googleTagManagerId.value and not seomatic.helper.isPreview %}\\n<noscript><iframe src=\\\"{{ googleTagManagerNoScriptUrl.value }}?id={{ googleTagManagerId.value }}\\\"\\nheight=\\\"0\\\" width=\\\"0\\\" style=\\\"display:none;visibility:hidden\\\"></iframe></noscript>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"googleTagManagerId\":{\"title\":\"Google Tag Manager ID\",\"instructions\":\"Only enter the ID, e.g.: `GTM-XXXXXX`, not the entire script code. [Learn More](https://developers.google.com/tag-manager/quickstart)\",\"type\":\"string\",\"value\":\"\"},\"dataLayerVariableName\":{\"title\":\"DataLayer Variable Name\",\"instructions\":\"The name to use for the JavaScript DataLayer variable. The value of this variable will be set to the `dataLayer` Twig template variable.\",\"type\":\"string\",\"value\":\"dataLayer\"},\"googleTagManagerUrl\":{\"title\":\"Google Tag Manager Script URL\",\"instructions\":\"The URL to the Google Tag Manager script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/gtm.js\"},\"googleTagManagerNoScriptUrl\":{\"title\":\"Google Tag Manager Script &lt;noscript&gt; URL\",\"instructions\":\"The URL to the Google Tag Manager `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/ns.html\"}},\"dataLayer\":[],\"include\":false,\"key\":\"googleTagManager\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"nonce\":null},\"facebookPixel\":{\"name\":\"Facebook Pixel\",\"description\":\"The Facebook pixel is an analytics tool that helps you measure the effectiveness of your advertising. You can use the Facebook pixel to understand the actions people are taking on your website and reach audiences you care about. [Learn More](https://www.facebook.com/business/help/651294705016616)\",\"templatePath\":\"_frontend/scripts/facebookPixelHead.twig\",\"templateString\":\"{% if facebookPixelId.value is defined and facebookPixelId.value %}\\n!function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?\\nn.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;\\nn.push=n;n.loaded=!0;n.version=\'2.0\';n.queue=[];t=b.createElement(e);t.async=!0;\\nt.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,\\ndocument,\'script\',\'{{ facebookPixelUrl.value }}\');\\nfbq(\'init\', \'{{ facebookPixelId.value }}\');\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if pageView %}\\nfbq(\'track\', \'PageView\');\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/facebookPixelBody.twig\",\"bodyTemplateString\":\"{% if facebookPixelId.value is defined and facebookPixelId.value %}\\n<noscript><img height=\\\"1\\\" width=\\\"1\\\" style=\\\"display:none\\\"\\nsrc=\\\"{{ facebookPixelNoScriptUrl.value }}?id={{ facebookPixelId.value }}&ev=PageView&noscript=1\\\" /></noscript>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"facebookPixelId\":{\"title\":\"Facebook Pixel ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://developers.facebook.com/docs/facebook-pixel/api-reference)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Facebook Pixel PageView\",\"instructions\":\"Controls whether the Facebook Pixel script automatically sends a PageView to Facebook Analytics when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"facebookPixelUrl\":{\"title\":\"Facebook Pixel Script URL\",\"instructions\":\"The URL to the Facebook Pixel script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://connect.facebook.net/en_US/fbevents.js\"},\"facebookPixelNoScriptUrl\":{\"title\":\"Facebook Pixel Script &lt;noscript&gt; URL\",\"instructions\":\"The URL to the Facebook Pixel `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.facebook.com/tr\"}},\"dataLayer\":[],\"include\":false,\"key\":\"facebookPixel\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"nonce\":null},\"linkedInInsight\":{\"name\":\"LinkedIn Insight\",\"description\":\"The LinkedIn Insight Tag is a lightweight JavaScript tag that powers conversion tracking, retargeting, and web analytics for LinkedIn ad campaigns.\",\"templatePath\":\"_frontend/scripts/linkedInInsightHead.twig\",\"templateString\":\"{% if dataPartnerId.value is defined and dataPartnerId.value %}\\n_linkedin_data_partner_id = \\\"{{ dataPartnerId.value }}\\\";\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/linkedInInsightBody.twig\",\"bodyTemplateString\":\"{% if dataPartnerId.value is defined and dataPartnerId.value %}\\n<script type=\\\"text/javascript\\\">\\n(function(){var s = document.getElementsByTagName(\\\"script\\\")[0];\\n    var b = document.createElement(\\\"script\\\");\\n    b.type = \\\"text/javascript\\\";b.async = true;\\n    b.src = \\\"{{ linkedInInsightUrl.value }}\\\";\\n    s.parentNode.insertBefore(b, s);})();\\n</script>\\n<noscript>\\n<img height=\\\"1\\\" width=\\\"1\\\" style=\\\"display:none;\\\" alt=\\\"\\\" src=\\\"{{ linkedInInsightNoScriptUrl.value }}?pid={{ dataPartnerId.value }}&fmt=gif\\\" />\\n</noscript>\\n{% endif %}\\n\",\"bodyPosition\":3,\"vars\":{\"dataPartnerId\":{\"title\":\"LinkedIn Data Partner ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://www.linkedin.com/help/lms/answer/65513/adding-the-linkedin-insight-tag-to-your-website?lang=en)\",\"type\":\"string\",\"value\":\"\"},\"linkedInInsightUrl\":{\"title\":\"LinkedIn Insight Script URL\",\"instructions\":\"The URL to the LinkedIn Insight script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://snap.licdn.com/li.lms-analytics/insight.min.js\"},\"linkedInInsightNoScriptUrl\":{\"title\":\"LinkedIn Insight &lt;noscript&gt; URL\",\"instructions\":\"The URL to the LinkedIn Insight `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://dc.ads.linkedin.com/collect/\"}},\"dataLayer\":[],\"include\":false,\"key\":\"linkedInInsight\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"nonce\":null},\"hubSpot\":{\"name\":\"HubSpot\",\"description\":\"If you\'re not hosting your entire website on HubSpot, or have pages on your website that are not hosted on HubSpot, you\'ll need to install the HubSpot tracking code on your non-HubSpot pages in order to capture those analytics.\",\"templatePath\":null,\"templateString\":null,\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/hubSpotBody.twig\",\"bodyTemplateString\":\"{% if hubSpotId.value is defined and hubSpotId.value %}\\n<script type=\\\"text/javascript\\\" id=\\\"hs-script-loader\\\" async defer src=\\\"{{ hubSpotUrl.value }}{{ hubSpotId.value }}.js\\\"></script>\\n{% endif %}\\n\",\"bodyPosition\":3,\"vars\":{\"hubSpotId\":{\"title\":\"HubSpot ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://knowledge.hubspot.com/articles/kcs_article/reports/install-the-hubspot-tracking-code)\",\"type\":\"string\",\"value\":\"\"},\"hubSpotUrl\":{\"title\":\"HubSpot Script URL\",\"instructions\":\"The URL to the HubSpot script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"//js.hs-scripts.com/\"}},\"dataLayer\":[],\"include\":false,\"key\":\"hubSpot\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"nonce\":null}},\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"issn\":null,\"about\":null,\"abstract\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"acquireLicensePage\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"conditionsOfAccess\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#identity\"},\"copyrightYear\":null,\"correction\":null,\"creativeWorkStatus\":null,\"creator\":{\"id\":\"{parseEnv(seomatic.site.creator.genericUrl)}#creator\"},\"dateCreated\":null,\"dateModified\":null,\"datePublished\":null,\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"encodingFormat\":null,\"exampleOfWork\":null,\"expires\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":null,\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"maintainer\":null,\"material\":null,\"materialExtent\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":null,\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sdDatePublished\":null,\"sdLicense\":null,\"sdPublisher\":null,\"sourceOrganization\":null,\"spatial\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporal\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"usageInfo\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.helper.siteLinksQueryInput()}\"},\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"graph\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null,\"nonce\":null},\"identity\":{\"actionableFeedbackPolicy\":null,\"address\":{\"type\":\"PostalAddress\",\"streetAddress\":\"{seomatic.site.identity.genericStreetAddress}\",\"addressLocality\":\"{seomatic.site.identity.genericAddressLocality}\",\"addressRegion\":\"{seomatic.site.identity.genericAddressRegion}\",\"postalCode\":\"{seomatic.site.identity.genericPostalCode}\",\"addressCountry\":\"{seomatic.site.identity.genericAddressCountry}\"},\"aggregateRating\":null,\"alumni\":null,\"areaServed\":null,\"award\":null,\"brand\":null,\"contactPoint\":null,\"correctionsPolicy\":null,\"department\":null,\"dissolutionDate\":null,\"diversityPolicy\":null,\"diversityStaffingReport\":null,\"duns\":\"{seomatic.site.identity.organizationDuns}\",\"email\":\"{seomatic.site.identity.genericEmail}\",\"employee\":null,\"ethicsPolicy\":null,\"event\":null,\"faxNumber\":null,\"founder\":\"{seomatic.site.identity.organizationFounder}\",\"foundingDate\":\"{seomatic.site.identity.organizationFoundingDate}\",\"foundingLocation\":\"{seomatic.site.identity.organizationFoundingLocation}\",\"funder\":null,\"globalLocationNumber\":null,\"hasCredential\":null,\"hasMerchantReturnPolicy\":null,\"hasOfferCatalog\":null,\"hasPOS\":null,\"interactionStatistic\":null,\"isicV4\":null,\"knowsAbout\":null,\"knowsLanguage\":null,\"legalName\":null,\"leiCode\":null,\"location\":null,\"logo\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.helper.socialTransform(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\")}\",\"width\":\"{seomatic.helper.socialTransformWidth(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\")}\",\"height\":\"{seomatic.helper.socialTransformHeight(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\")}\"},\"makesOffer\":null,\"member\":null,\"memberOf\":null,\"naics\":null,\"numberOfEmployees\":null,\"ownershipFundingInfo\":null,\"owns\":null,\"parentOrganization\":null,\"publishingPrinciples\":null,\"review\":null,\"seeks\":null,\"slogan\":null,\"sponsor\":null,\"subOrganization\":null,\"taxID\":null,\"telephone\":\"{seomatic.site.identity.genericTelephone}\",\"unnamedSourcesPolicy\":null,\"vatID\":null,\"additionalType\":null,\"alternateName\":\"{seomatic.site.identity.genericAlternateName}\",\"description\":\"{seomatic.site.identity.genericDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.site.identity.genericImage}\",\"width\":\"{seomatic.site.identity.genericImageWidth}\",\"height\":\"{seomatic.site.identity.genericImageHeight}\"},\"mainEntityOfPage\":null,\"name\":\"{seomatic.site.identity.genericName}\",\"potentialAction\":null,\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.site.identity.genericUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.site.identity.computedType}\",\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#identity\",\"graph\":null,\"include\":true,\"key\":\"identity\",\"environment\":null,\"dependencies\":null,\"nonce\":null},\"creator\":{\"actionableFeedbackPolicy\":null,\"address\":{\"type\":\"PostalAddress\",\"streetAddress\":\"{seomatic.site.creator.genericStreetAddress}\",\"addressLocality\":\"{seomatic.site.creator.genericAddressLocality}\",\"addressRegion\":\"{seomatic.site.creator.genericAddressRegion}\",\"postalCode\":\"{seomatic.site.creator.genericPostalCode}\",\"addressCountry\":\"{seomatic.site.creator.genericAddressCountry}\"},\"aggregateRating\":null,\"alumni\":null,\"areaServed\":null,\"award\":null,\"brand\":null,\"contactPoint\":null,\"correctionsPolicy\":null,\"department\":null,\"dissolutionDate\":null,\"diversityPolicy\":null,\"diversityStaffingReport\":null,\"duns\":\"{seomatic.site.creator.organizationDuns}\",\"email\":\"{seomatic.site.creator.genericEmail}\",\"employee\":null,\"ethicsPolicy\":null,\"event\":null,\"faxNumber\":null,\"founder\":\"{seomatic.site.creator.organizationFounder}\",\"foundingDate\":\"{seomatic.site.creator.organizationFoundingDate}\",\"foundingLocation\":\"{seomatic.site.creator.organizationFoundingLocation}\",\"funder\":null,\"globalLocationNumber\":null,\"hasCredential\":null,\"hasMerchantReturnPolicy\":null,\"hasOfferCatalog\":null,\"hasPOS\":null,\"interactionStatistic\":null,\"isicV4\":null,\"knowsAbout\":null,\"knowsLanguage\":null,\"legalName\":null,\"leiCode\":null,\"location\":null,\"logo\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.helper.socialTransform(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\")}\",\"width\":\"{seomatic.helper.socialTransformWidth(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\")}\",\"height\":\"{seomatic.helper.socialTransformHeight(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\")}\"},\"makesOffer\":null,\"member\":null,\"memberOf\":null,\"naics\":null,\"numberOfEmployees\":null,\"ownershipFundingInfo\":null,\"owns\":null,\"parentOrganization\":null,\"publishingPrinciples\":null,\"review\":null,\"seeks\":null,\"slogan\":null,\"sponsor\":null,\"subOrganization\":null,\"taxID\":null,\"telephone\":\"{seomatic.site.creator.genericTelephone}\",\"unnamedSourcesPolicy\":null,\"vatID\":null,\"additionalType\":null,\"alternateName\":\"{seomatic.site.creator.genericAlternateName}\",\"description\":\"{seomatic.site.creator.genericDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.site.creator.genericImage}\",\"width\":\"{seomatic.site.creator.genericImageWidth}\",\"height\":\"{seomatic.site.creator.genericImageHeight}\"},\"mainEntityOfPage\":null,\"name\":\"{seomatic.site.creator.genericName}\",\"potentialAction\":null,\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.site.creator.genericUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.site.creator.computedType}\",\"id\":\"{parseEnv(seomatic.site.creator.genericUrl)}#creator\",\"graph\":null,\"include\":true,\"key\":\"creator\",\"environment\":null,\"dependencies\":null,\"nonce\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}}','[]','{\"data\":{\"humans\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"/* TEAM */\\n\\nCreator: {{ seomatic.site.creator.genericName ?? \\\"n/a\\\" }}\\nURL: {{ seomatic.site.creator.genericUrl ?? \\\"n/a\\\" }}\\nDescription: {{ seomatic.site.creator.genericDescription ?? \\\"n/a\\\" }}\\n\\n/* THANKS */\\n\\nCraft CMS - https://craftcms.com\\nPixel & Tonic - https://pixelandtonic.com\\n\\n/* SITE */\\n\\nStandards: HTML5, CSS3\\nComponents: Craft CMS 3, Yii2, PHP, JavaScript, SEOmatic\\n\",\"siteId\":null,\"include\":true,\"handle\":\"humans\",\"path\":\"humans.txt\",\"template\":\"_frontend/pages/humans.twig\",\"controller\":\"frontend-template\",\"action\":\"humans\"},\"robots\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"# robots.txt for {{ siteUrl }}\\n\\nSitemap: {{ seomatic.helper.sitemapIndexForSiteId() }}\\n{% switch seomatic.config.environment %}\\n\\n{% case \\\"live\\\" %}\\n\\n# live - don\'t allow web crawlers to index cpresources/ or vendor/\\n\\nUser-agent: *\\nDisallow: /cpresources/\\nDisallow: /vendor/\\nDisallow: /.env\\nDisallow: /cache/\\n\\n{% case \\\"staging\\\" %}\\n\\n# staging - disallow all\\n\\nUser-agent: *\\nDisallow: /\\n\\n{% case \\\"local\\\" %}\\n\\n# local - disallow all\\n\\nUser-agent: *\\nDisallow: /\\n\\n{% default %}\\n\\n# default - don\'t allow web crawlers to index cpresources/ or vendor/\\n\\nUser-agent: *\\nDisallow: /cpresources/\\nDisallow: /vendor/\\nDisallow: /.env\\nDisallow: /cache/\\n\\n{% endswitch %}\\n\",\"siteId\":null,\"include\":true,\"handle\":\"robots\",\"path\":\"robots.txt\",\"template\":\"_frontend/pages/robots.twig\",\"controller\":\"frontend-template\",\"action\":\"robots\"},\"ads\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"# ads.txt file for {{ siteUrl }}\\n# More info: https://support.google.com/admanager/answer/7441288?hl=en\\n{{ siteUrl }},123,DIRECT\\n\",\"siteId\":null,\"include\":true,\"handle\":\"ads\",\"path\":\"ads.txt\",\"template\":\"_frontend/pages/ads.twig\",\"controller\":\"frontend-template\",\"action\":\"ads\"}},\"name\":\"Frontend Templates\",\"description\":\"Templates that are rendered on the frontend\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":\"SeomaticEditableTemplate\",\"include\":true,\"dependencies\":null,\"clearCache\":false}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebSite\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromCustom\",\"seoTitleField\":\"\",\"siteNamePositionSource\":\"fromCustom\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"fromCustom\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"fromCustom\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}'),(11,'2022-01-31 03:40:28','2022-01-31 03:40:28','cea651d5-308a-499a-9b8b-488a3290699b','1.0.26','categorygroup',2,'Category','category','category',NULL,'',1,'{\"1\":{\"id\":3,\"groupId\":2,\"siteId\":1,\"hasUrls\":1,\"uriFormat\":\"category/{slug}\",\"template\":null,\"language\":\"en-us\"},\"2\":{\"id\":4,\"groupId\":2,\"siteId\":2,\"hasUrls\":1,\"uriFormat\":\"category/{slug}\",\"template\":null,\"language\":\"es\"}}','2022-01-31 03:40:28','{\"language\":null,\"mainEntityOfPage\":\"WebPage\",\"seoTitle\":\"{category.title}\",\"siteNamePosition\":\"\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{category.url}\",\"robots\":\"all\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"ogImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary_large_image\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"twitterImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"inherited\":[],\"overrides\":[]}','{\"siteName\":\"plugindev\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"facebookSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}],\"inherited\":[],\"overrides\":[]}','{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"breadcrumb\":null,\"lastReviewed\":null,\"mainContentOfPage\":null,\"primaryImageOfPage\":null,\"relatedLink\":null,\"reviewedBy\":null,\"significantLink\":null,\"speakable\":null,\"specialty\":null,\"about\":null,\"abstract\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"acquireLicensePage\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"conditionsOfAccess\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#identity\"},\"copyrightYear\":\"{category.dateCreated |date(\\\"Y\\\")}\",\"correction\":null,\"creativeWorkStatus\":null,\"creator\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#creator\"},\"dateCreated\":false,\"dateModified\":\"{category.dateUpdated |atom}\",\"datePublished\":\"{category.dateCreated |atom}\",\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"encodingFormat\":null,\"exampleOfWork\":null,\"expires\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":\"{seomatic.meta.seoTitle}\",\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"maintainer\":null,\"material\":null,\"materialExtent\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#creator\"},\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sdDatePublished\":null,\"sdLicense\":null,\"sdPublisher\":null,\"sourceOrganization\":null,\"spatial\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporal\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"usageInfo\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.helper.siteLinksQueryInput()}\"},\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"graph\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}}','[]','{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null,\"clearCache\":false}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebPage\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromField\",\"seoTitleField\":\"title\",\"siteNamePositionSource\":\"sameAsGlobal\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"sameAsGlobal\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"sameAsGlobal\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}'),(12,'2022-01-31 03:40:28','2022-01-31 03:40:28','63a679d7-08c4-4e89-988f-6e1b9ca61e3e','1.0.26','categorygroup',2,'Category','category','category',NULL,'',2,'{\"1\":{\"id\":3,\"groupId\":2,\"siteId\":1,\"hasUrls\":1,\"uriFormat\":\"category/{slug}\",\"template\":null,\"language\":\"en-us\"},\"2\":{\"id\":4,\"groupId\":2,\"siteId\":2,\"hasUrls\":1,\"uriFormat\":\"category/{slug}\",\"template\":null,\"language\":\"es\"}}','2022-01-31 03:40:28','{\"language\":null,\"mainEntityOfPage\":\"WebPage\",\"seoTitle\":\"{category.title}\",\"siteNamePosition\":\"\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{category.url}\",\"robots\":\"all\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"ogImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary_large_image\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"twitterImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"inherited\":[],\"overrides\":[]}','{\"siteName\":\"plugindev\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"facebookSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}],\"inherited\":[],\"overrides\":[]}','{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"breadcrumb\":null,\"lastReviewed\":null,\"mainContentOfPage\":null,\"primaryImageOfPage\":null,\"relatedLink\":null,\"reviewedBy\":null,\"significantLink\":null,\"speakable\":null,\"specialty\":null,\"about\":null,\"abstract\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"acquireLicensePage\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"conditionsOfAccess\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#identity\"},\"copyrightYear\":\"{category.dateCreated |date(\\\"Y\\\")}\",\"correction\":null,\"creativeWorkStatus\":null,\"creator\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#creator\"},\"dateCreated\":false,\"dateModified\":\"{category.dateUpdated |atom}\",\"datePublished\":\"{category.dateCreated |atom}\",\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"encodingFormat\":null,\"exampleOfWork\":null,\"expires\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":\"{seomatic.meta.seoTitle}\",\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"maintainer\":null,\"material\":null,\"materialExtent\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#creator\"},\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sdDatePublished\":null,\"sdLicense\":null,\"sdPublisher\":null,\"sourceOrganization\":null,\"spatial\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporal\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"usageInfo\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.helper.siteLinksQueryInput()}\"},\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"graph\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}}','[]','{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null,\"clearCache\":false}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebPage\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromField\",\"seoTitleField\":\"title\",\"siteNamePositionSource\":\"sameAsGlobal\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"sameAsGlobal\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"sameAsGlobal\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}');
/*!40000 ALTER TABLE `seomatic_metabundles` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sequences`
--

LOCK TABLES `sequences` WRITE;
/*!40000 ALTER TABLE `sequences` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `sequences` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `shunnedmessages`
--

LOCK TABLES `shunnedmessages` WRITE;
/*!40000 ALTER TABLE `shunnedmessages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `shunnedmessages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sitegroups`
--

LOCK TABLES `sitegroups` WRITE;
/*!40000 ALTER TABLE `sitegroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sitegroups` VALUES (1,'plugindev','2020-03-27 13:22:43','2021-03-15 15:01:27',NULL,'f89601e9-4ba9-4a48-9e99-350aa9914912');
/*!40000 ALTER TABLE `sitegroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sites`
--

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sites` VALUES (1,1,1,1,'English','default','en-US',1,'@web/',1,'2020-03-27 13:22:43','2021-03-15 15:02:45',NULL,'5da841b1-ca0d-46ff-8bb1-04d6c889ac54'),(2,1,0,1,'Spanish','spanish','es',1,'@web/es',2,'2021-03-15 15:02:36','2021-03-15 15:02:36',NULL,'ec473f07-152f-423b-90df-ac425e6068a1');
/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `structureelements`
--

LOCK TABLES `structureelements` WRITE;
/*!40000 ALTER TABLE `structureelements` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `structureelements` VALUES (1,1,NULL,1,1,2,0,'2021-04-01 02:35:35','2022-01-31 03:40:28','49453ac8-b940-462b-9de9-8b45aa3efa99');
/*!40000 ALTER TABLE `structureelements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `structures`
--

LOCK TABLES `structures` WRITE;
/*!40000 ALTER TABLE `structures` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `structures` VALUES (1,NULL,'2021-04-01 02:35:21','2021-04-01 02:35:21','2022-01-31 03:40:28','720df5b4-5784-490a-b196-dcbd886a2803'),(2,NULL,'2022-01-31 03:40:28','2022-01-31 03:40:28',NULL,'7955d443-a120-44f2-bdbe-c741d59fadf4');
/*!40000 ALTER TABLE `structures` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `systemmessages`
--

LOCK TABLES `systemmessages` WRITE;
/*!40000 ALTER TABLE `systemmessages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `systemmessages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `taggroups`
--

LOCK TABLES `taggroups` WRITE;
/*!40000 ALTER TABLE `taggroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `taggroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `tokens`
--

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `usergroups`
--

LOCK TABLES `usergroups` WRITE;
/*!40000 ALTER TABLE `usergroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `usergroups_users`
--

LOCK TABLES `usergroups_users` WRITE;
/*!40000 ALTER TABLE `usergroups_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `usergroups_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpermissions`
--

LOCK TABLES `userpermissions` WRITE;
/*!40000 ALTER TABLE `userpermissions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `userpermissions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpermissions_usergroups`
--

LOCK TABLES `userpermissions_usergroups` WRITE;
/*!40000 ALTER TABLE `userpermissions_usergroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `userpermissions_usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpermissions_users`
--

LOCK TABLES `userpermissions_users` WRITE;
/*!40000 ALTER TABLE `userpermissions_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `userpermissions_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpreferences`
--

LOCK TABLES `userpreferences` WRITE;
/*!40000 ALTER TABLE `userpreferences` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `userpreferences` VALUES (1,'{\"language\":\"en-US\",\"locale\":null,\"weekStartDay\":\"1\",\"useShapes\":false,\"underlineLinks\":false,\"showFieldHandles\":false,\"enableDebugToolbarForSite\":false,\"enableDebugToolbarForCp\":false,\"showExceptionView\":false,\"profileTemplates\":false}');
/*!40000 ALTER TABLE `userpreferences` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `users` VALUES (1,'admin',NULL,'','','andrew@nystudio107.com','$2y$13$EuMO1jWoObzUT.7T6IMJ4.U1GB2uIGV8LbrzGKT/HEimvXCPC65Ji',1,0,0,0,'2022-03-17 16:12:39',NULL,NULL,NULL,'2021-03-01 03:52:45',NULL,1,NULL,NULL,NULL,0,'2021-03-15 14:57:00','2020-03-27 13:22:44','2022-03-17 16:12:39','6aaac777-3f7f-4a59-9f21-06bcb8de9a13');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `volumefolders`
--

LOCK TABLES `volumefolders` WRITE;
/*!40000 ALTER TABLE `volumefolders` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `volumefolders` VALUES (1,NULL,1,'Site','','2020-03-27 13:38:49','2020-03-27 13:38:49','06e0e3c7-6e7a-4bdd-8f29-c732a9b33766'),(2,NULL,NULL,'Temporary source',NULL,'2020-03-27 13:39:48','2020-03-27 13:39:48','2bb19851-ae57-499e-adf9-c1d0aec186ae'),(3,2,NULL,'user_1','user_1/','2020-03-27 13:39:48','2020-03-27 13:39:48','34f058d0-d16c-436b-8513-c46d815c95d0');
/*!40000 ALTER TABLE `volumefolders` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `volumes`
--

LOCK TABLES `volumes` WRITE;
/*!40000 ALTER TABLE `volumes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `volumes` VALUES (1,7,'Site','site','craft\\volumes\\Local',1,'@assetsUrl/assets/site','site',NULL,'{\"path\":\"@webroot/assets/site\"}',0,'2020-03-27 13:38:49','2021-03-15 16:13:40',NULL,'5c642d7e-b16b-4836-9575-668d75d242e5');
/*!40000 ALTER TABLE `volumes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `webperf_data_samples`
--

LOCK TABLES `webperf_data_samples` WRITE;
/*!40000 ALTER TABLE `webperf_data_samples` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `webperf_data_samples` VALUES (1,'2020-11-18 21:37:26','2020-11-18 21:37:27','ea0ce6d2-0729-438c-a965-aa494b278c10',8947159563722028624,1,'&#x1f6a7; Project | Homepage','http://localhost:8000/',NULL,NULL,NULL,1587,1736,1736,1689,2022,'??','Macintosh','Chrome 86.0.4240.198','OS X Catalina 10.15',0,1722,50,49,0,0,1672,488,9581568),(3,'2020-12-02 16:08:42','2020-12-02 16:08:42','4a9f192e-8cfa-4a02-8710-90cf1a0816cf',8824185223071447740,1,'&#x1f6a7; Project | Homepage','http://localhost:8000/',NULL,NULL,NULL,1189,1329,1329,1282,1525,'??','Macintosh','Chrome 87.0.4280.67','OS X Catalina 10.15',0,971,36,49,0,0,935,487,8870288),(4,'2020-12-06 22:47:55','2020-12-06 22:47:56','97d226f0-3c08-4411-864e-4c83a52fe704',5704165093160125832,1,'&#x1f6a7; Project | Homepage','http://localhost:8000/',NULL,NULL,NULL,1211,1409,1409,1308,1539,'??','Macintosh','Chrome 87.0.4280.67','OS X Catalina 10.15',0,1031,28,45,0,0,1002,488,8758504),(6,'2021-02-28 23:50:04','2021-02-28 23:50:05','ea368a63-7837-4705-a373-9769bdad7041',5021158955426407940,1,'&#x1f6a7; Project | Homepage','http://localhost:8000/',NULL,NULL,NULL,2438,2625,2625,2535,2540,'??','Macintosh','Chrome 88.0.4324.192','OS X 11.2',0,424,26,31,0,0,398,115,7669224),(7,'2021-03-02 00:00:19','2021-03-02 00:00:20','0ec9fd8c-1a9f-4fa6-844a-ff85e12deaeb',9066497417661839779,1,'&#x1f6a7; Project | Homepage','http://localhost:8000/',NULL,NULL,NULL,2735,NULL,NULL,2764,2780,'??','Macintosh','Chrome 88.0.4324.192','OS X 11.2',0,1741,91,50,0,0,1649,473,6527136),(8,'2021-03-02 00:00:30','2021-03-02 00:00:30','e1a76836-03ef-44ab-8a44-2ea663e0979b',6183991056336560919,1,'&#x1f6a7; Project | Homepage','http://localhost:8000/',NULL,NULL,NULL,484,532,532,520,536,'??','Macintosh','Chrome 88.0.4324.192','OS X 11.2',0,469,35,31,0,0,434,115,6195960),(10,'2021-03-03 15:51:51','2021-03-03 15:51:52','f02c49fb-a83c-45f4-b4e9-67dced5169a6',6164079075040411519,1,'&#x1f6a7; Project | Homepage','http://localhost:8000/',NULL,NULL,NULL,2817,2891,2891,2861,2866,'??','Macintosh','Chrome 88.0.4324.192','OS X 11.2',0,1576,101,57,0,0,1475,474,6416504),(12,'2021-03-04 18:47:56','2021-03-04 18:47:56','16ec8283-a3b2-4d1d-ae10-527b6e6a7d8f',6724523139216755323,1,'&#x1f6a7; Project | Homepage','http://localhost:8000/',NULL,NULL,NULL,3812,NULL,NULL,3864,3878,'??','Macintosh','Chrome 88.0.4324.192','OS X 11.2',0,3754,102,53,0,0,3652,476,6383096),(13,'2021-03-15 15:50:08','2021-03-15 15:50:08','2755a6dc-41fb-4c80-a40d-bafb660d1409',8084825374695554793,1,'&#x1f6a7; Project | Homepage','http://localhost:8000/',NULL,NULL,NULL,1752,1813,1813,1814,1842,'??','Macintosh','Chrome 89.0.4389.82','OS X 11.2',0,1227,34,61,0,0,1193,486,5286616),(14,'2021-03-15 15:50:37','2021-03-15 15:50:38','0931819f-85fd-4cf4-a28c-e838e2a2d080',8339846145763819515,1,'&#x1f6a7; Project | Homepage','http://localhost:8000/',NULL,NULL,NULL,653,721,721,685,686,'??','Macintosh','Chrome 89.0.4389.82','OS X 11.2',0,816,36,61,0,0,779,199,8754440),(15,'2021-03-15 15:50:44','2021-03-15 15:50:45','edd8ef72-bf67-4a3f-9bdd-5478da3237d8',4774729439798297718,1,'&#x1f6a7; Project','http://localhost:8000/blog',NULL,NULL,NULL,466,500,500,499,522,'??','Macintosh','Chrome 89.0.4389.82','OS X 11.2',0,267,20,37,0,0,246,340,3990056),(16,'2021-03-15 15:50:51','2021-03-15 15:50:51','629b7897-c19e-47aa-ae73-15d6e6fa25a6',4234256945667735932,1,'&#x1f6a7; Project | My first blog','http://localhost:8000/blog/my-first-blog',NULL,NULL,NULL,585,NULL,NULL,615,617,'??','Macintosh','Chrome 89.0.4389.82','OS X 11.2',0,365,34,65,0,0,330,393,3997232),(17,'2021-03-15 15:51:04','2021-03-15 15:51:05','a1579171-7a8c-4fd2-88dd-02843abcc1a2',2480923588497879388,2,'&#x1f6a7; Project | My first blog','http://localhost:8000/es/blog/my-first-blog',NULL,NULL,NULL,445,NULL,NULL,475,478,'??','Macintosh','Chrome 89.0.4389.82','OS X 11.2',0,195,25,40,0,0,170,369,4847616),(20,'2021-03-15 15:53:12','2021-03-15 15:53:12','217b8217-0f07-4e41-8d47-de40e2b36846',3355934282910147199,1,'&#x1f6a7; Project | My first blog','http://localhost:8000/blog/my-first-blog',NULL,NULL,NULL,548,605,605,590,591,'??','Macintosh','Chrome 89.0.4389.82','OS X 11.2',0,378,36,65,0,0,342,392,9078888);
/*!40000 ALTER TABLE `webperf_data_samples` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `webperf_error_samples`
--

LOCK TABLES `webperf_error_samples` WRITE;
/*!40000 ALTER TABLE `webperf_error_samples` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `webperf_error_samples` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `widgets`
--

LOCK TABLES `widgets` WRITE;
/*!40000 ALTER TABLE `widgets` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `widgets` VALUES (1,1,'craft\\widgets\\RecentEntries',1,NULL,'{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}',1,'2020-03-27 13:39:27','2020-03-27 13:39:27','2f8142d5-2827-4555-a01d-6febb92a5a37'),(2,1,'craft\\widgets\\CraftSupport',2,NULL,'[]',1,'2020-03-27 13:39:27','2020-03-27 13:39:27','ce3eb9de-186b-4978-afa5-ec0ed9dc8ddb'),(3,1,'craft\\widgets\\Updates',3,NULL,'[]',1,'2020-03-27 13:39:27','2020-03-27 13:39:27','8fe2cacd-6ad5-45be-a48d-c9c9ba814765'),(4,1,'craft\\widgets\\Feed',4,NULL,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2020-03-27 13:39:27','2020-03-27 13:39:27','fc1f719e-cf8d-4f24-a58f-d980812b3b32');
/*!40000 ALTER TABLE `widgets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping routines for database 'project_v3'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-03-17 16:35:06
