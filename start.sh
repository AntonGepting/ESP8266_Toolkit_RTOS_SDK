#!/bin/bash

IMAGE_NAME=local/esp8266:latest
CONTAINER_NAME=esp8266

docker run -it \
    --rm \
    --name $CONTAINER_NAME \
    --entrypoint=/bin/bash \
    --device /dev/ttyUSB0:/dev/ttyUSB0 \
    -v `pwd`:/build \
    $IMAGE_NAME
