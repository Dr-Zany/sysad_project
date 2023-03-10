#!/bin/sh

while true; do
    if [ -f /etc/letsencrypt/live/sysad.zany.ch/cert.pem ]; then
        CERT_EXPIRATION_DATE=$(openssl x509 -in /etc/letsencrypt/live/sysad.zany.ch/cert.pem -noout -enddate | cut -d= -f 2 )
        CERT_EXPIRATION_DATE=${CERT_EXPIRATION_DATE%????}
        CERT_EXPIRATION_IN_SECONDS=$(date --date="$CERT_EXPIRATION_DATE" +%s)
        CURRENT_DATE_IN_SECONDS=$(date +%s)
        DIFFERENCE_IN_SECONDS=$((CERT_EXPIRATION_IN_SECONDS - CURRENT_DATE_IN_SECONDS))
        if [ $DIFFERENCE_IN_SECONDS -le 864000 ]; then
            certbot certonly --webroot -w /var/www/certbot --force-renewal --register-unsafely-without-email -d sysad.zany.ch --agree-tos
        else
            echo "cert valide untile $CERT_EXPIRATION_DATE"
        fi
    else
        certbot certonly --webroot -w /var/www/certbot --register-unsafely-without-email -d sysad.zany.ch --agree-tos
    fi
    sleep 86400
done