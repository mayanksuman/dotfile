#
# ~/.zshrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Load prezto before .shell_common_config (speed optimization)
source "$HOME/.local/share/zsh/prezto/init.zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Easy cd-ing
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

# Following code useful to the user only if he is running an interactive shell.
# It fixes bug in which system progs are unable to find system python
# instead tried to use conda version resulting in errors.
# It ensures separation between user installed and system executables.
[ -z "$PS1" ] && echo "" || source "$HOME/.shell_common_config"
