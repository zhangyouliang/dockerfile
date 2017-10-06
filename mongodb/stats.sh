#!/bin/bash
M_NODE=`echo ${MONGO_CLUSTER} | awk -F ',' '{print $1}'`

# 等待各节点启动完成
for host in `echo ${MONGO_CLUSTER} | sed "s/,/\n/g"`
do
    while((1))
    do
        echo "help;" | /usr/bin/mongo ${host}/admin --shell &> /dev/null
        if [ $? = 0 ];then
            break;
        fi
        echo "wait for ${host} ..."
        sleep 1
    done
done

# 查询集群状态判断是否初始化副本集
mongo --host ${M_NODE} --quiet --eval "printjson(rs.status())" | grep "no replset config has been received" &> /dev/null
if [ $? = 0 ];then
    # 生产主机格式
    i=0
    for host in `echo ${MONGO_CLUSTER} | sed "s/,/\n/g"`
    do
        HO="${HO}{_id:${i},host:\"${host}\"},"
        ((i=$i+1))
    done
    # 初始化副本集
    sql="config = {_id:\"repset\", members:[${HO:0:-1}]};rs.initiate(config);"
    echo "$sql" | /usr/bin/mongo ${M_NODE}/admin --shell
fi

# 循环查询集群状态
sleep 15
while true
do
    echo "------------------------------------"
    echo "rs.status();" | /usr/bin/mongo ${M_NODE}/admin
    sleep $PRINT_TIME
done
