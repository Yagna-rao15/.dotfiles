#!/bin/bash
SOURCE_PATH="/home/yagna/Immich"
BACKUP_PATH="/run/media/yagna/7c49c171-357e-43f1-8cf7-4f68a0d0d452/Immich"

if [ ! -d "$SOURCE_PATH" ]; then
    echo "Error: Source directory $SOURCE_PATH does not exist"
    exit 1
fi

if ! mountpoint -q "/run/media/yagna/7c49c171-357e-43f1-8cf7-4f68a0d0d452/"; then
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
notify-send "Backup completed" "Your files have been backed up to the SSD."
