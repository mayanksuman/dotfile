#
# ~/.zshrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source $HOME/.zshrc-oh-my-zsh
source $HOME/.shell_common_config


[ -f ~/.fzf.zsh  ] && source ~/.fzf.zsh
