#!/bin/sh
# Read-only printer discovery for WorkPrint 64. No configuration is changed.
set -u

section() { printf '\n=== %s ===\n' "$1"; }

section "USB devices (vendor:product IDs)"
if command -v lsusb >/dev/null 2>&1; then
    lsusb
else
    echo "lsusb unavailable (install usbutils)."
fi

section "CUPS scheduler"
if command -v lpstat >/dev/null 2>&1; then
    lpstat -r 2>&1 || true
    lpstat -t 2>&1 || true
else
    echo "lpstat unavailable (install cups-client)."
fi

section "Discovered print backends"
if command -v lpinfo >/dev/null 2>&1; then
    lpinfo -v 2>&1 || true
else
    echo "lpinfo unavailable (install cups-client)."
fi

section "IPP-over-USB service"
if command -v systemctl >/dev/null 2>&1; then
    systemctl is-active ipp-usb 2>&1 || true
    systemctl --no-pager --full status ipp-usb 2>&1 | sed -n '1,12p' || true
else
    echo "systemctl unavailable."
fi

section "Available printer models (first 40)"
if command -v lpinfo >/dev/null 2>&1; then
    lpinfo -m 2>/dev/null | sed -n '1,40p' || true
fi

printf '\nDiagnostic complete. No printer settings were changed and no page was printed.\n'
