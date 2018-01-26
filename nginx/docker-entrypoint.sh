#!/bin/sh
if [[ ${GIT_URL} != "NULL" ]];then
    git clone ${GIT_URL} /configure
    cp /configure/${Configure_SCR} ${Configure_DEST}
fi
exec nginx -g "daemon off;"
