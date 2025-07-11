#!/bin/bash

# Set GTK dark theme
GTK_DARK_THEME="Adwaita:dark"

declare -A apps=(
  ["Firefox"]="firefox"
  ["Zen Browser"]="zen-browser"
  ["Brave"]="brave"
  ["Alacritty"]="alacritty"
  ["VS Code"]="env XDG_CACHE_HOME=$HOME/.cache XDG_DATA_HOME=$HOME/.local/share code"
  ["File Manager"]="env GTK_THEME=$GTK_DARK_THEME nautilus"
  ["GIMP"]="env GTK_THEME=$GTK_DARK_THEME gimp"
  ["Libre"]="env GTK_THEME=$GTK_DARK_THEME libreoffice"
  ["Obsidian"]='obsidian'
  ["Android Studio"]='android-studio'
  ["GPT"]='chatgpt'
  ["Gemini"]='gemini'
  ["Chrome"]='chromium'
  ["Kitty"]='kitty'
  ["Bluetooth"]="env GTK_THEME=$GTK_DARK_THEME blueberry"
  ["Minecraft"]='minecraft'
  ["KDE Connect"]='kdeconnect-app'
  ["Steam"]='steam'
  ["Proton VPN"]='protonvpn-app'
  ["Virtual Box"]='virtualbox'
  ["Anki"]='anki'
  ["Transmission"]="env GTK_THEME=$GTK_DARK_THEME transmission-gtk"
  ["Lutris"]="lutris"
)

selected=$(printf "%s\n" "${!apps[@]}" | dmenu -nb '#000000' -nf '#ffffff' -sb '#74c7ec' -sf '#000000' -p "Applications: " -i -fn 'JetBrainsMono')

if [[ -n "$selected" && -n "${apps[$selected]}" ]]; then
  if [ "$selected" == 'GPT' ]; then
    xdg-open "https://chatgpt.com/?oai-dm=1" &>/dev/null &
    sleep 0.5
    i3-msg "workspace 1"
  elif [ "$selected" == 'Gemini' ]; then
    xdg-open "https://gemini.google.com/app/8e75bac7a97603d4?hl=en-IN" &>/dev/null &
    sleep 0.5
    i3-msg "workspace 1"
  elif [ "$selected" == 'Minecraft' ]; then
    java -jar ~/Games/Minecraft/LegacyLauncher.jar &
  else
    eval "${apps[$selected]}" &>/dev/null &
  fi
fi
