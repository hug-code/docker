# docker-run-rabbit mq

> #### 启动参数说明

```shell script
-p 5672:5672                    默认TCP监听端口
-p 15672:15672                  web管理界面端口
--name rabbitmq                 指定容器名字
--hostname myRabbit             设置容器里面的主机名
--restart always                容器退出时的重启策略
         # no：容器退出时不重启
         # on-failure：容器故障退出（返回值非零）时重启
         # always：容器退出时总是重启

-e RABBITMQ_DEFAULT_USER=admin  初始用户名
-e RABBITMQ_DEFAULT_PASS=admin  初始密码
rabbitmq:3.8.6-management       指定镜像
```