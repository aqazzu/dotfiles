#!/bin/sh

NAG=$1

$NAG -t warning -y overlay -e bottom -f mono -m 'Power Menu' -Z 'exit sway' 'swaymsg exit' -Z 'suspend' 'loginctl suspend' -Z 'hibernate' 'loginctl hibernate' -Z 'reboot' 'loginctl reboot' -Z 'shutdown' 'loginctl poweroff'
