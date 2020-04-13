# Edited by Architector #4. wadsadwadasdawd
# Based on default Ubuntu 18.04 .bashrc

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=32768
HISTFILESIZE=$HISTSIZE

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Prompt
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Make man pages colorful.
man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}


# Enable vi-like bindings in Bash when you press ESC or some other keys.
set -o vi
# vi mode kills CTRL+L to clear screen gODDAMMIT lets fix
bind -m vi-insert "\C-l":clear-screen

#############################################################################
## REMINDER FOR MYSELF: PUT NON-BASH-SPECIFIC ALIASES AND STUFF INTO .profile
#############################################################################
# Actually screw it, I use only Bash anyways lol

# I like having local binaries.
#export PATH="$HOME/bin:$PATH" # Apparently I end up having this path set up thrice in this environment variable lol
# Vim is goot.
export EDITOR=vim
# Stop WINE from creating desktop shortcuts, menu entries and other stuff.
export WINEDLLOVERRIDES=winemenubuilder.exe=d
# Apparently this makes stuff faster lol
export RADV_PERFTEST=aco
# Fix Java fonts lol
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
# Timidity needs this to properly read my config apparently
export MMPAT_PATH_TO_CFG=/etc/timidity++

# Honestly I don't know what I was doing  here.
#export WINEPREFIX_POL="$WINEPREFIX"
#export WINEPREFIX_NORM="$HOME/.wine"
#export WINEPREFIX=$WINEPREFIX_NORM

# Mount a device with safe parameters and have it belong to me so that I can write to it
alias mountusb="sudo mount --options utf8,uid=$UID,nodev,nosuid,flush"
# Watch the size of the unwritten filesystem cache - starts to rapidly decay to 0kB when running "sync".
alias syncwatch="watch -n0.5 grep Dirty /proc/meminfo"
# ...
alias sl="ls"
# Because I use cyrillic sometimes even when I don't need to use cyrillic.
alias ды="ls"
# If it isn't obvious already I don't like sl.
alias ыд="ls"
# Turn the favorite Vi/Vim command into something that works here too.
alias :q="exit"
# Mondays first.
alias cal="cal -m"
# Allow feh to use imagemagick to convert an image to something readable to it.
alias feh="feh --conversion-timeout 1"
# This Proton trick actually works, but I'm fine with vanilla Wine now.
#alias wine="~/.steam/steam/steamapps/common/Proton\ 4.2/dist/bin/wine"
# To speed up opening files. This actually doesn't work in non-interactive
# shells, so I've decided to instead create symlinks with these names
# to provide equivalent functionality in all cases.
#alias o="exo-open" 
#alias о="exo-open" # Russian о here.

# "mkcd" to mkdir and then cd to the result
mkcd() { mkdir "$@";cd "$@";}
# "cdls" to cd and ls straight up
cdls() { cd "$@";ls;}


# taken from
# https://www.reddit.com/r/bash/comments/ebuw3h/mocking_case_generator/
# thaks man
mocking() {
  awk 'BEGIN {srand()} {
    j = rand() > .5
    n = split($0, a, "")
    for(i=0; i<=n; i++)
      out = out ((j = ++j % 2)? tolower(a[i]): toupper(a[i]))
    print out; out = ""
  }'
}

# In case I accidentally use sudo where I can't use sudo
case "$(hostname)" in
	"tilde"|"bsd")
		alias sudo="echo YOU HAVE NO POWER HERE.; false"
		;;
esac
