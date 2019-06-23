### # gocron 定时任务

[github](https://github.com/ouqiang/gocron)


#### # 运行 gocron
> !!! 最好将配置文件进行映射到宿主机,遇到一次悲剧的情况 ----- 忘记密码了

    mkdir -p  /data/gocron/{conf/log}
    docker run -d -p 5920:5920 -v /data/gocron/conf:/app/conf -v /data/gocron/log:/app/log --name gocron ouqg/gocron

#### # 运行 gocron-node


````
pip install supervisor 
# 打开 /etc/supervisord.conf 文件里面的注释
[include]
files = /etc/supervisor.d/*.conf

mkdir -p /etc/supervisor/conf.d/

cat << EOF > /etc/supervisor/conf.d/gocronnode.conf
[program:gocronnode]
command=/usr/local/bin/gocron-node -allow-root
directory=/var
autorestart=true
user = root
stdout_events_enabled=true
stderr_events_enabled=true 
EOF

cat << EOF > /lib/systemd/system/supervisord.service
[Unit]
Description=Supervisor daemon
[Service]
Type=forking
ExecStart=/usr/local/bin/supervisord -c /etc/supervisord.conf
ExecStop=/usr/local/bin/supervisorctl shutdown
ExecReload=/usr/local/bin/supervisorctl reload
KillMode=process
Restart=on-failure
RestartSec=42s
[Install]
WantedBy=multi-user.target
EOF


# RUn
systemctl systemctl daemon-reload && \
    systemctl enable supervisord.service  && \
    systemctl start supervisord.service
````


k8s 安装
---

- k8s 启动 gocron
- supervisor 确保 gocron-node 后台运行(对应业务机器)

````
# k8s 启动 gocron
kubectl apply -f gocron-deployment.yaml
# 对应机器安装相应的 gocron-node(上文操作)
# 测试
kubectl port-forward -n prod `kubectl get pods -n prod --selector=app=gocron -o jsonpath='{.items..metadata.name}'` 5920:5920
open http://127.0.0.1:5920
````
