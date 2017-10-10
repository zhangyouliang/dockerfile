#!/bin/bash
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
if [ ! -e /usr/local/ngrok/package/install.lock ];then
    StandardOutput "==> Production certificate"
    mkdir openssl && cd openssl
    openssl genrsa -out rootCA.key 2048 &> /dev/null
    openssl req -x509 -new -nodes -key rootCA.key -subj "/CN=$NGROK_DOMAIN" -days 5000 -out rootCA.pem &> /dev/null
    openssl genrsa -out device.key 2048 &> /dev/null
    openssl req -new -key device.key -subj "/CN=$NGROK_DOMAIN" -out device.csr &> /dev/null
    openssl x509 -req -in device.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out device.crt -days 5000 &> /dev/null
    cp -f rootCA.pem ../assets/client/tls/ngrokroot.crt
    cp -f device.crt ../assets/server/tls/snakeoil.crt
    cp -f device.key ../assets/server/tls/snakeoil.key
    cd ..
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
    mkdir -p package/{linux64,linux32,win64,win32,arm,mac64,mac32}

    cp -p {start.bat,ngrok.cfg,bin/windows_amd64/ngrok.exe} package/win64/
    cp -p {start.bat,ngrok.cfg,bin/windows_386/ngrok.exe} package/win32/

    cp -p {start.bat,ngrok.cfg,bin/linux_arm/ngrok} package/arm/

    cp -p {start.sh,ngrok.cfg,bin/darwin_amd64/ngrok}   package/mac64/
    cp -p {start.sh,ngrok.cfg,bin/darwin_386/ngrok}   package/mac32/

    cp {start.sh,ngrok.cfg,bin/ngrok}   package/linux64/
    cp {start.sh,ngrok.cfg,bin/linux_386/ngrok}   package/linux32/

    cd package
    rm -rf *.zip
    for p in `ls`
    do
    	mv ${p} ngrok
    	zip ${p}.zip ngrok/* &> /dev/null
    	rm -rf ngrok
    done
    touch /usr/local/ngrok/package/install.lock
fi

StandardOutput "==> Running ..."
StandardOutput "----------------------------------------"
StandardOutput "you can run command to see package dir"
StandardOutput "  docker inspect $HOSTNAME | jq '.[0].Mounts[0].Source'"
StandardOutput "----------------------------------------"
exec /usr/local/ngrok/bin/ngrokd -domain="$NGROK_DOMAIN" -tlsKey=/usr/local/ngrok/assets/server/tls/snakeoil.key -tlsCrt=/usr/local/ngrok/assets/server/tls/snakeoil.crt
