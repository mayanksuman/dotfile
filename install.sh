#!/usr/bin/env bash

source ./_scripts/msg.sh

action "Initializing submodule(s)"
git submodule update --init --recursive

info "  You need to be a sudo user for installing softwares."
info "  Please give your password if demanded."
sudo -v
# Keep-alive: update existing sudo time stamp until the script has finished
while true; 
do
	sudo -n true; sleep 60; kill -0 "$$" || exit; 
done 2>/dev/null &

action "Adding repository for latest nodejs and npm"
curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
ok

action "Installing required packages"
step "Update the apt "
sudo -E apt-get update
ok
step "Downloading and installing the packages"
sudo -E apt-get install -ym build-essential exuberant-ctags cmake python-pip \
	python3-pip nodejs git zsh tmux markdown pandoc sed xsel\
	silversearcher-ag pandoc stow \
	neovim 
ok

action "Configuring stow"
stow -t ~ stow
ok

action "Installing fonts"
stow -t ~ terminal_fonts
ok

action "Configuring git"
stow -t ~ git
ok

action "Configuring Bash"
stow -t ~ shell_common
echo "source ~/.shell_common_config">>~/.bashrc
ok

# ZSH setup
action "Configuring ZSH"
step "Setting up ZSH as default shell"
# If this user's login shell is not already "zsh", attempt to switch.
TEST_CURRENT_SHELL=$(expr "$SHELL" : '.*/\(.*\)')
if [ "$TEST_CURRENT_SHELL" != "zsh" ]; then
	# check for chsh and change the shell
	if hash chsh >/dev/null 2>&1; then
		info "Please enter your password if asked."
		chsh -s $(grep /zsh$ /etc/shells | tail -1)
		ok
		# Else, suggest the user do so manually.
	else
		warning "I can't change your shell automatically because this system does not have chsh."
		info "Please manually change your default shell to zsh!"
	fi
fi
# Check for old ZSH config
step "setting up ZSH configuration; Backing up existing config if present"
if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]; then
	info "Found ~/.zshrc. Backing up to ~/.zshrc.old";
	mv ~/.zshrc ~/.zshrc.old;
fi
stow -t ~ zsh
ok
info "ZSH configuration complete."
# ZSH setup complete

action "Configuring tmux"
step "Setting up tmux configuration; Backing up existing config if present"
if [ -f ~/.tmux.conf ] || [ -h ~/.tmux.conf ]; then
	info "Found ~/.tmux.conf. Backing up to ~/.tmux.conf.old";
	mv ~/.tmux.conf ~/.tmux.conf.old;
fi
stow -t ~ tmux
ok

step "Installing the tmux plugins"
# Tip from https://github.com/tmux-plugins/tpm/issues/6
# start a server but don't attach to it
tmux start-server
# create a new session but don't attach to it either
tmux new-session -d
# install the plugins
bash $HOME/.local/share/tmux/plugins/tpm/scripts/install_plugins.sh
# killing the tmux server
tmux kill-server
ok
#tmux setup complete
info "tmux is configured"

action "Configuring nvim/vim"
step "Looking for an existing nvim config; Backing Up if it exists."
if [ -d ~/.config/nvim ]; then
	info "Found ~/.config/nvim. Backing up to ~/.config/nvim.old";
	mv ~/.config/nvim ~/.config/nvim.old;
fi
ok

step "Looking for an existing vim config; Backing Up if it exists."
if [ -f ~/.vimrc ] || [ -h ~/.vimrc ]; then
	info "Found ~/.vimrc. Backing up to ~/.vimrc.old";
	mv ~/.vimrc ~/.vimrc.old;
fi
ok

step "Setting up new nvim/vim configuration"
stow -t ~ nvim
ok

step "Installing vim plugins"
vim +PlugInstall +qa
ok

step "Enabling python support in nvim"
sudo -E pip2 install --user neovim
sudo -E pip3 install --user neovim
ok
info "nvim/vim configuration is complete"

step "Applying base16 brewer theme"
bash -lic base16_brewer
ok

info "Installation Complete."
info "Post Installation manual configuration"
info " The theme can be changed by issueing base16_* command in ZSH or BASH."
