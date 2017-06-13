#! /usr/bin/env zsh
#


. bar_fragments.sh

wallpaperStr=$(Wallpaper)
sep="%{F#606060}|%{F-}"

while true; do
    echo " %{l} $(UpTime) $sep $wallpaperStr $sep $(IpAddresses)%{r}$(MusicStatus)"
  sleep 1;
done

