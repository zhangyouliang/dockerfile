FROM alpine:3.5
MAINTAINER "Mo" <root@ywclub.org>

COPY repositories /etc/apk/repositories

# Set Software Version
ENV NGINX_VERSION 1.13.0
ENV PHP_VIRSION 7.1.10
ENV CURL_VERSION 7.54.0
ENV GITBLOG_VERSION 2.3.2

# Install Nginx Build Environmental
RUN apk add --no-cache jemalloc-dev pcre-dev openssl-dev geoip-dev
# Install Nginx
RUN apk add --no-cache --virtual /tmp/nginx.build wget g++ make \
    && mkdir -p /usr/local/src/ \
    && wget -O /usr/local/src/nginx-${NGINX_VERSION}.tar.gz http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz \
    && tar -zxf /usr/local/src/nginx-${NGINX_VERSION}.tar.gz -C /usr/local/src/ \
    && cd /usr/local/src/nginx-${NGINX_VERSION}/ \
    && ./configure --user=www \
       --group=www \
       --prefix=/usr/local/nginx \
       --with-http_ssl_module \
       --with-http_v2_module \
       --with-http_gzip_static_module \
       --with-http_sub_module \
       --with-http_geoip_module \
       --with-ld-opt=-ljemalloc \
    && make && make install \
    && addgroup www \
    && adduser -D -G www -s /sbin/nologin www \
    # && ln -sf /dev/stdout /usr/local/nginx/logs/access.log \
    # && ln -sf /dev/stderr /usr/local/nginx/logs/error.log \
    && rm -rf /usr/local/src/* /usr/local/nginx/html \
    && apk del --no-cache --virtual /tmp/nginx.build \
    && mkdir /www

# Install Curl
RUN apk add --no-cache --virtual /tmp/curl.build g++ make openssl \
    && wget -O /usr/local/src/curl-${CURL_VERSION}.tar.gz https://curl.haxx.se/download/curl-${CURL_VERSION}.tar.gz \
    && tar -zxf /usr/local/src/curl-${CURL_VERSION}.tar.gz -C /usr/local/src/ \
    && cd /usr/local/src/curl-${CURL_VERSION}/ \
    && ./configure --prefix=/usr \
    && make && make install \
    && rm -rf /usr/local/src/* \
    && apk del --no-cache --virtual /tmp/curl.build

# Install PHP Build Environmental
RUN apk add --no-cache libxml2-dev jpeg-dev openssl-dev libpng-dev freetype-dev gettext-dev icu-dev libmcrypt-dev libxslt-dev
# Install PHP
RUN sh -e \
    && apk add --no-cache --virtual /tmp/php.build g++ make \
    && ping jp2.php.net -c 3 \
    && ls -d /usr/local/src/ \
    && echo " wget -O /usr/local/src/php-${PHP_VIRSION}.tar.gz http://jp2.php.net/distributions/php-${PHP_VIRSION}.tar.gz"  \
    && wget -O /usr/local/src/php-${PHP_VIRSION}.tar.gz http://jp2.php.net/distributions/php-${PHP_VIRSION}.tar.gz \
    && tar -zxf /usr/local/src/php-${PHP_VIRSION}.tar.gz -C /usr/local/src/ \
    && cd /usr/local/src/php-${PHP_VIRSION}/ \
    && ./configure \
       --prefix=/usr/local/php \
       --with-config-file-path=/usr/local/php/etc \
       --enable-fpm \
       --with-fpm-user=www \
       --with-fpm-group=www \
       --enable-mysqlnd \
       --with-mysqli=mysqlnd  \
       --with-pdo-mysql=mysqlnd \
       --with-iconv-dir \
       --with-freetype-dir \
       --with-jpeg-dir  \
       --with-png-dir \
       --with-zlib \
       --with-libxml-dir=/usr \
       --enable-xml \
       --disable-rpath \
       --enable-bcmath \
       --enable-shmop \
       --enable-sysvsem \
       --enable-inline-optimization \
       --with-curl=/usr \
       --enable-mbregex \
       --enable-mbstring \
       --enable-intl \
       --enable-pcntl \
       --with-mcrypt \
       --enable-ftp \
       --with-gd \
       --enable-gd-native-ttf \
       --with-openssl \
       --with-mhash \
       --enable-pcntl \
       --enable-sockets \
       --with-xmlrpc \
       --enable-zip \
       --enable-soap \
       --with-gettext \
       --disable-fileinfo \
       --enable-opcache \
       --with-xsl \
    && make \
    && make install \
    && cp /usr/local/src/php-${PHP_VIRSION}/php.ini-production /usr/local/php/etc/php.ini \
    && sed -i 's/post_max_size =.*/post_max_size = 50M/g' /usr/local/php/etc/php.ini \
    && sed -i 's/upload_max_filesize =.*/upload_max_filesize = 50M/g' /usr/local/php/etc/php.ini \
    && sed -i 's/;date.timezone =.*/date.timezone = PRC/g' /usr/local/php/etc/php.ini \
    && sed -i 's/short_open_tag =.*/short_open_tag = On/g' /usr/local/php/etc/php.ini \
    && sed -i 's/;cgi.fix_pathinfo=.*/cgi.fix_pathinfo=0/g' /usr/local/php/etc/php.ini \
    && sed -i 's/max_execution_time =.*/max_execution_time = 300/g' /usr/local/php/etc/php.ini \
    && curl -sS https://getcomposer.org/installer | /usr/local/php/bin/php -- --install-dir=/usr/local/bin --filename=composer \
    && /usr/local/php/bin/pear config-set php_ini /usr/local/php/etc/php.ini \
    && /usr/local/php/bin/pecl config-set php_ini /usr/local/php/etc/php.ini \
    && rm -rf /usr/local/src/* \
    && apk del --no-cache --virtual /tmp/php.build

