#!/bin/sh

docker run -itd \
 -p 3306:3306 \
 --name mysql \
 --hostname mysql \
 --restart=always \
 -e MYSQL_ROOT_PASSWORD=123456 \
 mysql:5.7 \
 --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci
