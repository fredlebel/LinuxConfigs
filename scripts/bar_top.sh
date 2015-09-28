#! /usr/bin/env zsh
#

. bar_fragments.sh

sep="%{F#606060}|%{F-}"

while true; do
  cpu_=$(Cpu_)
  net_=$(Net_)
  sleep 1;
  echo "%{l}$(Bspwm)%{r}$(Cpu $cpu_) $sep $(Mem) $sep $(Swap) $sep $(Disk /dev/mapper/vg-root Disk) $sep $(Ssid) $(Net $net_) $sep $(Temp) $sep $(Brightness) $sep $(Power) $sep $(Battery) $sep $(Date) "
done

