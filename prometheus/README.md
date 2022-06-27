
## # Docker 部署 Prometheus 说明：
--

监控端安装：
- Prometheus Server(普罗米修斯监控主服务器 )
- Node Exporter (收集Host硬件和操作系统信息)
- cAdvisor (负责收集Host上运行的容器信息)
- Grafana (展示普罗米修斯监控界面）

被监控安装：
- Node Exporter (收集Host硬件和操作系统信息)
- cAdvisor (负责收集Host上运行的容器信息)

## # 安装 node_exporter
--- 
> 所有服务器安装
> Node Exporter 收集系统信息，用于监控CPU、内存、磁盘使用率、磁盘读写等系统信息
> –net=host，这样 Prometheus Server 可以直接与 Node Exporter 通信

docker 安装
    
````bash
docker run -d --restart=always -p 9100:9100 \
    -v "/proc:/host/proc:ro" \
    -v "/sys:/host/sys:ro" \
    -v "/:/rootfs:ro" \
    -v "/etc/localtime:/etc/localtime:ro" \
    --net="host" \
    prom/node-exporter \
    --path.procfs /host/proc \
    --path.sysfs /host/sys \
    --collector.filesystem.ignored-mount-points "^/(sys|proc|dev|host|etc)($|/)"
````

测试: `curl http://localhost:9100/metrics`

## # 安装 cAdvisor
> 所有服务器安装
> cAdvisor 收集docker信息，用于展示docker的cpu、内存、上传下载等信息
> –net=host，这样 Prometheus Server 可以直接与 cAdvisor 通信

````bash
docker run -d \
    -v "/etc/localtime:/etc/localtime:ro" \
    --v="/:/rootfs:ro" \
    --v="/var/run:/var/run:rw" \
    --v="/sys:/sys:ro" \
    --v="/var/lib/docker/:/var/lib/docker:ro" \
    --v="/dev/disk/:/dev/disk:ro" \
    --net="host" \
    --publish=18104:8080 \
    --detach=true \
    --name=cadvisor \
    --privileged=true \
    google/cadvisor:latest

````



## # 安装 prometheus
> 主监控主机安装  prometheus

````bash
docker run -d --restart=always -p 9090:9090 \
    -v "/root/nas/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml" \
    -v "/etc/localtime:/etc/localtime:ro" \
    --name prometheus \
    prom/prometheus
````



## # 安装 grafana

````bash
docker run -d --restart=always --name=grafana -p 3000:3000 \
    -v /root/nas/grafana-data:/var/lib/grafana \
    -e "GF_SECURITY_ADMIN_PASSWORD=admin" \
    grafana/grafana
````

### # 基本使用

    node exporter
    入口流量
    
    sum by (ip) (rate(node_network_receive_bytes_total{name = 'node_bj_xxx', device != "lo"}[5m]))
    出口流量
    
    sum by (ip) (rate(node_network_transmit_bytes_total{name = 'node_bj_xxx', device != "lo"}[5m]))
    wmi exporter
    入口流量
    
    sum by (ip) (rate(wmi_net_bytes_received_total{name="node_hf_xxx"}[30m]))
    出口流量
    
    sum by (ip) (rate(wmi_net_bytes_sent_total{name="node_hf_xxx"}[30m]))
    内存&磁盘&CPU等
    
    node exporter
    启动时间
    
    node_boot_time_seconds{ip="xxx.xx.xxx.xx"}*1000
    内存大小
    
    node_memory_MemTotal_bytes{ip="xxx.xx.xxx.xx"}
    CPU核数
    
    count (sum by (cpu) (node_cpu_seconds_total{ip="xxx.xx.xxx.xx"}))
    平均负载
    
    node_load1{ip="xxx.xx.xxx.xx"}
    node_load5{ip="xxx.xx.xxx.xx"}
    node_load15{ip="xxx.xx.xxx.xx"}
    free内存
    
    node_memory_MemFree_bytes{ip="xxx.xx.xxx.xx"}
    可用内存
    
    node_memory_MemFree_bytes{ip="xxx.xx.xxx.xx"}+node_memory_Cached_bytes{ip="xxx.xx.xxx.xx"}+node_memory_Buffers_bytes{ip="xxx.xx.xxx.xx"}
    内存使用率
    
    100 - ((node_memory_MemFree_bytes{ip="xxx.xx.xxx.xx"}+node_memory_Cached_bytes{ip="xxx.xx.xxx.xx"}+node_memory_Buffers_bytes{ip="xxx.xx.xxx.xx"})/node_memory_MemTotal_bytes{ip="xxx.xx.xxx.xx"}) * 100
    磁盘使用率
    
    100 - node_filesystem_free_bytes{ip="xxx.xx.xxx.xx",fstype!~"rootfs|selinuxfs|autofs|rpc_pipefs|tmpfs|udev|none|devpts|sysfs|debugfs|fuse.*"} / node_filesystem_size_bytes{ip="xxx.xx.xxx.xx",fstype!~"rootfs|selinuxfs|autofs|rpc_pipefs|tmpfs|udev|none|devpts|sysfs|debugfs|fuse.*"} * 100
    CPU使用率
    
    avg  by (ip)(irate(node_cpu_seconds_total{ip="xxx.xx.xxx.xx", mode != "idle"}[2m])) * 100
    磁盘写IO
    
    sum by (ip) (rate(node_disk_written_bytes_total{ip="xxx.xx.xxx.xx"}[30m]))
    磁盘读IO
    
    sum by (ip) (rate(node_disk_read_bytes_total{ip="xxx.xx.xxx.xx"}[30m]))
    wmi exporter
    启动时间
    
    wmi_system_system_up_time {name='node_hf_xxx'} * 1000
    C盘大小
    
    wmi_logical_disk_size_bytes{name='node_hf_xxx',volume="C:"}
    C盘使用率
    
    (wmi_logical_disk_size_bytes{name='node_hf_xxx',volume='C:'}-wmi_logical_disk_free_bytes{name='node_hf_xxx',volume='C:'})/wmi_logical_disk_size_bytes{name='node_hf_xxx',volume='C:'} 
    内存大小
    
    wmi_cs_physical_memory_bytes{name='node_hf_xxx'} 
    可用内存
    
    wmi_os_physical_memory_free_bytes{name="node_hf_xxx"} 
    内存使用率
    
    1 - (wmi_os_physical_memory_free_bytes{name="node_hf_xxx"} /wmi_os_visible_memory_bytes{name="node_hf_xxx"})
    CPU核数
    
    wmi_cs_logical_processors{name='node_hf_xxx'}
    CPU使用率
    
    100-(avg by (ip) (irate(wmi_cpu_time_total{ip="xxx.xx.xxx.xx",mode="idle"}[30s]))*100)
    磁盘写IO
    
    sum by (ip)(rate(wmi_logical_disk_write_bytes_total{ip="xxx.xx.xxx.xx"}[30m]) )
    磁盘读IO
    
    sum by (ip) (rate(wmi_logical_disk_read_bytes_total{ip="xxx.xx.xxx.xx"}[30m]) )