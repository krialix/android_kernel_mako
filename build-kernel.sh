#!/bin/bash
# Copyright (C) 2014 Krialix
# Build Script. Use bash to run this script, bash build_kernel from source directory

# Kernel Version
THOR_VER="Thor_1.2"

# Thor Build ID
export LOCALVERSION="-"`echo $THOR_VER`
export KBUILD_BUILD_USER=krialix
export KBUILD_BUILD_HOST="Ubuntu"
export MANUFACTURER=lge;
export DEVICE=mako;

# Export Configs
export ARCH=arm
export SUBARCH=arm
export CROSS_COMPILE=../arm-cortex_a15-linux-gnueabihf-linaro_4.9.1-2014.05/bin/arm-cortex_a15-linux-gnueabihf-

# Folder Info
KERNEL_DIR=`pwd`
CONFIG_DIR=$KERNEL_DIR/arch/arm/configs
ZIMAGE_DIR=$KERNEL_DIR/arch/arm/boot
OUTPUT_DIR=${HOME}/Kernel/Output

# Copy Configs
cp -vr $CONFIG_DIR/mako_oc_config $KERNEL_DIR

# Rename Configs
mv mako_oc_config .config

# Start the build
echo "";
echo "Starting the kernel build";
echo "";

make -j8 zImage;

# Move zImage
mv -vif $ZIMAGE_DIR/zImage $OUTPUT_DIR/kernel/

# Clean
make clean && make mrproper
	
cd $OUTPUT_DIR
	
# Make zip
zip -r `echo $THOR_VER`.zip *
	
echo "Kernel build finished";
