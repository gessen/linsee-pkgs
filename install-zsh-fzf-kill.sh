#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

pkgname=fzf-kill
source="https://github.com/gessen/zsh-${pkgname}"

do_install() {
  pkgdir="${FP}/.config/oh-my-zsh/plugins/${pkgname}"
  if [ -d "${pkgdir}" ]; then
    return
  fi
  git clone "${source}" "${pkgdir}"
}

do_install
