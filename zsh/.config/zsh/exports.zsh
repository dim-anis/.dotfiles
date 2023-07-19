export HISTFILESIZE=1000000000
export HISTSIZE=1000000000

export EDITOR="nvim"
export TERMINAL="kitty"
export BROWSER="chrome"

export PATH=$HOME/.local/scripts:$PATH
export GOPATH=$HOME/.local/share/go
export PATH=$HOME/.local/share/go/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.fnm:$PATH
eval "$(fnm env)"
