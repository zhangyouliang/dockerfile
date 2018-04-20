FROM openjdk:8u151-jdk
MAINTAINER "Xiao Mo" <root@xiaomo.red>

COPY sources.list /etc/apt/sources.list

RUN apt-get update \
    && apt-get install tzdata --no-install-recommends -y \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/* \
    && echo "Asia/Shanghai" > /etc/timezone \
    && dpkg-reconfigure -f noninteractive tzdata

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

ENV DOCKER_CHANNEL stable
ENV DOCKER_VERSION 17.12.0-ce
RUN wget -O /usr/local/src/docker.tgz "https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/static/${DOCKER_CHANNEL}/x86_64/docker-${DOCKER_VERSION}.tgz" \
    && tar --strip-components=1 -xvzf /usr/local/src/docker.tgz -C /usr/local/bin \
    && rm -rf /usr/local/src/docker.tgz

ENV Jenkins_Version 2.107.2
RUN apt-get update \
    && apt-get install git wget --no-install-recommends -y \
    && mkdir -p /usr/share/jenkins /var/jenkins \
    && wget -O /usr/share/jenkins/jenkins.war https://mirrors.tuna.tsinghua.edu.cn/jenkins/war-stable/${Jenkins_Version}/jenkins.war \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*

ENV JENKINS_HOME /var/jenkins

EXPOSE 8080
VOLUME /var/jenkins

CMD ["java","-Dhudson.util.ProcessTree.disable=true","-jar","/usr/share/jenkins/jenkins.war"]
