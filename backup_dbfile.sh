#!/bin/bash
cd /home/mysql_data/mysql/
strdate=`date +%F`
mkdir -p /home/mysql_data/mysql_backup/dbfiles/${strdate}
cp -rf `ls |grep -v mysql-bin|grep -v sock` -t "/home/mysql_data/mysql_backup/dbfiles/${strdate}/"   #复制全数据库文件
cd /home/mysql_data/mysql_backup/dbfiles/
tar -czf ${strdate}.tar.gz ${strdate}  #打包压缩
rm -rf /home/mysql_data/mysql_backup/dbfiles/${strdate}  #删除原始文件
find /home/mysql_data/mysql_backup/dbfiles/ -mtime +30    -name "202*"  -exec rm -rf {} \;   #删除30天前的备份
exit 0