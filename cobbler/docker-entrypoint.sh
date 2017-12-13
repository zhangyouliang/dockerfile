#!/bin/bash
sed -i "s/server: 127.0.0.1/server: $Cobbler_SERVER_IP/g" /etc/cobbler/settings
sed -i "s/next_server:.*/next_server: $Cobbler_NEXT_SERVER_IP/g" /etc/cobbler/settings
Cobbler_PASSWORD=$(openssl passwd -1 -salt '123456' "$Cobbler_PASSWORD")
sed -i "s|default_password_crypted:.*|default_password_crypted: \"$Cobbler_PASSWORD\"|" /etc/cobbler/settings
sed -i 's/pxe_just_once: 0/pxe_just_once: 1/g' /etc/cobbler/settings

sed -i 's/manage_dhcp: 0/manage_dhcp: 1/g' /etc/cobbler/settings
sed -i "s/192.168.1.0/${Cobbler_DHCP_SUBNET}/" /etc/cobbler/dhcp.template
sed -i "s/192.168.1.5/${Cobbler_DHCP_ROUTER}/" /etc/cobbler/dhcp.template
sed -i "s/192.168.1.1;/${Cobbler_DHCP_DNS};/" /etc/cobbler/dhcp.template
sed -i "s/192.168.1.100 192.168.1.254/${Cobbler_DHCP_RANGE}/" /etc/cobbler/dhcp.template
sed -i "s/^#ServerName www.example.com:80/ServerName :80/" /etc/httpd/conf/httpd.conf
sed -i "s/service %s restart/supervisorctl restart %s/g" /usr/lib/python2.7/site-packages/cobbler/modules/sync_post_restart_services.py

rm -rf /run/httpd/*
/usr/sbin/apachectl
/usr/bin/cobblerd

cobbler sync
# cobbler get-loaders
# cobbler signature update

pkill cobblerd
pkill httpd
rm -rf /run/httpd/*

exec supervisord -n -c /etc/supervisord.conf
