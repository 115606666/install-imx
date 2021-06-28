#!/bin/sh

mkdir yocto && cd yocto && \
repo init \
    -u https://source.codeaurora.org/external/imx/imx-manifest \
    -b imx-linux-gatesgarth -m imx-5.10.9-1.0.0.xml && \
repo sync -c -j8
