#!/bin/bash
#
# requires:
#  bash
#  chroot
#
set -e

echo "doing execscript.sh: $1"

declare chroot_dir=$1

mv ${chroot_dir}/etc/pam.d/sshd ${chroot_dir}/etc/pam.d/sshd.0

cat <<EOS > ${chroot_dir}/etc/pam.d/sshd
#%PAM-1.0
#auth      required     pam_sepermit.so
#auth       include      password-auth

auth        required      pam_env.so
auth        requisite     pam_unix.so nullok try_first_pass
auth        sufficient    pam_google_authenticator.so
auth        requisite     pam_succeed_if.so uid >= 500 quiet
auth        required      pam_deny.so

account    required     pam_nologin.so
account    include      password-auth
password   include      password-auth
# pam_selinux.so close should be the first session rule
session    required     pam_selinux.so close
session    required     pam_loginuid.so
# pam_selinux.so open should only be followed by sessions to be executed in the user context
session    required     pam_selinux.so open env_params
session    optional     pam_keyinit.so force revoke
session    include      password-auth
EOS
