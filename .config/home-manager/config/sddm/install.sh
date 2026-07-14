#!/usr/bin/env bash
# Install the Flexoki Minimal SDDM theme. Needs root (writes to /usr).
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"

sudo install -d /usr/share/sddm/themes/flexoki-minimal
sudo install -m644 "$here"/flexoki-minimal/{Main.qml,metadata.desktop,theme.conf} \
    /usr/share/sddm/themes/flexoki-minimal/

sudo install -d /etc/sddm.conf.d
sudo install -m644 "$here/10-flexoki.conf" /etc/sddm.conf.d/10-flexoki.conf

echo "Installed. Preview with:  sddm-greeter-qt6 --test-mode --theme /usr/share/sddm/themes/flexoki-minimal"
echo "Applies on next login/reboot."
