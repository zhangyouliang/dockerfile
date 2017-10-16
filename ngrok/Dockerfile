FROM golang:1.9.1-alpine3.6

COPY repositories /etc/apk/repositories

ENV REPO https://github.com/prikevs/ngrok.git

RUN apk add --no-cache git zip make openssl \
    && [ -d /usr/local/ngrok ] || git clone ${REPO} /usr/local/ngrok \
    && mkdir /package \
    && rm -rf /usr/local/ngrok/assets/client/tls/*

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ENV NGROK_DOMAIN **NULL**

EXPOSE 80 443 4443

VOLUME ["/usr/local/ngrok/package","/usr/local/ngrok/assets/client/tls"]
# VOLUME []

WORKDIR /usr/local/ngrok

CMD ["docker-entrypoint.sh"]
