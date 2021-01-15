#!/usr/bin/env bash

# Example:
# docker-tags "microsoft/nanoserver" "microsoft/dotnet" "library/mongo" "library/redis"



docker-tags() {
    arr=("$@")

    for item in "${arr[@]}";
    do
        image=${item}
        echo "------------------ ${image} ------------------"
curl -s  https://registry.hub.docker.com/v1/repositories/${image}/tags \
| tr -d '[\[\]" ]' \
| tr '}' '\n' \
| awk -F: -v image=${image} '{if(NR!=NF && $3 != ""){printf("%s:%s\n",image,$3)}}'

    done
}
docker-tags $@