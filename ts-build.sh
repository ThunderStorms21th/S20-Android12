#!/bin/bash
#
# Kernel Build Script v2.1 for ThunderStorms S20 series kernels
#
# XDA@nalas

# Setup
export PLATFORM_VERSION=11
export ANDROID_MAJOR_VERSION=r
export ARCH=arm64
export CROSS_COMPILE=$(pwd)/toolchain/gcc-cfp/gcc-cfp-jopp-only/aarch64-linux-android-4.9/bin/aarch64-linux-android-
export CLANG_TRIPLE=aarch64-linux-gnu-
export LINUX_GCC_CROSS_COMPILE_PREBUILTS_BIN=$(pwd)/toolchain/gcc-cfp/gcc-cfp-jopp-only/aarch64-linux-android-4.9/bin
## Clang 8.0.8
#export CLANG_PREBUILT_BIN=$(pwd)/toolchain/clang/host/linux-x86/clang-r349610-jopp/bin/clang
#export CC=$(pwd)/toolchain/clang/host/linux-x86/clang-r349610-jopp/bin/clang
## Clang 14.0.0
export CLANG_PREBUILT_BIN=$(pwd)/toolchain/clang-14/host/linux-x86/clang-r437112b/bin/clang
export CC=$(pwd)/toolchain/clang-14/host/linux-x86/clang-r437112b/bin/clang
#export CLANG_PREBUILT_BIN=$(pwd)/toolchain/clang-12/host/linux-x86/clang-r416183c/bin
#export CC=$(pwd)/toolchain/clang-12/host/linux-x86/clang-r416183c/bin
#export CLANG_PREBUILT_BIN=$(pwd)/toolchain/clang-11/host/linux-x86/clang-r399163b/bin
#export CC=$(pwd)/toolchain/clang-11/host/linux-x86/clang-r399163b/bin/clang
#export CLANG_PREBUILT_BIN=$(pwd)/toolchain/clang/host/linux-x86/clang-r349610-jopp/bin
#export CC=$(pwd)/toolchain/clang/host/linux-x86/clang-r349610-jopp/bin/clang
#export CLANG_PREBUILT_BIN=$(pwd)/toolchain/clang-9/bin
#export CC=$(pwd)/toolchain/clang-9/bin
#export CLANG_PREBUILT_BIN=$(pwd)/toolchain/clang-13/bin
#export CC=$(pwd)/toolchain/clang-13/bin
export PATH=$PATH:$LINUX_GCC_CROSS_COMPILE_PREBUILTS_BIN:$CLANG_PREBUILT_BIN:$CC
export LLVM=1

export K_VERSION="v2.0.1"
export K_NAME="ThundeRStormS-Kernel-S20N20"
export K_BASE="CLUE7"
ANDROID=OneUI-R
MODEL=G98XX-N986B-N985F
# -----------------------------

# Paths
OUTDIR=$(pwd)/arch/arm64/boot
DTBDIR=$OUTDIR/dtb
DTB_DIR=$(pwd)/arch/arm64/boot/dts
DTCTOOL=$(pwd)/scripts/dtc/dtc
INCDIR=$(pwd)/include
PAGE_SIZE=2048
DTB_PADDING=0
LOG=compile_build.log
# -----------------------------

# Kernel name
# KERNEL_NAME="LOCALVERSION=-ThunderStormS-v1.0-DUF9-OneUI3"
DEFCONFIG1=exynos9830-z3sxxx_defconfig
DEFCONFIG2=exynos9830-x1slte_defconfig
DEFCONFIG3=exynos9830-y2slte_defconfig
DEFCONFIG4=exynos9830-x1sxxx_defconfig
DEFCONFIG5=exynos9830-y2sxxx_defconfig
DEFCONFIG6=exynos9830-c2sxxx_defconfig
DEFCONFIG7=exynos9830-c2slte_defconfig
DEFCONFIG_TS=ts_defconfig
DEFCONFIG_ED=ed_defconfig
ZIP_DATE=`date +%Y%m%d`
ZIP_NAME=$K_NAME-$MODEL-$ANDROID-$K_VERSION-CLANG1401-$ZIP_DATE.zip
# -----------------------------

