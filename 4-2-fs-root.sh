#! /bin/bash

set -e

mkdir -p prelinux/bin prelinux/sbin prelinux/etc

touch sbase/sed.1 # XXX this should be removed at some point

# install sbase/ubase/smdev
make -C sbase/ install DESTDIR="$PWD"/prelinux PREFIX=/usr MANPREFIX=/usr/man
make -C ubase/ install DESTDIR="$PWD"/prelinux PREFIX=/usr MANPREFIX=/usr/man
make -C smdev/ install DESTDIR="$PWD"/prelinux PREFIX=/usr MANPREFIX=/usr/man

# install mksh
cp mksh/mksh prelinux/bin/
ln -fs mksh prelinux/bin/sh

# install ports
cp ports/fs/etc/{group,passwd} prelinux/etc/
echo -n > prelinux/etc/fstab

# install cryptsetup
cp cryptsetup/src/cryptsetup.static prelinux/sbin/cryptsetup
cp cryptsetup/man/cryptsetup.8 prelinux/usr/man/man8

# install /sbin/init
cp init_prelinux prelinux/sbin/init
chmod +x prelinux/sbin/init

for f in prelinux/usr/man/man*/*.[1-8]; do
	man "$f" | col -b > ${f%.*}.txt
	rm "$f"
done
