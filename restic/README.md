# Restic

This service is responsible for automatically backup to a remote location some important data.

## How it works

The service contains a container named `backup` that **every day** at **2:00AM** performs the backup of some specifyed data to a remote **google drive** folder.

The backup is performed by `restic` which creates incrementa backups with snapshots.

The backuped data is protected by a password and encrypted, moreover the data is not in plain text, but uses the `restic` folder/fiele structure.

## What data is backed up?

The data backed up is:

- bitwarden's `data` directory

## Docker Volumes

This service uses the following docker volumes:

- `restic_data` used to store the backup before uploading it
- `vaultwarden_data` (external) vaultwarden data

## Docker networks

This image uses the following networks:

- `notification` (external)

## .env

This service has some important environment variable already configured inside the `docker-compose.yml` file, but some secret are stored inside a `.env` file:

- `RESTIC_REPOSITORY` name of the remote repository to use
- `RESTIC_PASSWORD` password of the repository

## rclone

To store the data inside a personal Google Drive folder we use `rclone`. 
Rclone must be configured following [this steps](https://rclone.org/drive/) on a desktop machine to obtain a `rclone.conf` file that is then placed inside the `rclone` folder.

## Restore the backed up files

To restore all the backed up data we must use `restic` commands inside the running container.

```sh
# Find the latest snapshot for the current host
$ docker exec restic-backup restic snapshots

# Restore the given file on the host
$ docker exec restic-backup restic restore --target /path/to/restore/folder <ID>
```
