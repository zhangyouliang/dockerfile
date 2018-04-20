FROM debian:jessie
MAINTAINER "Xiao Mo" <root@xiaomo.red>

# 构建软件运行环境
RUN apt-get update \
	&& apt-get install --no-install-recommends make wget tcpdump aircrack-ng perl openssh-server openssh-client libnet-ssh2-perl libmath-random-perl libjson-perl libtest-http-server-simple-perl libdatetime-format-duration-perl libconfig-std-perl libhttp-request-params-perl libstruct-compare-perl libgetopt-lucid-perl libmath-round-perl libswitch-perl libterm-readkey-perl libcgi-pm-perl -y \
	&& wget -O /usr/local/src/Acme-Tools-0.172.tar.gz http://www.cpan.org/authors/id/K/KJ/KJETIL/Acme-Tools-0.172.tar.gz \
	&& tar -zvxf /usr/local/src/Acme-Tools-0.172.tar.gz -C /usr/local/src/ \
	&& cd /usr/local/src/Acme-Tools-0.172 \
	&& perl Makefile.PL \
	&& make && make install \
	&& apt-get remove make wget -y \
	&& apt-get autoremove -y \
	&& apt-get clean all \
	&& rm -rf /usr/local/src/* /var/lib/apt/lists/*

# 安装软件
RUN apt-get update \
	&& apt-get install --no-install-recommends subversion -y \
	&& svn checkout svn://svn.code.sf.net/p/moscrack/code/trunk /usr/local/src/moscrack \
	&& cd /usr/local/src/moscrack/ \
	&& mkdir -p /opt/moscrack/cap /opt/moscrack/words /etc/moscrack/plugins \
	&& cp moscrack mosctop daemon/moscd daemon/moscc moscapid /usr/local/bin/ \
	&& cp -v plugins/* /etc/moscrack/plugins/ \
	&& cp moscrack.conf /etc/moscrack/ \
	&& cp -av tuning /opt/moscrack/ \
	&& apt-get remove subversion -y \
	&& apt-get autoremove -y \
	&& apt-get clean all \
	&& rm -rf /usr/local/src/* /var/lib/apt/lists/* \
	&& sed -i "s#/home/moscrack/#/root/#g" /etc/moscrack/moscrack.conf \
	&& sed -i "s#user = moscrack#user = root#g" /etc/moscrack/moscrack.conf \
	&& mkdir /root/.ssh/ \
	&& echo "StrictHostKeyChecking no" > /root/.ssh/config \
	&& echo "UserKnownHostsFile /dev/null" >> /root/.ssh/config

COPY nodes.dat /opt/moscrack/nodes.dat
COPY id_rsa /root/.ssh/id_rsa
COPY id_rsa.pub /root/.ssh/id_rsa.pub

RUN chmod 644 /root/.ssh/config \
	&& chmod 600 /root/.ssh/id_rsa \
	&& mkdir /words /cap \

EXPOSE 8080

VOLUME ["/words","/cap"]


ENTRYPOINT ["moscrack"]
CMD ["--help"]
