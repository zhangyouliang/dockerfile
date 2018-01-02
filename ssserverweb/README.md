```
docker run -d --name base \
-p 8080:8000 \
-v /var/run/docker.sock:/var/run/docker.sock:ro \
-e ALIYUN_ID=*** \
-e ManagerIP=*** \
-e ALIYUN_Secret=**** \
-e DomainName=xxx.com \
daocloud.io/buxiaomo/ssserverweb:latest
```
