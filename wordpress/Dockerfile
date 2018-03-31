FROM wordpress:4.9.4-php7.2-fpm-alpine
MAINTAINER "Cloth Mo" <root@xmitd.com>

RUN apk add --no-cache git

COPY docker-entrypoint.sh /usr/local/bin/

ENV GIT_URL=NULL \
		Configure_SCR=NULL \
		Configure_DEST=NULL
