# Linux base decision

## Decision

WorkPrint 64 will use a maintained Linux distribution as its operating-system foundation. The previous plan to build a complete general-purpose kernel, USB stack, network stack, filesystem, browser platform and printer system from scratch is discontinued as the primary product strategy.

This is a change of implementation, not a change of product name or goal.

## Proposed starting point

- Base: Debian stable, minimal installation.
- Desktop: XFCE, customized with a classic Windows 7-inspired WorkPrint look.
- Architecture: x86_64, subject to confirming that the target Lenovo CPU supports 64-bit mode.
- Printing: CUPS; prefer IPP Everywhere and IPP-USB where the printer supports them. Exact model support must be tested.
- Browser: a maintained browser from a supported source, tested against WhatsApp Web.
- Target: Lenovo computer with 3 GB RAM.

The exact Debian release and package versions should be pinned when the first reproducible image is built. Do not assume that a browser, WhatsApp Web or every printer will work merely because Linux boots.

## Why this route

Linux already provides a mature kernel, broad hardware support, networking, USB, filesystems and a large software ecosystem. Reusing these components makes it much more realistic to deliver a working desktop and printing workflow.

The trade-off is that WorkPrint 64 will be a customized Linux distribution/remix, not a kernel written entirely from scratch. Updates and security maintenance will depend on the selected upstream distribution and included applications.

## Memory constraints

3 GB RAM is a tight target for a modern browser. The desktop should be kept lean, background services minimized only when safe, and memory use measured on the actual machine. A low idle-memory number does not guarantee smooth browsing with several tabs or large WhatsApp downloads.

## Safe development sequence

1. Build and test in a virtual machine.
2. Produce a live USB image.
3. Boot the Lenovo from USB without installing or formatting its internal disk.
4. Verify Wi-Fi/Ethernet, graphics, audio, keyboard, touchpad and USB.
5. Identify the exact printer model and test real print jobs.
6. Consider installation only after backups and a tested recovery procedure exist.

## Current status

This document records the architecture decision only. It is not evidence that an ISO, live USB, installer or customized desktop has been built. Those remain future milestones.
