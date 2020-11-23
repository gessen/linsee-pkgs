#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

pkgname=libevent
pkgver=2.1.12
source="https://github.com/${pkgname}/${pkgname}/releases/download/release-${pkgver}-stable/${pkgname}-${pkgver}-stable.tar.gz"
do_strip=0

do_configure() {
  cd "${builddir}"
  cmake "${srcdir}" -DCMAKE_INSTALL_PREFIX="${pkgdir}" \
    -DCMAKE_BUILD_TYPE=Release \
    -DEVENT__LIBRARY_TYPE=SHARED
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
