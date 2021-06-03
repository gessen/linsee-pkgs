#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

ln -sfn "/var/fpwork/${USER}" "${HOME}/Workspace"

ln -sfn "${FP}/.dotfiles" "${HOME}/.dotfiles"
ln -sfn "${FP}/.cache/clangd" "${HOME}/.clangd"
ln -sfn "${FP}/.config/emacs" "${HOME}/.config/emacs"
ln -sfn "${FP}/.config/oh-my-zsh" "${HOME}/.config/oh-my-zsh"

ln -sfn "${HOME}/.dotfiles/home/bash_profile" "${HOME}/.bash_profile"
ln -sfn "${HOME}/.dotfiles/home/bashrc" "${HOME}/.bashrc"
ln -sfn "${HOME}/.dotfiles/home/zprofile" "${HOME}/.zprofile"
ln -sfn "${HOME}/.dotfiles/home/zshrc" "${HOME}/.zshrc"

mkdir -p "${FP}/.cache/ccache"
mkdir -p "${FP}/.cache/clangd"
mkdir -p "${FP}/.config/emacs/straight/versions"
mkdir -p "${FP}/.config/oh-my-zsh"
mkdir -p "${HOME}/.config/bat"
mkdir -p "${HOME}/.config/ccache"
mkdir -p "${HOME}/.config/clangd"
mkdir -p "${HOME}/.config/git"
mkdir -p "${HOME}/.config/htop"
mkdir -p "${HOME}/.config/lsd"
mkdir -p "${HOME}/.config/ranger"
mkdir -p "${HOME}/.config/ripgrep"
mkdir -p "${HOME}/.config/tig"
mkdir -p "${HOME}/.config/tmux"
mkdir -p "${HOME}/.ssh"

ln -sfn "${HOME}/.dotfiles/home/config/bat/config" "${HOME}/.config/bat/config"
ln -sfn "${HOME}/.dotfiles/home/config/ccache/config" "${HOME}/.config/ccache/config"
ln -sfn "${HOME}/.dotfiles/home/config/clangd/config.yaml" "${HOME}/.config/clangd/config.yaml"
ln -sfn "${HOME}/.dotfiles/home/config/emacs/init.el" "${HOME}/.config/emacs/init.el"
ln -sfn "${HOME}/.dotfiles/home/config/emacs/early-init.el" "${HOME}/.config/emacs/early-init.el"
ln -sfn "${HOME}/.dotfiles/home/config/emacs/straight/versions/default.el" "${HOME}/.config/emacs/straight/versions/default.el"
ln -sfn "${HOME}/.dotfiles/home/config/git/attributes" "${HOME}/.config/git/attributes"
ln -sfn "${HOME}/.dotfiles/home/config/git/config" "${HOME}/.config/git/config"
ln -sfn "${HOME}/.dotfiles/home/config/git/config.local" "${HOME}/.config/git/config.local"
ln -sfn "${HOME}/.dotfiles/home/config/git/ignore" "${HOME}/.config/git/ignore"
ln -sfn "${HOME}/.dotfiles/home/config/htop/htoprc" "${HOME}/.config/htop/htoprc"
ln -sfn "${HOME}/.dotfiles/home/config/lsd/config.yaml" "${HOME}/.config/lsd/config.yaml"
ln -sfn "${HOME}/.dotfiles/home/config/ranger/commands.py" "${HOME}/.config/ranger/commands.py"
ln -sfn "${HOME}/.dotfiles/home/config/ranger/rc.conf" "${HOME}/.config/ranger/rc.conf"
ln -sfn "${HOME}/.dotfiles/home/config/ripgrep/config" "${HOME}/.config/ripgrep/config"
ln -sfn "${HOME}/.dotfiles/home/config/tig/config" "${HOME}/.config/tig/config"
ln -sfn "${HOME}/.dotfiles/home/config/tmux/tmux.conf" "${HOME}/.config/tmux/tmux.conf"
ln -sfn "${HOME}/.dotfiles/home/config/shprofile" "${HOME}/.config/shprofile"
ln -sfn "${HOME}/.dotfiles/home/config/shrc" "${HOME}/.config/shrc"

ln -sfn "${HOME}/.config/git/config" "${HOME}/.gitconfig"

ln -sfn "${HOME}/.dotfiles/home/ssh/asmr-config" "${HOME}/.ssh/asmr-config"
ln -sfn "${HOME}/.dotfiles/home/ssh/config" "${HOME}/.ssh/config"
ln -sfn "${HOME}/.dotfiles/home/ssh/gerrit-config" "${HOME}/.ssh/gerrit-config"
ln -sfn "${HOME}/.dotfiles/home/ssh/github-config" "${HOME}/.ssh/github-config"
ln -sfn "${HOME}/.dotfiles/home/ssh/krling-config" "${HOME}/.ssh/krling-config"
ln -sfn "${HOME}/.dotfiles/home/ssh/mars-config" "${HOME}/.ssh/mars-config"

mkdir -p "${FP}/.local/share/bash"
mkdir -p "${FP}/.local/share/ranger"

ln -sfn "${FP}/.local/share/bash" "${HOME}/.local/share/bash"
ln -sfn "${FP}/.local/share/cargo" "${HOME}/.local/share/cargo"
ln -sfn "${FP}/.local/share/pyenv" "${HOME}/.local/share/pyenv"
ln -sfn "${FP}/.local/share/ranger" "${HOME}/.local/share/ranger"
ln -sfn "${FP}/.local/share/rustup" "${HOME}/.local/share/rustup"
ln -sfn "${FP}/.local/share/zsh" "${HOME}/.local/share/zsh"
