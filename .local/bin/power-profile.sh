#!/bin/bash

# Get the active profile from asusctl
profile_output=$(asusctl profile --profile-get)

# Extract the profile name more reliably
if echo "$profile_output" | grep -q "Quiet"; then
    profile="Quiet"
elif echo "$profile_output" | grep -q "Balanced"; then
    profile="Balanced"
elif echo "$profile_output" | grep -q "Performance"; then
    profile="Performance"
else
    profile="Unknown"
fi

# Display appropriate icon based on profile
case "$profile" in
    "Quiet")      echo "󰭟" ;;  # Silent Mode
    "Balanced")   echo "󰶐" ;;  # Balanced Mode
    "Performance") echo "󰓅" ;; # Performance Mode
    *)           echo "󰒮" ;;  # Unknown Profile
esac
