FROM php:7.2.8-fpm-alpine3.7
MAINTAINER "ZYL" <1577121881@qq.com>

COPY repositories /etc/apk/repositories

# The main mirrors are giving us timeout issues on builds periodically.
# So we can try these.
ENV TZ=Asia/Shanghai

RUN apk update \
    && apk upgrade \
    && apk add --no-cache bash bash-doc bash-completion \
    && apk add --no-cache supervisor openssl-dev openssl \
    && apk add --no-cache  tzdata zeromq \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && docker-php-ext-install mbstring opcache pdo_mysql mysqli iconv \
    # nginx
    && apk add --no-cache nginx && mkdir /run/nginx/  \
    # bzip2
    && apk add --no-cache bzip2-dev && docker-php-ext-install bz2 \
    # gd
    && set -ex \
    && apk add --no-cache libpng-dev libjpeg-turbo-dev freetype-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    # mcrypt
    && apk add --no-cache -t .build autoconf g++ make \
    && apk add --no-cache libmcrypt-dev \
    && pecl install mcrypt-1.0.1 \
    && docker-php-ext-enable mcrypt \
    && apk del .build \
    # Redis
    && apk add --no-cache --virtual .build-deps g++ make autoconf \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && apk del .build-deps \
    # Zip
    && apk add --no-cache zlib-dev \
    && docker-php-ext-install zip \
    # Imagick
    && apk add --no-cache -t .build g++ make autoconf \
    && apk add --no-cache libtool imagemagick-dev \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && apk del .build \
    # grpc
    && apk add --no-cache -t .build g++ make autoconf zlib zlib-dev \
    && apk add --no-cache linux-headers \
    && pecl install grpc \
    && docker-php-ext-enable grpc \
    && apk del .build \
    && rm -rf /var/cache/apk/*
