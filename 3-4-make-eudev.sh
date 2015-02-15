#! /bin/bash

set -e

cd eudev
./configure -C \
	--prefix= \
	--disable-introspection \
	--disable-gudev \
	--disable-keymap \
	--disable-manpages \
	CC=musl-gcc \
	CFLAGS=-I"$PWD"/../deps/include \
	LDFLAGS=-L"$PWD"/../deps/lib
make || true
make install DESTDIR="$PWD"/../deps || true
