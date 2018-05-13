dockerui
====

portainer
---

修改 `/etc/systemd/system/multi-user.target.wants/docker.service`

```
ExecStart=/usr/bin/dockerd  -H unix:///var/run/docker.sock
```

启动 portainer
```
# 即可
docker volume create portainer_data
docker run -d -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer
```

Shipyard
----

```
# docker pull rethinkdb
# docker pull microbox/etcd
# docker pull shipyard/docker-proxy
# docker pull swarm 
# docker pull shipyard/shipyard

```
> 注意：这将会暴露Docker Engine的管理端口2375。如果此节点在安全网络外部可以访问，建议使用TLS。

安装
```

# 数据存储
docker run  -ti -d --restart=always  --name shipyard-rethinkdb rethinkdb


# 服务发现
docker run -ti -d -p 4001:4001 -p 7001:7001 --restart=always --name shipyard-discovery microbox/etcd:latest  -name discovery

#  Docker代理服务
docker run -ti -d -p 2375:2375 --hostname=$HOSTNAME --restart=always --name shipyard-proxy -v /var/run/docker.sock:/var/run/docker.sock -e PORT=2375 shipyard/docker-proxy:latest

# Swarm管理节点
docker run -ti -d --restart=always --name shipyard-swarm-manager swarm:latest manage --host tcp://0.0.0.0:3375 etcd://118.31.78.77:4001

#  Swarm Agent节点
docker run -ti -d --restart=always --name shipyard-swarm-agent swarm:latest  join --addr 118.31.78.77:2375 etcd://118.31.78.77:4001

# Shipyard管理工具
docker run -ti -d --restart=always --name shipyard-controller --link shipyard-rethinkdb:rethinkdb --link shipyard-swarm-manager:swarm -p 8080:8080 shipyard/shipyard:latest server -d tcp://swarm:3375
```

访问 `http://xx:8080` 即可