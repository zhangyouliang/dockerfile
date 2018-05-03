#!/bin/bash
# 清理数据文件
HOST_LIST=(
    'root@10.211.55.35'
    'root@10.211.55.30'
    'root@10.211.55.31'
    'root@10.211.55.34'
    'root@10.211.55.33'
    'root@10.211.55.29'
)
for HOST in ${HOST_LIST[*]};
do
    ssh ${HOST} 'rm -rf /var/lib/zookeeper/*'
done