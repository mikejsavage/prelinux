#! /bin/bash

set -e

version=2.02.116
dir=LVM2.$version
archive=$dir.tgz

curl http://mirrors.kernel.org/sources.redhat.com/lvm2/$archive -o $archive
tar xf $archive
mv $dir lvm2
