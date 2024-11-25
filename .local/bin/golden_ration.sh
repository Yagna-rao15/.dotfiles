#!/bin/bash

# Define array of layouts in sequence
layouts=("split h" "split v")

# Get the number of layouts defined
num_layouts=${#layouts[@]}

# Get the currently focused workspace
current_workspace=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true).name')

# Get the current layout of the focused workspace
current_layout=$(i3-msg -t get_tree | jq -r --arg workspace "$current_workspace" '.nodes[].nodes[] | select(.name==$workspace).layout')

# Find index of current layout in layouts array
current_index=0
for (( i=0; i<$num_layouts; i++ )); do
    if [[ "${layouts[$i]}" == "$current_layout" ]]; then
        current_index=$i
        break
    fi
done

# Calculate index of next layout
next_index=$(( (current_index + 1) % num_layouts ))

# Switch to the next layout
i3-msg "layout ${layouts[$next_index]}"

