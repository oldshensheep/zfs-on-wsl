#!/bin/bash

# https://github.com/microsoft/WSL2-Linux-Kernel/tree/linux-msft-wsl-5.15.y
export KERNELVER="5.15.150.1"
export WSL2_Linux_Kernel_BRANCH="linux-msft-wsl-5.15.y"

# https://zfsonlinux.org/
export ZFSVER="2.2.3"

export KERNELNAME="standard-with-zfs"

export BUILD_DIR=$(pwd) # or $(pwd)

export WINDOWS_PATH="/mnt/c/.wsl-kernel-with-zfs"

export WSL_CONFIG_PATH="/mnt/c/Users/${username}/.wslconfig"
