docker run -d --name base \
-p 8080:8000 \
-v /var/run/docker.sock:/var/run/docker.sock:ro \
-e ALIYUN_ID=CA2itkysMDohoqJd \
-e ManagerIP=45.77.157.7 \
-e ALIYUN_Secret=9R4Z1UEH7UYLQ2DU3wmj8gXkGxGVEe \
-e DomainName=ssserver.cc \
daocloud.io/buxiaomo/ssserverweb:latest