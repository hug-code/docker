FROM centos:7

RUN yum update -y \
    && yum install -y gcc-c++ gcc automake \
    autoconf libtool make pcre pcre-devel openssl openssl-devel gd gd-devel \
    && groupadd www \
    && useradd -r -g www www \
    && mkdir -p  /home/wwwroot /tmp/nginx \
    && chmod +w /home/wwwroot \
    && chown -R www:www /home/wwwroot

WORKDIR /home/wwwroot

COPY module/echo-nginx-module-0.61.tar.gz \
     module/nginx-1.12.2.tar.gz \
     /tmp/nginx/

RUN cd /tmp/nginx \
    && tar zxf nginx-1.12.2.tar.gz \
    && tar zxf echo-nginx-module-0.61.tar.gz \
    && cd nginx-1.12.2 \
    &&  ./configure \
     --user=www \
     --group=www \
     --prefix=/usr/local/nginx \
     --with-http_stub_status_module \
     --with-http_ssl_module \
     --with-http_v2_module \
     --add-module=/tmp/nginx/echo-nginx-module-0.61 \
    && make && make install \
    && rm -rf /tmp/nginx

ENV PATH /usr/local/nginx/sbin:$PATH

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
