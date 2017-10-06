# mongodb

# docker-compose.yml
```
version: '2'
services:
    mongodb01:
        image: daocloud.io/buxiaomo/mongodb
        networks:
            mongodb:
                aliases:
                    - mongodb01
        ports:
            - 8008:26379/tcp
        command: mongod --dbpath /data/db --replSet repset
    mongodb02:
        image: daocloud.io/buxiaomo/mongodb
        networks:
            mongodb:
                aliases:
                    - mongodb02
        ports:
            - 8009:26379/tcp
        command: mongod --dbpath /data/db --replSet repset
    mongodb03:
        image: daocloud.io/buxiaomo/mongodb
        networks:
            mongodb:
                aliases:
                    - mongodb03
        ports:
            - 8010:26379/tcp
        command: mongod --dbpath /data/db --replSet repset
    repset:
        image: daocloud.io/buxiaomo/mongodb
        networks:
            mongodb:
                aliases:
                    - repset
        environment:
            - MONGO_CLUSTER=mongodb01:27017,mongodb02:27017,mongodb03:27017
        command: /stats.sh

networks:
    mongodb:
        external: true
```
