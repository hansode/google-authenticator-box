#!/bin/bash
#
# requires:
#  bash
#
set -e

declare chroot_dir=$1

while read param value; do
  config_sshd_config ${chroot_dir}/etc/ssh/sshd_config ${param} ${value}
done < <(cat <<-EOS | egrep -v '^#|^$'
	PasswordAuthentication no
	ChallengeResponseAuthentication yes
	UsePAM yes
	EOS
	)
