update setting
set value = '\\\\10.70.70.242\\www\\SPU\\SMS_Library\\' where settingid=33;

update setting
set value = '123456' where settingid=34;

update user
set username= 'admin', userpassword=MD5('admin')
where userid=1;