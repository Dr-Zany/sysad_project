FROM nginx:1.23.3-alpine

RUN apk add --update openssl gettext \ 
 && rm -rf /var/cache/apk/*

RUN mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.disabled
COPY ./nginx.conf /etc/nginx/nginx.sample
COPY ./ssl-params.conf /etc/nginx/snippets/ssl-params.conf
COPY ./proxy_settings.conf /etc/nginx/snippets/proxy_settings.conf
COPY ./site /var/www/site
COPY ./create_cert.sh /create_cert.sh
COPY ./env_replace.sh /env_replace.sh
RUN chmod +x /create_cert.sh \
 && chmod +x /env_replace.sh
RUN mkdir /etc/letsencrypt

ENTRYPOINT ["/env_replace.sh", "/create_cert.sh", "/docker-entrypoint.sh", "nginx", "-g", "daemon off;"]
