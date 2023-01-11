#!/bin/sh
set -e

envsubst < /etc/nginx/nginx.conf > /etc/nginx/nginx.conf

exec "$@"