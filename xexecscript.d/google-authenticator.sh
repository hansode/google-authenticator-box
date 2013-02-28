#!/bin/bash
#
# requires:
#  bash
#  chroot
#
set -e

echo "doing execscript.sh: $1"

declare chroot_dir=$1

## devel user

chroot ${chroot_dir} su - ${devel_user} <<'EOS'
whoami

git clone https://code.google.com/p/google-authenticator/
cd google-authenticator/libpam
make
sudo make install

yes | google-authenticator
EOS
