# README

This repository contains configuration files for a Nextcloud instance and a backup script.

## Why Nextcloud

Nextcloud is a fork of ownCloud, and it offers several advantages over its predecessor. Here are a few reasons why Nextcloud is considered to be a better choice:

- **Active Development**: Nextcloud is actively developed and maintained, with regular updates and new features being added. ownCloud, on the other hand, has not seen much development in recent years.

- **Security**: Nextcloud places a strong emphasis on security and privacy, and it has a dedicated security team that regularly releases security updates.

- **Flexibility**: Nextcloud is highly customizable and can be easily integrated with other services and apps. This allows users to tailor their Nextcloud instance to their specific needs.

- **Community Support**: Nextcloud has a large and active community of users and developers who contribute to the project and provide support to others.

- **Performance**: Nextcloud is designed to be more efficient and perform better than ownCloud, especially on large instances with many users and files.

Overall, Nextcloud offers a more stable, secure, and flexible solution for file storage and collaboration compared to ownCloud.


## .env
This file contains environment variables that are used to configure the Nextcloud instance and the backup script. The variables are as follows:

### Nextcloud
- **NC_ADMIN_USER**: the username for the Nextcloud administrator account.
- **NC_ADMIN_PASSWORD**: the password for the Nextcloud administrator account.
- **NC_TRUSTED_DOMAINS**: the trusted domain for the Nextcloud instance.
- **NC_OVERWRITEWEBROOT**: the webroot for the Nextcloud instance.
- **NC_OVERWRITEPROTOCOL**: the protocol for the Nextcloud instance.
- **NC_DEFAULT_LOCALE**: the default locale for the Nextcloud instance.
- **NC_DEFAULT_LANGUAGE**: the default language for the Nextcloud instance.
- **NC_DEFAULT_PHONE_REGION**: the default phone region for the Nextcloud instance.
- **NC_PHP_MEMORY_LIMIT**: the PHP memory limit for the Nextcloud instance.
- **NC_PHP_UPLOAD_LIMIT**: the PHP upload limit for the Nextcloud instance.

### Backup
- **BU_REMOT_USER**: the username for the remote server where the backups are stored.
- **BU_REMOTE_SERVER**: the remote server where the backups are stored.
- **BU_REMOTE_FOLDER**: the remote folder where the backups are stored.

## docker-compose.yaml
This file is used to configure and run the Nextcloud instance and the backup script as Docker containers. The file includes:

- **Volumes**: these are used to persist data for the Nextcloud instance and the backup script.
- **Services**: these are the Docker containers that run the Nextcloud instance and the backup script.
  - **nextcloud**: this service runs the Nextcloud instance and uses the environment variables from the .env file to configure it.
  - **backup**: this service runs the backup script and uses the environment variables from the .env file to configure it.

## Backup

The backup script in this repository, backup.sh, is designed to perform backups of the Nextcloud instance. The script is intended to be run as a cron job, and it checks the current date to determine when to perform the backup.

### Timing
 * If it's the first day of the month, the script performs a full backup of the entire directory specified in `/backup` and it will store the backup in the remote folder `/path/to/backup/monthly/` with the current month and year as the folder name. 
 * If it's the first day of the week, it will perform a full backup of the entire directory specified in `/backup` and it will store the backup in the remote folder `/path/to/backup/weekly/` with the current week name as the folder name. 
 * If it's not the first day of the month or week, it will perform an incremental backup using the `rsync` command and the `--link-dest` option, which creates hardlinks to files that haven't changed since the last backup, thus reducing the amount of data that needs to be transferred. The incremental backup will be stored in the remote folder `/path/to/backup/daily/` with the current date as the folder name.

### Retention
The script is configured to keep the last 12 monthly backups, 4 weeks of backups in the weekly folder and 7 days in the daily folder. This means that the backups from the current month and the previous 11 months will be retained in the monthly folder, the backups from the current week and the previous 3 weeks will be retained in the weekly folder, while the backups from older months and weeks will be deleted. It will keep backups from the last 7 days in the daily folder, and delete the older ones.


### Note
You need to update the BU_REMOTE variable with the correct values, and make sure the ssh key is present in the correct location, otherwise the backup will fail.

## Conclusion

In summary, this repository contains configuration files and a script that can be used to set up a Nextcloud instance and perform backups of the data. The .env file is used to configure the Nextcloud instance and the backup script, the docker-compose.yaml file is used to run the Nextcloud instance and the backup script as Docker containers, and the backup.sh script is used to perform the backups of the Next
