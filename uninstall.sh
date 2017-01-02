#!/usr/bin/env bash

main() {
  # Use colors, but only if connected to a terminal, and that terminal
  # supports them.
  if which tput >/dev/null 2>&1; then
      ncolors=$(tput colors)
  fi
  if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    BOLD="$(tput bold)"
    NORMAL="$(tput sgr0)"
  else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    BOLD=""
    NORMAL=""
  fi

  # Only enable exit-on-error after the non-critical colorization stuff,
  # which may fail on systems lacking tput or terminfo
  set -e
  
  printf "${RED}Uninstalling dotfiles ${NORMAL}\n"
  printf "${YELLOW}Please note that only configuration will be removed not the installed softwares.${NORMAL}\n"

printf "${YELLOW}Removing Fonts.${NORMAL}\n"
  if [ -d ~/.local/share/fonts/terminal_fonts ]; then
    rm ~/.local/share/fonts/terminal_fonts
  fi

printf "${YELLOW}Removing ZSH configuration.${NORMAL}\n"
  if [ -f ~/.zshrc ]; then
    rm ~/.zshrc;
  fi
printf "${YELLOW}Removing Oh-My-ZSH.${NORMAL}\n"
  if [ -d ~/.config/oh-my-zsh ]; then
    rm -R -f ~/.config/oh-my-zsh;
  fi
printf "${YELLOW}Removing Base16-shell themes.${NORMAL}\n"
  if [ -d ~/.config/base16-shell ]; then
    rm -R -f ~/.config/base16-shell;
  fi
  if [ -f ~/.vimrc_background ]; then
    rm ~/.vimrc_background;
  fi
  if [ -f ~/.base16_theme ]; then
    rm ~/.base16_theme;
  fi
printf "${YELLOW}Removing tmux configuration.${NORMAL}\n"
  if [ -f ~/.tmux.conf ]; then
    rm ~/.tmux.conf;
  fi
printf "${YELLOW}Removing vim and nvim configurations.${NORMAL}\n"
  if [ -d ~/.config/nvim ]; then
    rm ~/.config/nvim
  fi
  if [ -f ~/.vimrc ]; then
    rm ~/.vimrc;
  fi
printf "${YELLOW}Removing git configuration.${NORMAL}\n"
  if [ -f ~/.gitconfig ]; then
    rm ~/.gitconfig;
  fi
  if [ -f ~/.gitignore_global ]; then
    rm ~/.gitignore_global;
  fi

printf "${BLUE}Looking for an old ZSH config...${NORMAL}\n"
  if [ -f ~/.zshrc.old ] || [ -h ~/.zshrc.old ]; then
    printf "${YELLOW}Found ~/.zshrc.old. Restoring up to ~/.zshrc${NORMAL}\n";
    mv ~/.zshrc.old ~/.zshrc;
  fi

printf "${BLUE}Looking for an old tmux config...${NORMAL}\n"
  if [ -f ~/.tmux.conf.old ] || [ -h ~/.tmux.conf.old ]; then
    printf "${YELLOW}Found ~/.tmux.conf.old.${NORMAL} ${GREEN}Restoring up to ~/.tmux.conf${NORMAL}\n";
    mv ~/.tmux.conf.old ~/.tmux.conf;
  fi

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
printf "${BLUE}Looking for an old git config...${NORMAL}\n"
  if [ -f ~/.gitconfig.old ] || [ -h ~/.gitconfig.old ]; then
    printf "${YELLOW}Found ~/.gitconfig.old.${NORMAL} ${GREEN}Restoring up to ~/.gitconfig${NORMAL}\n";
    mv ~/.gitconfig.old ~/.gitconfig;
  fi

  if [ -f ~/.gitignore_global.old ] || [ -h ~/.gitignore_global.old ]; then
    printf "${YELLOW}Found ~/.gitignore_global.old.${NORMAL} ${GREEN}Restoring up to ~/.gitignore_global${NORMAL}\n";
    mv ~/.gitignore_global.old ~/.gitignore_global;
  fi

  if [ -d ~/.local/share/nvim ]; then
    printf "${RED}"
    echo -n "Do you want to uninstalled the config data in ~/.local/share/nvim (y/n)? "
    read answer
    printf "${NORMAL}"
    if echo "$answer" | grep -iq "^y" ;then
      rm -R -f ~/.local/share/nvim
    fi
  fi

  if [ -d ~/.local/share/tmux ]; then
    printf "${RED}"
    echo -n "Do you want to uninstalled the config data in ~/.local/share/tmux (y/n)? "
    read answer
    printf "${NORMAL}"
    if echo "$answer" | grep -iq "^y" ;then
      rm -R -f ~/.local/share/tmux
    fi
  fi

printf "${GREEN}All configuration successfully uninstalled. ${NORMAL}\n"
}

main
