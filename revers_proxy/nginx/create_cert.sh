#!/bin/sh
set -e

DOMAIN=$DOMAIN

if [ ! -f /etc/letsencrypt/live/sysad.zany.ch/fullchain.pem ] || [ ! -f /etc/letsencrypt/live/sysad.zany.ch/privkey.pem ]; then
    mkdir -p /etc/letsencrypt/dummy/$DOMAIN
    openssl req -batch -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/letsencrypt/dummy/$DOMAIN/privkey.pem  -out /etc/letsencrypt/dummy/$DOMAIN/fullchain.pem
elif grep -wq "dummy" /etc/nginx/nginx.conf; then
    sed -i 's/dummy/live/' /etc/nginx/nginx.conf
fi

exec "$@"
