#
# ~/.zshrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Load prezto before .shell_common_config (speed optimization)
source "$HOME/.local/share/zsh/prezto/init.zsh"
source "$HOME/.shell_common_config"

eval "$(direnv hook zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
