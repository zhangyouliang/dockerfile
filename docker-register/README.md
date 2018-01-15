>  自动构建  docker 个人服务器,添加认证功能

> Note : Only nginx:alpine supports bcrypt.

### # 目录结构
```
.
├── README.md
├── auth  <相关证书>
├── data  <镜像存储地点>
├── docker-compose.yml <docker-compose配置文件>
├── nginx.conf 
└── tools.sh  <工具>

```

### # 生成密码
> `auth/nginx.htpasswd`为 testuser 和 testpassword 创建一个密码文件。

````
docker run --rm --entrypoint htpasswd registry:2 -Bbn testuser testpassword > auth/nginx.htpasswd
````

**注意：如果您不想使用bcrypt，可以省略该-B参数。**

### # 测试

````
## 获取 docker ip
docker inspect dockerregister_nginx_1 | grep IPAddress
##vim /etc/hosts
## 添加 xx.xx.xx.xx myregistrydomain.com
## (证书自己生成的,所以会提示禁止访问,这是使用-k 跳过)
curl -k https://myregistrydomain.com/v2 
````

### # 使用



````
## 401 Authorization Required
curl -X GET -k https://myregistrydomain.com/v2/_catalog

### Successful
curl -X GET -u testuser:testpassword -k https://myregistrydomain.com/v2/_catalog

### push
docker tag ubuntu myregistrydomain.com/test
docker push myregistrydomain.com/test
docker pull myregistrydomain.com/test
````
> Login with a “push” authorized user (using testuser and testpassword), then tag and push your first image:

### # 问题

不安全的 registry:

````
## centos7 and ubuntu 16.04
$ cat /etc/docker/daemon.json
{
  "insecure-registry": [ "myregistrydomain.com:5043"  ]
}

$ systemctl daemon-reload && systemctl restart docker.service

````

### 参考
[官方文档](https://docs.docker.com/registry/recipes/nginx/#starting-and-stopping)

[HTTPS 证书生成教程](http://www.barretlee.com/blog/2015/10/05/how-to-build-a-https-server/)