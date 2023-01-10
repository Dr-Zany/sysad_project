#!/bin/bash
set -e

if [ ! -f /etc/letsencrypt/live/sysad.zany.ch/fullchain.pem ] || [ ! -f /etc/letsencrypt/live/sysad.zany.ch/privkey.pem ]; then
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/letsencrypt/live/sysad.zany.ch/privkey.pem  -out /etc/letsencrypt/live/sysad.zany.ch/fullchain.pem
fi

exec "$@"