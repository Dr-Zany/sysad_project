#!/bin/sh

# Update these variables with the correct values
REMOTE_SERVER=$REMOTE_SERVER

# Check if today is the first day of the month
if [ "$(date +%d -d tomorrow)" == "01" ]; then
    current_month_year=$(date +"%m-%Y")
    # Perform a full backup
    rsync -avz --delete -e "ssh -i /root/.ssh/id_rsa -p 22" /backup $REMOTE_SERVER/monthly/$current_month_year
    # Remove old backups
    ssh $REMOTE_SERVER "find /path/to/backup/monthly/* -maxdepth 0 -type d -not -path '/path/to/backup/monthly/$current_month_year' -printf '%T@ %p\n' | sort -n | head -n -12 | cut -f2- -d' ' | xargs rm -rf"

fi

# Check if today is the first day of the week
if [ "$(date +%u)" == "1" ]; then
    current_week=$(date +"week-%V-%Y")
    # Perform a full backup
    rsync -avz --delete -e "ssh -i /root/.ssh/id_rsa -p 22" /backup $REMOTE_SERVER/weekly/$current_week
    # Remove old backups
    ssh $REMOTE_SERVER "find /path/to/backup/weekly/* -maxdepth 0 -type d -not -path '/path/to/backup/weekly/$current_week' -printf '%T@ %p\n' | sort -n | head -n -4 | cut -f2- -d' ' | xargs rm -rf"
else
    current_day=$(date +"%Y-%m-%d")
    # Perform an incremental backup
    rsync -avz --delete -e "ssh -i /root/.ssh/id_rsa -p 22" --link-dest=$REMOTE_SERVER/weekly/$current_week /backup $REMOTE_SERVER/daily/$current_day
    # Remove old backups
    ssh $REMOTE_SERVER "find /path/to/backup/daily/* -maxdepth 0 -type d -not -path '/path/to/backup/daily/$current_day' -printf '%T@ %p\n| sort -n | head -n -7 | cut -f2- -d' ' | xargs rm -rf"
fi