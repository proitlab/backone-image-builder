#!/bin/sh

IS_PROBLEM=`nslookup google.com | grep "can't find" | wc -l`

if [ ${IS_PROBLEM} -ne 0 ]
then
  # Add Google to DNS List Server
  uci add_list dhcp.@dnsmasq[0].server=8.8.8.8
  uci commit dhcp
  /etc/init.d/dnsmasq restart
fi
