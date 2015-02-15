#! /bin/bash

set -e

[[ -d util-linux ]] || ./1-1-download-util-linux.sh
[[ -d popt ]]       || ./1-2-download-popt.sh
[[ -d lvm2 ]]       || ./1-3-download-lvm2.sh
[[ -d eudev ]]      || ./1-4-download-eudev.sh
[[ -d cryptsetup ]] || ./1-5-download-cryptsetup.sh
[[ -d mksh ]]       || ./1-6-download-mksh.sh
