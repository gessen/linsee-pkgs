#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

pkgname=libxml2
pkgver=v2.9.12
source="git+https://gitlab.gnome.org/GNOME/${pkgname}.git"

do_configure() {
  cd "${srcdir}"
  patch -p1 < "${this_dir}/${pkgname}/${pkgname}.patch"
  sed -e '/cd fuzz; /d' -e 's/fuzz //g' -i Makefile.am
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
  export CPPFLAGS="$(python-config --includes)"
  libtoolize
  autoreconf -fiv
  cd "${builddir}"
  "${srcdir}/configure" --prefix="${pkgdir}" \
    --with-threads \
    --with-history \
    --with-python="$(python-config --prefix)/bin/python"
  sed -i -e 's/ -shared / -Wl,-O1,--as-needed\0 /g' libtool
}

do_compile() {
  cd "${builddir}"
  PYTHONHASHSEED=0 make -j$(nproc)
  find doc -type f -exec chmod 0644 {} +
}

do_install() {
  cd "${builddir}"
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
do_everything
