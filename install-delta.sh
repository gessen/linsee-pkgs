#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

pkgname=delta
source="git+https://github.com/dandavison/${pkgname}.git"
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
  install -Dm 644 "etc/completion/completion.bash" "${pkgdir}/share/bash-completion/completions/delta"
  install -Dm 644 "etc/completion/completion.zsh" "${pkgdir}/share/zsh/site-functions/_delta"
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
