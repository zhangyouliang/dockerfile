FROM alpine:latest

ENV TZ=Asia/Shanghai

# RUN apk add tzdata \
#     && echo $TZ > /etc/timezone \
#     && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
#     && apk del tzdata



RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk add curl busybox-extras tzdata --no-cache unrar unzip \
    && echo $TZ > /etc/timezone \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && apk del tzdata \
    && rm -rf /var/cache/apk/* /tmp/* \
    && if [ ! -e /etc/nsswitch.conf ];then echo 'hosts: files dns' > /etc/nsswitch.conf; fi