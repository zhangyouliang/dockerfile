### # gocron 定时任务

[github](https://github.com/ouqiang/gocron)


#### # 运行 gocron
> !!! 最好将配置文件进行映射到宿主机,遇到一次悲剧的情况 ----- 忘记密码了
    
    docker run -d -p 5920:5920 -v /data/gocron/conf:/app/conf --name gocron ouqg/gocron

#### # 运行 gocron-node

> supervisor 运行

    pip install supervisor 
    # 打开 /etc/supervisord.conf 文件里面的注释
    [include]
    files = /etc/supervisor.d/*.conf
    
    # gocronnode.conf 内容
    vim /etc/supervisor.d/gocronnode.conf 
    [program:gocronnode]
    command=/usr/local/bin/gocron-node
    directory=/var
    autorestart=true
    user = gocronnode
    stdout_events_enabled=true
    stderr_events_enabled=true
    
    # running
    supervisorctl start all
    # status
    supervisorctl status


