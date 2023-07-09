#!/bin/bash

IMAGE_NAME=local/esp8266:latest

docker build -t $IMAGE_NAME .
