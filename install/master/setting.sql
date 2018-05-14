################### Step 1 ###########################
UPDATE setting
SET value = '/var/www/library/data/Library/'
WHERE settingid = 33;

UPDATE setting
SET value = '123456'
WHERE settingid = 34;

UPDATE setting
SET value = 'tcp://10.70.70.213:50001'
WHERE settingid = 87;

UPDATE setting
SET value = 'tcp://10.70.70.213:9505'
WHERE settingid = 88;

UPDATE setting
SET value = 'nexcel'
WHERE settingid = 63;

UPDATE `setting`
SET `value` = 'Asia/Ho_Chi_Minh'
WHERE `settingid` = '11';

UPDATE `setting` 
SET `userSee`='0' 
WHERE `settingid` IN (11,70,82,67,63);

update user
set username= 'admin', userpassword=MD5('admin')
where userid=1;

UPDATE `pages` SET `asHome` = 0 WHERE name IN ('application','transition','dataset','template','task','module','help','mediamanager');
UPDATE `setting` SET `fieldType`='emails' WHERE `settingid`='18';

INSERT INTO `setting` (`settingid`, `setting`, `value`, `fieldType`, `helptext`, `options`, `cat`, `userChange`, `title`, `validation`, `ordering`, `default`, `userSee`, `type`) VALUES
(900, 'UPGRADE_LOCATION', '/var/www/web/SMS_Upgrade/', 'text', 'The fully qualified path to the CMS upgrade location.', NULL, 'upgrade', 1, 'Upgrade Location', 'required', 10, '', 1, 'string');

INSERT INTO `setting` (`settingid`, `setting`, `value`, `fieldType`, `helptext`, `options`, `cat`, `userChange`, `title`, `validation`, `ordering`, `default`, `userSee`, `type`) VALUES
(901, 'SMS_CLIENT_VERSION', '1.8.1.130', 'text', 'The upgrade package version.', NULL, 'upgrade', 1, 'Upgrade Version', 'required', 10, '', 1, 'string');

INSERT INTO `setting` (`settingid`, `setting`, `value`, `fieldType`, `helptext`, `options`, `cat`, `userChange`, `title`, `validation`, `ordering`, `default`, `userSee`, `type`) VALUES
(902, 'SMS_CLIENT_FILENAME', 'SMSClientInstaller.zip', 'text', 'The upgrade package name.', NULL, 'upgrade', 1, 'Upgrade Filename', 'required', 10, '', 1, 'string');

ALTER TABLE `display`
ADD `shop` varchar(200) NULL;

INSERT INTO `setting` (`settingid`, `setting`, `value`, `fieldType`, `helptext`, `options`, `cat`, `userChange`, `title`, `validation`, `ordering`, `default`, `userSee`, `type`) VALUES
(903, 'TOKEN', '', 'text', NULL, NULL, 'configuration', 1, 'Token', '', 200, '', 1, 'string');

