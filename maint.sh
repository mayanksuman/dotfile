#!/usr/bin/env bash

source ./_scripts/msg.sh

if [ $EUID -eq 0 ]; then
	error "This bash script should not be run as root. Exitting"
	exit 1
fi


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

action "Restow links"
stow -t ~ -R stow
stow -t ~ -R shell_common
stow -t ~ -R fonts
stow -t ~ -R tmux
stow -t ~ -R zsh
stow -t ~ -R nvim
stow -t ~ -R git
ok

action "Updating font cache"
sudo fc-cache -f -v
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

step "Updating neovim plugin"
if [ "$(ls -A ~/.local/share/nvim/plugged/vim-grammarous/misc)" ]; then
	echo "If you are facing problem with spell check in vim"
	echo "Delete the old languagetools"
	rm -iRf ~/.local/share/nvim/plugged/vim-grammarous/misc
fi
nvim +PlugClean +PlugInstall +UpdateRemotePlugins +PlugUpdate +qa
nvim +GrammarousCheck +qa

cd ~/.local/share/nvim/plugged/LanguageClient-neovim/
rm -f bin/languageclient
bash install.sh
cd -
ok

info "Maintainance Complete."
