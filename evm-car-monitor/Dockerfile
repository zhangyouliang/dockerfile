FROM alpine:3.5

COPY run.sh /usr/local/bin/run.sh

RUN apk add --no-cache curl jq \
    && chmod +x /usr/local/bin/run.sh

CMD ["run.sh"]
