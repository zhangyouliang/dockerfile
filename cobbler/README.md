docker run -d --net host --name cobbler \
-e Cobbler_SERVER_IP=192.168.0.197 \
-e Cobbler_NEXT_SERVER_IP=192.168.0.197 \
-e Cobbler_PASSWORD=root \
-e Cobbler_DHCP_SUBNET=192.168.0.0 \
-e Cobbler_DHCP_ROUTER=192.168.0.1 \
-e Cobbler_DHCP_DNS=192.168.0.1 \
-e Cobbler_DHCP_RANGE="192.168.0.100 192.168.0.200" \
-v /root/iso/centos:/iso:ro \
cobbler:2.8
