# Legacy freestanding-kernel build notes

> **Important:** These instructions apply only to the original experimental Limine kernel scaffold. They are retained for reference and are no longer the build path for the WorkPrint 64 product. The current architecture decision is documented in [LINUX_BASE.md](LINUX_BASE.md).

## Safety

Do not install this project over the Lenovo's current system. The freestanding kernel is not a complete operating system and does not provide a desktop, storage stack, network stack, USB host controller, printer support or installer.

## Tools for the legacy kernel scaffold

A 64-bit Linux development environment is required for this historical experiment:

- GCC and GNU binutils;
- GNU Make and Python 3;
- xorriso for ISO creation;
- Limine host utility and BIOS/UEFI files from one compatible release supporting protocol base revision 6.

## Build the legacy kernel

From the repository root:

```sh
make check-tools all validate
```

This builds and statically validates `build/workprint.elf`. It does not produce a usable desktop OS.

## Runtime status

The kernel scaffold has not been verified booting in QEMU or on the target Lenovo. No bootable ISO has been verified. Do not treat a successful ELF build as proof of a working operating system.

## Superseded plan

The former from-scratch roadmap is superseded by [ROADMAP.md](ROADMAP.md). WorkPrint 64's primary path is now a customized Linux-based system.
