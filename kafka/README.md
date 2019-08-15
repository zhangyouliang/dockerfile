# 设置参数
参考编排文件

# 设置节点标签

```
docker node update --label-add kafka.node01=true Docker01
docker node update --label-add kafka.node02=true Docker02
docker node update --label-add kafka.node03=true Docker03
```

# 创建各节点数据目录

```
mkdir -p /var/lib/kafka
```

# 部署集群

```
docker stack deploy -c kafka.yml kafka
```

# 其他

```
docker-compose -f docker-compose-dev.yml up -d
```

参考
===
- [使用Docker快速搭建Kafka开发环境](https://www.jianshu.com/p/ac03f126980e)