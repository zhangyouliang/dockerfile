FROM debian:jessie
MAINTAINER "Mo" <root@ywclub.org>

# 构建软件运行环境
RUN apt-get update \
	&& apt-get install --no-install-recommends aircrack-ng openssh-server -y \
	&& sed -i "s/PermitRootLogin without-password/PermitRootLogin yes/g" /etc/ssh/sshd_config \
	&& sed -i "s/#PasswordAuthentication.yes/PasswordAuthentication yes/g" /etc/ssh/sshd_config \
	&& mkdir /var/run/sshd \
	&& apt-get clean all \
	&& rm -rf /var/lib/apt/lists/*
	
COPY authorized_keys /root/.ssh/authorized_keys

RUN chmod 600 /root/.ssh/authorized_keys

CMD ["/usr/sbin/sshd","-D"]
