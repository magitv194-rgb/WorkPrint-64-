# Desktop configuration

The initial desktop is XFCE with LightDM. WorkPrint-specific launchers are installed into the standard applications menu:

- **WhatsApp Web** opens `https://web.whatsapp.com/` in Firefox ESR.
- **Impresoras** opens system-config-printer for local and network printer setup.

These launchers do not bundle WhatsApp or a proprietary printer driver. WhatsApp Web requires an internet connection, browser compatibility and sufficient memory. Printer setup still depends on the exact printer model and supported protocol/driver.

## Current design choices

- Keep XFCE rather than a heavier desktop environment.
- Use Firefox ESR as the supported browser baseline.
- Keep printer administration accessible from the applications menu.
- Avoid automatically starting a browser or opening WhatsApp at login.
- Measure idle and browser memory use on the 3 GB target before claiming performance.

The visual theme, wallpaper, panel layout and full WorkPrint branding remain unfinished. See [the validation plan](TEST_PLAN.md).
