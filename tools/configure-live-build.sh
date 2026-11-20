#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
cd "$ROOT/live"

if ! command -v lb >/dev/null 2>&1; then
    echo "ERROR: live-build is not installed. On Debian: sudo apt install live-build" >&2
    exit 1
fi

lb config \
    --distribution trixie \
    --architecture amd64 \
    --binary-images iso-hybrid \
    --archive-areas "main contrib non-free-firmware" \
    --debian-installer none \
    --firmware-binary true \
    --firmware-chroot true \
    --iso-volume WORKPRINT_64 \
    --image-name workprint-64 \
    --memtest none \
    --bootappend-live "boot=live components username=workprint hostname=workprint locales=es_AR.UTF-8 keyboard-layouts=latam"
