#!/usr/bin/env bash


echo " Install dotfiles ..."

echo "Initializing submodule(s) ..."
git submodule update --init --recursive

echo "  You need to be a sudo user for installing softwares."
echo "  Please give your password if demanded."
sudo -v
# Keep-alive: update existing sudo time stamp until the script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo " Adding repository for latest nodejs and npm"
curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -

echo "Installing required packages ..."
sudo -E apt update
sudo -E apt install -y build-essential exuberant-ctags cmake python-pip \
	python3-pip nodejs git zsh tmux markdown pandoc sed xsel\
	silversearcher-ag pandoc \
	neovim python-neovim python3-neovim stow

echo "Setting up stow"
stow -t ~ stow

echo "Installing fonts ..."
stow terminal_fonts

echo "Setting up git"
stow git

echo "Setting up shell configuration ..."
stow shell_common
echo "source $(pwd)/shell_common_config">>~/.bashrc

printf "Looking for an existing zsh config...\n"
  if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]; then
    printf "Found ~/.zshrc. Backing up to ~/.zshrc.old\n";
    mv ~/.zshrc ~/.zshrc.old;
  fi
stow zsh

  # If this user's login shell is not already "zsh", attempt to switch.
  TEST_CURRENT_SHELL=$(expr "$SHELL" : '.*/\(.*\)')
  if [ "$TEST_CURRENT_SHELL" != "zsh" ]; then
    # If this platform provides a "chsh" command (not Cygwin), do it, man!
    if hash chsh >/dev/null 2>&1; then
      printf "${BLUE}Time to change your default shell to zsh! Please enter your password.${NORMAL}\n"
      chsh -s $(grep /zsh$ /etc/shells | tail -1)
    # Else, suggest the user do so manually.
    else
      printf "I can't change your shell automatically because this system does not have chsh.\n"
      printf "${BLUE}Please manually change your default shell to zsh!${NORMAL}\n"
    fi
  fi

stow tmux
# Installing the tmux plugins
  # Tip from https://github.com/tmux-plugins/tpm/issues/6
  # start a server but don't attach to it
  tmux start-server
  # create a new session but don't attach to it either
  tmux new-session -d
  # install the plugins
  bash $TPM_DIR/scripts/install_plugins.sh
  # killing the server is not required, I guess
  tmux kill-server
  #All installation steps complete
  printf "${GREEN}tmux setup is now complete.${NORMAL}\n"

echo "Setting up nvim/vim configurations ..."
printf "${BLUE}Enabling python support in nvim...${NORMAL}\n"
  sudo -E pip2 install --user neovim
  sudo -E pip3 install --user neovim

  printf "${BLUE}Looking for an existing nvim config...${NORMAL}\n"
  if [ -d ~/.config/nvim ]; then
    printf "${YELLOW}Found ~/.config/nvim.${NORMAL} ${GREEN}Backing up to ~/.config/nvim.old${NORMAL}\n";
    mv ~/.config/nvim ~/.config/nvim.old;
  fi
  cd ..
printf "${BLUE}Looking for an existing vim config...${NORMAL}\n"
  if [ -f ~/.vimrc ] || [ -h ~/.vimrc ]; then
    printf "${YELLOW}Found ~/.vimrc.${NORMAL} ${GREEN}Backing up to ~/.vimrc.old${NORMAL}\n";
    mv ~/.vimrc ~/.vimrc.old;
  fi
stow nvim
vim +PlugInstall +qa

#Applying base16 brewer theme
bash -lic base16_brewer

echo "Installation Complete."
echo "Post Installation manual configuration"
echo " The theme can be changed by issueing base16_* command in ZSH or BASH."
