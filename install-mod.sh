#!/bin/bash

source ./config.sh

# cd ${BUILD_DIR}/kbuild/linux-${KERNELVER}
# sudo make modules_install

cd ${BUILD_DIR}/kbuild/zfs-${ZFSVER}
sudo make install

