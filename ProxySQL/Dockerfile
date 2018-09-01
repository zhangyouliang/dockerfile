FROM ubuntu:16.04
MAINTAINER Xiao Mo

COPY sources.list /etc/apt/sources.list

RUN apt-get update \
    && apt-get install -y wget lsb-release \
    && wget -O - 'http://repo.proxysql.com/ProxySQL/repo_pub_key' | apt-key add - \
    && echo deb http://repo.proxysql.com/ProxySQL/proxysql-1.4.x/$(lsb_release -sc)/ ./ \
       | tee /etc/apt/sources.list.d/proxysql.list \
    && apt-get update \
    && apt-get install proxysql \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

VOLUME [ "/var/lib/proxysql" ]

EXPOSE 6032 6033

CMD [ "docker-entrypoint.sh" ]