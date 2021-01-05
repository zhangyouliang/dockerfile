php 镜像制作
===


这里全部使用 alpine 镜像,后面的 alpine3.4需要使用对应的 repositories 加速地址,例如:

php:7.3.25-fpm-alpine3.12 则需要使用

````
http://mirrors.aliyun.com/alpine/v3.12/main/
http://mirrors.aliyun.com/alpine/v3.12/community
````


````
# 查看 php 所有的 tag
curl -s  https://registry.hub.docker.com/v1/repositories/php/tags \
| tr -d '[\[\]" ]' \
| tr '}' '\n' \
| awk -F: -v image='php' '{if(NR!=NF && $3 != ""){printf("%s:%s\n",image,$3)}}'
````