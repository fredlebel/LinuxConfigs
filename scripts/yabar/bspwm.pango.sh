#! /usr/bin/env zsh
#

line=$(bspc wm --get-status | tr ':' ' ')

num_mon=1

DesktopClickerFull() {
    # echo "%{A:bspc desktop -f ^$1:}%{F$2}[$1]%{F-}%{A}"
    printf "<span foreground='$2'> [$1] </span>"
    if [ $1 = 2 ] || [ $1 = 7 ]; then
        printf "<span foreground='darkred'>  -  </span>"
    fi
}
DesktopClickerEmpty() {
    # echo "%{A:bspc desktop -f ^$1:}%{F$2}$1%{F-}%{A}"
    printf "<span foreground='$2'> $1 </span>"
    if [ $1 = 2 ] || [ $1 = 7 ]; then
        printf "<span foreground='darkred'>  -  </span>"
    fi
}

case $line in
    S*)
        sys_infos="${line#?}"
        ;;
    T*)
        title="${line#?}"
        ;;
    W*)
        wm_infos=""
        setopt shwordsplit
        for item in $line; do
            name=$(echo $item | cut -d'/' -f2)
            case $item in
                M*)
                    # active monitor
                    if [ $num_mon -gt 1 ] ; then
                        wm_infos="$wm_infos %{F$COLOR_ACTIVE_MONITOR_FG}%{B$COLOR_ACTIVE_MONITOR_BG} ${name} %{B-}%{F-}  "
                    fi
                    ;;
                m*)
                    # inactive monitor
                    if [ $num_mon -gt 1 ] ; then
                        wm_infos="$wm_infos %{F$COLOR_INACTIVE_MONITOR_FG}%{B$COLOR_INACTIVE_MONITOR_BG} ${name} %{B-}%{F-}  "
                    fi
                    ;;
                O*)
                    # focused occupied desktop
                    #wm_infos="$wm_infos %{F#FFFF00}[$name]%{F-}"
                    wm_infos="$wm_infos $(DesktopClickerFull $name '#FFFF00')"
                    ;;
                F*)
                    # focused free desktop
                    #wm_infos="$wm_infos %{F#FFFF00}$name%{F-}"
                    wm_infos="$wm_infos $(DesktopClickerEmpty $name '#FFFF00')"
                    ;;
                U*)
                    # focused urgent desktop
                    wm_infos="$wm_infos %{F#FFFF00}<$name>%{F-}"
                    ;;
                o*)
                    # occupied desktop
                    #wm_infos="$wm_infos %{F#808080}[$name]%{F-}"
                    wm_infos="$wm_infos $(DesktopClickerFull $name '#808080')"
                    ;;
                f*)
                    # free desktop
                    #wm_infos="$wm_infos %{F#343434}$name%{F-}"
                    wm_infos="$wm_infos $(DesktopClickerEmpty $name '#343434')"
                    ;;
                u*)
                    # urgent desktop
                    wm_infos="$wm_infos %{F#F62217}<$name>%{F-}"
                    ;;
                L*)
                    # layout
                    #wm_infos="$wm_infos       %{F#38ACEC>(${item#?})</fc>"
                    ;;
            esac
        done
        unsetopt shwordsplit
        ;;
esac
printf "%s\n" "$wm_infos $title $sys_infos"

