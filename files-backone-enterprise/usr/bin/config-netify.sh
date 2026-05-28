#!/bin/sh

nft add table inet nfa
nft add set inet nfa nfa_block.v4 { type ipv4_addr . inet_service . ipv4_addr \; flags interval, timeout \; timeout 5m \; }

if [ -f /etc/init.d/netifyd ]; then
  /etc/init.d/netifyd stop
  /etc/init.d/netifyd start
fi
nft list tables
nft -f /etc/nftables.d/10-netify.nft.sh

echo "DONE!" >/tmp/config-netify.log
