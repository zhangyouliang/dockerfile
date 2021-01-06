#!/usr/bin/env bash

###
# 获取指定 docker 镜像的全部tag
# ./tags.sh <docker image name>
###
if [[ $# -lt 1 ]];then
    echo "Usage: ./$0 <docker image name>"
    exit 1
fi

image=$1

curl -s  https://registry.hub.docker.com/v1/repositories/${image}/tags \
| tr -d '[\[\]" ]' \
| tr '}' '\n' \
| awk -F: -v image=${image} '{if(NR!=NF && $3 != ""){printf("%s:%s\n",image,$3)}}'