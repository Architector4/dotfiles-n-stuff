#!/usr/bin/env bash
# Toggle my touchpad. Probably better for you to set up your own touchpad here if you have one
pad="SynPS/2 Synaptics TouchPad"
current=$(xinput list-props "$pad" | grep "Device Enabled" | cut "-b24")
if [ $current -eq 1 ]
then
	xinput set-prop "$pad" "Device Enabled" 0
else
	xinput set-prop "$pad" "Device Enabled" 1
fi
