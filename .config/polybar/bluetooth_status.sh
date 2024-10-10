#!/bin/bash

# Function to get the current Bluetooth status
get_bluetooth_status() {
    bluetoothctl show | grep -q "Powered: yes"
    [ $? -eq 0 ] && echo "on" || echo "off"
}

# Function to toggle Bluetooth
toggle_bluetooth() {
    if [ "$(get_bluetooth_status)" == "on" ]; then
        bluetoothctl power off
        echo "󰂲 Bluetooth: Off"  # Change icon for off state
    else
        bluetoothctl power on
        echo " Bluetooth: On"    # Change icon for on state
    fi
}

# Check if the script was called with an argument
if [ "$1" == "toggle" ]; then
    toggle_bluetooth
else
    if [ "$(get_bluetooth_status)" == "on" ]; then
        echo "%{F$COLOR}%{F-}" # Active state with color
    else
        echo "%{F#f38ba8}󰂲%{F-}" # Inactive state with a red color
    fi
fi

