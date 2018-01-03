FROM splunk/universalforwarder:7.0.0

COPY sources.list /etc/apt/sources.list

RUN apt-get update \
    && apt-get install curl jq --no-install-recommends -y \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*
