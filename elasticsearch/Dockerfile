FROM ubuntu:16.04
MAINTAINER "Xiao Mo" <root@xiaomo.red>

# COPY sources.list /etc/apt/sources.list

RUN echo "Asia/Shanghai" > /etc/timezone

ENV JAVA_VERSION 8
RUN apt-get update \
    && apt-get install openjdk-${JAVA_VERSION}-jdk --no-install-recommends -y \
    && useradd -p elk -u 1000 elk \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*
ENV JAVA_HOME /usr/lib/jvm/java-${JAVA_VERSION}-openjdk-amd64
ENV CLASSPATH $JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV PATH $PATH:$JAVA_HOME/bin:$JRE_HOME/bin

ENV ELASTICSEARCH_VERSION 5.4.1
RUN apt-get update \
    && apt-get install wget --no-install-recommends -y \
    && wget -O /usr/local/src/elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.4.2.tar.gz \
    && tar -zvxf /usr/local/src/elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz -C /usr/local/ \
    && rm -rf /usr/local/src/elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz \
    && apt-get remove wget -y \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/* \
ENV ELASTICSEARCH_HOME /usr/local/elasticsearch-${ELASTICSEARCH_VERSION}

WORKDIR /usr/local/elasticsearch-${ELASTICSEARCH_VERSION}
