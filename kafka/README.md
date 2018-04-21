# Kafka
```
docker node update --label-add kafka.node01=true node01
docker node update --label-add kafka.node02=true node02
docker node update --label-add kafka.node03=true node03
```

# 清理数据
```
HOST_LIST=(
    'root@10.211.55.29'
    'root@10.211.55.30'
    'root@10.211.55.31'
)
for HOST in ${HOST_LIST[*]};
do
    ssh ${HOST} 'rm -rf /var/lib/zookeeper/* /var/lib/kafka/*'
done
```