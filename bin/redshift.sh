#!/usr/bin/env bash
# Toggle redshift

# Status file is an empty file that signifies if the script is running or not.
# Helps to allow for the toggling behavior.
STATUSFILE=~/.cache/.redshift_enabled

if [ -f "$STATUSFILE" ] && [ "$1" != "on" ]; then
	# Status file exists, meaning the script is running,
	# and "on" parameter was not sent.
	# Remove the status file!
	rm $STATUSFILE
	# Turn it off
	if [ -n "$WAYLAND_DISPLAY" ]; then	# Running on Wayland
		# When using AUR package "redshift-wayland-git", any
		# invocation of redshift keeps being open until killed, and
		# killing it resets the red tint, essentially doing what is needed.
		killall redshift
	else					# Running on X
		redshift -x
	fi
else
	# If it's not running or "on" parameter was sent,
	# turn on redshift and create statusfile.
	touch "$STATUSFILE"
	redshift -P -O 2750K
fi
