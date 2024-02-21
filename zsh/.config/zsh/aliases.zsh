if [[ $TERM == "xterm-kitty" ]]; then
  alias ssh="kitty +kitten ssh"
fi

# brew
alias bup='brew upgrade --cask --greedy && brew upgrade'

alias nvimrc='nvim ~/.config/nvim/'

# eza
alias l='eza -la --group-directories-first --icons --git'
alias lt='l --tree --long --level=2'

alias cl=clear
alias cat=bat

# git
alias gc="git commit -m"
alias gco="git checkout"
alias gb="git branch"
alias gst="git status"
alias gdiff="git diff"
alias gba="git branch -a"
alias gadd="git add"
alias ga="git add -p"
