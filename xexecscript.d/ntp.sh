#!/bin/bash
#
# requires:
#  bash
#  chroot
#
set -e

echo "doing execscript.sh: $1"

declare chroot_dir=$1

unprevent_daemons_starting ${chroot_dir} ntpd
unprevent_daemons_starting ${chroot_dir} ntpdate
