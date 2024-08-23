# For ROS-Humble
# source /opt/ros/humble/setup.zsh

# Source zshenv and alias
source "$XDG_CONFIG_HOME/zsh/.alias"

# Set zinit Directory
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if not exist
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# Adding zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Adding Snippet
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::command-not-found

# Load Completions
autoload -Uz compinit
compinit -d "$ZDOTDIR/.zcompdump"
# _comp_options+=(globdots)

zinit cdreplay -q

# Keybinds
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# History
HISTSIZE=5000
HISTFILE=~/.config/zsh/.history
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt appendhistory
setopt share_history
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt inc_append_history
unsetopt EXTENDED_HISTORY

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"


