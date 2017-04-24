#!/bin/sh

mkdir yocto && cd yocto && \
repo init \
    -u git://git.freescale.com/imx/fsl-arm-yocto-bsp.git -b imx-4.1-krogoth -m imx-4.1.15-2.0.3.xml && \
repo sync -c -j8
