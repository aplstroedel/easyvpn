#!/bin/bash
sysctl net.ipv4.ip_forward=1
/sbin/iptables -A INPUT -i eth0 -m state --state NEW -p tcp --dport 1194 -j ACCEPT

/sbin/iptables -A INPUT -i tun0 -j ACCEPT

/sbin/iptables -A FORWARD -i tun0 -j ACCEPT
/sbin/iptables -A FORWARD -i tun0 -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT
/sbin/iptables -A FORWARD -i eth0 -o tun0 -m state --state RELATED,ESTABLISHED -j ACCEPT

/sbin/iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE

/sbin/iptables -A OUTPUT -o tun0 -j ACCEPT
