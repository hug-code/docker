#!/bin/sh

docker run -itd \
    -p 9000:9000 \
    -v /home/wwwroot:/home/wwwroot \
    --name php74 \
     my/php74
