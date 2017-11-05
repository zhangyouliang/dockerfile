FROM nginx:1.13.5-alpine

RUN apk add --no-cache git

ADD docker-entrypoint.sh /usr/local/bin/
ADD nginx.conf /etc/nginx/nginx.conf

ENV GIT_URL=NULL \
    GIT_USER=NULL \
    GIT_PASS=NULL

CMD ["docker-entrypoint.sh"]
