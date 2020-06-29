FROM alpine:latest
MAINTAINER "ZYL" <1577121881@qq.com>

ENV TZ=Asia/Shanghai

COPY repositories /etc/apk/repositories

RUN apk add tzdata \
    && echo $TZ > /etc/timezone \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && apk del tzdata