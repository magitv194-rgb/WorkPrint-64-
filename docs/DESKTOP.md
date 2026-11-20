# Desktop configuration

The initial desktop uses XFCE with LightDM. It is configured for a familiar, classic desktop workflow while keeping the session relatively lightweight.

## Included shortcuts

- **WhatsApp Web** opens `https://web.whatsapp.com/` in Firefox ESR.
- **Impresoras** opens system-config-printer for local and network printer setup.

These launchers do not bundle WhatsApp or a proprietary printer driver. WhatsApp Web requires an internet connection, browser compatibility and sufficient memory. Printer setup depends on the exact printer model and supported protocol/driver.

## Visual configuration

- XFCE panel at the bottom, with Whisker menu, pinned Firefox ESR / WhatsApp Web / Impresoras launchers, task list, notification area, clock and session actions.
- Greybird GTK theme and elementary-xfce icon theme.
- Noto Sans interface font.
- A WorkPrint 64 vector wallpaper installed at `/usr/share/backgrounds/workprint/workprint-wallpaper.svg` and selected by the default XFCE desktop channel.
- No automatic browser launch or WhatsApp sign-in at login.

The wallpaper and layout are an initial visual identity, not a pixel-perfect Windows 7 clone. The project should use its own branding rather than copying proprietary logos or artwork.

## Performance constraints

XFCE is chosen instead of a heavier desktop environment, but the 3 GB RAM target is still tight for a modern browser. Firefox ESR has a 32 MiB disk-cache limit, a reduced session-history viewer count, low-memory tab unloading and on-demand session restoration to avoid loading every restored tab at once. These settings reduce avoidable pressure but do not make modern websites lightweight. Idle memory, browser memory and responsiveness must be measured on the actual Lenovo before making performance claims.

See [the validation plan](TEST_PLAN.md).
