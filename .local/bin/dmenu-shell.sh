#!/bin/sh

while true; do
    CMD=$(cat ~/.config/zsh/zhistory | cut -d ';' -f2- | sort -u | dmenu -l 10 -p "Run:")
    [ -z "$CMD" ] && exit  # Exit if empty
    ${SHELL:-zsh} -c "$CMD"
done

