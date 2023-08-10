FROM python:3-alpine

ARG NOTIFY_PORT
ENV NOTIFY_PORT=5000

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

CMD waitress-serve --port=${NOTIFY_PORT} app:flask_app
