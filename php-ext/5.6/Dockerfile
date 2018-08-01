FROM php:5.6.33-fpm-alpine3.4
MAINTAINER "Xiao Mo" <root@xiaomo.red>

COPY repositories /etc/apk/repositories

# Mysql
RUN docker-php-ext-install pdo_mysql mysqli

# Bzip2
RUN apk add --no-cache bzip2-dev \
    && docker-php-ext-install bz2

# gd
RUN apk add --no-cache libpng-dev libjpeg-turbo-dev freetype-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd

# Redis
RUN set -x \
    && apk add --no-cache -t .build git \
    && mkdir -p /usr/src/php/ext/ \
    && git clone -b master https://github.com/phpredis/phpredis.git /usr/src/php/ext/redis \
    && docker-php-ext-install redis \
    && apk del .build \
    && rm -rf /usr/src/php/ext/redis 

# Imagick
RUN set -x \
    && apk add --no-cache -t .build g++ make autoconf \
    && apk add --no-cache libtool imagemagick-dev \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && apk del .build

# Zip
RUN apk add --no-cache zlib-dev \
    && docker-php-ext-install zip

# iconv
RUN docker-php-ext-install iconv

# mcrypt
RUN apk add --no-cache libmcrypt-dev \
    && docker-php-ext-install mcrypt

# memcached