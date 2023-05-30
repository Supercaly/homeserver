FROM alpine:latest

WORKDIR /src

# install dependencies
RUN apk add --no-cache \
    bash \
    sqlite \
    openssl \
    rclone

# copy sources
COPY entrypoint.sh ./
COPY includes.sh ./
COPY backup.sh ./
COPY restore.sh ./
RUN chmod +x ./*.sh

# copy rclone config
COPY rclone.conf /root/.config/rclone/rclone.conf

ENTRYPOINT ["/src/entrypoint.sh"]
