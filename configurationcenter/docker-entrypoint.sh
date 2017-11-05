#!/bin/sh
if [ ${GIT_URL} != "NULL" ];
    git clone ${GIT_URL} /usr/share/nginx/configure
elif [ ! -e /usr/share/nginx/configure ];then
    echo "Please set GIT_URL"
    exit 1
fi
nginx -g "daemon off;"
