#!/bin/sh

mkdir yocto && cd yocto && \
repo init \
    -u https://source.codeaurora.org/external/imx/imx-manifest \
    -b imx-linux-warrior -m imx-4.19.35-1.1.0.xml && \
repo sync -c -j8
