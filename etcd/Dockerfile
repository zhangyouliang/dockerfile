FROM alpine:3.7
MAINTAINER "Cloth Mo" <root@buxiaomo.com>

ENV ETCD_VERSION v3.2.12
RUN mkdir -p /usr/local/src/ /etcd \
    && wget -O /usr/local/src/etcd-${ETCD_VERSION}-linux-amd64.tar.gz https://github.com/coreos/etcd/releases/download/${ETCD_VERSION}/etcd-${ETCD_VERSION}-linux-amd64.tar.gz \
    && tar -zxf /usr/local/src/etcd-${ETCD_VERSION}-linux-amd64.tar.gz -C /usr/local/src \
    && cp /usr/local/src/etcd-${ETCD_VERSION}-linux-amd64/etcd /usr/local/bin/ \
    && cp /usr/local/src/etcd-${ETCD_VERSION}-linux-amd64/etcdctl /usr/local/bin/ \
    && rm -rf /tmp/* /usr/local/src

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ENV ETCD_NAME=default \
    ETCD_LISTEN_PEER_URLS=http://${ETCD_NAME}:2380 \
    ETCD_LISTEN_CLIENT_URLS=http://127.0.0.1:2379,http://${ETCD_NAME}:2379 \
    ETCD_INITIAL_ADVERTISE_PEER_URLS=http://${ETCD_NAME}:2380 \
    ETCD_INITIAL_CLUSTER_STATE=new \
    ETCD_INITIAL_CLUSTER_TOKEN=etcd-cluster \
    ETCD_ADVERTISE_CLIENT_URLS=http://${ETCD_NAME}:2380 \
    ETCD_INITIAL_CLUSTER=NULL

VOLUME /etcd

EXPOSE 2380

CMD ["docker-entrypoint.sh"]
