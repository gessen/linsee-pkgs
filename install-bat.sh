#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

pkgname=bat
pkgver=0.18.0
source="https://github.com/sharkdp/${pkgname}/archive/v${pkgver}.tar.gz"
do_builddir=0

do_configure() {
  :
}

do_compile() {
  cd "${srcdir}"
  cargo build --release --locked
}

do_install() {
  cd "${srcdir}"
  install -dm 755 "${pkgdir}/bin"
  install -dm 755 "${pkgdir}/share/zsh/site-functions"
  install -dm 755 "${pkgdir}/share/man/man1"

  install -Dm 755 "target/release/${pkgname}" -t "${pkgdir}/bin"
  find "target/release" -name bat.1 -type f \
    -exec install -Dm 644 {} -t "${pkgdir}/share/man/man1" \;
  find "target/release" -name bat.zsh -type f \
    -exec install -Dm 644 {} "${pkgdir}/share/zsh/site-functions/_bat" \;
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
