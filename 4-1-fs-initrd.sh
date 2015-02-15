#! /bin/bash

set -e

cp ramdisk.txt initramfs.lst
echo -n > fstab

# append a list of all the sbase/ubase symlinks to initramfs.lst
find sbase/ -maxdepth 1 -type f ! -name "sbase-box" -executable | sed "s/^sbase\(.*\)/slink \/bin\1 sbase-box 777 0 0/g" >> initramfs.lst
find ubase/ -maxdepth 1 -type f ! -name "ubase-box" -executable | sed "s/^ubase\(.*\)/slink \/bin\1 ubase-box 777 0 0/g" >> initramfs.lst

for linux in /usr/src/linux-*; do
	/usr/src/$linux/usr/gen_init_cpio initramfs.lst > initrd-${linux#linux-}
done
