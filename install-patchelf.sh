#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

pkgname=patchelf
pkgver=0.12
source="https://github.com/NixOS/${pkgname}/archive/${pkgver}.tar.gz"
filename="${pkgname}-${pkgver}.tar.gz"
do_patchelf=0

do_configure() {
  cd "${srcdir}"
  ./bootstrap.sh
  cd "${builddir}"
  "${srcdir}/configure" --prefix="${pkgdir}"
}

do_compile() {
  cd "${builddir}"
  make -j$(nproc)
}

do_install() {
  cd "${builddir}"
  make install PREFIX="${pkgdir}"
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
