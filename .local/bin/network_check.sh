#!/bin/bash

MOBILE_IP="10.42.0.152"
# NOTE: To check IP of mobile use command arp -a to list all connected devices ip or nmap -sn netwrok (10.42.0.1/24)

# NETWORK_INTERFACE="wlp4s0"

if ping -c 1 "$MOBILE_IP" &>/dev/null; then
    systemctl --user start syncthing.service
    cd /home/yagna/Immich || exit
    docker compose up -d
    notify-send "Pixel 7 Connected" "Services Activated"
else
    systemctl --user stop syncthing.service
    cd /home/yagna/Immich || exit
    docker compose down
    notify-send "Pixel 7 Not connected" "Services Deactivated"
fi

