FROM golang:1.11-alpine

## https://www.jianshu.com/p/dd233020c5b7
## 参考: https://github.com/containous/traefik/blob/master/build.Dockerfile

# 备份原始文件
# 修改为国内镜像源
RUN cp /etc/apk/repositories /etc/apk/repositories.bak \
    && go get github.com/tools/godep \
    && echo "http://mirrors.aliyun.com/alpine/v3.4/main/" > /etc/apk/repositories \
    && apk --update upgrade \
    && apk --no-cache --no-progress add make git mercurial bash gcc musl-dev curl tar \
    && rm -rf /var/cache/apk/*








