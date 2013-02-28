#!/bin/bash
#
# requires:
#  bash
#  chroot
#
set -e

echo "doing execscript.sh: $1"

declare chroot_dir=$1

create_user_account  ${chroot_dir} google-authenticator
update_user_password ${chroot_dir} google-authenticator google-authenticator
