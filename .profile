# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# Set language
export LANG=en_US.utf8
export LC_ALL=$LANG
export LANGUAGE=$LANG

#if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Not needed anymore since I have figured how to do it in /etc/vconsole.conf
#setfont /usr/share/kbd/consolefonts/Cyr_a8x16.psfu.gz

# Notify if I have more than 1GB of stuff in the trash folder.
trashweight=$(du -sht 1G ~/.local/share/Trash | cut -f1)
if [ -n "$trashweight" ]; then
	echo "Your trash folder weighs $trashweight btw"
fi
unset trashweight

# Set environment variables related to GUIs
# Some fixes to make custom compose key sequences from .XCompose work
export XMODIFIERS="@im=none"
export GTK_IM_MODULE="xim"
export QT_IM_MODULE="xim"
# Use qt5ct for customization
export QT_QPA_PLATFORMTHEME="qt5ct"
# Fix KeepAssXC from messing up its interface when X is launched with --dpi 72
export QT_AUTO_SCREEN_SCALE_FACTOR=0
# Fix qt5 ignoring my DPI setting by explicitly pointing it out to qt too
export QT_FONT_DPI=72
