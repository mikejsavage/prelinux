#! /bin/bash

set -e

version=2.1.1
dir=eudev-$version
archive=$dir.tar.gz

curl http://dev.gentoo.org/~blueness/eudev/$archive -o $archive
tar xf $archive
mv $dir eudev
