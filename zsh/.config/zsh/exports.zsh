export HISTFILESIZE=1000000
export HISTSIZE=1000000

export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_TYPE=en_US.UTF-8

# Environment Variables
export EDITOR="nvim"
export TERMINAL="wezterm"
export BROWSER="firefox"

# PATH Configuration
export GOPATH="$HOME/.local/share/go"

export PATH="$HOME/.local/bin:$HOME/.local/scripts:$GOPATH/bin:$HOME/.local/share/zig:$PATH"
export PATH="$HOME/.cargo/bin:$HOME/.fnm:/opt/homebrew/opt/postgresql@16/bin:/opt/homebrew/opt/libpq/bin:$PATH"

# Homebrew Optimizations
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1

# Initialize Environment Managers
eval "$(fnm env)"
eval "$(~/.local/bin/mise activate)"
