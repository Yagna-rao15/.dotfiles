#!/usr/bin/env bash

switch_to() {
    if [[ -z "$TMUX" ]]; then
        tmux attach-session -t "$1"
    else
        tmux switch-client -t "$1"
    fi
}

has_session() {
    tmux has-session -t="$1" 2>/dev/null
}

hydrate() {
    local session="$1"
    local dir="$2"
    local hydrater="$dir/.tmux-sessionizer"

    tmux send-keys -t "$session" "cd \"$dir\"" C-m

    [[ ! -f "$hydrater" ]] && hydrater="$HOME/.tmux-sessionizer"
    [[ -f "$hydrater" ]] && tmux send-keys -t "$session" "source \"$hydrater\"" C-m
}

# Get selected directory
if [[ $# -eq 1 ]]; then
    selected="$1"
else
    SEARCH_DIRS=(~/Code/)
    selected=$(find "${SEARCH_DIRS[@]}" -mindepth 1 -maxdepth 1 -type d 2>/dev/null | fzf)
fi

[[ -z "$selected" ]] && exit 0

session_name=$(basename "$selected" | tr '. ' '__')

# Check if session already exists
if has_session "$session_name"; then
    switch_to "$session_name"
    exit 0
fi

# If session doesn't exist, create it
tmux_running=$(pgrep -x tmux)

if [[ -z "$TMUX" && -z "$tmux_running" ]]; then
    exec tmux new-session -s "$session_name" -c "$selected"
else
    tmux new-session -ds "$session_name" -c "$selected"
    hydrate "$session_name" "$selected"
    switch_to "$session_name"
fi

