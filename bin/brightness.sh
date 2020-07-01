#!/bin/sh
# Script to change backlight brightness (works only on Linux)
# Pass parameter like "brightness.sh 4" or "brightness.sh -4"
# This script assumens that the backlight is in this exact location and user has write access.
# Assumed location is /sys/class/backlight/amdgpu_bl0/brightness

# For write access, you can add this udev rule in file /etc/udev/rules.d/90-backlight.rules:
#ACTION=="add", SUBSYSTEM=="backlight", RUN+="/bin/chgrp video /sys/class/backlight/%k/brightness"
#ACTION=="add", SUBSYSTEM=="backlight", RUN+="/bin/chmod g+w /sys/class/backlight/%k/brightness"

cd /sys/class/backlight/amdgpu_bl0/

brightness=$(cat brightness)
max_brightness=$(cat max_brightness)
if [ $# -eq 0 ]
then
	echo $brightness
	exit 0
fi
brightness=$((brightness+$1*max_brightness/32))

if [ $((brightness < 1 )) '=' 1 ]
then
	brightness=1
fi
if [ $((brightness > max_brightness )) '=' 1 ]
then
	brightness=255
fi
echo -n $brightness > brightness
