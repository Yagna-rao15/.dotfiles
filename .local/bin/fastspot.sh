#!/bin/bash

# Interfaces
WIFI_INTERFACE="wlp4s0"
SSID="FastTransfer"
PASSWORD="securepass"
BAND="a"  # Use 5 GHz (802.11a/n)
CHANNEL="40" # Try a 5 GHz channel (check 'iw list' for available 5 GHz channels)
HW_MODE="a" # For 5 GHz (802.11a/n)
WPA_PROTO="WPA2"
WPA_KEY_MGMT="WPA-PSK"
WPA_PASS="securepass"

CONFIG_FILE="/tmp/hostapd.conf"

echo "Stopping Network Manager..."
sudo systemctl stop NetworkManager

echo "Creating hostapd configuration file: $CONFIG_FILE"
cat << EOF | sudo tee $CONFIG_FILE
interface=$WIFI_INTERFACE
ssid=$SSID
hw_mode=$HW_MODE
channel=$CHANNEL
ieee80211n=1
ht_capab=[HT40+][SHORT-GI-40]
wpa=$WPA_PROTO
wpa_key_mgmt=$WPA_KEY_MGMT
wpa_passphrase=$WPA_PASS
auth_algs=1
EOF

echo "Starting hostapd..."
sudo hostapd -B $CONFIG_FILE

echo "Starting Network Manager again (you might need to reconnect to your regular network later)..."
sudo systemctl start NetworkManager

echo "Hotspot setup using hostapd with configuration file."
echo "Connect your Android device to SSID: $SSID (password: $PASSWORD)"
echo "Remember to stop the hotspot manually with 'sudo killall hostapd'"
