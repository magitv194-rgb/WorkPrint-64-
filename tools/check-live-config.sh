#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
LIST="$ROOT/live/config/package-lists/workprint.list.chroot"
SCRIPT="$ROOT/tools/configure-live-build.sh"

test -s "$LIST"
sh -n "$SCRIPT"

awk '
    /^[[:space:]]*#/ || /^[[:space:]]*$/ { next }
    /^[a-z0-9][a-z0-9+.-]*$/ { next }
    { print "Invalid package-list entry at line " NR ": " $0; failed = 1 }
    END { exit failed }
' "$LIST"

echo "WorkPrint live-build configuration checks passed."
