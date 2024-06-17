#!/bin/sh

# 0 means enabled cache (default)
# 1 means disabled cache

cacheroot="/home/rikou/.cache/lf"
cachebit="$cacheroot/cache"

if [ ! -e $cachebit ]; then
    echo 0 > $cachebit
elif [ $(cat $cachebit) -eq 1 ]; then
    echo 0 > $cachebit
else
    echo 1 > $cachebit
fi
