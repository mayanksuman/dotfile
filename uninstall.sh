#!/usr/bin/env bash

source ./_scripts/msg.sh
if [ "$(id -u)" = 0 ]; then
	error "This script should not be run as root. Exitting"
	exit 1
fi

info "Uninstalling dotfiles"
info "Please note that only configuration will be removed not the installed softwares by package manager."

info "  You need to be a sudo user for uninstalling configuration."
info "  Please give your password if demanded."
sudo -v
# Keep-alive: update existing sudo time stamp until the script has finished
while true; 
do
	sudo -n true; sleep 60; kill -0 "$$" || exit; 
done 2>/dev/null &

action "Removing gdb configuration"
stow -t ~ -D gdb
ok

action "Removing Fonts."
stow -t ~ -D fonts
step "Updating font cache"
sudo fc-cache -f -v
ok

action "Removing nodejs configuration."
stow -t ~ -D nodejs
ok

action "Removing BASH configuration"
stow -t ~ -D shell_common
if [ -f ~/.vimrc_background ] || [ -h ~/.vimrc_background ]; then
    rm ~/.vimrc_background;
  fi
  if [ -f ~/.base16_theme ] || [ -h ~/.base16_theme ]; then
    rm ~/.base16_theme;
  fi
ok

action "Removing ZSH configuration"
stow -t ~ -D zsh
  if [ -f ~/.zshrc.old ] || [ -h ~/.zshrc.old ]; then
    echo -e "${YELLOW}Found old config file ~/.zshrc.old.${NORMAL} ${GREEN}Restoring up to ~/.zshrc${NORMAL}";
    mv ~/.zshrc.old ~/.zshrc;
  fi
ok

action "Removing tmux configuration"
stow -t ~ -D tmux
info "Looking for an old tmux config..."
  if [ -f ~/.tmux.conf.old ] || [ -h ~/.tmux.conf.old ]; then
    echo -e "${YELLOW}Found ~/.tmux.conf.old.${NORMAL} ${GREEN}Restoring up to ~/.tmux.conf${NORMAL}";
    mv ~/.tmux.conf.old ~/.tmux.conf;
  fi
ok

action "Removing nvim/vim configuration"
stow -t ~ -D nvim
ok
info "Looking for an old nvim config..."
  if [ -d ~/.config/nvim.old ]; then
    echo -e "${YELLOW}Found ~/.config/nvim.old.${NORMAL} ${GREEN}Restoring up to ~/.config/nvim${NORMAL}";
    mv ~/.config/nvim.old ~/.config/nvim;
  fi

info "Looking for an old vim config..."
  if [ -f ~/.vimrc.old ] || [ -h ~/.vimrc.old ]; then
    echo -e "${YELLOW}Found ~/.vimrc.old.${NORMAL} ${GREEN}Restoring up to ~/.vimrc${NORMAL}";
    mv ~/.vimrc.old ~/.vimrc;
  fi

action "Removing pplatex binaries"
stow -t ~ -D pplatex
ok

action "Removing git configuration"
stow -t ~ -D git
info "Looking for an old git config..."
  if [ -f ~/.gitconfig.old ] || [ -h ~/.gitconfig.old ]; then
    echo -e "${YELLOW}Found ~/.gitconfig.old.${NORMAL} ${GREEN}Restoring up to ~/.gitconfig${NORMAL}";
    mv ~/.gitconfig.old ~/.gitconfig;
  fi

  if [ -f ~/.gitignore_global.old ] || [ -h ~/.gitignore_global.old ]; then
    echo -e "${YELLOW}Found ~/.gitignore_global.old.${NORMAL} ${GREEN}Restoring up to ~/.gitignore_global${NORMAL}";
    mv ~/.gitignore_global.old ~/.gitignore_global;
  fi
ok

action "Removing pyenv and associated virtualenvs"
  rm -rf $HOME/.pyenv
  step "Deconfiguring python modules"
  cd python || exit
  for dir in ./*
  do
  	stow -t ~ -D "${dir:2}"
  done
  cd - || exit
ok

action "Removing stow -t ~ Configuration"
stow -t ~ -D stow
ok

info "All configuration successfully uninstalled."
