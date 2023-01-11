FROM nginx:1.23.3-alpine

RUN apk add --update openssl \ 
 && rm -rf /var/cache/apk/*

RUN mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.disabled
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./ssl-params.conf /etc/nginx/snippets/ssl-params.conf
COPY ./site /var/www/site
COPY ./create_cert.sh /create_cert.sh
RUN chmod +x /create_cert.sh
RUN mkdir /etc/letsencrypt

ENTRYPOINT ["/create_cert.sh", "/docker-entrypoint.sh", "nginx", "-g", "daemon off;"]
