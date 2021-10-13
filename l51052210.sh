#!/bin/sh

mkdir yocto && cd yocto && \
repo init \
    -u https://source.codeaurora.org/external/imx/imx-manifest \
    -b imx-linux-hardknott -m imx-5.10.52-2.1.0.xml && \
repo sync -c -j8
