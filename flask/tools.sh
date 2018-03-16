#!/usr/bin/env bash

IMAGE_NAME='pornhub'

clean()
{
    docker stop $(docker ps -a | grep "$IMAGE_NAME" | awk '{print $1}')
    docker rm $(docker ps -a | grep "$IMAGE_NAME" | awk '{print $1}')
}
cleanAll()
{
    clean
    docker rmi "$IMAGE_NAME"
}

start()
{
    docker run -p 4000:80 -d "$IMAGE_NAME"
}

stop()
{
    docker stop $(docker ps -a | grep "$IMAGE_NAME" | awk '{print $1}')
}

build()
{
    docker build --no-cache -t "$IMAGE_NAME" .
}
ps()
{
    docker ps -a | grep "$IMAGE_NAME"
}


case $1 in
    clean)
    clean
    ;;
    cleanAll)
    cleanAll
    ;;
    stop)
    stop
    ;;
    start)
    start
    ;;
    build)
    build
    ;;
    ps)
    ps
    ;;
    *)
    echo "Usage: ./tools.sh {start|cleanAll|clean|stop|build|ps}"
    ;;
esac





