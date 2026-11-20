#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
LIST="$ROOT/live/config/package-lists/workprint.list.chroot"
SCRIPT="$ROOT/tools/configure-live-build.sh"

test -s "$LIST"
sh -n "$SCRIPT"

# Package lists must contain one package name per non-empty, non-comment line.
if grep -Ev '^[[:space:]]*($|#|[a-z0-9][a-z0-9+.-]*([[:space:]]+#.*)?$)' "$LIST"; then
    echo "ERROR: invalid package-list line(s)" >&2
    exit 1
fi

echo "WorkPrint live-build configuration checks passed."
