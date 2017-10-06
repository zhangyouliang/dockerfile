FROM daocloud.io/library/golang:1.8.1
MAINTAINER "Cloth Mo" <root@buxiaomo.com>

COPY sources.list /etc/apt/sources.list

RUN apt-get update \
    && wget -O /usr/local/src/etcd-v3.1.7-linux-amd64.tar.gz https://github.com/coreos/etcd/releases/download/v3.1.7/etcd-v3.1.7-linux-amd64.tar.gz \
    && tar -zxf /usr/local/src/etcd-v3.1.7-linux-amd64.tar.gz -C /usr/local/src/ \
    && cp /usr/local/src/etcd-v3.1.7-linux-amd64/etcd /usr/local/bin/ \
    && cp /usr/local/src/etcd-v3.1.7-linux-amd64/etcdctl /usr/local/bin/ \
    && rm -rf /usr/local/src/* \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 2379

CMD ["etcd"]
