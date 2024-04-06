#!/bin/sh
# On-demand autoclicker.
# Copybottom clicker.sh by Architector #4 2020

# Status file is an empty file that signifies if the script is running or not.
# Helps to allow for the toggling behavior.
STATUSFILE=/tmp/clicker_clicking_$USER

if [ -n "$1" ]; then
	BUTTON="$1"
else
	# If no button is specified, assume button 1 (left mouse button) is to be pressed.
	BUTTON=1
fi

if [ -f "$STATUSFILE" ]; then
	# Status file exists, meaning the script is running.
	# Remove it!
	rm "$STATUSFILE"
	# Release mouse, just in case.
	xdotool mouseup $BUTTON
	# Kill all instances of this script
	killall clicker.sh
	# Nothing after this line runs, because killall terminates this script too lol
else
	# If it's not running, turn on the loop and create statusfile.
	touch "$STATUSFILE"
	while true;do
		# Make this number higher for slower clicks, lower for faster.
		sleep 0.008
		xdotool mousedown $BUTTON
		# Give it some time of being held, just in case
		sleep 0.008
		# Raise the button
		xdotool mouseup $BUTTON
	done
fi
