#!/bin/sh
if [[ ${GIT_URL} != "NULL" ]];then
    git clone ${GIT_URL} /configure
    for n in $(seq 30);do
        if [[ -n $(eval echo \$\{Configure_File_SCR_${n}\}) ]]; then
            if [[ -e $(eval echo \$\{Configure_File_DEST_${n}\}) ]]; then
                rm -rf $(eval echo \$\{Configure_File_DEST_${n}\})
            fi
            cp -r /configure/$(eval echo \$\{Configure_File_SCR_${n}\}) $(eval echo \$\{Configure_File_DEST_${n}\})
        else
            break
        fi
    done
fi
exec nginx -g "daemon off;"
