#!/bin/ash

# Get SERIALNUMBER from first argument
SERIALNUMBER="$1"

# Check if SERIALNUMBER is provided
if [ -z "$SERIALNUMBER" ]; then
    echo "Error: SERIALNUMBER not provided"
    echo "Usage: $0 <SERIALNUMBER>"
    exit 1
fi

# Get MAC address of eth0 and strip ":"
MAC_RAW=$(cat /sys/class/net/eth0/address 2>/dev/null | tr -d ':')

# Check if MAC address was retrieved
if [ -z "$MAC_RAW" ]; then
    echo "Error: Could not retrieve MAC address from eth0"
    exit 1
fi

# Combine SERIALNUMBER with MAC address (with parentheses)
COMBINED="${SERIALNUMBER}-${MAC_RAW}"

# Update DISTRIB_ID in /etc/openwrt_release
if [ -f /etc/openwrt_release ]; then
    # Check if DISTRIB_ID already exists
    if grep -q "^DISTRIB_ID=" /etc/openwrt_release; then
        # Replace existing DISTRIB_ID
        sed -i "s/^DISTRIB_ID=.*/DISTRIB_ID='${COMBINED}'/" /etc/openwrt_release
    else
        # Add DISTRIB_ID if it doesn't exist
        echo "DISTRIB_ID='${COMBINED}'" >> /etc/openwrt_release
    fi
else
    echo "DISTRIB_ID='${COMBINED}'" > /etc/openwrt_release
fi

echo "Updated DISTRIB_ID to: ${COMBINED}"
