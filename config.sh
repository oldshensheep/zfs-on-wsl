#!/bin/bash

export KERNELVER="6.1.24" # https://www.kernel.org/
export ZFSVER="2.1.10"       # https://zfsonlinux.org/

export KERNEL_SOURCE_URL="https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.1.24.tar.xz"
export WSL2_Linux_Kernel_BRANCH="linux-msft-wsl-6.1.21.1"

export KERNELNAME="standard-with-zfs"
export BUILD_DIR=$HOME # or $(pwd)
