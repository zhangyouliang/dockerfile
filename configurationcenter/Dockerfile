FROM nginx:1.13.5-alpine

RUN apk add --no-cache git

COPY docker-entrypoint.sh /usr/local/bin/

CMD ["docker-entrypoint.sh"]
