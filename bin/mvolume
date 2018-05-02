#!/bin/sh
#| File    : ~/.local/bin/mvolume
#| Author  : Fabien Cazenave
#| Source  : https://github.com/fabi1cazenave/dotFiles
#| Licence : WTFPL
#|
#| Helper script to control the master volume:
#|   ./mvolume [raise|lower|mute]
#|
#| alternative syntax:
#|   ./mvolume +           # raise volume 1%
#|   ./mvolume -           # lower volume 1%
#|   ./mvolume /           # toggle mute
#|

show_usage() {
  echo "usage: $0 [raise|lower|mute]" && exit 1
}

command_exists() {
  command -v "$1" > /dev/null 2>&1
}

# pulseaudio?
# see also: http://ubuntuforums.org/showpost.php?p=10232181&postcount=9
if command_exists pactl ; then
  case $1 in

    # pulseaudio 8.0 (Ubuntu 16.04)
    +|raise) pactl set-sink-volume @DEFAULT_SINK@ +1% ;;
    -|lower) pactl set-sink-volume @DEFAULT_SINK@ -1% ;;
    /|mute)  pactl set-sink-mute   @DEFAULT_SINK@ toggle ;;

    # pulseaudio 4.0 (Ubuntu 14.04)
    # +|raise) pactl set-sink-volume @DEFAULT_SINK@ -- +1% ;;
    # -|lower) pactl set-sink-volume @DEFAULT_SINK@ -- -1% ;;
    # /|mute)  pactl set-sink-mute   @DEFAULT_SINK@ toggle ;;

    # pulseaudio 1.1 (Ubuntu 12.04)
    # +|raise) pactl set-sink-volume @DEFAULT_SINK@ -- +1% ;;
    # -|lower) pactl set-sink-volume @DEFAULT_SINK@ -- -1% ;;
    # /|mute)
    #   toggle=`pacmd dump | awk '$1~/set-sink-mute/{ print ($3 == "no") }'`
    #   pactl set-sink-mute @DEFAULT_SINK@ $toggle ;;

    *) show_usage ;;
  esac

# alsa mixer?
elif command_exists amixer ; then
  case $1 in
    +|raise) amixer -q sset Master 1%+ ;;
    -|lower) amixer -q sset Master 1%- ;;
    /|mute)  amixer -q sset Master toggle ;;
    *) show_usage ;;
  esac

# no sound controller available
else
  echo "could not find pulseaudio 'pactl' nor alsa 'amixer'." && exit 1
fi

