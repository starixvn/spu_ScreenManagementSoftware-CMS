update setting
set value = '\\\\10.70.70.242\\www\\SPU\\SMS_Library\\' where settingid=33;

update setting
set value = '123456' where settingid=34;

update setting
set value = 'tcp://10.18.200.202:50001' where settingid=87;

update setting
set value = 'tcp://10.18.200.202:9505' where settingid=88;

update setting
set value = 'nexcel' where settingid=63;

update user
set username= 'admin', userpassword=MD5('admin')
where userid=1;

UPDATE `module` SET `Enabled`='0' WHERE `ModuleID` <> 5;
UPDATE `module` SET `Enabled`='1' WHERE `ModuleID` IN (5);

INSERT INTO `setting` (`settingid`, `setting`, `value`, `fieldType`, `helptext`, `options`, `cat`, `userChange`, `title`, `validation`, `ordering`, `default`, `userSee`, `type`) VALUES
(900, 'UPGRADE_LOCATION', '\\\\10.70.70.242\\www\\SPU\\SMS_UpgradeVersion\\', 'text', 'The fully qualified path to the CMS upgrade location.', NULL, 'upgrade', 1, 'Upgrade Location', 'required', 10, '', 1, 'string');

INSERT INTO `setting` (`settingid`, `setting`, `value`, `fieldType`, `helptext`, `options`, `cat`, `userChange`, `title`, `validation`, `ordering`, `default`, `userSee`, `type`) VALUES
(901, 'SMS_CLIENT_VERSION', '1.8.1.130', 'text', 'The upgrade package version.', NULL, 'upgrade', 1, 'Upgrade Version', 'required', 10, '', 1, 'string');

INSERT INTO `setting` (`settingid`, `setting`, `value`, `fieldType`, `helptext`, `options`, `cat`, `userChange`, `title`, `validation`, `ordering`, `default`, `userSee`, `type`) VALUES
(902, 'SMS_CLIENT_FILENAME', 'SMSClientInstaller.zip', 'text', 'The upgrade package name.', NULL, 'upgrade', 1, 'Upgrade Filename', 'required', 10, '', 1, 'string');