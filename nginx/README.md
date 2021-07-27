# docker-build-nginx

> ### 镜像说明
1. nginx 编译已添加 echo 模块

> ### 构建
```shell script
docker build -t my_nginx .
```

> ### 创建容器
```shell script
docker run -d --name nginx -p 8883:80 -v /d/code:/home/wwwroot my_nginx
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
