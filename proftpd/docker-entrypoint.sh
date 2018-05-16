#!/bin/bash
set -e
MasqueradeAddress=$(curl -s  --unix-socket /run/docker.sock http://unix/info  | jq -r .Swarm.NodeAddr)
sed -i "s/^#.MasqueradeAddress.*/MasqueradeAddress ${MasqueradeAddress}/g" /etc/proftpd/proftpd.conf
echo -e "\n\nSQLConnectInfo ${MYSQL_DATABASE}@${MYSQL_HOST}:${MYSQL_PORT} ${MYSQL_USER} ${MYSQL_PASSWORD}" >> /etc/proftpd/sql.conf
chown -R www-data:www-data /var/www
chmod -R 775 /var/www

exec proftpd -nc /etc/proftpd/proftpd.conf