FROM php:7.2.0-fpm-alpine3.7
MAINTAINER "Xiao Mo" <root@xiaomo.red>
LABEL CALFBBS_VERSION=2.0

COPY repositories /etc/apk/repositories

RUN docker-php-ext-install pdo_mysql mysqli

# gd
RUN apk add --no-cache libpng-dev libjpeg-turbo-dev freetype-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd

RUN set -ex; \
	curl -o calfbbs.zip -fSL "http://www.calfbbs.cn/index.php?m=app&c=index&a=download"; \
	unzip calfbbs.zip -d /usr/src/; \
	rm calfbbs.zip; \
	chown -R www-data:www-data /usr/src/calfbbs

VOLUME /var/www/html

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["php-fpm"]
