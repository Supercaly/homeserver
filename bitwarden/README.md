# Bitwarden self-host

This service contains images responsibe of managing the self-hosted instance of [Bitwarden](https://bitwarden.com/).
The main Bitwarden service is achived through the unofficial implementation called [vaultwarden](https://github.com/dani-garcia/vaultwarden).
Alternatively, an image is responsible of automatically backup all user data daily and restoring it in caso of failure.

## vaultwarden/.env

To configure the vaultwarden image a `vaultwarden/.env` file is used
 
- `DOMAIN` domain name with pull path
- `WEBSOCKET_ENABLED` enable web socket for push notification on web apps
- `ADMIN_TOKEN` token used for accessing the admin panel
- `SIGNUPS_ALLOWED` allow new user to register without invitation (disabled)
- `INVITATIONS_ALLOWED` allow users to invite new users (disbled)
- `LOG_FILE` file to use as log
- `LOG_LEVEL` log level

## vwbackup

This image is responsible of creating backups of all the important files needed by vaultwarden. The backup process is configured by cronjob to run once a day.
This image uses [rclone](https://rclone.org/) to sync the local backup folder with a remote one stored on google drive.

### vwbackup/.env

To configure this image a `vwbackup/.env` file is used

- `BACKUP_ENCRYPTION_KEY` backup encription key
- `CRON_TIME` cronjob time at which schedule the backup
- `RCLONE_REMOTE` remote origin to use for rclone
- `RCLONE_BACKUP_FOLDER` path to the remote backup folder

### vwbackup/rclone.conf

To configure rclone remote this image uses `vwbackup/rclone.conf` file. In particular the google drive remote is configured initially on another machine with browser support, in order to generate the `remote.conf`` file, and then it is copyed in here.
For more information follow [this guide](https://rclone.org/drive/).

## Docker Volumes

This service creates the following docker volumes:

- `vw_data` used to store vaultwarden data
- `vw_backup` used to store vaultwarden backups

## Docker Networks

The vaultwarden image needs some [docker networks](https://docs.docker.com/network/) to properly work:

- `caddy`

Those networks need to be created manually before using this image. 
To create them use this command for each network as seen [here](https://docs.docker.com/engine/reference/commandline/network_create/#description)

```console
$ docker network create -d bridge name
```

More info on compose networks can be found [here](https://docs.docker.com/compose/networking/#specify-custom-networks).
