FROM mazzolino/restic:latest

RUN apk add --no-cache \
    sqlite \
    curl

COPY ./hooks /hooks
RUN chmod +x /hooks/*.sh

ENTRYPOINT ["/sbin/tini", "--", "/entrypoint"]
