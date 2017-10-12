FROM golang:1.9.0

RUN apt-get update \
    && apt-get install --no-install-recommends git zip -y \
    && [ -d /usr/local/ngrok ] || git clone https://github.com/inconshreveable/ngrok.git /usr/local/ngrok \
    && mkdir /package \
    && rm -rf /usr/local/ngrok/assets/client/tls/*

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ENV NGROK_DOMAIN **NULL**

EXPOSE 80 443 4443

VOLUME ['/usr/local/ngrok/package','/usr/local/ngrok/assets/client/tls/']

WORKDIR /usr/local/ngrok

CMD ["docker-entrypoint.sh"]
