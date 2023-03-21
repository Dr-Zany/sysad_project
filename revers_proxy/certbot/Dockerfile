FROM certbot/certbot:v1.32.2

COPY ./renew_cert.sh /renew_cert.sh
RUN chmod +x /renew_cert.sh

# Schedule the script to run every day
RUN echo "0 0 * * * /renew_cert.sh" > /etc/crontabs/root

ENTRYPOINT [ "/renew_cert.sh", "crond", "-f", "-l", "8"]