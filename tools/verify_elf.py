#!/usr/bin/env python3
"""Validate the ELF and Limine request metadata expected by WorkPrint 64."""
import struct
import sys
from pathlib import Path

def fail(message: str) -> None:
    raise SystemExit(f"ELF validation failed: {message}")

if len(sys.argv) != 2:
    fail("usage: verify_elf.py <kernel.elf>")

data = Path(sys.argv[1]).read_bytes()
if len(data) < 64 or data[:4] != b"\x7fELF":
    fail("missing or truncated ELF header")
if data[4] != 2 or data[5] != 1:
    fail("expected ELF64 little-endian")

header = struct.unpack_from("<HHIQQQIHHHHHH", data, 16)
e_type, e_machine, _, entry, phoff, shoff, _, _, phentsize, phnum, shentsize, shnum, shstrndx = header
if e_type != 2 or e_machine != 62:
    fail("expected x86_64 executable (ET_EXEC)")
if phentsize < 56 or phoff + phentsize * phnum > len(data):
    fail("invalid program-header table")
if shentsize < 64 or shoff + shentsize * shnum > len(data) or shstrndx >= shnum:
    fail("invalid section-header table")

loads = []
for index in range(phnum):
    p_type, p_flags, p_offset, p_vaddr, p_paddr, p_filesz, p_memsz, p_align = struct.unpack_from(
        "<IIQQQQQQ", data, phoff + index * phentsize
    )
    if p_type != 1:  # PT_LOAD
        continue
    if p_filesz > p_memsz:
        fail(f"load segment {index}: file size exceeds memory size")
    if p_offset + p_filesz > len(data):
        fail(f"load segment {index}: data extends past end of file")
    if p_memsz == 0:
        fail(f"load segment {index}: empty memory segment")
    if p_paddr < 0x00100000 or p_paddr >= 0x100000000:
        fail(f"load segment {index}: physical address is outside the expected low-memory window")
    if p_memsz > 0x100000000 - p_paddr:
        fail(f"load segment {index}: physical range extends beyond 4 GiB")
    if p_vaddr < 0xFFFFFFFF80000000 or p_memsz > 0xFFFFFFFFFFFFFFFF - p_vaddr:
        fail(f"load segment {index}: virtual range is outside the higher-half address space")
    if p_align not in (0, 1):
        if p_align & (p_align - 1):
            fail(f"load segment {index}: alignment is not a power of two")
        if p_vaddr % p_align != p_offset % p_align:
            fail(f"load segment {index}: virtual address and file offset are incongruent")
    loads.append((p_flags, p_vaddr, p_paddr, p_memsz))

if not loads:
    fail("no PT_LOAD segments found")
if not any((flags & 1) and start <= entry < start + size for flags, start, _, size in loads):
    fail("entry point is not inside an executable load segment")

sections = [
    struct.unpack_from("<IIQQQQIIQQ", data, shoff + index * shentsize)
    for index in range(shnum)
]
strings_section = sections[shstrndx]
if strings_section[1] != 3:  # SHT_STRTAB
    fail("section-name table is not a string table")
strings_start = strings_section[4]
strings_end = strings_start + strings_section[5]
if strings_end > len(data):
    fail("section-name string table extends past end of file")
strings = data[strings_start:strings_end]
request_section = None
for section in sections:
    name_offset = section[0]
    if name_offset >= len(strings):
        continue
    end = strings.find(b"\0", name_offset)
    if end < 0:
        continue
    if strings[name_offset:end] == b".limine_requests":
        request_section = section
        break

if request_section is None:
    fail("missing .limine_requests section")
if request_section[1] != 1:  # SHT_PROGBITS
    fail(".limine_requests is not a PROGBITS section")
request_address, request_offset, request_size = request_section[3], request_section[4], request_section[5]
if request_offset + request_size > len(data):
    fail(".limine_requests extends past end of file")
request_bytes = data[request_offset:request_offset + request_size]
start_marker = struct.pack("<QQQQ", 0xf6b8f4b39de7d1ae, 0xfab91a6940fcb9cf,
                           0x785c6ed015d3e316, 0x181e920a7852b9d9)
base_revision = struct.pack("<QQQ", 0xf9562b2d5c95a6c8, 0x6a7b384944536bdc, 6)
end_marker = struct.pack("<QQ", 0xadc0e0531bb10d03, 0x9572709f31764c62)
if not (request_bytes.find(start_marker) < request_bytes.find(base_revision) < request_bytes.find(end_marker)):
    fail("Limine request delimiters or base revision 6 tag are missing or out of order")
memmap_request_id = struct.pack("<QQQQQ", 0xc7b1dd30df4c8b88, 0x0a82e883a194f07b,
                                0x67cf3d9d378a806f, 0xe304acdfc50c3c62, 0)
if memmap_request_id not in request_bytes:
    fail("Limine memory-map request is missing from the request section")

if not any((flags & 2) and start <= request_address and
           request_address + request_size <= start + size
           for flags, start, _, size in loads):
    fail(".limine_requests is not covered by a writable PT_LOAD segment")

print(f"ELF OK: entry=0x{entry:016x}; {len(loads)} load segments; Limine base revision 6 and memory-map request OK")
for flags, vaddr, paddr, memsz in loads:
    print(f"  VMA=0x{vaddr:016x} LMA=0x{paddr:08x} MEM=0x{memsz:x} FLAGS={flags}")
