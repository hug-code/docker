#!/bin/sh

docker run -d \
    --user=root \
    --privileged=true \
    -p 4999:80 \
    -v /showdoc_data/html:/var/www/html/
    --name showdoc \
    star7th/showdoc

# 更多参数详查：https://www.showdoc.com.cn/help/65610
