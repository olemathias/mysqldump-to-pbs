#!/bin/bash

rm -rf backup # Clean backup from previous run
mkdir -p backup
mysql -u "$MYSQL_USERNAME" -p"$MYSQL_PASSWORD" -h "$MYSQL_HOST" -N -e 'show databases' | grep -Ev 'information_schema|mysql|performance_schema|sys' | while read dbname; do echo "$dbname" && mysqldump -u "$MYSQL_USERNAME" -p"$MYSQL_PASSWORD" -h "$MYSQL_HOST" --complete-insert --routines --triggers --single-transaction "$dbname" > "backup/$dbname".sql; done
proxmox-backup-client backup mysqldump.pxar:/app/backup
