#!/bin/sh

docker run -itd \
    -p 11000:22 \
    -p 11001:3000 \
    -v /home/data/gogs:/data \
    --name=gogs \
    --hostname myGogs \
    gogs/gogs