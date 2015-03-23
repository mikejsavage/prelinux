#! /bin/bash

set -e

make -C sbase/ all sbase-box CC=musl-gcc LDFLAGS="-s -static"
