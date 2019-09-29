FROM idoop/docker-apollo:latest

COPY docker-entrypoint /usr/local/bin/docker-entrypoint
COPY healthcheck /usr/local/bin/healthcheck

RUN chmod +x /usr/local/bin/docker-entrypoint && chmod +x /usr/local/bin/healthcheck

ENTRYPOINT ["docker-entrypoint"]
