#!/bin/bash
set -e
MasqueradeAddress=$(curl -s  --unix-socket /run/docker.sock http://unix/info  | jq -r .Swarm.NodeAddr)
sed -i "s/^#.MasqueradeAddress.*/MasqueradeAddress ${MasqueradeAddress}/g" /etc/proftpd/proftpd.conf
echo -e "\n\nSQLConnectInfo ${MYSQL_DATABASE}@${MYSQL_HOST}:${MYSQL_PORT} ${MYSQL_USER} ${MYSQL_PASSWORD}" >> /etc/proftpd/sql.conf
chown -R www-data:www-data /var/www
# chmod -R 775 /var/www
# cat > /tmp/mysql.cnf << EOF
# [client]
# port = ${MYSQL_PORT}
# host = ${MYSQL_HOST}
# user= ${MYSQL_USER}
# password = ${MYSQL_PASSWORD}
# EOF
# mysql --defaults-file=/tmp/mysql.cnf ${MYSQL_DATABASE} < /var/lib/proftpd/ftp_group.sql
# mysql --defaults-file=/tmp/mysql.cnf ${MYSQL_DATABASE} < /var/lib/proftpd/ftp_user.sql
# rm -rf /tmp/mysql.cnf
exec proftpd -nc /etc/proftpd/proftpd.conf