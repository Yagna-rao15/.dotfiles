export PATH="/usr/local/bin:$PATH"
export PATH="${PATH:+${PATH}:}$HOME/.local/bin"

# Editor and shell Setup
export EDITOR="nvim"
export VISUAL="nvim"
export SHELL="zsh"
export TERMINAL="alacritty"
export TERM="xterm-256color"
export MANPAGER='nvim +Man!'

# XDG Base Directory Specification
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_STATE_HOME="${HOME}/.local/state"
export XDG_CACHE_HOME="${HOME}/.cache"

# Set up fzf
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
fi
export FZF_DEFAULT_COMMAND='rg --hidden -l ""' # Include hidden files
export FZF_CTRL_T_OPTS=" --preview 'bat -n --color=always {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export FZF_DEFAULT_OPTS="--layout=reverse --border=bold --border=rounded --margin=3% --color=dark"

# GnuPG XCursor path
export GNUPGHOME="${XDG_DATA_HOME}/gnupg"
export XCURSOR_PATH="/usr/share/icons:${XDG_DATA_HOME}/icons"

# NodeJs
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# Java Options
# export _JAVA_OPTIONS="-Djava.util.prefs.userRoot=${XDG_CONFIG_HOME}/java"
if [[ ! "$PATH" == */home/yagna/Code/Java/apache-maven-3.9.9/bin/* ]]; then
  export PATH="${PATH:+${PATH}:}/home/yagna/Code/Java/apache-maven-3.9.9/bin/"
fi

# wget
alias wget='wget --hsts-file="$XDG_DATA_HOME/wget-hsts"'

# Changing Node REPL History file location
export NODE_REPL_HISTORY="$XDG_CONFIG_HOME/node_repl_history"
export npm_config_cache=/home/yagna/.local/share/npm

# Go export
export PATH=$PATH:/usr/local/go/bin
export GOPATH='/home/yagna/Code/Go'
export PATH="$PATH:$(go env GOBIN)$(go env GOPATH)/bin"

# For cuda and GPU
export PATH=/usr/local/cuda/bin:$PATH
export PATH=/opt/cuda/bin:$PATH
export LD_LIBRARY_PATH=/opt/cuda/lib64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH

# Nvidia Drivers
export NV_CACHE_DIR="$XDG_CACHE_HOME/nv"

# Theming
export GTK_ICON_THEME="Papirus-Dark"
export GTK_CURSOR_THEME="macOS"
export GTK_CURSOR_SIZE=40
export GTK_THEME=Adwaita:dark
export GTK2_RC_FILES=/usr/share/themes/Adwaita-dark/gtk-2.0/gtkrc
export QT_STYLE_OVERRIDE=Adwaita-Dark

# VS CODE
export VSCODE_PORTABLE="$XDG_DATA_HOME/Code" # Force extensions and user data to be stored here

# PKI for Zen or Firefox
export PKI_DIR="$XDG_CACHE_HOME/pki"

# Nix
# export NIX_PATH=nixpkgs=https://nixos.org/channels/nixos-23.05

# Googl Android
export ANDROID_HOME=$HOME/Code/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
