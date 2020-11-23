#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

pkgname=zsh
pkgver=5.8
source="https://www.zsh.org/pub/zsh-${pkgver}.tar.xz"
do_builddir=0
do_strip=0

do_configure() {
  cd "${srcdir}"

  # Remove unneeded and conflicting completion scripts
	for _fpath in AIX BSD Cygwin Darwin Debian Mandriva openSUSE Solaris; do
		rm -rf Completion/${_fpath}
		sed "s#\s*Completion/$_fpath/\*/\*##g" -i Src/Zle/complete.mdd
	done

  export CPPFLAGS="$(pkg-config --cflags-only-I ncursesw)"
  export LDFLAGS="$(pkg-config --libs-only-L ncursesw)"
  ./configure --prefix="${pkgdir}" \
    --docdir="${pkgdir}/share/doc/zsh" \
    --htmldir="${pkgdir}/share/doc/zsh/html" \
    --with-term-lib='ncursesw' \
    --enable-function-subdirs \
    --enable-fndir="${pkgdir}/share/zsh/functions" \
    --enable-scriptdir="${pkgdir}/share/zsh/scripts" \
    --with-tcsetpgrp
}

do_compile() {
  cd "${srcdir}"
  make -j$(nproc)
}

do_install() {
  cd "${srcdir}"
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
