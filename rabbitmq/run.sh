#!/bin/sh

docker run -itd \
    -p 5672:5672 \
    -p 15672:15672 \
    --name rabbitmq  \
    --hostname myRabbit \
    --restart always \
    -e RABBITMQ_DEFAULT_USER=admin \
    -e RABBITMQ_DEFAULT_PASS=admin  \
    rabbitmq:3.8.6-management