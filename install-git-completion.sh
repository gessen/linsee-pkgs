#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

pkgname=git-completion
pkgver=1.3
source="https://github.com/felipec/${pkgname}/archive/v${pkgver}.tar.gz"
do_builddir=0

do_configure() {
  :
}

do_compile() {
  :
}

do_install() {
  cd "${srcdir}"
  make install \
    DESTDIR="${pkgdir}/" \
    zshfuncdir="share/zsh/site-functions" \
    completionsdir="share/bash-completion/completions" \
    sharedir="share/git-completion"
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
