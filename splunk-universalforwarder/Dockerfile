FROM splunk/universalforwarder:7.0.0
MAINTAINER "Xiao Mo" <root@xiaomo.red>

COPY sources.list /etc/apt/sources.list

RUN apt-get update \
    && apt-get install wget jq autoconf binutils make gcc g++ --no-install-recommends -y \
    && wget --no-check-certificate -O /usr/local/src/curl-7.57.0.tar.gz https://curl.haxx.se/download/curl-7.57.0.tar.gz \
    && tar -zvxf /usr/local/src/curl-7.57.0.tar.gz -C /usr/local/src/ \
    && cd /usr/local/src/curl-7.57.0 \
    && ./configure && make install \
    && apt-get purge autoconf binutils g++ make wget -y \
    && apt-get autoremove -y \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/* /usr/local/src/*
