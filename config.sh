#!/bin/bash

# https://github.com/microsoft/WSL2-Linux-Kernel/tree/linux-msft-wsl-5.15.y
export KERNELVER="5.15.137.3"
export WSL2_Linux_Kernel_BRANCH="linux-msft-wsl-5.15.y"

# https://zfsonlinux.org/
export ZFSVER="2.2.2"

export KERNELNAME="standard-with-zfs"

export BUILD_DIR=$HOME # or $(pwd)
