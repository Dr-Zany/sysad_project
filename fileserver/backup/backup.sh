#!/bin/bash

# Define variable for remote server
REMOTE_SERVER=$BU_REMOTE_SERVER
REMOTE_PATH=$BU_REMOTE_PATH

# Define variables for backup folders
MONTHLY_BACKUP_FOLDER=$REMOTE_SERVER:$REMOTE_PATH/monthly/
WEEKLY_BACKUP_FOLDER=$REMOTE_SERVER:$REMOTE_PATH/weekly/
DAILY_BACKUP_FOLDER=$REMOTE_SERVER:$REMOTE_PATH/daily/

# Define variable for local backup folder
LOCAL_BACKUP_FOLDER=/backup/

# Get current day of the week
DAY_OF_WEEK=$(date +%u)

# Get current day of the month
DAY_OF_MONTH=$(date +%d)

# Get current date
CURRENT_DATE=$(date +%Y-%m-%d)

# Full Backup (First Monday of the month)
if [ "$DAY_OF_WEEK" -eq 2 ] && [ "$DAY_OF_MONTH" -le 7 ]; then
  # Create monthly backup folder with current date
  MONTHLY_BACKUP_FOLDER_DATE=$MONTHLY_BACKUP_FOLDER$CURRENT_DATE
  ssh $REMOTE_SERVER "mkdir -p $MONTHLY_BACKUP_FOLDER_DATE"
  # Copy all files from local backup folder to monthly backup folder
  rsync -avz -e ssh --delete $LOCAL_BACKUP_FOLDER $MONTHLY_BACKUP_FOLDER_DATE
  # Remove all files from weekly and daily backup Folders
  ssh $REMOTE_SERVER "rm -rf $WEEKLY_BACKUP_FOLDER/*"
  ssh $REMOTE_SERVER "rm -rf $DAILY_BACKUP_FOLDER/*"
  # Remove older monthly backups
  ssh $REMOTE_SERVER "find $MONTHLY_BACKUP_FOLDER -maxdepth 1 -type d -mtime +30 -exec rm -rf {} \;"

# Differential Backup (Every Friday)
elif [ "$DAY_OF_WEEK" -eq 6 ]; then
  # Create weekly backup folder with
  # Create weekly backup folder with current date
  WEEKLY_BACKUP_FOLDER_DATE=$WEEKLY_BACKUP_FOLDER$CURRENT_DATE
  ssh user@remote-server "mkdir -p $WEEKLY_BACKUP_FOLDER_DATE"
  # Copy all files from local backup folder to weekly backup folder
  rsync -avz -e ssh --delete --link-dest=$MONTHLY_BACKUP_FOLDER$(ssh user@remote-server "ls -t $MONTHLY_BACKUP_FOLDER" | head -1) $LOCAL_BACKUP_FOLDER $WEEKLY_BACKUP_FOLDER_DATE
  # Remove all files from daily backup folder
  ssh user@remote-server "rm -rf $DAILY_BACKUP_FOLDER/*"
  # Remove older weekly backups
  ssh user@remote-server "find $WEEKLY_BACKUP_FOLDER -maxdepth 1 -type d -mtime +7 -exec rm -rf {} \;"

# Incremental Backup (Every weekday)
else
  # Create daily backup folder with current date
  DAILY_BACKUP_FOLDER_DATE=$DAILY_BACKUP_FOLDER$CURRENT_DATE
  ssh user@remote-server "mkdir -p $DAILY_BACKUP_FOLDER_DATE"
  # Copy all files from local backup folder to daily backup folder
  rsync -avz -e ssh --delete --link-dest=$WEEKLY_BACKUP_FOLDER$(ssh user@remote-server "ls -t $WEEKLY_BACKUP_FOLDER" | head -1) $LOCAL_BACKUP_FOLDER $DAILY_BACKUP_FOLDER_DATE
  # Remove older daily backups
  ssh user@remote-server "find $DAILY_BACKUP_FOLDER -maxdepth 1 -type d -mtime +1 -exec rm -rf {} \;"
fi