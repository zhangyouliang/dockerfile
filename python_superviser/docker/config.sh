#!/bin/bash

## 坑点,一定要设置为ture,否则容器不能后台运行
sed -i -e "s/nodaemon=false/nodaemon=true /g" /etc/supervisord.conf

sed -i -e "s/;\[include\]/\[include\]/g" /etc/supervisord.conf
# 加载配置文件
echo 'files=/docker/supervisor/*.conf' >>  /etc/supervisord.conf
