# Build and test

## Important safety note

Do not install this project over the Lenovo's current system. This repository does not yet provide a complete OS, installer, storage stack, or recovery process. Testing must begin in an emulator or from a separate removable drive after a bootable image has been verified.

## Required tools

A Linux or other POSIX development environment is currently required to build this early kernel scaffold. Install:

- an x86_64-elf GCC cross compiler and binutils;
- GNU Make;
- xorriso;
- Limine bootloader release files.

The target computer does not need Linux installed. These are development-host tools, not a requirement for the eventual end-user system.

## Build kernel

Run:

```sh
make check-tools
make
```

Expected output: `build/workprint.elf`.

## ISO image

Place the required Limine release files in `limine/` using the filenames referenced by the Makefile, then run:

```sh
make iso
```

This recipe is an initial integration point and must be checked against the exact Limine release before relying on it. No ISO has been built or boot-tested yet.

## Validation still required

- Confirm cross-compiler and linker availability.
- Confirm ELF format, entry point and load segments.
- Verify Limine protocol handoff and serial output in QEMU.
- Add automated checks before attempting real hardware.
