FROM mongo:3.4.4
MAINTAINER "Cloth Mo" <root@buxiaomo.com>

COPY stats.sh /stats.sh

RUN chmod +x /stats.sh

ENV MONGO_CLUSTER mongodb01:27017,mongodb02:27017,mongodb03:27017
ENV PRINT_TIME 15
