#!/bin/sh

docker run -p 27017:27017 \
    --restart=always \
    -v /home/data/mongo:/data/db \
    -itd \
    --name mongo  \
    -e MONGO_INITDB_ROOT_USERNAME=root \
    -e MONGO_INITDB_ROOT_PASSWORD=123456 \
    mongo --auth
