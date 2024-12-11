#!/bin/bash

# Paths to search for .desktop files
desktop_dirs=("/usr/share/applications" "$HOME/.local/share/applications")

# Collect application names and corresponding Exec commands
apps=$(
    find "${desktop_dirs[@]}" -name "*.desktop" 2>/dev/null | while read -r file; do
        name=$(grep -m 1 "^Name=" "$file" | cut -d= -f2)
        exec=$(grep -m 1 "^Exec=" "$file" | cut -d= -f2 | sed 's/%.//')
        if [[ -n "$name" && -n "$exec" ]]; then
            echo "$name:$exec"
        fi
    done
)

# Display the applications in Rofi
selected=$(echo "$apps" | cut -d: -f1 | rofi -dmenu -theme dmenu)

# Launch the selected application
if [[ -n "$selected" ]]; then
    command=$(echo "$apps" | grep -F "$selected:" | cut -d: -f2)
    eval "$command" &>/dev/null &
    # notify-send "Rofi Launcher" "No application selected" -u low
fi

