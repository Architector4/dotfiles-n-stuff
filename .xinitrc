#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi
if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi
if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi
if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# For when I start X from a directory other than ~
cd
# Xorg on FreeBSD doesn't seem to remember this setting
xinput set-prop "System mouse" "libinput Accel Speed" -1
# Calibrate touchscreen
xinput --map-to-output 'ELAN0732:00 04F3:251C' eDP-1
# What, you thought this isn't going to be another generic "dotfiles" repo with "i3" at the end of .xinitrc?
exec i3
