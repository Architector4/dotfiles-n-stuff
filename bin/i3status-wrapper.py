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

debug = False
if len(sys.argv) >= 2:
    if sys.argv[1] == "debug":
        debug = True

si_units = ["", "K", "M", "G", "T"]

def conv_si(num):
    """
    Convert input number to a shorter string with a SI unit postfix.
    Does not support float values.
    """
    for iteration, unit in enumerate(si_units):
        if num < 10000 or unit == si_units[-1]:
            return str(num)+unit
        num = num//1000

def get_max_frequency():
    """ Get the maximum allowed frequency for cpu0, assuming all CPUs use the same. """
    with open ('/sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq') as fp:
        return int(fp.readlines()[0].strip())*1000

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
    players = []
    if debug:
        names=[0]
    else:
        names=Playerctl.list_players()
    for name in names: # Iterate over every media player
        try: # A media player's properties may sometimes be unavailable for some reason
            if debug:
                class Wet:
                    metadata = {"mpris:length": 10000039}
                    status = "Playing"
                class Woot:
                    props = Wet
                    def get_title():
                        return "title"
                    def get_artist():
                        return "artist"
                    def get_position():
                        return 9999999
                player = Woot
            else:
                player = Playerctl.Player.new_from_name(name)
            try: # Try getting title
                title = player.get_title()
                if len(title)==0: # Title is empty
                    continue
            except InterruptedError: # Couldn't get title - happens when there is no media player.
                continue
            artist = player.get_artist()
            try:
                pos = time.strftime("%H:%M:%S", time.gmtime(max(player.get_position()/1000000, 0)))
            except gi.repository.GLib.Error: # Player position may be not supported
                pos = None
            if 'mpris:length' in player.props.metadata.keys():
                length = time.strftime("%H:%M:%S", time.gmtime(player.props.metadata['mpris:length']/1000000))
            else:
                length=None
            if (artist is None) & (title is None):
                continue
                #return "" # No valid media data yet
            output=""
            if artist is not None:
                if len(artist)>0:
                    output+=artist+" - "
            output+=title
            if pos is not None:
                output+=" ("+pos
                if length is not None:
                    output+="/"+length
                output+=")"
            players.append( (output, player.props.status) )
        except InterruptedError:
            players.append( ("?", "?") )
            continue
    return players


def print_line(message):
    """ Non-buffered printing to stdout. """
    sys.stdout.write(message + '\n')
    sys.stdout.flush()

def read_line():
    """ Interrupted respecting reader for stdin. """
    if debug:
        return """,[{"name": "media", "color": "#AAFFAA", "full_text": "Venetian Snares - MORE DRUG N BASS (00:03:21/00:05:19)"}, {"name": "max_freq", "color": "#CCCCCC", "full_text": "4829MHz"}, {"name": "ethernet", "instance": "wg0", "color": "#00FF00", "markup": "none", "full_text": "WG: 10.169.199.25"}, {"name": "ipv6", "color": "#FF0000", "markup": "none", "full_text": ""}, {"name": "ethernet", "instance": "eno1", "color": "#00FF00", "markup": "none", "full_text": "E: 192.168.1.144"}, {"name": "wireless", "instance": "_first_", "color": "#FF0000", "markup": "none", "full_text": ""}, {"name": "disk_info", "instance": "/mnt", "markup": "none", "full_text": ""}, {"name": "disk_info", "instance": "/media/freebsd", "markup": "none", "full_text": ""}, {"name": "disk_info", "instance": "/media/ext_hdd", "markup": "none", "full_text": "EX 1.2 TiB"}, {"name": "disk_info", "instance": "/", "markup": "none", "full_text": "252.2 GiB"}, {"name": "volume", "instance": "pulse.Master.0", "markup": "none", "full_text": "\u266a 35%"}, {"name": "cpu_usage", "markup": "none", "full_text": "CPU 06%"}, {"name": "battery", "instance": "/sys/class/power_supply/BAT0/uevent", "markup": "none", "full_text": "BAT 49.69% 0.00W"}, {"name": "tztime", "instance": "local", "markup": "none", "full_text": "Fri Jun, 2024-06-14, 10:04:38"}]"""
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
        j.insert(0, {
            'name' : 'max_freq',
            'color': '#CCCCCC',
            'full_text': conv_si(get_max_frequency())+"Hz"
            })

        players = get_playing_media_name()
        for i, media in enumerate(players):
            if media[0] != "":

                # Probably can be helped with Python 3.10 match-case...
                if media[1] == 'Playing':
                        color = '#AAFFAA'
                else:
                    if i%2 == 0:
                        color = '#CCCCCC'
                    else:
                        color = '#AAAAAA'


                j.insert(0, {
                    'name' : 'media',
                    #'markup' : 'pango', # Breaks with video title containing &
                    'color' : color,
                    #'full_text' : '<span rise="3073">%s</span>' % video
                    'full_text' : media[0]
                    })

        # and echo back new encoded json
        print_line(prefix+json.dumps(j))
