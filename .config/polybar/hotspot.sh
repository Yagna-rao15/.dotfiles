#!/bin/bash

# Get the active SSID
ACTIVE_SSID=$(nmcli -t -f NAME connection show --active | head -n 1)

# Get BSSID for the active connection
nmcli -t -f BSSID,SSID device wifi list | grep "$ACTIVE_SSID" | awk -F: '{print $1}'

if [[ -n "$ACTIVE_SSID" ]]; then
    if nmcli connection show --active | grep -q "Hotspot"; then
        echo "󰖟 $ACTIVE_SSID"
    else
        echo "󰖩 $ACTIVE_SSID"
    fi
else
    echo "󰖪 Disconnected"  # Disconnected state
fi

