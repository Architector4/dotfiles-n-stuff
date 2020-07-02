#!/bin/sh
# Rapidly check if I even have connection to the internet
while true;do
	ping -c 1 -W 1 1.1.1.1
	ping -c 1 -W 1 192.168.1.1
	sleep 0.3
done | grep "bytes"
