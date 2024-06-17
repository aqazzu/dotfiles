#!/bin/sh

VALUE=$1
WOBSOCK=$XDG_RUNTIME_DIR/wob.sock

get_vol(){
    wpctl get-volume @DEFAULT_SINK@ | tr -d . | cut -d" " -f2
}

pactl set-sink-volume @DEFAULT_SINK@ $VALUE
get_vol > $WOBSOCK
