FROM alpine:3.5

COPY repositories /etc/apk/repositories

RUN mkdir /usr/local/src \
    && apk add --no-cache --update ca-certificates openssl \
    && update-ca-certificates \
    && wget -c -O /usr/local/src/pure-ftpd-1.0.47.tar.gz https://download.pureftpd.org/pub/pure-ftpd/releases/pure-ftpd-1.0.47.tar.gz \
    && tar -zvxf /usr/local/src/pure-ftpd-1.0.47.tar.gz -C /usr/local/src
