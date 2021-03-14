#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

pkgname=lsd
pkgver=0.20.1
source="https://github.com/Peltoche/${pkgname}/archive/${pkgver}.tar.gz"
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
  install -dm 755 "${pkgdir}/share/bash-completion/completions"
  install -dm 755 "${pkgdir}/share/zsh/site-functions"

  install -Dm 755 "target/release/${pkgname}" -t "${pkgdir}/bin"
  find "target/release" -name lsd.bash -type f \
    -exec install -Dm 644 {} "${pkgdir}/share/bash-completion/completions/lsd" \;
  find "target/release" -name _lsd -type f \
    -exec install -Dm 644 {} -t "${pkgdir}/share/zsh/site-functions" \;
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
