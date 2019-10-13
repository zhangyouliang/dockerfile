# etcd

构建容器
```
docker build -t daocloud.io/buxiaomo/etcd:3.2.9 .
```

如何启动etcd容器
```
docker run -d --name etcd \
--net host \
daocloud.io/buxiaomo/etcd:3.2.9 \
--name etcd \
--data-dir /etcd \
--advertise-client-urls http://0.0.0.0:4001 \
--initial-advertise-peer-urls http://0.0.0.0:7001
```
添加一个特权账号并开启认证

    docker exec -it etcd etcdctl user add root
    New password: root123456
    docker exec -it etcd etcdctl auth enable

查看角色列表

    docker exec -it etcd etcdctl --username root:root123456 user list

添加一个非特权账号

    docker exec -it etcd etcdctl --username root:root123456 user add phpor
添加角色

    docker exec etcd etcdctl --username root:root123456 role add test1

给角色添加能力：

    docker exec etcd etcdctl --username root:root123456 role grant --rw --path /test1 test1
注意，这里只添加了 /test1 的读写权限，不包含其子目录（文件），如果需要包含，请这么写：

    docker exec etcd etcdctl --username root:root123456 role grant --rw --path /test1/* test1

查看有哪些角色

    docker exec etcd etcdctl --username root:root123456 role list

查看指定角色的权限

    docker exec etcd etcdctl --username root:root123456 role get test1

将用户添加到角色：

    docker exec etcd etcdctl --username root:root123456 user grant --roles test1 phpor

查看用户拥有哪些角色

    docker exec etcd etcdctl --username root:root123456 user get phpor


常用命令(3版本)
====

    ENDPOINTS=localhost:2379
    # 获取全部 key
    ETCDCTL_API=3  etcdctl --endpoints=$ENDPOINTS  get / --prefix --keys-only

    # 删除key
    etcdctl del <key>
    etcdctl del <prefix> --prefix
    # 设置key
    etcdctl put <key> <val>

    # 基于相同前缀
    etcdctl put web1 value1
    etcdctl put web2 value2
    etcdctl get web --prefix

    # 集群状态
    etcdctl endpoint status
    etcdctl endpoint health

    # 获取成员列表
    etcdctl member list -w table

    # 授予租约
    # 授予租约，TTL为10秒
    etcdctl lease grant 10
    # 附加key foo到租约32695410dcc0ca06
    etcdctl put --lease=32695410dcc0ca06 foo bar

    #  撤销租约
    etcdctl lease revoke 32695410dcc0ca06
    etcdctl get foo
    # 空应答，因为租约撤销导致foo被删除

    # 维持租约
    # etcdctl lease grant 10
    lease 32695410dcc0ca06 granted with TTL(10s)
    # etcdctl lease keep-alive 32695410dcc0ca0
    注： 上面的这个命令中，etcdctl 不是单次续约，而是 etcdctl 会一直不断的发送请求来维持这个租约。
    


## 参考
* [文档参考](https://skyao.io/learning-etcd3/documentation/dev-guide/interacting_v3.html)