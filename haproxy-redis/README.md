# haproxy-redis

```
docker run -d --name haproxy-redis \
-e REDIS_CLUSTER="redis_master01:6379,redis_slave01:6379" haproxy-redis:1.8.2
```
