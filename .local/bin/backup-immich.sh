#!/bin/bash
DOCKER_VOLUME_PATH="/home/yagna/Immich/"
BACKUP_PATH="/mnt/backup-ssd/Immich"

# Create BTRFS snapshot
btrfs subvolume snapshot -r "$DOCKER_VOLUME_PATH" "$DOCKER_VOLUME_PATH.snapshot"

# Sync to external drive
rsync -av --delete \
    "$DOCKER_VOLUME_PATH.snapshot/" \
    "$BACKUP_PATH/"

# Clean up snapshot
btrfs subvolume delete "$DOCKER_VOLUME_PATH.snapshot"
