FROM php:7.2.0-fpm-alpine3.7

COPY repositories /etc/apk/repositories

RUN docker-php-ext-install pdo_mysql mysqli

ENV CHANZHI_VERSION 6.7.1
RUN set -ex; \
	curl -o chanzhieps.zip -fSL "http://dl.cnezsoft.com/chanzhi/${CHANZHI_VERSION}/chanzhiEPS.${CHANZHI_VERSION}.zip"; \
	unzip chanzhieps.zip -d /usr/src/; \
	rm chanzhieps.zip; \
	chown -R www-data:www-data /usr/src/chanzhieps

VOLUME /var/www/html

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["php-fpm"]
