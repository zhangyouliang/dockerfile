FROM daocloud.io/library/alpine:3.5

COPY repositories /etc/apk/repositories

RUN apk add --no-cache haproxy

COPY haproxy.cfg /etc/haproxy/haproxy.cfg
COPY docker-entrypoint.sh /docker-entrypoint.sh

CMD ["sh","/docker-entrypoint.sh"]
