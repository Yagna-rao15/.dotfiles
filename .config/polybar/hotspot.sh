#!/bin/bash

primary_color="%{F#74c7ec}"
text_color="%{F#cdd6f4}"
reset_color="%{F-}"

ICON_HOSTSPOT="󰖟"
ICON_WIFI="󰖩"
ICON_WIFI_OFF="󰖪"

get_active_ssid() {
  nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2-
}

is_hotspot() {
  nmcli -t -f NAME,TYPE con show --active | grep -q "^Hotspot:802-11-wireless"
}

is_wifi_on() {
  nmcli radio wifi | grep -q "enabled"
}

if [[ "$1" == "notify" ]]; then
  wifi_status=$(nmcli radio wifi)
  active_ssid=$(get_active_ssid)

  if [[ "$wifi_status" == "enabled" ]]; then
    if [[ -n "$active_ssid" ]]; then
      notify-send "Wi-Fi Status" "Connected to: $active_ssid"
    else
      notify-send "Wi-Fi Status" "Wi-Fi is ON\nNot connected to any network"
    fi
  else
    notify-send "Wi-Fi Status" "Wi-Fi is OFF"
  fi
  exit 0
fi

if is_wifi_on; then
  ACTIVE_SSID=$(get_active_ssid)
  if [[ -n "$ACTIVE_SSID" ]]; then
    if is_hotspot; then
      echo "${primary_color}${ICON_HOSTSPOT}${reset_color} ${text_color}${ACTIVE_SSID}${reset_color}"
    else
      echo "${primary_color}${ICON_WIFI}${reset_color} ${text_color}${ACTIVE_SSID}${reset_color}"
    fi
  else
    echo "${primary_color}${ICON_WIFI}${reset_color}"
  fi
else
  echo "${primary_color}${ICON_WIFI_OFF}${reset_color}"
fi
