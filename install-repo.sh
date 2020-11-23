#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

pkgname=repo

pkgdir="${FP}/.local/stow/${pkgname}"
stowdir="${FP}/.local/stow"
stow="${FP}/.local/bin/stow"

do_install() {
  mkdir -p "${pkgdir}/bin"
  curl -L https://storage.googleapis.com/git-repo-downloads/repo -o "${pkgdir}/bin/${pkgname}"
  chmod a+x "${pkgdir}/bin/${pkgname}"
}

do_stow() {
  cd "${stowdir}"
  "${stow}" -v "${pkgname}"
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

do_install
do_stow
