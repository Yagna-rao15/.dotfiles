#!/bin/bash

# Interfaces
WIFI_INTERFACE="wlp4s0"
ETHERNET_INTERFACE="eno1"
SSID="YagnaRao"
PASSWORD="micromax"

if [[ "$1" == "off" ]]; then
  nmcli radio wifi off
  exit 0
fi

if [[ "$1" == "wifi" ]]; then
  nmcli radio wifi off
  nmcli radio wifi on
  exit 0
fi

echo "Starting wifi"
nmcli radio wifi on

echo "Enabling IP forwarding..."
sudo sysctl -w net.ipv4.ip_forward=1

echo "Setting up NAT..."
sudo iptables -t nat -A POSTROUTING -o $ETHERNET_INTERFACE -j MASQUERADE
sudo iptables -A FORWARD -i $WIFI_INTERFACE -o $ETHERNET_INTERFACE -j ACCEPT
sudo iptables -A FORWARD -i $ETHERNET_INTERFACE -o $WIFI_INTERFACE -m state --state RELATED,ESTABLISHED -j ACCEPT

echo "Starting the hotspot..."
nmcli dev wifi hotspot ifname $WIFI_INTERFACE ssid $SSID password $PASSWORD

echo "Hotspot setup complete."
