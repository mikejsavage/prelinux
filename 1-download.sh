#! /bin/bash

set -e

[[ -d util-linux ]] || ./1-1-download-util-linux.sh
[[ -d popt ]]       || ./1-2-download-popt.sh
[[ -d lvm2 ]]       || ./1-3-download-lvm2.sh
[[ -d eudev ]]      || ./1-4-download-eudev.sh
[[ -d nettle ]]     || ./1-5-download-nettle.sh
[[ -d cryptsetup ]] || ./1-6-download-cryptsetup.sh
[[ -d mksh ]]       || ./1-7-download-mksh.sh
