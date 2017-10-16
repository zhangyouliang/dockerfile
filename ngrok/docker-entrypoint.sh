#!/bin/sh
function StandardOutput {
    echo -e "\033[32m$1\033[0m"
}
function ErrorOutput {
    echo -e "\033[31m$1!!!\033[0m"
}
if [ ${NGROK_DOMAIN} == "**NULL**" ];then
    ErrorOutput "Please set the NGROK_DOMAIN environment variable !"
    exit 1
fi
if [ ! -e ${NGROK_CONFIG}/install.lock ];then
    StandardOutput "==> Production certificate"
    rm -rf /etc/ngrok/*
    mkdir -p /etc/ngrok/package/linux64 \
        /etc/ngrok/package/linux32 \
        /etc/ngrok/package/win64 \
        /etc/ngrok/package/win32 \
        /etc/ngrok/package/arm \
        /etc/ngrok/package/mac64 \
        /etc/ngrok/package/mac32 \
        ${NGROK_CONFIG}/tls \
    cd ${NGROK_CONFIG}/tls
    openssl genrsa -out rootCA.key 2048 &> /dev/null
    openssl req -x509 -new -nodes -key rootCA.key -subj "/CN=$NGROK_DOMAIN" -days 5000 -out rootCA.pem &> /dev/null
    openssl genrsa -out device.key 2048 &> /dev/null
    openssl req -new -key device.key -subj "/CN=$NGROK_DOMAIN" -out device.csr &> /dev/null
    openssl x509 -req -in device.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out device.crt -days 5000 &> /dev/null
    cp -f rootCA.pem ${NGROK_HOME}/assets/client/tls/ngrokroot.crt
    mv rootCA.pem ngrokroot.crt
    cp -f device.crt ${NGROK_HOME}/assets/server/tls/snakeoil.crt
    mv device.crt snakeoil.crt
    cp -f device.key ${NGROK_HOME}/assets/server/tls/snakeoil.key
    mv device.key snakeoil.key
    cd ${NGROK_HOME}
    StandardOutput "==> Compile Ngrok Server..."
    GOOS=linux GOARCH=amd64 make release-server &> /dev/null
    StandardOutput "==> Compile Ngrok Client For Linux ..."
    GOOS=linux GOARCH=amd64 make release-client &> /dev/null
    GOOS=linux GOARCH=386 make release-client &> /dev/null
    GOOS=linux GOARCH=arm make release-client &> /dev/null
    StandardOutput "==> Compile Ngrok Client For Windows ..."
    GOOS=windows GOARCH=amd64 make release-client &> /dev/null
    GOOS=windows GOARCH=386 make release-client &> /dev/null
    StandardOutput "==> Compile Ngrok Client For Mac ..."
    GOOS=darwin GOARCH=386 make release-client &> /dev/null
    GOOS=darwin GOARCH=amd64 make release-client &> /dev/null

    cat > ngrok.cfg << EOF
server_addr: "$NGROK_DOMAIN:4443"
trust_host_root_certs: false

tunnels:
  ssh:
     remote_port: 22
     proto:
       tcp: "127.0.0.1:22"
  mstsc:
      remote_port: 3389
      proto:
       tcp: "127.0.0.1:3389"
  web:
   subdomain: "www"
   proto:
     http: 80
  domain:
   hostname: "www.example.com"
   proto:
     http: 80
EOF
    cat > start.bat << EOF
@echo off
ipconfig /flushdns
ngrok.exe -config ngrok.cfg start ssh mstsc web
pause
EOF
    cat > start.sh << EOF
./ngrok -config \$1 start `echo \$2 | sed 's/,/ /g'`
EOF
    chmod +x start.sh

    StandardOutput "==> Package required files"
    # mkdir package/linux64 package/linux32 package/win64 package/win32 package/arm package/mac64 package/mac32

    cp -p ./start.bat ./ngrok.cfg bin/windows_amd64/ngrok.exe ${NGROK_CONFIG}/package/win64/
    cp -p ./start.bat ./ngrok.cfg bin/windows_386/ngrok.exe ${NGROK_CONFIG}/package/win32/

    cp -p ./start.bat ./ngrok.cfg bin/linux_arm/ngrok ${NGROK_CONFIG}/package/arm/

    cp -p ./start.sh ./ngrok.cfg bin/darwin_amd64/ngrok   ${NGROK_CONFIG}/package/mac64/
    cp -p ./start.sh ./ngrok.cfg bin/darwin_386/ngrok   ${NGROK_CONFIG}/package/mac32/

    cp ./start.sh ./ngrok.cfg bin/ngrok ${NGROK_CONFIG}/package/linux64/
    cp ./start.sh ./ngrok.cfg bin/linux_386/ngrok   ${NGROK_CONFIG}/package/linux32/

    cd ${NGROK_CONFIG}/package
    rm -rf *.zip
    for p in `ls`
    do
    	mv ${p} ngrok
    	zip ${p}.zip ngrok/* &> /dev/null
    	rm -rf ngrok
    done
    mv ${NGROK_HOME}/bin/ngrokd /etc/ngrok/ngrokd
    [ $? == 0 ] && touch ${NGROK_CONFIG}/install.lock || exit 1
fi

StandardOutput "==> Running ..."
StandardOutput "----------------------------------------"
StandardOutput "you can run command to see package dir"
StandardOutput "  docker inspect $HOSTNAME | jq '.[0].Mounts[0].Source'"
StandardOutput "----------------------------------------"
exec /etc/ngrok/ngrokd -domain="$NGROK_DOMAIN" -tlsKey=${NGROK_CONFIG}/tls/snakeoil.key -tlsCrt=${NGROK_CONFIG}/tls/snakeoil.crt
