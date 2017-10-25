#!/usr/bin/env bash

source ./_scripts/msg.sh
  
  info "Uninstalling dotfiles"
  info "Please note that only configuration will be removed not the installed softwares."

action "Removing Fonts."
stow -t ~ -D fonts
ok

action "Removing git configuration"
stow -t ~ -D git
printf "${BLUE}Looking for an old git config...${NORMAL}\n"
  if [ -f ~/.gitconfig.old ] || [ -h ~/.gitconfig.old ]; then
    printf "${YELLOW}Found ~/.gitconfig.old.${NORMAL} ${GREEN}Restoring up to ~/.gitconfig${NORMAL}\n";
    mv ~/.gitconfig.old ~/.gitconfig;
  fi

  if [ -f ~/.gitignore_global.old ] || [ -h ~/.gitignore_global.old ]; then
    printf "${YELLOW}Found ~/.gitignore_global.old.${NORMAL} ${GREEN}Restoring up to ~/.gitignore_global${NORMAL}\n";
    mv ~/.gitignore_global.old ~/.gitignore_global;
  fi
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
    info "Found old config file ~/.zshrc.old. Restoring up to ~/.zshrc";
    mv ~/.zshrc.old ~/.zshrc;
  fi
ok

action "Removing tmux configuration"
stow -t ~ -D tmux
printf "${BLUE}Looking for an old tmux config...${NORMAL}\n"
  if [ -f ~/.tmux.conf.old ] || [ -h ~/.tmux.conf.old ]; then
    printf "${YELLOW}Found ~/.tmux.conf.old.${NORMAL} ${GREEN}Restoring up to ~/.tmux.conf${NORMAL}\n";
    mv ~/.tmux.conf.old ~/.tmux.conf;
  fi
ok

action "Removing nvim/vim configuration"
stow -t ~ -D nvim
ok
printf "${BLUE}Looking for an old nvim config...${NORMAL}\n"
  if [ -d ~/.config/nvim.old ]; then
    printf "${YELLOW}Found ~/.config/nvim.old.${NORMAL} ${GREEN}Restoring up to ~/.config/nvim${NORMAL}\n";
    mv ~/.config/nvim.old ~/.config/nvim;
  fi

 printf "${BLUE}Looking for an old vim config...${NORMAL}\n"
  if [ -f ~/.vimrc.old ] || [ -h ~/.vimrc.old ]; then
    printf "${YELLOW}Found ~/.vimrc.old.${NORMAL} ${GREEN}Restoring up to ~/.vimrc${NORMAL}\n";
    mv ~/.vimrc.old ~/.vimrc;
  fi

action "Removing stow -t ~ Configuration"
stow -t ~ -D stow
ok


info "All configuration successfully uninstalled."

