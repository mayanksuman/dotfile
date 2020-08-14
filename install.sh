#!/usr/bin/env bash

. ./_scripts/msg.sh
PYTHON_VERSION=3.8.5;	# default pthon version installed by pyenv

if [ "$(id -u)" = 0 ]; then
	error "This script should not be run as root. Exitting"
	exit 1
fi

is_config_file_present(){
	argAry1=("${!1}")
	for item in ${argAry1[*]}
	do
		if ! { [ -f "$item" ] || [ -h "$item" ]; }; then
			false
			return
		fi
	done
	true
}

action "Configuring user"
gituser_info_file=git/.config/git/.gituser_info.secret
cookiecutter_config_file=python/cookiecutter/.config/cookiecutter/cookiecutterrc.secret
user_config_files=("$gituser_info_file" "$cookiecutter_config_file")
if is_config_file_present user_config_files[@]; then
	info "User configiruation are already set in following files."
	for item in ${user_config_files[*]}; do
		disp_file "$item"
	done
	info "If you want to change them, then please edit the respective file."
else
	input "Enter your name" username
	input "Enter your e-mail address" email
	input "Enter your github username (if any; Otherwise leave blank)" \
		github_username
	
	info "Writing configuration file"
	for item in ${user_config_files[*]}; do
		cp "$item".example "$item"
		sed -i "s/\\[USER_NAME\\]/$username/g" "$item"
		sed -i "s/\\[E_MAIL_ID\\]/$email/g" "$item"
		sed -i "s/\\[GITHUB_USER\\]/$github_username/g" "$item"
		echo "$item"
	done
fi
ok

info "  You need to be a sudo user for installing softwares."
info "  Please give your password if demanded."
sudo -v
# Keep-alive: update existing sudo time stamp until the script has finished
while true; 
do
	sudo -n true; sleep 60; kill -0 "$$" || exit; 
done 2>/dev/null &

action "Initializing and updating submodule(s)"
step "Installing git"
sudo -E apt-get update && sudo -E apt-get install -ym git
git submodule update --init --recursive
cd 'zsh/.local/share/zsh/prezto' || exit
git submodule update --init --recursive
cd - || exit
git submodule foreach git pull origin master
ok

action "Installing required packages"
step "Upgrading the system softwares"
sudo -E apt-get update && sudo -E apt-get upgrade -ym
ok

step "Installing download managers"
sudo -E apt-get install -ym curl aria2
ok

step "Downloading and installing the required packages"
# setting up environment
sudo -E apt-get install -ym zsh tmux sed xsel stow neovim direnv
# for C/C++ development
sudo -E apt-get install -ym build-essential clang clang-tools clang-tidy \
	global exuberant-ctags cmake ccache
# for python (pip3 and pipenv)
sudo -E apt-get install -ym python3-pip pipenv
# for python and indic support in libreoffice
sudo -E apt-get install -ym libreoffice-script-provider-python hunspell-hi \
	libreoffice-l10n-in
# for markdown, latex and other text utilities
sudo -E apt-get install -ym pandoc markdown texlive dvipng texlive-luatex \
	texlive-latex-extra texlive-formats-extra texlive-publishers \
	texlive-science texworks texlive-bibtex-extra biber texlive-font-utils \
	chktex tidy odt2txt dos2unix
# some utilities
sudo -E apt-get install -ym youtube-dl
# for php composer framework
sudo -E apt-get install -ym composer
# for common truetype font
sudo -E apt-get install -ym ttf-mscorefonts-installer
# Install plain noto and hack fonts
sudo -E apt-get install -ym fonts-noto-core fonts-hack
# for english dictionary
sudo -E apt-get install -ym sdcv
#sudo -E apt-get install -ym dictd dict-gcide dict-vera dict-jargon \
#	dict-elements dict-moby-thesaurus dict
# for docker
sudo -E apt-get install -ym docker.io docker-compose
# for GIS related work
sudo -E apt-get install -ym proj-bin libproj-dev gdal-bin libgdal-dev python3-gdal \
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

step "Installing python programmes for system python"
# Note: This file also setup pyenv. The idea is package that provide cli/gui 
# entry points and are needed by user software like neovim is installed 
# outside pyenv, so they are available no matter which pyenv environment 
# is active.
#
# However, these package cannot be imported in python running under pyenv as 
# pyenv python do not have ~/.local/lib/python3.x in the path.
SYSPIP=/usr/bin/pip
SYSPIP3=/usr/bin/pip3
$SYSPIP3 install --user -U youtube-dl autopep8 black colorama cookiecutter \
		proselint yamllint nose pytest jedi psutil setproctitle demjson \
		pygments odfpy python-language-server virtualenvwrapper
$SYSPIP install --user -U virtualenvwrapper
ok

action "Configuring stow"
stow -t ~ -R stow
ok

action "Configuring gdb"
stow -t ~ -R gdb
ok

action "Installing fonts"
mkdir -p ~/.local/share/fonts/
stow -t ~ -R fonts
ok
step "Updating font cache"
sudo fc-cache -f -v
ok

action "Setting up nodejs and npm for javascript/typescript development"
# for nodejs and javascript/typescript development
#curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -
sudo -E apt-get install -ym nodejs npm
mkdir -p "$HOME/.npm_packages"
sudo -E chown -R "$USER:$USER" "$HOME/.npm_packages"
stow -t ~ -R nodejs
export PATH=$HOME/.npm_packages/bin:$PATH
npm install -g typescript javascript-typescript-langserver
ok

