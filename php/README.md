# docker-build-php

> #### 镜像说明
1. 当前php版本为php-7.4-fpm，可自定义php版本
2. 已安装redis和pod_mysql扩展
3. 已安装amqp扩展
4. 已安装composer


> #### 构建php
```shell script
docker build -t my_php .
```

> #### 使用 php-cli

##### (1).查看php版本
```
docker run -it --rm my_php php -v
```
##### (2).查看php安装的扩展模块
```
docker run -it --rm my_php php -m
```
##### (3).查看composer版本
```
docker run -it --rm my_php composer -V