# Install Supervisor
RUN apk add --no-cache supervisor \
    && mkdir -p /etc/supervisor/supervisord.d \
    && echo_supervisord_conf > /etc/supervisor/supervisord.conf \
    && rm -rf /tmp/

# Install Git
RUN apk add --no-cache git

# Config Nginx
COPY nginx.conf /usr/local/nginx/conf/nginx.conf
ENV NGINX_HOME /usr/local/nginx
ENV PATH $PATH:$NGINX_HOME/sbin

# Config PHP
COPY php-fpm.conf /usr/local/php/etc/php-fpm.conf
ENV PHP_HOME /usr/local/php
ENV PATH $PATH:$PHP_HOME/sbin

# Config Supervisor
RUN sed -i "s/;chmod=0700/chmod=0777/g" /etc/supervisor/supervisord.conf \
    && sed -i "s/;chown=nobody:nogroup/chown=root:root/g" /etc/supervisor/supervisord.conf \
    && sed -i "s/;port=127.0.0.1:9001/port=9001/g" /etc/supervisor/supervisord.conf \
    && sed -i "s/nodaemon=false/nodaemon=true/g" /etc/supervisor/supervisord.conf \
    && sed -i "s/;user=chrism/user=root/g" /etc/supervisor/supervisord.conf \
    && sed -i "s/;childlogdir=\/tmp/childlogdir=\/tmp/g" /etc/supervisor/supervisord.conf \
    && sed -i "s#;\[include\]#\[include\]#g" /etc/supervisor/supervisord.conf \
    && sed -i "s#;files = relative/directory/\*.ini#files = /etc/supervisor/supervisord.d/\*.ini#" /etc/supervisor/supervisord.conf
COPY nginx.ini /etc/supervisor/supervisord.d/
COPY php-fpm.ini /etc/supervisor/supervisord.d/

# Config GitBlog log
RUN mkdir /var/log/gitblog \
    && touch /var/log/gitblog/nginx.error.log /var/log/gitblog/php-fpm.log /var/log/gitblog/php-fpm.slow.log /var/log/gitblog/nginx.access.log

# COPY www/gitblog.tar.gz /tmp/
RUN apk add --no-cache --virtual /tmp/gitblog.build openssl \
    && mkdir /tmp \
    && wget -O /tmp/gitblog-${GITBLOG_VERSION}.tar.gz https://codeload.github.com/jockchou/gitblog/tar.gz/v${GITBLOG_VERSION} \
    && tar -zxf /tmp/gitblog-${GITBLOG_VERSION}.tar.gz -C /tmp/ \
    && cd /tmp/gitblog-${GITBLOG_VERSION} \
    && mv * /www/ \
    && mv /www/blog /www/tmp \
    && rm -rf  /tmp/* \
    && apk del --no-cache --virtual /tmp/gitblog.build

COPY docker-entrypoint.sh /docker-entrypoint.sh

EXPOSE 80 443

VOLUME /www

ENV GIT_URL **NULL**
ENV GIT_USER **NULL**
ENV GIT_PASS **NULL**

CMD ["/docker-entrypoint.sh"]
