#!/bin/sh

RWALL=$(wal ~/dwm/wallpapers/)
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
feh --bg-fill $RWALL&
urxvtd&
nm-applet&
volumeicon&
dunst&
xautolock -time 10 -locker slock&
while true; do
   xsetroot -name "$( date +"%a %d %b %I:%M" )"
   sleep 1m    # Update time every minute
done &
exec dwm
