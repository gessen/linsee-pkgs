#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

do_install() {
  export CPPFLAGS="$(pkg-config --cflags readline sqlite3)"
  export LDFLAGS="$(pkg-config --libs readline sqlite3)"
  export CONFIGURE_OPTS="--enable-shared"
  python2_ver="2.7.16"
  python3_ver="3.6.8"
  pyenv install --skip-existing --verbose "${python2_ver}"
  pyenv install --skip-existing --verbose "${python3_ver}"
  python2_bin="${PYENV_ROOT}/versions/${python2_ver}/bin/python"
  python3_bin="${PYENV_ROOT}/versions/${python3_ver}/bin/python"
  python2_rpath="$(patchelf --print-rpath ${python2_bin})"
  python3_rpath="$(patchelf --print-rpath ${python3_bin})"
  patchelf --set-rpath "${python2_rpath}:${LD_LIBRARY_PATH}" "${python2_bin}"
  patchelf --set-rpath "${python3_rpath}:${LD_LIBRARY_PATH}" "${python3_bin}"
  pyenv global "${python3_ver}" "${python2_ver}"
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

source "${this_dir}/linsee-pip.sh"
do_everything
