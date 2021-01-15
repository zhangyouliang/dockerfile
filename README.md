> 参考: https://github.com/buxiaomo/dockerfile

### # 快速获取 docker 镜像的全部 tag

````
alias dt='curl -fsSL https://gitee.com/whatdy/dockerfile/raw/master/tags.sh | sh -s -- '
# 获取 nginx 
dt nginx

# 或者
./dockertags.sh nginx

# 获取多个镜像的 tag
./dockertags-mut.sh "nginx" "python"



````


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
* 清除缓存包
```
#alpine
rm -rf /var/cache/apk/*
# ubuntu
rm -rf /var/lib/apt/lists/*
```

### # 比较常用且有用的镜像列表
* alpine: A minimal Docker image based on Alpine Linux with a complete package index and only 5 MB in size! 
* scratch: an explicitly empty image, especially for building images "FROM scratch"
* busybox: Busybox base image.
* radial/busyboxplus:curl
* docker:docker in docker 
* bash:Bash is the GNU Project’s Bourne Again SHell
* buildpack-deps: A collection of common build dependencies used for installing various modules, e.g., gems.
* composer:Composer is a dependency manager written in and for PHP.

### # 其他 docker 相关项目地址

- [tick_sandbox](https://github.com/zhangyouliang/tick_sandbox)
- [docker-elk](https://github.com/deviantony/docker-elk.git)
- [k8s 相关操作](https://gitee.com/whatdy/k8s)
