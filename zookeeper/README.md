# zookeeper

```
docker node update --label-add zookeeper.node01=true Docker01
docker node update --label-add zookeeper.node02=true Docker02
docker node update --label-add zookeeper.node03=true Docker03
```

# 清理数据
```
HOST_LIST=(
    'root@10.0.1.10'
    'root@10.0.1.11'
    'root@10.0.1.12'
)
for HOST in ${HOST_LIST[*]};
do
    ssh ${HOST} 'rm -rf /var/lib/zookeeper/* /var/lib/kafka/*'
done
```

sed -i "s/10.211.55.29:2888:3888,10.211.55.30:2888:3888,10.211.55.31:2888:3888/10.0.1.10:2888:3888,10.0.1.11:2888:3888,10.0.1.12:2888:3888/g" zookeeper.yml