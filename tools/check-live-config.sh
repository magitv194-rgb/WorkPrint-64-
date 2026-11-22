#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
LIST="$ROOT/live/config/package-lists/workprint.list.chroot"
SCRIPT="$ROOT/tools/configure-live-build.sh"

test -s "$LIST"
sh -n "$SCRIPT"
PRINTER_DIAGNOSTIC="$ROOT/live/config/includes.chroot/usr/share/workprint/tools/diagnose-printers.sh"
test -s "$PRINTER_DIAGNOSTIC"
sh -n "$PRINTER_DIAGNOSTIC"
grep -qx 'usbutils' "$LIST"

python3 - "$ROOT" <<'PY'
import json
import sys
import xml.etree.ElementTree as ET
from pathlib import Path

root = Path(sys.argv[1])
configs = {
    "live/config/includes.chroot/etc/xdg/xfce4/panel/default.xml": "xfce4-panel",
    "live/config/includes.chroot/etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml": "xsettings",
    "live/config/includes.chroot/etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml": "xfce4-desktop",
    "live/config/includes.chroot/etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml": "xfce4-keyboard-shortcuts",
}
for relative, expected_channel in configs.items():
    path = root / relative
    if not path.is_file():
        raise SystemExit(f"Missing desktop configuration: {relative}")
    channel = ET.parse(path).getroot()
    if channel.tag != "channel" or channel.get("name") != expected_channel:
        raise SystemExit(f"Invalid XFCE channel in {relative}")

shortcuts = ET.parse(root / "live/config/includes.chroot/etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml").getroot()
shortcut = shortcuts.find(".//property[@name='<Primary><Alt>t']")
if shortcut is None or shortcut.get("value") != "xfce4-terminal":
    raise SystemExit("WorkPrint Ctrl+Alt+T terminal shortcut is missing")

wallpaper = root / "live/config/includes.chroot/usr/share/backgrounds/workprint/workprint-wallpaper.svg"
if not wallpaper.is_file():
    raise SystemExit("Missing WorkPrint desktop wallpaper")
ET.parse(wallpaper)

desktop_config = ET.parse(root / "live/config/includes.chroot/etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml").getroot()
image = desktop_config.find(".//property[@name='last-image']")
if image is None or image.get("value") != "/usr/share/backgrounds/workprint/workprint-wallpaper.svg":
    raise SystemExit("XFCE desktop does not point to the WorkPrint wallpaper")

policy_path = root / "live/config/includes.chroot/etc/firefox-esr/policies/policies.json"
policy = json.loads(policy_path.read_text(encoding="utf-8"))
policies = policy.get("policies", {})
for key in ("DisableTelemetry", "DisableFirefoxStudies", "DisablePocket"):
    if policies.get(key) is not True:
        raise SystemExit(f"Firefox policy {key} must be enabled")
preferences = policies.get("Preferences", {})
for key in ("browser.tabs.unloadOnLowMemory", "browser.sessionstore.restore_on_demand",
            "browser.sessionstore.restore_pinned_tabs_on_demand"):
    if preferences.get(key, {}).get("Value") is not True:
        raise SystemExit(f"Firefox low-memory preference {key} must be enabled")

launchers = {
    "live/config/includes.chroot/usr/share/applications/workprint-whatsapp.desktop":
        ("WhatsApp Web", "firefox-esr --new-window https://web.whatsapp.com/"),
    "live/config/includes.chroot/usr/share/applications/workprint-printers.desktop":
        ("Impresoras", "system-config-printer"),
}
for relative, (name, command) in launchers.items():
    path = root / relative
    if not path.is_file():
        raise SystemExit(f"Missing application launcher: {relative}")
    content = path.read_text(encoding="utf-8")
    if f"Name={name}" not in content or f"Exec={command}" not in content:
        raise SystemExit(f"Invalid application launcher: {relative}")

panel = ET.parse(root / "live/config/includes.chroot/etc/xdg/xfce4/panel/default.xml").getroot()
plugin_values = [p.get("value") for p in panel.findall(".//property[@name='plugins']/property")]
for required in ("whiskermenu", "launcher", "tasklist", "systray", "clock", "actions"):
    if required not in plugin_values:
        raise SystemExit(f"XFCE panel is missing plugin: {required}")

launcher = panel.find(".//property[@name='plugin-7']")
launcher_items = {v.get("value") for v in launcher.findall(".//value")} if launcher is not None else set()
for required in (
    "/usr/share/applications/firefox-esr.desktop",
    "/usr/share/applications/workprint-whatsapp.desktop",
    "/usr/share/applications/workprint-printers.desktop",
):
    if required not in launcher_items:
        raise SystemExit(f"XFCE quick-launcher is missing: {required}")

print("XFCE desktop, wallpaper, Firefox policy and application launcher checks passed.")
PY

awk '
    /^[[:space:]]*#/ || /^[[:space:]]*$/ { next }
    /^[a-z0-9][a-z0-9+.-]*$/ { next }
    { print "Invalid package-list entry at line " NR ": " $0; failed = 1 }
    END { exit failed }
' "$LIST"

echo "WorkPrint live-build configuration checks passed."
