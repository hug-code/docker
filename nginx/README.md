# docker-build-nginx

> ### 镜像说明
1. nginx 编译已添加 echo 模块

> ### 构建
```shell script
docker build -t my_nginx .
```

> ### 创建容器
```shell script
docker run -d
  --name nginx
  -p 80:80
  -v /conf/nginx.conf:/usr/local/nginx/conf/nginx.conf
  -v /code:/home/wwwroot
  my_nginx
```

> ### nginx + php访问站点
```shell script
# 启动php容器
docker run -d
  --name php
  -p 9000:9000
  -v /code:/home/wwwroot
  my_php

# 注意，把php和nginx挂载在同一个数据卷下面

# 查看php容器的IP地址
docker inspect --format='{{.NetworkSettings.IPAddress}}' php

# nginx 解析php
location ~ .*\.php?$
{
    root /home/wwwroot/;
    include fastcgi_params;
    fastcgi_pass  <php容器ip>:9000;
    fastcgi_index index.php;
    fastcgi_param SCRIPT_FILENAME /$document_root$fastcgi_script_name;
}
```

> ### 配置文件参考
#### vue 站点配置
```shell script
server {
    listen       80;
    server_name  localhost;
    root         /home/wwwroot/web;
    index        index.html;
    
    # 路由设置为 history 需要配置，否则子页刷新404
    location / {
        try_files $uri $uri/ /index.html;
    }

    # access_log  /home/logs/nginx/access.log;
}

```
#### 配置跨域
```shell script
add_header Access-Control-Allow-Origin *;
add_header Access-Control-Allow-Headers *;
add_header Access-Control-Allow-Methods GET,POST,PUT,DELETE,OPTIONS;
```
