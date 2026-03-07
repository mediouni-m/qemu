#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later

set -euo pipefail
set -x

echo "Install gdb"
apt update
apt install -y gdb-multiarch gdb

echo "Install cross compilers"
apt update
apt install -y \
gcc-aarch64-linux-gnu \
libc6-dev-arm64-cross \
gcc-arm-linux-gnueabihf \
libc6-dev-armhf-cross \
gcc-mips-linux-gnu \
libc6-dev-mips-cross \
gcc-mips64-linux-gnuabi64 \
libc6-dev-mips64-cross \
gcc-mips64el-linux-gnuabi64 \
libc6-dev-mips64el-cross \
gcc-mipsel-linux-gnu \
libc6-dev-mipsel-cross \
gcc-riscv64-linux-gnu \
libc6-dev-riscv64-cross \
gcc-s390x-linux-gnu \
libc6-dev-s390x-cross \
gcc-powerpc64le-linux-gnu \
libc6-dev-ppc64el-cross \

echo "Install additional cross compilers (not available on arm)"
apt update
apt install -y \
gcc-hppa-linux-gnu \
libc6-dev-hppa-cross \
gcc-m68k-linux-gnu \
libc6-dev-m68k-cross \
gcc-powerpc-linux-gnu \
libc6-dev-powerpc-cross \
gcc-powerpc64-linux-gnu \
libc6-dev-ppc64-cross \
gcc-sparc64-linux-gnu \
libc6-dev-sparc64-cross ||
true

echo "Precache tests data"
./configure
ninja -C build precache-functional -k 0 || true
ninja -C build precache-functional -j1 -k 0
