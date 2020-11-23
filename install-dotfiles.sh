#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

pkgname=dotfiles
branch=linsee
source="git@gitlabe2.ext.net.nokia.com:jswierk/${pkgname}.git"

do_install() {
  git clone "${source}" --branch="${branch}" "${FP}/.dotfiles"
}

do_install
