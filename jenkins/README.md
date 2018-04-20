# jenkins
```
docker run -d --name jenkins \
-v /var/run/docker.sock:/var/run/docker.sock \
-v /var/jenkins:/var/jenkins \
-p 8080:8080 daocloud.io/buxiaomo/jenkins:2.107.1
```