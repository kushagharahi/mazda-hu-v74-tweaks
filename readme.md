## v74 CMU Info
### XSS_attack
Used to gain root on a v74 FW Mazda HU
- Format USB to Fat32
- Put contents of `XSS_attack` into root of USB
- Plug into vehicle
- Play music to get debug menu/access to root terminal
### jci
`/jci/gui/system/js/systemApp.js` is from the v74 fw. This should remain unmodified as a reference and tweaks should be done via shell scripts.

### scripts
Call these from the terminal.
- removeStartupDisclaimer.sh - THIS IS A WIP and will cause your system to bootloop!

### spi_flash_backups
See [spi_flash_backups/readme.md](spi_flash_backups/readme.md) for more information.