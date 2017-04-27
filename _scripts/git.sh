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
  hash git >/dev/null 2>&1 || {
    echo "Error: git is not installed"
    exit 1
  }
  cd ../git/
  
printf "${BLUE}Looking for an existing git config...${NORMAL}\n"
  if [ -f ~/.gitconfig ] || [ -h ~/.gitconfig ]; then
    printf "${YELLOW}Found ~/.gitconfig.${NORMAL} ${GREEN}Backing up to ~/.gitconfig.old${NORMAL}\n";
    mv ~/.gitconfig ~/.gitconfig.old;
  fi

  if [ -f ~/.gitignore_global ] || [ -h ~/.gitignore_global ]; then
    printf "${YELLOW}Found ~/.gitignore_global.${NORMAL} ${GREEN}Backing up to ~/.gitignore_global.old${NORMAL}\n";
    mv ~/.gitignore_global ~/.gitignore_global.old;
  fi

  umask g-w,o-w

  sed -i "/templatedir = */c\\# templatedir = $PWD" gitconfig.symlink

  ln -s $(pwd)/gitconfig.symlink ~/.gitconfig
  ln -s $(pwd)/gitignore_global.symlink ~/.gitignore_global

  cd $curr_dir
  
  printf "${GREEN}"
  echo 'git is now configured successfully.'
  printf "${NORMAL}"
}

main
