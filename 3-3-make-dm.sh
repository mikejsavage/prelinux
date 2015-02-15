#! /bin/bash

set -e

cd lvm2
./configure -C \
	--prefix= \
	--enable-static_link \
	--disable-nls \
	CC=musl-gcc LDFLAGS=-L"$PWD"/../deps/lib
make device-mapper
make install_device-mapper DESTDIR="$PWD"/../deps
cd ..