# FUNCTIONS
# ---------
DELETE_PLACEHOLDERS()
{
	find . -name \.placeholder -type f -delete
        echo "Placeholders Deleted from Ramdisk"
        echo ""
}

CLEAN_DTB()
{
	if ! [ -d $(pwd)/arch/arm64/boot/dts ] ; then
		echo "no directory : "$(pwd)/arch/arm64/boot/dts""
	else
		echo "rm files in : "$(pwd)/arch/arm64/boot/dts/*.dtb""
		rm $(pwd)/arch/arm64/boot/dts/exynos/*.dtb
		rm $(pwd)/arch/arm64/boot/dts/exynos/*.dtb_dtout
		rm $(pwd)/arch/arm64/boot/dts/exynos/*.dtb.dtout
		rm $(pwd)/arch/arm64/boot/dts/exynos/*.dtb.reverse.dts
		rm $(pwd)/arch/arm64/boot/dts/samsung/*.dtb
		rm $(pwd)/arch/arm64/boot/dts/samsung/*.dtb_dtout
		rm $(pwd)/arch/arm64/boot/dts/samsung/*.dtb.dtout
		rm $(pwd)/arch/arm64/boot/dts/samsung/*.dtb.reverse.dts
		rm $(pwd)/arch/arm64/boot/boot.img-dtb
		rm $(pwd)/arch/arm64/boot/boot.img-kernel
		rm $(pwd)/arch/arm64/configs/tmp_defconfig
	fi
}

BUILD_KERNEL_988B()
{
    # Make .config
	cp -f $(pwd)/arch/arm64/configs/$DEFCONFIG1 $(pwd)/arch/arm64/configs/tmp_defconfig
	cat $(pwd)/arch/arm64/configs/$DEFCONFIG_TS >> $(pwd)/arch/arm64/configs/tmp_defconfig

    # Compile kernels
    echo "***** Compiling kernel *****"
    [ ! -d "out" ] && mkdir out
    [ ! -d "out/SM-G988B" ] && mkdir out/SM-G988B
    # SM-G988B
    make -j$(nproc) -C $(pwd) $KERNEL_NAME tmp_defconfig
    make -j$(nproc) -C $(pwd) $KERNEL_NAME
    [ -e arch/arm64/boot/Image.gz ] && cp arch/arm64/boot/Image.gz $(pwd)/out/SM-G988B/Image.gz
    if [ -e arch/arm64/boot/Image ]; then
      cp arch/arm64/boot/Image $(pwd)/out/SM-G988B/Image
      # DTB for Exynos 9830 - SM-G988B
      echo "***** Compiling Device Tree Blobs *****"
      $(pwd)/tools/mkdtimg cfg_create $(pwd)/out/SM-G988B/dtb.img dt.configs/exynos9830.cfg -d ${DTB_DIR}/exynos
      $(pwd)/tools/mkdtimg cfg_create $(pwd)/out/SM-G988B/dtbo.img dt.configs/z3sxxx.cfg -d ${DTB_DIR}/samsung
    else
      echo "return to Main menu' 'Kernel STUCK in BUILD!"
    fi
}

BUILD_KERNEL_980F()
{
    # Make .config
	cp -f $(pwd)/arch/arm64/configs/$DEFCONFIG2 $(pwd)/arch/arm64/configs/tmp_defconfig
	cat $(pwd)/arch/arm64/configs/$DEFCONFIG_TS >> $(pwd)/arch/arm64/configs/tmp_defconfig
    # Compile kernels
    echo "***** Compiling kernel *****"
    [ ! -d "out" ] && mkdir out
    [ ! -d "out/SM-G980F" ] && mkdir out/SM-G980F
    # SM-G980F
    make -j$(nproc) -C $(pwd) $KERNEL_NAME tmp_defconfig
    make -j$(nproc) -C $(pwd) $KERNEL_NAME
    [ -e arch/arm64/boot/Image.gz ] && cp arch/arm64/boot/Image.gz $(pwd)/out/SM-G980F/Image.gz
    if [ -e arch/arm64/boot/Image ]; then
      cp arch/arm64/boot/Image $(pwd)/out/SM-G980F/Image
      # DTB for Exynos 9830 - SM-G980F
      echo "***** Compiling Device Tree Blobs *****"
      $(pwd)/tools/mkdtimg cfg_create $(pwd)/out/SM-G980F/dtb.img dt.configs/exynos9830.cfg -d ${DTB_DIR}/exynos
      $(pwd)/tools/mkdtimg cfg_create $(pwd)/out/SM-G980F/dtbo.img dt.configs/x1slte.cfg -d ${DTB_DIR}/samsung
    else
      echo "return to Main menu' 'Kernel STUCK in BUILD!"
    fi
}

BUILD_KERNEL_985F()
{
    # Make .config
	cp -f $(pwd)/arch/arm64/configs/$DEFCONFIG3 $(pwd)/arch/arm64/configs/tmp_defconfig
	cat $(pwd)/arch/arm64/configs/$DEFCONFIG_TS >> $(pwd)/arch/arm64/configs/tmp_defconfig
    # Compile kernels
    echo "***** Compiling kernel *****"
    [ ! -d "out" ] && mkdir out
    [ ! -d "out/SM-G985F" ] && mkdir out/SM-G985F
    # SM-G985F
    make -j$(nproc) -C $(pwd) $KERNEL_NAME tmp_defconfig
    make -j$(nproc) -C $(pwd) $KERNEL_NAME
    [ -e arch/arm64/boot/Image.gz ] && cp arch/arm64/boot/Image.gz $(pwd)/out/SM-G985F/Image.gz
    if [ -e arch/arm64/boot/Image ]; then
      cp arch/arm64/boot/Image $(pwd)/out/SM-G985F/Image
      # DTB for Exynos 9830 - SM-G985F
      echo "***** Compiling Device Tree Blobs *****"
      $(pwd)/tools/mkdtimg cfg_create $(pwd)/out/SM-G985F/dtb.img dt.configs/exynos9830.cfg -d ${DTB_DIR}/exynos
      $(pwd)/tools/mkdtimg cfg_create $(pwd)/out/SM-G985F/dtbo.img dt.configs/y2slte.cfg -d ${DTB_DIR}/samsung
    else
      echo "return to Main menu' 'Kernel STUCK in BUILD!"
    fi
}

BUILD_KERNEL_981B()
{
    # Make .config
	cp -f $(pwd)/arch/arm64/configs/$DEFCONFIG4 $(pwd)/arch/arm64/configs/tmp_defconfig
	cat $(pwd)/arch/arm64/configs/$DEFCONFIG_TS >> $(pwd)/arch/arm64/configs/tmp_defconfig
    # Compile kernels
    echo "***** Compiling kernel *****"
    [ ! -d "out" ] && mkdir out
    [ ! -d "out/SM-G981B" ] && mkdir out/SM-G981B
    # SM-G91BF
    make -j$(nproc) -C $(pwd) $KERNEL_NAME tmp_defconfig
    make -j$(nproc) -C $(pwd) $KERNEL_NAME
    [ -e arch/arm64/boot/Image.gz ] && cp arch/arm64/boot/Image.gz $(pwd)/out/SM-G981B/Image.gz
    if [ -e arch/arm64/boot/Image ]; then
      cp arch/arm64/boot/Image $(pwd)/out/SM-G981B/Image
      # DTB for Exynos 9830 - SM-G981B
      echo "***** Compiling Device Tree Blobs *****"
      $(pwd)/tools/mkdtimg cfg_create $(pwd)/out/SM-G981B/dtb.img dt.configs/exynos9830.cfg -d ${DTB_DIR}/exynos
      $(pwd)/tools/mkdtimg cfg_create $(pwd)/out/SM-G981B/dtbo.img dt.configs/x1sxxx.cfg -d ${DTB_DIR}/samsung
    else
      echo "return to Main menu' 'Kernel STUCK in BUILD!"
    fi
}

BUILD_KERNEL_986B()
{
    # Make .config
	cp -f $(pwd)/arch/arm64/configs/$DEFCONFIG5 $(pwd)/arch/arm64/configs/tmp_defconfig
	cat $(pwd)/arch/arm64/configs/$DEFCONFIG_TS >> $(pwd)/arch/arm64/configs/tmp_defconfig
    # Compile kernels
    echo "***** Compiling kernel *****"
    [ ! -d "out" ] && mkdir out
    [ ! -d "out/SM-G986B" ] && mkdir out/SM-G986B
    # SM-G91BF
    make -j$(nproc) -C $(pwd) $KERNEL_NAME tmp_defconfig
    make -j$(nproc) -C $(pwd) $KERNEL_NAME
    [ -e arch/arm64/boot/Image.gz ] && cp arch/arm64/boot/Image.gz $(pwd)/out/SM-G986B/Image.gz
    if [ -e arch/arm64/boot/Image ]; then
      cp arch/arm64/boot/Image $(pwd)/out/SM-G986B/Image
      # DTB for Exynos 9830 - SM-G986B
      echo "***** Compiling Device Tree Blobs *****"
      $(pwd)/tools/mkdtimg cfg_create $(pwd)/out/SM-G986B/dtb.img dt.configs/exynos9830.cfg -d ${DTB_DIR}/exynos
      $(pwd)/tools/mkdtimg cfg_create $(pwd)/out/SM-G986B/dtbo.img dt.configs/y2sxxx.cfg -d ${DTB_DIR}/samsung
    else
      echo "return to Main menu' 'Kernel STUCK in BUILD!"
    fi
}

BUILD_KERNEL_N986B()
{
    # Make .config
	cp -f $(pwd)/arch/arm64/configs/$DEFCONFIG6 $(pwd)/arch/arm64/configs/tmp_defconfig
	cat $(pwd)/arch/arm64/configs/$DEFCONFIG_TS >> $(pwd)/arch/arm64/configs/tmp_defconfig

    # Compile kernels
    echo "***** Compiling kernel *****"
    [ ! -d "out" ] && mkdir out
    [ ! -d "out/SM-N986B" ] && mkdir out/SM-N986B
    # SM-N986B
    make -j$(nproc) -C $(pwd) $KERNEL_NAME tmp_defconfig
    make -j$(nproc) -C $(pwd) $KERNEL_NAME
    [ -e arch/arm64/boot/Image.gz ] && cp arch/arm64/boot/Image.gz $(pwd)/out/SM-N986B/Image.gz
    if [ -e arch/arm64/boot/Image ]; then
      cp arch/arm64/boot/Image $(pwd)/out/SM-N986B/Image
      # DTB for Exynos 9830 - SM-N986B
      echo "***** Compiling Device Tree Blobs *****"
      $(pwd)/tools/mkdtimg cfg_create $(pwd)/out/SM-N986B/dtb.img dt.configs/exynos9830.cfg -d ${DTB_DIR}/exynos
      $(pwd)/tools/mkdtimg cfg_create $(pwd)/out/SM-N986B/dtbo.img dt.configs/c2sxxx.cfg -d ${DTB_DIR}/samsung
    else
      echo "return to Main menu' 'Kernel STUCK in BUILD!"
    fi
}

BUILD_KERNEL_N985F()
{
    # Make .config
	cp -f $(pwd)/arch/arm64/configs/$DEFCONFIG7 $(pwd)/arch/arm64/configs/tmp_defconfig
	cat $(pwd)/arch/arm64/configs/$DEFCONFIG_TS >> $(pwd)/arch/arm64/configs/tmp_defconfig

    # Compile kernels
    echo "***** Compiling kernel *****"
    [ ! -d "out" ] && mkdir out
    [ ! -d "out/SM-N985F" ] && mkdir out/SM-N985F
    # SM-N985F
    make -j$(nproc) -C $(pwd) $KERNEL_NAME tmp_defconfig
    make -j$(nproc) -C $(pwd) $KERNEL_NAME
    [ -e arch/arm64/boot/Image.gz ] && cp arch/arm64/boot/Image.gz $(pwd)/out/SM-N985F/Image.gz
    if [ -e arch/arm64/boot/Image ]; then
      cp arch/arm64/boot/Image $(pwd)/out/SM-N985F/Image
      # DTB for Exynos 9830 - SM-N985F
      echo "***** Compiling Device Tree Blobs *****"
      $(pwd)/tools/mkdtimg cfg_create $(pwd)/out/SM-N985F/dtb.img dt.configs/exynos9830.cfg -d ${DTB_DIR}/exynos
      $(pwd)/tools/mkdtimg cfg_create $(pwd)/out/SM-N985F/dtbo.img dt.configs/c2slte.cfg -d ${DTB_DIR}/samsung
    else
      echo "return to Main menu' 'Kernel STUCK in BUILD!"
    fi
}

BUILD_DTB()
{
    # Compile DTB/DTBO images
    echo "***** Compiling Device Tree Blobs *****"
    # DTB for all Exynos 9830 devices
    $(pwd)/tools/mkdtimg cfg_create $(pwd)/out/SM-G988B/dtb.img dt.configs/exynos9830.cfg -d ${DTB_DIR}/exynos
    $(pwd)/tools/mkdtimg cfg_create $(pwd)/out/SM-G980F/dtb.img dt.configs/exynos9830.cfg -d ${DTB_DIR}/exynos
    $(pwd)/tools/mkdtimg cfg_create $(pwd)/out/SM-G985F/dtb.img dt.configs/exynos9830.cfg -d ${DTB_DIR}/exynos
    $(pwd)/tools/mkdtimg cfg_create $(pwd)/out/SM-G981B/dtb.img dt.configs/exynos9830.cfg -d ${DTB_DIR}/exynos
    $(pwd)/tools/mkdtimg cfg_create $(pwd)/out/SM-G986B/dtb.img dt.configs/exynos9830.cfg -d ${DTB_DIR}/exynos
    $(pwd)/tools/mkdtimg cfg_create $(pwd)/out/SM-N986B/dtb.img dt.configs/exynos9830.cfg -d ${DTB_DIR}/exynos
    # DTBO for Exynos 9830 SM-G988B
    $(pwd)/tools/mkdtimg cfg_create $(pwd)/out/SM-G988B/dtbo.img dt.configs/z3sxxx.cfg -d ${DTB_DIR}/samsung
    # DTBO for Exynos 9830 SM-G980F
    $(pwd)/tools/mkdtimg cfg_create $(pwd)/out/SM-G980F/dtbo.img dt.configs/x1slte.cfg -d ${DTB_DIR}/samsung
    # DTBO for Exynos 9830 SM-G985F
    $(pwd)/tools/mkdtimg cfg_create $(pwd)/out/SM-G985F/dtbo.img dt.configs/y2slte.cfg -d ${DTB_DIR}/samsung
    # DTBO for Exynos 9830 SM-G981B
    $(pwd)/tools/mkdtimg cfg_create $(pwd)/out/SM-G981B/dtbo.img dt.configs/x1sxxx.cfg -d ${DTB_DIR}/samsung
    # DTBO for Exynos 9830 SM-G986B
    $(pwd)/tools/mkdtimg cfg_create $(pwd)/out/SM-G986B/dtbo.img dt.configs/y2sxxx.cfg -d ${DTB_DIR}/samsung
    # DTBO for Exynos 9830 SM-N986B
    $(pwd)/tools/mkdtimg cfg_create $(pwd)/out/SM-N986B/dtbo.img dt.configs/c2sxxx.cfg -d ${DTB_DIR}/samsung
    # DTBO for Exynos 9830 SM-N885F
    $(pwd)/tools/mkdtimg cfg_create $(pwd)/out/SM-N986B/dtbo.img dt.configs/c2slte.cfg -d ${DTB_DIR}/samsung
}

BUILD_RAMDISK_988B()
{
    # Build Ramdisk and boot.img
    # SM-G988B
    echo ""
    echo "Building Ramdisk for SM-G988B"
    mv $(pwd)/out/SM-G988B/Image $(pwd)/out/SM-G988B/boot.img-kernel
    mv $(pwd)/out/SM-G988B/dtb.img $(pwd)/out/SM-G988B/boot.img-dtb
    mkdir $(pwd)/builds/temp
    cp -rf $(pwd)/builds/aik/. $(pwd)/builds/temp
    cp -rf $(pwd)/builds/ramdisk/. $(pwd)/builds/temp
    rm -f $(pwd)/builds/temp/split_img/boot.img-kernel
    rm -f $(pwd)/builds/temp/split_img/boot.img-dtb
    mv $(pwd)/out/SM-G988B/boot.img-kernel $(pwd)/builds/temp/split_img/boot.img-kernel
    mv $(pwd)/out/SM-G988B/boot.img-dtb $(pwd)/builds/temp/split_img/boot.img-dtb
    echo "Done"
    cd $(pwd)/builds/temp
    ./repackimg.sh
    echo SEANDROIDENFORCE >> image-new.img
    cd ..
    cd ..
    mv $(pwd)/builds/temp/image-new.img $(pwd)/builds/SMG988B-boot.img
    rm -rf $(pwd)/builds/temp
}

BUILD_RAMDISK_980F()
{
    # SM-G980F
    echo ""
    echo "Building Ramdisk for SM-G980F"
    mv $(pwd)/out/SM-G980F/Image $(pwd)/out/SM-G980F/boot.img-kernel
    mv $(pwd)/out/SM-G980F/dtb.img $(pwd)/out/SM-G980F/boot.img-dtb
    mkdir $(pwd)/builds/temp
    cp -rf $(pwd)/builds/aik/. $(pwd)/builds/temp
    cp -rf $(pwd)/builds/ramdisk/. $(pwd)/builds/temp
    rm -f $(pwd)/builds/temp/split_img/boot.img-kernel
    rm -f $(pwd)/builds/temp/split_img/boot.img-dtb
    mv $(pwd)/out/SM-G980F/boot.img-kernel $(pwd)/builds/temp/split_img/boot.img-kernel
    mv $(pwd)/out/SM-G980F/boot.img-dtb $(pwd)/builds/temp/split_img/boot.img-dtb
    echo "Done"
    cd $(pwd)/builds/temp
    ./repackimg.sh
    echo SEANDROIDENFORCE >> image-new.img
    cd ..
    cd ..
    mv $(pwd)/builds/temp/image-new.img $(pwd)/builds/SMG980F-boot.img
    rm -rf $(pwd)/builds/temp
}

BUILD_RAMDISK_985F()
{
    # SM-G985F
    echo ""
    echo "Building Ramdisk for SM-G985F"
    mv $(pwd)/out/SM-G985F/Image $(pwd)/out/SM-G985F/boot.img-kernel
    mv $(pwd)/out/SM-G985F/dtb.img $(pwd)/out/SM-G985F/boot.img-dtb
    mkdir $(pwd)/builds/temp
    cp -rf $(pwd)/builds/aik/. $(pwd)/builds/temp
    cp -rf $(pwd)/builds/ramdisk/. $(pwd)/builds/temp
    rm -f $(pwd)/builds/temp/split_img/boot.img-kernel
    rm -f $(pwd)/builds/temp/split_img/boot.img-dtb
    mv $(pwd)/out/SM-G985F/boot.img-kernel $(pwd)/builds/temp/split_img/boot.img-kernel
    mv $(pwd)/out/SM-G985F/boot.img-dtb $(pwd)/builds/temp/split_img/boot.img-dtb
    echo "Done"
    cd $(pwd)/builds/temp
    ./repackimg.sh
    echo SEANDROIDENFORCE >> image-new.img
    cd ..
    cd ..
    mv $(pwd)/builds/temp/image-new.img $(pwd)/builds/SMG985F-boot.img
    rm -rf $(pwd)/builds/temp
}

BUILD_RAMDISK_981B()
{
    # SM-G981B
    echo ""
    echo "Building Ramdisk for SM-G981B"
    mv $(pwd)/out/SM-G981B/Image $(pwd)/out/SM-G981B/boot.img-kernel
    mv $(pwd)/out/SM-G981B/dtb.img $(pwd)/out/SM-G981B/boot.img-dtb
    mkdir $(pwd)/builds/temp
    cp -rf $(pwd)/builds/aik/. $(pwd)/builds/temp
    cp -rf $(pwd)/builds/ramdisk/. $(pwd)/builds/temp
    rm -f $(pwd)/builds/temp/split_img/boot.img-kernel
    rm -f $(pwd)/builds/temp/split_img/boot.img-dtb
    mv $(pwd)/out/SM-G981B/boot.img-kernel $(pwd)/builds/temp/split_img/boot.img-kernel
    mv $(pwd)/out/SM-G981B/boot.img-dtb $(pwd)/builds/temp/split_img/boot.img-dtb
    echo "Done"
    cd $(pwd)/builds/temp
    ./repackimg.sh
    echo SEANDROIDENFORCE >> image-new.img
    cd ..
    cd ..
    mv $(pwd)/builds/temp/image-new.img $(pwd)/builds/SMG981B-boot.img
    rm -rf $(pwd)/builds/temp
}

BUILD_RAMDISK_986B()
{
    # SM-G986B
    echo ""
    echo "Building Ramdisk for SM-G986B"
    mv $(pwd)/out/SM-G986B/Image $(pwd)/out/SM-G986B/boot.img-kernel
    mv $(pwd)/out/SM-G986B/dtb.img $(pwd)/out/SM-G986B/boot.img-dtb
    mkdir $(pwd)/builds/temp
    cp -rf $(pwd)/builds/aik/. $(pwd)/builds/temp
    cp -rf $(pwd)/builds/ramdisk/. $(pwd)/builds/temp
    rm -f $(pwd)/builds/temp/split_img/boot.img-kernel
    rm -f $(pwd)/builds/temp/split_img/boot.img-dtb
    mv $(pwd)/out/SM-G986B/boot.img-kernel $(pwd)/builds/temp/split_img/boot.img-kernel
    mv $(pwd)/out/SM-G986B/boot.img-dtb $(pwd)/builds/temp/split_img/boot.img-dtb
    echo "Done"
    cd $(pwd)/builds/temp
    ./repackimg.sh
    echo SEANDROIDENFORCE >> image-new.img
    cd ..
    cd ..
    mv $(pwd)/builds/temp/image-new.img $(pwd)/builds/SMG986B-boot.img
    rm -rf $(pwd)/builds/temp
}

BUILD_RAMDISK_N986B()
{
    # Build Ramdisk and boot.img
    # SM-N986B
    echo ""
    echo "Building Ramdisk for SM-N986B"
    mv $(pwd)/out/SM-N986B/Image $(pwd)/out/SM-N986B/boot.img-kernel
    mv $(pwd)/out/SM-N986B/dtb.img $(pwd)/out/SM-N986B/boot.img-dtb
    mkdir $(pwd)/builds/temp
    cp -rf $(pwd)/builds/aik/. $(pwd)/builds/temp
    cp -rf $(pwd)/builds/ramdisk/. $(pwd)/builds/temp
    rm -f $(pwd)/builds/temp/split_img/boot.img-kernel
    rm -f $(pwd)/builds/temp/split_img/boot.img-dtb
    mv $(pwd)/out/SM-N986B/boot.img-kernel $(pwd)/builds/temp/split_img/boot.img-kernel
    mv $(pwd)/out/SM-N986B/boot.img-dtb $(pwd)/builds/temp/split_img/boot.img-dtb
    echo "Done"
    cd $(pwd)/builds/temp
    ./repackimg.sh
    echo SEANDROIDENFORCE >> image-new.img
    cd ..
    cd ..
    mv $(pwd)/builds/temp/image-new.img $(pwd)/builds/SMN986B-boot.img
    rm -rf $(pwd)/builds/temp
}

BUILD_RAMDISK_N985F()
{
    # Build Ramdisk and boot.img
    # SM-N985F
    echo ""
    echo "Building Ramdisk for SM-N985F"
    mv $(pwd)/out/SM-N985F/Image $(pwd)/out/SM-N985F/boot.img-kernel
    mv $(pwd)/out/SM-N985F/dtb.img $(pwd)/out/SM-N985F/boot.img-dtb
    mkdir $(pwd)/builds/temp
    cp -rf $(pwd)/builds/aik/. $(pwd)/builds/temp
    cp -rf $(pwd)/builds/ramdisk/. $(pwd)/builds/temp
    rm -f $(pwd)/builds/temp/split_img/boot.img-kernel
    rm -f $(pwd)/builds/temp/split_img/boot.img-dtb
    mv $(pwd)/out/SM-N985F/boot.img-kernel $(pwd)/builds/temp/split_img/boot.img-kernel
    mv $(pwd)/out/SM-N985F/boot.img-dtb $(pwd)/builds/temp/split_img/boot.img-dtb
    echo "Done"
    cd $(pwd)/builds/temp
    ./repackimg.sh
    echo SEANDROIDENFORCE >> image-new.img
    cd ..
    cd ..
    mv $(pwd)/builds/temp/image-new.img $(pwd)/builds/SMN985F-boot.img
    rm -rf $(pwd)/builds/temp
}


BUILD_FLASHABLES()
{
	cd $(pwd)/builds
	mkdir temp2
	cp -rf zip-OneUIR/common/. temp2
    cp -rf *.img temp2/
	cd temp2
	echo ""
	echo "Compressing kernels..."
	tar cv *.img | xz -9 > kernel.tar.xz
	echo "Copying kernels to ts folder..."
	mv kernel.tar.xz ts/
    rm -rf *.img	
	zip -9 -r ../$ZIP_NAME *

	cd ..
    rm -rf temp2
}

BUILD_FLASHABLES_TS()
{
	cd $(pwd)/builds
	mkdir temp2
	cp -rf ThunderStormS_Kernel_Installer/. temp2
    cp -rf SMG980F-boot.img temp2/thunderstorm/g980
    cp -rf SMG985F-boot.img temp2/thunderstorm/g985
    cp -rf SMG981B-boot.img temp2/thunderstorm/g981
    cp -rf SMG986B-boot.img temp2/thunderstorm/g986
    cp -rf SMG988B-boot.img temp2/thunderstorm/g988
    cp -rf SMN986B-boot.img temp2/thunderstorm/n986
    cp -rf SMN985F-boot.img temp2/thunderstorm/n985

	cd temp2
	echo ""
	#echo "Compressing kernels..."
	#tar cv *.img | xz -9 > kernel.tar.xz
	#echo "Copying kernels to ts folder..."
	#mv kernel.tar.xz ts/
    #rm -rf *.img	
	zip -9 -r ../$ZIP_NAME *

	cd ..
    rm -rf temp2
}

MAIN()
{

(
    echo ""
    # -----------------------------
    START_TIME=`date +%T`
	START_TIME_SEC=`date +%s`
        BUILD_KERNEL_988B
        BUILD_RAMDISK_988B
        BUILD_KERNEL_981B
        BUILD_RAMDISK_981B
        BUILD_KERNEL_986B
        BUILD_RAMDISK_986B
        BUILD_KERNEL_980F
        BUILD_RAMDISK_980F
        BUILD_KERNEL_985F
        BUILD_RAMDISK_985F
        BUILD_KERNEL_N986B
        BUILD_RAMDISK_N986B
        BUILD_KERNEL_N985F
        BUILD_RAMDISK_N985F
		rm $(pwd)/arch/arm64/configs/tmp_defconfig

        # BUILD_DTB
        # BUILD_FLASHABLES
        BUILD_FLASHABLES_TS
    END_TIME=`date +%T`
    END_TIME_SEC=`date +%s`
    # -----------------------------

    # Add making date and hrs to logs
    echo ""
    echo "Start compile time is $START_TIME."
    echo "End compile time is $END_TIME."
	let "ELAPSED_TIME=$END_TIME_SEC - $START_TIME_SEC"
	echo "Total compile time is $ELAPSED_TIME seconds."
    echo ""
) 2>&1 | tee -a ./$LOG

	echo "Your flasheable release can be found in the build folder"
	echo ""
}

# PROGRAM START
# -------------
clear
echo "*****************************************"
echo "*   ThunderStorms Kernel Build Script   *"
echo "*****************************************"
echo ""
echo "    CUSTOMIZABLE STOCK SAMSUNG KERNEL"
echo ""
echo "       Build Kernel for: S20/N20"
echo ""
echo ""
echo "    -- Start compiling the kernel. --"
echo ""
echo ""

DELETE_PLACEHOLDERS
CLEAN_DTB
MAIN
