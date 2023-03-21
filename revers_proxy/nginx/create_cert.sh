#!/bin/sh
set -e

NX_DOMAIN=$NX_DOMAIN

if [ ! -f /etc/letsencrypt/live/$NX_DOMAIN/fullchain.pem ] || [ ! -f /etc/letsencrypt/live/$NX_DOMAIN/privkey.pem ]; then
    mkdir -p /etc/letsencrypt/dummy/$NX_DOMAIN
    openssl req -batch -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/letsencrypt/dummy/$NX_DOMAIN/privkey.pem  -out /etc/letsencrypt/dummy/$NX_DOMAIN/fullchain.pem
elif grep -wq "dummy" /etc/nginx/nginx.conf; then
    sed -i 's/dummy/live/' /etc/nginx/nginx.conf
fi

exec "$@"
