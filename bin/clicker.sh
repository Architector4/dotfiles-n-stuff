#!/bin/bash
# On-demand autoclicker.
# Copyright clicker.sh™ © ® architector4©® 2019 from a subreddit lol

# Status file is an empty file that signifies if the script is running or not.
# Helps to allow for the toggling behavior.
STATUSFILE=~/.clicking

# 1st button of mouse, left button. 2 is middle button, 3 is right button
BUTTON=1

if [ -f "$STATUSFILE" ]; then
	# Status file exists, meaning the script is running.
	# Remove it! BLERGH FORGOT THAT ONE LOL
	rm $STATUSFILE
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
		sleep 0.01
		xdotool mousedown $BUTTON
		# Give it some time of being held, just in case
		sleep 0.01 
		# Raise the button
		xdotool mouseup $BUTTON
	done
fi