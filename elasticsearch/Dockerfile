ARG VERSION=7.7.0
FROM elasticsearch:${VERSION}

WORKDIR /usr/share/elasticsearch

RUN ./bin/elasticsearch-plugin install https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v${VERSION}/elasticsearch-analysis-ik-${VERSION}.zip