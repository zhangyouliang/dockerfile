FROM debian:jessie

RUN apt-get update \
    && apt-get install wget --no-install-recommends -y \
    && wget --no-cookies --no-check-certificate \
       -O /usr/local/src/jdk-9.0.1_linux-x64_bin.tar.gz \
       --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
       "http://download.oracle.com/otn-pub/java/jdk/9.0.1+11/jdk-9.0.1_linux-x64_bin.tar.gz" \
    && tar -zxf /usr/local/src/jdk-9.0.1_linux-x64_bin.tar.gz -C /usr/local/ \
    && mv /usr/local/jdk-9.0.1 /usr/local/java \
    && rm -rf /usr/local/src/* \
    && apt-get remove wget -y \
    && apt-get autoremove -y \
    && apt-get clean all

ENV JAVA_HOME /usr/local/java
ENV CLASSPATH $JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV PATH $PATH:$JAVA_HOME/bin:$JRE_HOME/bin
