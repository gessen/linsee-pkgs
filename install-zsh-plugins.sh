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

"${this_dir}/install-zsh-autopair.sh"
"${this_dir}/install-zsh-autosuggestions.sh"
"${this_dir}/install-zsh-fzf-git.sh"
"${this_dir}/install-zsh-fzf-kill.sh"
"${this_dir}/install-zsh-interactive-cd.sh"
"${this_dir}/install-zsh-syntax-highlighting.sh"
