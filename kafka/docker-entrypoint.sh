#!/bin/bash
function set_kafka_configure() {
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
    # 设置zookeeper集群配置
    if [ ${K} == "zookeeper.connect" ];then
        if [ ${C} == "localhost:2181" ];then
            ${KAFKA_HOME}/bin/zookeeper-server-start.sh ${KAFKA_HOME}/config/zookeeper.properties &
        else
            set_kafka_configure zookeeper.connect ${ZOOKEEPER_CLUSTER}
            ZK_IS_SET=true
        fi
    fi
    if [ ${ZK_IS_SET} == false ];then
        ${KAFKA_HOME}/bin/zookeeper-server-start.sh ${KAFKA_HOME}/config/zookeeper.properties &
    fi
    set_kafka_configure ${K} ${V}
done

# 固定的Log日志存储目录，不允许修改
set_kafka_configure log.dirs /var/lib/kafka

exec ${KAFKA_HOME}/bin/kafka-server-start.sh ${KAFKA_HOME}/config/server.properties