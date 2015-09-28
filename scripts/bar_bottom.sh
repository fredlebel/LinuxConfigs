#! /usr/bin/env bash
#

. bar_fragments.sh

wallpaperStr=$(Wallpaper)
sep="%{F#606060}|%{F-}"

while true; do
  echo "%{l}$wallpaperStr $sep $(CurrentIp)%{r}$(MusicStatus)"
  sleep 1;
done

