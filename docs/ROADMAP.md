# Development roadmap

## Stage 0: repository and boot scaffold
- [x] Establish project structure and goals.
- [x] Add a minimal x86_64 entry point and serial diagnostics.
- [x] Compile the kernel ELF with the documented GCC/binutils command.
- [x] Validate ELF64 format, entry point, higher-half virtual addresses, low physical load addresses, and load-segment permissions with `tools/verify_elf.py`.
- [ ] Boot in QEMU through Limine.

The kernel build and ELF layout checks have passed in a local Linux build environment. The GitHub Actions workflow now runs the same ELF validator, but its hosted run has not yet been independently confirmed. No Limine ISO or QEMU boot has been verified.

## Stage 1: hardware foundation
- [ ] Memory map parsing and physical/virtual memory management.
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
