#!/bin/sh
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
