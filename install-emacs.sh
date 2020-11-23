#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

pkgname=emacs
pkgver="27.1"
source="https://github.com/emacs-mirror/${pkgname}/archive/${pkgname}-${pkgver}.tar.gz"

do_configure() {
  cd "${srcdir}"
  ./autogen.sh
  cd "${builddir}"
  "${srcdir}/configure" --prefix="${pkgdir}" \
    --with-modules \
    --without-x
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
