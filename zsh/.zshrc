#
# ~/.zshrc
#
zmodload zsh/zprof

# If not running interactively, don't do anything
case $- in
	*i*) ;;
	  *) return;;
esac

# Load prezto before .shell_common_config (speed optimization)
source "$HOME/.local/share/zsh/prezto/init.zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Easy cd-ing
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

# Enable Async autosuggest
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# History Options:
# Tip: Command starting with space will not be included in history
setopt incappendhistory        # Write to the history file immediately, not when the shell exits.
setopt histreduceblanks        # Remove superfluous blanks before recording entry.

source "$HOME/.shell_common_config"
