# moscrack
构建镜像前请生成密钥对
	ssh-keygen -b 2048 -t rsa -f /root/id_rsa -q -N ""
	

将id_rsa和id_rsa.pub拷贝到moscrack-master目录

将id_rsa.pub拷贝到moscrack-slave目录，并重命名为authorized_keys

使用：

先启动节点容器，在使用master

开始爆破：

docker run -it --rm --network=moscrack --name moscrack-master \

-v /words:/words -v /cap:/cap \

moscrack:master -e test -w /words/tune.words -c /cap/tune.cap

启用节点：
docker run -d --network=moscrack --name moscrack-slave01 moscrack:slave

docker run -d --network=moscrack --name moscrack-slave02 moscrack:slave

docker run -d --network=moscrack --name moscrack-slave03 moscrack:slave

docker run -d --network=moscrack --name moscrack-slave04 moscrack:slave

docker run -d --network=moscrack --name moscrack-slave05 moscrack:slave
