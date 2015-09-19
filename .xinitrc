#!/bin/sh

# /usr/bin/VBoxClient-all
VBoxClient-all &
xsetroot -cursor_name left_ptr
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
# xcompmgr -n &
# trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 6 --transparent true --alpha 0 --tint 0x000000 --height 16 &
sh ~/.fehbg &
export EDITOR=vi
#exec xmonad
#exec awesome
#compton -c -o 1 -C -f -i 0.65 &
compton -c -o 1 -C -f &
sxhkd -f 35 &
xmobar .xmobarrc        -d &
xmobar .xmobarrc_bottom -d &
#xrandr --output "VGA-0" --auto --output "VGA-1" --auto --right-of "VGA-0"
mpd
exec bspwm

