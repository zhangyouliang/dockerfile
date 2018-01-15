#!/bin/bash

set -e

OPTIONS="-f docker-compose.yml"

case $1 in
    build )
        docker-compose $OPTIONS build
    ;;
    run )
        docker-compose $OPTIONS up -d
    ;;
    start )
        docker-compose $OPTIONS start
    ;;
    stop )
        docker-compose $OPTIONS stop
    ;;
    clean_container)
        docker-compose $OPTIONS down
    ;;
    cleanall)
        docker-compose $OPTIONS --rmi all
    ;;
    ps)
        docker-compose $OPTIONS ps
    ;;
    * )
        echo 'Usage: ./tools.sh {build | run | exec| cleanall | clean_container | ps | stop | start}'
    ;;
esac



