#!/bin/sh
echo "root:${PASSWORD}" | chpasswd &> /dev/null || exit 1
SHELL=$(awk -F ':' "/^${USER}/{print \$NF}" /etc/passwd)
sed -i "/${USER}/s|${SHELL}|/usr/bin/rssh|g" /etc/passwd
mkdir /usr/local/chroot
echo "logfacility = LOG_USER

allowscp
# allowsftp
# allowcvs
# allowrdist
# allowrsync

umask = 022

# chrootpath = /usr/local/chroot

user=${USER}:022:00001" > /etc/rssh.conf
ssh-keygen -A &> /dev/null
exec /usr/sbin/sshd -D -e
