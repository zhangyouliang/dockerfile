#!/bin/bash
# REDIS_CLUSTER="redis_master01:6379,redis_slave01:6379"
set -e
if [[ ${GIT_URL} != "NULL" ]];then
    git clone ${GIT_URL} /configure
    for n in $(seq 30);do
        if [[ $(echo $(eval echo \$\{Configure_File_SCR_${n}\}) | wc -L) != 0 ]]; then
            if [[ -e $(eval echo \$\{Configure_File_DEST_${n}\}) ]]; then
                rm -rf $(eval echo \$\{Configure_File_DEST_${n}\})
            fi
            cp -r /configure/$(eval echo \$\{Configure_File_SCR_${n}\}) $(eval echo \$\{Configure_File_DEST_${n}\})
            echo "Copy configfile /configure/$(eval echo \$\{Configure_File_SCR_${n}\}) to $(eval echo \$\{Configure_File_DEST_${n}\})"
        else
            break
        fi
    done
fi
i=0
for host in `echo ${REDIS_CLUSTER} | sed "s/,/\n/g"`
do
    # server master master:6379 check inter 1s
    HO="${HO}|server redis${i} ${host}  check port 6379 inter 5s fastinter 2s downinter 5s rise 3 fall 3"
    i=`expr $i + 1`
done
echo ${HO:1} | sed 's/|/\n/g' | sed 's/server/    server/g' >> /usr/local/etc/haproxy/haproxy.cfg

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- haproxy "$@"
fi

if [ "$1" = 'haproxy' ]; then
	shift # "haproxy"
	# if the user wants "haproxy", let's add a couple useful flags
	#   -W  -- "master-worker mode" (similar to the old "haproxy-systemd-wrapper"; allows for reload via "SIGUSR2")
	#   -db -- disables background mode
  set -- haproxy -W -db "$@"
fi

exec "$@"
