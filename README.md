# WorkPrint 64

WorkPrint 64 is an experimental x86_64 operating-system project. The goal is a lightweight desktop with a classic Windows 7-inspired appearance, a browser suitable for WhatsApp Web, and a practical printing subsystem.

**Status: early development scaffold. This is not yet an installable or daily-usable operating system.** The repository currently contains a minimal kernel entry point, serial diagnostics including Limine memory-map type labels, response-revision checking, range checks and a usable-memory total, a higher-half ELF layout, Limine protocol base revision 6 metadata, a static ELF validator, a Limine boot menu configuration, build notes, a roadmap, and a CI build workflow. It has not yet been boot-tested in QEMU or on the target Lenovo.

## Design priorities

- x86_64 first; verify the target CPU and firmware before installation.
- Keep memory use low; the target machine has 3 GB RAM.
- Prefer open standards for printing: IPP Everywhere and IPP-USB when the printer supports them.
- Treat model-specific printer support as a separate compatibility task; USB detection alone does not guarantee printing.
- Never risk the existing installation during early testing.

## Current limitations

There is no desktop, browser, network stack, Wi-Fi support, USB host controller, storage driver, filesystem, printer driver, print spooler, or installer yet. If booted successfully, the kernel initializes serial output, checks the Limine base revision, prints the supplied memory map, and then halts. This runtime behaviour has not yet been verified in QEMU. The ISO recipe has not been tested with a compatible Limine binary release.

## Build and validation

See [docs/BUILD.md](docs/BUILD.md) for the supported development environment, build commands, Limine requirements, and validation status. The static ELF check is:

```sh
make check-tools all validate
```

Do not install this project over the Lenovo's current system. First prove the boot process in QEMU, then test from removable media with a recovery path.
