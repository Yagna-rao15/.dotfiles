#!/bin/bash

# Find all .desktop files
desktop_files=$(find /usr/share/applications ~/.local/share/applications -name "*.desktop" 2>/dev/null)

# Extract application names and corresponding Exec commands
apps=$(while read -r file; do
    # Get the Name and Exec fields
    name=$(grep -m 1 "^Name=" "$file" | cut -d= -f2)
    exec=$(grep -m 1 "^Exec=" "$file" | cut -d= -f2 | sed 's/%.//')
    if [[ -n "$name" && -n "$exec" ]]; then
        echo "$name:$exec"
    fi
done <<< "$desktop_files")

# Show the list in dmenu and get the selected application
selected=$(echo "$apps" | cut -d: -f1 | dmenu -nb '#000000' -nf '#ffffff' -sb '#74c7ec' -sf '#000000' -p "Applications: " -i -fn 'JetBrainsMono' -h 32
)

# Extract the corresponding Exec command and run it
command=$(echo "$apps" | grep "^$selected:" | cut -d: -f2)
if [[ -n "$command" ]]; then
    eval "$command" &
fi

