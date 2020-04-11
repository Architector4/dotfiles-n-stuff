# Script to change backlight brightness
# Pass parameter like "brightness.sh 4" or "brightness.sh -4"
# This script assumens that the backlight is in this exact location and user has write access.
# Assumed location is /sys/class/backlight/amdgpu_bl0/brightness
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
