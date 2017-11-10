```
docker run -d --name ssserver \
-p 443:8388 \
-e PASSWORD=xiaomo \
--restart unless-stopped daocloud.io/buxiaomo/ssserver:latest
```
```
version: "3"
services:
    ss:
        image: daocloud.io/buxiaomo/ssserver:2.8.2
        hostname: zhangyang
        ports:
            - 8388:8388/tcp
        environment:
            - PASSWORD=123456
        deploy:
            mode: global
            restart_policy:
                condition: on-failure
                delay: 10s
                max_attempts: 3
                window: 120s
            placement:
                constraints: [node.role == worker]
        logging:
            driver: splunk
            options:
                splunk-url: "http://xxx.xxx.xxx.xxx:8088"
                splunk-token: "185e6f9d-c393-4892-a6d1-80da077acfd1"
                tag: "{{.Name}}/{{.FullID}}"
```
