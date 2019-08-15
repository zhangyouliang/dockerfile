FROM alpine:latest
MAINTAINER "ZYL" <1577121881@qq.com>

COPY repositories /etc/apk/repositories

RUN apk add tzdata \
    && echo "Asia/Shanghai" > /etc/timezone \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && apk del tzdata