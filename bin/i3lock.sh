#!/bin/sh
# Pick a random picture from ~/Pictures/Glitchy and lock with it
i3lock -nti "$(find ~/Pictures/Glitchy | shuf -n 1)"
