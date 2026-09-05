#!/bin/bash

read -p "Enter namespace: " NAMESPACE
read -p "Enter deployment name: " DEPLOYMENT

echo "===== Rollout History ====="

kubectl rollout history deployment "$DEPLOYMENT" -n "$NAMESPACE"

echo
echo "Rolling back deployment..."

kubectl rollout undo deployment "$DEPLOYMENT" -n "$NAMESPACE"

if [ $? -eq 0 ]; then
    echo "Rollback successful"
    kubectl rollout status deployment "$DEPLOYMENT" -n "$NAMESPACE"
else
    echo "Rollback failed"
    exit 1
fi
