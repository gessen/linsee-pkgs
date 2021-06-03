#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

pkgname=fzf
pkgver=0.27.2
source="https://github.com/junegunn/${pkgname}/archive/${pkgver}.tar.gz"
filename="${pkgname}-${pkgver}.tar.gz"
do_builddir=0
do_patchelf=0

do_configure() {
  :
}

do_compile() {
  :
}

do_install() {
  cd "${srcdir}"
  ./install --bin
  install -dm 755 "${pkgdir}/bin"
  install -Dm 755 bin/* -t "${pkgdir}/bin"

  install -dm 755 "${pkgdir}/share/fzf/shell"
  install -Dm 644 shell/*.bash shell/*.zsh -t "${pkgdir}/share/fzf/shell"

  install -Dm 644 man/man1/fzf.1 "${pkgdir}/share/man/man1/fzf.1"
  install -Dm 644 man/man1/fzf-tmux.1 "${pkgdir}/share/man/man1/fzf-tmux.1"
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
