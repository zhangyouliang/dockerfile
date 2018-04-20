#!/bin/bash
function SET_KAFKA_CONFIGURE() {
    grep -w "#$1" ${KAFKA_HOME}/config/server.properties &> /dev/null && sed -i "s/#$1/$1/g" ${KAFKA_HOME}/config/server.properties
    grep -w $1 ${KAFKA_HOME}/config/server.properties &> /dev/null
    if [ $? -eq 0 ];then
        sed -i "s#$1=.*#$1=$2#g" ${KAFKA_HOME}/config/server.properties
    else
        echo "$1=$2" >> ${KAFKA_HOME}/config/server.properties
    fi
}
ZK_IS_SET=false
# 设置KafKa参数
for C in ${KAFKA_CONFIG}
do
    K=$(echo ${C} | awk -F '=' '{print $1}')
    V=$(echo ${C} | awk -F '=' '{print $2}')
    if [ ${K} != "log.dirs" ];then
        # 设置zookeeper集群配置
        if [ ${K} == "zookeeper.connect" ];then
            if [ ${C} == "localhost:2181" ];then
                ${KAFKA_HOME}/bin/zookeeper-server-start.sh ${KAFKA_HOME}/config/zookeeper.properties &
            else
                SET_KAFKA_CONFIGURE zookeeper.connect ${ZOOKEEPER_CLUSTER}
                ZK_IS_SET=true
            fi
        fi
        if [ ${ZK_IS_SET} == false ];then
            ${KAFKA_HOME}/bin/zookeeper-server-start.sh ${KAFKA_HOME}/config/zookeeper.properties &
        fi
        SET_KAFKA_CONFIGURE ${K} ${V}
    fi
done

exec ${KAFKA_HOME}/bin/kafka-server-start.sh ${KAFKA_HOME}/config/server.properties