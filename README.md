# WorkPrint 64

WorkPrint 64 is a Linux-based operating-system project for modest x86_64 computers. Its goal is a lightweight, classic desktop inspired by Windows 7, with a modern browser for WhatsApp Web and a practical printing workflow.

**Current status: first live-build configuration committed; no ISO has been built or boot-tested yet.** The repository now contains a Debian 13 (Trixie) amd64 live-build recipe with XFCE, LightDM, Firefox ESR, CUPS, IPP-USB and selected printer drivers, plus local configuration checks and a GitHub Actions package-resolution workflow. This is build infrastructure, not a finished operating system.

## Technical direction

- Use Debian stable as the maintained Linux foundation.
- Start with XFCE and LightDM, then customize the desktop with WorkPrint branding.
- Target x86_64; confirm that the Lenovo CPU supports 64-bit mode before attempting to boot this image.
- Include Firefox ESR as the initial browser candidate. WhatsApp Web compatibility and memory use still need testing.
- Use CUPS and prefer IPP Everywhere / IPP-USB where the printer supports them. Exact model support must be tested.
- Keep the 3 GB RAM limit in mind and measure actual usage rather than promising smooth performance in every workload.
- Never risk the existing installation during early testing.

## Build configuration

See [live/README.md](live/README.md) for the initial image build instructions. The live-build configuration is in `live/`; package selection is in `live/config/package-lists/workprint.list.chroot`.

The local configuration check is:

```sh
tools/check-live-config.sh
```

## Current limitations

No WorkPrint 64 ISO, live USB, installer, customized theme, or verified printer compatibility list exists yet. The image build and boot tests remain pending. The original freestanding kernel scaffold is retained as a legacy experiment and is no longer the product's primary implementation path.

Do not install anything to the Lenovo's internal disk. Build and test in a virtual machine first, then use a live USB without installing.
