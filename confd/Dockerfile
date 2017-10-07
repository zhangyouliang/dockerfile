FROM alpine:3.6
MAINTAINER "Mo" <root@buxiaomo.com>

RUN apk --update add go bash

RUN apk add --no-cache wget \
	&& wget --no-check-certificate -O /usr/local/bin/confd https://github.com/kelseyhightower/confd/releases/download/v0.11.0/confd-0.11.0-linux-amd64 \
	&& apk del --no-cache wget \
	&& chmod +x /usr/local/bin/confd \
	&& mkdir -p /etc/confd/{conf.d,templates}

CMD ["confd"]
