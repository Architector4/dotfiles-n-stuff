#!/usr/bin/env bash
# Used for multiplayer sessions in Terraria
# When activated, this script spams random item icons the chat lol

function item() {
	xdotool type "[i"
	xdotool key 61
	#xdotool type "1"
	xdotool type "s"
	xdotool type "$((RANDOM%99))"
	xdotool key Shift+47
	xdotool type "$((RANDOM%3929))"
	xdotool type "]"
}
function return() {
	xdotool keydown Return
	sleep 0.1
	xdotool keyup Return
}

while true
	do sleep 0.5
	return
	for i in {1..10};do
		item
		true "$i" # To stop shellcheck from complaining
		# Yeah this is trash code - it doesn't need to
		# be performant lmao
	done
	return
done
