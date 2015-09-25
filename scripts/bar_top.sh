#! /usr/bin/env zsh
#

. bar_fragments.sh

while true; do
  cpu_=$(Cpu_)
  net_=$(Net_)
  sleep 1;
  echo "%{l}$(Bspwm)%{r}$(Cpu $cpu_) | $(Mem) | $(Swap) | $(Disk /dev/sda1 Disk) | $(Net $net_) | $(Date) "
done

