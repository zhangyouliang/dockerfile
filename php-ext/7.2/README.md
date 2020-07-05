
apk 坑点
=====

````
# del 会将 apk 安装的全部删除, 导致 mongodb 拓展出错 
apk add --no-cache -t .build g++ make autoconf  openssl-dev openssl
pecl install mongodb 
docker-php-ext-enable mongodb 
apk del .build

# 正确方式,将卸载和不卸载的分开
apk add --no-cache -t .build g++ make autoconf
apk add --no-cache openssl-dev openssl
pecl install mongodb 
docker-php-ext-enable mongodb
# 仅删除  g++ make autoconf
apk del .build
````




Docker php安装扩展步骤详解
=====

Docker 中的PHP容器安装扩展的方式有
- 通过pecl方式安装
- 通过php 容器中自带的几个特殊命令来安装，这些特殊命令可以在Dockerfile中的RUN命令中进行使用。

PHP中安装扩展有几个特殊的命令
- docker-php-source  
- docker-php-ext-install
- docker-php-ext-enable
- docker-php-ext-configure



1.docker-php-source
===
  
此命令，实际上就是在PHP容器中创建一个/usr/src/php的目录，里面放了一些自带的文件而已。我们就把它当作一个从互联网中下载下来的PHP扩展源码的存放目录即可。事实上，所有PHP扩展源码扩展存放的路径： /usr/src/php/ext 里面。

格式：

    docker-php-source extract | delete
    
参数说明：

* extract : 创建并初始化 /usr/src/php目录
* delete : 删除 /usr/src/php目录

2.docker-php-ext-enable
===

这个命令，就是用来启动 PHP扩展 的。我们使用pecl安装PHP扩展的时候，默认是没有启动这个扩展的，
如果想要使用这个扩展必须要在php.ini这个配置文件中去配置一下才能使用这个PHP扩展。
而 docker-php-ext-enable 这个命令则是自动给我们来启动PHP扩展的，不需要你去php.ini这个配置文件中去配置。


3.docker-php-ext-install
===

这个命令，是用来安装并启动PHP扩展的。

命令格式：

    docker-php-ext-install “源码包目录名”

注意点：

- “源码包“需要放在 `/usr/src/php/ext` 下
- 默认情况下，PHP容器没有 `/usr/src/php` 这个目录，需要使用 `docker-php-source extract`来生成。
- docker-php-ext-install 安装的扩展在安装完成后，会自动调用docker-php-ext-enable来启动安装的扩展。
- 卸载扩展，直接删除`/usr/local/etc/php/conf.d` 对应的配置文件即可。

4.docker-php-ext-configure
===

docker-php-ext-configure 一般都是需要跟 `docker-php-ext-install`搭配使用的。
它的作用就是，当你安装扩展的时候，需要自定义配置时，就可以使用它来帮你做到。

```

案例

FROM php:7.1-fpm
RUN apt-get update \
	# 相关依赖必须手动安装
	&& apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
    # 安装扩展
    && docker-php-ext-install -j$(nproc) iconv mcrypt \
    # 如果安装的扩展需要自定义配置时
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd
```



参考
==
- [Docker php安装扩展步骤详解](https://www.cnblogs.com/yinguohai/p/11329273.html)
