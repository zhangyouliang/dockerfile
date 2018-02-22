FROM php:7.2.0-fpm-alpine3.7

COPY repositories /etc/apk/repositories

ENV H5AI_VERSION 0.29.0
RUN set -ex; \
	curl -o h5ai.zip -fSL "https://release.larsjung.de/h5ai/h5ai-${H5AI_VERSION}.zip"; \
	mkdir /usr/src/_h5ai ; \
	unzip h5ai.zip -d /usr/src/_h5ai; \
	rm h5ai.zip; \
	chown -R www-data:www-data /usr/src/_h5ai

VOLUME /var/www/html

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["php-fpm"]
