
查询API
===
- GET /_search 空搜索
- GET /broker/_search 指定索引
- GET /broker,customer/_search 指定多索引
- GET /b,c/_search 匹配索引

大纲
==

- 轻量搜索 URI Search
- 请求体搜索 Request Body Search
- 一个条件的搜索
- 合并查询语句
- 结构体搜索

轻量搜索（查询字符串） 不安全 弃用
==
- GET /broker/_search?q=name:三
- GET /broker/_search?q=interests:书+name:三
- GET /_search?size=5&from=5
    -- size 显示应该返回的结果数量，默认是 10 （所以在不指定分页数据的情况下 ，只返回10条数据）
    -- from 显示应该跳过的初始结果数量，默认是 0

> PS：都是精确分词模式，实现不了精确搜索

请求体搜索
====

基于 查询表达式(Query DSL) 进行查询

````
GET /broker/_search
{
    "query": {
        "match": {
            "name": "三"
        }
    }
}
````
echo '{"query": {"match": {"id": 1}}}' | http  http://47.98.66.134:9200/m_products2/_search


**查询表达式(Query DSL) **
===
查询语句(Query clauses) 就像一些简单的组合块 ，这些组合块可以彼此之间合并组成更复杂的查询。这些语句可以是如下形式：

- 叶子查询语句 (Leaf query clauses) (就像 match 语句) 被用于将查询字符串和一个字段（或者多个字段）对比。

叶查询子句中寻找一个特定的值在某一特定领域，如 match，term或 range查询。这些查询可以单独使用

- 复合查询语句 (Compound query clauses) 语句 主要用于 合并其它查询语句。 比如，一个 bool 语句 允许在你需要的时候组合其它语句，无论是 must 匹配、 must_not 匹配还是 should 匹配，同时它可以包含不评分的过滤器（filters）：
```
{
    "bool": {
        "must":     { "match": { "tweet": "elasticsearch" }},
        "must_not": { "match": { "name":  "mary" }},
        "should":   { "match": { "tweet": "full text" }},
        "filter":   { "range": { "age" : { "gt" : 30 }} }
    }
}
```
```
{
    "bool": {
        "must": { "match":   { "email": "business opportunity" }},
        "should": [
            { "match":       { "starred": true }},
            { "bool": {
                "must":      { "match": { "folder": "inbox" }},
                "must_not":  { "match": { "spam": true }}
            }}
        ],
        "minimum_should_match": 1
    }
}
```
- match	分词匹配
- match_all	匹配所有文档。在没有指定查询方式时，它是默认的查询
- multi_match	在多个字段上执行相同的 match 查询
- range	范围查询 （gt：大于、gte：大于等于、lt：小于、lte：小于等于）
- term	精确匹配
- missing	IS_NULL
- exists	NOT IS_NULL


组合多查询编辑
===

- bool 过滤器
- constant_score 过滤器

- must	匹配
- must_not	不 匹配
- should	满足任意一条即可
- filter	必须 匹配，不评分过滤器

结构化搜索
====
不分词的搜索，精确搜索，直接跳过了整个评分阶段

精确值搜索
```
{
    "query" : {
        "constant_score" : { 
            "filter" : {
                "term" : { 
                    "companyId" : "35f142de-2931-431d-b939-111111111111"
                }
            }
        }
    }
}
```
组合过滤器
```
{    
    "query": {****
        "bool": {
            "filter": [{
                "term": {
                    "companyId": "35f142de-2931-431d-b939-111111111111"
                }
            },
            {
                "term": {
                    "name": "三"
               }
            }]
        }
    }
}
```

参考
===
- [ElasticSearch 常用字段类型](https://www.cnblogs.com/chy18883701161/p/12723658.html)
- [Elasticsearch 学习笔记](https://www.letianbiji.com/elasticsearch/es7-search-from-size.html)