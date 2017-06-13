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
if [ "$(hostname)" = turing ]; then
  compton -c -o 1 -C -f -b --config ~/.config/compton.conf
else
  compton -c -o 1 -C -f --vsync drm -b --config ~/.config/compton.conf
fi
sxhkd -f 35 &
reset-bars
#xmobar .xmobarrc        -d &
#xmobar .xmobarrc_bottom -d &
#xrandr --output "VGA-0" --auto --output "VGA-1" --auto --right-of "VGA-0"
#xrandr --output "DP1" --auto --output "HDMI1" --auto --right-of "DP1" --output "HDMI2" --auto --left-of "DP1"
xrandr --output "HDMI2" --auto --pos 0x1136 --output "DP1" --primary --auto --pos 1280x0 --output "HDMI1" --auto --pos 5120x800
mpd &
exec bspwm

