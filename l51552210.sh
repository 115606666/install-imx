#!/bin/sh

mkdir yocto && cd yocto && \
repo init \
    -u https://github.com/nxp-imx/imx-manifest \
    -b imx-linux-kirkstone -m imx-5.15.52-2.1.0.xml && \
repo sync -c -j8
