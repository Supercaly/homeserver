# Notify

This service listens to HTTP POST requests with a message that needs to be sent to various notification systems, like:

- SMTP
- Telegram

To do so this image uses Apprise.

## Format of the request

To send a notification a service needs to perform a `POST` request to the `/` route of the server passing the following `json` data:

```json
{
    "title": "some title",
    "body": "some body"
}
```

A popular way of sending this message is through `curl` like so:

```bash
$ curl -X POST \
    -H "Content-Type: application/json" \
    -d "{\"title\":\"some title\", \"body\": \"some body\"}" \
    http://addr:port/
```

## .apprise

To configure the apprise endpoints we use a configuration file named `.apprise`. 
To properly configure this file read [this](https://github.com/caronc/apprise/wiki/config).

## Docker Networks

This image uses some docker networks:

- `notification` (external)
