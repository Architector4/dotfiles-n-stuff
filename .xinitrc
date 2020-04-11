# For when I start X from a directory other than ~
cd
# Some fixes to make custom compose key sequences from .XCompose work
export XMODIFIERS="@im=none"
export GTK_IM_MODULE="xim"
export QT_IM_MODULE="xim"
export QT_QPA_PLATFORMTHEME="qt5ct"
# What, you thought this isn't going to be another generic "dotfiles" repo with "i3" at the end of .xinitrc?
i3
