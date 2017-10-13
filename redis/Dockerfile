FROM alpine:3.6
MAINTAINER "Cloth Mo" <root@buxiaomo.com>

ADD repositories  /etc/apk/repositories

RUN apk add --no-cache redis \
    && sed -i "s/bind 127.0.0.1/bind 0.0.0.0/g" /etc/redis.conf \
    && sed -i "s/protected-mode.*/protected-mode no/g" /etc/redis.conf \
    && sed -i "s/daemonize yes/daemonize no/g" /etc/redis.conf

COPY sentinel.sh /usr/bin/
COPY sentinel.conf /etc/redis/sentinel.conf

RUN chmod +x /usr/bin/sentinel.sh

EXPOSE 6379

CMD ["redis-server","/etc/redis.conf"]
