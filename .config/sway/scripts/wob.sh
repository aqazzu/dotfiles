#!/bin/sh

WOBSOCK=$XDG_RUNTIME_DIR/wob.sock

if [ ! -e $WOBSOCK ]; then
    mkfifo $WOBSOCK
    echo "wob socket created!"
else
    echo "wob socket exists!"
fi

tail -f $WOBSOCK | wob
