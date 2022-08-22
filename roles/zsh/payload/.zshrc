#
# ~/.zshrc
#
#zmodload zsh/zprof

# If not running interactively, don't do anything
case $- in
	*i*) ;;
	  *) return;;
esac

# Enable Async autosuggest
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=200

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# load prezto
source "$HOME/.local/share/zsh/prezto/init.zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -n "$PS1" ] && source "$HOME/.shell_common_config"

if [ -e /home/mayank/.nix-profile/etc/profile.d/nix.sh ]; then . /home/mayank/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
