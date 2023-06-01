#!/bin/sh

mkdir yocto && cd yocto && \
repo init \
    -u https://github.com/nxp-imx/imx-manifest \
    -b imx-linux-langdale -m imx-6.1.1-1.0.0.xml && \
repo sync -c -j8
