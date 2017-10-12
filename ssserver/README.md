```
docker run -d --name ssserver \
-p 8388:8388 \
-e PASSWORD=xiaomo \
--restart unless-stopped daocloud.io/buxiaomo/ssserver:latest
```
