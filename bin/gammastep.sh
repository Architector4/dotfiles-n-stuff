#!/bin/sh
# Toggle gammastep

# Status file is an empty file that signifies if the script is running or not.
# Helps to allow for the toggling behavior.
STATUSFILE=/tmp/gammastep_toggled_on_$USER

if [ -f "$STATUSFILE" ] && [ "$1" != "on" ]; then
	# Status file exists, meaning the script is running,
	# and "on" parameter was not sent.
	# Remove the status file!
	rm "$STATUSFILE"
	# Turn it off
	if [ -n "$WAYLAND_DISPLAY" ]; then	# Running on Wayland
		# Seems to work better on Wayland
		killall gammastep
	else					# Running on X
		gammastep -x
	fi
else
	# If it's not running or "on" parameter was sent,
	# turn on gammastep and create statusfile.
	touch "$STATUSFILE"
	gammastep -P -O 2750K
fi
