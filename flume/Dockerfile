FROM java:openjdk-8-jdk

COPY sources.list /etc/apt/sources.list

ENV FLUME_VERSION 1.8.0
RUN apt-get update \
    && apt-get install wget --no-install-recommends -y \
    && wget -O /usr/local/src/apache-flume-${FLUME_VERSION}-bin.tar.gz http://mirrors.tuna.tsinghua.edu.cn/apache/flume/${FLUME_VERSION}/apache-flume-${FLUME_VERSION}-bin.tar.gz \
    && tar -zvxf /usr/local/src/apache-flume-${FLUME_VERSION}-bin.tar.gz -C /usr/local \
    && apt-get remove wget -y \
    && apt-get autoremove -y \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /usr/local/src/apache-flume-${FLUME_VERSION}-bin.tar.gz
WORKDIR /usr/local/apache-flume-${FLUME_VERSION}-bin
COPY log4j.properties /usr/local/apache-flume-${FLUME_VERSION}-bin/conf/log4j.properties
