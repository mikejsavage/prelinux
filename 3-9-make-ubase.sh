#! /bin/bash

set -e

make -C ubase/ all ubase-box CC=musl-gcc LDFLAGS="-s -static"
