export HISTFILESIZE=1000000
export HISTSIZE=1000000

export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_TYPE=en_US.UTF-8

export EDITOR="nvim"
export TERMINAL="wezterm"
export BROWSER="chrome"

export PATH=$HOME/.local/scripts:$PATH
export GOPATH=$HOME/.local/share/go
export PATH=$HOME/.local/share/go/bin:$PATH
export PATH=$HOME/.local/share/zig:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.fnm:$PATH

export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1

eval "$(fnm env)"
