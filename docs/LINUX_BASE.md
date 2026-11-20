# Linux base decision

## Decision

WorkPrint 64 uses a maintained Linux distribution as its operating-system foundation. The previous plan to build a complete general-purpose kernel, USB stack, network stack, filesystem, browser platform and printer system from scratch is no longer the primary product strategy.

This changes the implementation, not the product name or goals.

## Initial implementation

The current live-build configuration targets:

- Debian 13 (Trixie) stable, amd64.
- XFCE desktop with LightDM.
- Firefox ESR with conservative cache/session defaults for low-memory systems.
- CUPS, system-config-printer, IPP-USB and selected open printer drivers.
- Spanish (Argentina) locale and Latin American keyboard layout.
- A Lenovo target with 3 GB RAM, subject to confirming x86_64 CPU support.

The package selection and live-build script are in `live/` and `tools/configure-live-build.sh`. The amd64 hybrid ISO builds successfully and has reached the XFCE live desktop in QEMU with 3072 MB RAM assigned. See [the validation plan](TEST_PLAN.md).

## Why this route

Linux already provides a mature kernel, broad hardware support, networking, USB, filesystems and a large software ecosystem. Reusing these components makes it more realistic to deliver a working desktop and printing workflow.

The trade-off is that WorkPrint 64 is a customized Linux distribution/remix, not a kernel written entirely from scratch. Updates and security maintenance depend on Debian and the included applications.

## Memory constraints

3 GB RAM is a tight target for a modern browser. The desktop should be kept lean, background services minimized only when safe, and memory use measured on the actual machine. Firefox receives conservative cache/session defaults, but those settings are not a substitute for real measurements. Low idle-memory use does not guarantee smooth browsing with several tabs or large WhatsApp downloads.

## Safe development sequence

1. Build and test in a disposable virtual machine.
2. Boot the resulting live image in QEMU.
3. Verify that the graphical live session appears.
4. Test network, browser launch, CUPS startup and shutdown behavior.
5. Produce a live USB image.
6. Boot the Lenovo from USB without installing or formatting its internal disk.
7. Verify network, graphics, audio, input devices and USB.
8. Identify the exact printer model and test real print jobs.
9. Consider installation only after backups and a tested recovery procedure exist.

## Current status

The initial amd64 ISO build and artifact upload succeeded. A QEMU smoke test visually confirmed the XFCE live desktop with 3 GB RAM assigned. Network connectivity, Firefox operation, CUPS service behavior, measured memory use, physical Lenovo hardware and printer output remain unverified.
