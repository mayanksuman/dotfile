#!/usr/bin/env bash

echo "Installing dotfiles ..."

echo "Initializing submodule(s) ..."
git submodule update --init --recursive

echo "Installing required packages ..."
echo " Adding repository for latest nodejs and npm"
echo "  You need to be a sudo user for installing softwares."
echo "  Please give your password if demanded."
curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
sudo -E apt update
sudo -E apt install -y build-essential exuberant-ctags cmake python-pip \
	python3-pip nodejs git zsh tmux markdown pandoc sed xsel\
	silversearcher-ag pandoc \
	neovim python-neovim python3-neovim 

echo "Installing fonts ..."
if [ -d ~/.local/share/fonts/terminal_fonts ]; then
	printf "Found ~/.local/share/fonts/terminal_fonts.Backing up to ~/.local/share/fonts/terminal_fonts.old\n";
	mv ~/.local/share/fonts/terminal_fonts ~/.local/share/fonts/terminal_fonts.old;
fi
ln -s $PWD/terminal_fonts ~/.local/share/fonts/terminal_fonts

echo "Installing configuration ..."
cd scripts
./zsh.sh
./tmux.sh
./git.sh

mkdir -p ~/.local/share/nvim
mkdir -p ~/.local/share/nvim/{backup,swap,view,undo}
./nvim.sh

#Applying base16 brewer theme
bash -lic base16_brewer

echo "Installation Complete."
echo "Post Installation manual configuration"
echo " The theme can be changed by issueing base16_* command in ZSH or BASH."
