#!/bin/sh
set -e
if [[ ${GIT_URL} != "NULL" ]];then
    git clone ${GIT_URL} /configure
    for n in $(seq 30);do
        if [[ -n $(eval echo \$\{Configure_File_SCR_${n}\}) ]]; then
            mv /configure/$(eval echo \$\{Configure_File_SCR_${n}\}) $(eval echo \$\{Configure_File_DEST_${n}\})
        else
            break
        fi
    done
fi
case "$1" in
    *.yaml|*.yml) set -- registry serve "$@" ;;
    serve|garbage-collect|help|-*) set -- registry "$@" ;;
esac
exec "$@"
