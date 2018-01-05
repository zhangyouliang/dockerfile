FROM kalilinux/kali-linux-docker

RUN echo "deb http://mirrors.tuna.tsinghua.edu.cn/kali/ kali-rolling main contrib non-free" > /etc/apt/sources.list \
    && echo "deb-src http://mirrors.tuna.tsinghua.edu.cn/kali/ kali-rolling main contrib non-free" >> /etc/apt/sources.list

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update \
    && apt-get -y --force-yes install ruby metasploit-framework
# 
