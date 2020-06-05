solr
===


````
export SOLR_DATAIMPORTHANDLER_MYSQL=true
# 构建带有 mysql 驱动的镜像
docker build --build-arg SOLR_DATAIMPORTHANDLER_MYSQL=true -t solr:8.5.1 .
````