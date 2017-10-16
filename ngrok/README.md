# ngrok
```
docker run -d --name ngrok-server \
-p 80:80/tcp \
-p 443:443/tcp \
-p 4443:4443/tcp \
-p 3000-3010:3000-3010/tcp \
-e NGROK_DOMAIN=daocloud.cc daocloud.io/buxiaomo/ngrok:1.7.1
```
