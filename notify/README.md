# Notify

This stack listens for critical and error messages from other containers and sends immediate notifications via 

- SMTP (Gmail)
- Telegram

The stack sends notifications using [Apprise](https://github.com/caronc/apprise).

## Format of the request

To send a notification a service located in a different container needs to perform a `POST` request to the `/` route of the server passing the following `json` data:

```json
{
    "title": "some title",
    "body": "some body"
}
```

A popular way of sending this message is using `curl`:

```bash
$ curl -X POST \
    -H "Content-Type: application/json" \
    -d "{\"title\":\"some title\", \"body\": \"some body\"}" \
    http://addr:port/
```

## .apprise

To configure the apprise endpoints we use a configuration file named `.apprise`. 
Read the official [documentation](https://github.com/caronc/apprise/wiki/config) to properly configure it.

## Docker Networks

This stack uses this docker networks:

- `notify_default` (internal)
