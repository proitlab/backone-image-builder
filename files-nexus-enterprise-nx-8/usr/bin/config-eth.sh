#!/bin/sh

# SPF
ip link set "eth0" name "eth10"
ip link set "eth1" name "eth11"

# ETH
ip link set "eth2" name "eth0"
ip link set "eth3" name "eth1"
ip link set "eth4" name "eth2"
ip link set "eth5" name "eth3"
ip link set "eth6" name "eth4"
ip link set "eth7" name "eth5"
ip link set "eth8" name "eth6"
ip link set "eth9" name "eth7"


echo "DONE!" > /tmp/config-eth.log
