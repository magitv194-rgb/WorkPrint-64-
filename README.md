# WorkPrint 64

WorkPrint 64 is a Linux-based operating-system project for modest x86_64 computers. Its goal is a lightweight, classic desktop inspired by Windows 7, with a modern browser for WhatsApp Web and a practical printing workflow.

**Current status: migration decision recorded; the Linux-based system is not built yet.** The repository still contains an experimental freestanding kernel scaffold from the original from-scratch approach. That scaffold is retained as historical development work, but it is no longer the primary implementation path.

## New technical direction

- Use a maintained Linux distribution as the kernel and hardware-support foundation.
- Start from a minimal Debian stable installation with the XFCE desktop, then customize and reduce unnecessary services.
- Target the existing Lenovo with 3 GB RAM; measure real memory use rather than assuming every browser workload will fit comfortably.
- Include a supported modern browser for WhatsApp Web, subject to current browser and WhatsApp requirements.
- Use CUPS and prefer IPP Everywhere / IPP-USB where the printer supports them. Add model-specific drivers or backends only where licensing and availability permit.
- Build a branded WorkPrint 64 desktop, boot artwork, defaults, documentation and recovery process.
- Never risk the existing installation during early testing. Begin with a live USB or virtual machine.

## What is not ready

There is no WorkPrint 64 Linux ISO, installer, customized desktop image, browser bundle, or verified printer compatibility list yet. The existing custom kernel is not a usable operating system and is retained only as a legacy experiment. No installation or hardware test has been performed on the Lenovo.

## Development plan

See [docs/LINUX_BASE.md](docs/LINUX_BASE.md) for the new architecture decision and [docs/ROADMAP.md](docs/ROADMAP.md) for milestones. The old freestanding kernel build notes remain in [docs/BUILD.md](docs/BUILD.md) for historical reference only.

