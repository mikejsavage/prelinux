#! /bin/bash

set -e

version=1.6.6
dir=cryptsetup-$version
archive=$dir.tar.xz

curl https://kernel.org/pub/linux/utils/cryptsetup/v${version%.*}/$archive -o $archive
tar xf $archive
mv $dir cryptsetup
