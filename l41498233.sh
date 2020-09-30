#!/bin/sh

mkdir yocto && cd yocto && \
repo init \
    -u https://source.codeaurora.org/external/imx/imx-manifest \
    -b imx-linux-sumo -m imx-4.14.98-2.3.3.xml && \
repo sync -c -j8
