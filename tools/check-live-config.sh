#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
LIST="$ROOT/live/config/package-lists/workprint.list.chroot"
SCRIPT="$ROOT/tools/configure-live-build.sh"

test -s "$LIST"
sh -n "$SCRIPT"

python3 - "$ROOT" <<'PY'
import sys
import xml.etree.ElementTree as ET
from pathlib import Path

root = Path(sys.argv[1])
configs = {
    "live/config/includes.chroot/etc/xdg/xfce4/panel/default.xml": "xfce4-panel",
    "live/config/includes.chroot/etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml": "xsettings",
}
for relative, expected_channel in configs.items():
    path = root / relative
    if not path.is_file():
        raise SystemExit(f"Missing desktop configuration: {relative}")
    channel = ET.parse(path).getroot()
    if channel.tag != "channel" or channel.get("name") != expected_channel:
        raise SystemExit(f"Invalid XFCE channel in {relative}")

print("XFCE desktop XML checks passed.")
PY

awk '
    /^[[:space:]]*#/ || /^[[:space:]]*$/ { next }
    /^[a-z0-9][a-z0-9+.-]*$/ { next }
    { print "Invalid package-list entry at line " NR ": " $0; failed = 1 }
    END { exit failed }
' "$LIST"

echo "WorkPrint live-build configuration checks passed."
