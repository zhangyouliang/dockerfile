FROM armhf/debian:jessie

# less priviledge user, the id should map the user the downloaded files belongs to
# RUN groupadd -r aria && useradd -m -r -g aria aria -u 1000

# COPY sources.list /etc/apt/sources.list

# webui + aria2
RUN apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 9165938D90FDDD2E \
    && apt-get update \
    && apt-get install --no-install-recommends curl git make g++ libssl-dev nettle-dev libgmp-dev libssh2-1-dev libc-ares-dev libxml2-dev zlib1g-dev libsqlite3-dev pkg-config libxml2-dev libcppunit-dev autoconf automake autotools-dev autopoint libtool -y \
    && ARIA2_VERSION="1.32.0" \
    && mkdir aria_build && cd aria_build \
    && curl -s -L -k https://github.com/aria2/aria2/releases/download/release-"$ARIA2_VERSION"/aria2-"$ARIA2_VERSION".tar.gz > aria2.tar.gz \
    && tar -xzf aria2.tar.gz \
    && cd aria2-$ARIA2_VERSION \
    && autoreconf -i && ./configure --prefix=/usr/local/aria2 && make install \
    && rm -rf aria_build \
    && apt-get remove --purge --auto-remove make g++ libssl-dev nettle-dev libgmp-dev libssh2-1-dev libc-ares-dev libxml2-dev zlib1g-dev libsqlite3-dev pkg-config libxml2-dev libcppunit-dev autoconf automake autotools-dev autopoint libtool -y \
    && apt-get install -y libxml2 libsqlite3-0 libc-ares2 zlib1g \
    && rm -rf /var/lib/apt/lists/*

        # && apt-get install -y busybox curl git \
        make g++ libssl-dev nettle-dev libgmp-dev libssh2-1-dev libc-ares-dev libxml2-dev zlib1g-dev libsqlite3-dev pkg-config libxml2-dev libcppunit-dev autoconf automake autotools-dev autopoint libtool \


        && mv src/aria2c /usr/bin/ \
        && cd ../.. \
        &&
        &&


ADD . /webui-aria2

# gosu install latest
RUN GITHUB_REPO="https://github.com/tianon/gosu" \
  && LATEST=`curl -s  $GITHUB_REPO"/releases/latest" | grep -Eo "[0-9].[0-9]*"` \
  && curl -L $GITHUB_REPO"/releases/download/"$LATEST"/gosu-armhf" > /usr/local/bin/gosu \
  && chmod +x /usr/local/bin/gosu

# goland install (compile source code for ARM since no version are currently available)
RUN curl -L "https://storage.googleapis.com/golang/go1.9.1.linux-armv6l.tar.gz" > go.tar.gz \
  && tar -xzf go.tar.gz -C /usr/local \
  && export GOROOT="/usr/local/go" && export GOPATH=`pwd` \
  && $GOROOT/bin/go get github.com/mattn/goreman && $GOROOT/bin/go build -o /usr/local/bin/goreman github.com/mattn/goreman \
  && apt-get remove --purge --auto-remove git \
  && rm go.tar.gz && rm -rf $GOROOT && rm -rf $GOPATH/src && rm -rf $GOPATH/pkg \
  && unset GOROOT && unset GOPATH

# goreman setup
RUN echo "web: gosu aria /bin/busybox httpd -f -p 8080 -h /webui-aria2\nbackend: gosu aria /usr/bin/aria2c --conf-path=/home/aria/.aria2/aria2.conf /data/downloads/*.torrent" > Procfile

# aria2 downloads directory
VOLUME /data/downloads
# aria2 conf directory
VOLUME /home/aria/.aria2

# aria2 RPC port, map as-is or reconfigure webui
EXPOSE 6800/tcp

# webui static content web server, map wherever is convenient
EXPOSE 8080/tcp

CMD ["start"]
