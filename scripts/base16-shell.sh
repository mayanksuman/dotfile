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

  CHECK_ZSH_INSTALLED=$(grep /zsh$ /etc/shells | wc -l)
  if [ ! $CHECK_ZSH_INSTALLED -ge 1 ]; then
    printf "${YELLOW}Zsh is not installed!${NORMAL} Please install zsh first!\n"
    exit
  fi
  unset CHECK_ZSH_INSTALLED

  if [ ! -n "$BASE16_ZSH" ]; then
    curr_dir=$PWD
    cd $HOME
    BASE16_ZSH="$(pwd)/.config/base16-shell"
    echo "Base16-Shell is going to be installed in $BASE16_ZSH ." 
    cd $curr_dir
  fi

  if [ -d "$BASE16_ZSH" ]; then
    printf "${YELLOW}You already have Base16-Shell for zsh installed.${NORMAL}\n"
    printf "You'll need to remove $BASE16_ZSH if you want to re-install.\n"
    exit
  fi

  # Prevent the cloned repository from having insecure permissions. Failing to do
  # so causes compinit() calls to fail with "command not found: compdef" errors
  # for users with insecure umasks (e.g., "002", allowing group writability). Note
  # that this will be ignored under Cygwin by default, as Windows ACLs take
  # precedence over umasks except for filesystems mounted with option "noacl".
  umask g-w,o-w

  printf "${BLUE}Cloning Base16-Shell...${NORMAL}\n"
  hash git >/dev/null 2>&1 || {
    echo "Error: git is not installed"
    exit 1
  }
  # The Windows (MSYS) Git is not compatible with normal use on cygwin
  if [ "$OSTYPE" = cygwin ]; then
    if git --version | grep msysgit > /dev/null; then
      echo "Error: Windows/MSYS Git is not supported on Cygwin"
      echo "Error: Make sure the Cygwin git package is installed and is first on the path"
      exit 1
    fi
  fi

  mkdir -p $BASE16_ZSH
  env git clone --depth=1 https://github.com/chriskempson/base16-shell.git $BASE16_ZSH || {
    printf "Error: git clone of Base16-Shell repo failed\n"
    exit 1
  }
  
  printf "${GREEN}"
  echo ' ____    _    ____  _____ _  __            ____  _          _ _ '
  echo '| __ )  / \  / ___|| ____/ |/ /_          / ___|| |__   ___| | |'
  echo '|  _ \ / _ \ \___ \|  _| | | '_ \   ____  \___ \| '_ \ / _ \ | |'
  echo '| |_) / ___ \ ___) | |___| | (_) | |____|  ___) | | | |  __/ | |'
  echo '|____/_/   \_\____/|_____|_|\___/         |____/|_| |_|\___|_|_|  .... is now installed.'
  echo ''
  echo ''
  printf "${NORMAL}"
  env zsh
  base16_brewer
}

main
