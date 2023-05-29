FROM alpine:latest

WORKDIR /src

RUN apk add --no-cache \
    bash \
    sqlite \
    openssl \
    rclone

COPY entrypoint.sh ./
COPY includes.sh ./
COPY backup.sh ./
COPY restore.sh ./
RUN chmod +x ./*.sh

COPY rclone.conf /root/.config/rclone/rclone.conf

ENTRYPOINT ["./entrypoint.sh"]
