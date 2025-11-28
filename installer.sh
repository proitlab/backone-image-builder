#!/bin/ash

# Download zip files
# curl -o /tmp/files.tar.gz https://install.backone.cloud/installer/files.tar.gz

# Extract the files
#tar -xvf /tmp/files.tar.gz -C /

# Update Package
opkg update
# Install Packages
opkg install bash zabbix-agentd curl mosquitto-client-ssl libmbedtls rtty-nossl luci
opkg install luci-theme-material luci-app-commands luci-app-acl wget-ssl ethtool adblock luci-app-vnstat usbutils kmod-usb-serial-option kmod-usb-serial-qualcomm kmod-usb-serial-wwan kmod-usb-serial kmod-usb-net-cdc-ether mwan3 luci-app-mwan3 git

# Download BackOne and install
wget https://download.backone.cloud/abadi/21.02.6/packages/backone/backone....
opkg install backone....

# Download and install luci-app-backone
wget https://download.backone.cloud/abadi/21.02.6/packages/backone/backone....
opkg install backone....

# Do it again to make sure -> Extract the files
#tar -xvf /tmp/files.tar.gz -C /

# Reboot
reboot
