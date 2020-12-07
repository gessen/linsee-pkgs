#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

pkgname=ccls
source="git+https://github.com/MaskRay/ccls.git"
do_strip=0

do_configure() {
  cd "${builddir}"
  cmake "${srcdir}" -DCMAKE_INSTALL_PREFIX="${pkgdir}" \
    -DCMAKE_CXX_COMPILER=clang++ \
    -DCCLS_VERSION="$(date +%Y%m%d)" \
    -DCLANG_LINK_CLANG_DYLIB=on \
    -DUSE_SYSTEM_RAPIDJSON=off
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
