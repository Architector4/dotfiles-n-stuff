#!/bin/sh
# Receive text on stdin and type it out with xdotool
# Optional arguments are prepended to each line
while read -r line; do
	#sleep 0.1
	xdotool type "$@" "${line}"
	# Keypad ENTER key sometimes work better than normal Return
	#xdotool key KP_Enter
	xdotool key "$@" Return
done
