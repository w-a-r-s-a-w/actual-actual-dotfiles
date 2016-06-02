#!/bin/sh
# start some nice programs

 if [ -d /etc/X11/xinit/xinitrc.d ] ; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
   [ -x "$f" ] && . "$f"
  done
  unset f
 fi

# wallpaper
hsetroot -tile '/home/pouncelciot/Pictures/Wallpapers/04017_matherpoint_1920x1080.jpg'   

# custom PATHs
export PATH=$PATH:~/bin:~/colorscripts

# X settings
xsetroot -cursor_name left_ptr &
xset +fp /usr/share/fonts/local
xset +fp /usr/share/fonts/bitmap
xset fp rehash
xset r rate 275 30
xrdb -merge ~/.Xresources

# WM and more

# keybind daemon
sxhkd &

# urxvt daemon
urxvtd &

# execute i3
# exec i3

# execute wm on bg
# 2bwm &

# execute term on fg ( to keep X alive )
# exec urxvt

# exec openbox
exec openbox-session

# tint2
