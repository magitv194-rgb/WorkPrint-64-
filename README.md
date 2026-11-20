# WorkPrint 64

WorkPrint 64 is a Linux-based operating-system project for modest x86_64 computers. Its goal is a lightweight, classic desktop inspired by Windows 7, with a modern browser for WhatsApp Web and a practical printing workflow.

**Current status: customized amd64 hybrid ISO built and uploaded as a development artifact; automated QEMU live-boot smoke testing is being added, while desktop and hardware tests remain pending.** The image is based on Debian 13 (Trixie) and currently includes XFCE, LightDM, Firefox ESR, CUPS, IPP-USB and selected printer drivers. GitHub Actions validates package availability, builds the ISO, checks its boot catalog and publishes a SHA-256 checksum.

This is an early development image, not a finished or stable operating system.

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

- [GitHub Actions ISO build history and artifacts](https://github.com/magitv194-rgb/WorkPrint-64-/actions/workflows/build-iso.yml)
- [Validation plan](docs/TEST_PLAN.md)
- [Desktop shortcuts and design status](docs/DESKTOP.md)\n- [Printing architecture and current support status](docs/PRINTING.md)

The local configuration check is:

```sh
sh tools/check-live-config.sh
```

## Current limitations

The first ISO has not yet been boot-tested in a virtual machine. The desktop theme and WorkPrint branding are not finished, and no physical printer has been tested. WhatsApp Web performance on a 3 GB system is also unverified.

Do not install anything to the Lenovo's internal disk. Test the ISO in a virtual machine first, then boot a live USB without installing. See [the validation plan](docs/TEST_PLAN.md).
