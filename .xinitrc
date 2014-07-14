# /usr/bin/VBoxClient-all
VBoxClient-all &
xsetroot -cursor_name left_ptr
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
xcompmgr -n &
# trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 6 --transparent true --alpha 0 --tint 0x000000 --height 16 &
# exec xmonad
sh ~/.fehbg &


