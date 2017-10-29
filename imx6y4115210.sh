#!/bin/sh

mkdir yocto && cd yocto && \
repo init \
    -u git://git.freescale.com/imx/fsl-arm-yocto-bsp.git -b imx-4.1-krogoth && \
repo sync -c -j8
