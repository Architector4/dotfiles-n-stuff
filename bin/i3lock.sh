#!/bin/sh
# Pick a random picture from ~/Pictures/Glitchy and lock with it
i3lock -nti "$(find ~/Pictures/Glitchy ! -type d | shuf -n 1)" ||
swaylock -ti "$(find ~/Pictures/Glitchy ! -type d | shuf -n 1)"
