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
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# load prezto
source "$HOME/.local/share/zsh/prezto/init.zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source "$HOME/.shell_common_config"
