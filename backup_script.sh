#!/bin/bash

SOURCE="/home/mradul/shell_practice"
BACKUP_DIR="/home/mradul/backup"
DATE=$(date +%Y-%m-%d_%H-%M-%S)

mkdir -p "$BACKUP_DIR"

tar -czf "$BACKUP_DIR/backup_$DATE.tar.gz" "$SOURCE"

if [ $? -eq 0 ]; then
    echo "Backup successful: backup_$DATE.tar.gz"
else
    echo "Backup failed!"
    exit 1
fi
