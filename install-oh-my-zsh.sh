#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

pkgname=oh-my-zsh
source="git+https://github.com/ohmyzsh/ohmyzsh.git"
do_builddir=0
do_patchelf=0
do_strip=0

do_configure() {
  :
}

do_compile() {
  :
}

do_install() {
  install -dm 755 "${pkgdir}/share/${pkgname}/"
  rsync -auz "${srcdir}/" "${pkgdir}/share/${pkgname}/"
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
