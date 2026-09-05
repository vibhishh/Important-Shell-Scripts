#!/bin/bash

SOURCE="/var/www/html"
BACKUP_DIR="/backup"
DATE=$(date +%Y-%m-%d_%H-%M-%S)

mkdir -p "$BACKUP_DIR"

echo "Starting backup..."

tar -czf "$BACKUP_DIR/backup_$DATE.tar.gz" "$SOURCE"

if [ $? -eq 0 ]; then
    echo "Backup successful"
else
    echo "Backup failed"
    exit 1
fi

echo "Removing backups older than 7 days..."

find "$BACKUP_DIR" -type f -name "*.tar.gz" -mtime +7 -delete

echo "Backup process completed."
