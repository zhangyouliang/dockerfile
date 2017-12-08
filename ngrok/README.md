# ngrok

## 使用默认授权
```
docker run -d --name ngrok-server \
-v /etc/ngrok:/etc/ngrok \
-v /var/run/docker.sock:/var/run/docker.sock:ro \
-p 80:80/tcp \
-p 443:443/tcp \
-p 4443:4443/tcp \
-p 3000-3010:3000-3010/tcp \
-e NGROK_DOMAIN=xx.xx.xx daocloud.io/buxiaomo/ngrok:1.7.1
```

## 使用自定义授权
```
docker run -d --name ngrok-server \
-v /etc/ngrok:/etc/ngrok \
-p 80:80/tcp \
-p 443:443/tcp \
-p 4443:4443/tcp \
-p 3000-3010:3000-3010/tcp \
-e NGROK_DOMAIN=daocloud.cc \
-e NGROK_USER=admin \
-e NGROK_PASS=123456 \
daocloud.io/buxiaomo/ngrok:1.7.1
```


# 迁移

## 以挂载数据卷

1、打包/etc/ngrok目录下所有文件，拷贝至新节点执行上面的命令即可，注意修改挂载路径

2、更改域名解析

## 未挂在数据卷

1、执行`docker inspect ngrok-server | jq '.[0].Mounts[0].Source'`命令获取卷，打包此目录中的所有文件，拷贝至新节点

2、启动ngrok-server容器，注意修改挂载路径

3、更改域名解析
