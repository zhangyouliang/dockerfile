#!/bin/sh
# REDIS_CLUSTER="redis_master01:6379,redis_slave01:6379"
i=0
for host in `echo ${REDIS_CLUSTER} | sed "s/,/\n/g"`
do
    # server master master:6379 check inter 1s
    HO="${HO}|server redis${i} ${host}  check port 6379 inter 5s fastinter 2s downinter 5s rise 3 fall 3"
    i=`expr $i + 1`
done
echo ${HO:1} | sed 's/|/\n/g' | sed 's/server/    server/g' >> /etc/haproxy/haproxy.cfg
exec haproxy -f /etc/haproxy/haproxy.cfg
