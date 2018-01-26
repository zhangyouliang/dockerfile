FROM redis:4.0.7-alpine
MAINTAINER "Cloth Mo" <root@xmitd.com>

RUN apk add --no-cache git

COPY docker-entrypoint.sh /usr/local/bin/

ENV GIT_URL=NULL \
		Configure_SCR=NULL \
		Configure_DEST=NULL
