#!/bin/sh
set -e

if [ ! -f /etc/letsencrypt/live/sysad.zany.ch/fullchain.pem ] || [ ! -f /etc/letsencrypt/live/sysad.zany.ch/privkey.pem ]; then
    mkdir -p /etc/letsencrypt/dummy/sysad.zany.ch
    openssl req -batch -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/letsencrypt/dummy/sysad.zany.ch/privkey.pem  -out /etc/letsencrypt/dummy/sysad.zany.ch/fullchain.pem
elif grep -wq "dummy" /etc/nginx/nginx.conf; then
    sed -i 's/dummy/live/' /etc/nginx/nginx.conf
fi

exec "$@"
