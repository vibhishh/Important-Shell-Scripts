#!/bin/bash

SOURCE="/var/www/html"
BACKUP_DIR="/backup"
S3_BUCKET="s3://my-server-backup-bucket"
DATE=$(date +%Y-%m-%d_%H-%M-%S)

mkdir -p "$BACKUP_DIR"

BACKUP_FILE="$BACKUP_DIR/backup_$DATE.tar.gz"

echo "Creating backup..."

tar -czf "$BACKUP_FILE" "$SOURCE"

if [ $? -ne 0 ]; then
    echo "ERROR: Backup creation failed"
    exit 1
fi

echo "Backup created: $BACKUP_FILE"

echo "Uploading backup to S3..."

aws s3 cp "$BACKUP_FILE" "$S3_BUCKET/"

if [ $? -ne 0 ]; then
    echo "ERROR: S3 upload failed"
    exit 1
fi

echo "Backup uploaded successfully to S3"

# Delete local backups older than 7 days
find "$BACKUP_DIR" -type f -name "*.tar.gz" -mtime +7 -delete

echo "Old local backups cleaned."
echo "Backup completed successfully."
