FROM alpine:3.6
MAINTAINER "Xiao Mo" <root@xiaomo.red>

ARG FRP_VERSION=0.18.0
ADD https://github.com/fatedier/frp/releases/download/v0.18.0/frp_${FRP_VERSION}_linux_amd64.tar.gz /usr/local

RUN tar -zvxf /usr/local/frp_${FRP_VERSION}_linux_amd64.tar.gz -C /usr/local/ \
    && mv /usr/local/frp_${FRP_VERSION}_linux_amd64 /usr/local/frp

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

EXPOSE 80 443 6000 7000 7500

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/usr/local/frp/frps","-c","/usr/local/frp/frps.ini"]