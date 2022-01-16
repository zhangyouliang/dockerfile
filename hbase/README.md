Hbase
===

````
docker run -d -h myhbase -p 2182:2181 -p 8080:8080 -p 8085:8085 -p 9090:9090 -p 9095:9095 -p 16000:16000 -p 16010:16010 -p 16201:16201 -p 16301:16301 --name hbase1.3 harisekhon/hbase:2.1
````

访问:  http://localhost:8085



- [github:hbase-docker](https://github.com/dajobe/hbase-docker)
- [github:go:client](https://github.com/tsuna/gohbase)