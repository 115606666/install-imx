#!/bin/bash

    mkdir ~/log && \
    BUILD_NAME=`basename $0 .sh` && \
    LOG_FILENAME=~/log/build_${BUILD_NAME}_`date +%Y%m%d%H%M%S`.txt && \
    date +%Y%m%d%H%M%S >> ${LOG_FILENAME} && \
    df                 >> ${LOG_FILENAME} && \
    free               >> ${LOG_FILENAME} && \
    \
    MACHINE_NAME=imx6qsabresd && \
    IMAGE_NAME=core-image-minimal && \
    BACKEND=fb && \
    BUILD_PATH=${MACHINE_NAME} && \
    \
    echo MACHINE_NAME=${MACHINE_NAME} >> ${LOG_FILENAME} && \
    echo IMAGE_NAME=${IMAGE_NAME}     >> ${LOG_FILENAME} && \
    echo BACKEND=${BACKEND}           >> ${LOG_FILENAME} && \
    echo BUILD_PATH=${BUILD_PATH}     >> ${LOG_FILENAME} && \
    \
    echo export MACHINE_NAME=${MACHINE_NAME} >> ~/.bashrc && \
    echo export IMAGE_NAME=${IMAGE_NAME}     >> ~/.bashrc && \
    echo export BACKEND=${BACKEND}           >> ~/.bashrc && \
    echo export BUILD_PATH=${BUILD_PATH}     >> ~/.bashrc && \
    \
    cd ~/yocto && \
    MACHINE=${MACHINE_NAME} EULA=1 source ./fsl-setup-release.sh -b ${BUILD_PATH} -e ${BACKEND} && \
    \
    START_DATETIME=`date +%Y%m%d%H%M%S` && START_TIME=$(date +%s) && \
    echo START_DATETIME=${START_DATETIME} && \
    echo IMAGE_NAME=${IMAGE_NAME} && \
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
    echo START_DATETIME=${START_DATETIME} && \
    echo END_DATETIME=${END_DATETIME} && \
    echo START_TIME=$START_TIME && \
    echo END_TIME=$END_TIME && \
    echo diff=$DIFF && echo $HH:$MM:$SS && \
    \
    echo START_DATETIME=${START_DATETIME} >> ${LOG_FILENAME} && \
    echo END_DATETIME=${END_DATETIME}     >> ${LOG_FILENAME} && \
    echo START_TIME=$START_TIME           >> ${LOG_FILENAME} && \
    echo END_TIME=$END_TIME               >> ${LOG_FILENAME} && \
    echo diff=$DIFF                       >> ${LOG_FILENAME} && \
    echo $HH:$MM:$SS                      >> ${LOG_FILENAME} && \
    \
    date +%Y%m%d%H%M%S >> ${LOG_FILENAME} && \
    df                 >> ${LOG_FILENAME} && \
    free               >> ${LOG_FILENAME} && \
    \
    date +%Y%m%d%H%M%S && df && free && \
    ls -la ~/yocto/imx6*/tmp/deploy/images/imx6* && \
    echo "!!!!!! ${BUILD_NAME} done."
