#!/bin/sh

set -e

for idx in 2 3 4
do
    dev="lo$idx"
    if ip link show "$dev" >/dev/null
    then
        ip link del "$dev"
    fi
done
