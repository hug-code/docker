### 使用redis.conf
您可以创建自己的 Dockerfile，将上下文中的 redis.conf 添加到 /data/ 中，就像这样。
```text
FROM redis
COPY redis.conf /usr/local/etc/redis/redis.conf
CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]
```
或者，您可以使用docker run选项指定相同的内容。
```text
$ docker run -v /myredis/conf:/usr/local/etc/redis --name my_redis redis redis-server /usr/local/etc/redis/redis.conf
```
/myredis/conf/包含您的redis.conf文件的本地目录在哪里。

使用这种方法意味着你不需要为你的 redis 容器创建一个 Dockerfile。
