#! /bin/bash

set -e

version=R50e
dir=mksh-$version
archive=$dir.tgz

curl https://www.mirbsd.org/MirOS/dist/mir/mksh/$archive -o $archive
tar xf $archive