action "Configuring Bash"
stow -t ~ -R shell_common
# Check for source line; if it does not exist then add it in ~/.bashrc
comm_shell_line='[ -z "$PS1" ] && echo "" || source "$HOME/.shell_common_config"'
if ! grep -qsFx "$comm_shell_line" ~/.bashrc ; then
	echo "$comm_shell_line">>~/.bashrc
fi
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
bash -i "$HOME/.local/share/tmux/plugins/tpm/scripts/install_plugins.sh"
# killing the tmux session
tmux kill-session -t "install_session"
ok
#tmux setup complete
info "tmux is configured"

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

#step "Enabling python support in nvim and its plugins"
$SYSPIP install --user -U pynvim
$SYSPIP3 install --user -U pynvim notedown neovim-remote

# step "Enabling node.js support in nvim"
# npm install -g neovim
# ok

# step "Enabling ruby support in nvim"
# gem install --user neovim
# ok

step "Installing vim plugins"
nvim +PlugInstall +PlugUpdate +UpdateRemotePlugins +PlugUpgrade +PlugClean +qa
ok

step "Installing Language Servers"
# Nothing to do here
## Language Server for Python is already installed using $SYSPIP3
## Language server for javascript and typescript is installed using npm
## Language server for PHP is installed by neovim during plugin install
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
		cd ~/.local/share/nvim/plugged/LanguageClient-neovim/ || exit
		rm -f bin/languageclient
		bash -i install.sh
		cd - || exit
	fi
else
	info "No grammar check problem as per user."
fi
ok
info "nvim/vim configuration is complete"

action "Configuring git"
stow -t ~ -R git
ok

action "Setting up pyenv"
step "Installing prerequisite"
sudo -E apt-get install -ym make build-essential libssl-dev zlib1g-dev \
	libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
	libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python3-openssl git
ok

step "Setting up conda environment"
cd ~/.dotfile/python || exit
stow -t ~ -R conda
cd - || exit
ok

step "Installing/updating pyenv"
if which pyenv > /dev/null; then
	pyenv update
else
	curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
	source "$HOME/.shell_common_config"
fi
ok

step "Installing python $PYTHON_VERSION and miniconda3-latest in pyenv"
pyenv install "$PYTHON_VERSION"
pyenv install miniconda3-latest
ok

step "Setting up jupyterlab in miniconda3-latest virtualenv tools"
pyenv virtualenv miniconda3-latest jupyter
# This virtulenv should be moved to system python but the package that is 
# stopping this nb_conda_kernels. Once built in kernelspec for jupyter is 
# completed, the virtualenv may be moved to system python.
# Note: Important nodejs is required for jupyter now.
pyenv activate jupyter
conda install -y jupyter jupyterlab ipython ipywidgets ipyleaflet ipympl \
		  ipykernel nb_conda_kernels scipy
#conda install -y jupyterlab-git jupyterlab_code_formatter
#jupyter-labextension install @jupyterlab/toc @jupyterlab/geojson-extension \
#                        jupyterlab-spreadsheet @krassowski/jupyterlab_go_to_definition \
#                        @ryantam626/jupyterlab_code_formatter;
#pip install jupyterlab_sql
#jupyter serverextension enable jupyterlab_sql --py --sys-prefix
#jupyter lab build
conda clean -y --all
python -m ipykernel install --user
pyenv deactivate
ok

step "Setting up numerical/data science tools in miniconda3-latest"
pyenv virtualenv miniconda3-latest conda_tools
pyenv activate conda_tools
conda install -y python==3.7.3;			# Last tested python with Orange3
conda install -y orange3 glueviz;
conda clean -y --all
pyenv deactivate
ok

step "Setting up general scientific python virtualenv from miniconda3-latest"
pyenv virtualenv miniconda3-latest num_python
pyenv activate num_python
conda install -y numpy scipy statsmodels pandas xarray \
		geopandas matplotlib cartopy h5py netcdf4 dask \
		bottleneck seaborn xlwt ipykernel
conda clean -y --all
pyenv deactivate
ok

step "Setting up the default python version and tools binary in pyenv"
pyenv global "$PYTHON_VERSION" jupyter conda_tools
ok

step "Configuring python modules"
cd python || exit
mkdir -p ~/.config/jupyter/lab/
sudo -E chown -R "$USER:$USER" ~/.config/jupyter/lab
# For installing Cheatsheets/Examples
mkdir -p ~/.local/share/eg
sudo -E chown -R "$USER:$USER" ~/.local/share/eg
for dir in ./*
do
	stow -t ~ -R "${dir:2}"
done
cd - || exit
ok

step "Indexing the cheatsheets/Examples"
bash -ic "source ~/.shell_common_config;eg -r; exit"
ok

step "Applying base16 brewer theme"
bash -ic "source ~/.shell_common_config;base16_brewer < /dev/null; exit"
ok

action "Increasing C/C++ compilation cache to 32G"
ccache --max-size 32G
ok

info "Installation Complete."
info "Post Installation manual configuration"
info "  The theme can be changed by issueing base16_* command in ZSH or BASH."
info "  The default font for the terminal can be changed to Hack."
info "You can uninstall all vim package and use neovim entirely."
info "Use update-alternatives for that."
