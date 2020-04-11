#!/bin/sh
# Forcefully kill the currently active window with extreme force and yeah
xprop -root _NET_ACTIVE_WINDOW | cut -b41-49 | while read line;do xkill -id $line;done
