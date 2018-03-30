#!/bin/bash

#根据环境变量启动镜像
/docker/config.sh


#启动守护
/opt/python2.7/bin/supervisord -c /etc/supervisord.conf

