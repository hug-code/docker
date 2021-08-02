# docker-build-php

> ### 镜像说明
1. 当前php版本为php-7.4-fpm，可自定义php版本
2. 已添加的扩展：redis pod_mysql amqp mongodb imagick bcmath sockets zip swoole
3. 已添加composer

> ### 构建
```shell script
docker build -t my_php .
```

> ### 创建容器
```shell script
docker run -d --name php -p 9000:9000 my_php
```

> ### 使用 php-cli

#### 查看php版本
```
docker run -it --rm my_php php -v
```
#### 查看php安装的扩展模块
```
docker run -it --rm my_php php -m
```
#### 查看composer版本
```
docker run -it --rm my_php composer -V
