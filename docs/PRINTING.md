# Printing architecture

A universal USB printer driver is not realistic. USB detection only identifies a device; it does not imply that the operating system understands the printer's command language.

## Preferred path

1. Detect the USB device and record vendor/product IDs.
2. Check whether the printer exposes IPP-over-USB (IPP-USB).
3. For network printers, discover IPP services and query supported document formats and printer attributes.
4. Prefer standards-based IPP Everywhere when the device advertises the required capabilities.
5. Select a backend only after capability discovery. Examples include PWG Raster, PDF, PostScript, PCL or vendor-specific languages, depending on the printer.

## Compatibility policy

- Never send a format merely because the printer is connected.
- Never claim support for HP, Epson, Canon, Brother, Samsung, Lexmark, Xerox or any other brand without testing specific models.
- Maintain a tested model/firmware matrix.
- Provide clear unsupported-device messages instead of silently printing corrupted pages.

## Current status

No USB stack, IPP client, spooler, rasterizer or printer backend is implemented in this repository. This document describes the intended design only.
