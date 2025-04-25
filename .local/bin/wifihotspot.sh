#!/bin/bash

# Polybar module for displaying hotspot information
# Add this script to your polybar config directory (e.g., ~/.config/polybar/scripts/hotspot.sh)
# Make it executable with: chmod +x ~/.config/polybar/scripts/hotspot.sh

# Function to check if a hotspot is active
is_hotspot_active() {
  # Check if NetworkManager is managing any access point
  nmcli -t -f NAME,TYPE con show --active | grep ":ap$" >/dev/null
  return $?
}

# Function to get hotspot details
get_hotspot_info() {
  # Get the name of the active AP connection
  local hotspot_name=$(nmcli -t -f NAME,TYPE con show --active | grep ":ap$" | cut -d':' -f1)
  
  # Get SSID and connected devices count if possible
  if [ -n "$hotspot_name" ]; then
    local ssid=$(nmcli -t -f 802-11-wireless.ssid con show "$hotspot_name" 2>/dev/null | cut -d':' -f2)
    
    # Try to count connected devices (requires iw)
    local connected_devices=0
    local interface=$(nmcli -t -f GENERAL.DEVICE con show "$hotspot_name" 2>/dev/null | cut -d':' -f2)
    
    if [ -n "$interface" ] && command -v iw >/dev/null; then
      connected_devices=$(iw dev "$interface" station dump | grep Station | wc -l)
    fi
    
    echo "$ssid ($connected_devices)"
  else
    echo "No active hotspot"
  fi
}

# Main execution
if is_hotspot_active; then
  info=$(get_hotspot_info)
  echo "%{F#2495e7}直%{F-} $info"
else
  echo "%{F#707880}睊%{F-} Off"
fi
