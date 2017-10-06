FROM golang:1.9.0

RUN apt-get update \
    && apt-get install --no-install-recommends git zip \
    && [ -d /tmp/ngrokd/ ] && rm -rf /tmp/ngrokd/ \
    && [ -d /usr/local/ngrok ] || git clone https://github.com/inconshreveable/ngrok.git /usr/local/ngrok \
    && mkdir /package

COPY run.sh /usr/local/bin/run.sh

ENV NGROK_DOMAIN **NULL**

EXPOSE 80 443 4443

VOLUME /usr/local/ngrok/package

WORKDIR /usr/local/ngrok

CMD ["run.sh"]
