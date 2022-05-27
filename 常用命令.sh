#全库备份
mysqldump -uroot -p --all-databases --master-data=2 --single-transaction --quick --force --routines --triggers --events > /home/allbackupfile.sql

#备份特定库
mysqldump -uroot -p --databases DB1 DB2 --master-data=2 --single-transaction --quick --force --routines --triggers --events > /home/DB1backupfile.sql

#查看binlog
mysqlbinlog -v --base64-output=decode-rows /var/lib/mysql/master.000003 \
    --start-datetime="2019-03-01 00:00:00"  \
    --stop-datetime="2019-03-10 00:00:00"   \
    --start-position="5000"    \
    --stop-position="20000"

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

#my.cnf忽略大小写
lower_case_table_names=1

cat > /etc/yum.repos.d/mysql57.repo <<- 'EOF'
# Enable to use MySQL 5.7
[mysql-5.7-community]
name=MySQL 5.7 Community Server
baseurl=https://mirrors.tuna.tsinghua.edu.cn/mysql/yum/mysql-5.7-community-el7-$basearch/
enabled=1
gpgcheck=0
gpgkey=https://repo.mysql.com/RPM-GPG-KEY-mysql
EOF
yum install -y mysql-server

#innobackupex
yum install https://repo.percona.com/yum/percona-release-latest.noarch.rpm
yum install percona-xtrabackup-24

innobackupex --user=root --password=password --socket=/var/lib/mysql/mysql.sock --parallel=4 --no-timestamp /root/bak
innobackupex --apply-log /tmp/mysql/# 导入数据后，还要执行下整理操作
innobackupex --copy-back  /tmp/mysql/  # 将整理好的数据库文件导入到原先的mysql datadir里
chown mysql.mysql  /data/mysql/ -R
cat xtrabackup_info
mysql>reset master
mysql>SET @@GLOBAL.GTID_PURGED='uuid:seq';