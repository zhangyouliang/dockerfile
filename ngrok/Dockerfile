FROM golang:1.9.1-alpine3.6

COPY repositories /etc/apk/repositories

ENV REPO https://github.com/prikevs/ngrok.git
ENV NGROK_HOME /usr/local/ngrok
ENV NGROK_CONFIG /etc/ngrok
RUN apk add --no-cache git zip make openssl \
    && git clone ${REPO} ${NGROK_HOME} \
    && rm -rf /usr/local/ngrok/assets/client/tls/*

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ENV NGROK_DOMAIN **NULL**

EXPOSE 80 443 4443

VOLUME ["/etc/ngrok"]

WORKDIR ${NGROK_HOME}

CMD ["docker-entrypoint.sh"]
