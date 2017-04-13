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

  curr_dir=$PWD
  printf "${BLUE}Enabling python support in nvim...${NORMAL}\n"
  sudo -E pip2 install --user neovim
  sudo -E pip3 install --user neovim

  printf "${BLUE}Looking for an existing nvim config...${NORMAL}\n"
  if [ -d ~/.config/nvim ]; then
    printf "${YELLOW}Found ~/.config/nvim.${NORMAL} ${GREEN}Backing up to ~/.config/nvim.old${NORMAL}\n";
    mv ~/.config/nvim ~/.config/nvim.old;
  fi
  cd ..
ln -s $(pwd)/nvim ~/.config/nvim
  sed -i "/let g:config_file_location='*'/c\\let g:config_file_location='$PWD/nvim/'" nvim/init.vim
  sed -i "/let g:runtime_data_location='*'/c\\let g:runtime_data_location='$HOME/.local/share/nvim/'" nvim/init.vim
  

  printf "${BLUE}Looking for an existing vim config...${NORMAL}\n"
  if [ -f ~/.vimrc ] || [ -h ~/.vimrc ]; then
    printf "${YELLOW}Found ~/.vimrc.${NORMAL} ${GREEN}Backing up to ~/.vimrc.old${NORMAL}\n";
    mv ~/.vimrc ~/.vimrc.old;
  fi
  ln -s ~/.config/nvim/init.vim ~/.vimrc
  cd $curr_dir
  nvim +PlugInstall +qa
  # vim +PlugInstall +qa
  echo "nvim config is now installed"
}

main
