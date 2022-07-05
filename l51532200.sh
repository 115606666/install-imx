#!/bin/sh

mkdir yocto && cd yocto && \
repo init \
    -u https://source.codeaurora.org/external/imx/imx-manifest \
    -b imx-linux-kirkstone -m imx-5.15.32-2.0.0.xml && \
repo sync -c -j8
