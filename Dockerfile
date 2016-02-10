FROM blacklabelops/alpine
MAINTAINER Steffen Bleul <sbl@blacklabelops.com>

RUN apk add --update \
      curl \
      gpgme \
      postgresql && \
    # Install gosu
    wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/1.7/gosu-amd64" && \
    chmod +x /usr/local/bin/gosu && \
    # Remove obsolete packages
    apk del \
      curl \
      gpgme && \
    # Clean caches and tmps
    rm -rf /var/cache/apk/* && \
    rm -rf /tmp/* && \
    rm -rf /var/log/*

ENV LANG en_US.utf8
ENV PGDATA /var/lib/postgresql/data

COPY docker-entrypoint.sh /

VOLUME /var/lib/postgresql/data
EXPOSE 5432
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["postgres"]
