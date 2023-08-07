FROM mazzolino/restic:latest

RUN apk add --no-cache sqlite

COPY ./hooks /hooks

ENTRYPOINT ["/sbin/tini", "--", "/entrypoint"]
