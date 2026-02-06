#!/usr/bin/env bash

IFACE=$(ip route | awk '/default/ {print $5; exit}')
INTERVAL=5

read RX1 TX1 < <(awk -v iface="$IFACE" '$1 ~ iface ":" {print $2, $10}' /proc/net/dev)
sleep $INTERVAL
read RX2 TX2 < <(awk -v iface="$IFACE" '$1 ~ iface ":" {print $2, $10}' /proc/net/dev)

RX_RATE=$(( (RX2 - RX1) / INTERVAL ))
TX_RATE=$(( (TX2 - TX1) / INTERVAL ))

human() {
  awk -v b="$1" 'BEGIN {
    if (b < 1024) printf "%d B/s", b;
    else if (b < 1024^2) printf "%.1f KB/s", b/1024;
    else printf "%.1f MB/s", b/1024^2;
  }'
}

echo "↓ $(human $RX_RATE) ↑ $(human $TX_RATE)"

