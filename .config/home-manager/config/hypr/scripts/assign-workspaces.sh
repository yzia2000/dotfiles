#!/usr/bin/env bash
# Evenly split the 10 workspaces across all currently-connected monitors.
# 2 monitors -> 5 workspaces each, 3 monitors -> {4,3,3}, etc.
# Re-run this whenever monitors are plugged/unplugged (see the socket2
# listener in hyprland.conf) to rebalance.

set -euo pipefail

TOTAL_WS=10

# Monitor names, ordered left-to-right by their x position so the split
# follows the physical layout.
mapfile -t MONITORS < <(hyprctl monitors -j | jq -r 'sort_by(.x) | .[].name')

n=${#MONITORS[@]}
(( n == 0 )) && exit 0

# base workspaces per monitor, with the remainder spread onto the first
# monitors (so with 3 monitors you get 4,3,3).
base=$(( TOTAL_WS / n ))
rem=$(( TOTAL_WS % n ))

ws=1
for i in "${!MONITORS[@]}"; do
  mon="${MONITORS[$i]}"
  count=$base
  (( i < rem )) && count=$(( count + 1 ))

  first=$ws
  for (( j = 0; j < count; j++ )); do
    # Bind workspace $ws to this monitor. `default:true` makes the first
    # workspace of the group the one shown when the monitor activates.
    if (( j == 0 )); then
      hyprctl keyword workspace "${ws},monitor:${mon},default:true" >/dev/null
    else
      hyprctl keyword workspace "${ws},monitor:${mon}" >/dev/null
    fi
    ws=$(( ws + 1 ))
  done
  echo "monitor ${mon}: workspaces ${first}..$(( ws - 1 ))"
done
