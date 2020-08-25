#!/bin/sh

# This script uses xterm's Tektronix terminal emulator emulation to show off random pictures
# from /usr/share/tek2plot, which has weird cool graphs and some world map and looks hackery lol

if [ $# -ne 0 ]&&[ "$1" '=' "me" ];then # woo, give the man some commands he wants!
	while true;do
		clear
		sleep 0.1
		cat "$(find /usr/share/tek2plot/ | grep "\.tek$" | grep -v "karney.tek" | shuf -n1)"
		sleep 1.5
	done
else
	xterm -t -tn tek4014 -e ~/bin/tektronix.sh me
fi
