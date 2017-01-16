#!/usr/bin/env bash

echo "Installing dotfiles ..."

echo "Initializing submodule(s) ..."
git submodule update --init --recursive

echo "Installing required packages ..."
echo "  You need to be a sudo user for installing softwares."
echo "  Please give your password if demanded."
sudo -E apt update
sudo -E apt install zsh tmux neovim markdown xsel silversearcher-ag exuberant-ctags git gcc g++ sed python-pip python3-pip npm nodejs pandoc

echo "Installing fonts ..."
ln -s $PWD/terminal_fonts ~/.local/share/fonts/terminal_fonts

echo "Installing configuration ..."
cd scripts
./zsh.sh
./tmux.sh
./git.sh

mkdir -p ~/.local/share/nvim
mkdir -p ~/.local/share/nvim/{backup,swap,view,undo}
./nvim.sh


echo "Installation Complete."
echo "Post Installation manual configuring (Highly Reccomended)"
echo "For installing tmux plugins, please enter tmux and press <ctrl-b-I>."
echo " For getting base16 color scheme in shell and vim. Please open a ZSH shell and input base16_brewer or any other theme name."
