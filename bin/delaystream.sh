#!/usr/bin/env bash
# For when your PC is too fast, so you have to make your data flow slower
while read -r line;do
	echo "$line"
	sleep "$1"
done
