# Edited by Architector #4. wadsadwadasdawd
# Based on default Ubuntu 18.04 .bashrc

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# Start .profile even if this is a non-login shell
. ~/.profile

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Enable completion features (YES PLEASE DO)
# Apparently Arch enables this already lol
#[[ $PS1 && -f /usr/local/share/bash-completion/bash_completion.sh ]] && \
	#source /usr/local/share/bash-completion/bash_completion.sh

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# Eternal bash history.
# ---------------------
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

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


# Mount a device with safe parameters and have it belong to me so that I can write to it
alias mountusb="sudo mount --options utf8,uid=$UID,nodev,nosuid,flush"
# Watch the size of the unwritten filesystem cache - starts to rapidly decay to 0kB when running "sync".
alias syncwatch="watch -n0.5 grep Dirty /proc/meminfo"
# CPU speed options (cpupower caps out at minimum/maximum values anyways)
alias cpuslow="sudo cpupower frequency-set -u 1M"
alias cpumeh="sudo cpupower frequency-set -u 1900M"
alias cpuquiet="sudo cpupower frequency-set -u 3000M"
alias cpufast="sudo cpupower frequency-set -u 10000M"
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
# Use AMDVLK instead of Mesa's RADV for Vulkan - gives less performance, but why not.
alias amdvlk='export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/amd_icd64.json:/usr/share/vulkan/icd.d/amd_icd32.json'
# Use TkGlitch's version of AMDVLK for Vulkan
alias amdvlk-tkg='export VK_ICD_FILENAMES=/opt/amdvlk/etc/vulkan/icd.d/amd_icd64.json:/opt/amdvlk/etc/vulkan/icd.d/amd_icd32.json'
# Make cp do reflinks by default
# This is not needed on GNU coreutils v9.0 or later
alias cp="cp --reflink=auto"
# Fill the screen with character "EEEE" (calibration test)
alias EEEEE="echo -e '\e#8'"
# Open to-do file
alias todo="vim ~/Documents/todo.txt"

# "mkcd" to mkdir and then cd to the result
mkcd() { mkdir "$@"&&cd "$@";}
# "cdls" to cd and ls straight up
cdls() { cd "$@"&&ls;}


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

# For Kitty terminal emulator - plot a function real quick
function iplot {
    echo "
    set terminal pngcairo enhanced font 'Fira Sans,10'
    set autoscale
    set samples 1000
    set output '|kitty +kitten icat --stdin yes'
    set object 1 rectangle from screen 0,0 to screen 1,1 fillcolor rgb'#fdf6e3' behind
    plot $@
    set output '/dev/null'
    " | gnuplot
}
