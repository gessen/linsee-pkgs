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

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

FP="${HOME}/Workspace"
stowdir="${FP}/.local/stow"
stow="${FP}/.local/bin/stow"

cd "${stowdir}"
"${stow}" -v rustup
"${stow}" -v cargo
