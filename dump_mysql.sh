#!/bin/bash
cd /home/mysql_data/mysql/
filedate=`date +%F_%s`
mysqldump -udb_recovery -pRecovery_2019  --all-databases  --master-data=2 --single-transaction  --quick    --force    --routines --triggers --events   > /home/mysql_data/mysql_backup/dump/all_databases.sql.${filedate}   #备份全库
tar -czf /home/mysql_data/mysql_backup/dump/all_databases.sql.${filedate}.tar.gz  /home/mysql_data/mysql_backup/dump/all_databases.sql.${filedate}   #打包压缩
rm -rf /home/mysql_data/mysql_backup/dump/all_databases.sql.${filedate}  #删除原始文件
find /home/mysql_data/mysql_backup/dump/ -mtime +30  -name "all_databases.sql.*" -exec rm -rf {} \;  #删除30天前的备份
exit 0