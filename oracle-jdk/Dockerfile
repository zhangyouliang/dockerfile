FROM debian:jessie
MAINTAINER "Xiao Mo" <root@xiaomo.red>

RUN apt-get update \
    && apt-get install wget --no-install-recommends -y \
    && wget --no-cookies --no-check-certificate \
       -O /usr/local/src/jdk-8u171-linux-x64.tar.gz \
       --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
       "http://download.oracle.com/otn-pub/java/jdk/8u171-b11/512cd62ec5174c3487ac17c61aaa89e8/jdk-8u171-linux-x64.tar.gz" \
    && tar -zxf /usr/local/src/jdk-8u171-linux-x64.tar.gz -C /usr/local/ \
    && mv /usr/local/jdk1.8.0_171 /usr/local/java \
    && rm -rf /usr/local/src/* \
    && apt-get remove wget -y \
    && apt-get autoremove -y \
    && apt-get clean all

ENV JAVA_HOME /usr/local/java
ENV CLASSPATH $JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV PATH $PATH:$JAVA_HOME/bin:$JRE_HOME/bin
