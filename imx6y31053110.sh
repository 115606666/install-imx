#!/bin/sh

mkdir yocto && cd yocto && \
repo init \
    -u git://git.freescale.com/imx/fsl-arm-yocto-bsp.git -b imx-3.10.53-1.1.0_ga && \
repo sync -c -j8 && \
echo "!!!!!! docker-imx6y31053110 done."
