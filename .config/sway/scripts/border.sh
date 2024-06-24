#!/bin/sh

current_border_mode="$(swaymsg -t get_tree | jq -r '.. | select(.type?) | select(.focused==true).border')"

case $current_border_mode in
    normal) border_mode=pixel ;;
    *) border_mode=normal ;;
esac

swaymsg [workspace=.] border $border_mode
swaymsg [workspace=.] default_border $border_mode
