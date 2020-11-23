#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

pkgname=zsh-autopair
source="https://github.com/hlissner/${pkgname}"

do_install() {
  pkgdir="${FP}/.config/oh-my-zsh/plugins/${pkgname}"
  if [ -d "${pkgdir}" ]; then
    return
  fi
  git clone "${source}" "${pkgdir}"
}

do_install
