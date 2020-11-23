#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

pkgname=ncurses
pkgver=6.2
source="https://ftp.gnu.org/pub/gnu/${pkgname}/${pkgname}-${pkgver}.tar.gz"

do_configure() {
  cd "${builddir}"
  "${srcdir}/configure" --prefix="${pkgdir}" \
    --with-pkg-config-libdir="${pkgdir}/lib/pkgconfig" \
    --with-shared \
    --with-cxx-shared \
    --without-normal \
    --without-debug \
    --without-ada \
    --enable-widec \
    --enable-pc-files
}

do_compile() {
  cd "${builddir}"
  make -j$(nproc)
}

do_install() {
  cd "${builddir}"
  make install

  # fool packages looking to link to non-wide-character ncurses libraries
  for lib in ncurses ncurses++ form panel menu; do
    echo "INPUT(-l${lib}w)" > "${pkgdir}/lib/lib${lib}.so"
    ln -sf "${lib}w.pc" "${pkgdir}/lib/pkgconfig/${lib}.pc"
  done

  for lib in tic tinfo; do
    echo "INPUT(libncursesw.so.${pkgver:0:1})" > "${pkgdir}/lib/lib${lib}.so"
    ln -sf "libncursesw.so.${pkgver:0:1}" "${pkgdir}/lib/lib${lib}.so.${pkgver:0:1}"
    ln -sf "ncursesw.pc" "${pkgdir}/lib/pkgconfig/${lib}.pc"
  done

  # some packages look for -lcurses during build
  echo 'INPUT(-lncursesw)' > "${pkgdir}/lib/libcursesw.so"
  ln -sf libncurses.so "${pkgdir}/lib/libcurses.so"

  for lib in formw menuw ncurses++w ncursesw panelw; do
    sed -i 's|^Libs: |Libs: -L${libdir} |' "${pkgdir}/lib/pkgconfig/${lib}.pc"
  done
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
