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
    ["Libre"]='libreoffice'
    ["Obsidian"]='obsidian'
    ["Android Studio"]='android-studio'
    # ["Tmux"]="tmux"
    ["GPT"]='chatgpt'
)

selected=$(printf "%s\n" "${!apps[@]}" | dmenu -nb '#000000' -nf '#ffffff' -sb '#74c7ec' -sf '#000000' -p "Applications: " -i -fn 'JetBrainsMono')

if [[ -n "$selected" && -n "${apps[$selected]}" ]]; then
  if [ "$selected" == 'GPT' ]; then
    xdg-open "https://chatgpt.com/?oai-dm=1" &>/dev/null &
    sleep 0.5
    i3-msg "workspace 1"
  else
    eval "${apps[$selected]}" &>/dev/null &
  fi
fi

