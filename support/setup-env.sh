export PATH="/opt/rg35xx-toolchain/usr/bin:${PATH}:/opt/rg35xx-toolchain/usr/arm-buildroot-linux-gnueabihf/sysroot/bin"
export CROSS_COMPILE=/opt/rg35xx-toolchain/usr/bin/arm-buildroot-linux-gnueabihf-
export PREFIX=/opt/rg35xx-toolchain/usr/arm-buildroot-linux-gnueabihf/sysroot/usr
export UNION_PLATFORM=rg35xx
export CC=${CROSS_COMPILE}gcc
export AR=${CROSS_COMPILE}ar
export AS=${CROSS_COMPILE}as
export LD=${CROSS_COMPILE}ld
export CXX=${CROSS_COMPILE}g++
export HOST=arm-buildroot-linux-gnueabihf
export LD_LIBRARY_PATH="/opt/rg35xx-toolchain/usr/lib/:${LD_LIBRARY_PATH}"
