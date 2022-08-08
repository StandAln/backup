#!/bin/bash

BACKUP_DIR=/backup
TO_BACKUP=/opt/scripts/create_user
BACKUP_DATE=$(date +'%d.%m.%Y_%H.%M')
BACKUP_FILE_NAME=$BACKUP_DIR/$(hostname)_$BACKUP_DATE.tar.gz
LOG_NAME=$BACKUP_DIR/backup.log
BACKUP_LOG_NAME=backup_$BACKUP_DATE.log.tar.gz


find $BACKUP_DIR -type f -mtime +30 -name '*.tar.gz' -delete
find $BACKUP_DIR -type f -size +1M -name '*.log' -execdir tar -czvf $BACKUP_LOG_NAME {} + 1>/dev/null
find $BACKUP_DIR -type f -size +1M -name '*.log' -delete
find $BACKUP_DIR -type f -mtime +60 -name '*.log.tar.gz' -delete
echo -e '\n'$BACKUP_DATE'\n'>>$LOG_NAME
tar -czvf $BACKUP_FILE_NAME -C $TO_BACKUP . 1>>$LOG_NAME