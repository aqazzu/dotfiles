#!/bin/sh

VALUE=$1
WOBSOCK=$XDG_RUNTIME_DIR/wob.sock

get_vol(){
    raw_vol=$(wpctl get-volume @DEFAULT_SINK@ | tr -d . | cut -d" " -f2)
    if [ "$raw_vol" -lt 100 ]; then
        echo "$raw_vol" | cut -c 2-
    else
        echo "$raw_vol"
    fi
}

OLD_VOL=$(get_vol)
CLEAN_VALUE=$(echo "$VALUE" | rev | cut -c 2- | rev)

if [ $(( $OLD_VOL + $CLEAN_VALUE )) -le "100" ]; then
    pactl set-sink-volume @DEFAULT_SINK@ $VALUE
else
    pactl set-sink-volume @DEFAULT_SINK@ 100%
fi
get_vol > $WOBSOCK
