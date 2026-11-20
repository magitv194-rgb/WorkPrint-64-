# Build and test

## Important safety note

Do not install this project over the Lenovo's current system. This repository does not yet provide a complete OS, installer, storage stack, or recovery process. Testing must begin in an emulator or from a separate removable drive after a bootable image has been verified.

## Required tools

A 64-bit Linux development environment is the supported build host for this early scaffold. Install:

- GCC and GNU binutils (a native x86_64 compiler is sufficient for this stage; a cross compiler can also be selected with Make variables);
- GNU Make and Python 3;
- xorriso for ISO creation;
- a recent Limine binary release whose bootloader supports Limine protocol base revision 6.

The kernel explicitly requests Limine base revision 6, the current non-deprecated revision in the upstream protocol. An older Limine binary may refuse to load it. Do not mix arbitrary Limine binaries from different releases.

The target computer does not need Linux installed. These are development-host tools, not a requirement for the eventual end-user system.

## Build kernel

Run:

```sh
make check-tools
make
python3 tools/verify_elf.py build/workprint.elf
```

Expected output: `build/workprint.elf`, followed by an ELF validation summary showing four load segments and accepted Limine request metadata.

To select a cross toolchain, pass its executable names explicitly, for example:

```sh
make CC=x86_64-elf-gcc LD=x86_64-elf-ld AS=x86_64-elf-gcc
```

## Kernel memory layout and Limine metadata

The kernel is linked at the higher-half virtual address `0xffffffff80000000`, while its ELF load segments have physical load addresses beginning at 1 MiB. The linker script expresses this distinction with separate virtual and load addresses and emits separate executable, read-only, writable-request, and BSS load segments.

The kernel includes the Limine request start/end markers and a base-revision-6 tag in a dedicated writable `.limine_requests` ELF load segment. The kernel checks the tag at startup and halts with a serial diagnostic if the bootloader did not accept the requested revision. The validator checks the ELF structure, load addresses, permissions, marker order, and base-revision tag. This is a static consistency check, not proof that a particular Limine binary will boot the kernel.

The boot entry assumes the Limine loader has established the protocol execution environment. The kernel does not yet request or consume a memory map or framebuffer, establish its own page tables, or initialize memory management.

## ISO image

Place all four required Limine release files from the same compatible release in `limine/`:

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

- Confirm the hosted GitHub Actions run succeeds.
- Build an ISO with a pinned, compatible Limine release.
- Verify Limine protocol handoff and serial output in QEMU.
- Request and parse the Limine memory map before adding a physical memory manager.
- Add automated checks before attempting real hardware.
