#
# ~/.zshrc
#
#zmodload zsh/zprof

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

source "$HOME/.shell_common_config"
