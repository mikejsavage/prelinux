#! /bin/bash

set -e

cd popt
./configure -C \
	--prefix= \
	--disable-nls \
	CC=musl-gcc
make
make install DESTDIR="$PWD"/../deps
cd ..
