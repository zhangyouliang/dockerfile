#!/bin/sh
set -e
if [ "$GIT_URL" != "**NULL**" ];then
    git clone ${GIT_URL} /www/blog
    if [ -e /www/blog/conf.yaml ];then
        mv /www/blog/conf.yaml /www/conf.yaml
    else
        mv /www/example-conf.yaml /www/conf.yaml
    fi
fi
exec /usr/bin/supervisord -c /etc/supervisor/supervisord.conf
