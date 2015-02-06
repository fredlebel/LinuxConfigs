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
compton -c -o 1 -C -f -i 0.65 &
sxhkd -f 100 &
xmobar .xmobarrc        -d &
xmobar .xmobarrc_bottom -d &
exec bspwm

