rancher-vpn-server
====

```
- 镜像: nixel/rancher-vpn-server:latest
- 开启 1194/tcp and 2222/tcp 端口
- 安装 sshpass
- volumns: /root/nas/vpn/openvpn:/etc/openvpn
- 勾选: 主机完全访问权限
- 注入使用了类似阿里云 VPN,进出网络IP不一致时需要修改IP

例如: 我的进IP:10.0.0.1,出 10.0.0.2

sshpass -p 8Z1fBJOPcTvhs3Zlx2se ssh -p 2222 -o ConnectTimeout=4 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@10.0.0.2 "get_vpn_client_conf.sh 10.0.0.2:1194" > RancherVPNClient.ovpn
将 IP 修改为入的 ip 即可
```

## OPENVPN连接

mac 版本下载
[Tunnelblick](https://tunnelblick.en.softonic.com/mac)

将 *.ovpn 添加到配置,连接即可


## 参考

- [rancher 官方](http://rancher.com/building-a-continuous-integration-environment-using-docker-jenkins-and-openvpn/)