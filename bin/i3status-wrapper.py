#!/usr/bin/env python
# -*- coding: utf-8 -*-

# TAKEN FROM: https://github.com/i3/i3status/blob/master/contrib/wrapper.py
# MUTILATED BY: Architector #4
# This script is a simple wrapper which prefixes each i3status line with custom
# information. It is a python reimplementation of:
# http://code.stapelberg.de/git/i3status/tree/contrib/wrapper.pl
#
# To use it, ensure your ~/.i3status.conf contains this line:
#     output_format = "i3bar"
# in the 'general' section.
# Then, in your ~/.i3/config, use:
#     status_command i3status | ~/i3status/contrib/wrapper.py
# In the 'bar' section.
#
# In its current version it will display the cpu frequency governor, but you
# are free to change it to display whatever you like, see the comment in the
# source code below.
#
# © 2012 Valentin Haenel <valentin.haenel@gmx.de>
#
# This program is free software. It comes without any warranty, to the extent
# permitted by applicable law. You can redistribute it and/or modify it under
# the terms of the Do What The Fuck You Want To Public License (WTFPL), Version
# 2, as published by Sam Hocevar. See http://sam.zoy.org/wtfpl/COPYING for more
# details.

import sys
import subprocess
import json
# Playerctl bindings: https://github.com/altdesktop/playerctl
import gi
gi.require_version('Playerctl', '2.0')
from gi.repository import Playerctl
import time

def get_governor():
    """ Get the current governor for cpu0, assuming all CPUs use the same. """
    with open('/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor') as fp:
        return fp.readlines()[0].strip()

    ### This old code was querying the window title of a window of class "umpv", was hacky and dumb.
##vidname="" # When rapidly switching workspaces, it fails to find the window.
##vidstop=0 # This system here is to use what the previous query gave in case last one failed.
#def get_playing_video_name():
#    sub = subprocess.Popen("xprop -id $(xdotool search --classname umpv) WM_NAME | cut -d\\\" -f2-",
#            shell=True, stdout=subprocess.PIPE, stderr=subprocess.DEVNULL)
#    stdout=sub.stdout.readlines()
#    if len(stdout) == 0:
#        #if vidstop>2:
#            #vidname=""
#        #vidstop+=1
#        #return vidname
#        return ""
#    line=stdout[0].decode("utf-8")[:-2]#[:-7]
#    vidname=line
#    vidstop=0
#    return line

# Get full media player status line using playerctl
def get_playing_media_name():
    player = Playerctl.Player()
    artist = player.get_artist()
    title = player.get_title()
    pos = time.strftime("%H:%M:%S", time.gmtime(player.get_position()/1000/1000))
    if 'mpris:length' in player.props.metadata.keys():
        length = time.strftime("%H:%M:%S", time.gmtime(player.props.metadata['mpris:length']/1000/1000))
    else:
        length=None
    if (artist is None) & (title is None):
        return "" # No valid media data yet
    output=""
    if artist is not None:
        output+=artist+" - "
    output+=title
    output+=" ("+pos
    if length is not None:
        output+="/"+length
    output+=")"
    return output


def print_line(message):
    """ Non-buffered printing to stdout. """
    sys.stdout.write(message + '\n')
    sys.stdout.flush()

def read_line():
    """ Interrupted respecting reader for stdin. """
    # try reading a line, removing any extra whitespace
    try:
        line = sys.stdin.readline().strip()
        # i3status sends EOF, or an empty line
        if not line:
            sys.exit(3)
        return line
    # exit on ctrl-c
    except KeyboardInterrupt:
        sys.exit()

if __name__ == '__main__':
    # Skip the first line which contains the version header.
    print_line(read_line())

    # The second line contains the start of the infinite array.
    print_line(read_line())

    while True:
        line, prefix = read_line(), ''
        # ignore comma at start of lines
        if line.startswith(','):
            line, prefix = line[1:], ','

        j = json.loads(line)
        # insert information into the start of the json, but could be anywhere
        # CHANGE THIS LINE TO INSERT SOMETHING ELSE
        #j.insert(0, {'full_text' : '%s' % get_governor(), 'name' : 'gov'})

        try:
            media = get_playing_media_name()
            if media != "":
                j.insert(0, {
                    'name' : 'media',
                    #'markup' : 'pango', # Breaks with video title containing &
                    'color' : '#CCCCCC',
                    #'full_text' : '<span rise="3073">%s</span>' % video
                    'full_text' : media
                    })
        except:
            j.insert(0, {
                'name' : 'umpv',
                #'markup' : 'pango', # Breaks with video title containing &
                'color' : '#CCCCCC',
                #'full_text' : '<span rise="3073">%s</span>' % video
                'full_text' : "dangit."
                })

        # and echo back new encoded json
        print_line(prefix+json.dumps(j))
