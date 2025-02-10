#!/bin/bash

# Set the directories to search
CODE_DIR=~/Code
OBSIDIAN_DIR=~/Obsidian

# Create a list of options for fzf
OPTIONS=$(find "$CODE_DIR" -type d -maxdepth 1 2>/dev/null | sed "s|^$CODE_DIR/||")
OPTIONS="$OPTIONS"$'\n'"Obsidian"

# Fuzzy search the options
CHOICE=$(echo "$OPTIONS" | fzf --prompt="Select a directory: ")

# Handle the selection
if [ -z "$CHOICE" ]; then
  echo "No selection made. Exiting."
  exit 1
fi

# Handle "Obsidian" separately
if [ "$CHOICE" == "Obsidian" ]; then
  cd "$OBSIDIAN_DIR" || exit
else
  cd "$CODE_DIR/$CHOICE" || exit
fi

# Open nvim in the selected directory
nvim

