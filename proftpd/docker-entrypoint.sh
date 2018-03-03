#!/bin/bash
set -e
cat > /etc/proftpd/sql.conf << EOF
SQLBackend        mysql
SQLAuthTypes            OpenSSL Crypt
SQLAuthenticate         users groups
SQLConnectInfo  ${MYSQL_DB}@${MYSQL_HOST} ${MYSQL_USER} ${MYSQL_PASS}
SQLUserInfo     ftpuser userid passwd uid gid homedir shell
SQLGroupInfo    ftpgroup groupname gid members
SQLMinID        500
SQLLog PASS updatecount
SQLNamedQuery updatecount UPDATE "count=count+1, accessed=now() WHERE userid='%u'" ftpuser
SQLLog  STOR,DELE modified
SQLNamedQuery modified UPDATE "modified=now() WHERE userid='%u'" ftpuser
SqlLogFile /var/log/proftpd/sql.log
SQLDefaultUID ${SQLDefaultUID}
SQLDefaultGID ${SQLDefaultGID}
EOF

sed -i "s/#.MasqueradeAddress.*/MasqueradeAddress 175.25.184.203/g" /etc/proftpd/proftpd.conf
exec proftpd -nc /etc/proftpd/proftpd.conf
