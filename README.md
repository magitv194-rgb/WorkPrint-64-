# WorkPrint 64

WorkPrint 64 is a Linux-based operating-system project for modest x86_64 computers. Its goal is a lightweight, classic desktop inspired by Windows 7, with a modern browser for WhatsApp Web and a practical printing workflow.

**Current status: Debian 13 (Trixie) amd64 hybrid ISO built successfully and visually boot-tested to the customized XFCE live desktop in QEMU with 3 GB RAM assigned.** The VM evidence confirms the WorkPrint wallpaper, panel and desktop icons. Automated OCR now checks the icon labels in a cropped, enlarged screenshot. GitHub Actions also validates package availability, builds the ISO, checks its boot catalog and publishes a SHA-256 checksum.

The QEMU test confirms that the graphical live session can start in that virtual configuration. It does not establish performance, networking, printer compatibility or successful operation on the target Lenovo. This remains an early development image, not a finished or stable operating system.

## Technical direction

- Use Debian stable as the maintained Linux foundation.
- Start with XFCE and LightDM, then customize the desktop with WorkPrint branding.
- Target x86_64; confirm that the Lenovo CPU supports 64-bit mode before attempting to boot this image.
- Include Firefox ESR as the initial browser candidate. WhatsApp Web compatibility and memory use still need testing.
- Use CUPS and prefer IPP Everywhere / IPP-USB where the printer supports them. Exact model support must be tested.
- Keep the 3 GB RAM limit in mind and measure actual usage rather than promising smooth performance in every workload.
- Never risk the existing installation during early testing.

## Build and artifact

See [live/README.md](live/README.md) for the image build instructions. The live-build configuration is in `live/`; package selection is in `live/config/package-lists/workprint.list.chroot`.

- [Latest verified ISO build](https://github.com/magitv194-rgb/WorkPrint-64-/actions/runs/44810603583)
- [Latest successful QEMU desktop test](https://github.com/magitv194-rgb/WorkPrint-64-/actions/runs/44813818683)
- [Linux configuration validation](https://github.com/magitv194-rgb/WorkPrint-64-/actions/runs/44813818610)
- [Validation plan](docs/TEST_PLAN.md)
- [Desktop shortcuts and design status](docs/DESKTOP.md)
- [Printing architecture and current support status](docs/PRINTING.md)

The local configuration check is:

```sh
sh tools/check-live-config.sh
```

## Current limitations

The ISO reaches the customized XFCE desktop in QEMU with 3072 MB RAM assigned, and the desktop icon OCR check passes. Network connectivity, audio, Firefox launch/page loading, WhatsApp Web performance, memory consumption and physical printer compatibility remain unverified. The Lenovo itself has not yet been tested.

Do not install anything to the Lenovo's internal disk. Next, test the ISO as a live USB without installing. See [the validation plan](docs/TEST_PLAN.md).
