#!/bin/bash

primary_color="%{F#74c7ec}"
text_color="%{F#cdd6f4}"
reset_color="%{F-}"

ICON_ON=""
ICON_OFF="󰂲"

get_bluetooth_powered() {
  bluetoothctl show | grep -q "Powered: yes"
}

get_connected_devices() {
  bluetoothctl devices Connected | cut -d ' ' -f 3- | paste -sd ", " -
}

if [[ "$1" == "notify" ]]; then
  if get_bluetooth_powered; then
    devices=$(get_connected_devices)
    if [[ -n "$devices" ]]; then
      notify-send "Bluetooth Status" "Connected to: $devices"
    else
      notify-send "Bluetooth Status" "Bluetooth is ON\nNo devices connected"
    fi
  else
    notify-send "Bluetooth Status" "Bluetooth is OFF"
  fi
  exit 0
fi

if get_bluetooth_powered; then
  devices=$(get_connected_devices)
  if [[ -n "$devices" ]]; then
    # echo "${primary_color}${ICON_ON}${reset_color} ${text_color}${devices}${reset_color}"
    echo "${primary_color}${ICON_ON}${reset_color}"
  else
    # echo "${primary_color}${ICON_OFF}${reset_color} ${text_color}On${reset_color}"
    echo "${primary_color}${ICON_OFF}${reset_color}"
  fi
else
  echo "${primary_color}${ICON_OFF}${reset_color}"
fi
