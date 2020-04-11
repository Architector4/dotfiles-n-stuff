#!/bin/bash
# For when your PC is too fast, so you have to make your data flow slower
while read line;do
	echo $line
	sleep $1
done
