FROM alpine:3.6
MAINTAINER "Mo" <root@buxiaomo.com>

RUN apk --update add go bash

ENV CONDF_VERSIOV 0.15.0
RUN apk add --no-cache wget \
	&& wget --no-check-certificate -O /usr/local/bin/confd https://github.com/kelseyhightower/confd/releases/download/v${CONDF_VERSIOV}/confd-${CONDF_VERSIOV}-linux-amd64 \
	&& apk del --no-cache wget \
	&& chmod +x /usr/local/bin/confd \
	&& mkdir -p /etc/confd/conf.d /etc/confd/templates

CMD ["confd"]
