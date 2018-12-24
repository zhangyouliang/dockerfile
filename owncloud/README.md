owncloud
----
````
mkdir -p /data/owncloud/data
chmod -R 777 /data/owncloud

## setup docker container
$ docker-compose -f docker-compose.yml up -d
## stop and destory container
$ docker-compose down
## clean all
$ docker-compose down --rmi all
````

目录请一定要选择 `/var/www/html/data`

nginx 代理配置:

    upstream pan_server{
            server  127.0.0.1:4001;
    
    }
    
    server {
            listen   80;
            server_name owncloud.xxx.com;
            access_log var/log/nginx/access.log main;
            error_log /var/log/nginx/error.log;
    
            proxy_set_header X-Forwarded-For $remote_addr;
    
        location / {
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            add_header Cache-Control  "no-cache";
        
            proxy_pass http://pan_server;
            limit_rate 256m;
            client_max_body_size 0;
                
        }
    
    }
