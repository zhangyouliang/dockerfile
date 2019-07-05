FROM alpine:latest
RUN cp /etc/apk/repositories /etc/apk/repositories.bak &&\ 
    echo "http://mirrors.aliyun.com/alpine/v3.4/main/" > /etc/apk/repositories && \
    apk add --update curl bash && \
    rm -rf /var/cache/apk/*

EXPOSE 2060

WORKDIR /srv

ENTRYPOINT [ "/usr/local/bin/docker-entrypoint.sh" ]

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
COPY qqwry_linux_386 qqwry_linux_386
COPY qqwry.dat qqwry.dat

RUN chmod +x /usr/local/bin/docker-entrypoint.sh /srv/qqwry_linux_386



