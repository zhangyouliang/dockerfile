#!/bin/sh
[ $PASS = "**NULL**" ] && PASS=`pwgen -s 12 1`
echo "=> The Password is ${PASS}"
ssserver -s ${SERVER_ADDR} -p 8388 -k ${PASS} -m ${SERVER_METHOD} --fast-open
