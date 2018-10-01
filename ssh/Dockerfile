FROM ubuntu:16.04
MAINTAINER Xiao Mo

COPY sources.list /etc/apt/sources.list

RUN apt-get update \
    && apt-get install -y openssh-server \
    && mkdir /var/run/sshd \
    && sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config \
    && apt-get clean all

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ENV ROOT_PASSWORD=root

EXPOSE 22

CMD ["docker-entrypoint.sh"]