# Validation plan

This plan separates build validation from boot validation and real hardware compatibility. A successful ISO build does not prove that the desktop, networking or printer support works.

## 1. Build artifact

- [x] Build a Debian 13 Trixie amd64 hybrid ISO in GitHub Actions.
- [x] Check that the ISO is larger than 100 MB.
- [x] Calculate and publish a SHA-256 digest in the build log.
- [x] Upload the ISO as the `workprint-64-amd64-iso` workflow artifact.
- [ ] Download the artifact and independently verify its SHA-256 digest.
- [ ] Inspect the ISO partition/boot catalog with `xorriso`.

The current CI artifact is retained for 14 days. It is a development artifact, not a release.

## 2. Virtual machine smoke test

Use a disposable VM. Do not attach a physical disk or enable automatic installation.

Suggested baseline:
- Architecture: x86_64 / amd64
- Firmware: test BIOS first, then UEFI
- RAM: 2048 MB for a general boot test; repeat at 3072 MB to approximate the target laptop
- CPUs: 2
- Disk: none required for a live-session test
- Network: user-mode networking
- CD/DVD: attach the WorkPrint ISO

Record:
- Does the boot menu appear?
- Does the live kernel and initramfs load without errors?
- Does the live session reach the graphical login/desktop?
- Does XFCE start and remain responsive?
- Is the virtual network interface detected?
- Does Firefox ESR launch?
- Does CUPS start and expose its local administration page?
- Does shutdown/reboot complete cleanly?

A headless QEMU process remaining alive is not sufficient evidence of a successful graphical boot. Capture the guest display or use a serial console configured for diagnostic output.

## 3. 3 GB memory profile

After a successful desktop boot:
- Record idle memory after five minutes with no applications open.
- Record memory with Firefox ESR open to one ordinary page.
- Record memory with several tabs, noting that modern websites can exceed the available RAM.
- Check swap activity and responsiveness.
- Do not promise WhatsApp Web performance until it has been measured.

## 4. Lenovo hardware test

Before booting on the laptop, identify CPU model/architecture and whether firmware uses BIOS or UEFI. Boot from USB in live mode only. Do not partition, format or install to the internal disk.

Record exact models and results for:
- Graphics and display resolution
- Wi-Fi and Ethernet
- Audio output/input
- Keyboard, touchpad and function keys
- USB ports and storage devices
- Suspend/resume and battery reporting

## 5. Printer validation

For each physical printer, record the exact model, USB vendor/product IDs or network protocol, firmware if known, selected driver/backend, and test results. Test plain text, PDF, grayscale, duplex (if supported), margins and paper sizes.

Prefer IPP Everywhere or IPP-over-USB when the printer advertises those capabilities. A detected USB device is not proof that it can print.

## 6. Release gate

Do not label an image stable or recommend installation until:
- BIOS and/or UEFI boot has been tested on a VM.
- The live desktop, network and audio have been checked.
- The target Lenovo has passed a non-destructive live USB test.
- The exact printer model has passed print tests.
- A recovery/backup path exists before any installation.
