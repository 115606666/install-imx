#!/bin/bash

    mkdir -p ~/log && \
    BUILD_NAME=`basename $0 .sh` && \
    LOG_FILENAME=~/log/build_${BUILD_NAME}_`date +%Y%m%d%H%M%S`.txt && \
    date +%Y%m%d%H%M%S | tee -a ${LOG_FILENAME} && \
    df                 | tee -a ${LOG_FILENAME} && \
    free               | tee -a ${LOG_FILENAME} && \
    \
    MACHINE_NAME=imx6qsabresd && \
    DISTRO_NAME=fsl-imx-fb && \
    IMAGE_NAME=core-image-minimal && \
    BUILD_PATH=${MACHINE_NAME} && \
    \
    echo MACHINE_NAME=${MACHINE_NAME} | tee -a ${LOG_FILENAME} && \
    echo DISTRO_NAME=${DISTRO_NAME}   | tee -a ${LOG_FILENAME} && \
    echo IMAGE_NAME=${IMAGE_NAME}     | tee -a ${LOG_FILENAME} && \
    echo BUILD_PATH=${BUILD_PATH}     | tee -a ${LOG_FILENAME} && \
    \
    echo export MACHINE_NAME=${MACHINE_NAME} >> ~/.bashrc && \
    echo export DISTRO_NAME=${DISTRO_NAME}   >> ~/.bashrc && \
    echo export IMAGE_NAME=${IMAGE_NAME}     >> ~/.bashrc && \
    echo export BUILD_PATH=${BUILD_PATH}     >> ~/.bashrc && \
    \
    cd ~/yocto && \
    \
    DISTRO=${DISTRO_NAME} MACHINE=${MACHINE_NAME} EULA=1 source ./fsl-setup-release.sh -b ${BUILD_PATH} && \
    \
    START_DATETIME=`date +%Y%m%d%H%M%S` && START_TIME=$(date +%s) && \
    echo START_DATETIME=${START_DATETIME} | tee -a ${LOG_FILENAME} && \
    \
    time bitbake ${IMAGE_NAME} 2>&1 | tee -a ${LOG_FILENAME} && \
    \
    END_DATETIME=$(date +%Y%m%d%H%M%S) && \
    END_TIME=$(date +%s) && \
    DIFF=$(echo "$END_TIME - $START_TIME" | bc) && \
    HH=$(echo "$DIFF / 3600" | bc) && \
    MM=$(echo "$DIFF - ($HH * 3600)" | bc) && \
    MM=$(echo "$MM / 60" | bc) && \
    SS=$(echo "$DIFF % 60" | bc) && \
    \
    echo START_DATETIME=${START_DATETIME} | tee -a ${LOG_FILENAME} && \
    echo END_DATETIME=${END_DATETIME}     | tee -a ${LOG_FILENAME} && \
    echo START_TIME=$START_TIME           | tee -a ${LOG_FILENAME} && \
    echo END_TIME=$END_TIME               | tee -a ${LOG_FILENAME} && \
    echo diff=$DIFF                       | tee -a ${LOG_FILENAME} && \
    echo $HH:$MM:$SS                      | tee -a ${LOG_FILENAME} && \
    \
    date +%Y%m%d%H%M%S | tee -a ${LOG_FILENAME} && \
    df                 | tee -a ${LOG_FILENAME} && \
    free               | tee -a ${LOG_FILENAME} && \
    \
    ls -la ~/yocto/imx6*/tmp/deploy/images/imx6* | tee -a ${LOG_FILENAME} && \
    echo "!!!!!! ${BUILD_NAME} done."
