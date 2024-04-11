## Gaining root on a v74 FW Mazda HU

## Usage
- Format USB to Fat32
- Put contents of `XSS_attack` into root of USB
- Plug into vehicle
- Play music to get debug menu/access to root terminal

## Info
`/jci/gui/system/js/systemApp.js` is from the v74 fw. This should remain unmodified as a reference and tweaks should be done via shell scripts.

## Scripts
Call these from the terminal.