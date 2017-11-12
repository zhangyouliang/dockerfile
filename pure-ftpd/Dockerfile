FROM alpine:3.5

COPY repositories /etc/apk/repositories

ARG PUREFTPD_VERSION=1.0.47

ARG PUREFTPD_CONFIGURE="--prefix=/usr/local/pureftpd CFLAGS=-O2 --with-mysql --with-puredb --with-quotas --with-cookie --with-virtualhosts --with-diraliases --with-sysquotas --with-ratios --with-altlog --with-paranoidmsg --with-shadow --with-welcomemsg --with-throttling --with-uploadscript --with-language=english --with-rfc2640 --with-ftpwho --with-tls"

RUN mkdir /usr/local/src \
    && apk add --no-cache --update --virtual .build-deps  ca-certificates openssl \
    && update-ca-certificates \
    && wget -O /usr/local/src/pure-ftpd-${PUREFTPD_VERSION}.tar.gz https://download.pureftpd.org/pub/pure-ftpd/releases/pure-ftpd-${PUREFTPD_VERSION}.tar.gz \
    && tar -zvxf /usr/local/src/pure-ftpd-${PUREFTPD_VERSION}.tar.gz -C /usr/local/src \
    && apk del --no-cache --virtual .build-deps \
    && apk add --no-cache --update --virtual .build-deps g++ make \
    && apk add --no-cache mariadb-dev \
    && cd /usr/local/src/pure-ftpd-${PUREFTPD_VERSION} \
    && ./configure ${PUREFTPD_CONFIGURE} \
    && make && make install \
    && apk del --no-cache --virtual .build-deps
