#!/bin/sh
sed -i "s/redis_master/${MASTER_HOSTNAME}/g" /etc/redis/sentinel.conf
exec redis-sentinel /etc/redis/sentinel.conf --sentinel
