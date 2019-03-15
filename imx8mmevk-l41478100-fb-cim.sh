#!/bin/bash
cat << __EOF
Below is output by yocto

MACHINE_NAME=imx8mmevk
DISTRO_NAME=fsl-imx-fb
IMAGE_NAME=core-image-minimal
BUILD_PATH=build

 Build directory is  build

 ERROR - Only Wayland distros are supported for i.MX 8 or i.MX 8M
__EOF
