#! /usr/bin/env zsh
#

music_name="$(mpc current)"
music_progress="$(mpc | head -n 2 | tail -n 1 | sed 's/  / /g')"
music_state="$(mpc | head -n 2 | tail -n 1 | cut -d '[' -f2 | cut -d ']' -f1)"
if [[ -n "$music_name" ]]; then
    template="%{A:mpc prev:}%{F#00FFFF}<|%{F-}%{A}"
    template="$template %{A:mpc toggle:}"
if [[ $music_state == "playing" ]]; then
    template="$template %{F#FFFF00}$music_name%{F-} | %{F#80FF80}$music_progress%{F-}"
elif [[ $music_state == "paused" ]]; then
    template="$template %{F#888888}$music_name%{F-} | %{F#888888}$music_progress%{F-}"
fi
    template="$template %{A}%{A:mpc next:}%{F#00FFFF} |> %{F-}%{A} "
else
    template="%{F#808080}no music%{F-}"
fi
printf $template
