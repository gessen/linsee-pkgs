#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

pkgname=powerlevel10k
pkgver=1.14.6
source="https://github.com/romkatv/${pkgname}"

do_install() {
  pkgdir="${FP}/.config/oh-my-zsh/themes/${pkgname}"
  if [ -d "${pkgdir}" ]; then
    return
  fi
  git clone "${source}" "${pkgdir}" --branch="v${pkgver}"
  ln -sfn "${pkgdir}/${pkgname}.zsh-theme" "${FP}/.config/oh-my-zsh/themes/${pkgname}.zsh-theme"
}

do_install



