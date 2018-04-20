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
    && apk del -t .build

# Zip
RUN apk add --no-cache zlib-dev \
    && docker-php-ext-install zip

RUN apk add --no-cache git

COPY docker-entrypoint.sh /usr/local/bin/

ENV GIT_URL=NULL \
		Configure_SCR=NULL \
		Configure_DEST=NULL

CMD ["docker-entrypoint.sh"]
