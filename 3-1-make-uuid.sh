#! /bin/bash

set -e

# > hhhhhhhh has joined #musl
# hhhhhhhh holy goddamn fuck gnu tools are written by idiots
# hhhhhhhh naturally, the make target to install the libs from util-linux is
# hhhhhhhh make install-usrlib_execLTLIBRARIES
# hhhhhhhh but when you do it with CC=musl-gcc
# hhhhhhhh it compiles with with musl-gcc
# hhhhhhhh then it compiles them again with regular gcc
# hhhhhhhh and installs the regular libs
# hhhhhhhh fuck
# zhasha   What did you expect?
# hhhhhhhh i don't know
# zhasha   Hell, it's probably unintentional but a side effect of having 614 times more code than necessary

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
	--without-user \
	--disable-nls \
	CC=musl-gcc
make CC=musl-gcc libblkid.la libuuid.la
make \
	install-nodist_blkidincHEADERS \
	install-uuidincHEADERS \
	DESTDIR="$PWD"/../deps
	# install-usrlib_execLTLIBRARIES \ # fucking idiots

cp -r .libs ../deps/lib

cd ..
