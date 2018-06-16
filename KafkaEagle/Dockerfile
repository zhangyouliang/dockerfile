FROM daocloud.io/buxiaomo/maven:latest as builder

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre \
    CLASSPATH=$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar \
    PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin

RUN git clone https://github.com/smartloli/kafka-eagle.git /usr/local/src/kafka-eagle \
    && cd /usr/local/src/kafka-eagle \
    && ./build.sh

# FROM java:8u111-jre
# COPY --from=builder /app/jarfile/
# CMD ["./app"]