# Printing architecture

A universal USB printer driver is not realistic. USB detection only identifies a device; it does not imply that the operating system understands the printer's command language.

## Preferred path

1. Detect the USB device and record vendor/product IDs.
2. Check whether the printer exposes IPP-over-USB (IPP-USB).
3. For network printers, discover IPP services and query supported document formats and printer attributes.
4. Prefer standards-based IPP Everywhere when the device advertises the required capabilities.
5. Select a backend only after capability discovery. Examples include PWG Raster, PDF, PostScript, PCL or vendor-specific languages, depending on the printer.

## On-device diagnostic helper

Run the read-only diagnostic from a terminal after booting the live system:

```sh
sh /usr/share/workprint/tools/diagnose-printers.sh
```

It reports USB vendor/product IDs, CUPS scheduler status, discovered CUPS backends and IPP-USB service status. It does not install drivers, change printer configuration or send a test page. Record the exact printer model and compare the reported IDs with the manufacturer's documentation before selecting a driver.

## Included components

The current live image package list includes:
- CUPS and CUPS client/filter components for print spooling and conversion.
- system-config-printer for printer administration.
- ipp-usb for printers exposing IPP-over-USB.
- HPLIP and the HP CUPS driver package.
- Gutenprint and brlaser for selected printer families.

Package inclusion is not a claim that every printer model is supported. Actual support depends on the printer model, firmware, advertised protocols and available driver.

## Compatibility policy

- Never send a format merely because the printer is connected.
- Never claim support for HP, Epson, Canon, Brother, Samsung, Lexmark, Xerox or any other brand without testing specific models.
- Maintain a tested model/firmware matrix.
- Provide clear unsupported-device messages instead of silently printing corrupted pages.

## Current status

The printing software is included in the first ISO build configuration. No physical printer has yet been tested with WorkPrint 64. The target HP printer's exact model is still unknown, so its compatibility cannot yet be confirmed.

The first hardware test must verify CUPS service startup, USB/network discovery, driver selection and successful sample-page output. See [the validation plan](TEST_PLAN.md).
