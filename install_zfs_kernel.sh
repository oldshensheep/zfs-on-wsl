#!/bin/bash

source ./config.sh

mkdir -p ${WINDOWS_PATH}
mv ${BUILD_DIR}/bzImage-kernel${KERNELVER}-zfs${ZFSVER} ${WINDOWS_PATH}

KPATH_WIN=$(wslpath -m ${WINDOWS_PATH})/bzImage-kernel${KERNELVER}-zfs${ZFSVER}

touch ${WSL_CONFIG_PATH}
python ./modify_wsl_config.py ${WSL_CONFIG_PATH} ${KPATH_WIN}
