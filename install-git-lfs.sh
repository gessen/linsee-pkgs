#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

pkgname=git-lfs
pkgver=2.12.0
source="https://github.com/${pkgname}/${pkgname}/releases/download/v${pkgver}/${pkgname}-linux-amd64-v${pkgver}.tar.gz"
strip_components=0
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
  install -Dm 755 git-lfs "${pkgdir}/bin/git-lfs"
  git lfs install
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
