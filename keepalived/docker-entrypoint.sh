#!/bin/bash

[[ "${DEBUG}" == "true" ]] && set -x

: ${MAIN_CONF:=/etc/keepalived/keepalived.conf}

if [ -f "${MAIN_CONF}" ];then
    chmod 644 /etc/keepalived/keepalived.conf
fi

if [ -f /run/keepalived/keepalived.pid ];then
    > /run/keepalived/keepalived.pid
fi

if [ -f /run/keepalived/vrrp.pid ];then
    > /run/keepalived/vrrp.pid
fi

if [ "${1:0:1}" = '-' ];then
    exec keepalived "$@"
else
    exec keepalived --dont-fork --log-console --log-detail --vrrp  -f /etc/keepalived/keepalived.conf
fi
