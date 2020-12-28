#!/bin/bash

export ARCH=arm64
export CROSS_COMPILE=/home/neel/Desktop/toolchain/linaro/bin/aarch64-linux-gnu-
export ANDROID_MAJOR_VERSION=q
export PLATFORM_VERSION=10.0.0
export USE_CCACHE=1
rm ./arch/arm64/boot/Image
rm ./arch/arm64/boot/Image.gz
rm ./arch/arm64/boot/dts/*.dtb
make clean && make mrproper	

echo "============="
echo "Building DTB"
echo "============="
DTS=arch/arm64/boot/dts
chmod a+x ./tools/dtbtool 
make exynos7870-j7velte_sea_open_00.dtb exynos7870-j7velte_sea_open_01.dtb exynos7870-j7velte_sea_open_03.dtb
./tools/dtbtool $DTS/ -o ./dtb
echo "============="
echo "Building Zimg"
echo "============="
#make j6lte_defconfig
make j7velte_defconfig
make -j3
echo "Done"
echo ""
cp -r ./arch/arm64/boot/Image ./boot.img-zImage