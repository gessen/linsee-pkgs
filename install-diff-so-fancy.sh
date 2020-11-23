#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

pkgname=diff-so-fancy
pkgver=1.3.0
source="https://github.com/so-fancy/${pkgname}/archive/v${pkgver}.tar.gz"
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
  sed -i 's|^use lib .*$|use lib dirname(abs_path(File::Spec->catdir($0))) . "/../share/diff-so-fancy/";|' diff-so-fancy
  install -Dm 755 diff-so-fancy "${pkgdir}/bin/diff-so-fancy"
  install -Dm 755 lib/DiffHighlight.pm "${pkgdir}/share/${pkgname}/DiffHighlight.pm"
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
