#!/usr/bin/env bash
# Listens to Hyprland's event socket and re-runs the workspace split whenever
# a monitor is added or removed. Requires `socat`.

set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOCK="${XDG_RUNTIME_DIR}/hypr/${HYPRLAND_INSTANCE_SIGNATURE}/.socket2.sock"

# Initial assignment.
"${DIR}/assign-workspaces.sh" || true

if ! command -v socat >/dev/null 2>&1; then
  echo "workspace-listener: socat not found; hotplug rebalancing disabled" >&2
  exit 0
fi

socat -U - "UNIX-CONNECT:${SOCK}" | while read -r line; do
  case "$line" in
    monitoradded*|monitorremoved*)
      "${DIR}/assign-workspaces.sh" || true
      ;;
  esac
done
