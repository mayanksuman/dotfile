#!/usr/bin/env bash

source ./_scripts/msg.sh

action "Initializing submodule(s)"
git submodule update --init --recursive
ok

info "  You need to be a sudo user for installing softwares."
info "  Please give your password if demanded."
sudo -v
# Keep-alive: update existing sudo time stamp until the script has finished
while true; 
do
	sudo -n true; sleep 60; kill -0 "$$" || exit; 
done 2>/dev/null &

action "Adding repository for latest nodejs and npm"
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
ok

action "Installing required packages"
step "Update the apt "
sudo -E apt-get update
ok
step "Downloading and installing the packages"
sudo -E apt-get install -ym build-essential exuberant-ctags cmake ccache \
	python-pip python3-pip python3-tk nodejs git zsh tmux markdown pandoc \
	sed xsel silversearcher-ag pandoc stow vim-gnome fonts-noto-hinted \
	neovim texlive texlive-latex-extra texlive-formats-extra \
	texlive-pulishers texlive-bibtex-extra biber texlive-font-utils \
	dvipng
ok

step "Installing python packages"
sudo -E chown -R $USER:$USER ~/local/lib
sudo -E chown -R $USER:$USER ~/local/include
sudo -E chown -R $USER:$USER ~/local/bin
sudo -E chown -R $USER:$USER ~/local/share
pip3 install numpy sympy scipy pandas matplotlib bokeh holoviews jupyter statsmodels\
	ipywidgets numba cython ipython nose scikit-learn h5py notebook tensorflow \
	xarray tables
ok


action "Configuring stow"
stow -t ~ -D stow
stow -t ~ stow
ok

action "Installing fonts"
mkdir -p ~/.local/share/fonts/
stow -t ~ -D fonts
stow -t ~ fonts
ok
action "Updating font cache"
sudo fc-cache -f -v
ok

action "Configuring Bash"
stow -t ~ -D shell_common
stow -t ~ shell_common
# Check for source line; if it does not exist then add it in ~/.bashrc
if ! grep -qsFx 'source ~/.shell_common_config' ~/.bashrc ; then
  echo "source ~/.shell_common_config">>~/.bashrc
fi
ok

# ZSH setup
action "Configuring ZSH"
stow -t ~ -D zsh
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
step "Looking for an existing zsh config"
if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]; then
	info "Found ~/.zshrc. Backing up to ~/.zshrc.old";
	mv ~/.zshrc ~/.zshrc.old;
else
info "No existing zsh config found";
fi
ok
step "setting up new ZSH configuration"
stow -t ~ zsh
ok
info "ZSH configuration complete."
# ZSH setup complete

action "Configuring tmux"
stow -t ~ -D tmux
step "Looking for an existing tmux config"
if [ -f ~/.tmux.conf ] || [ -h ~/.tmux.conf ]; then
	info "Found ~/.tmux.conf. Backing up to ~/.tmux.conf.old";
	mv ~/.tmux.conf ~/.tmux.conf.old;
else
info "No existing tmux config found";
fi
ok
step "Setting up new tmux configuration"
stow -t ~ tmux
ok

step "Installing the tmux plugins"
# Tip from https://github.com/tmux-plugins/tpm/issues/6
# start a server but don't attach to it
tmux start-server
# create a new session but don't attach to it either
tmux new-session -d -s "install_session"
# install the plugins
bash $HOME/.local/share/tmux/plugins/tpm/scripts/install_plugins.sh
# killing the tmux session
tmux kill-session -t "install_session"
ok
#tmux setup complete
info "tmux is configured"

action "Configuring nvim/vim"
stow -t ~ -D nvim
step "Looking for an existing nvim config"
if [ -d ~/.config/nvim ]; then
	info "Found ~/.config/nvim. Backing up to ~/.config/nvim.old";
	mv ~/.config/nvim ~/.config/nvim.old;
else
info "No existing nvim config found";
fi
ok

step "Looking for an existing vim config"
if [ -f ~/.vimrc ] || [ -h ~/.vimrc ]; then
	info "Found ~/.vimrc. Backing up to ~/.vimrc.old";
	mv ~/.vimrc ~/.vimrc.old;
else
info "No existing vim config found";
fi
ok

step "Setting up new nvim/vim configuration"
stow -t ~ nvim
ok

step "Installing vim plugins"
vim +PlugInstall +qa
vim +GrammarousCheck +qa
ok

step "Enabling python support in nvim"
sudo -E pip2 install --user neovim
sudo -E pip3 install --user neovim
ok
info "nvim/vim configuration is complete"

step "Applying base16 brewer theme"
bash -lic base16_brewer
ok

action "Configuring git"
stow -t ~ -D git
if [ -f git/.config/git/.gituser_info.sec ] || [ -h git/.config/git/.gituser_info.sec ]; then
info "git user info file is found. The contents are"
cat git/.config/git/.gituser_info.sec
info "If you want to change, then please edit $(pwd)/git/.gituser_info.sec file."
else
input "Enter your name as git user"
read username
input "Enter your e-mail address as git user"
read email
input "Enter your github username (if any; if you do not have leave it blank)"
read github_username
cp git/.config/git/.gituser_info.sec.example git/.config/git/.gituser_info.sec
sed -i "s/\[USER_NAME\]/$username/g" git/.config/git/.gituser_info.sec
sed -i "s/\[E_MAIL_ID\]/$email/g" git/.config/git/.gituser_info.sec
sed -i "s/\[GITHUB_USER\]/$github_username/g" git/.config/git/.gituser_info.sec
fi
stow -t ~ git
ok

action "Increasing C/C++ compilation cache to 32G"
ccache --max-size 32G
ok

info "Installation Complete."
info "Post Installation manual configuration"
info " The theme can be changed by issueing base16_* command in ZSH or BASH."
