BUILD_DIR := build
ISO_ROOT := $(BUILD_DIR)/iso_root
KERNEL := $(BUILD_DIR)/workprint.elf
CC ?= x86_64-elf-gcc
LD ?= x86_64-elf-ld
AS ?= x86_64-elf-gcc
CFLAGS := -std=gnu11 -ffreestanding -fno-stack-protector -fno-pic -m64 -mno-red-zone -mcmodel=kernel -Wall -Wextra -Werror -O2 -Iinclude
ASFLAGS := -c -m64 -ffreestanding -fno-pic -mno-red-zone
LDFLAGS := -nostdlib -z max-page-size=0x1000 -T linker.ld

.PHONY: all clean check-tools iso
all: $(KERNEL)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/boot.o: boot/boot.S | $(BUILD_DIR)
	$(AS) $(ASFLAGS) $< -o $@

$(BUILD_DIR)/kernel.o: kernel/kernel.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(KERNEL): $(BUILD_DIR)/boot.o $(BUILD_DIR)/kernel.o linker.ld
	$(LD) $(LDFLAGS) -o $@ $(BUILD_DIR)/boot.o $(BUILD_DIR)/kernel.o

check-tools:
	@command -v $(CC) >/dev/null || (echo "Missing cross compiler: $(CC)"; exit 1)
	@command -v $(LD) >/dev/null || (echo "Missing linker: $(LD)"; exit 1)

iso: $(KERNEL)
	@test -f limine/limine-bios.sys -o -f limine/limine-bios-cd.bin || (echo "Install Limine files under ./limine first; see docs/BUILD.md"; exit 1)
	@command -v xorriso >/dev/null || (echo "Missing xorriso"; exit 1)
	mkdir -p $(ISO_ROOT)/boot/limine
	cp $(KERNEL) $(ISO_ROOT)/boot/workprint.elf
	cp limine.conf $(ISO_ROOT)/boot/limine/limine.conf
	cp limine/limine-bios.sys limine/limine-bios-cd.bin limine/limine-uefi-cd.bin $(ISO_ROOT)/boot/limine/
	cp limine/BOOTX64.EFI $(ISO_ROOT)/EFI/BOOT/BOOTX64.EFI
	xorriso -as mkisofs -b boot/limine/limine-bios-cd.bin -no-emul-boot -boot-load-size 4 -boot-info-table --efi-boot boot/limine/limine-uefi-cd.bin -efi-boot-part --efi-boot-image --protective-msdos-label $(ISO_ROOT) -o $(BUILD_DIR)/workprint.iso

clean:
	rm -rf $(BUILD_DIR)
