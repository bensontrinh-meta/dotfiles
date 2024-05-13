#!/bin/sh
set -e

GITHUB_USERNAME="bensontrinh-meta"
export LOCAL_BIN="$HOME/.local/bin"

git config --global user.email "trinhbenson@meta.com"
git config --global user.name "Benson Trinh"

echo "[INSTALL] Ohmyzsh"
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh

echo "[INSTALL] Powerlevel10k"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo "[SETUP] Vim"
sudo apt-get install vim -y

echo "[SETUP] kubectx"
wget https://github.com/ahmetb/kubectx/releases/download/v0.9.5/kubectx -P $LOCAL_BIN
chmod +x $LOCAL_BIN/kubectx

echo "[SETUP] kubens"
wget https://github.com/ahmetb/kubectx/releases/download/v0.9.5/kubens -P $LOCAL_BIN
chmod +x $LOCAL_BIN/kubens

echo "[SETUP] k9s"
curl -sS https://webinstall.dev/k9s | bash

echo "[INSTALL] Chezmoi"
export BINDIR=$HOME/.local/bin
sh -c "$(curl -fsLS chezmoi.io/get)"

echo "[SETUP] Chezmoi"
$BINDIR/chezmoi init $GITHUB_USERNAME

echo "[SETUP] direnv"
curl -sfL https://direnv.net/install.sh | bash

echo "[APPLY] apply dotfiles"
$BINDIR/chezmoi apply