# Development roadmap

WorkPrint 64 now follows the Linux-based architecture decision. The original freestanding x86_64 kernel work is retained as a legacy experiment, not the main product path.

## Stage 0: architecture decision
- [x] Define the product goal: lightweight x86_64 desktop, classic appearance, browser and practical printing.
- [x] Choose a maintained Linux base instead of implementing a complete kernel and hardware stack from scratch.
- [x] Record the original kernel scaffold as legacy work so it is not mistaken for a usable OS.

## Stage 1: establish a reproducible Linux base
- [ ] Confirm the Lenovo CPU architecture, firmware mode and boot options without modifying its disk.
- [ ] Build a clean minimal Debian stable XFCE test installation in a virtual machine.
- [ ] Record idle RAM use, boot time, disk footprint and responsiveness.
- [ ] Create a repeatable package and configuration manifest.
- [ ] Verify networking, audio, graphics, suspend/resume and USB on representative hardware.
- [ ] Produce a first live USB image and test boot without installing to the Lenovo.

## Stage 2: WorkPrint desktop
- [ ] Create WorkPrint branding, wallpaper, icons, theme and login experience.
- [ ] Configure a familiar classic taskbar, application menu and desktop layout.
- [ ] Remove unnecessary startup services only after measuring their impact and checking dependencies.
- [ ] Set up system updates, user accounts, firewall defaults and recovery documentation.

## Stage 3: browser and work workflow
- [ ] Select a maintained browser supported by the chosen base.
- [ ] Test WhatsApp Web login, downloads and document/image handling.
- [ ] Configure sensible browser defaults and low-memory usage guidance.
- [ ] Test opening and printing common PDF and image formats.

## Stage 4: printing
- [ ] Integrate CUPS and its service-management tools.
- [ ] Test printer discovery over USB and network.
- [ ] Prefer IPP Everywhere / IPP-USB when supported by the actual printer.
- [ ] Identify exact HP printer model and check the appropriate supported driver/backend.
- [ ] Test photo paper sizes, margins, quality settings, grayscale and multi-page documents.
- [ ] Publish a tested printer compatibility list; do not claim universal support.

## Stage 5: release and recovery
- [ ] Build a reproducible ISO/live USB image.
- [ ] Test installation and recovery in a virtual machine first.
- [ ] Test live boot on the Lenovo without overwriting its current operating system.
- [ ] Measure performance with 3 GB RAM and document browser limitations.
- [ ] Only consider installation after backup, hardware checks and a verified recovery route.

## Legacy: freestanding kernel experiment

The repository's original Limine-based kernel scaffold, ELF validator and related build notes are retained for reference. They do not provide a desktop, network, USB stack, storage, browser, printer support or installer, and they are not the foundation of the new Linux-based release.
