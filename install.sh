#!/bin/sh
set -e

GITHUB_USERNAME="bensontrinh-meta"

git config --global user.email "trinhbenson@meta.com"
git config --global user.name "Benson Trinh"

echo "[INSTALL] Ohmyzsh"
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh

echo "[INSTALL] Powerlevel10k"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo "[SETUP] Vim"
sudo apt-get install vim -y

echo "[SETUP] kubectx"
sudo apt-get install kubectx

echo "[SETUP] k9s"
go install github.com/derailed/k9s@latest

echo "[INSTALL] Chezmoi"
export BINDIR=$HOME/.local/bin
sh -c "$(curl -fsLS chezmoi.io/get)"

echo "[SETUP] Chezmoi"
$BINDIR/chezmoi init $GITHUB_USERNAME

echo "[APPLY] apply dotfiles"
$BINDIR/chezmoi apply