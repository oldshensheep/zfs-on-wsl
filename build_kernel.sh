#!/bin/bash
set -xe

source config.sh


rm -rf ${BUILD_DIR}/kbuild
mkdir ${BUILD_DIR}/kbuild

# download source of kernel

git clone --branch ${WSL2_Linux_Kernel_BRANCH}  --depth 1 --single-branch https://github.com/microsoft/WSL2-Linux-Kernel.git
mv WSL2-Linux-Kernel ${BUILD_DIR}/kbuild/

# Using Microsoft config-wsl
cp ${BUILD_DIR}/kbuild/WSL2-Linux-Kernel/Microsoft/config-wsl ${BUILD_DIR}/kbuild/WSL2-Linux-Kernel/.config

# Change the kernel name
sed -i 's/^CONFIG_LOCALVERSION=.*/CONFIG_LOCALVERSION="-${KERNELNAME}"/g' ${BUILD_DIR}/kbuild/WSL2-Linux-Kernel/.config

cd ${BUILD_DIR}/kbuild/WSL2-Linux-Kernel
make olddefconfig
make prepare

wget https://github.com/openzfs/zfs/releases/download/zfs-${ZFSVER}/zfs-${ZFSVER}.tar.gz -O ${BUILD_DIR}/kbuild/zfs.tar.gz
tar -xf ${BUILD_DIR}/kbuild/zfs.tar.gz -C ${BUILD_DIR}/kbuild
cd ${BUILD_DIR}/kbuild/zfs-${ZFSVER}

./autogen.sh
./configure --enable-linux-builtin=yes --with-linux=${BUILD_DIR}/kbuild/WSL2-Linux-Kernel --with-linux-obj=${BUILD_DIR}/kbuild/WSL2-Linux-Kernel
./copy-builtin ${BUILD_DIR}/kbuild/WSL2-Linux-Kernel

# Build ZFS!
make -s -j$(nproc)

cd ${BUILD_DIR}/kbuild/WSL2-Linux-Kernel

# Enable ZFS support 
sed -i '/.*CONFIG_ZFS.*/d' ${BUILD_DIR}/kbuild/WSL2-Linux-Kernel/.config
echo "CONFIG_ZFS=y" >> ${BUILD_DIR}/kbuild/WSL2-Linux-Kernel/.config

# Build kernel!
make -j$(nproc)

cp -fv ${BUILD_DIR}/kbuild/WSL2-Linux-Kernel/arch/x86/boot/bzImage ${BUILD_DIR}
mv ${BUILD_DIR}/bzImage ${BUILD_DIR}/bzImage-kernel${KERNELVER}-zfs${ZFSVER}
