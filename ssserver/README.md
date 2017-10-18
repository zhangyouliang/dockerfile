```
docker run -d --name ssserver \
-p 139:8388 \
-e PASSWORD=xiaomo \
--restart unless-stopped daocloud.io/buxiaomo/ssserver:latest
```
