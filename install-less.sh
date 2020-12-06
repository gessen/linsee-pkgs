#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

pkgname=less
pkgver=563
source="http://www.greenwoodsoftware.com/${pkgname}/${pkgname}-${pkgver}.tar.gz"

do_configure() {
  cd "${builddir}"
  "${srcdir}/configure" --prefix="${pkgdir}" \
   --sysconfdir="${pkgdir}/etc" \
   --with-regex=pcre
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
