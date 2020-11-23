#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

pkgname=aspell-en
pkgver=2019.10.06
source="https://ftp.gnu.org/gnu/aspell/dict/en/aspell6-en-${pkgver}-0.tar.bz2"
do_builddir=0

do_configure() {
  cd "${srcdir}"
  ./configure --vars ASPELL="${FP}/.local/stow/aspell/bin/aspell"
}

do_compile() {
  cd "${srcdir}"
  make -j$(nproc)
}

do_install() {
  cd "${srcdir}"
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

do_purge() {
  :
}

do_strip() {
  :
}

do_stow() {
  cd "${stowdir}"
  "${stow}" -v "${pkgname%-*}"
}

do_everything
