#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

do_install() {
  export CPPFLAGS="$(pkg-config --cflags sqlite3)"
  export LDFLAGS="$(pkg-config --libs sqlite3)"
  pyenv install --skip-existing --verbose 2.7.16
  pyenv install --skip-existing --verbose 3.6.8
  pyenv global 3.6.8 2.7.16
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
