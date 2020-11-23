#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

pkgname=pyenv
pkgver=1.2.21
source="https://github.com/${pkgname}/${pkgname}/archive/v${pkgver}.tar.gz"
filename="${pkgname}-${pkgver}.tar.gz"
do_builddir=0

do_configure() {
  :
}

do_compile() {
  :
}

do_install() {
  cd "${srcdir}"

  install -dm 755 "${pkgdir}/bin"
  install -dm 755 "${pkgdir}/share/${pkgname}/libexec"
  install -Dm 755 libexec/* -t "${pkgdir}/share/${pkgname}/libexec"
  ln -sf "${pkgdir}/share/${pkgname}/libexec/${pkgname}" "${pkgdir}/bin/${pkgname}"

  install -dm 755 "${pkgdir}/share/${pkgname}/pyenv.d/exec/pip-rehash"
  install -dm 755 "${pkgdir}/share/${pkgname}/pyenv.d/rehash/conda.d"
  install -dm 755 "${pkgdir}/share/${pkgname}/pyenv.d/rehash/source.d"
  install -Dm 755 pyenv.d/exec/pip-rehash/* -t "${pkgdir}/share/${pkgname}/pyenv.d/exec/pip-rehash"
  install -Dm 644 pyenv.d/exec/*.bash -t "${pkgdir}/share/${pkgname}/pyenv.d/exec/"
  install -Dm 644 pyenv.d/rehash/*.bash -t "${pkgdir}/share/${pkgname}/pyenv.d/rehash"
  install -Dm 644 pyenv.d/rehash/conda.d/* -t "${pkgdir}/share/${pkgname}/pyenv.d/rehash/conda.d"
  install -Dm 644 pyenv.d/rehash/source.d/* -t "${pkgdir}/share/${pkgname}/pyenv.d/rehash/source.d"

  install -dm 755 "${pkgdir}/share/${pkgname}/plugins/python-build/bin"
  install -Dm 755 plugins/python-build/bin/* -t "${pkgdir}/share/${pkgname}/plugins/python-build/bin"
  for bin in {"${pkgname}"-{install,uninstall},python-build}; do
    ln -sf "${pkgdir}/share/${pkgname}/plugins/python-build/bin/${bin}" "${pkgdir}/bin/${bin}"
  done
  cp -a plugins/python-build/share "${pkgdir}/share/${pkgname}/plugins/python-build"

  install -Dm 644 completions/${pkgname}.bash "${pkgdir}/share/bash-completion/completions/${pkgname}"
  install -Dm 644 completions/${pkgname}.zsh "${pkgdir}/share/zsh/site-functions/_${pkgname}"
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
