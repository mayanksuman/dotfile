#!/usr/bin/env bash

source ./_scripts/msg.sh

if [ $EUID -eq 0 ]; then
	error "This bash script should not be run as root. Exitting"
	exit 1
fi


action "Initializing and updating submodule(s)"
git submodule update --init --recursive
cd 'zsh/.local/share/zsh/prezto'
git submodule update --init --recursive
cd -
git submodule foreach git pull origin master --recursive
ok

info "  You need to be a sudo user for installing softwares."
info "  Please give your password if demanded."
sudo -v
# Keep-alive: update existing sudo time stamp until the script has finished
while true; 
do
	sudo -n true; sleep 60; kill -0 "$$" || exit; 
done 2>/dev/null &

action "Update the apt and installing curl"
sudo -E apt-get update && sudo -E apt-get upgrade
sudo -E apt install curl
ok

# action "Adding repository for latest nodejs and npm"
# curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
# ok

action "Installing required packages"
step "Update the apt "
sudo -E apt-get update
ok
step "Downloading and installing the packages"
# setting up environment
sudo -E apt-get install -ym zsh tmux sed xsel stow neovim direnv fonts-noto-core
# for C/C++ development
sudo -E apt-get install -ym build-essential clang clang-tools clang-tidy \
	global universal-ctags cmake ccache git
# for python 
sudo -E apt install -ym python3-pip python3-tk 
# for nodejs
sudo -E apt install -ym nodejs
# for markdown and latex
sudo -E apt-get install -ym pandoc markdown texlive dvipng \
	texlive-latex-extra texlive-formats-extra texlive-publishers composer \
	texlive-bibtex-extra biber texlive-font-utils chktex tidy odt2txt
# for english dictionary
#sudo -E apt install -ym dictd dict-gcide dict-vera dict-jargon dict-elements \
#	dict-moby-thesaurus dict
# for GIS related work
sudo -E apt install -ym proj-bin libproj-dev gdal-bin libgdal-dev python3-gdal \
	libgeos++-dev libgeos-dev
ok

step "Setting up local install paths"
mkdir -p ~/.local
mkdir -p ~/.local/{bin,share,lib,include}
sudo -E chown -R "$USER:$USER" ~/.local/lib
sudo -E chown -R "$USER:$USER" ~/.local/bin
sudo -E chown -R "$USER:$USER" ~/.local/include
sudo -E chown -R "$USER:$USER" ~/.local/share
ok

step "Installing python packages"
pip3 install --user -U cython
pip3 install --user -U numpy sympy scipy statsmodels scikit-learn dask \
	tensorflow pywavelets pandas xarray geopandas pysal pyresample pillow \
	matplotlib bokeh holoviews seaborn cartopy numba nose netcdf4 \
	tables h5py xlwt ipython jupyter ipywidgets notebook jedi psutil \
	setproctitle yamllint proselint demjson scrapy beautifulsoup4 notedown
pip3 install --user -U orange3 glueviz

# GDAL support - Install this way only if python3-GDAL fail
#pip3 install --user -U GDAL==$(gdal-config --version) --global-option=build_ext \
#	--global-option=-I/usr/include/gdal
# If cartopy cause Ipython to crash: hint: try ax.coastlines()
#pip3 install --user -U shapely cartopy --no-binary shapely --no-binary cartopy
ok

action "Configuring stow"
stow -t ~ stow
ok

action "Installing fonts"
mkdir -p ~/.local/share/fonts/
stow -t ~ fonts
ok
action "Updating font cache"
sudo fc-cache -f -v
ok

action "Configuring Bash"
stow -t ~ shell_common
# Check for source line; if it does not exist then add it in ~/.bashrc
if ! grep -qsFx 'source ~/.shell_common_config' ~/.bashrc ; then
	echo "source ~/.shell_common_config">>~/.bashrc
fi
ok
# Add direnv support in bash
if ! grep -qsFx 'eval "$(direnv hook bash)"' ~/.bashrc ; then
	echo 'eval "$(direnv hook bash)"'>>~/.bashrc
fi


# ZSH setup
action "Configuring ZSH"
step "Setting up ZSH as default shell"
# If this user's login shell is not already "zsh", attempt to switch.
TEST_CURRENT_SHELL=$(expr "$SHELL" : '.*/\(.*\)')
if [ "$TEST_CURRENT_SHELL" != "zsh" ]; then
	# check for chsh and change the shell
	if hash chsh >/dev/null 2>&1; then
		info "Please enter your password if asked."
		chsh -s "$(grep /zsh$ /etc/shells | tail -1)"
		ok
	else
		# Suggest the user do so manually.
		warning "I can't change your shell automatically"
		warning "because this system does not have chsh."
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
bash "$HOME/.local/share/tmux/plugins/tpm/scripts/install_plugins.sh"
# killing the tmux session
tmux kill-session -t "install_session"
ok
#tmux setup complete
info "tmux is configured"

action "Installing Cheatsheets/Examples"
mkdir -p ~/.local/share/eg
sudo -E chown -R "$USER:$USER" ~/.local/share/eg
stow -t ~ eg
ok

action "Configuring nvim/vim"
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

step "Enabling python support in nvim"
#pip install --user -U neovim
pip3 install --user -U neovim
ok

# step "Enabling ruby support in nvim"
# gem install --user neovim
# ok

step "Installing vim plugins"
nvim +PlugInstall +qa
nvim +GrammarousCheck +qa
ok

step "Installing Language Servers"
# Language Server for Python
pip3 install --user -U python-language-server
# Language server for javascript and typescript
# npm config set prefix $HOME
# export PATH=$HOME/node_modules/.bin:$PATH
# npm install -g javascript-typescript-langserver
# Language server for PHP is installed by vim during plugin install
ok
info "nvim/vim configuration is complete"

step "Applying base16 brewer theme"
bash -lic base16_brewer
ok

action "Configuring git"
gituser_info_file=git/.config/git/.gituser_info.secret
if [ -f "$gituser_info_file" ] || [ -h "$gituser_info_file" ]; then
info "git user info file is found. The contents are"
cat "$gituser_info_file"
info "If you want to change, then please edit $(pwd)/$gituser_info_file file."
else
input "Enter your name as git user"
read -r username
input "Enter your e-mail address as git user"
read -r email
input "Enter your github username (if any; if you do not have leave it blank)"
read -r github_username
cp git/.config/git/.gituser_info.secret.example "$gituser_info_file"
sed -i "s/\\[USER_NAME\\]/$username/g" "$gituser_info_file"
sed -i "s/\\[E_MAIL_ID\\]/$email/g" "$gituser_info_file"
sed -i "s/\\[GITHUB_USER\\]/$github_username/g" "$gituser_info_file"
fi
stow -t ~ git
ok

action "Increasing C/C++ compilation cache to 32G"
ccache --max-size 32G
ok

info "Installation Complete."
info "Post Installation manual configuration"
info "  The theme can be changed by issueing base16_* command in ZSH or BASH."
info "  The default font for the terminal can be changed to"
info "  RobotoMono Nerd Medium."
info "You can uninstall all vim package and use neovim entirely."
info "Use update-alternatives for that."
