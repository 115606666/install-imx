#!/bin/sh

mkdir yocto && cd yocto && \
repo init \
    -u https://source.codeaurora.org/external/imx/fsl-arm-yocto-bsp \
    -b imx-morty && \
repo sync -c -j8
