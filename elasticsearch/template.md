
````
# 设置ip
es_ip=http://10.42.241.45:9200
````

```
GET _cat/templates 已经创建的模板

```

删除模板
```
http --json DELETE '$es_ip/_template/tmp' 'Content-Type':'application/json; charset=utf-8'
```

创建修改模板
````
curl -X PUT $es_ip/_template/tmp -d 
'{
   "template": "nginx*",
   "order": 0,
   "index_patterns": [
     "nginx*"
   ],
   "settings": {
     "refresh_interval": "30s",
     "merge.policy.max_merged_segment": "1000mb",
     "translog.durability": "async",
     "translog.flush_threshold_size": "2gb",
     "translog.sync_interval": "100s",
     "index": {
       "number_of_shards": "11",
       "number_of_replicas": "0"
     }
   },
   "mappings": {
     "dynamic_templates": [
       {
         "message_field": {
           "path_match": "message",
           "match_mapping_type": "string",
           "mapping": {
             "type": "text",
             "norms": false
           }
         }
       },
       {
         "string_fields": {
           "match": "*",
           "match_mapping_type": "string",
           "mapping": {
             "type": "text",
             "norms": false,
             "fields": {
               "keyword": {
                 "type": "keyword",
                 "ignore_above": 1024
               }
             }
           }
         }
       }
     ],
     "properties": {
       "@timestamp": {
         "type": "date"
       },
       "@version": {
         "type": "keyword"
       },
       "url_args": {
         "type": "nested",
         "properties": {
           "key": {
             "type": "keyword"
           },
           "value": {
             "type": "keyword"
           }
         }
       }
     }
   }
 }'
````


````
# 创建一个默认模板，模板名为 template_default
# 这个模板匹配所有的索引，它的order属性值为0。索引创建时将被设置一个分片，一个副本。
PUT _template/template_default
{
  "index_patterns": ["*"],
  "order" : 0,
  "version": 1,
  "settings": {
    "number_of_shards": 1,
    "number_of_replicas":1
  }
}
 
# 创建一个模板，模板名为 template_test
# 这个模板匹配test开头的索引，它的order属性值为1。索引创建时将被设置一个分片，两个副本。
# 并且，date类型自动检测功能将关闭，数字自动检测功能将开启。
PUT /_template/template_test
{
    "index_patterns" : ["test*"],
    "order" : 1,
    "settings" : {
        "number_of_shards": 1,
        "number_of_replicas" : 2
    },
    "mappings" : {
        "date_detection": false,
        "numeric_detection": true
    }
}
 
# 删除模板名为template_1的模板
DELETE /_template/template_1
 
# 获取模板名为template_1的模板
GET /_template/template_1
 
# 获取通配符模板
GET /_template/temp*
 
# 获取多个模板
GET /_template/template_1,template_2
 
# 获取所有模板
GET /_template
 
# 判断模板是否存在

````


参考
===
- [Elasticsearch7.X 入门学习第八课笔记-----索引模板和动态模板](https://www.cnblogs.com/lonelyxmas/p/11612466.html)
