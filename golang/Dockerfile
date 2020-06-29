FROM golang:1.12-alpine

## https://www.jianshu.com/p/dd233020c5b7
## 参考: https://github.com/containous/traefik/blob/master/build.Dockerfile

ENV GOPROXY="https://goproxy.io"
ENV TZ=Asia/Shanghai

# 备份原始文件
# 修改为国内镜像源
RUN cp /etc/apk/repositories /etc/apk/repositories.bak \
    && echo "http://mirrors.aliyun.com/alpine/v3.4/main/" > /etc/apk/repositories \
    && apk --update upgrade \
    && apk --no-cache --no-progress add make git mercurial bash gcc musl-dev curl tar tzdata \
    && echo $TZ > /etc/timezone \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && go get github.com/tools/godep \
    && go get github.com/jteeuwen/go-bindata/... \
    && rm -rf /var/cache/apk/*








