#!/usr/bin/env python3
"""Validate the basic ELF64 layout expected by the WorkPrint 64 boot scaffold."""
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
e_type, e_machine, _, entry, phoff, _, _, _, phentsize, phnum, *_ = header
if e_type != 2 or e_machine != 62:
    fail("expected x86_64 executable (ET_EXEC)")
if phentsize < 56 or phoff + phentsize * phnum > len(data):
    fail("invalid program-header table")

loads = []
for index in range(phnum):
    fields = struct.unpack_from("<IIQQQQQQ", data, phoff + index * phentsize)
    p_type, p_flags, p_offset, p_vaddr, p_paddr, p_filesz, p_memsz, p_align = fields
    if p_type != 1:  # PT_LOAD
        continue
    if p_filesz > p_memsz:
        fail(f"load segment {index}: file size exceeds memory size")
    if p_offset + p_filesz > len(data):
        fail(f"load segment {index}: data extends past end of file")
    if p_paddr < 0x00100000 or p_paddr >= 0x100000000:
        fail(f"load segment {index}: physical address is outside the expected low-memory window")
    if p_vaddr < 0xFFFFFFFF80000000:
        fail(f"load segment {index}: virtual address is not in the higher half")
    if p_align not in (0, 1) and (p_align & (p_align - 1)):
        fail(f"load segment {index}: alignment is not a power of two")
    loads.append((p_flags, p_vaddr, p_paddr, p_memsz))

if not loads:
    fail("no PT_LOAD segments found")
if not any((flags & 1) and start <= entry < start + size for flags, start, _, size in loads):
    fail("entry point is not inside an executable load segment")

print(f"ELF OK: entry=0x{entry:016x}; {len(loads)} load segments")
for flags, vaddr, paddr, memsz in loads:
    print(f"  VMA=0x{vaddr:016x} LMA=0x{paddr:08x} MEM=0x{memsz:x} FLAGS={flags}")
