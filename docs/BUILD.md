# Build and test

## Important safety note

Do not install this project over the Lenovo's current system. This repository does not yet provide a complete OS, installer, storage stack, or recovery process. Testing must begin in an emulator or from a separate removable drive after a bootable image has been verified.

## Required tools

A 64-bit Linux development environment is the supported build host for this early scaffold. Install:

- GCC and GNU binutils (a native x86_64 compiler is sufficient for this stage; a cross compiler can also be selected with Make variables);
- GNU Make;
- xorriso for ISO creation;
- Limine release files for the ISO target.

The target computer does not need Linux installed. These are development-host tools, not a requirement for the eventual end-user system.

## Build kernel

Run:

```sh
make check-tools
make
```

Expected output: `build/workprint.elf`.

To select a cross toolchain, pass its executable names explicitly, for example:

```sh
make CC=x86_64-elf-gcc LD=x86_64-elf-ld AS=x86_64-elf-gcc
```

## ISO image

Place all four required Limine release files in `limine/`:

- `limine-bios.sys`
- `limine-bios-cd.bin`
- `limine-uefi-cd.bin`
- `BOOTX64.EFI`

Then run:

```sh
make iso
```

The ISO recipe is an initial integration point and must be checked against the exact Limine release before relying on it. No ISO has been built or boot-tested yet.

## Validation still required

- Confirm compiler and linker availability.
- Confirm ELF format, entry point and load segments.
- Verify Limine protocol handoff and serial output in QEMU.
- Add automated checks before attempting real hardware.
