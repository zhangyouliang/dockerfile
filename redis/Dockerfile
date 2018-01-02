FROM redis:3.2.11
MAINTAINER "Cloth Mo" <root@buxiaomo.com>

COPY sentinel.sh /usr/bin/
COPY sentinel.conf /etc/redis/sentinel.conf

RUN chmod +x /usr/bin/sentinel.sh

EXPOSE 6379

CMD ["redis-server","/etc/redis.conf"]
