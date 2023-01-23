#!/bin/sh
# Toggle video recording


# Status file is an empty file that signifies if the script is running or not.
# Helps to allow for the toggling behavior.
STATUSFILE=/tmp/vid_recording_toggled_on_$USER

OUTPUT=/tmp/vid_recording.mp4

if [ -f "$STATUSFILE" ] && [ "$1" != "on" ]; then
	# Status file exists, meaning the script is running,
	# and "on" parameter was not sent.
	# Kill ffmpeg...
	kill $(cat "$STATUSFILE")
	# Remove the status file!
	rm "$STATUSFILE"
	# Serve the file...
	dragon-drop "$OUTPUT"
	# Remove the file!
	rm "$OUTPUT"
else
	# If it's not running or "on" parameter was sent,
	# do the thing!!
	ffmpeg \
		-loglevel 8 \
		-y \
		-f x11grab \
		-framerate 30 \
		-show_region 1 \
		$(slop -f "-grab_x %x -grab_y %y -video_size %wx%h ") \
		-i :0 \
		-preset fast \
		"$OUTPUT" &
		#-grab_x 200 \
		#-grab_y 200 \
		#-video_size 200x200 \
	echo $! > "$STATUSFILE"
fi