## openvpn 服务器搭建

服务器配置 centos7

```
yum install docker
docker pull kylemanna/openvpn

OVPN_DATA="/data/ovpn-data"
// 下面的全局变量替换为你的服务器的外网IP
IP="xxx.xxx.xxx.xxx"
mkdir -p ${OVPN_DATA}

// 第二步
docker run -v ${OVPN_DATA}:/etc/openvpn --rm kylemanna/openvpn ovpn_genconfig -u tcp://${IP}

// 第三步
docker run -v ${OVPN_DATA}:/etc/openvpn --rm -it kylemanna/openvpn ovpn_initpki

// ---------------------------------------------------------
Enter PEM pass phrase: 输入123456（你是看不见的）
Verifying - Enter PEM pass phrase: 输入123456（你是看不见的）
Common Name (eg: your user, host, or server name) [Easy-RSA CA]:回车一下
Enter pass phrase for /etc/openvpn/pki/private/ca.key:输入123456
// ---------------------------------------------------------

// 第五步
docker run -v ${OVPN_DATA}:/etc/openvpn --rm -it kylemanna/openvpn easyrsa build-client-full CLIENTNAME nopass

// ---------------------------------------------------------
Enter pass phrase for /etc/openvpn/pki/private/ca.key:输入123456
// ---------------------------------------------------------

// 第六步
docker run -v ${OVPN_DATA}:/etc/openvpn --rm kylemanna/openvpn ovpn_getclient CLIENTNAME > ${OVPN_DATA}/CLIENTNAME.ovpn

// 第七步
docker run --name openvpn -v ${OVPN_DATA}:/etc/openvpn -d -p 1194:1194 --privileged kylemanna/openvpn

```

经过以上七个步骤，你将会在/data/ovpn-data中看到一个CLIENTNAME.ovpn文件，将其下载到本地，利用OpenVPN GUI连接，即可。

经过整理后即：

```
yum install docker
docker pull kylemanna/openvpn
OVPN_DATA="/data/ovpn-data"
IP="123.123.123.123"
mkdir ${OVPN_DATA}
docker run -v ${OVPN_DATA}:/etc/openvpn --rm kylemanna/openvpn ovpn_genconfig -u tcp://${IP}
docker run -v ${OVPN_DATA}:/etc/openvpn --rm -it kylemanna/openvpn ovpn_initpki
docker run -v ${OVPN_DATA}:/etc/openvpn --rm -it kylemanna/openvpn easyrsa build-client-full CLIENTNAME nopass
docker run -v ${OVPN_DATA}:/etc/openvpn --rm kylemanna/openvpn ovpn_getclient CLIENTNAME > ${OVPN_DATA}/CLIENTNAME.ovpn
docker run --name openvpn -v ${OVPN_DATA}:/etc/openvpn -d -p 1194:1194 --privileged kylemanna/openvpn
```

## OPENVPN连接

mac 版本下载
[Tunnelblick](https://tunnelblick.en.softonic.com/mac)

将 *.ovpn 添加到配置,连接即可
