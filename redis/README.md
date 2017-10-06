# redis

# docker-compose.yml
```
version: '2'
services:
    redis_master01:
        image: daocloud.io/buxiaomo/redis
        networks:
            redis:
                aliases:
                    - redis_master01

    redis_slave01:
        image: daocloud.io/buxiaomo/redis
        networks:
            redis:
                aliases:
                    - redis_slave01
        command: redis-server --slaveof redis_master01 6379

    redis_sentinel01:
        image: daocloud.io/buxiaomo/redis
        ports:
            - 8009:26379/tcp
        environment:
            - MASTER_HOSTNAME=redis_master01
        networks:
            redis:
                aliases:
                    - redis_sentinel
        command: sentinel.sh

networks:
    redis:
        external: true
```
