# Kafka
```
docker node update --label-add kafka.node01=true Docker01
docker node update --label-add kafka.node02=true Docker02
docker node update --label-add kafka.node03=true Docker03
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