FROM daocloud.io/buxiaomo/oracle-jdk:8u181
MAINTAINER "Xiao Mo" <root@xiaomo.red>

ENV VERSION 6.2.4
RUN apt-get update \
    && apt-get install wget -y \
    && wget https://artifacts.elastic.co/downloads/kibana/kibana-${VERSION}-linux-x86_64.tar.gz -O /usr/local/src/kibana-${VERSION}-linux-x86_64.tar.gz \
    && tar -zvxf /usr/local/src/kibana-${VERSION}-linux-x86_64.tar.gz -C /usr/local/ \
    && mv /usr/local/kibana-${VERSION}-linux-x86_64 /usr/local/kibana \
    && rm -rf /usr/local/src/* \
    && apt-get remove wget -y \
    && apt-get autoremove -y \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*
ENV ELASTICSEARCH_HOME /usr/local/kibana

RUN useradd elk \
    && chown -R elk.elk /usr/local/kibana

USER elk

WORKDIR /usr/local/kibana

CMD ["/usr/local/kibana/bin/kibana"]