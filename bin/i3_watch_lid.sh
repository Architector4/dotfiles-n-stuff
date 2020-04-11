#!/bin/bash
# Look at ACPI events, and trigger i3lock when laptop lid is closed

# the description of this file is invalid now that
# i've edited it a million times and only left
# the script to lock the screen normally here
# ignore physlock, best to not execute it automatically,
# cause 2 instances of physlock or something 
# causes Xorg to flail away from sheer power of locking

# When lid gets closed, sets CPU frequency's upper
# limit to 500M and locks TTY switching with physlock,
# and locks screen with i3lock.
# When lid gets opened, kills i3lock, 
# unlocks TTY switching, starts physlock and
# restores CPU freq upper limit by setting it to 10G.
# The CPU's upper limit maxes out at its real limits
# which are 1000MHz and 2200MHz for my CPU, so don't
# worry about the ridiculousness of the numbers.
# Needs this rule in /etc/sudoers to work:
# ALL	ALL = NOPASSWD: /usr/bin/cpupower frequency-set -u [!-]*
#
# The reason for this scheme with physlock is that
# it takes laptop lid open action as a key,
# so you have to press ENTER to reset the prompt
# and then type your password again, which is annoying.
# So I just lock the screen with i3lock while lid is
# closed, and then unlock and lock it again with physlock
# once it's open.

# Actually nevermind with physlock and CPU frequencies -
# Messing with physlock often crashes Xorg, and
# frequency adjustment is being done with acpid event
# handlers in /etc/acpi/events.


acpi_listen | while read line; do
	if (echo $line | grep "LID close"); then
		#echo "LOL LID CLOSE"
		#sudo cpupower frequency-set -u 500M
		#if ! pidof physlock ;then
			#physlock -l
			i3lock.sh&
		#fi
	fi
	#elif (echo $line | grep "LID open"); then
	#	#	#echo "LOL LID OPEN"
	#	#sudo cpupower frequency-set -u 10
	#	#if ! pidof physlock;then
	#		#killall i3lock
	#		#physlock -L
	#		#physlock
	#	#fi
	#	true
	#fi
done
