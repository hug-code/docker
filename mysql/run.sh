#!/bin/sh

docker run -itd \
 -p 3306:3306 \
 --name mysql \
 --hostname mysql \
 --restart=always \
 -e MYSQL_ROOT_PASSWORD=123456 \
 mysql:5.7