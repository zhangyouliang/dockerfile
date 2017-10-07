```
docker run -d --name shadowsocks \
-p 8388:8388 \
-e PASS=123456 \
--restart unless-stopped daocloud.io/buxiaomo/ss
```
