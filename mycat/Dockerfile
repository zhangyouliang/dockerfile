FROM java:8u111-jre
MAINTAINER "Xiao Mo" <root@xiaomo.red>

COPY sources.list /etc/apt/sources.list

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre \
    CLASSPATH=.:$JAVA_HOME/lib/ \
    PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin

RUN wget -O /usr/local/src/Mycat-server-1.6.5-release-20171008170112-linux.tar.gz http://dl.mycat.io/1.6.5-BETA/Mycat-server-1.6.5-release-20171008170112-linux.tar.gz \
    && tar -zxf /usr/local/src/Mycat-server-1.6.5-release-20171008170112-linux.tar.gz -C /usr/local/ \
    && rm -rf /usr/local/src/Mycat-server-1.6.5-release-20171008170112-linux.tar.gz

ENV MYCAT_HOME=/usr/local/mycat \
    PATH=$JAVA_HOME/bin:$JRE_HOME/bin:$MYCAT_HOME/bin:$PATH

WORKDIR ${MYCAT_HOME}

EXPOSE 9066 8066

CMD ["mycat", "console"]
