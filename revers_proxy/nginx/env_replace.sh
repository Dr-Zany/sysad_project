#!/bin/sh
set -e

envsubst < /etc/nginx/nginx.sample > /etc/nginx/nginx.conf

exec "$@"