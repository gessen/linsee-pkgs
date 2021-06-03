#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

pkgname=gcc
pkgver=10.3.0
source="https://ftp.gnu.org/gnu/${pkgname}/${pkgname}-${pkgver}/${pkgname}-${pkgver}.tar.xz"
do_strip=0

do_configure() {
  cd "${srcdir}"
  ./contrib/download_prerequisites
  cd "${builddir}"
  "${srcdir}/configure" --prefix="${pkgdir}" \
    --libdir="${pkgdir}/lib" \
    --libexecdir="${pkgdir}/lib" \
    --mandir="${pkgdir}/share/man" \
    --infodir="${pkgdir}/share/info" \
    --enable-languages=c,c++ \
    --enable-shared \
    --enable-threads=posix \
    --enable-lto \
    --enable-plugin \
    --disable-multilib
}

do_compile() {
  cd "${builddir}"
  make -j$(nproc)
}

do_install() {
  cd "${builddir}"
  make install
  if [[ ! -f "${pkgdir}/bin/cc" ]]; then
    cp -a "${pkgdir}/bin/gcc" "${pkgdir}/bin/cc"
  fi
  mv "${pkgdir}/lib64/"* "${pkgdir}/lib/"
  rm -rf "${pkgdir}/lib64"
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
