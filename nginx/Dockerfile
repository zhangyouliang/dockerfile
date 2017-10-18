FROM alpine:3.5
MAINTAINER "Cloth Mo" <root@buxiaomo.com>

COPY repositories /etc/apk/repositories

ENV NGINX_VERSION 1.13.6
RUN apk add --no-cache wget g++ make jemalloc-dev pcre-dev openssl-dev geoip-dev \
	&& mkdir -p /usr/local/src/ \
	&& wget -O /usr/local/src/nginx-${NGINX_VERSION}.tar.gz http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz \
	&& tar -zxf /usr/local/src/nginx-${NGINX_VERSION}.tar.gz -C /usr/local/src/ \
	&& cd /usr/local/src/nginx-${NGINX_VERSION}/ \
	&& ./configure --prefix=/etc/nginx \
		--sbin-path=/usr/sbin/nginx \
		--modules-path=/usr/lib64/nginx/modules \
		--conf-path=/etc/nginx/nginx.conf \
		--error-log-path=/var/log/nginx/error.log \
		--http-log-path=/var/log/nginx/access.log \
		--pid-path=/var/run/nginx.pid \
		--lock-path=/var/run/nginx.lock \
		--http-client-body-temp-path=/var/cache/nginx/client_temp \
		--http-proxy-temp-path=/var/cache/nginx/proxy_temp \
		--http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
		--http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
		--http-scgi-temp-path=/var/cache/nginx/scgi_temp \
		--user=nginx --group=nginx --with-compat \
		--with-threads --with-http_mp4_module \
		--with-http_addition_module --with-http_auth_request_module \
		--with-http_dav_module --with-http_flv_module \
		--with-http_gunzip_module --with-http_gzip_static_module \
		--with-http_random_index_module --with-http_realip_module \
		--with-http_secure_link_module \
		--with-http_slice_module --with-stream \
		--with-http_ssl_module --with-http_stub_status_module \
		--with-http_sub_module --with-http_v2_module \
		--with-stream_realip_module --with-stream_ssl_module \
		--with-stream_ssl_preread_module --with-ld-opt=-ljemalloc --with-http_geoip_module \
	&& make && make install \
	&& addgroup nginx \
    && adduser -D -G nginx -s /sbin/nologin nginx \
	&& rm -rf /usr/local/src/* \
	&& ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log \
	&& mkdir /etc/nginx/conf.d/ \
	&& apk del --no-cache g++ gcc binutils isl libatomic libc-dev musl-dev make binutils-libs mpc1 mpfr3 gmp libgomp

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80 443

VOLUME /www

CMD ["/usr/sbin/nginx","-g","daemon off;"]
