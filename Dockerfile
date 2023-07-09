# [Info](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
# [Info](https://docs.espressif.com/projects/esp8266-rtos-sdk/en/release-v3.3/get-started/linux-setup.html)
#
FROM python:2.7

MAINTAINER Anton Gepting anton.gepting@gmail.com

# No user actions for apt-get
ARG DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update -qq \
    && apt-get install -qy \
        gcc \
        git \
        wget \
        make \
        libncurses-dev \
        flex \
        bison \
        gperf \
        python-pip \
        python-serial \
    && rm -rf /var/lib/apt/lists/*

# Toolchain
ARG TOOLCHAIN_FILE=xtensa-lx106-elf-linux64-1.22.0-100-ge567ec7-5.2.0.tar.gz
ARG TOOLCHAIN_URL=https://dl.espressif.com/dl/$TOOLCHAIN_FILE

# SDK URL
ARG ESP8266_RTOS_SDK_URL=https://github.com/espressif/ESP8266_RTOS_SDK.git

# ESP Directory
ARG ESP_PATH=/root/esp
# SDK Directory
ENV IDF_PATH=${ESP_PATH}/ESP8266_RTOS_SDK

# Add ESP bin to $PATH
ENV PATH="${PATH}:${ESP_PATH}/xtensa-lx106-elf/bin"

# Download & unpack toolchain
RUN mkdir -p ${ESP_PATH} \
    && cd ${ESP_PATH} \
    && wget ${TOOLCHAIN_URL} \
    && tar -xzf ${TOOLCHAIN_FILE} \
    && rm ${TOOLCHAIN_FILE}

# Download SDK + Install pip requirements
RUN cd ${ESP_PATH} \
    && git clone -b release/v3.3 --recursive ${ESP8266_RTOS_SDK_URL} \
    && python2.7 -m pip install --user -r ${IDF_PATH}/requirements.txt
