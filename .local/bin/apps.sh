#!/bin/bash

declare -A apps=(
    # ["Firefox"]="firefox"
    ["Zen Browser"]="zen-browser"
    ["Brave"]="brave"
    # ["Twilight"]="zen-twilight"
    ["Terminal"]="alacritty"
    ["VS Code"]="env XDG_CONFIG_HOME=$HOME/.config XDG_CACHE_HOME=$HOME/.cache XDG_DATA_HOME=$HOME/.local/share code"
    ["File Manager"]="nautilus"
    ["GIMP"]="gimp"
    ["Eclipse"]="eclipse"
    ["Libre"]='libreoffice'
    # ["Tmux"]="tmux"
)

selected=$(printf "%s\n" "${!apps[@]}" | dmenu -nb '#000000' -nf '#ffffff' -sb '#74c7ec' -sf '#000000' -p "Applications: " -i -fn 'JetBrainsMono')

if [[ -n "$selected" && -n "${apps[$selected]}" ]]; then
    eval "${apps[$selected]}" &>/dev/null &
fi

