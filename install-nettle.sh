#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

pkgname=nettle
pkgver=3.6
source="https://ftp.gnu.org/gnu/${pkgname}/${pkgname}-${pkgver}.tar.gz"

do_configure() {
  cd "${builddir}"
  export CFLAGS="$(pkg-config --cflags gmp)"
  export LDFLAGS="$(pkg-config --libs gmp)"
  "${srcdir}/configure" --prefix="${pkgdir}" \
    --libdir="${pkgdir}/lib" \
    --disable-static
}

do_compile() {
  cd "${builddir}"
  make -j$(nproc)
}

do_install() {
  cd "${builddir}"
  make install
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
