FROM php:7.4-fpm

ENV REDIS_VERSION=5.2.2
ENV AMQP_VERSION=1.10.2
ENV RABBITMQC_VERSION=0.8.0

COPY conf/sources.list /opt/sources.list

WORKDIR /home/wwwroot

# 使用阿里云源更新并安装gd库
RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak \
    && mv /opt/sources.list /etc/apt/ \
    && apt-get update \
    && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng-dev \
    unixodbc-dev \
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
    gcc g++ make autoconf libc-dev pkg-config \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd pcntl

# 安装redis和pod_mysql扩展
COPY extend/redis-${REDIS_VERSION}.tgz /opt/redis.tgz
RUN docker-php-ext-install pdo_mysql \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install bcmath \
    && pecl install /opt/redis.tgz \
    && docker-php-ext-enable redis


# 安装amqp扩展
COPY extend/rabbitmq-c-${RABBITMQC_VERSION}.tar.gz /opt/rabbitmq-c.tar.gz
RUN cd /opt/ && tar -zxvf rabbitmq-c.tar.gz \
    && cd rabbitmq-c-${RABBITMQC_VERSION} \
    && ./configure --prefix=/usr/local/rabbitmq-c \
    && make && make install

COPY extend/amqp-${AMQP_VERSION}.tgz /opt/amqp.tgz
RUN docker-php-source extract \
    && cd /opt/ && tar zxvf amqp.tgz && mv amqp-${AMQP_VERSION} /usr/src/php/ext/amqp \
    && cp /opt/rabbitmq-c-${RABBITMQC_VERSION}/librabbitmq/amqp_ssl_socket.h /usr/src/php/ext/amqp \
    && docker-php-ext-configure amqp --with-php-config=/usr/local/bin/php-config  --with-librabbitmq-dir=/usr/local/rabbitmq-c \
    && docker-php-ext-install amqp

RUN rm -rf /opt/*.tgz && rm -rf /opt/*.tar.gz

# 安装compser扩展
ADD extend/composer.phar /usr/local/bin/composer
RUN chmod 755 /usr/local/bin/composer


EXPOSE 9000
