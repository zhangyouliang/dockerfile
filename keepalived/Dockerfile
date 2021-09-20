FROM alpine:3.13.6

COPY docker-entrypoint.sh /entrypoint.sh

ENV TZ Asia/Shanghai

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
    apk update && \
    apk add --no-cache keepalived curl bash iproute2 grep sed tcpdump tzdata && \
    chmod a+x /entrypoint.sh && \
    mkdir -p /etc/keepalived && \
    echo Asia/Shanghai > /etc/timezone && \
    if [ ! -e /etc/nsswitch.conf ];then echo 'hosts: files dns myhostname' > /etc/nsswitch.conf; fi && \
    rm -rf /var/cache/apk/* /tmp/*

ENTRYPOINT ["/entrypoint.sh"]
