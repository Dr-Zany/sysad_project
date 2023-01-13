FROM alpine

# Update these variables with the correct values
ENV BU_REMOTE=user@server:/path/to/backup

# Install rsync and ssh
RUN apk add --update rsync openssh

COPY backup.sh /usr/local/bin/backup.sh
RUN chmod +x /usr/local/bin/backup.sh

# Schedule the script to run every day
RUN echo "0 0 * * * /usr/local/bin/backup.sh" > /etc/crontabs/root

# Start cron and tail to keep the container running
ENTRYPOINT ["crond", "-f", "-l", "8"]