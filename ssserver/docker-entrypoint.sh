#!/bin/sh
[ $PASSWORD = "**NULL**" ] && PASSWORD=`pwgen -s 12 1`
K=$(uname -r)
K=${K:0:3}
R=$(echo "${K} >= 3.7" | bc)
if [ ${R} -eq 1 ];then
    OPS=" --fast-open --workers 20"

else
    OPS=" --workers 20"
fi
echo "=> The Password is ${PASSWORD}"
echo "=> You can download the shadowsocks"
echo "   Window:  http://ys-f.ys168.com/598741933/iTjHSWk4J536H265KM5/Shadowsocks.exe"
echo "   Android: http://ys-n.ys168.com/598741957/jRgMVTn4J536H26KKM6/shadowsocks.apk"
echo "   Mac:  http://ys-n.ys168.com/598741911/hSiJVfl3L452I6642OH/ShadowsocksX-NG.1.6.1.zip"
ssserver -s ${SERVER_ADDR} -p 8388 -k ${PASSWORD} -m ${SERVER_METHOD} ${OPS}
