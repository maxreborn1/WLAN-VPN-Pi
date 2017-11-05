#!/bin/sh 

logger "VPN Wifi Pi - Now starting all components"

# Give all other service the chance to finish their startup procedures
sleep 5

logger "VPN Wifi Pi - done waiting"

sudo service isc-dhcp-server restart

#sleep 3
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
sudo iptables -A FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT

sudo iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE
sudo iptables -A FORWARD -i eth1 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i wlan0 -o eth1 -j ACCEPT

sudo service dnsmasq restart

logger "VPN Wifi Pi - done..."

