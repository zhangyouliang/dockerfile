# 参数说明

eg:

```shell
docker run -d --net host --name cobbler \
-e Cobbler_SERVER_IP=10.3.236.240 \
-e Cobbler_NEXT_SERVER_IP=10.3.236.240 \
-e Cobbler_PASSWORD=root \
-e Cobbler_DHCP_SUBNET=10.3.236.0 \
-e Cobbler_DHCP_ROUTER=10.3.236.254 \
-e Cobbler_DHCP_DNS=114.114.114.114 \
-e Cobbler_DHCP_RANGE="10.3.236.200 10.3.236.210" \
-v /root/iso:/iso:ro \
cobbler:2.8
```
# 导入镜像

将镜像在宿主机mount到 `/root/ios` 目录，以CentOS为例：

```Shell
mkdir /root/iso/centos
mount /root/CentOS-7-x86_64-DVD-1611.iso /root/iso/centos
```

导入镜像

```shell
docker exec -it cobbler ls /ios
docker exec -it cobbler cobbler import --name=CentOS-7.3.1611-x86_64 --path=/iso/centos/
```
