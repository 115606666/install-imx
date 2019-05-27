#!/bin/sh

mkdir yocto && cd yocto && \
repo init \
    -u https://source.codeaurora.org/external/imx/imx-manifest \
    -b imx-linux-rocko -m imx-4.9.123-2.3.0-8mm_ga.xml && \
repo sync -c -j8
