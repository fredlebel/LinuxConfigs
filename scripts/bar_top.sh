#! /usr/bin/env zsh
#

. bar_fragments.sh

sep="%{F#606060}|%{F-}"

while true; do
  if [ "$(hostname)" = nixos ]; then
    cpu_=$(Cpu_)
    net_=$(Net_ enp0s3)
    sleep 1;
    echo "%{l}$(Bspwm)%{r}$(Cpu $cpu_) $sep $(Mem) $sep $(Swap) $sep $(Disk /dev/sda1 Disk) $sep $(Net $net_ enp0s3) $sep $(Date) "
  else
    cpu_=$(Cpu_)
    net_=$(Net_ wlp2s0)
    sleep 1;
    echo "%{l}$(Bspwm)%{r}$(Cpu $cpu_) $sep $(Mem) $sep $(Swap) $sep $(Disk /dev/mapper/MyStorage-rootvol Disk) $sep $(Ssid) $(Net $net_ wlp2s0) $sep $(Temp) $sep $(Brightness) $sep $(Power) $sep $(Battery) $sep $(Date) "
  fi
done