CREATE TABLE `clientresourceusage` (
  `displayid` int(11) NOT NULL,
  `logdate` int(11) DEFAULT NULL,
  `cpuusage` tinyint(4) DEFAULT NULL,
  `ramtotal` bigint(20) DEFAULT NULL,
  `ramavailable` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

UPDATE `module`
SET defaultDuration = 86399
WHERE ModuleID = 5;

INSERT INTO `command` (`commandId`, `command`, `code`, `description`, `userId`) 
VALUES (1, 'Restart Player', 'RestartPlayer', 'Restart Player', 1);
INSERT INTO `command` (`commandId`, `command`, `code`, `description`, `userId`) 
VALUES (2, 'Upgrade Version', 'UpgradeVersion', 'Upgrade Version', 1);

CREATE TABLE IF NOT EXISTS `clientversion` (
  `versionId` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(15) NOT NULL,
  `fileName` varchar(100) NOT NULL,
  `description` varchar(2000) CHARACTER SET utf8 DEFAULT NULL,
  `uploadDate` int(11) NOT NULL,
  `uploadOwner` int(11) NOT NULL,
  `lastUpdateDate` int(11) DEFAULT NULL,
  `lastUpdateOwner` int(11) DEFAULT NULL,
  `retired` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`versionId`,`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

UPDATE `pages` SET title = 'Screens' WHERE pageID = 6;
UPDATE `pages` SET title = 'Screen Groups' WHERE pageID = 22;
UPDATE `pages` SET title = 'Screen Profiles' WHERE pageID = 30;

INSERT INTO `pages`(pageID, name, title, asHome)
VALUES(40, 'clientversion', 'Client Versions', 0);

update setting set helptext = 'Should the server send anonymous statistics back to the SMS project?' where settingid = 36;
update setting set helptext = 'Key used to distinguish each SMS instance. This is generated randomly based on the time you first installed SMS, and is completely untraceable.' where settingid = 37;
update setting set helptext = 'Should SMS send an email if a display is in an error state every time the maintenance script runs?' where settingid = 49;
update setting set helptext = 'Should SMS send future schedule information to clients?' where settingid = 50;

update setting set cat = 'configuration' where settingid = 900;
delete from setting where settingid = 901;
delete from setting where settingid = 902;

UPDATE `setting` SET `userSee`= 0 WHERE `settingid` in (900,33,64,65,47,48,36,38,59,60,71,72,73,77,78,79,84,89,93,74,62);

## Insert screen permission setting ###############################
INSERT INTO `setting` 
	(`setting`, 
	`value`, 
	`fieldType`, 
	`options`, 
	`cat`, 
	`userChange`, 
	`title`, 
	`validation`, 
	`ordering`, 
	`default`, 
	`userSee`, 
	`type`) 
	VALUES ('SCREEN_DEFAULT', 'public write', 'dropdown', 'public|public write|private', 'permissions', '1', 'Screens Permission', '', '25', 'public write', '1', 'word');
## end ###############################

UPDATE setting 
SET value = '/var/www/library/data/Upgrade/' WHERE settingid = 900;

ALTER TABLE `schedule` 
ADD COLUMN `commandAdditionalInfo` VARCHAR(2000) NULL AFTER `syncTimezone`;

ALTER TABLE `daypart` AUTO_INCREMENT = 2;

################### Step 2. Run this query after login on web admin ###########################
UPDATE `module` SET `Enabled`='0' WHERE `ModuleID` <> 5;
UPDATE `module` SET `Enabled`='1' WHERE `ModuleID` IN (5);
UPDATE `module` SET `Enabled`='1' WHERE `ModuleID`='2';

##################Insert a group of all screens###############################

SELECT @DisplayGroupId := MIN(DisplayGroupId) FROM displaygroup;

INSERT INTO displaygroup (DisplayGroup, IsDisplaySpecific, Description, `isDynamic`, `dynamicCriteria`, `userId`)
SELECT DISTINCT 'All Screens', 0, 'The group of all screens. Can not be modified!', 0, '', 0
FROM displaygroup
WHERE @DisplayGroupId <> 1;

SELECT @DisplayGroupId := MAX(DisplayGroupId) FROM displaygroup WHERE DisplayGroup = 'All Screens';

INSERT INTO `lkdgdg` (`parentId`, `childId`, `depth`) 
SELECT DISTINCT 1, 1, 0
FROM lkdgdg
WHERE @DisplayGroupId <> 1;

UPDATE displaygroup
SET DisplayGroupId = 1
WHERE DisplayGroupId = @DisplayGroupId AND @DisplayGroupId <> 1;

UPDATE displaygroup
SET DisplayGroup = 'All Screens', IsDisplaySpecific = 0, Description = 'The group of all screens. Can not be modified!', isDynamic = 0, dynamicCriteria = '', userId = 0
WHERE DisplayGroupId = 1;
######################end###############################