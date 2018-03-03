FROM php:7.2.0-fpm-alpine3.7

COPY repositories /etc/apk/repositories

RUN docker-php-ext-install pdo_mysql mysqli

ENV ZBLOG_VERSION=1.5.1
RUN set -ex; \
	curl -o Z-BlogPHP.zip -fSL "https://update.zblogcn.com/zip/Z-BlogPHP_1_5_1_1740_Zero.zip"; \
	mkdir /usr/src/zblog; \
	unzip Z-BlogPHP.zip -d /usr/src/zblog; \
	rm Z-BlogPHP.zip; \
	chown -R www-data:www-data /usr/src/zblog

VOLUME /var/www/html

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["php-fpm"]
