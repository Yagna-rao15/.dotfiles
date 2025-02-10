#!/bin/bash

# Interfaces
WIFI_INTERFACE="wlp4s0"
ETHERNET_INTERFACE="eno1"
SSID="YagnaRao"
PASSWORD="micromax"

echo "Enabling IP forwarding..."
sudo sysctl -w net.ipv4.ip_forward=1

echo "Setting up NAT..."
sudo iptables -t nat -A POSTROUTING -o $ETHERNET_INTERFACE -j MASQUERADE
sudo iptables -A FORWARD -i $WIFI_INTERFACE -o $ETHERNET_INTERFACE -j ACCEPT
sudo iptables -A FORWARD -i $ETHERNET_INTERFACE -o $WIFI_INTERFACE -m state --state RELATED,ESTABLISHED -j ACCEPT

echo "Starting the hotspot..."
nmcli dev wifi hotspot ifname $WIFI_INTERFACE ssid $SSID password $PASSWORD

echo "Hotspot setup complete."
