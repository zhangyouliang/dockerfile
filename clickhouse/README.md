

````bash
# 测试方式
docker run -d --name ch-server --ulimit nofile=262144:262144 -p 8123:8123 -p 9000:9000 -p 9009:9009 yandex/clickhouse-server:21.9.4

# 正式方式创建
# 创建相关文件夹
mkdir -p  ~/data/clickhouse/{conf,data,log}
# 复制配置文件到本地
docker run -d --rm --name=tmp_ch yandex/clickhouse-server:21.9.4 sleep 100
docker cp tmp_ch:/etc/clickhouse-server/users.xml ~/data/clickhouse/conf/users.xml
docker cp tmp_ch:/etc/clickhouse-server/config.xml ~/data/clickhouse/conf/config.xml  

````

修改连接用户名、密码（users.xml）

如果使用 password_sha256_hex 的话,如果使用明文,直接替换 password 即可


1.执行命令，生成SHA256密码
````
PASSWORD=$(base64 < /dev/urandom | head -c8); echo "$PASSWORD"; echo -n "$PASSWORD" | sha256sum | tr -d '-'
````
2.返回结果
````
#密码明文
pC7ifHEP  
#密文
b5219ae190d15160affc91a0eaf88ba6b662576ff543a624d5d8e514c1560864 
````

3.修改users.xml配置文件


运行
````
docker run -d --name clickhouse-server \
-p 8123:8123 \
-p 9009:9009 \
-p 9090:9000 \
--ulimit nofile=262144:262144 \
--volume=/Users/youliangzhang/data/clickhouse/data:/var/lib/clickhouse \
--volume=/Users/youliangzhang/data/clickhouse/log:/var/log/clickhouse-server \
--volume=/Users/youliangzhang/data/clickhouse/conf/config.xml:/etc/clickhouse-server/config.xml \
--volume=/Users/youliangzhang/data/clickhouse/conf/users.xml:/etc/clickhouse-server/users.xml yandex/clickhouse-server:21.9.4

````