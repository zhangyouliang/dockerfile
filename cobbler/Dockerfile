FROM centos:7.2.1511

RUN yum install yum-utils -y \
    && yum-config-manager --add-repo http://mirrors.aliyun.com/repo/epel-7.repo \
    && yum makecache \
    && yum install cobbler vim net-tools -y

COPY tftp /etc/xinetd.d/tftp
