FROM nginx:1.23.3-alpine

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./ssl-params.conf /etc/nginx/snippets/ssl-params.conf
COPY ./enterypoint.sh /enterypoint.sh
RUN chmod +x /enterypoint.sh

ENTRYPOINT ["/entrypoint.sh"]