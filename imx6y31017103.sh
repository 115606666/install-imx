#!/bin/sh

mkdir yocto && cd yocto && \
repo init \
    -u git://git.freescale.com/imx/fsl-arm-yocto-bsp.git -b imx-3.10.17-1.0.3_patch && \
repo sync -c -j8
