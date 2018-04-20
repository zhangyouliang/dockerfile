FROM nginx:1.13.8-alpine
MAINTAINER "Xiao Mo" <root@xiaomo.red>

RUN apk add --no-cache git

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ENV GIT_URL=NULL

CMD ["docker-entrypoint.sh"]
#ffff
