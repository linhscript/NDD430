#!/bin/bash
iptables -t filter -F
iptables -X
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP


# Apache service
iptables -N APACHE
iptables -A FORWARD -p tcp -s 195.165.17.0/26 --dport 4242 -m state --state NEW,ESTABLISHED,RELATED -j APACHE 
iptables -A FORWARD -p tcp -d 195.165.17.0/26 --sport 4242 -m state --state ESTABLISHED,RELATED -j APACHE 
iptables -A APACHE -j LOG --log-prefix "APACHE"
iptables -A APACHE -j ACCEPT

# ISS service
iptables -N ISS
iptables -A FORWARD -p tcp -s 195.165.17.0/26 --dport 2424 -m state --state NEW,ESTABLISHED,RELATED -j ISS
iptables -A FORWARD -p tcp -d 195.165.17.0/26 --sport 2424 -m state --state ESTABLISHED,RELATED -j ISS
iptables -A ISS -j LOG --log-prefix "ISS"
iptables -A ISS -j ACCEPT

# DNS service
iptables -N DNS
iptables -A FORWARD -p tcp -s 195.165.17.0/26 --dport 53 -m state --state NEW,ESTABLISHED,RELATED -j DNS
iptables -A FORWARD -p tcp -s 195.165.17.0/24 --sport 53 -m state --state NEW,ESTABLISHED,RELATED -j DNS
iptables -A FORWARD -p udp -s 195.165.17.0/26 --dport 53 -m state --state NEW,ESTABLISHED,RELATED -j DNS
iptables -A FORWARD -p udp -s 195.165.17.0/24 --sport 53 -m state --state NEW,ESTABLISHED,RELATED -j DNS
iptables -A DNS -j LOG --log-prefix "DNS"
iptables -A DNS -j ACCEPT

# DHCP service
iptables -N DHCP
iptables -A INPUT -p udp --dport 67:68 -m state --state NEW,ESTABLISHED,RELATED -j DHCP
iptables -A OUTPUT -p udp --sport 67:68 -m state --state NEW,ESTABLISHED,RELATED -j DHCP
iptables -A FORWARD -p udp --dport 67:68 -m state --state NEW,ESTABLISHED,RELATED -j DHCP
iptables -A FORWARD -p udp --sport 67:68 -m state --state NEW,ESTABLISHED,RELATED -j DHCP
iptables -A DHCP -j LOG --log-prefix "DHCP"
iptables -A DHCP -j ACCEPT

# Traceroute
iptables -N TRACEROUTE
iptables -A OUTPUT -p icmp -j TRACEROUTE
iptables -A FORWARD -p icmp -j TRACEROUTE
iptables -A OUTPUT -p udp --dport 33434:33474 -j TRACEROUTE
iptables -A FORWARD -p udp --dport 33434:33474 -j TRACEROUTE
iptables -A TRACEROUTE -j LOG --log-prefix "TRACEROUTE" --log-level 4
iptables -A TRACEROUTE -j ACCEPT



