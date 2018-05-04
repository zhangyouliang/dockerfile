# Cobbler

## 参数说明

| 环境变量 | 说明 | 默认值 |
| :- | :-- | :- |
| Cobbler_SERVER_IP | Cobbler容器所在主机的IP地址 | null |
| Cobbler_PASSWORD | root密码 | root |
| Cobbler_DHCP_SUBNET | 子网地址 | null |
| Cobbler_DHCP_ROUTER | 网关地址 | null |
| Cobbler_DHCP_DNS | DNS地址 | 114.114.114.114 |
| Cobbler_DHCP_RANGE | 装机是分配的IP地址池 | null |

## 示例

```shell
docker run -d --net host --name cobbler \
-e Cobbler_SERVER_IP=10.211.55.14 \
-e Cobbler_PASSWORD=root \
-e Cobbler_DHCP_SUBNET=10.211.55.0 \
-e Cobbler_DHCP_ROUTER=10.211.55.1 \
-e Cobbler_DHCP_DNS=114.114.114.114 \
-e Cobbler_DHCP_RANGE=10.211.55.100 10.211.55.150 \
-v /root/iso:/iso:ro \
cobbler:2.8.2

docker run -d --net host --name cobbler \
-e Cobbler_SERVER_IP=10.0.0.36 \
-e Cobbler_PASSWORD=root \
-e Cobbler_DHCP_SUBNET=10.0.0.0 \
-e Cobbler_DHCP_ROUTER=10.0.0.10 \
-e Cobbler_DHCP_DNS=114.114.114.114 \
-e Cobbler_DHCP_RANGE=10.0.0.240 10.0.0.250 \
-v /root/iso:/iso:ro \
cobbler:2.8.2
```
## Cobbler Web

Cobbler Web：http://${Cobbler_SERVER_IP}/cobbler_web

登录用户：cobbler

登录密码：cobbler

# 导入镜像

1、将镜像在宿主机mount到 `/root/ios` 目录，以CentOS为例：

```Shell
mkdir /root/iso/centos
mount CentOS-7-x86_64-DVD-1511.iso /root/iso/centos
```

2、导入镜像

```shell
docker exec -it cobbler ls /iso
docker exec -it cobbler cobbler import --name=CentOS-7.3.1611-x86_64 --path=/iso/centos
docker exec -it cobbler cobbler sync
```

