#!/bin/sh

mkdir yocto && cd yocto && \
repo init \
    -u https://source.codeaurora.org/external/imx/imx-manifest \
    -b imx-linux-sumo -m imx-4.14.78-1.0.0_ga.xml && \
repo sync -c -j8
