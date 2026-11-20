# Development roadmap

## Stage 0: repository and boot scaffold
- [x] Establish project structure and goals.
- [x] Add a minimal x86_64 entry point and serial diagnostics.
- [x] Separate higher-half virtual addresses from low physical load addresses.
- [x] Add Limine base revision 6 metadata, request delimiters, and memory-map request in a writable ELF segment.
- [x] Add early-boot serial reporting for the Limine memory map (runtime verification in QEMU pending).
- [x] Compile the kernel ELF with GCC/binutils in a local Linux environment.
- [x] Validate ELF64 format, entry point, load segments, Limine markers, base revision, and request-segment permissions with `tools/verify_elf.py`.
- [ ] Confirm the GitHub Actions hosted run.
- [ ] Build an ISO with matching, compatible Limine binaries and host utility.
- [ ] Boot in QEMU and verify serial output.

The kernel ELF and static validator have passed in a local Linux build environment. The GitHub Actions workflow has been updated to run the validator and publish the ELF artifact, but its hosted run has not yet been independently confirmed. The memory-map request and serial reporting are implemented but have not yet been observed at runtime. No Limine ISO or QEMU boot has been verified.

## Stage 1: hardware foundation
- [ ] Validate memory-map responses in QEMU and reserve kernel/bootloader regions safely.
- [ ] Physical and virtual memory management.
- [ ] Interrupt descriptor table, exceptions and timer.
- [ ] PCI enumeration.
- [ ] USB host controller support (xHCI, EHCI where needed).
- [ ] ACPI power and device discovery.
- [ ] Storage and filesystem support.

## Stage 2: usable system
- [ ] Framebuffer and graphics driver.
- [ ] Window manager and classic desktop shell.
- [ ] Keyboard, mouse and audio.
- [ ] TCP/IP, DNS, TLS and Wi-Fi support.
- [ ] Browser integration suitable for WhatsApp Web.

## Stage 3: printing
- [ ] USB device identification and safe hot-plug handling.
- [ ] IPP and IPP-USB implementation where supported.
- [ ] Printer capability discovery and print queue.
- [ ] Model-specific backends and test matrix.

## Stage 4: reliability
- [ ] Installer, partitioning safeguards and recovery.
- [ ] Updates, logs and crash reporting.
- [ ] Low-memory testing with a 3 GB RAM target.
- [ ] Hardware compatibility testing on the actual Lenovo.

Stages 1-4 are not implemented. Do not interpret checklist items as existing features.
