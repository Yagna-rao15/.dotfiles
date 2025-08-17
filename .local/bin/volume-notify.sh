#!/usr/bin/env bash

vol=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+%' | head -1 | tr -d '%')
mute=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

if [ "$mute" = "yes" ]; then
  icon="󰖁 "
else
  if [ "$vol" -lt 60 ]; then
    icon="󰖀 "
  else
    icon="󰕾 "
  fi
fi

bar=$(seq -s '━' 0 $((vol / 5)) | sed 's/[0-9]//g')
notify-send -r 9993 -t 1000 "$icon Volume: $vol%" "$bar"

