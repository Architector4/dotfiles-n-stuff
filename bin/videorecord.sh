#!/bin/sh
# Toggle video recording


# Status file is an empty file that signifies if the script is running or not.
# Helps to allow for the toggling behavior.
STATUSFILE=/tmp/vid_recording_toggled_on_$USER

OUTPUT=/tmp/vid_recording_$USER.mp4

if [ -f "$STATUSFILE" ] && [ "$1" != "on" ]; then
	# Status file exists, meaning the script is
	# probably running, and "on" parameter was not sent.

	id=$(cat "$STATUSFILE")
	echo $id
	# Remove the status file!
	rm "$STATUSFILE"

	# Check what is running on that process ID...
	cmd=$(cat /proc/"$id"/comm)
	echo "$cmd"
	if [ "$cmd" != "ffmpeg" ] && [ "$cmd" != "wf-recorder" ]; then
		# Actually it isn't even running...
		# Just restart the script!
		exec "$0" "$@"
	fi

	# Kill it...
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
	
	# Hacky approach, get first sink monitor in the list...
	PACTL_MONITOR=$(pactl list short sources | grep monitor | cut -f2 | grep -v "hdmi" | head -n1)

	if [ -n "$WAYLAND_DISPLAY" ]; then # Running on Wayland
		GEOMETRY=$(slurp)
		if [ -n "$GEOMETRY" ]; then
			wf-recorder \
				-g "$GEOMETRY" \
				--audio="$PACTL_MONITOR" \
				-f "$OUTPUT" &
				echo $! > "$STATUSFILE"
		fi
	else # Running on X or whatever else
		GEOMETRY=$(slop -f "-grab_x %x -grab_y %y -video_size %wx%h ")
		if [ -n "$GEOMETRY" ]; then
		# shellcheck disable=SC2046  # intentionally unquoted parameter with slop lol
			ffmpeg \
				-loglevel 8 \
				-y \
				-f pulse \
				-ac 2 \
				-i "$PACTL_MONITOR" \
				-f x11grab \
				-framerate 30 \
				-show_region 1 \
				$GEOMETRY \
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
	fi
fi
