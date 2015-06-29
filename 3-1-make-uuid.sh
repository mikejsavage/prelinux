#! /bin/bash

set -e

cd util-linux
./configure -C \
	--prefix= \
	--disable-libmount \
	--disable-libsmartcols \
	--disable-mount \
	--disable-losetup \
	--disable-fsck \
	--disable-partx \
	--disable-uuidd \
	--disable-mountpoint \
	--disable-fallocate \
	--disable-unshare \
	--disable-nsenter \
	--disable-setpriv \
	--disable-eject \
	--disable-agetty \
	--disable-cramfs \
	--disable-bfs \
	--disable-minix \
	--disable-fdformat \
	--disable-hwclock \
	--disable-wdctl \
	--disable-switch_root \
	--disable-pivot_root \
	--without-python \
	--without-ncurses \
	--without-user \
	--disable-nls \
	CC=musl-gcc
make CC=musl-gcc libblkid.la libuuid.la
make \
	install-nodist_blkidincHEADERS \
	install-uuidincHEADERS \
	DESTDIR="$PWD"/../deps
	# install-usrlib_execLTLIBRARIES \ # for some reason this rebuilds everything against gcc...

cp -r .libs ../deps/lib

cd ..
