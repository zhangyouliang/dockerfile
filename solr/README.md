solr
===


````
export SOLR_DATAIMPORTHANDLER_MYSQL=true
# 构建带有 mysql 驱动的镜像
docker build --build-arg SOLR_DATAIMPORTHANDLER_MYSQL=true -t solr:8.5.1 .
````



时间过程
===
> laravel + docker solr-8.5.1 

 
/data/solr:/var/solr

```
# 启动并且映射文件到宿主机,防止数据丢失
mkdir -p /data/solr && chmod 777 /data/solr
docker run --name solr -v /data/solr:/var/solr -d -p 8983:8983 -t solr:latest
# 创建   mycore
docker exec -it  --user=solr solr bin/solr create_core -c mycore

curl -L -o /tmp/mysql_connector.tar.gz "https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.45.tar.gz"
tar -zxvf /tmp/mysql_connector.tar.gz -C . "mysql-connector-java-5.1.45/mysql-connector-java-5.1.45-bin.jar" --strip-components 1
rm -rf /tmp/mysql_connector.tar.gz

容器内: 

复制文件到: /var/solr/contrib/dataimporthandler/lib/mysql-connector-java-5.1.45-bin.jar


```

/var/solr/data/mycore/conf/solrconfig.xml

````
<!-- solr 自带分词 -->
<lib dir="${solr.install.dir:../../../..}/contrib/analysis-extras/lucene-libs" regex="lucene-analyzers-smartcn-8.5.1.jar" />
<!-- solr 数据导入 -->
<lib dir="${solr.install.dir:../../../..}/dist/" regex="solr-dataimporthandler-.*\.jar" />
<lib dir="${solr.install.dir:../../../..}/contrib/dataimporthandler/lib/" regex="mysql-connector-java-.*\.jar" />
<!--   <lib dir="${solr.install.dir:../../../..}/dist/" regex="mysql-connector-java-.*\.jar" />-->
````

```
<field name="id" type="string" indexed="true" stored="true" required="true" multiValued="false" />
<!-- 添加自己的字段(下面是我自己的,请换成对应数据库的...) -->
<field name="sort" type="string" indexed="true" stored="true"/>
<field name="name" type="text_cn" indexed="true" stored="true"/> 
<field name="content" type="string" indexed="true" stored="true"/>
<field name="pic" type="string" indexed="true" stored="true"/>
<field name="tag" type="string" indexed="true" stored="true"/>
<field name="material" type="string" indexed="true" stored="true"/>
<field name="process" type="string" indexed="true" stored="true"/>

<!-- chinese participle smartcn -->
<fieldType name="text_cn" class="solr.TextField" positionIncrementGap="100">
   <analyzer type="index">
       <tokenizer class="org.apache.lucene.analysis.cn.smart.HMMChineseTokenizerFactory"/>
   </analyzer>
    <analyzer type="query">
       <tokenizer class="org.apache.lucene.analysis.cn.smart.HMMChineseTokenizerFactory"/>
    </analyzer>
</fieldType>

<!--  注意: field 的 type="text_cn" 需要与 fieldType 一样  -->



文档最后添加:

<requestHandler name="/dataimport" class="org.apache.solr.handler.dataimport.DataImportHandler">
    <lst name="defaults">
        <str name="config">data-config.xml</str>
    </lst>

</requestHandler>

```
新建文件: /var/solr/data/mycore/conf/data-config.xml

```
<?xml version="1.0" encoding="UTF-8" ?>

<dataConfig>
    <dataSource convertType="true" type="JdbcDataSource" driver="com.mysql.jdbc.Driver"
                url="jdbc:mysql://<host>:3306/<db name>"
                user="username"
                password="password"/>
    <document>
        <entity name="m_products2" query="SELECT * FROM m_products2 ">
            <field column="id" name="id"/>
            <field column="mid" name="mid"/>
            <field column="sort" name="sort"/>
            <field column="source" name="source"/>
            <field column="name" name="name"/>
            <field column="cookingtime" name="cookingtime"/>
            <field column="content" name="content"/>
            <field column="pic" name="pic"/>
            <field column="tag" name="tag"/>
            <field column="material" name="material"/>
            <field column="process" name="process"/>
            <field column="historyCount" name="historyCount"/>
            <field column="collNu" name="collNu"/>
        </entity>
    </document>
</dataConfig>
```







重启 solr 



laravel 配置
=====

```
# 安装 solr 第三方包
composer require solarium/solarium -vvv

# config/database.php 添加如下代码
'solr' => [
        'endpoint' => [
            'localhost' => [
                'host' => 'xxxx',
                'port' => 8983,
                'core' => "mycore",
                'path' => '/',
                'wt' => 'json',
            ],
        ],
    ],
```

php 安装 solr 拓展(b)
===

```
pecl install solr 

> solr: `/private/tmp/pear/temp/solr/configure --with-php-config=/usr/local/opt/php@7.3/bin/php-config --enable-solr-debug=no --with-curl=/usr/local --with-libxml-dir=/usr/local' failed

libcurl 报错:  指定 curl 安装路径: /usr/local/opt/curl (注: 这是 mac curl 的安装路径 !!!) 即可解决
```

ik 分词添加
====
下载地址：https://search.maven.org/search?q=com.github.magese

GitHub地址：https://github.com/magese/ik-analyzer-solr

```
# 添加 jar 包
curl -L -o /opt/solr/server/solr-webapp/webapp/WEB-INF/lib/ik-analyzer-8.3.0.jar "https://search.maven.org/remotecontent?filepath=com/github/magese/ik-analyzer/8.3.0/ik-analyzer-8.3.0.jar"
# 从 Github 仓库中(src/mian/resources)

# 复制配置文件
cp  ext.dic IKAnalyzer.cfg.xml stopword.dic /opt/solr/server/solr-webapp/webapp/WEB-INF
```
managed-schema

```
<!-- ik分词器 -->
<fieldType name="text_ik" class="solr.TextField">
    <analyzer type="index">
        <tokenizer class="org.wltea.analyzer.lucene.IKTokenizerFactory" useSmart="true" conf="ik.conf"/>
        <filter class="solr.LowerCaseFilterFactory"/>
    </analyzer>
    <analyzer type="query">
        <tokenizer class="org.wltea.analyzer.lucene.IKTokenizerFactory" useSmart="true" conf="ik.conf"/>
        <filter class="solr.LowerCaseFilterFactory"/>
    </analyzer>
</fieldType>
```



文档参考
===

* [Solr的data-config.xml导入数据库记录](https://blog.csdn.net/qq_41674409/article/details/85143606)
* [Solr 入门使用](https://learnku.com/articles/6188/introduction-to-solr-usage)
* [Solr 导入同步数据库数据与查询](https://learnku.com/articles/6206/solr-imports-data-synchronize-database-data-and-queries)
* [solr 全文检索引擎安装及使用(docker版)](https://juejin.im/post/5d36b5cee51d45775c73ddb7)
