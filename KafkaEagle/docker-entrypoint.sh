#!/bin/bash
function SET_KE_CONFIGURE() {
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
    if [ ${K} != "kafka.eagle.webui.port" ];then
        SET_KE_CONFIGURE ${K} ${V}
    fi
done
echo "kafka.eagle.driver=org.sqlite.JDBC" >> $KE_HOME/conf/system-config.properties
echo "kafka.eagle.url=jdbc:sqlite:/usr/local/kafka-eagle-web-1.2.3/db/ke.db" >> $KE_HOME/conf/system-config.properties

exec ${KE_HOME}/bin/kafka-server-start.sh ${KAFKA_HOME}/config/server.properties