#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

pkgname=stow
pkgver=2.3.1
source="https://ftp.gnu.org/gnu/${pkgname}/${pkgname}-${pkgver}.tar.gz"
filename="${pkgname}-${pkgver}.tar.gz"
do_stow=0

do_configure() {
  cd "${builddir}"
  "${srcdir}/configure" --prefix="${pkgdir}" \
    --mandir="${pkgdir}/share/man" \
    --infodir="${pkgdir}/share/info" \
    --with-pmdir="${pkgdir}/share/perl5/vendor_perl"
}

do_compile() {
  cd "${builddir}"
  make
}

do_install() {
  cd "${builddir}"
  make install PREFIX="${pkgdir}"
  cd "${stowdir}"
  "${stowdir}/${pkgname}/bin/${pkgname}" -v "${pkgname}"
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
