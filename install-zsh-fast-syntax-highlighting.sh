#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

pkgname=fast-syntax-highlighting
pkgver=1.55
source="https://github.com/zdharma/fast-syntax-highlighting"

do_install() {
  pkgdir="${FP}/.config/oh-my-zsh/plugins/${pkgname}"
  if [ -d "${pkgdir}" ]; then
    return
  fi
  git clone "${source}" "${pkgdir}" --branch="v${pkgver}"
}

do_install
