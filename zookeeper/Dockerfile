FROM daocloud.io/library/debian:jessie
MAINTAINER "Cloth Mo" <root@buxiaomo.com>

ENV ZOOKEEPER_VERSION 3.4.10

COPY sources.list /etc/apt/sources.list

RUN echo "Asia/Shanghai" > /etc/timezone \
    && dpkg-reconfigure -f noninteractive tzdata

RUN apt-get update \
    && apt-get install openjdk-7-jdk --no-install-recommends -y \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64
ENV CLASSPATH $JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV PATH $PATH:$JAVA_HOME/bin:$JRE_HOME/bin

RUN apt-get update \
    && apt-get install axel --no-install-recommends -y \
    && axel -n 20 --output=/usr/local/src/zookeeper-${ZOOKEEPER_VERSION}.tar.gz http://mirrors.tuna.tsinghua.edu.cn/apache/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/zookeeper-${ZOOKEEPER_VERSION}.tar.gz \
    && tar -zxf /usr/local/src/zookeeper-${ZOOKEEPER_VERSION}.tar.gz -C /usr/local/ \
    && rm -rf /usr/local/src/zookeeper-${ZOOKEEPER_VERSION}.tar.gz \
    && apt-get remove axel -y \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*

RUN cp /usr/local/zookeeper-${ZOOKEEPER_VERSION}/conf/zoo_sample.cfg /usr/local/zookeeper-${ZOOKEEPER_VERSION}/conf/zoo.cfg \
    && sed -i "s#dataDir=/tmp/zookeeper#dataDir=/var/lib/zookeeper#g" /usr/local/zookeeper-${ZOOKEEPER_VERSION}/conf/zoo.cfg \
    && mkdir -p /var/lib/zookeeper
ENV ZOOKEEPER_HOME /usr/local/zookeeper-${ZOOKEEPER_VERSION}
ENV PATH $PATH:$ZOOKEEPER_HOME/bin
# ADD log4j.properties /usr/local/zookeeper-${ZOOKEEPER_VERSION}/conf/

WORKDIR /usr/local/zookeeper-${ZOOKEEPER_VERSION}

VOLUME /var/lib/zookeeper

ENV ZOOKEEPER_ID NULL
ENV ZOOKEEPER_CLUSTER NULL

EXPOSE 2181 2888 3888

ADD start.sh /usr/local/bin/start.sh

CMD ["start.sh"]
