#!/bin/bash

read -p "Enter namespace: " NAMESPACE
read -p "Enter deployment name: " DEPLOYMENT
read -p "Enter replica count: " REPLICAS

kubectl scale deployment "$DEPLOYMENT" \
    --replicas="$REPLICAS" \
    -n "$NAMESPACE"

if [ $? -eq 0 ]; then
    echo "Deployment scaled to $REPLICAS replicas"
else
    echo "ERROR: Scaling failed"
    exit 1
fi
