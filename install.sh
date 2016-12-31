#!/usr/bin/env bash

echo "Installing dotfiles"

echo "Initializing submodule(s)"
git submodule update --init --recursive

echo "Installing required packages"
sudo -E apt update
sudo -E apt install zsh tmux neovim markdown xsel silversearcher-ag exuberant-ctags git gcc g++ sed python-pip python3-pip npm nodejs pandoc

echo "Installing fonts"
cp -R /fonts/ ~/.local/share/fonts/

echo "Installing configuration"
cd scripts
./oh_my_zsh_install.sh
./base16-shell.sh
./tmux.sh
./nvim.sh
./git.sh
