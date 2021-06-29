#!/bin/bash

SEP_LINE=------------------------------------------------------------------
LOG_FILENAME=
START_TIME=
DIFF_TIME=

print_df_free()
{
    date +%Y%m%d%H%M%S | tee -a $LOG_FILENAME
    df                 | tee -a $LOG_FILENAME
    free               | tee -a $LOG_FILENAME
}

print_sep_line()
{
    echo $SEP_LINE | tee -a $LOG_FILENAME
}

get_start_time()
{
    local START_DATETIME=`date +%Y%m%d%H%M%S`
    START_TIME=$(date +%s)
    echo START_DATETIME=${START_DATETIME} | tee -a ${LOG_FILENAME}
}

print_diff_time()
{
    local END_DATETIME=$(date +%Y%m%d%H%M%S)
    local END_TIME=$(date +%s)
    local DIFF=$(echo "$END_TIME - $START_TIME" | bc)
    local HH=$(echo "$DIFF / 3600" | bc)
    local MM=$(echo "$DIFF - ($HH * 3600)" | bc)
    local MM=$(echo "$MM / 60" | bc)
    local SS=$(echo "$DIFF % 60" | bc)
    DIFF_TIME=$HH:$MM:$SS
    echo DIFF_TIME=$DIFF_TIME
}

    mkdir -p ~/log
    BUILD_NAME=`basename $0 .sh`
    LOG_FILENAME=~/log/build_${BUILD_NAME}_`date +%Y%m%d%H%M%S`.txt
    print_df_free

    MACHINE_NAME=imx7dsabresd
    DISTRO_NAME=fsl-imx-fb
    IMAGE_NAME=core-image-minimal
    BUILD_PATH=build

    echo MACHINE_NAME=${MACHINE_NAME} | tee -a ${LOG_FILENAME}
    echo DISTRO_NAME=${DISTRO_NAME}   | tee -a ${LOG_FILENAME}
    echo IMAGE_NAME=${IMAGE_NAME}     | tee -a ${LOG_FILENAME}
    echo BUILD_PATH=${BUILD_PATH}     | tee -a ${LOG_FILENAME}

    echo export MACHINE_NAME=${MACHINE_NAME} | tee -a ~/.bashrc
    echo export DISTRO_NAME=${DISTRO_NAME}   | tee -a ~/.bashrc
    echo export IMAGE_NAME=${IMAGE_NAME}     | tee -a ~/.bashrc
    echo export BUILD_PATH=${BUILD_PATH}     | tee -a ~/.bashrc

    cd ~/yocto

    # Build yocto
    print_sep_line
    print_df_free
    get_start_time
    [ -f ./fsl-setup-release.sh ] && DISTRO=${DISTRO_NAME} MACHINE=${MACHINE_NAME} EULA=1 source ./fsl-setup-release.sh -b ${BUILD_PATH}
    [ -f ./imx-setup-release.sh ] && DISTRO=${DISTRO_NAME} MACHINE=${MACHINE_NAME} EULA=1 source ./imx-setup-release.sh -b ${BUILD_PATH}
    grep PACKAGE_CLASSES conf/local.conf
    sed -i 's,^PACKAGE_CLASSES\ =\ \"package_deb\",#PACKAGE_CLASSES\ =\ \"package_deb\",' conf/local.conf
    grep PACKAGE_CLASSES conf/local.conf
    time bitbake ${IMAGE_NAME} 2>&1 | tee -a ${LOG_FILENAME}
    print_diff_time
    TIME1=$DIFF_TIME
    ls -la tmp/deploy/images/* | tee -a ${LOG_FILENAME}
    print_df_free

    # build SDK
    print_sep_line
    print_df_free
    get_start_time
    time bitbake $IMAGE_NAME -c populate_sdk 2>&1 | tee -a $LOG_FILENAME
    print_diff_time
    TIME2=$DIFF_TIME
    ls -la tmp/deploy/sdk | tee -a $LOG_FILENAME
    print_df_free

    # Print summary
    print_sep_line
    echo TIME1=$TIME1 | tee -a $LOG_FILENAME
    echo TIME2=$TIME2 | tee -a $LOG_FILENAME

    echo "!!!!!! ${BUILD_NAME} done."
