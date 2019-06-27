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

action "Installing required packages"
step "Upgrading the system softwares"
sudo -E apt-get update && sudo -E apt-get upgrade -ym
ok

step "Installing download managers"
sudo -E apt-get install -ym curl aria2
ok

step "Downloading and installing the required packages"
# setting up environment
sudo -E apt-get install -ym zsh tmux sed xsel stow neovim direnv fonts-noto-core
# for C/C++ development
sudo -E apt-get install -ym build-essential clang clang-tools clang-tidy \
	global universal-ctags cmake ccache git
# for python (pip3)
sudo -E apt-get install -ym python3-pip
# for markdown, latex and other text utilities
sudo -E apt-get install -ym pandoc markdown texlive dvipng texlive-luatex \
	texlive-latex-extra texlive-formats-extra texlive-publishers \
	texlive-science texworks texlive-bibtex-extra biber texlive-font-utils \
	chktex tidy odt2txt dos2unix
# for php composer framework
sudo -E apt-get install -ym composer
# for common truetype font
sudo -E apt-get install -ym ttf-mscorefonts-installer
# for english dictionary
#sudo -E apt install -ym dictd dict-gcide dict-vera dict-jargon dict-elements \
#	dict-moby-thesaurus dict
# for GIS related work
sudo -E apt install -ym proj-bin libproj-dev gdal-bin libgdal-dev python3-gdal \
	libgeos++-dev libgeos-dev
ok

step "Removing unnecessary packages"
sudo -E apt-get autoremove -ym
sudo -E apt-get autoclean -ym
sudo -E apt-get clean -ym
ok

step "Setting up local install paths"
mkdir -p ~/.local
mkdir -p ~/.local/{bin,share,lib,include}
sudo -E chown -R "$USER:$USER" ~/.local/lib
sudo -E chown -R "$USER:$USER" ~/.local/bin
sudo -E chown -R "$USER:$USER" ~/.local/include
sudo -E chown -R "$USER:$USER" ~/.local/share
ok

step "Installing python packages for system python"
# Note: This file also setup miniconda. The idea is non-data science package 
# that is needed by user doftware like neovim is installed outside miniconda,
# so they are available does not matter which conda environment is active.
#
# Further, these package can be also import in miniconda as miniconda python 
# has ~/.local/lib/python3.x in the path. Beware the libraries installed in 
# ~/.local/lib/python3.x has higher preference in minconda so do not install 
# any data science packages in ~/.local/lib/python3.x, otherwise sub-optimal
# performance in data science workload might be observed.
SYSPIP=/usr/bin/pip
SYSPIP3=/usr/bin/pip3
$SYSPIP3 install --user -U proselint yamllint nose pytest jedi psutil \
	setproctitle demjson ipython tqdm
ok

step "Setting up python environment"
cd python
for dir in ./*
do
	stow -t ~ -R ${dir:2}
done
cd -
ok

action "Configuring stow"
stow -t ~ -R stow
ok

action "Installing fonts"
mkdir -p ~/.local/share/fonts/
stow -t ~ -R fonts
ok
action "Updating font cache"
sudo fc-cache -f -v
ok

action "Configuring Bash"
stow -t ~ -R shell_common
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
stow -t ~ -D zsh
if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]; then
	info "Found ~/.zshrc. Backing up to ~/.zshrc.old";
	mv ~/.zshrc ~/.zshrc.old;
else
	info "No existing zsh config found";
fi
ok

step "setting up new ZSH configuration"
stow -t ~ -R zsh
ok
info "ZSH configuration complete."
# ZSH setup complete

action "Configuring tmux"
step "Looking for an existing tmux config"
stow -t ~ -D tmux
if [ -f ~/.tmux.conf ] || [ -h ~/.tmux.conf ]; then
	info "Found ~/.tmux.conf. Backing up to ~/.tmux.conf.old";
	mv ~/.tmux.conf ~/.tmux.conf.old;
else
info "No existing tmux config found";
fi
ok
step "Setting up new tmux configuration"
stow -t ~ -R tmux
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
stow -t ~ -R eg
ok

action "Configuring nvim/vim"
step "Looking for an existing nvim config"
stow -t ~ -D nvim
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
stow -t ~ -R nvim
ok

step "Enabling python support in nvim"
#pip install --user -U neovim
$SYSPIP install --user -U pynvim
$SYSPIP3 install --user -U pynvim

# Required by ncm2-ultisnips
$SYSPIP3 install --user -U notedown
# Required by vimtex
$SYSPIP3 install --user -U neovim-remote
ok

# step "Enabling ruby support in nvim"
# gem install --user neovim
# ok

step "Installing vim plugins"
nvim +PlugInstall +PlugUpdate +UpdateRemotePlugins +PlugUpgrade +PlugClean +qa
ok

step "Installing Language Servers"
# Language Server for Python
$SYSPIP3 install --user -U python-language-server
## Language server for javascript and typescript
## install nodejs
#sudo -E apt install -ym nodejs
# npm config set prefix $HOME
# export PATH=$HOME/node_modules/.bin:$PATH
# npm install -g javascript-typescript-langserver
## Language server for PHP is installed by vim during plugin install
ok

step "Fixing spell check in vim if any"
read -p "Do you face any problem for grammar check in vim?(Y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
	if [ "$(ls -A ~/.local/share/nvim/plugged/vim-grammarous/misc)" ]; then
		echo "If you are facing problem with spell check in vim"
		echo "Delete the old languagetools"
		rm -iRf ~/.local/share/nvim/plugged/vim-grammarous/misc
		nvim +GrammarousCheck +qa
		cd ~/.local/share/nvim/plugged/LanguageClient-neovim/
		rm -f bin/languageclient
		bash install.sh
		cd -
	fi
else
	info "No grammar check problem as per user."
fi
ok
info "nvim/vim configuration is complete"

action "Setting up miniconda3 environment"
read -p "Do you want to setup miniconda3?(Y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
	step "Installing/updating miniconda3 in $HOME/.miniconda3"
	curl https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh --output ~/miniconda3.sh
	chmod +x ~/miniconda3.sh
	mkdir -p ~/.miniconda3
	bash ~/miniconda3.sh -b -u -p ~/.miniconda3
	rm -f ~/miniconda3.sh
	ok

	step "Setting up conda and base environment"
	stow -t ~ -R conda
	bash -ic "conda activate;conda install -y numpy scipy statsmodels pandas \
		xarray geopandas matplotlib cartopy ipython jupyter ipywidgets \
		notebook nb_conda_kernels ipykernel jupyter_contrib_nbextensions \
		jupyterlab h5py netcdf4 orange3 glueviz bottleneck seaborn xlwt"
	ok
	info "Setting miniconda3 environment is complete"
else
	info "User opted to not set up miniconda3."
fi

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
stow -t ~ -R git
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
