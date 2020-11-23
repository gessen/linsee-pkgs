#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

pkgname=lsd
pkgver=0.16.0

do_install() {
  cargo install --root="${pkgdir}" --version="${pkgver}" --force "${pkgname}"
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

source "${this_dir}/linsee-cargo.sh"
do_everything
