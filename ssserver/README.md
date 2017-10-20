```
docker run -d --name ssserver \
-p 443:8388 \
-e PASSWORD=xiaomo \
--restart unless-stopped daocloud.io/buxiaomo/ssserver:latest
```
