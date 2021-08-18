#!/bin/sh

docker run -p 6379:6379 \
    --restart=always \
    -itd \
    --name redis \
    -v /redis/data:/data \
    redis:6.2.1 \
    --requirepass 123456 \
    --appendonly yes
