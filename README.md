> 参考: https://github.com/buxiaomo/dockerfile

### # docker 镜像体积优化建议

* 不要安装不必要的软件包
* 使用多阶段构建(golang)
* 使用对应语言的 alpine 基础镜像,golang 可使用 scratch 镜像(不占空间)(注意适当修改编译命令)
* 解耦应用程序:分离依赖包，以及源代码程序，充分利用层的缓存
* 最小化层数
  * 只有RUN，COPY，ADD指令创建图层。其他说明创建临时的中间映像，并且不会增加构建的大小
* 使用单行命令(利用 && 将命令进行拼接,可有效减少镜像层数)
* 多利用构建缓存,可加快构建速度 [参考](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)

技巧:
* 安装软件时去除依赖
```
# ubuntu
apt-get install -y — no-install-recommends

#alpine
apk add --no-cache &&  apk del build-dependencies

# centos
yum install -y ... && yum clean all

```


### # 其他 docker 相关项目地址

- [tick_sandbox](https://github.com/zhangyouliang/tick_sandbox)
- [docker-elk](https://github.com/deviantony/docker-elk.git)
- [k8s 相关操作](https://gitee.com/whatdy/k8s)
