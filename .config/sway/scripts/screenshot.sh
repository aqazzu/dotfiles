#!/bin/sh

COMMAND=$1
IMG=$(xdg-user-dir PICTURES)/screenshots/$(date +"screenshot_%Y%m%d_%H%M%S_%N.png")

notify(){
$(notify-send "Screenshot taken" "Saved: $IMG" -A "open $IMG=open" -i image -t 3000)
}

#COMMAND functions:

fullscreen(){
    grim -c $IMG
    wl-copy < $IMG
    notify
}

region(){
    grim -c -g "$(slurp -d)" $IMG
    wl-copy < $IMG
    notify
}

$COMMAND
