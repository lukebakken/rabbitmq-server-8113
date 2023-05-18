#!/bin/sh

set -e

for idx in 2 3 4
do
    dev="lo$idx"
    if ! ip link show "$dev" >/dev/null
    then
        ipaddr="127.0.0.$idx"
        ip link add name "$dev" type dummy
        ip addr add "$ipaddr/8" dev "$dev"
        ip link set "$dev" up
    fi
    echo "------------------------------------------------------------------------"
    echo "DEV $dev INFO:"
    ip link show "$dev"
    ip addr show "$dev"
done
echo "------------------------------------------------------------------------"
