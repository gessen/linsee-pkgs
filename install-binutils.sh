#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

pkgname=binutils
pkgver=2.35.1
source="https://ftp.gnu.org/gnu/${pkgname}/${pkgname}-${pkgver}.tar.xz"

do_configure() {
  cd "${builddir}"
  "${srcdir}/configure" --prefix="${pkgdir}" \
    --with-lib-path="${FP}/.local/lib:/lib64:/lib:/usr/lib64:/usr/lib" \
    --enable-gold \
    --enable-ld=default \
    --enable-lto \
    --enable-plugins \
    --enable-relro \
    --enable-shared \
    --enable-threads \
    --disable-gdb \
    --disable-werror \
    --with-pic

  make configure-host
}

do_compile() {
  cd "${builddir}"
  make -j$(nproc)
}

do_install() {
  cd "${builddir}"
  make install prefix="${pkgdir}"
  rm -rf "${pkgdir}/x86_64-pc-linux-gnu/"
  rm -rf "${pkgdir}/share/man/man1/"{dlltool,windres,windmc}*
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
