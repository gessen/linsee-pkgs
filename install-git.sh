#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

pkgname=git
pkgver=2.28.0
source="https://www.kernel.org/pub/software/scm/${pkgname}/${pkgname}-${pkgver}.tar.xz"
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
  make install gitexecdir="${pkgdir}/lib/git-core" INSTALL_SYMLINKS=1
  install -Dm 644 ./contrib/completion/git-completion.bash "${pkgdir}/share/bash-completion/completions/${pkgname}"
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
