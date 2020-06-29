- 集成 ik 分词
=======
Elasticsearch
====





Install Kibana with Docker
==
> https://www.elastic.co/guide/en/kibana/current/docker.html#docker

> 修改系统参数
```
echo 'vm.max_map_count=655360' >> /etc/sysctl.conf
sysctl -p
# 所需要的镜像版本
- elasticsearch:7.7.0
- kibana:7.6.2
```

> elasticsearch 安装
```
elasticsearch.yml 
==
cluster.name: "docker-cluster"
network.host: 0.0.0.0

#开启跨域访问
http.cors.enabled: true
http.cors.allow-origin: "*"
http.cors.allow-headers: Authorization,X-Requested-With,Content-Length,Content-Type

node.name: "node-1"
discovery.seed_hosts: ["127.0.0.1", "[::1]"]
cluster.initial_master_nodes: ["node-1"]

#xpack.security.enabled: true
#xpack.security.transport.ssl.enabled: true


# ik 插件安装
elasticsearch-plugin install https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v7.7.0/elasticsearch-analysis-ik-7.7.0.zip
# 如果下载缓慢可以先下载到本地,然后安装 elasticsearch-plugin install file:///xxxx/elasticsearch-analysis-ik-7.7.0.zip
# 查看安装列表
elasticsearch-plugin list

重启 es !!!

```

> kibana 安装
````
配置 es 地址:
环境变量 : ELASTICSEARCH_HOSTS: http://xxxx:9200
或者
./kibana.yml:/usr/share/kibana/config/kibana.yml  修改 : elasticsearch.hosts: [ "http://xxxx:9200" ]
或者
docker run --link YOUR_ELASTICSEARCH_CONTAINER_NAME_OR_ID:elasticsearch -p 5601:5601 kibana:7.6.2
````
