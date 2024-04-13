# NOR SPI Flash dumps and modifications

## ☠️☠️🔴🔴 DANGER: No support is given. Do this at your own risk. This is highly unsafe and can leave you with an expensive brick. I hope you know what you are doing! 🔴🔴☠️☠️

## What is a NOR SPI Flash chip and what does it do in the CMU?
Basically it's a small flash chip that contains the boot programs for the CMU.

## Files
These are dumped from a `MX25L6433FZ2I-08G Macronix` NOR SPI Flash chip from a CMU on OS Version: 74.00.324 NA N and Fail-Safe 74.00.324 
- backup-cmu.bin - stock backup
- backup-newsquashfs.bin - stock backup + new squashfs that has a new `cmu` user password (`cmu/jci`) 
  - follow from step 8 to flash this onto your system.

## How?
Credit to http://ru1.ktkd.ru/mazda2.html for the outline of how to do this.

1 - dump the SPI NOR flash memory first
- see: https://www.mazda3revolution.com/threads/black-screen-mzd.229891/post-2401643 for how to do that with a Raspberry PI
- This is how `backup-cmu.bin` was created
- **MAKE BACKUPS OF THIS BINARY. IF YOU SCREW UP, THIS WILL BE LOST FOREVER**
- **MAKE BACKUPS OF THIS BINARY. IF YOU SCREW UP, THIS WILL BE LOST FOREVER**
- **MAKE BACKUPS OF THIS BINARY. IF YOU SCREW UP, THIS WILL BE LOST FOREVER**

2 - dump the squashfs partition located at 0x070000
- `dd if=backup-cmu.bin of=squashfs.bin bs=1 skip=$((0x070000))`

3 - unpack the squashfs image
- `unsquashfs squashfs.bin`

4 - modify `passwd` for the `cmu` user from [ID7 recovery](https://mazdatweaks.com/id7/) (makes it `cmu/jci` login)
- `cmu:$5$tDn5yi8Rsf8e$OeOTL/ZnIkwNgIRU8vAiZwvavRqfkAIw3pVZ5P9DYwD:0:0:root:/root:/bin/sh`

5 - repack the squashfs image
- `mksquashfs squashfs-root new_squashfs_image.bin`

6 - pad the image with zeroes to match the original size of the initial dumped squash fs image (~4 kb vs ~7.5mb)
-  ```
    original_size=$(stat -c %s squashfs.bin)
    modified_size=$(stat -c %s new_squashfs_image.bin)
    padding=$((original_size - modified_size))
    dd if=/dev/zero bs=1 count=$padding >> new_squashfs_image.bin
- this needs to be done because we are going to overwrite the squashfs partition in our original SPI NOR flash memory dump, so it should be the same size.

7 - put the new squashfs image into the flash memory dump at the same offset to override the old squashfs partition
- `dd if=new_squashfs_image.bin of=backup-cmu.bin bs=1 seek=$((0x070000))`

8 - reflashed the SPI chip with updated binary (`backup-cmu.bin`)
- once again see: https://www.mazda3revolution.com/threads/black-screen-mzd.229891/post-2401643 for how to do that with a Raspberry PI and flashrom

9 - once you finish this, you should be able to login to the serial console as a root user with the user/pass of `cmu/jci`. It is well documented online how to connect via serial to the CMU.
- a great life pro tip, piping the serial output to this grep will cut down on a lot of the spam helping you to understand what you're doing e.g, [CODE]<serial output command> | grep -v -E '^[0-9]{2}:[0-9]{2}:[0-9]{2}\.[0-9]+' -u[/CODE]