FROM java:8u111-jre

ENV VERISON=1.2.3

RUN wget -O /usr/local/src/v${VERISON}.tar.gz \
        https://github.com/smartloli/kafka-eagle-bin/archive/v${VERISON}.tar.gz \
    && tar -zvxf /usr/local/src/v${VERISON}.tar.gz -C /usr/local/src/ \
    && tar -zvxf /usr/local/src/kafka-eagle-bin-${VERISON}/kafka-eagle-web-${VERISON}-bin.tar.gz -C /usr/local/ \
    && rm -rf /usr/local/src/* 
ENV KAFKAEAGLE=/usr/local/kafka-eagle-web-${VERISON} \
    PATH=$KAFKAEAGLE/bin:$PATH