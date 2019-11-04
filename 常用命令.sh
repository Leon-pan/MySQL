#全库备份
mysqldump -uroot -p --all-databases > /home/allbackupfile.sql

#建库
create database jd_szmc default character set utf8;
grant all privileges on hive.* to 'hive'@'%' identified by 'hive_123#$';

#授权
grant all privileges on *.* to 'root'@'%' identified by 'P@ssw0rd' with grant option;

#显示用户
SELECT DISTINCT CONCAT('User: ''',user,'''@''',host,''';') AS query FROM mysql.user;

#查看权限
show grants for 'hive'@'%';

#删除用户
drop user 'hive'@'%';

#Mysql5.7降低密码策略
set global validate_password_policy=0;

#read_only
mysql -uroot -p -e 'set global read_only=1'
set global read_only=1;

#查看信息
show VARIABLES like '%version%';
show VARIABLES like '%read_only%';