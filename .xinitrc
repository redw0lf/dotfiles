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

exec udiskie --use-udisks2 &
exec sh ~/.screenlayout/primary.sh &
exec xautolock -time 10 -locker "i3lock-fancy-rapid 4 3 -t 'Good Luck'" -detectsleep -corners +00- &
exec nm-applet &
exec /home/janosch/bin/unity_glitch_fix.sh & 
exec ~/.fehbg &
exec setxkbmap -layout "us,us,de" -variant ",colemak_dh,"  &
exec i3
