FROM golang:1.9.1

COPY sources.list /etc/apt/sources.list

ENV REPO https://github.com/prikevs/ngrok.git
ENV NGROK_HOME /usr/local/ngrok
ENV NGROK_CONFIG /etc/ngrok
RUN apt-get update \
    && apt-get install --no-install-recommends git zip -y \
    && git clone ${REPO} ${NGROK_HOME} \
    && rm -rf /usr/local/ngrok/assets/client/tls/* \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ENV NGROK_DOMAIN **NULL**
ENV NGROK_USER admin
ENV NGROK_PAAS admin

EXPOSE 80 443 4443

VOLUME ["/etc/ngrok"]

WORKDIR ${NGROK_HOME}

CMD ["docker-entrypoint.sh"]
