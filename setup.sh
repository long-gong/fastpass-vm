#!/bin/bash

# Install dependencies
sudo apt-get update --fix-missing
sudo apt-get install -y git build-essential wget hugepages libpcap-dev linux-headers-`uname -r`


# Download DPDK
cd /tmp
wget http://fast.dpdk.org/rel/dpdk-16.04.tar.xz 
tar xvf dpdk-16.04.tar.xz 


# Compile and Install DPDK
# source: http://core.dpdk.org/doc/quick-start/
pushd dpdk-16.04
make config T=x86_64-native-linuxapp-gcc
sed -ri 's,(PMD_PCAP=).*,\1y,' build/.config
make

# Install kernel modules
sudo modprobe uio
sudo insmod build/kmod/igb_uio.ko

# Configure
mkdir -p /mnt/huge
mount -t hugetlbfs nodev /mnt/huge
echo 64 > /sys/devices/system/node/node0/hugepages/hugepages-2048kB/nr_hugepages

# Test
make -C examples RTE_SDK=$(pwd) RTE_TARGET=build O=$(pwd)/build/examples

popd

export RTE_SDK=`pwd`/dpdk-16.04
export RTE_TARGET=build

# Clone fasspass
git clone https://github.com/yonch/fastpass.git
export FASTPASS_DIR=`pwd`/fastpass

# Install Dependencies Again

## Linux kernel
git clone git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
pushd linux-stable
git checkout v3.10.25
cp $FASTPASS_DIR/src/kernel-mod/kernel-config-3.10.25 .config
unset KBUILD_OUTPUT # build in the source directory
unset KDIR          # build in the source directory
make oldconfig
cp $FASTPASS_DIR/src/kernel-mod/pkt_sched.h include/uapi/linux/
echo "#include <linux/compiler-gcc4.h>" > include/linux/compiler-gcc5.h
make -j22
popd

export KBUILD_OUTPUT=`pwd`/linux-stable
export KDIR=$KBUILD_OUTPUT
## Install Dependencies 
sudo apt-get install -y flex bison iptables-dev libdb-dev

git clone http://github.com/yonch/iproute2-fastpass
pushd iproute2-fastpass
make -j22
popd


# Compile fasspass
cd $FASTPASS_DIR/src/arbiter
make








