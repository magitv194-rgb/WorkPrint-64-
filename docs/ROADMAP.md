# Development roadmap

## Stage 0: repository and boot scaffold
- [x] Establish project structure and goals.
- [x] Add a minimal x86_64 entry point and serial diagnostics.
- [ ] Compile and validate the ELF.
- [ ] Boot in QEMU through Limine.

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
