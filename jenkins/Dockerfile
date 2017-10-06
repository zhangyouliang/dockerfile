FROM ubuntu:16.04
MAINTAINER "Cloth Mo" <root@buxiaomo.com>

COPY sources.list /etc/apt/sources.list

RUN apt-get update \
    && apt-get install tzdata --no-install-recommends -y \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/* \
    && echo "Asia/Shanghai" > /etc/timezone \
    && dpkg-reconfigure -f noninteractive tzdata

RUN apt-get update \
    && apt-get install openjdk-8-jdk --no-install-recommends -y \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64
ENV CLASSPATH $JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV PATH $PATH:$JAVA_HOME/bin:$JRE_HOME/bin

RUN apt-get update \
    && apt-get install ant --no-install-recommends -y \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*
ENV ANT_HOME /usr/share/ant
ENV PATH $PATH:$ANT_HOME/bin

RUN apt-get update \
    && apt-get install maven --no-install-recommends -y \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*
ENV MAVEN_HOME /usr/share/maven/
ENV PATH $PATH:$MAVEN_HOME/bin

RUN apt-get update \
    && apt-get install git wget --no-install-recommends -y \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*

RUN wget -O /usr/local/src/docker-17.03.0-ce.tgz  https://get.docker.com/builds/Linux/x86_64/docker-17.03.0-ce.tgz \
    && tar --strip-components=1 -xvzf /usr/local/src/docker-17.03.0-ce.tgz -C /usr/local/bin \
    && rm -rf /usr/local/src/docker-17.03.0-ce.tgz

ENV Jenkins_Version 2.73.1
RUN mkdir -p /usr/share/jenkins /var/jenkins \
    && wget -O /usr/share/jenkins/jenkins.war https://mirrors.tuna.tsinghua.edu.cn/jenkins/war-stable/${Jenkins_Version}/jenkins.war \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*

ENV JENKINS_HOME /var/jenkins

EXPOSE 8080
VOLUME /var/jenkins

CMD ["java","-Dhudson.util.ProcessTree.disable=true","-jar","/usr/share/jenkins/jenkins.war"]
