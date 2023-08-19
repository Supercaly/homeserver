# Restic

This stack provides [Restic](https://restic.net/), a backup tool that can automatically backup important data to a remote location.

## How it works

The Restic service performs a backup of some specifyed data **every day** at **2:00AM** and copy it to a remote **google drive** folder.

Restic is performing incremental backups with snapshots in order to consume as less memory as possible.

The backd up data is encrypted and password protected, moreover the data is not in plain text, but uses the restic folder/file structure.

## What data is backed up?

Restic backs up this data:

- bitwarden's `data` directory

## Docker Volumes

This stack uses this docker volumes:

- `data` store the backup before uploading it
- `vaultwarden_data` (external) vaultwarden data

## Docker Networks

This stack uses this docker networks:

- `notify_default` (external)

## .env

This stack uses some secret environment variables stored inside a `.env` file:

- `RESTIC_REPOSITORY` name of the remote repository to use
- `RESTIC_PASSWORD` password of the repository

## rclone

To store the data inside a personal **Google Drive** folder we use [RClone](https://rclone.org/). 
Rclone must be configured following [this steps](https://rclone.org/drive/) on a desktop machine to obtain a `rclone.conf` file that is then placed inside the `rclone` folder.

## Restore the backed up files

To restore all the backed up data we must use `restic` commands inside the running container.

```sh
# Find the latest snapshot for the current host
$ docker exec restic-backup restic snapshots

# Restore the given file on the host
$ docker exec restic-backup restic restore --target /path/to/restore/folder <ID>
```
