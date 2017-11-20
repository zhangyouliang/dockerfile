# kolla
wget -O /usr/local/src/ubuntu-source-registry-ocata.tar.gz http://tarballs.openstack.org/kolla/images/ubuntu-source-registry-ocata.tar.gz
<!-- tar -zvxf ubuntu-source-registry-ocata.tar.gz -->
tar -zxf /usr/local/src/ubuntu-source-registry-ocata.tar.gz -C /var/lib/registry

docker run -d --name kolla \
-e DOCKER_REGISTRY=192.168.0.167 \
-e DOCKER_REGISTRY_NAME=lokolla \
-e KOLLA_HOST=192.168.0.166 \
-e KOLLA_USER=root \
-e KOLLA_PASS=root \
-e KOLLA_PORT=22 \
-e KILLA_INTERNAL_VIP_ADDRESS=192.168.0.3 \
-e NETWORK_INTERFACE=ens32 \
-e NEUTRON_EXTERNAL_INTERFACE=ens35 \
daocloud.io/buxiaomo/kolla


192.168.0.167/lokolla/ubuntu-source-aodh-api:4.0.3
