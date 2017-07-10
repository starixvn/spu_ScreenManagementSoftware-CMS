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