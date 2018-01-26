#!/bin/sh
set -e

if [[ ${GIT_URL} != "NULL" ]];then
    git clone ${GIT_URL} /configure
    cp /configure/${Configure_SCR} ${Configure_DEST}
fi

# first arg is `-f` or `--some-option`
# or first arg is `something.conf`
if [ "${1#-}" != "$1" ] || [ "${1%.conf}" != "$1" ]; then
	set -- redis-server "$@"
fi

# allow the container to be started with `--user`
if [ "$1" = 'redis-server' -a "$(id -u)" = '0' ]; then
	chown -R redis .
	exec su-exec redis "$0" "$@"
fi

exec "$@"
