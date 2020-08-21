#!/bin/bash
if [[ ! -f /usr/sbin/iptables ]]
then
 iptables=/sbin/iptables
else
 iptables=/usr/sbin/iptables
fi
/usr/sbin/sysctl net.ipv4.ip_forward=1
"$iptables" -A INPUT -i "$1" -m state --state NEW -p tcp --dport 1194 -j ACCEPT

"$iptables" -A INPUT -i tun0 -j ACCEPT

"$iptables" -A FORWARD -i tun0 -j ACCEPT
"$iptables" -A FORWARD -i tun0 -o "$1" -m state --state RELATED,ESTABLISHED -j ACCEPT
"$iptables" -A FORWARD -i "$1" -o tun0 -m state --state RELATED,ESTABLISHED -j ACCEPT

"$iptables" -t nat -A POSTROUTING -s 10.8.0.0/24 -o "$1" -j MASQUERADE

"$iptables" -A OUTPUT -o tun0 -j ACCEPT
