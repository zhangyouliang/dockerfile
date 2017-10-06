# kafka

    docker run -d --name kafka daocloud.io/buxiaomo/kafka
    
# docker-compose.zookeeper.yml
```
version: '2'
services:
    zookeeper01:
        image: daocloud.io/buxiaomo/zookeeper
        ports:
            - 8004:2181/tcp
        environment:
            - ZOOKEEPER_ID=1
            - ZOOKEEPER_CLUSTER=server.1=zookeeper01:2888:3888,server.2=zookeeper02:2888:3888,server.3=zookeeper03:2888:3888
        networks:
            kafka:
                aliases:
                    - zookeeper01
    zookeeper02:
        image: daocloud.io/buxiaomo/zookeeper
        ports:
            - 8005:2181/tcp
        environment:
            - ZOOKEEPER_ID=2
            - ZOOKEEPER_CLUSTER=server.1=zookeeper01:2888:3888,server.2=zookeeper02:2888:3888,server.3=zookeeper03:2888:3888
        networks:
            kafka:
                aliases:
                    - zookeeper02
    zookeeper03:
        image: daocloud.io/buxiaomo/zookeeper
        ports:
            - 8006:2181/tcp
        environment:
            - ZOOKEEPER_ID=3
            - ZOOKEEPER_CLUSTER=server.1=zookeeper01:2888:3888,server.2=zookeeper02:2888:3888,server.3=zookeeper03:2888:3888
        networks:
            kafka:
                aliases:
                    - zookeeper03
networks:
    kafka:
        external: true
```
# docker-compose.kafka.yml
```
version: '2'
services:
    kafka01:
        image: daocloud.io/buxiaomo/kafka
        ports:
            - 8001:9092/tcp
        environment:
            - BROKER_ID=1
            # IP为容器所在宿主机的IP
            - KAFKA_HOST_IP=10.3.236.215
            - KAFKA_PORT=8001
            - ZOOKEEPER_CLUSTER=zookeeper01:2181,zookeeper02:2181,zookeeper03:2181
        networks:
            kafka:
                aliases:
                    - kafka01
        # command: ping www.baidu.com
    kafka02:
        image: daocloud.io/buxiaomo/kafka
        ports:
            - 8002:9092/tcp
        environment:
            - BROKER_ID=2
            # IP为容器所在宿主机的IP
            - KAFKA_HOST_IP=10.3.236.215
            - KAFKA_PORT=8002
            - ZOOKEEPER_CLUSTER=zookeeper01:2181,zookeeper02:2181,zookeeper03:2181
        networks:
            kafka:
                aliases:
                    - kafka02
        # command: ping www.baidu.com
    kafka03:
        image: daocloud.io/buxiaomo/kafka
        ports:
            - 8003:9092/tcp
        environment:
            - BROKER_ID=3
            # IP为容器所在宿主机的IP
            - KAFKA_HOST_IP=10.3.236.215
            - KAFKA_PORT=8003
            - ZOOKEEPER_CLUSTER=zookeeper01:2181,zookeeper02:2181,zookeeper03:2181
        networks:
            kafka:
                aliases:
                    - kafka03
        # command: ping www.baidu.com
networks:
    kafka:
        external: true
```
####
