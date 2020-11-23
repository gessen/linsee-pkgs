#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

pkgname=llvm-project
pkgver=11.0.0
source="https://github.com/llvm/${pkgname}/releases/download/llvmorg-${pkgver}/${pkgname}-${pkgver}.tar.xz"
do_strip=0

do_configure() {
  cd "${srcdir}"
  patch -p1 < "${this_dir}/clang.patch"
  cd "${builddir}"
  cmake "${srcdir}/llvm" -DCMAKE_INSTALL_PREFIX="${pkgdir}" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_C_COMPILER="${FP}/.local/bin/gcc" \
    -DCMAKE_CXX_COMPILER="${FP}/.local/bin/g++" \
    -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra;lld" \
    -DLLVM_BUILD_LLVM_DYLIB=ON \
    -DLLVM_LINK_LLVM_DYLIB=ON \
    -DLLVM_INSTALL_UTILS=ON \
    -DLLVM_ENABLE_RTTI=ON \
    -DLLVM_BINUTILS_INCDIR="${FP}/.local/include"
}

do_compile() {
  cd "${builddir}"
  cmake --build "${builddir}" -- -j$(nproc)
}

do_install() {
  cd "${builddir}"
  cmake --build "${builddir}" --target install/strip
}

if [ -n "${BASH_SOURCE}" ]; then
  this_script=${BASH_SOURCE}
  this_dir="$(cd "$(dirname "${BASH_SOURCE}")" && pwd)"
elif [ -n "${ZSH_NAME}" ]; then
  this_script=$0
  this_dir="$(cd "$(dirname "$0")" && pwd)"
else
  echo "Error: Unsupported shell"
  return 1
fi

source "${this_dir}/linsee-makepkg.sh"
do_everything
