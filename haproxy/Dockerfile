FROM haproxy:1.8.3-alpine
MAINTAINER "Xiao Mo" <root@xiaomo.red>

RUN apk add --no-cache git

COPY docker-entrypoint.sh /

ENV GIT_URL=NULL \
		Configure_SCR=NULL \
		Configure_DEST=/usr/local/etc/haproxy/haproxy.cfg
