#!/bin/sh

VALUE=$1
WOBSOCK=$XDG_RUNTIME_DIR/wob.sock

brightnessctl s $VALUE | sed -En 's/.*\(([0-9]+)%\).*/\1/p' > $WOBSOCK
