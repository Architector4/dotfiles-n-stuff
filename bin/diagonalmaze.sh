#!/usr/bin/env bash
# Spam / and \ characters, making what kind of looks like a maze
while true; do
	if [ $(($RANDOM%2)) -eq 1 ]; then
		echo -n "/";else echo -n "\\"
	fi
done
