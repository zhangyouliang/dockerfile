FROM alpine:3.5

echo "http://mirrors.ustc.edu.cn/alpine/v3.5/main/
http://mirrors.ustc.edu.cn/alpine/v3.5/community" > /etc/apk/repositories

RUN apk add --no-cache -t .ops git make g++ \
    && apk add --no-cache mariadb-dev libssh-dev zlib-dev libgcrypt-dev libidn-dev pcre-dev postgresql-dev zmap \
    && git clone https://github.com/vanhauser-thc/thc-hydra.git /usr/local/src/hydra \
    && cd /usr/local/src/hydra \
    && ./configure && make && make install


RUN apk add --no-cache zmap
