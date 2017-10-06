FROM golang:1.8-alpine
MAINTAINER "Cloth Mo" <root@buxiaomo.com>

ADD etcd-v3.1.0-rc.1-linux-amd64.tar.gz /tmp/

RUN cp /tmp/etcd-v3.1.0-rc.1-linux-amd64/etcd /usr/local/bin/ \
	&& cp /tmp/etcd-v3.1.0-rc.1-linux-amd64/etcdctl /usr/local/bin/ \
	&& rm -rf /tmp/*

EXPOSE 2379

CMD ["etcd"]
