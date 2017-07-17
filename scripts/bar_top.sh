#! /usr/bin/env zsh
#

. bar_fragments.sh

sep="%{F#606060}|%{F-}"

while true; do
  if [ "$(hostname)" = turing ]; then
    cpu_=$(Cpu_)
    net_=$(Net_ enp0s31f6)
    sleep 1;
    echo "%{l}$(ResetBar) %{c} $(Bspwm)%{r}$(Cpu $cpu_) $sep $(Mem) $sep $(Disk /home Root) $(Disk /data Data) $sep $(Net $net_ enp0s31f6) $sep $(Date) "
    # echo "%{l}$(ResetBar) $(Bspwm)%{r}$(Cpu $cpu_) $sep $(Mem) $sep $(Disk /dev/sda3 Disk) $sep $(Net $net_ enp0s31f6) $sep $(VolumeStatus) $sep $(Date) "
  else
    cpu_=$(Cpu_)
    net_=$(Net_ wlp2s0)
    sleep 1;
    echo "%{l}$(Bspwm)%{r}$(Cpu $cpu_) $sep $(Mem) $sep $(Swap) $sep $(Disk /dev/mapper/MyStorage-rootvol Disk) $sep $(Ssid) $(Net $net_ wlp2s0) $sep $(Temp) $sep $(Brightness) $sep $(Power) $sep $(Battery) $sep $(Date) "
  fi
done

