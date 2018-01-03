#!/bin/bash
set -e
function set_kafka_configure() {
    grep -w "#$1" config/server.properties &> /dev/null && sed -i "s/#$1/$1/g" config/server.properties
    grep -w $1 config/server.properties &> /dev/null
    if [ $? -eq 0 ];then
        sed -i "s#$1=.*#$1=$2#g" config/server.properties
    else
        echo "$1=$2" >> config/server.properties
    fi
}
# 本次测试，支持Docker之外的访问访问没有问题，暂未测试Docker内部调用
# 根据环境变量判定是否让kafak支持Docker之外的服务访问
# 若需要支持Docker之外的服务访问请设置KAFKA_HOST_IP,KAFKA_PORT这两个环境变量
if [ ${KAFKA_HOST_IP} != "NULL" ] && [ ${KAFKA_PORT} != "NULL" ];then
    set_kafka_configure advertised.host.name ${KAFKA_HOST_IP}
    # echo "advertised.host.name=${KAFKA_HOST_IP}" >> config/server.properties
    set_kafka_configure advertised.port ${KAFKA_PORT}
    # echo "advertised.port=${KAFKA_PORT}" >> config/server.properties
else
    IP=`hostname -i`
    sed -i "s/#advertised.listeners/advertised.listeners/g" config/server.properties
    sed -i "s/your.host.name:9092/${IP}:9092/g" config/server.properties
    set_kafka_configure host.name ${IP}
    # echo "=${IP}" >>  config/server.properties
fi
# 集群必须设置此环境变量值
if [ ${BROKER_ID} != "NULL" ];then
    set_kafka_configure broker.id ${BROKER_ID}
    # sed -i "s/broker.id=.*/broker.id=${BROKER_ID}/g" config/server.properties
fi
# 设置zookeeper集群配置
if [ ${ZOOKEEPER_CLUSTER} = "localhost:2181" ];then
    bin/zookeeper-server-start.sh config/zookeeper.properties &
else
    set_kafka_configure zookeeper.connect ${ZOOKEEPER_CLUSTER}
    # sed -i "s/zookeeper.connect=localhost:2181/zookeeper.connect=${ZOOKEEPER_CLUSTER}/g" config/server.properties
fi
# 启动服务后是否自动创建TOPICS
if [ ${KAFKA_TOPICS} != "NULL" ];then
    set_kafka_configure create.topics ${KAFKA_TOPICS}
    # echo "create.topics=${KAFKA_TOPICS}" >> config/server.properties
fi
# 配置kafka参数

sed -i '/export KAFKA_HEAP_OPTS/a\    export JMX_PORT="9999"' /usr/local/kafka_${SCALA_VERSION}-${KAFKA_VERSION}/bin/kafka-server-start.sh

set_kafka_configure log.dirs /kafka
set_kafka_configure log.cleanup.policy delete
set_kafka_configure auto.create.topics.enable 'true'
set_kafka_configure num.partitions 6
set_kafka_configure delete.topic.enable 'true'
# sed -i "s#log.dirs=.*#log.dirs=/kafka#g" config/server.properties
# echo "log.cleanup.policy = delete" >> config/server.properties
# echo "auto.create.topics.enable = true" >> config/server.properties
# sed -i "s#num.partitions=.*#num.partitions=6#g" config/server.properties
# echo "delete.topic.enable=true" >> config/server.properties

exec bin/kafka-server-start.sh config/server.properties
