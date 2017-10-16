# ngrok
```
docker run -d --name ngrok-server \
-v /etc/ngrok:/etc/ngrok \
-p 80:80/tcp \
-p 443:443/tcp \
-p 4443:4443/tcp \
-p 3000-3010:3000-3010/tcp \
-e NGROK_DOMAIN=daocloud.cc daocloud.io/buxiaomo/ngrok:1.7.1
```
# 迁移

## 挂在了数据卷

1、打包/etc/ngrok目录下所有文件，拷贝至新节点执行上面的命令即可

2、更改域名解析


## 没有挂在数据卷

执行`docker inspect ngrok-server | jq '.[0].Mounts[0].Source'`命令获取卷，打包此目录中的所有文件，拷贝至新节点

2、更改域名解析
