#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

pkgname=tig
pkgver=2.5.0
source="https://github.com/jonas/${pkgname}/releases/download/${pkgname}-${pkgver}/${pkgname}-${pkgver}.tar.gz"
do_builddir=0

do_configure() {
  cd "${srcdir}"
  ./configure --prefix="${pkgdir}"
}

do_compile() {
  cd "${srcdir}"
  make -j$(nproc)
}

do_install() {
  cd "${srcdir}"
  make install
  install -Dm 644 contrib/tig-completion.bash "${pkgdir}/share/bash-completion/completions/${pkgname}"
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
