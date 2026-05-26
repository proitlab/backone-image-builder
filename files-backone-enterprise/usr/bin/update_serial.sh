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

OS_RELEASE=/usr/lib/os-release
# Update BUILD_ID in /etc/os-release
if [ -f ${OS_RELEASE} ]; then
    # Check if BUILD already exists
    if grep -q "^BUILD_ID=" ${OS_RELEASE}; then
        # Replace existing DISTRIB_ID
        sed -i "s/^BUILD_ID=.*/BUILD_ID='${COMBINED}'/" ${OS_RELEASE}
    else
        # Add DISTRIB_ID if it doesn't exist
        echo "BUILD_ID='${COMBINED}'" >> ${OS_RELEASE}
    fi
else
    echo "BUILD_ID='${COMBINED}'" > ${OS_RELEASE}
fi

echo "Updated BUILD_ID to: ${COMBINED}"
