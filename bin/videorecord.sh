#!/bin/sh
# Toggle video recording


# Status file is an empty file that signifies if the script is running or not.
# Helps to allow for the toggling behavior.
STATUSFILE=/tmp/vid_recording_toggled_on_$USER

OUTPUT=/tmp/vid_recording.mp4

if [ -f "$STATUSFILE" ] && [ "$1" != "on" ]; then
	# Status file exists, meaning the script is
	# probably running, and "on" parameter was not sent.

	id=$(cat "$STATUSFILE")
	# Remove the status file!
	rm "$STATUSFILE"

	# Check what is running on that process ID...
	cmd=$(cat /proc/"$id"/comm)
	if [ "$cmd" != "ffmpeg" ]; then
		# Actually ffmpeg isn't even running...
		# Just restart the script!
		exec "$0" "$@"
	fi

	# Kill ffmpeg...
	kill "$id"
	# Wait for it to actually die...
	while kill -0 "$id" 2> /dev/null; do sleep 0.01; done;
	# Rename the file to not conflict with further recording...
	OUTPUT_MOVED=$(mktemp -u).mp4
	mv "$OUTPUT" "$OUTPUT_MOVED"
	# Serve the file...
	dragon-drop "$OUTPUT_MOVED"
	# Some programs don't like the file disappearing even after seeing it, so...
	# Sleep a bit!
	sleep 10
	# Remove the file!
	rm "$OUTPUT_MOVED"
else
	# If it's not running or "on" parameter was sent,
	# do the thing!!
	# shellcheck disable=SC2046
	ffmpeg \
		-loglevel 8 \
		-y \
		-f x11grab \
		-framerate 30 \
		-show_region 1 \
		-grab_x $(slop -f "%x -grab_y %y -video_size %wx%h ") \
		-i :0 \
		-vf "pad=ceil(iw/2)*2:ceil(ih/2)*2" \
		-pix_fmt yuv420p \
		-crf 30 \
		"$OUTPUT" &
		#-grab_x 200 \
		#-grab_y 200 \
		#-video_size 200x200 \
		#-preset fast \
	echo $! > "$STATUSFILE"
fi
