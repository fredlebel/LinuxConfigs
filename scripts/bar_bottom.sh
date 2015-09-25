#! /usr/bin/env bash
#

. bar_fragments.sh

wallpaperStr=$(Wallpaper)

while true; do
  echo "%{l}$wallpaperStr | $(CurrentIp)%{r}$(MusicStatus)"
  sleep 1;
done

