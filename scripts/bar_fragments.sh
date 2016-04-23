#! /usr/bin/env zsh
#

Human() {
    echo $1 | awk '
    function human(x) {
        s="BkMGTEPYZ";
        while (x>=1000 && length(s)>1)
            {x/=1024; s=substr(s,2)}
        return int(x+0.5) substr(s,1,1)
    }
    {sub(/^[0-9]+/, human($1)); print}'
}

RndWP() {
    echo "%{A:rnd_wallpaper.sh ~/Wallpapers/$1:}%{Fwhite}$2%{F-}%{A}"
}

Wallpaper() {
    template="Wallpapers: ["

    template="$template$(RndWP Gradients grad), "
    template="$template$(RndWP Abstract abs), "
    template="$template$(RndWP Landscapes land), "
    template="$template$(RndWP SciFi sci), "
    template="$template$(RndWP Closeups close), "
    template="$template$(RndWP Pix pix), "
    template="$template$(RndWP Art art)"

    template="$template]"

    echo $template
}

CurrentIp() {
    IP=$(ip addr show | grep global | grep -P '\d+\.\d+\.\d+\.\d+' -o | head -n 1)
    echo "%{F#ffffff}IP: %{F-}%{F#ffff22}$IP%{F-}"
}

MusicStatus() {
  music_name="$(mpc current)"
  music_progress="$(mpc | head -n 2 | tail -n 1 | sed 's/%/%%/g')"
  music_state="$(mpc | head -n 2 | tail -n 1 | cut -d '[' -f2 | cut -d ']' -f1)"
  if [ -n "$music_name" ]; then
    template="%{A:mpc prev:}%{F#00FFFF} <|%{F-}%{A}"
    template="$template %{A:mpc toggle:}"
    if [ $music_state == "playing" ]; then
      template="$template %{F#FFFF00}$music_name%{F-} | %{F#80FF80}$music_progress%{F-}"
    elif [ $music_state == "paused" ]; then
      template="$template %{F#888888}$music_name%{F-} | %{F#888888}$music_progress%{F-}"
    fi
    template="$template %{A}%{A:mpc next:}%{F#00FFFF} |> %{F-}%{A} "
  else
    template="%{F#808080}no music%{F-}"
  fi
  echo $template
}

Date() {
    dateStr=$(date "+%A %b %d %H:%M:%S")
    echo "%{Forange}$dateStr%{F-}"
}

Cpu_() {
    grep 'cpu ' /proc/stat
}

Cpu() {
    cpuVal=$(cat <(echo $1) <(echo $(Cpu_)) | awk -v RS="" '{printf("%.0f", ($13-$2+$15-$4)*100/($13-$2+$15-$4+$16-$5))}')
    if (( cpuVal > 75 )); then
        echo "Cpu: %{F#ff4444}$cpuVal%%%{F-}"
    else
        echo "Cpu: %{F#00ff00}$cpuVal%%%{F-}"
    fi
}

Mem() {
    totalMem=$(free | tail -n2 | head -n1 | gawk '{print $2}')
    freeMem=$(free | tail -n2 | head -n1 | gawk '{print $7}')
    totalReadable=$(free -h | tail -n2 | head -n1 | gawk '{print $2}')
    freeReadable=$(free -h | tail -n2 | head -n1 | gawk '{print $7}')
    if (( freeMem * 100 / totalMem < 25 )); then
        echo "Mem free: %{F#ff4444}$freeReadable%{F-}"
    else
        echo "Mem free: %{F#00ff00}$freeReadable%{F-}"
    fi
}

Swap() {
    totalMem=$(free | tail -n1 | gawk '{print $2}')
    usedMem=$(free | tail -n1 | gawk '{print $3}')
    totalReadable=$(free -h | tail -n1 | gawk '{print $2}')
    usedReadable=$(free -h | tail -n1 | gawk '{print $3}')
    if (( usedMem * 100 / totalMem > 25 )); then
        echo "Swap: %{F#ff4444}$usedReadable%{F-}"
    else
        echo "Swap: %{F#00ff00}$usedReadable%{F-}"
    fi
}

Disk() {
    diskUsage=$(df $1 | tail -n1 | awk '{printf "%.0f", 100-$4/$2*100}')
    readableFree=$(df -h $1 | tail -n1 | awk '{print $4}')
    if (( diskUsage > 90 )); then
        echo "$2: %{F#ff4444}$diskUsage%% $readableFree%{F-}"
    else
        echo "$2: %{F#00ff00}$diskUsage%% $readableFree%{F-}"
    fi
}

Net_() {
    ifconfig $1 | grep packets | awk '{print $5}' | awk -v RS="" '{printf "%s %s", $1, $2}'
}

Net() {
    net_2=$(Net_ $2)
    netRx=$(cat <(echo $1) <(echo $net_2) | awk -v RS="" '{printf "%sK", int(($3-$1)/1000)}')
    netTx=$(cat <(echo $1) <(echo $net_2) | awk -v RS="" '{printf "%sK", int(($4-$2)/1000)}')
    networkUsage="%{F#00ff00}$netRx%{F-}/%{F#00ff00}$netTx%{F-}"
    # Used to minimize shifting in bar.
    paddedLength=$(echo $((${#networkUsage} - ${#netRx} - ${#netTx} + 5))s)
    printf "Net: %$paddedLength" "$networkUsage"
}

Ssid() {
    ssid=$(iwgetid | cut -d'"' -f2)
    if [ -n "$ssid" ]; then
        echo "((%{F#00ff00}$ssid%{F-}))"
    else
        echo "((%{F#ff4444}No wifi%{F-}))"
    fi
}

Battery() {
    capacity=$(cat /sys/class/power_supply/BAT0/capacity)
    if (( capacity < 15 )); then
        echo "Battery: %{F#ff4444}$capacity%%%{F-}"
    else
        echo "Battery: %{F#00ff00}$capacity%%%{F-}"
    fi
}

Power() {
    power=$(cat /sys/class/power_supply/BAT0/power_now | awk '{printf "%.1f", ($1 / 1000000)}')
    if (( power > 10 )); then
        echo "%{F#ff4444}$power%{F-} W"
    else
        echo "%{F#00ff00}$power%{F-} W"
    fi
}

Temp() {
    temp=$(cat /sys/class/thermal/thermal_zone2/temp)
    temp=$(( temp / 1000 ))
    if (( temp > 56 )); then
        echo "Temp: %{F#ff4444}$temp°%{F-}"
    else
        echo "Temp: %{F#00ff00}$temp°%{F-}"
    fi
}

Brightness() {
    val=$(xbacklight | awk '{print int($1)}')
    echo "Brightness: %{F#00ff00}$val%{F-}%%"
}

DesktopClickerFull() {
    echo "%{A:bspc desktop -f ^$1:}%{F$2}[$1]%{F-}%{A}"
}

DesktopClickerEmpty() {
    echo "%{A:bspc desktop -f ^$1:}%{F$2}$1%{F-}%{A}"
}

Bspwm() {
    line=$(bspc wm --get-status | tr ':' ' ')

    num_mon=1

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
    printf "%s" "$wm_infos $title $sys_infos"
}

