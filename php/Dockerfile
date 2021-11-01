FROM php:7.4-fpm

ENV REDIS_VERSION=5.2.2
ENV AMQP_VERSION=1.10.2
ENV RABBITMQC_VERSION=0.8.0
#ENV IMAGICK_VERSION=3.4.4
#ENV IMAGEMAGICK_VERSION=7.0.10-39
ENV MONGO_VERSION=1.9.0
ENV COMPOSER_VERSION=2.0.8
ENV SWOOLE_VERSION=4.6.2

COPY conf/sources.list /opt/sources.list

WORKDIR /home/wwwroot

# 使用阿里云源更新
#RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak \
#    && mv /opt/sources.list /etc/apt/
RUN apt-get update \
    && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng-dev \
    libzip-dev \
    unixodbc-dev \
    apt-utils \
    procps \
    lsof \
    git \
    zip \
    unzip \
    libevent-dev \
    openssl \
    libssl-dev \
    libcurl4-openssl-dev \
    pkg-config \
    gcc g++ make autoconf libc-dev pkg-config

# 添加扩展并安装gd库
RUN docker-php-source extract \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd pcntl \
    && docker-php-ext-install bcmath sockets zip \
    && docker-php-ext-configure opcache --enable-opcache \
    && docker-php-ext-install opcache

# 拷贝所需要的扩展包
COPY extend/redis-${REDIS_VERSION}.tgz \
    extend/mongodb-${MONGO_VERSION}.tgz \
    extend/rabbitmq-c-${RABBITMQC_VERSION}.tar.gz \
    extend/amqp-${AMQP_VERSION}.tgz \
    extend/swoole-${SWOOLE_VERSION}.tgz \
    /opt/
#    extend/ImageMagick-${IMAGEMAGICK_VERSION}.tar.gz \
#    extend/imagick-${IMAGICK_VERSION}.tgz \

# 安装redis、pod_mysql、mongo扩展
RUN docker-php-ext-install pdo_mysql \
    && docker-php-ext-install mysqli \
    && pecl install /opt/redis-${REDIS_VERSION}.tgz \
    && docker-php-ext-enable redis \
    && pecl install /opt/mongodb-${MONGO_VERSION}.tgz \
    && docker-php-ext-enable mongodb \
    && pecl install /opt/swoole-${SWOOLE_VERSION}.tgz \
    && docker-php-ext-enable swoole

# 安装amqp扩展
RUN cd /opt/ && tar -zxvf rabbitmq-c-${RABBITMQC_VERSION}.tar.gz \
    && cd rabbitmq-c-${RABBITMQC_VERSION} \
    && ./configure --prefix=/usr/local/rabbitmq-c \
    && make && make install \
    && cd /opt/ && tar zxvf amqp-${AMQP_VERSION}.tgz && mv amqp-${AMQP_VERSION} /usr/src/php/ext/amqp \
    && cp /opt/rabbitmq-c-${RABBITMQC_VERSION}/librabbitmq/amqp_ssl_socket.h /usr/src/php/ext/amqp \
    && docker-php-ext-configure amqp --with-php-config=/usr/local/bin/php-config  --with-librabbitmq-dir=/usr/local/rabbitmq-c \
    && docker-php-ext-install amqp

# 安装imagick扩展
#RUN cd /opt/ && tar -zxvf ImageMagick-${IMAGEMAGICK_VERSION}.tar.gz \
#    && cd ImageMagick-${IMAGEMAGICK_VERSION} \
#    && ./configure --prefix=/usr/local/ImageMagick \
#    && make && make install \
#    && cd /opt/ && tar zxvf imagick-${IMAGICK_VERSION}.tgz && mv imagick-${IMAGICK_VERSION} /usr/src/php/ext/imagick \
#    && docker-php-ext-configure imagick --with-php-config=/usr/local/bin/php-config  --with-imagick=/usr/local/ImageMagick \
#    && docker-php-ext-install imagick

# 安装compser扩展  删除软件包
ADD extend/composer-${COMPOSER_VERSION}.phar /usr/local/bin/composer
RUN /usr/local/bin/composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/ \
    && chmod 755 /usr/local/bin/composer \
    && rm -rf /opt/*

EXPOSE 9000
