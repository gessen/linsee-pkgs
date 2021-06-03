#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

pkgname=cmake
pkgver=3.20.3
source="https://cmake.org/files/v${pkgver%.*}/${pkgname}-${pkgver}-linux-x86_64.tar.gz"
do_builddir=0
do_strip=0

do_configure() {
  cd "${srcdir}"
  mv man share/
  mv doc share/
}

do_compile() {
  :
}

do_install() {
  cd "${srcdir}"
  mkdir -p "${pkgdir}/bin"
  mkdir -p "${pkgdir}/share"
  cp -r bin/ "${pkgdir}/"
  cp -r share/ "${pkgdir}/"
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
