FROM python:3-alpine

ARG NOTIFY_PORT
ARG NOTIFY_LOG_FILE
ARG NOTIFY_LOG_SIZE_BYTES
ARG NOTIFY_LOG_KEEP_NUM
ARG NOTIFY_APPRISE_CONFIG

ENV NOTIFY_PORT=${NOTIFY_PORT:-5000}
ENV NOTIFY_LOG_FILE=${NOTIFY_LOG_FILE:-'/var/log/notify/app.log'}
ENV NOTIFY_LOG_SIZE_BYTES=${NOTIFY_LOG_SIZE_BYTES:-5000}
ENV NOTIFY_LOG_KEEP_NUM=${NOTIFY_LOG_KEEP_NUM:-3}
ENV NOTIFY_APPRISE_CONFIG=${NOTIFY_APPRISE_CONFIG:-'/usr/src/app/.apprise'}

RUN apk add --no-cache \
    curl

RUN pip install --no-cache-dir \
    flask \
    apprise \
    waitress

WORKDIR /usr/src/app

COPY app.py .
COPY .apprise .

EXPOSE ${NOTIFY_PORT}

HEALTHCHECK --interval=60s \
    CMD curl --fail localhost:${NOTIFY_PORT}/alive || exit 1

CMD ["python3", "app.py"]
