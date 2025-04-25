#!/bin/bash

primary_color="%{F#74c7ec}"
text_color="%{F#cdd6f4}"
reset_color="%{F-}"

ACTIVE_SSID=$(nmcli device wifi | grep "*" | awk '{print $3}')

if [[ -n "$ACTIVE_SSID" ]]; then
    if nmcli connection show --active | grep -q "Hotspot"; then
        echo "${primary_color}󰖟${reset_color} ${text_color}$ACTIVE_SSID${reset_color}"
    else
        echo "${primary_color}󰖩${reset_color} ${text_color}$ACTIVE_SSID${reset_color}"
    fi
else
    echo "${primary_color}󰖪${reset_color}"
fi
