#!/bin/bash
iptables -t filter -F
iptables -X
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP



iptables -N INPUT-ACCEPT
iptables -N INPUT-DROP
iptables -N OUTPUT-ACCEPT
iptables -N OUTPUT-DROP
iptables -N FORWARD-ACCEPT
iptables -N FORWARD-DROP

iptables -A INPUT -j INPUT-DROP
iptables -A OUTPUT -j INPUT-DROP
iptables -A FORWARD -j INPUT-DROP

#Rules for INPUT-ACCEPT chain
iptables -A INPUT-ACCEPT -j LOG --log-prefix "INPUT-ACCEPTED"
iptables -A INPUT-ACCEPT -j ACCEPT

#Rules for INPUT-DROP chain
iptables -A INPUT-DROP -j LOG --log-prefix "INPUT-DROPPED"
iptables -A INPUT-DROP -j DROP

#Rules for OUPUT-ACCEPT chain
iptables -A OUTPUT-ACCEPT -j LOG --log-prefix "OUTPUT-ACCEPTED"
iptables -A OUTPUT-ACCEPT -j ACCEPT

#Rules for OUTPUT-DROP chain
iptables -A OUTPUT-DROP -j LOG --log-prefix "OUTPUT-DROPPED"
iptables -A OUTPUT-DROP -j DROP

#Rules for FORWARD-ACCEPT chain
iptables -A FORWARD-ACCEPT -j LOG --log-prefix "FORWARD-ACCEPTED"
iptables -A FORWARD-ACCEPT -j ACCEPT

#Rules for FORWARD-DROP chain
iptables -A FORWARD-DROP -j LOG --log-prefix "FORWARD-DROPPED"
iptables -A FORWARD-DROP -j DROP


#SSH/SCP to Router
iptables -A INPUT -p tcp -s 195.165.17.0/26 --dport 3737 -m state --state NEW,ESTABLISHED,RELATED -j INPUT-DROP
iptables -A OUTPUT -p tcp -d 195.165.17.0/26 --sport 3737 -m state --state ESTABLISHED,RELATED -j OUTPUT-DROP

#SSH/SCP to Server
iptables -A FORWARD -p tcp -s 195.165.17.0/26 --dport 7373 -m state --state NEW,ESTABLISHED,RELATED -j FORWARD-ACCEPT
iptables -A FORWARD -p tcp -d 195.165.17.0/26 --sport 7373 -m state --state ESTABLISHED,RELATED -j FORWARD-ACCEPT

#IIS 
iptables -A FORWARD -p tcp -s 195.165.17.0/26 --dport 2424 -m state --state NEW,ESTABLISHED,RELATED -j FORWARD-ACCEPT
iptables -A FORWARD -p tcp -d 195.165.17.0/26 --sport 2424 -m state --state ESTABLISHED,RELATED -j FORWARD-ACCEPT

#Apache 
iptables -A FORWARD -p tcp -s 195.165.17.0/26 --dport 4242 -m state --state NEW,ESTABLISHED,RELATED -j FORWARD-ACCEPT
iptables -A FORWARD -p tcp -d 195.165.17.0/26 --sport 4242 -m state --state ESTABLISHED,RELATED -j FORWARD-ACCEPT

#MySQL 
iptables -A FORWARD -p tcp -s 195.165.17.0/26 --dport 3306 -m state --state NEW,ESTABLISHED,RELATED -j FORWARD-ACCEPT
iptables -A FORWARD -p tcp -d 195.165.17.0/26 --sport 3306 -m state --state ESTABLISHED,RELATED -j FORWARD-ACCEPT

#HMAIL IMAP
iptables -A FORWARD -p tcp -s 195.165.17.0/26 --dport 143 -m state --state NEW,ESTABLISHED,RELATED -j FORWARD-ACCEPT
iptables -A FORWARD -p tcp -d 195.165.17.0/26 --sport 143 -m state --state ESTABLISHED,RELATED -j FORWARD-ACCEPT

#HMAIL SMTP 
iptables -A FORWARD -p tcp -s 195.165.17.0/26 --dport 25 -m state --state NEW,ESTABLISHED,RELATED -j FORWARD-ACCEPT
iptables -A FORWARD -p tcp -d 195.165.17.0/26 --sport 25 -m state --state ESTABLISHED,RELATED -j FORWARD-ACCEPT

#DNS
iptables -A FORWARD -p tcp -s 195.165.17.0/26 --dport 53 -m state --state NEW,ESTABLISHED,RELATED -j FORWARD-ACCEPT
iptables -A FORWARD -p tcp -d 195.165.17.0/26 --sport 53 -m state --state ESTABLISHED,RELATED -j FORWARD-ACCEPT
iptables -A FORWARD -p udp -s 195.165.17.0/26 --dport 53 -m state --state NEW,ESTABLISHED,RELATED -j FORWARD-ACCEPT
iptables -A FORWARD -p udp -d 195.165.17.0/26 --sport 53 -m state --state ESTABLISHED,RELATED -j FORWARD-ACCEPT
 
#DHCP
iptables -A INPUT -p udp --dport 67:68 -m state --state NEW,ESTABLISHED,RELATED -j INPUT-ACCEPT 
iptables -A OUTPUT -p udp --sport 67:68 -m state --state NEW,ESTABLISHED,RELATED -j OUTPUT-ACCEPT
iptables -A FORWARD -p udp --dport 67:68 -m state --state NEW,ESTABLISHED,RELATED -j FORWARD-ACCEPT
iptables -A FORWARD -p udp --sport 67:68 -m state --state ESTABLISHED,RELATED -j FORWARD-ACCEPT

#FTP UNENCRYPTED
iptables -A FORWARD -p tcp -s 195.165.17.0/26 --dport 21 -m state --state NEW,ESTABLISHED,RELATED -j FORWARD-ACCEPT
iptables -A FORWARD -p tcp -d 195.165.17.0/26 --sport 21 -m state --state ESTABLISHED,RELATED -j FORWARD-ACCEPT
iptables -A FORWARD -p tcp -s 195.165.17.0/26 --dport 20 -m state --state NEW,ESTABLISHED,RELATED -j FORWARD-ACCEPT
iptables -A FORWARD -p tcp -d 195.165.17.0/26 --sport 20 -m state --state ESTABLISHED,RELATED -j FORWARD-ACCEPT 




