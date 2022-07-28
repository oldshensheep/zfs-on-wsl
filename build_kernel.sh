#!/bin/bash
set -xe

sudo apt update
sudo apt upgrade -y
sudo apt install -y dwarves build-essential autoconf automake libtool gawk alien fakeroot dkms libblkid-dev uuid-dev libudev-dev libssl-dev zlib1g-dev libaio-dev libattr1-dev libelf-dev linux-headers-generic python3 python3-dev python3-setuptools python3-cffi libffi-dev python3-packaging git libcurl4-openssl-dev

rm -rf ${BUILD_DIR}/kbuild
mkdir ${BUILD_DIR}/kbuild


wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-${KERNELVER}.tar.xz -O ${BUILD_DIR}/kbuild/kernel.tar.xz
tar -xf ${BUILD_DIR}/kbuild/kernel.tar.xz -C ${BUILD_DIR}/kbuild

# Using Microsoft config-wsl
wget https://raw.githubusercontent.com/microsoft/WSL2-Linux-Kernel/linux-msft-wsl-5.10.y/Microsoft/config-wsl -O ${BUILD_DIR}/kbuild/linux-${KERNELVER}/.config
# Change the kernel name
sed -i 's/^CONFIG_LOCALVERSION=.*/CONFIG_LOCALVERSION="-${KERNELNAME}"/g' ${BUILD_DIR}/kbuild/linux-${KERNELVER}/.config

cd ${BUILD_DIR}/kbuild/linux-${KERNELVER}
make olddefconfig
make prepare

wget https://github.com/openzfs/zfs/releases/download/zfs-${ZFSVER}/zfs-${ZFSVER}.tar.gz -O ${BUILD_DIR}/kbuild/zfs.tar.gz
tar -xf ${BUILD_DIR}/kbuild/zfs.tar.gz -C ${BUILD_DIR}/kbuild
cd ${BUILD_DIR}/kbuild/zfs-${ZFSVER}

./autogen.sh
./configure --enable-linux-builtin=yes --with-linux=${BUILD_DIR}/kbuild/linux-${KERNELVER} --with-linux-obj=${BUILD_DIR}/kbuild/linux-${KERNELVER}
./copy-builtin ${BUILD_DIR}/kbuild/linux-${KERNELVER}

# Build ZFS!
make -s -j$(nproc)

cd ${BUILD_DIR}/kbuild/linux-${KERNELVER}

# Enable ZFS support 
sed -i '/.*CONFIG_ZFS.*/d' ${BUILD_DIR}/kbuild/linux-${KERNELVER}/.config
echo "CONFIG_ZFS=y" >> ${BUILD_DIR}/kbuild/linux-${KERNELVER}/.config

# Build kernel!
make -j$(nproc)

cp -fv ${BUILD_DIR}/kbuild/linux-${KERNELVER}/arch/x86/boot/bzImage ${BUILD_DIR}
mv ${BUILD_DIR}/bzImage ${BUILD_DIR}/bzImage-kernel${KERNELVER}-zfs${ZFSVER}
