#全库备份
mysqldump -uroot -p --all-databases > /home/allbackupfile.sql

#授权
grant all privileges on *.* to 'root'@'%' identified by 'P@ssw0rd' with grant option;

#显示用户
SELECT DISTINCT CONCAT('User: ''',user,'''@''',host,''';') AS query FROM mysql.user;

#read_only
mysql -uroot -p -e 'set global read_only=1'
set global read_only=1;

#查看信息
show VARIABLES like '%version%';
show VARIABLES like '%read_only%';