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

# Get rid of lesspipe
unset LESSOPEN
# I like having local binaries.
#export PATH="$HOME/bin:$PATH" # Apparently I end up having this path set up thrice in this environment variable lol
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
# Vulkan driver on Nvidia does not feel like working if there are any other present,
# and this gets it going anyways lol
# export VK_ICD_FILENAMES='/usr/share/vulkan/icd.d/nvidia_icd.json'

# Honestly I don't know what I was doing  here.
#export WINEPREFIX_POL="$WINEPREFIX"
#export WINEPREFIX_NORM="$HOME/.wine"
#export WINEPREFIX=$WINEPREFIX_NORM

# Set environment variables related to GUIs
# Some fixes to make custom compose key sequences from .XCompose work
export XMODIFIERS="@im=none"
export GTK_IM_MODULE="xim"
export QT_IM_MODULE="xim"
# Use qt5ct for customization
export QT_QPA_PLATFORMTHEME="qt5ct"
# Below can be useful to specify DPI to Qt
#export QT_FONT_DPI=72
# Some Qt applications can break with different font DPI; this fixes that
#export QT_AUTO_SCREEN_SCALE_FACTOR=0

# Disable .NET telemetry
export DOTNET_CLI_TELEMETRY_OPTOUT=1
