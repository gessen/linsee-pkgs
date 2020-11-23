#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

pkgname=gnutls
pkgver=3.6.15
source="https://www.gnupg.org/ftp/gcrypt/${pkgname}/v${pkgver%.*}/${pkgname}-${pkgver}.tar.xz"

do_configure() {
  cd "${builddir}"
  export CFLAGS="$(pkg-config --cflags libtasn1)"
  export LDFLAGS="$(pkg-config --libs libtasn1)"
  export CFLAGS="${CFLAGS} $(pkg-config --cflags nettle)"
  export LDFLAGS="${LDFLAGS} $(pkg-config --libs nettle)"
  export CFLAGS="${CFLAGS} $(pkg-config --cflags gmp)"
  export LDFLAGS="${LDFLAGS} $(pkg-config --libs gmp)"
  "${srcdir}/configure" --prefix="${pkgdir}" \
    --with-included-unistring \
    --without-p11-kit \
    --disable-static
}

do_compile() {
  cd "${builddir}"
  make -j$(nproc)
}

do_install() {
  cd "${builddir}"
  make install

  find "${pkgdir}/share/info" -name '*.info*' -exec gzip -n -9 {} \;
  find "${pkgdir}/share/man" -exec gzip -n -9 {} \;
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
