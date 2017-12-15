FROM alpine:3.5
MAINTAINER "Cloth Mo" <root@buxiaomo.com>

COPY repositories /etc/apk/repositories

RUN apk add --no-cache python py-pip python-dev pwgen bc \
    && pip install shadowsocks setuptools

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENV PASSWORD **NULL**
ENV SERVER_METHOD aes-256-cfb
ENV SERVER_ADDR 0.0.0.0

EXPOSE 8388

CMD ["/docker-entrypoint.sh"]
