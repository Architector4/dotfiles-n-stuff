#!/usr/bin/env bash
# Toggle redshift

# Status file is an empty file that signifies if the script is running or not.
# Helps to allow for the toggling behavior.
STATUSFILE=~/.redshift_enabled

if [ -f "$STATUSFILE" ] && [ "$1" != "on" ]; then
	# Status file exists, meaning the script is running,
	# or "on" parameter was sent.
	# Remove the status file!
	rm $STATUSFILE
	# Turn it off
	redshift -x
else
	# If it's not running or "on" parameter was sent,
	# turn on redshift and create statusfile.
	touch "$STATUSFILE"
	redshift -P -O 2750K
fi
