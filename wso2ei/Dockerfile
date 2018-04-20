FROM ubuntu:16.04
MAINTAINER "Xiao Mo" <root@xiaomo.red>

RUN apt-get update \
    && apt-get install curl unzip wget -y \
    && wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u141-b15/336fa29ff2bb4ef291e347e091f7f4a7/jdk-8u141-linux-x64.tar.gz" -O /usr/local/src/jdk-8u141-linux-x64.tar.gz \
    && tar -zxf /usr/local/src/jdk-8u141-linux-x64.tar.gz -C /usr/local/ \
    && mv /usr/local/jdk1.8.0_141 /usr/local/java \
    && rm -f /usr/local/src/jdk-8u141-linux-x64.tar.gz \
    && apt-get remove axel -y \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/usr/local/java \
    JRE_HOME=/usr/local/java/jre \
    CLASS_PATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib \
    PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin

WORKDIR /opt

ARG EI_VERSION=6.1.1
ARG PRODUCT_NAME=wso2ei
ARG ZIP_URL=https://product-dist.wso2.com/products/enterprise-integrator/$EI_VERSION/$PRODUCT_NAME-$EI_VERSION.zip
RUN apt-get update \
    && apt-get install curl unzip -y \
    && curl -LOk -A "testuser" -e "http://connect.wso2.com/wso2/getform/reg/new_product_download" $ZIP_URL \
    && unzip -qq $PRODUCT_NAME-$EI_VERSION.zip; \
    && mv $PRODUCT_NAME-$EI_VERSION $PRODUCT_NAME; \
    && rm -f $PRODUCT_NAME/bin/*.bat; \
    && rm -f wso2*.zip

ENV CARBON_HOME /opt/$PRODUCT_NAME
ENV PATH $PATH:$CARBON_HOME/bin:$JAVA_HOME/bin

WORKDIR /

# /opt/wso2ei/repository/deployment/server
# /opt/wso2ei/dbscripts

EXPOSE 8280 8243 9443

ENTRYPOINT ["integrator.sh"]
