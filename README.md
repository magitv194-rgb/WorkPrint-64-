# WorkPrint 64

WorkPrint 64 is an experimental x86_64 operating-system project. The goal is a lightweight desktop with a classic Windows 7-inspired appearance, a browser suitable for WhatsApp Web, and a practical printing subsystem.

**Status: early development scaffold. This is not yet an installable or daily-usable operating system.** The repository currently contains a minimal kernel entry point, serial diagnostics, a linker layout, a Limine boot menu configuration, build notes, a roadmap, and a CI build workflow. It has not yet been boot-tested on the target Lenovo.

## Design priorities

- x86_64 first; verify the target CPU and firmware before installation.
- Keep memory use low; the target machine has 3 GB RAM.
- Prefer open standards for printing: IPP Everywhere and IPP-USB when the printer supports them.
- Add model/family-specific printer backends where technically and legally possible.
- Never claim universal printer compatibility: USB detection alone does not provide a working driver.
- Keep the system usable without replacing the user's current installation until boot and hardware tests pass.

## Repository map

- `boot/`: kernel entry assembly.
- `kernel/`: early kernel code and serial logging.
- `docs/`: architecture, build, hardware and printing notes.
- `.github/workflows/`: automated kernel build check.
- `limine.conf`: Limine boot menu entry.
- `linker.ld`: ELF kernel layout.

## Current limitations

No GUI, USB stack, storage driver, network stack, browser, Wi-Fi support, printer driver, installer, or ISO image exists yet. The current scaffold is a foundation for development, not a finished OS. The CI workflow has been added, but its result has not yet been observed.

See [the build guide](docs/BUILD.md), [roadmap](docs/ROADMAP.md), and [printing design](docs/PRINTING.md).
