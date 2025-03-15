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

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# Not needed anymore since I have figured how to do it in /etc/vconsole.conf
#setfont /usr/share/kbd/consolefonts/Cyr_a8x16.psfu.gz

# Notify if I have more than 1GB of stuff in the trash folder.
trashweight=$(du -sht 1G ~/.local/share/Trash | cut -f1)
if [ -n "$trashweight" ]; then
	echo "Your trash folder weighs $trashweight btw"
fi
unset trashweight

# Get rid of lesspipe
unset LESSOPEN
# Vim is goot.
export EDITOR=vim
# Stop WINE from creating desktop shortcuts, menu entries and other stuff.
export WINEDLLOVERRIDES=winemenubuilder.exe=d
# Apparently this makes stuff faster lol
# But it's default since Mesa 20.2 so worth disabling now lol
#export RADV_PERFTEST=aco
# Apparently this makes stuff even faster xd
export WINEFSYNC=1
export WINEESYNC=1
# Fix Java fonts lol
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
# Timidity needs this to properly read my config apparently
export MMPAT_PATH_TO_CFG=/etc/timidity++
# Enable smooth touchpad scrolling on Firefox
export MOZ_USE_XINPUT2=1
# Make applications using winit not care about DPI
export WINIT_X11_SCALE_FACTOR=1
# Disable .NET telemetry
export DOTNET_CLI_TELEMETRY_OPTOUT=1
# New Python 3.13 REPL has its own bespoke set of behavior that conflicts with my GNU readline muscle memory
export PYTHON_BASIC_REPL=1
