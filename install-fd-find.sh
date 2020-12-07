#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

pkgname=fd-find
pkgver=8.2.0
source="https://github.com/sharkdp/fd/archive/v${pkgver}.tar.gz"
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
  install -dm 755 "${pkgdir}/share/man/man1"

  install -Dm 755 "target/release/fd" -t "${pkgdir}/bin"
  find "target/release" -name fd.bash -type f \
    -exec install -Dm 644 {} "${pkgdir}/share/bash-completion/completions/fd" \;
  install -Dm 644 "contrib/completion/_fd" -t "${pkgdir}/share/zsh/site-functions"
  install -Dm 644 "doc/fd.1" -t "${pkgdir}/share/man/man1"
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
