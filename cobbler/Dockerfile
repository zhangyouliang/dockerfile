FROM centos:7.3.1611

RUN yum install yum-utils epel-release wget -y \
    && yum-config-manager --add-repo http://mirrors.aliyun.com/repo/epel-7.repo \
    && yum-config-manager --add-repo http://download.opensuse.org/repositories/home:/libertas-ict:/cobbler28/CentOS_7/home:libertas-ict:cobbler28.repo \
    && yum makecache \
    && yum -y install cobbler tftp-server dhcp openssl cobbler-web supervisor \
    && yum clean all \
    && yum -y update
RUN wget -O /var/lib/cobbler/loaders/README http://cobbler.github.io/loaders/README \
    && wget -O /var/lib/cobbler/loaders/COPYING.elilo http://cobbler.github.io/loaders/COPYING.elilo \
    && wget -O /var/lib/cobbler/loaders/COPYING.yaboot http://cobbler.github.io/loaders/COPYING.yaboot \
    && wget -O /var/lib/cobbler/loaders/COPYING.syslinux http://cobbler.github.io/loaders/COPYING.syslinux \
    && wget -O /var/lib/cobbler/loaders/elilo-ia64.efi http://cobbler.github.io/loaders/elilo-3.8-ia64.efi \
    && wget -O /var/lib/cobbler/loaders/yaboot http://cobbler.github.io/loaders/yaboot-1.3.17 \
    && wget -O /var/lib/cobbler/loaders/pxelinux.0 http://cobbler.github.io/loaders/pxelinux.0-3.86 \
    && wget -O /var/lib/cobbler/loaders/menu.c32 http://cobbler.github.io/loaders/menu.c32-3.86 \
    && wget -O /var/lib/cobbler/loaders/grub-x86.efi http://cobbler.github.io/loaders/grub-0.97-x86.efi \
    && wget -O /var/lib/cobbler/loaders/grub-x86_64.efi http://cobbler.github.io/loaders/grub-0.97-x86_64.efi

COPY tftp /etc/xinetd.d/tftp
COPY docker-entrypoint.sh /usr/local/bin/
COPY supervisord.d/conf.ini /etc/supervisord.d/conf.ini

CMD ["docker-entrypoint.sh"]
