#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

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

"${this_dir}/install-symlinks.sh"
"${this_dir}/install-dotfiles.sh"
"${this_dir}/install-zsh-plugins.sh"
"${this_dir}/install-zsh-themes.sh"

"${this_dir}/install-stow.sh"
"${this_dir}/install-bash-completion.sh"
"${this_dir}/install-git-completion.sh"
"${this_dir}/install-fasd.sh"
"${this_dir}/install-fzf.sh"
"${this_dir}/install-patchelf.sh"
"${this_dir}/install-pyenv.sh"
"${this_dir}/install-oh-my-zsh.sh"

"${this_dir}/install-cmake.sh"
"${this_dir}/install-gcc.sh"

"${this_dir}/install-aspell.sh"
"${this_dir}/install-aspell-en.sh"
"${this_dir}/install-binutils.sh"
"${this_dir}/install-libevent.sh"
"${this_dir}/install-grpc.sh"
"${this_dir}/install-ncurses.sh"
"${this_dir}/install-bison.sh"
"${this_dir}/install-curl.sh"
"${this_dir}/install-jansson.sh"
"${this_dir}/install-gmp.sh"
"${this_dir}/install-libtasn1.sh"
"${this_dir}/install-sqlite.sh"
"${this_dir}/install-tar.sh"

"${this_dir}/install-tmux.sh"
"${this_dir}/install-htop.sh"
"${this_dir}/install-less.sh"
"${this_dir}/install-tig.sh"
"${this_dir}/install-zsh.sh"
"${this_dir}/install-git.sh"
"${this_dir}/install-nettle.sh"
"${this_dir}/install-pythons.sh"
"${this_dir}/install-libtool.sh"
"${this_dir}/install-git-lfs.sh"
"${this_dir}/install-gnutls.sh"
"${this_dir}/install-bear.sh"
"${this_dir}/install-git-review.sh"
"${this_dir}/install-ranger.sh"
"${this_dir}/install-repo.sh"

"${this_dir}/install-llvm-project.sh"
"${this_dir}/install-ccls.sh"
"${this_dir}/install-emacs.sh"
"${this_dir}/install-rustup.sh"
"${this_dir}/install-bat.sh"
"${this_dir}/install-delta.sh"
"${this_dir}/install-fd.sh"
"${this_dir}/install-lsd.sh"
"${this_dir}/install-ripgrep.sh"
"${this_dir}/install-sad.sh"

