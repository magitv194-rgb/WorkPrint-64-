# Development roadmap

WorkPrint 64 follows a Linux-based architecture. The original freestanding x86_64 kernel is retained as a legacy experiment, not the main product path.

## Stage 0: architecture and initial build configuration
- [x] Define the product goal: lightweight x86_64 desktop, classic appearance, browser and practical printing.
- [x] Choose Debian stable rather than implementing a complete kernel and hardware stack from scratch.
- [x] Record the original kernel scaffold as legacy work.
- [x] Add a Debian 13 Trixie amd64 live-build configuration.
- [x] Define an initial XFCE, Firefox ESR, CUPS and selected printer-driver package set.
- [x] Add local shell/package-list validation.
- [x] Add GitHub Actions checks for package resolution and live-build configuration generation.
- [x] Confirm hosted package/configuration checks succeed.\n- [x] Build and upload the first amd64 hybrid ISO in GitHub Actions.\n- [ ] Independently download and inspect the ISO artifact.

## Stage 1: build and boot the first image
- [ ] Build the first hybrid ISO on a Debian 13 amd64 host.
- [ ] Verify ISO checksums and inspect its boot structure.
- [ ] Boot in QEMU with BIOS and UEFI where practical.
- [ ] Confirm graphical XFCE login, networking and a usable live session.
- [ ] Measure idle RAM use and disk footprint.
- [ ] Fix missing packages, boot options and hardware firmware issues.

## Stage 2: hardware validation
- [ ] Confirm the Lenovo CPU architecture and firmware mode.
- [ ] Boot the live USB without modifying the internal disk.
- [ ] Verify graphics, Wi-Fi/Ethernet, audio, keyboard, touchpad and USB.
- [ ] Test suspend/resume and restart behaviour.

## Stage 3: WorkPrint desktop and work workflow
- [ ] Create WorkPrint branding, wallpaper, icons, theme and login experience.
- [ ] Configure a familiar classic taskbar, application menu and desktop layout.
- [ ] Test Firefox ESR and WhatsApp Web, including downloads and document/image handling.
- [ ] Measure browser memory use on the 3 GB target.

## Stage 4: printing
- [ ] Test CUPS and printer discovery over USB and network.
- [ ] Prefer IPP Everywhere / IPP-USB when supported by the actual printer.
- [ ] Identify the exact HP printer model and verify the appropriate driver/backend.
- [ ] Test photo sizes, margins, quality, grayscale and multi-page documents.
- [ ] Publish a tested printer compatibility list; do not claim universal support.

## Stage 5: release and recovery
- [ ] Build a reproducible ISO/live USB image.
- [ ] Test installation and recovery in a virtual machine first.
- [ ] Only consider installation after backup, hardware checks and a verified recovery route.

## Legacy: freestanding-kernel experiment

The original Limine-based kernel scaffold, ELF validator and related build notes are retained for reference. They do not provide a desktop, network, USB stack, storage, browser, printer support or installer.
