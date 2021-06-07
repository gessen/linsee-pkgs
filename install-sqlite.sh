#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

pkgname=sqlite
pkgver=3350500
source="https://www.sqlite.org/2021/${pkgname}-src-${pkgver}.zip"

do_configure() {
  export LDFLAGS="-L${FP}/.local/lib"
  cd "${builddir}"
  "${srcdir}/configure" --prefix="${pkgdir}" TCLLIBDIR="${pkgdir}/share/sqlite3"
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
