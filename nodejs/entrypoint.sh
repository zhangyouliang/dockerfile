#!/bin/bash
set -e
[[ "${DEBUG}" == "true" ]] && set -x
function package_check(){
    [ ! -f '/home/node/package.json' ] \
        && { ehco 'package.json not exist!';exit 6; }
    :
}
function npm_base(){
    [[ "$(npm list nodemon)" =~ 'empty' ]] &&  npm install nodemon -g
    [[ "$(npm list request)" =~ 'empty' ]] && npm install request
    :
}
function node_base_run(){
    package_check
    npm install 
    npm_base
    exec "$@"
}

[ "$1" = 'node' -a "$#" -gt 1 ] && exec node
# edit your's  run style
[ "$*" = 'npm run start' ] && node_base_run
#----------------------

exec "$@"
