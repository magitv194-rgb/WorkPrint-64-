#include <stdint.h>

#define COM1 0x3F8
#define LIMINE_MEMMAP_MAX_PRINT 128

struct limine_memmap_entry {
    uint64_t base;
    uint64_t length;
    uint64_t type;
};

struct limine_memmap_response {
    uint64_t revision;
    uint64_t entry_count;
    struct limine_memmap_entry **entries;
};

struct limine_memmap_request {
    uint64_t id[4];
    uint64_t revision;
    struct limine_memmap_response *response;
};

/*
 * Limine protocol base revision 6. The bootloader sets element [2]
 * to zero when it supports the requested base revision.
 */
__attribute__((used, section(".limine_requests"), aligned(8)))
static volatile uint64_t limine_base_revision[3] = {
    0xf9562b2d5c95a6c8,
    0x6a7b384944536bdc,
    6
};

__attribute__((used, section(".limine_requests_start"), aligned(8)))
static volatile uint64_t limine_requests_start_marker[4] = {
    0xf6b8f4b39de7d1ae,
    0xfab91a6940fcb9cf,
    0x785c6ed015d3e316,
    0x181e920a7852b9d9
};

__attribute__((used, section(".limine_requests"), aligned(8)))
static volatile struct limine_memmap_request memmap_request = {
    .id = {
        0xc7b1dd30df4c8b88,
        0x0a82e883a194f07b,
        0x67cf3d9d378a806f,
        0xe304acdfc50c3c62
    },
    .revision = 0,
    .response = 0
};

__attribute__((used, section(".limine_requests_end"), aligned(8)))
static volatile uint64_t limine_requests_end_marker[2] = {
    0xadc0e0531bb10d03,
    0x9572709f31764c62
};

static inline void outb(uint16_t port, uint8_t value)
{
    __asm__ volatile ("outb %0, %1" : : "a"(value), "Nd"(port));
}

static inline uint8_t inb(uint16_t port)
{
    uint8_t value;
    __asm__ volatile ("inb %1, %0" : "=a"(value) : "Nd"(port));
    return value;
}

static void serial_init(void)
{
    outb(COM1 + 1, 0x00);
    outb(COM1 + 3, 0x80);
    outb(COM1 + 0, 0x03);
    outb(COM1 + 1, 0x00);
    outb(COM1 + 3, 0x03);
    outb(COM1 + 2, 0xC7);
    outb(COM1 + 4, 0x0B);
}

static void serial_putc(char c)
{
    unsigned int limit = 1000000;
    while ((inb(COM1 + 5) & 0x20) == 0 && --limit != 0) { }
    outb(COM1, (uint8_t)c);
}

static void serial_write(const char *text)
{
    while (*text) {
        if (*text == '\n') serial_putc('\r');
        serial_putc(*text++);
    }
}

static void serial_hex64(uint64_t value)
{
    static const char digits[] = "0123456789abcdef";
    for (int shift = 60; shift >= 0; shift -= 4) {
        serial_putc(digits[(value >> shift) & 0x0f]);
    }
}

static void print_memory_map(void)
{
    struct limine_memmap_response *response = memmap_request.response;

    if (response == 0 || response->entries == 0) {
        serial_write("Limine did not provide a memory map response.\n");
        return;
    }

    serial_write("Memory map entry count: 0x");
    serial_hex64(response->entry_count);
    serial_write("\n");

    uint64_t count = response->entry_count;
    if (count > LIMINE_MEMMAP_MAX_PRINT) {
        count = LIMINE_MEMMAP_MAX_PRINT;
        serial_write("Memory map output capped at 128 entries.\n");
    }

    for (uint64_t i = 0; i < count; ++i) {
        struct limine_memmap_entry *entry = response->entries[i];
        if (entry == 0) {
            serial_write("Memory map contains a null entry pointer.\n");
            break;
        }

        serial_write("base=0x");
        serial_hex64(entry->base);
        serial_write(" length=0x");
        serial_hex64(entry->length);
        serial_write(" type=0x");
        serial_hex64(entry->type);
        serial_write("\n");
    }
}

__attribute__((noreturn))
void kernel_main(void)
{
    serial_init();

    if (limine_base_revision[2] != 0) {
        serial_write("\nWorkPrint 64: incompatible Limine base revision.\n");
        for (;;) __asm__ volatile ("cli; hlt");
    }

    serial_write("\nWorkPrint 64 kernel entered.\n");
    serial_write("Limine base revision 6 accepted.\n");
    print_memory_map();
    serial_write("Early boot stage only. No desktop, networking or printing yet.\n");

    for (;;) __asm__ volatile ("cli; hlt");
}
