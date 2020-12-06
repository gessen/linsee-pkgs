#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

ln -sfn "/var/fpwork/${USER}" "${HOME}/Workspace"

ln -sfn "${FP}/.dotfiles" "${HOME}/.dotfiles"
ln -sfn "${FP}/.cache/clangd" "${HOME}/.clangd"
ln -sfn "${FP}/.config/emacs" "${HOME}/.config/emacs"
ln -sfn "${FP}/.config/oh-my-zsh" "${HOME}/.config/oh-my-zsh"

ln -sfn "${HOME}/.dotfiles/home/bashrc" "${HOME}/.bashrc"
ln -sfn "${HOME}/.dotfiles/home/zshrc" "${HOME}/.zshrc"

ln -sfn "${HOME}/.dotfiles/home/config/bat/config" "${HOME}/.config/bat/config"
ln -sfn "${HOME}/.dotfiles/home/config/ccache/config" "${HOME}/.config/ccache/config"
ln -sfn "${HOME}/.dotfiles/home/config/clangd/config.yaml" "${HOME}/.config/clangd/config.yaml"
ln -sfn "${HOME}/.dotfiles/home/config/emacs/init.el" "${HOME}/.config/emacs/init.el"
ln -sfn "${HOME}/.dotfiles/home/config/emacs/early-init.el" "${HOME}/.config/emacs/early-init.el"
ln -sfn "${HOME}/.dotfiles/home/config/emacs/straight/versions/default.el" "${HOME}/.config/emacs/straight/versions/default.el"
ln -sfn "${HOME}/.dotfiles/home/config/git/attributes" "${HOME}/.config/git/attributes"
ln -sfn "${HOME}/.dotfiles/home/config/git/config" "${HOME}/.config/git/config"
ln -sfn "${HOME}/.dotfiles/home/config/git/ignore" "${HOME}/.config/git/ignore"
ln -sfn "${HOME}/.dotfiles/home/config/htop/htoprc" "${HOME}/.config/htop/htoprc"
ln -sfn "${HOME}/.dotfiles/home/config/ranger/commands.py" "${HOME}/.config/ranger/commands.py"
ln -sfn "${HOME}/.dotfiles/home/config/ranger/rc.conf" "${HOME}/.config/ranger/rc.conf"
ln -sfn "${HOME}/.dotfiles/home/config/ripgrep/config" "${HOME}/.config/ripgrep/config"
ln -sfn "${HOME}/.dotfiles/home/config/tig/config" "${HOME}/.config/tig/config"
ln -sfn "${HOME}/.dotfiles/home/config/tmux/tmux.conf" "${HOME}/.config/tmux/tmux.conf"
ln -sfn "${HOME}/.dotfiles/home/config/profile" "${HOME}/.config/profile"

ln -sfn "${HOME}/.config/git/config" "${HOME}/.gitconfig"

ln -sfn "${FP}/.local/share/bash" "${HOME}/.local/share/bash"
ln -sfn "${FP}/.local/share/cargo" "${HOME}/.local/share/cargo"
ln -sfn "${FP}/.local/share/pyenv" "${HOME}/.local/share/pyenv"
ln -sfn "${FP}/.local/share/ranger" "${HOME}/.local/share/ranger"
ln -sfn "${FP}/.local/share/rustup" "${HOME}/.local/share/rustup"
ln -sfn "${FP}/.local/share/zsh" "${HOME}/.local/share/zsh"
