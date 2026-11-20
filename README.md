# WorkPrint 64

WorkPrint 64 is an experimental x86_64 operating-system project. The goal is a lightweight desktop with a classic Windows 7-inspired appearance, a browser suitable for WhatsApp Web, and a practical printing subsystem.

**Status: early development scaffold. This is not yet an installable or daily-usable operating system.** The repository currently contains a minimal kernel entry point, serial diagnostics, a higher-half ELF layout, Limine protocol base revision 6 metadata, a static ELF validator, a Limine boot menu configuration, build notes, a roadmap, and a CI build workflow. It has not yet been boot-tested in QEMU or on the target Lenovo.

## Design priorities

- x86_64 first; verify the target CPU and firmware before installation.
- Keep memory use low; the target machine has 3 GB RAM.
- Prefer open standards for printing: IPP Everywhere and IPP-USB when the printer supports them.
- Treat model-specific printer support as a separate compatibility task; USB detection alone does not guarantee printing.
- Never risk the existing installation during early testing.

## Current limitations

There is no desktop, browser, network stack, Wi-Fi support, USB host controller, storage driver, filesystem, printer driver, print spooler, or installer yet. The kernel currently initializes serial output and halts. The ISO recipe has not been verified with a pinned Limine release, and no boot test has passed.

## Build and validation

See [docs/BUILD.md](docs/BUILD.md) for the supported development environment, build commands, Limine requirements, and validation status. The static ELF check is:

```sh
make check-tools all
python3 tools/verify_elf.py build/workprint.elf
```

Do not install this project over the Lenovo's current system. First prove the boot process in QEMU, then test from removable media with a recovery path.
