# Validation plan

This plan separates build validation from boot validation and real hardware compatibility. A successful ISO build does not prove that networking, printing or performance works.

## 1. Build artifact

- [x] Build a Debian 13 Trixie amd64 hybrid ISO in GitHub Actions.
- [x] Check that the ISO is larger than 100 MB.
- [x] Calculate and publish a SHA-256 digest in the build log.
- [x] Upload the ISO as the `workprint-64-amd64-iso` workflow artifact.
- [ ] Download the artifact and independently verify its SHA-256 digest.
- [x] Inspect the ISO El Torito boot catalog with `xorriso`.
- [x] Inspect the ISO system area with `xorriso`.
- [x] Upload the ISO and checksum as a workflow artifact.

The current CI artifact is retained for 14 days. It is a development artifact, not a release.

## 2. Virtual machine smoke test

- [x] Boot the ISO in QEMU using x86_64 emulation.
- [x] Allocate 3072 MB RAM to the VM.
- [x] Capture and manually inspect the guest display after boot.
- [x] Confirm that the XFCE live desktop appears.
- [ ] Require OCR checks for expected desktop icons in CI (new assertion added; awaiting workflow result).
- [ ] Verify virtual network connectivity from inside the guest.
- [ ] Verify Firefox ESR launches and loads a page.
- [ ] Verify CUPS starts and exposes its local administration page.
- [ ] Verify clean shutdown and reboot.
- [ ] Test BIOS and UEFI boot modes independently.

Evidence: [QEMU smoke-test run](https://github.com/magitv194-rgb/WorkPrint-64-/actions/runs/44806112856). The late screenshot shows the XFCE desktop and desktop icons. This confirms a graphical live-session boot in that QEMU configuration, not on the target Lenovo hardware.

Use a disposable VM. Do not attach a physical disk or enable automatic installation.

## 3. 3 GB memory profile

The VM was configured with 3072 MB RAM, but memory consumption and performance have not yet been measured.

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
