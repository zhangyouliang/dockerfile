FROM node:9.6.1
MAINTAINER "Xiao Mo" <root@xiaomo.red>

COPY sources.list /etc/apt/sources.list

RUN git clone https://github.com/henszey/etcd-browser.git /app
ENV DEBIAN_FRONTEND noninteractive

WORKDIR /app
EXPOSE 8000

CMD ["nodejs", "server.js"]
