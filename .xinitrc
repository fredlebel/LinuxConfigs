#!/bin/sh

# /usr/bin/VBoxClient-all
# VBoxClient-all &
if [ -e $HOME/.profile ]
then
    . $HOME/.profile
fi
xsetroot -cursor_name left_ptr
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
# xcompmgr -n &
# trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 6 --transparent true --alpha 0 --tint 0x000000 --height 16 &
sh ~/.fehbg &
export EDITOR=vi
#exec xmonad
#exec awesome
#compton -c -o 1 -C -f -i 0.65 &
if [ "$(hostname)" = nixos ]; then
  compton -c -o 1 -C -f -b
else
  compton -c -o 1 -C -f --vsync drm -b
fi
sxhkd -f 35 &
reset-bars
#xmobar .xmobarrc        -d &
#xmobar .xmobarrc_bottom -d &
#xrandr --output "VGA-0" --auto --output "VGA-1" --auto --right-of "VGA-0"
mpd
exec bspwm

