#!/bin/sh
# set -ex
user='www-data'
group='www-data'
if ! [ -e _h5ai/public/index.php ]; then
    echo >&2 "H5ai not found in $PWD - copying now..."
    if [ "$(ls -A)" ]; then
        echo >&2 "WARNING: $PWD is not empty - press Ctrl+C now if this is an error!"
        ( set -x; ls -A; sleep 10 )
    fi
    tar --create \
        --file - \
        --one-file-system \
        --directory /usr/src/_h5ai \
        --owner "$user" --group "$group" \
        . | tar --extract --file -
    echo >&2 "Complete! H5ai has been successfully copied to $PWD"
fi
exec "$@"
