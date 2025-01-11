#!/bin/bash
SOURCE_PATH="/home/yagna/Immich"
BACKUP_PATH="/mnt/backup-ssd/Immich"

if [ ! -d "$SOURCE_PATH" ]; then
    echo "Error: Source directory $SOURCE_PATH does not exist"
    exit 1
fi

if ! mountpoint -q "/mnt/backup-ssd"; then
    echo "Error: Backup drive is not mounted"
    exit 1
fi

if [ ! -d "$BACKUP_PATH" ]; then
    sudo mkdir -p "$BACKUP_PATH"
fi

echo "Starting backup..."
sudo rsync -av --progress \
    "$SOURCE_PATH/" \
    "$BACKUP_PATH/"

echo "Backup completed"
