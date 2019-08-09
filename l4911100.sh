#!/bin/sh

mkdir yocto && cd yocto && \
repo init \
    -u git://git.freescale.com/imx/fsl-arm-yocto-bsp.git \
    -b imx-morty && \
repo sync -c -j8
