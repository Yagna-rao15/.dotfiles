#!/bin/sh
#
# To crete a new note

if [ -z "$1" ]; then
  echo "Specify File Name"
  exit 1
fi

if [ -n "$2" ]; then
  echo "Enter only 1 file name"
  exit 1
fi

cd ~/Obsidian/Notes/ || exit 1
file_name=$(echo "$1" | tr ' ' '-')".md"
touch "${file_name}"
nvim "$file_name"
