# automatically switch to the node version used by the current project
eval "$(fnm env --use-on-cd)"

# enable p10k prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# history
HISTFILE=~/.zsh_history

# source ZAP plugin manager
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

# source p10k
[[ ! -f ~/.p10k.zsh ]] || plug "$HOME/.p10k.zsh"

# source aliases and exports
plug "$HOME/.config/zsh/aliases.zsh"
plug "$HOME/.config/zsh/exports.zsh"

# install plugins
plug "zap-zsh/supercharge"
plug "zsh-users/zsh-autosuggestions"
plug "hlissner/zsh-autopair"
plug "zsh-users/zsh-syntax-highlighting"
plug "zap-zsh/fzf"
plug "zap-zsh/fnm"
plug "zap-zsh/vim"
plug "romkatv/powerlevel10k"

# bindings
bindkey '^ ' autosuggest-accept
bindkey -s '^f' 'tmux-sessionizer\n'
