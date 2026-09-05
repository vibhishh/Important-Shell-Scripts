#!/bin/bash

BACKUP_DIR="./k8s-backup"
DATE=$(date +%Y-%m-%d_%H-%M-%S)

mkdir -p "$BACKUP_DIR/$DATE"

echo "Creating Kubernetes backup..."

kubectl get all -A -o yaml \
    > "$BACKUP_DIR/$DATE/all-resources.yaml"

kubectl get configmaps -A -o yaml \
    > "$BACKUP_DIR/$DATE/configmaps.yaml"

kubectl get secrets -A -o yaml \
    > "$BACKUP_DIR/$DATE/secrets.yaml"

kubectl get pvc -A -o yaml \
    > "$BACKUP_DIR/$DATE/pvc.yaml"

kubectl get pv -A -o yaml \
    > "$BACKUP_DIR/$DATE/pv.yaml"

tar -czf "$BACKUP_DIR/k8s-backup-$DATE.tar.gz" \
    -C "$BACKUP_DIR" "$DATE"

rm -rf "$BACKUP_DIR/$DATE"

echo "Backup created:"
echo "$BACKUP_DIR/k8s-backup-$DATE.tar.gz"
