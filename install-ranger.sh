#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

pkgname=ranger

do_install() {
  eval "$(pyenv init -)"
  pip install "${pkgname}-fm"
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
